Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA045FDA7;
	Sat, 28 Feb 2026 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311829; cv=none; b=nSCz4SQycbaeiqCJT7qeCctZOnbbZ9wx2J9WTbt678C6D+2Pe+RBtMvGzQlpOyx76i7NL9PRVhrrnxkIdmqIlCKuWsa1SneNcknQZSP1vpezm+e+pgg6recOmdla3YM3O8oZUVqVQqBsfkUFNdbXVRKyczVx8cHLQUAsZTCyLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311829; c=relaxed/simple;
	bh=FwTgjiCtraLuXMfdXw4gBl+jxXmEf2hMBpF7WF/kxpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0UcBkwDh0muXTdhNpqUCcFX9EPudBa4o38VlhakqutbgT8xeow2AICbf9zuWkhpv+OQDAk5YJyIKRPMZNmxs1EIOHfYo7uE4VUyWdow+3y4O2VD01Vo/+0JkVhxmbcMetlOrZUvw93g05bKk4bWUxgPblB6S+kMc2sYOKn/fCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qQVSCZcr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qQVSCZcr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GR0zUbUSdkThp+budEXJULNzc5JronWqLIlaC/ZNF5k=; b=qQVSCZcr+ySlfYYrHr9SYhBnzp
	N3M2Uygz8VVXoUSzXbGzimyZ/X9SEtEDxJoC1ttf5NWbgSgmdYNxY73+r9+0NLNpQ6g5IVLVp5vqe
	wOiD/9YGuAKmZ6uyos5upk79OxZ6WsoMAok3TGcLXCIYwDWcqrARUSyk9hDKqaaSQJNo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwRGT-009DsM-SO; Sat, 28 Feb 2026 21:50:17 +0100
Date: Sat, 28 Feb 2026 21:50:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 08/11] net/nebula-matrix: add vsi resource
 implementation
Message-ID: <4e979488-3a6f-43a1-a958-a6606e422372@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-9-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-9-illusion.wang@nebula-matrix.com>

> +static void nbl_hw_set_driver_status(struct nbl_hw_mgt *hw_mgt, bool active)
> +{
> +	u32 status = 0;
> +
> +	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);

No point initialising status if the first thing your do is assign to
it.

> +static int nbl_res_vsi_init_chip_module(struct nbl_resource_mgt *res_mgt)
> +{
> +	u8 eth_speed = res_mgt->resource_info->board_info.eth_speed;
> +	u8 eth_num = res_mgt->resource_info->board_info.eth_num;
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
> +	int ret = 0;
> +
> +	ret = hw_ops->init_chip_module(p, eth_speed, eth_num);

Another example. Please review all the driver for such pointless
initialisation.

	Andrew
