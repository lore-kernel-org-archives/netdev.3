Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072942;
	b=4VAhGmrSZbEe52cdVidYnQfozPZnfZ/xtYvtgkE9fkFgoFWf5jlh6Q7UZBMphrkcegMG
	 twsz0Zp7M2PjpgdefBrWoj1fkMNXA1KcsVlS3+s9xEvM0Fsy8yQyxY6EN823+Na2WXTlp
	 oJWOWhPG2J2R2TUU7ELKMBt4EDgr35U28Tv69Xe4Lz5GU4dViN15WlvaFcuauE0W3708G
	 EgQ5AGNnDb1RXgUtPrRFMmOa6WJKZl3V1sGyeBKmEPLyhOr6UGALfKIwCF+jY0jUgcD8E
	 yvfhjnh3+4mUn5k1ax9px4OiJUE9DV3VAK+oqvW1IqkCZKcjvVNzMIbac9O+UD9xT5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072942;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=OT852kkRo/o4VjO6nyHiNDsa3iGlZR8hdH3eYAOExAs=;
	b=ngSttEBJaCgMD+UkC2+eiBiSpSR8Uzd+ddun5xJ8Ggv72ddRssODvzK/b2y1sQul4gAU
	 P01LFZZJM9+9rwMXkjX5MDP7SataAPALbn/7PRX0RRzkaqLa40TUESm4SQroea9tY4mZw
	 Ek+amN06nefqmgt/8UMTMioCqV6wbgpCjEnuPinyS47ddQTnH60ECCpSOzbSuXysBESNF
	 vV4B/gobhlgQ/r6J5m6x9kXeo53IOPISqJpjJeY83VyREY+MPEj+JX1mEWHzAhSJd/tLf
	 5dfpAjQfFW16QR5l1JVpBaCUJ+evBcKBCZtyv2AzFdsZmFw9EzpFjWYBXnsgcAAh7TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ovou0tyw;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EE606A326;
	Sat,  7 Nov 2026 17:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D6EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ovou0tyw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OT852kkRo/o4VjO6nyHiNDsa3iGlZR8hdH3eYAOExAs=; b=Ovou0tywlvaSffc2v+I5u+7dbS
	kFnRn2pP6r1t4tP5XOnyoH8W6L6tpQZw+NRbA0ziv5aY5nXi0THYLVgKGgA5VAXvcnW6EqrCkwQES
	fn9LTHRTMjXmi7xo0uc8S3D+ZFpn2c9aYywiFzvAuGFmOKLvd5lnOcrSXZfpkOMsW5NA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPkK1-00EzDN-C0; Sat, 07 Nov 2026 18:35:21 +0100
Date: Sat, 7 Nov 2026 18:35:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ibm: emac: fix MR0 write in emac_rx_enable()
Message-ID: <59326527-5002-483a-b418-fef18eeab5d4@lunn.ch>
References: <20261105231417.119930-1-rosenp@gmail.com>
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
In-Reply-To: <20261105231417.119930-1-rosenp@gmail.com>

On Thu, Nov 05, 2026 at 03:14:17PM -0800, Rosen Penev wrote:
> When an asynchronous RX disable is still in progress, emac_rx_enable()
> waits for MR0[RXI] with
> 
> 	while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n)
> 
> which assigns only the RXI bit to r, as & binds tighter than =. The
> following write of r | EMAC_MR0_RXE then clears every other MR0 bit,
> including TXE, and TX stays stopped until the watchdog resets the EMAC.
> 
> This path is taken when RX is restarted after an RX descriptor error.
> 
> Tested on a Cisco Meraki MX60.
> 
> Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 640618c0a09e..b676b286e339 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -249,7 +249,7 @@ static void emac_rx_enable(struct emac_instance *dev)
>  		if (unlikely(!(r & EMAC_MR0_RXI))) {
>  			/* Wait if previous async disable is still in progress */
>  			int n = dev->stop_timeout;
> -			while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n) {
> +			while (!((r = in_be32(&p->mr0)) & EMAC_MR0_RXI) && n) {
>  				udelay(1);
>  				--n;

This sort of code should really make use of iopoll.h

	Andrew
