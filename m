Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B022EACD;
	Fri,  6 Feb 2026 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346889; cv=none; b=M4Oapk9842AyVqOqdDopsPmM+ZgJhGxjV4wh981xUtzJrUFWKqqBU6HSPZ1eGvMytiI2KyGw9JJNzkKq8sQHRNcdOihRb5Z86Yi24+4fBadvvt1hqJZTm6DZWufFdP6CBcJkVGxbN6p1b8Vwjuj6K74cq9V9jb86lsU9OOcnxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346889; c=relaxed/simple;
	bh=lIs/tjRh/71CTW5nBpzCWtllnfh1ZUh50LJUm0w39QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/sxqihEJuUHiVfNRWD/sP3yX0IOua2acgfOqXdfrJd81bZEOmTmK8GKrcYCfUosbnlEBJW9DxUtlkdfD0gFQjq552uj3WJBf4nKKOleReXStO+y3dZvgMHZKrPMHphI2vibaOetrrVmYd45U/O3DeijnmKeGuk2XSURlpvsweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5LFhhwVP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5LFhhwVP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v9rlU65cZ+TLmBB5K+rhqw2fZYDAPPiFm6L0t9BL9DY=; b=5LFhhwVPV6JgSAE0c2NaezvAFY
	2N9I3S/UoH3ZPMV0rhikhf56lXX387d+/0LqmaJAvnkSEoIWBDZOxVr04Nko/LlAm+Va3MVzaF5yr
	bNAxS2uMhpVe4VQM0v+mjBYhXZp/68HPaJMD7d+aLARRieCBNFr+OLR4uTnOsoYkSzWY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1voC5e-006KTT-EF; Fri, 06 Feb 2026 04:01:02 +0100
Date: Fri, 6 Feb 2026 04:01:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 01/11] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <4eb26cb5-c46e-498f-ad3a-be740737715d@lunn.ch>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
 <20260206021608.85381-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206021608.85381-2-illusion.wang@nebula-matrix.com>

> +#define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
> +
> +#define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
> +#define NBL_CAP_IS_NET(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_NET_BIT)
> +#define NBL_CAP_IS_NIC(val) NBL_CAP_TEST_BIT(val, NBL_CAP_IS_NIC_BIT)
> +#define NBL_CAP_IS_OCP(val) NBL_CAP_TEST_BIT(val, NBL_CAP_IS_OCP_BIT)
> +#define NBL_CAP_IS_LEONIS(val) NBL_CAP_TEST_BIT(val, NBL_CAP_IS_LEONIS_BIT)
> +
> +enum {
> +	NBL_CAP_HAS_CTRL_BIT = 0,
> +	NBL_CAP_HAS_NET_BIT,
> +	NBL_CAP_IS_NIC_BIT,
> +	NBL_CAP_IS_LEONIS_BIT,
> +	NBL_CAP_IS_OCP_BIT,
> +};

> +static const struct pci_device_id nbl_id_table[] = {
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },

This seems overly complicated. Maybe NBL_CAP_* should be directly
BIT() values? 

NBL_CAP_TEST_BIT then goes away:

#define NBL_CAP_IS_CTRL(val) (val & NBL_CAP_HAS_CTRL_BIT)

which is simple enough you can have it inline, macro not needed.

It is however hard to say, because you add these macros here, but
don't have any uses of them.

	Andrew
