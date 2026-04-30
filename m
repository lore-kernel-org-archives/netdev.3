Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFA52D47E9
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577704; cv=none; b=ZIcFN2eTnvgiSoSUAQXXHtc/N0R//qzv9rwVFQtgNEX4F+/QLr7/Dm1SmGVyxro8MJKzgKcp92bTS4AJFKxtHwn5tUw+QMPgCiohWvsqsWimK+sIfrrxinahdDSUQeSb2ZTAFG3Om7Ur1agzTU+8A64sPjLp/H+JpIkHiorGCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577704; c=relaxed/simple;
	bh=JU+Lm2/8upLNNTuwyJEW2xobHbda9df7x/rU9pwAbT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYyK+0bVnUK5aiPSfHD5dPLWYmjjtNZPG/FCQdoZW2GMvohorOjefA9Fkis0EUgONrFhBxJHSejI6jVCpQu1j8WopJ9Bnw7h+OziNaSHzD6wNzGneR+dSQp6QcV8qaVt7lG3rcCsVGaRdEH4R4dOwsRJjl9js7mCNd/2V+/UEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xLxpYijP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xLxpYijP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yE89MWJJ8mFNP+EQE3tQLxIR0F1fbjJ/EDjapCeT7Rg=; b=xLxpYijPKRJlrSK1eSbhOU9fBY
	zsnEulmwdGukFA+7vrU6SfzbCXvIp1PN5dKignndvM7ZMJj//Yay/FkpBrWEMCbrHZbZs0Vr9DM+R
	eQmWuVRWC4QO0XFDIkVTDOGOhM8n8qsD1MZxwD5G9utjkQDVz6rJ0KJkkX9zwj0bcdDA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIXA0-000jMJ-GI; Thu, 30 Apr 2026 21:34:56 +0200
Date: Thu, 30 Apr 2026 21:34:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 1/3] net/ethernet: add ZTE network driver
 support
Message-ID: <eabcb0c3-324f-4fd7-992e-8d517980ea27@lunn.ch>
References: <20260430151138.2813381-1-han.junyang@zte.com.cn>
 <20260430151138.2813381-2-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430151138.2813381-2-han.junyang@zte.com.cn>

> +    struct zxdh_pf_device *pf_dev = NULL;

Please don't initialise variables, unless they actual do need
initialising. It mask used before set warnings the compiler will
issue.

> +void dh_pf_pci_close(struct dh_core_dev *dev)
> +{
> +    struct zxdh_pf_device *pf_dev = NULL;

Looks like you can just set it so dev->priv.

> +static int dh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +    struct dh_core_dev *dh_dev;
> +    struct zxdh_pf_device *pf_dev;

Reverse Christmas tree. 

> +    struct devlink *devlink;
> +    int ret;
> +
> +    devlink = devlink_alloc(&dh_pf_devlink_ops, sizeof(struct dh_core_dev),
> +                &pdev->dev);

Wrong indentation. In fact, this seems to have spaces not tabs. What
does checkpatch say about these files? Or is you email still broken?

No point reviewing further if the basic are wrong.

    Andrew

---
pw-bot: cr
