Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D19425CF7
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555168; cv=none; b=L15BsbPp1kELZLXbbgKZUxlBwFuFFipkN6FXMrfux0jIiaAQ64pP4KapiMJw7mr8Pf/7tJIh3XNK/wj6nCNT2ul0Uo1OiBxPJm69BEUvny7nQxCdDhVyBw+Iae8b28WrcXS5t3fOO3FjE+IfBh7mLftBYJ6SwO/QLGoq8N5qjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555168; c=relaxed/simple;
	bh=uXaikVFR1mtKR6RmfSvw2mwrSxVg6nZ6Dfz59NmUYms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQHpeL6Sq3MPiTseoudqFBew/7+JOzStuXy69Wh3oqXrS5V1Peg59q13OsqRwcHxdoxSf+hW6UtJ/KkHQhUJbdwBTvR7zRpkPSXPnsnlyx9rQCTaaKz66hyqw8ZuUBgkV/oEP95HfupcvAVT6uKiml+Ufx3heQhLVV7zrMzd9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Z6+Wmedx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Z6+Wmedx"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8486ac3f347so3071608b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784555165; x=1785159965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CiqM6HQnEYGFM1tqwPiFklMvqyJPy7ipNoK3CEVhAc8=;
        b=Z6+WmedxIu4Gud36zEwVdxlnkDSgmdIGPOAl/o3Fa91zagwpsD0fO//uiHqHZgj8y5
         AOftPCn26dHaJG0WMwJ9F584mK6sWrva1O7/3ksJKz1ERBxhBe2j+KgwLiQjchlub4Cp
         NWzZlON8P0ZkQAefwJt12K+fWQMYNAcJUM3xXlFmLZYo7EwRaxxaIfZTADY5r01LSHKz
         TnCVEVul77j5wMa+r/QPW0vtKVuufi37+tFrVrCMhi5ubAdU8BzVGP9PUui0zaa5zZaU
         sRrFNiSXOVsEjatQiX0TZczTwVq3iOmLnGj4/5ve2qAPAjQltWotqvaDr6hKqWbieYp/
         y4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555165; x=1785159965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CiqM6HQnEYGFM1tqwPiFklMvqyJPy7ipNoK3CEVhAc8=;
        b=nkTaU9+BQ05RqVtnskUSfcHqffTxExml/TTc5OOtevWuYZwHc7m8tszHBI5VFNpixu
         SDZ2c459R5bwtn+okEodq8IL+Uz12YFIfXUGHYeehwuaM33Eb6n7nQkkF2hOsV9vt1CX
         eL5JyVGLra5G/JgCXBgESFYl02OA984ecMc/7anjTURtxbaKUslNYMCaKnW3g2dKOHfz
         qK3riJKNNalepOnWGQcAQ5oIkBCm12XqLJpLFyoFAX/2JuRrDgvh/biYa1TZwPYKY6Ij
         nxqN4o4eotGbVmvSPsQS+ADNcDchlDbDA25i2ggMnZHF2NjFgQ90aD1hhuV4SjxQ1sAG
         Q1hw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7zCkicULqIuQ1o7NaEXwWKo1HfZ69vkzP0yYdOzsdGe1XG1mcJDP5PYODi9JhD5CMYTRySpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqpaLQPOaxSDSlCiBytg+3awz3y/60+BlOuMCt9SZNeMxNH2T9
	E7pD4XPrxFG/HgiGpbD41Dl4NhLe7I7OICBfqxusU8GppuATn/J3RMPuDGA2OFEYgTA=
X-Gm-Gg: AfdE7cku23pZ/6JUHD0cYxuL/UmcahDTi6A1U+WpSWTlwE6JRVrtlVmr4wTgQYrIZjG
	2ABsSN0g9wxiP1gf4jBFOCHJutoSFA220HvNpsucOypWjdAILgjFEI3gfq61x1LbkxQf/JEdEWa
	IjGC8ITBTQvftIT5vlge4NhBZmeJsZdyieT5be+uQtbxW0DZySF+NErbGkOzuSORbTrzp6+dqhC
	SNi0UoolPOE2uaW562/oXGPAvhqrN8vVJWM1guQ7sK7lqD+uZZPg6QF8BnKmCan3CRwmPowDS0R
	gxDnG74IdTSKNfeE52q/KlPbubJGRKMQls3y/e59eqQOx5cOffWZNR6onTudWYnjNcEb36SUszt
	Xk0aQlx1F+PofmSOEx5kiAWQUS3qZKSsJ3MVNRtHUzrfGNdQtQTcc3UG//dXA6QCKYhRVwQ==
X-Received: by 2002:a05:6a00:1390:b0:848:2f58:e1e9 with SMTP id d2e1a72fcca58-84beb54b717mr19266604b3a.36.1784555165506;
        Mon, 20 Jul 2026 06:46:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2e68e7b8sm5439737b3a.35.2026.07.20.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:46:04 -0700 (PDT)
Date: Mon, 20 Jul 2026 06:46:04 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 05/14] net: enetc: use PCI device name
 for debugfs directory
Message-ID: <al4mnM58+65TQnfI@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-6-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-6-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:07AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> enetc_create_debugfs() is called right after register_netdev(), at which
> point ndev->name still holds the format "eth%d" (e.g., eth0) rather than
> the final assigned name (e.g., via udev rules).
> 
> Use pci_name() instead of netdev_name() to name the debugfs directory.
> The PCI device name is unique, stable, and available from the start,
> making it a more reliable identifier for the debugfs entry. Therefore,
> the observable debugfs path from something like
> /sys/kernel/debug/eth0/mac_filter to a PCI BDF-style path such as
> /sys/kernel/debug/0002:00:00.0/mac_filter.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> index 4a769d9e5679..be378bf8f74d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> @@ -81,10 +81,9 @@ DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
>  
>  void enetc_create_debugfs(struct enetc_si *si)
>  {
> -	struct net_device *ndev = si->ndev;
>  	struct dentry *root;
>  
> -	root = debugfs_create_dir(netdev_name(ndev), NULL);
> +	root = debugfs_create_dir(pci_name(si->pdev), NULL);
>  	if (IS_ERR(root))
>  		return;
>  

Reviewed-by: Joe Damato <joe@dama.to>
