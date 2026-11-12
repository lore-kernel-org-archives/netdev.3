Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484896;
	b=RXbAmc+Xwz2EJhOvFJQ3uDbVg78PR88ymTQs4kQF5vpcn5og2T8lJyyZXroyXEAPi2bZ
	 ROCPfCT0f0z+/m7JWxFhIAOIt2axmKcu3btV1pA4iu5XPhBiYQ1MFqxmzpOEL7BlobZ8o
	 Tjri4JpK5UwrMdFKHoQid7Y6ZpMIC1hG2p9HWMM5O5TyhtuI1VRtyYWIW3ZwFLisKS2+C
	 15QKdp8MJeEOCSr2hkro9sM+9urtUAEzUKPxddeYOVpwwz1JloLBwBVGFqSaocSlWQzOU
	 Wb/uX2Jdx+emaw2POoPNCBqZj4J3h2kISS5aHU0+2s2Mw6t7uWx+t1+GQzCBF3ofNbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484896;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=SrQYdejZ3O32TNHlFeTRApwB45XDzPQrsRBZYxShr1E=;
	b=DCLv0rupfAs/Qo7NOzB/E75upfV526aszDEHR9ZaLF6q68xBDJmXR4FDsIBcRb9wdnf0
	 +Tgq5Cxo9e+6jkqgEYsbmq5oVfGGQZtvcBdfdAbd0jzI6i7keGrItUOwto/Rr99gzwOFF
	 QTB2Jau1HtNZPCZHjviDL+NzedcLvdYWj/dLjt7X+/DjS4xCgc0RkAGnOWrL32MKBRZvg
	 +MHQa4Xq6GakFExNZylzVZuossGuPpe5OgSkKbE6AKT9JCgBFn6SY4lyMPVCSTCW+wGtv
	 oh4j7TQvt+Am0A50yxbPoiodkGiktu6mh0EiXihv8ALZwEpN593S4RnyrDNbr3kOE0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MfVfH7ls;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56370606A327;
	Thu, 12 Nov 2026 12:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56370606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MfVfH7ls
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SrQYdejZ3O32TNHlFeTRApwB45XDzPQrsRBZYxShr1E=; b=MfVfH7lsakVXAX+0coNBN4yhPH
	EsrW2GZiCjPev0CM14rkH0CQmMa6H7QIVqrI/LukmYS/ErOz9tmjYbcMOfZnfpqD/CMydA+lR8TB0
	qwqkmzIS2sL3KSglt6HTdWN4tx29p9Yj9DCMtQs8sC6Zw8ZeB4J6W6P+BhoQYeZ3l+U1bhEhLWHWD
	EIPa08ooR4oy47gWnsl7BE0GjqGrFiuwn8Q3GAlnTXrN4KLilDbydWho33rDYX/PjbRynVpugI+ro
	009vKGyI38ZRwArx0zO1pGgFL4YqzLiZoqM6GsGFer3zDfNDQZSE64OXzHak5IoZMcqXAPIyWvlqD
	D+hIiHwg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRTUX-00DxF6-1L;
	Thu, 12 Nov 2026 12:01:21 +0000
Date: Thu, 12 Nov 2026 04:01:16 -0800
From: Breno Leitao <leitao@debian.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com, 
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v34 net-next 1/8] net/nebula-matrix: add channel layer
Message-ID: <avWqOzt1ImFuvyXL@gmail.com>
References: <20261112094925.6098-1-illusion.wang@nebula-matrix.com>
 <20261112094925.6098-2-illusion.wang@nebula-matrix.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112094925.6098-2-illusion.wang@nebula-matrix.com>
X-Debian-User: leitao

> @@ -75,27 +215,32 @@ static int nbl_probe(struct pci_dev *pdev,
>  	struct nbl_adapter *adapter;
>  	int err;
>  
> +	nbl_get_func_param(pdev, id->driver_data, &param);
>  	err = pcim_enable_device(pdev);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
>  		return err;
>  	}
>  
> -	nbl_get_func_param(pdev, id->driver_data, &param);
>  	/* never return fail when DMA_BIT_MASK(64) */
>  	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  
>  	pci_set_master(pdev);
>  
> +	err = nbl_probe_chip_deps(pdev, param.caps.has_ctrl);
> +	if (err)
> +		goto out_clear_master;
> +
>  	adapter = nbl_core_init(pdev, &param);
>  	if (IS_ERR(adapter)) {
>  		dev_err(dev, "Nbl adapter init fail: %pe\n", adapter);
>  		err = PTR_ERR(adapter);
> -		goto adapter_init_err;
> +		goto out_clear_master;
>  	}

nbl_get_func_param() now runs before pcim_enable_device(), but
nbl_probe_chip_deps() still runs after pcim_enable_device() and
pci_set_master().

Shouldn't nbl_probe_chip_deps() be on called earlier?
