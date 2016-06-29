function [clusters] = kMeanLimit( dataSet, showInfo, showPlot )
%KMEANLIMIT Clustering of sequence data into fast and slow responses
%   kmeans Clustering as used in:
%   Song, S., & Cohen, L. (2014). Impact of conscious intent on chunking during motor learning. 
%   Learning & Memory (Cold Spring Harbor, N.Y.), 21(9), 449-51. doi:10.1101/lm.035824.114

colorRed = [ 0.7, 0.3, 0.2 ];
colorBlue = [ 0.2, 0.3, 0.7 ];
meanDataset = mean( dataSet );
sdDataSet   = std( dataSet );

for l = 1 : length( dataSet )
  if dataSet > meanDataset+2*sdDataSet % checks if value is above 2 SD
    if showInfo
      disp( ['Value altered at j = ', num2str( l )] ); % info if above happened
    end
    dataSet(l) = meanDataset+2*sdDataSet;
  end
end
[clusters, centroidLocations, ~, ~] = kmeans( dataSet, 2, 'EmptyAction', 'drop' );
% it is random wether the first cluster is smaller or greater than the second one, so I make sure it
% always stays the same way

  clusters(clusters == 1) = centroidLocations(1) > centroidLocations(2);
  clusters(clusters == 2) = centroidLocations(2) > centroidLocations(1);

if showPlot
  figure
  hold on
  plot( dataSet, 's-','color', colorBlue, 'MarkerFaceColor', colorBlue )
  plot( clusters, 'v-', 'color', colorRed, 'MarkerFaceColor', colorRed )
  xlabel( 'Element' )
  ylabel( 'Time' )
  yMaxInData = max( dataSet );
  margin = 1.1;
  yUpperLimit = yMaxInData * margin;
  axis( [1, length( dataSet ), 0, yUpperLimit] )
end
end

