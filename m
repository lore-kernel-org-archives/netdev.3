Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477613777E;
	Tue, 16 Jun 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639398; cv=none; b=lfPa9KtxAhAoUdRKh4nqLmlW7xIu8LRYH8o6gkY3EXAz0wofbRIqYizQJnS0E5Eo2qgGjM67lI8bqVb1uuvWzhH1Bsz6aXBEo17nda6CY8il8LxLpHOEoCCnswUbdO9nYMjTdopk6sXds/aytuuIGwpVdKUI87iwKfOwOPRTy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639398; c=relaxed/simple;
	bh=lbYdePnu2vp6L9DLzQ8Qy4dIGkO4CaI6L5VlAH7bSpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyJPcUrKjH0RUHdxP/xSb/hxuWJS+4DVhxmqGar98IvPXk2Fg0id6Ys1HTAi8YNrK3kS4KdVOePeNnUH59VwRsT/BAmNtzCWh/1fwhWUln68eyglFMDH0bztDAIFJP9ZT26QtxiAz9WBS9A0phn4KIzgBfo1afE+Hb9rL8Bj5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wSsNulhG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wSsNulhG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eab7LTBnJKSi89rfuqrUuKK2Wu3DeKyLU4H+uT36IvU=; b=wSsNulhGk4ZPFiKv82MNsn5vNo
	TFvN52r8k8EWkp6uAik31+f/RdFLPGBSot9+fSwvlOdhzNCKxULPPQYdw2wpA0/4i27vrQ9wL6iS5
	r7Tv6uuLnzRpQGi+ZTnWaYp9cU7bGHLNoS+DsYAcvTIwBmWs4n3/kmQ8/K00hBTwGgDg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZZnB-0081aI-V4; Tue, 16 Jun 2026 21:49:49 +0200
Date: Tue, 16 Jun 2026 21:49:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v6 2/2] dinghai: add hardware register access
 and PCI? capability scanning
Message-ID: <ea19f9f8-2004-47d2-8497-a5b608072e36@lunn.ch>
References: <20260616212106742_trNLb7r-FL04eDlJO8tT@zte.com.cn>
 <20260616213550502kLzSZF2DiQyd9Dl0Dv0Gz@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616213550502kLzSZF2DiQyd9Dl0Dv0Gz@zte.com.cn>

> +int zxdh_pf_common_cfg_init(struct dh_core_dev *dh_dev)
> +{
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +	struct pci_dev *pdev = dh_dev->pdev;
> +	int common;
> +
> +	/* check for a common config: if not, use legacy mode (bar 0). */
> +	common = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_COMMON_CFG,
> +					     IORESOURCE_IO | IORESOURCE_MEM,
> +					     &pf_dev->modern_bars);
> +	if (common == 0) {
> +		dev_err(dh_dev->device,
> +			"missing capabilities %i, leaving for legacy driver\n",
> +			common);

That looks double odd. Normally you would use !common. Also, you know
common is 0, so why use "%i", when it could be just '0'.

> +int zxdh_pf_notify_cfg_init(struct dh_core_dev *dh_dev)
> +{
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +	struct pci_dev *pdev = dh_dev->pdev;
> +	u32 notify_length;
> +	u32 notify_offset;
> +	int notify;
> +
> +	/* If common is there, these should be too... */
> +	notify = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_NOTIFY_CFG,
> +					     IORESOURCE_IO | IORESOURCE_MEM,
> +					     &pf_dev->modern_bars);
> +	if (notify == 0) {
> +		dev_err(dh_dev->device, "missing capabilities %i\n", notify);
> +		return -EINVAL;
> +	}
> +

Same again.

    Andrew

---
pw-bot: cr
