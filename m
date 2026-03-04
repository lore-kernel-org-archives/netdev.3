Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55293822AD
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655235; cv=none; b=jqyQkBCBVe/ZxyCMvauQCQJecHdZkxCzOpyj0gVpaIvDPh4Iw7b2zOv7O/BOiA1snmhz8lPqekBgfpYzCIubDspNGbYHXMRO5MTFSpuUZpuulqd4E4ql1HpO/MW6n1Or1acj1pR6Mkw6z2b6G3CfyvHyLQKAD11TFDZuyax2lZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655235; c=relaxed/simple;
	bh=7isN0xhrJkk47PegGus9LY1Urm2aH5STsiDXwCBNBRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYvS/XJvt6sjZ+wUVK7O4LdytPs4U9DPDjtTtRvCJihjHbGN6alTWfCegiPNbCy7YINOlWCjLaeQBLJ2K/bRDaRUmzJ44Fso/6XL9cFgeeRyEJCW6jpEojfEXdvOSR4F+HQjJi9RvZ9y6VP8DVePWqpgPZHtqIVyOat5RdA3Ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B9QPp6Qk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B9QPp6Qk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZYpCnuhrUQxVvNjT6K7a+BBoT+f8MufvgTAJ3dQzlp0=; b=B9QPp6QkMWDTSxdkj4rOXky+S5
	U7IsorNFmVM/GZXVAruWBbQqKkf31vCGRWwITXj9P7oMLCMMX94HSaWGD2zxAHRoMMxu/NkI44p04
	+5vZJF7BIh1+Kkum4OdixwipjcNnNRDEgzQFxGop6AIce44JxMqCae9jGcuz72PdxgvU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxsbD-00AAdx-1k; Wed, 04 Mar 2026 21:13:39 +0100
Date: Wed, 4 Mar 2026 21:13:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk,
	quan@os.amperecomputing.com, keyur@os.amperecomputing.com,
	iyappan@os.amperecomputing.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] net: mdio: xgene: Fix misleading err message in
 xgene mdio read
Message-ID: <837d37e3-b68b-43d5-b325-235fe9c83f65@lunn.ch>
References: <20260304195755.2468204-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304195755.2468204-1-alok.a.tiwari@oracle.com>

On Wed, Mar 04, 2026 at 11:57:36AM -0800, Alok Tiwari wrote:
> xgene_xfi_mdio_read() prints "write failed" when the MDIO management
> interface remains busy and the read times out. Update the message to
> "read failed" to match the operation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/mdio/mdio-xgene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
> index a8f91a4b7fed..ede6b9ddc426 100644
> --- a/drivers/net/mdio/mdio-xgene.c
> +++ b/drivers/net/mdio/mdio-xgene.c
> @@ -250,7 +250,7 @@ static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
>  	} while ((status & BUSY_MASK) && timeout--);
>  
>  	if (status & BUSY_MASK) {
> -		pr_err("XGENET_MII_MGMT write failed\n");
> +		pr_err("XGENET_MII_MGMT read failed\n");

It is not even a plain cut/paste error. xgene_xfi_mdio_write() does
not print an error message!

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
