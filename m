Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388D3AD514;
	Mon,  1 Jun 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323710; cv=none; b=f8SpEfQEQj3yl4VkDHnj7Qmy07y3M5gfHZ2mk1HakV9q4paaPBL3bWNA3fKjfyx20rBITdHkGSTe8A8TvbwJgksh4FOkDIpQIO4igJPR7qv6MsN0v6zWly1DtLFK8EbaFniT7eIamDkmElB/Xw91DCNt4GG1WgteNaHkUIHsesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323710; c=relaxed/simple;
	bh=b7XIUnfimfLGNKwoTtR5UhLG0DfGvISBJlLSi/i5SmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmfdP8S0t3dhXAePlT9VRmFFiLcexo9ECdKq4qaM1/ya2joLTrc2vG++JMb8QD5EmwqItO5eT9stnordaUahSu9t5uMrwjvVYDNZl3EN0eIzbvxPBs9ZIsQ7NMKIc98YOGZspi/AkFnv9sykplbjpNaegEWxzicjcAyJWYtLKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=usGPnNt8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="usGPnNt8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=78BA/GTDKa+jAZdCM5jkeiqae4h88fyQe91puNaR8Oc=; b=usGPnNt8SnZTMJ1TUaViv5FZdW
	qR1I70zA6xz8DE5kV83LHyGqoJc0ziPwIiq1QFjqYP/YNgBhpr66R9OCTYky+31+nn/OjlXf08sKL
	rAMxS9pAv1UeXsaoum9ktCA8QMhpCkJktafdOLSmZzm3tVOsnxcPRwBqIsLAYmIHj4u4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wU3WM-005WDq-Uq; Mon, 01 Jun 2026 16:21:38 +0200
Date: Mon, 1 Jun 2026 16:21:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v5 1/2] dinghai: add ZTE network driver support
Message-ID: <2f211c43-575a-4661-b37a-6fe61d24da79@lunn.ch>
References: <20260601142440024x-1sx0cQucoMxTHjm7ps3@zte.com.cn>
 <20260601143002051rSxzNiN9iKNj5gsdema0a@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601143002051rSxzNiN9iKNj5gsdema0a@zte.com.cn>

> +static int dh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct zxdh_pf_device *pf_dev;
> +	struct dh_core_dev *dh_dev;
> +	struct devlink *devlink;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "dh_pf probe start\n");

Please don't spam the kernel log.

> +	ret = dh_pf_pci_init(dh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "dh_pf_pci_init failed: %d\n", ret);
> +		goto err_cfg_init;
> +	}
> +
> +	dev_info(&pdev->dev, "dh_pf probe completed\n");
> +
> +	return 0;
> +
> +err_cfg_init:
> +	mutex_destroy(&pf_dev->irq_lock);
> +	mutex_destroy(&dh_dev->lock);
> +	dh_core_free_priv(dh_dev);
> +err_pf_dev:
> +	devlink_free(devlink);
> +	return -ENOMEM;

dh_pf_pci_init() returns an error code. You should use it here. It
makes the code hard to debug when the higher level is ENOMEM, but the
lower is saying EINVAL or something.

> +static void dh_pf_remove(struct pci_dev *pdev)
> +{
> +	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
> +	struct devlink *devlink = priv_to_devlink(dh_dev);
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +
> +	dev_info(&pdev->dev, "dh_pf remove start\n");

More log spamming. Drivers mostly use dev_err() for when things have
gone wrong, and dev_dbg() for debug. Other levels exists, but they are
not really used. If you do use them, they need to be for good reasons.

	Andrew
