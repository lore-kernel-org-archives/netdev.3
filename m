Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE1346E47;
	Fri,  8 May 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231172; cv=none; b=jU76JSgInvbUS37rstXoKCRzKgxcsP/vFoo+AeU6BeNJoR5kxWHXPkfiaewybIZmBCDKVvmpepNCmPqCt1jgN5IZrtbvH0aru4YURPov/bhiLWBV0eBN/dc4KMSsqcfE5Z4Iq3MbXhcKd/avvzcsDEVbs4JTw484BeY4TGrvbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231172; c=relaxed/simple;
	bh=Y8lQ88XYvx4hx8ENZ4lXSLd9wquiqv7sWk8FhPH2ZwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWA79JPYOWNIU4SPG++sG5Y5x6UNNNGyy0JhIIzgb3nPIaadcpLLKfQABJp+k71OtFjnyB1bBHMGk7tV79QokNGRLinpMqE24kVg6sG24GIQme81HoNxMXEZRbbniN1yIq9dp5JhnjKAE/QK+BXSFhyUVm2oSOr/1TTas4mKQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCqtA0T2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCqtA0T2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC6DC2BCB0;
	Fri,  8 May 2026 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231172;
	bh=Y8lQ88XYvx4hx8ENZ4lXSLd9wquiqv7sWk8FhPH2ZwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCqtA0T2f3VYdI5v21HBLMqzYcBfz+7CJX0P1bb4p3tUbOGvBUh0gM1i+pjc49bF1
	 8fZ/FjIursXrZpc06WQjhopoPEEDZ/wdrjaP+5O9yujlfAJ3PQgRoH+pJqKTBeeVKv
	 7F6eVphtCL2oEjYXI8zvRZ7RdepQ9M8EWC82UIHfOieNmrux6IDkjB5MsQ6LbyIu55
	 ENXJ03qpsIwwwWH8TKBomN5GvJFWnw+jA3mX1KNh3x2aB1PkwseG+LR6atUDojGUEO
	 alU6PkufkEY0t1lUs1QVgqGdq0oE7qR6KyE6hwXVfOtxUs2Dn7lXcK0C5cWhWU96uN
	 kr9Hd2KJCiF8A==
Date: Fri, 8 May 2026 10:06:07 +0100
From: Simon Horman <horms@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/mlx5e: Fix PTP TX SQ cleanup on metadata DB
 failure
Message-ID: <20260508090607.GL15617@horms.kernel.org>
References: <20260504223018.49556-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504223018.49556-1-prathameshdeshpande7@gmail.com>

On Mon, May 04, 2026 at 11:30:05PM +0100, Prathamesh Deshpande wrote:
> mlx5e_ptp_open_txqsq() creates the hardware SQ before allocating the PTP
> traffic metadata database.
> 
> If mlx5e_ptp_alloc_traffic_db() fails, the error path frees the software
> TX queue state but skips destroying the already-created hardware SQ.
> 
> Add a dedicated unwind label that destroys the SQ before freeing the TXQ
> state.
> 
> Fixes: 1880bc4e4a96 ("net/mlx5e: Add TX port timestamp support")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

