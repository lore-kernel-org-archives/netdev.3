Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C23ED5A6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815458; cv=none; b=OSBZFFHGTrLcYUUN0w1S0MGrCyRiBtp/b+wUB/v1An0EyndZg2GnbTxiF+oIVjr7bM4TUzV4ekZARWjZ+/6W4g8H8F8UB9WWhxgkEdeExx+Z3v2uZ8StDAlu9lnCt5G0r2uQ7OnfUAmebMM0IohqVQPqZoNb4vxu0q+PZlMkrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815458; c=relaxed/simple;
	bh=XvDQJvE4M7XT7qt7Y6KTCu/jIFJH2/QmiZiRcck1yNU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=AEj/yT5kgnTl96O4vc2tyZPGMPCDvfMp7N5QVWYBT3dRF4IZMqRSWUKJ2x3cDAxNUXCVbRgmBWt9v+m0O7ZX9pJGyt7gMgEQX0F8/ahQWUF95FwDxhaFvAxf21QtoXGqUmAv0LkS2KmQOarh+0t8LrvlI9GpnFrGBxEIUIl0BM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RzDUAkFI; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RzDUAkFI"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782815455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLoCBIg3HCmpmWjUPvotZGyKOLRzdtV91re2dTJIL1o=;
	b=RzDUAkFILWC/o/M/4TZRlATAn/JZaqIvcW27ziULpEIqBWQtET9nz+lOZaT2jk3SLc8ux2
	JESCgvmSwCuoiuVDYobgpT2SFQ7AZ95/yceW43f0BpWEqVmHLak6IBrM+BNyh3+CF0XYX+
	lYnk0Q8W1twJpCGSvgkJM7IOAxRGLdQ=
Date: Tue, 30 Jun 2026 10:30:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as
 packet
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260629174458.6ebf647d@kernel.org>
References: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
 <20260629174458.6ebf647d@kernel.org>
X-Migadu-Flow: FLOW_OUT

June 30, 2026 at 8:44 AM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@k=
ernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:

>=20
>=20On Thu, 25 Jun 2026 15:32:04 +0000 Tianchu Chen wrote:
>=20
>=20>=20
>=20> From: Tianchu Chen <flynnnchen@tencent.com>
> >=20=20
>=20>  Discovered by Atuin - Automated Vulnerability Discovery Engine.
> >=20=20
>=20>  cx82310_rx_fixup() treats an RX length of 0xffff as a device reboo=
t
> >  marker and schedules work to re-enable ethernet mode, but then conti=
nues
> >  processing the marker as a normal packet length. This is an out-of-b=
ounds
> >  heap write controlled by the usb device.
> >=20
>=20Where? Can you be more specific in the commit message? At a glance=20
>=20the accesses seem to be bound-checked with skb->len.
> --=20
>=20pw-bot: cr
>


The "len > skb->len" check bounds the source read, but the overflow is on=
 the
destination buffer.

The buggy path is:

	if (len =3D=3D 0xffff) {
		netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode")=
;
		schedule_work(&priv->reenable_work);
		/* <- BUG: missing return; 0xffff bypasses the oversized-length reject =
*/
	} else if (len > CX82310_MTU) {
		netdev_err(dev->net, "RX packet too long: %d B\n", len);
		return 0;
	}
	if (len > skb->len) {
		dev->partial_len =3D skb->len; // skb->len is bounded by the USB transf=
er size (4K)
		dev->partial_rem =3D len - skb->len;
		memcpy((void *)dev->partial_data, skb->data,
		       dev->partial_len); /* <- TRIGGER: can copy 4K bytes into 1516-by=
te partial_data */
...
...
	}

For normal oversized lengths, the len > CX82310_MTU branch rejects
before this copy. But 0xffff is special-cased and falls through. With a
4096-byte RX URB, after the 2-byte length header is pulled, skb->len can
be 4094, while partial_data is allocated as dev->hard_mtu
(CX82310_MTU + 2, 1516 bytes).

So the source read is bounded by skb->len; the destination write is not.

I am happy to send a v2 with this spelled out more clearly in the commit =
message
if needed.

Best regards,
Tianchu Chen
