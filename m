Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF272F745D;
	Wed, 24 Jun 2026 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316866; cv=none; b=Fj51Sbonq1zhRh2+zxpiriLLbxCUlEp5M0CZk6mqX9Qj07MwD0aL0bQTAiDzbw3g3Yvwnpiiv5WQ4k86ZLJbv34aMa3HiVNTopOZQqCeY/JbqhNXet9bV1kr89kziOIK5V2+ImgTZhwa3ycr5CPLwF31vVxAmR0rpcQTXMA9pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316866; c=relaxed/simple;
	bh=McnGAaBHFGShwJ7DCU4bcpI0bt8t4BNhuDOjfMVD+kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYaFdjGWWehI8a0j1KIW4xqx5KLs5ZKQeUApbXwQJ+t1H4gFwxMMk9HI/7bYDLaOJvZDn/ysUMBDKdwW1XUSb6zWQJCFtrvIoxukb2/S749hlKbB34K+iYYBksoq+PFnQXnFrRIe6ytapgwKUOj4LBpMGl8ZEKKw1jstxv8CxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZUc4z5ZX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZUc4z5ZX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kOrKWDaB0ZFkgmsKOd1YksUh3/RLEW4Ywg0Vwyt3LTQ=; b=ZUc4z5ZXtx1jvccJBmBq3UZOb1
	WbhuofMPjZd5cEDAwo7pqeCRVSZwhzokghQXuizOfCMoyADHgEcluAdE4rZS0RTFXtMrs5vFOXDFE
	/W1i798WxkuTbfSktXxznpIynENGmvaNs0eIIwnl8QBBhL8bw1ujfJqo1dcDdHEu0Rjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcQ1r-00974o-MQ; Wed, 24 Jun 2026 18:00:43 +0200
Date: Wed, 24 Jun 2026 18:00:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jackbb_wu@compal.com
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
	Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
	Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/7] net: wwan: t9xx: Add control plane transaction
 layer
Message-ID: <2a90ae6b-2b6d-4340-b557-915252cc3488@lunn.ch>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-2-73ff03f60c48@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-t9xx_driver_v1-v3-2-73ff03f60c48@compal.com>

> +static int __init mtk_common_drv_init(void)
> +{
> +	return 0;
> +}
> +module_init(mtk_common_drv_init);
> +
> +static void __exit mtk_common_drv_exit(void)
> +{
> +}
> +module_exit(mtk_common_drv_exit);

Since these don't do anything, they should not be needed.

> @@ -467,6 +468,7 @@ static u32 mtk_pci_ext_h2d_evt_hw_bits(u32 chs)
>  
>  	SET_HW_BITS(hw_bits, chs, MHCCIF_RC2EP_EVT_DEVICE_RESET,
>  		    DEV_EVT_H2D_DEVICE_RESET);
> +
>  	return LE32_TO_U32(cpu_to_le32(hw_bits));

Please don't add white space like this. I assume a previous patch
added this code, so move this to that patch.

> @@ -908,13 +910,11 @@ static int mtk_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct mtk_md_dev *mdev;
>  	int ret;
>  
> -	mdev = devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
> +	mdev = mtk_dev_alloc(dev, &pci_hw_ops);
>  	if (!mdev) {
>  		ret = -ENOMEM;
>  		goto log_err;
>  	}
> -	mdev->dev_ops = &pci_hw_ops;
> -	mdev->dev = dev;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv) {
> @@ -991,7 +991,7 @@ static int mtk_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  free_priv_data:
>  	devm_kfree(dev, priv);
>  free_cntx_data:
> -	devm_kfree(dev, mdev);
> +	mtk_dev_free(mdev);

Why are you removing devm_ calls?

	Andrew
