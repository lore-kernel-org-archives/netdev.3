Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65253A0EB8;
	Mon,  7 Sep 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765801; cv=none; b=V1A2gWlToSrNUjZVQ4k+wBBlasmzsuuT2dayErmr2Afwgr54nhFx1oT+2DDbqm3NTbrPvwjxSWaqPk4zyIuLwRm34Fpky2QRv4PHzjSwVKnUaj8L/FoLrfnrBjhqJikzMa2WUuvMmA+pRNxmh/d4Yi5gzBhpsO5Q4vDHVkPYHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765801; c=relaxed/simple;
	bh=/P7Sbk9Hs/wN9ZAoCTA0T2/6ZF8YyfqUeL7d9fV4Jc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDSepcdDJ/sKKXIXSvOph6m1F3KLRRnQFXIQR6QWfmTp2E6DQ4OCa4FD4V9O7SnVcU4TRKQU4Cp2FDMSbcc48irLB8AooVenKnES6G1HK1oXnR440b5EygK3a/e8iwrj+vB7IH9o9P5+Ex1+YsZLHj5H5uXXFqMBqluFePtH1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6B5kDkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6B5kDkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF4D1F00A3A;
	Mon,  7 Sep 2026 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788765800;
	bh=c21lYurPKYfdmT2lcEuR4ohmdUaS0V1VthtHZ4DLJoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l6B5kDklYqET19u+BTusL2gjnI9VJ6LwlBC+lz2Q33vYYPhStdESELOeX/xvcg+8R
	 Q5MvlxKLhn4DTmoZ4OxMOj1u84dFahqcY8T0r1oslzPOanAXkaigHpEYo46QP+0L8z
	 T5S9OeZ2B21iD49yClBUNyw43se48zdJe+hIuqUzf118AmPfrbJbV55mPHFrhSGfye
	 4+S6fSYMWLFiiB4BP6K0vaP8AQHVW3oW2S1P+8qvwQukbEtuNfiTJST93n8DHvouI3
	 W8ri+wAv/Nwvqg2+W0wmA5UidNwMb4E08lKN/as0Q/+4wJywCY72YEdvA2Jvt0ottb
	 yEI7v2qH10KDA==
Date: Mon, 7 Sep 2026 10:23:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <20260907072315.GG13683@unreal>
References: <20260907042827.4077114-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907042827.4077114-1-rkannoth@marvell.com>

On Mon, Sep 07, 2026 at 09:58:27AM +0530, Ratheesh Kannoth wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> otx2_get_link_ksettings() already fills speed, duplex, autoneg, link
> modes and FEC from CGX firmware data, but leaves cmd->base.port unset.
> As a result, ethtool does not show the physical connector type even
> though the firmware provides it in fwdata.port.
> 
> Populate cmd->base.port from rsp->fwdata.port so users can see values
> such as PORT_TP or PORT_AUI via ethtool.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v1 -> v2: Addressed sashiko comments.
> 	https://lore.kernel.org/netdev/20260904154833.3b32ea6a@kernel.org/
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 9bee1b91eeaa..9b4c151b4d7d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -1231,6 +1231,8 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
>  				OTX2_MODE_SUPPORTED, cmd);
>  	otx2_get_fec_info(rsp->fwdata.supported_fec,
>  			  OTX2_MODE_SUPPORTED, cmd);
> +
> +	cmd->base.port = (u8)rsp->fwdata.port;

You should declare identical fields with the same type and avoid silently
casting variables.

Thanks

>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 
> 
