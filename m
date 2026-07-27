Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDC351C2F;
	Mon, 27 Jul 2026 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118741; cv=none; b=lWFnc/yAJusxzV3gyfXTT6EUDGptkFTdu4VGLWWtB9PfwGoGIVoxSFucoZ0nNDv5yV7+d+rWrd1fX1f2PNl/ar1qyxfLm7o5oGi8lmyingDjNAAjqhOTCvR4jhoiJ4cRRpIuQGbkHClirEBdO7AXQa/3Uf4UpCyYrPvmkSiFxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118741; c=relaxed/simple;
	bh=Q5JmecGMXcIAe8J3Tia4EK2N4XqlCjwW4oTFNMnNBeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b12hX9pnN8I3cfUvOY+p9pfaEOgPYEmCTThEJHEM1pwAN5eif+ublIB5ZpfDUkZ7qR7WaiJA9IWmS0mzwwwc3J2hMkm+HCDkspUWlS11vkz8Y+4cEHDwVDIVLvlVwhkOUudK46kEmRPvnPGe2I4AXwRvYy0/jBHVJB2+IQvQ/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=C0NU/yYq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="C0NU/yYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785118736;
	bh=zFylZWS9nKbbYGnPEWcRgJ+WL7PVQDD9csdvwzZ0SDo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C0NU/yYqtgiz9QU5ut7tFHGC10DtkbCMk7l3aj4YT0l/G9LApNGDjpoev/uTRtu/w
	 Vi7Tq9EvpMxSFCFUKQcCWNKxf1Okb3rOaLmr5yaSPPlsMTLSpg8TUr0ED8NhzBM6jt
	 Cle/4w98uvt9NxxuIKnfKHKyGbTBsywvIb07SP/9Og7NrTOjCOQwHpcLW0M/MPI35x
	 Kbe60f8q3GDesbh8QtQjHkG3El8JlgP+Y2gAnwx/1JHoCZk/K18YouS4IzN2BCWwLX
	 ajehWS2XMt+Rhcr1e9P44AqQ/T8DtlOj+N1KzV+evouX1ZMP9yerqzF+GxckGD2QCK
	 B5kUVJo1kk9hw==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DB65C608E3;
	Mon, 27 Jul 2026 10:18:54 +0800 (AWST)
Message-ID: <a97d01ccf39389d52e70c32c60da5d80ecac2652.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v5 00/12] net: mctp: usb: Add support for
 MCTP-over-USB v1.1
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
Date: Mon, 27 Jul 2026 10:18:53 +0800
In-Reply-To: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
References: 
	<20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

Some review feedback from sashiko, along with responses:

> --- Patch [2]: [PATCH net-next v5 02/12] net: mctp: usb: Use packet-lengt=
h max for maximum packet-size check ---
> commit df3ce01edadf3abe9a5e04b1500317e960abd98f
> Author: Jeremy Kerr <jk@codeconstruct.com.au>
>=20
> net: mctp: usb: Use packet-length max for maximum packet-size check
>=20
> This commit updates the maximum packet size check in mctp-usb to use a ne=
w
> define based on the u8 transport header length field. It also applies thi=
s
> new maximum to the MTU calculation.
>=20
> > diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
> > index 545eff06322ce..c6e36b63e87a0 100644
> > --- a/drivers/net/mctp/mctp-usb.c
> > +++ b/drivers/net/mctp/mctp-usb.c
> > @@ -76,7 +76,7 @@ static netdev_tx_t mctp_usb_start_xmit(struct sk_buff=
 *skb,
> > =20
> >  	plen =3D skb->len;
> > =20
> > -	if (plen + sizeof(*hdr) > MCTP_USB_1_0_XFER_SIZE)
> > +	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX)
> >  		goto err_drop;
> > =20
> >  	rc =3D skb_cow_head(skb, sizeof(*hdr));
>=20
> This isn't a bug introduced by this patch, but could a transient USB erro=
r
> during TX permanently stall the network device's transmit queue?

This is a shortcoming in the existing tx path, and is addressed by patch
05/12.

[...]

> This is also a pre-existing issue, but does the RX polling loop stop
> permanently on transient USB errors?

... and this by patch 04/12.


> --- Patch [5]: [PATCH net-next v5 05/12] net: mctp: usblib: Move TX trans=
fer processing to mctp-usblib ---
> commit ee53d6679c1c34404c4b886475dd086d680df184
> Author: Jeremy Kerr <jk@codeconstruct.com.au>
>=20
> net: mctp: usblib: Move TX transfer processing to mctp-usblib
>=20
> This commit moves the TX processing alongside RX processing in mctp-usbli=
b
> to accommodate packed transfers where a transfer may contain multiple MCT=
P
> packets. It splits the transmit API into push, send, and complete stages
> and fixes an inconsistency between tx and rx stats.
>=20
> > diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usb=
lib.c
> > --- a/drivers/net/mctp/mctp-usblib.c
> > +++ b/drivers/net/mctp/mctp-usblib.c
> [ ... ]
> > +static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb,
> > +				      enum skb_drop_reason *reason)
> > +{
> > +	struct mctp_usb_hdr *hdr;
> > +	unsigned long plen;
> > +	int rc;
> [ ... ]
> > +	hdr =3D skb_push(skb, sizeof(*hdr));
> > +	if (!hdr) {
> > +		*reason =3D SKB_DROP_REASON_NOMEM;
> > +		return -ENOMEM;
> > +	}
> > +
> > +	hdr->id =3D cpu_to_be16(MCTP_USB_DMTF_ID);
> > +	hdr->rsvd =3D 0;
> > +	hdr->len =3D plen + sizeof(*hdr);
>=20
> This isn't a bug introduced by this patch, but does this assignment miss =
a
> cpu_to_be16() conversion?
>=20
> The len field in struct mctp_usb_hdr is defined as __be16, but it appears=
 to
> be assigned a native integer value here.

At this point in the series, hdr->len is a u8, not __be16.

We change this to a __be16 two patches later in 07/12, and at the same
time add the necessary endian conversion to all uses of hdr->len.

> --- Patch [10]: [PATCH net-next v5 10/12] net: mctp: usblib: Add initial =
kunit tests ---
> commit 6e78640ea8bf2b13bb32c513ae1e30a04bebf125
> Author: Jeremy Kerr <jk@codeconstruct.com.au>
>=20
> net: mctp: usblib: Add initial kunit tests
>=20
> This commit adds initial KUnit tests for the MCTP USB library receive
> path to verify extraction of MCTP packets from incoming USB transfer data=
.
>=20
> > diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mct=
p-usblib-test.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/drivers/net/mctp/mctp-usblib-test.c
>=20
> [ ... ]
>=20
> > +static int mctp_usblib_test_dst_output(struct mctp_dst *dst,
> > +				       struct sk_buff *skb)
> > +{
> > +	struct mctp_usblib_test_dev *dev =3D netdev_priv(skb->dev);
> > +
> > +	skb_queue_tail(&dev->rx_pkts, skb);
> > +
> > +	return 0;
> > +}
>=20
> Could this lead to memory corruption if an external packet is routed here=
?

This is testcase code, so intentionally simplified, and typically
running within the kunit harness. We should not be receiving or routing
external packets at this point.

Cheers,


Jeremy
