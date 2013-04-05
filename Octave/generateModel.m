function [model] = generateModel(features, nCentroids)

    centroids = kmeansfast(features, nCentroids);

    model = centroids - (ones(nCentroids,1) * mean(centroids));

return