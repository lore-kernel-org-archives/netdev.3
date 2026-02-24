Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BFF3A9629;
	Tue, 24 Feb 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953192; cv=none; b=anHCxTazdBo69rYZsX4q3z9+z5gjMYjq4taq2oszso7JpKswaxvUS5RL7sGuKvXRhCBnDY+R/TE6qUCJUrPXLn5yZcebWvCwxBBsHGwwaR97ehAfo1uBHeHBKA3bScdequHYbvdpa+TXbljYg0FDDIooVpIbW57CYs5Ww9CMXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953192; c=relaxed/simple;
	bh=Bh0vMs/UoAW2yNPLuqgfJHTBII6cu61y5+RNft69p7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGU7UV+lHgFwHZtwIsXTrjZU6GKT2n0D9i3v6bOAh5WD6LJeOQ2jVdAwA7LP+k7vTrwLOgx+HBN/k2VpgYbrgAGLXelEVTKPHcVqD/Q6nfWDcBFK9OtcD3y5hq3q415yg/TUag4BNdDgOayK6oMRD5qU06LkbDcr4tREJf1ZyY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcpSCJpf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcpSCJpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDA9C19423;
	Tue, 24 Feb 2026 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771953192;
	bh=Bh0vMs/UoAW2yNPLuqgfJHTBII6cu61y5+RNft69p7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcpSCJpfPcTtdXL4ikvaXuDBKwShC31gIYz3XKU3Z0Wcf0p1oqGZLm1WyMfnD5KwL
	 2vu3JNwNZennOMmgkoly+ACUzh46Q3qQXNZl+HlrjitsI4HdLZEHQBKa+iL9k+BamD
	 pcphOTQYXxIHvWClPifBObu9NiJlNlaxLDLlgl+BURzcsqqQNcbXpFok0kIS2gph66
	 futP61kyTVKxRs1x1ooH9WL0trLf7gGSbwqXP/90ZmAkahMVWmeIwfRPLGAUo24+7A
	 +z+0OO8Q2nuN4DQLOeUOFx5AA8g01MBt/8aeCv4l8RLVFjoJ0IKwQ8t5qQ/dqSSJiM
	 No3Fpap6iiS5w==
Date: Tue, 24 Feb 2026 17:13:08 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next] net: freescale: ucc_geth: call of_node_put once
Message-ID: <aZ3cJI86dknRg_mk@horms.kernel.org>
References: <20260224014141.352642-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224014141.352642-1-rosenp@gmail.com>

+ Maxime


On Mon, Feb 23, 2026 at 05:41:41PM -0800, Rosen Penev wrote:
> Move it up to avoid placing it in both the error and success paths.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/freescale/ucc_geth.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index 78d72409b6e0..4d598693d7a6 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -3470,14 +3470,13 @@ static int ucc_geth_probe(struct platform_device* ofdev)
>  	phy_node = of_parse_phandle(np, "phy-handle", 0);
>  	if (phy_node) {
>  		prop = of_get_property(phy_node, "interface", NULL);
> +		of_node_put(phy_node);
>  		if (prop) {
>  			dev_err(&ofdev->dev,
>  				"Device-tree property 'interface' is no longer supported. Please use 'phy-connection-type' instead.");
> -			of_node_put(phy_node);
>  			err = -EINVAL;
>  			goto err_put_tbi;
>  		}
> -		of_node_put(phy_node);
>  	}
> 
>  	err = of_get_phy_mode(np, &phy_interface);
> --
> 2.53.0
> 
> 
