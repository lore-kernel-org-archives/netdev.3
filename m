Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AE3AF669;
	Mon,  1 Jun 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324101; cv=none; b=jsZcQc0/iMWY2tjFwQ+rjuFsiY4QgAbl+q5oKU1/JkF8+92MXW7P4T918GpTXZ6UmhUPao1f1VIdGj3X10ZuolEdrdc3IGPOTO8Eh3gJcswMcb2KCbIDCe7kqcvMQUR/RyMyLcJGZIWZe1G444fMOB556Lc6F5Y4aJ2Cl8gmHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324101; c=relaxed/simple;
	bh=sYL54OqTOn+amh7BOPAUk5OxWfZUMJhoHExI3nY2QBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITKJ27jsuGv5Bj4DlP+O4nrMVvDBtgHxZDcvJph0WWRghM+b0M/AJOsdsWhFXEc4rK/2i3YoVkuiZGiy4iPYlw8XUA1Vfrenz+KBaDx+Jl7MOS7eTX60r9b/rUAL7iobtkEwtGiKaNSSk3YBxu9cQ35i6aCBvHet2KKz9lqjvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x4oCBWeT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x4oCBWeT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T6paJbyYL33aWzV+hhcBhUhpUBftf/yLil7Uwrqb++g=; b=x4oCBWeTk6NnUWLMyY22uL1AVg
	owPr37j8T+O/2bqa4AizIMBsbAGEnOXHm8Gqk0EunF6Kjogz3VLWSujZo2nr3icApyHRDothylr2C
	FyZ1YtVIuKRbRQIHXXFz2kCgEpZjEFBtuRs/Em+bdIWnWP9U2Ql5KsYhq64zm2nX+q3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wU3cj-005WH7-BC; Mon, 01 Jun 2026 16:28:13 +0200
Date: Mon, 1 Jun 2026 16:28:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v5 1/2] dinghai: add ZTE network driver support
Message-ID: <ae94bb6d-b341-4112-a914-533162f682e4@lunn.ch>
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

> +static void dh_pf_remove(struct pci_dev *pdev)
> +{
> +	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
> +	struct devlink *devlink = priv_to_devlink(dh_dev);
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +
> +	dev_info(&pdev->dev, "dh_pf remove start\n");
> +
> +	dh_pf_pci_close(dh_dev);
> +	mutex_destroy(&pf_dev->irq_lock);
> +	mutex_destroy(&dh_dev->lock);
> +	dh_core_free_priv(dh_dev);
> +	devlink_free(devlink);

Think about the ordering. What does that devlink instance allow? At
some point you are going to add some ops. Do any of those ops need to
access the PCI device? Do they need the mutex? Access to priv?

> +static inline void dh_core_free_priv(struct dh_core_dev *dh_dev)
> +{
> +	kfree(dh_dev->priv);
> +	dh_dev->priv = NULL;

There should not be any need to set it to NULL. If you have called
dh_core_free_priv() you should be 100% sure you will not be accessing
it again.

	Andrew
