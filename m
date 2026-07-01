Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3230136358
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873969; cv=none; b=Nwmh4UUof9xbCJ7TwkPqZUniZQJkAbLLwPs37FrB7vQ5/B3RsBHCGnLtyiB+U5iAL5RQsJwxg7JdavdmL24vrv053BQ6yc+7dM/y/wAdqZG7vH3Q/F1gk/02WqVjH+S54EL1bGzdD6DfTk3BVtiinDc6sEAZS+r0JVMOzQ8cIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873969; c=relaxed/simple;
	bh=AkM2YMbS4cgrcGDPieW2Q/7KIitk4hyUSMotQdJZHd0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=p6+SYJbx05pJ4saWS8Q5uq0y0WxnaJguekTttOfLvYN5BTWZJJkDnKYo61JkVHEf6KZu34LhFtjsc1TrkIoJLkbFl0quQa/SKe7WlN1kJ9CBqyTeIwqkI7xjw7ZSPIBXiMR23duA727fthfBXMk0ukIx51cHE1AQiDasPftWGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OL4YoBGb; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OL4YoBGb"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782873955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGyYp8fgvM0spGaHVAVIN+LiPqSPwBtl4s6NpkpojzU=;
	b=OL4YoBGbS7vuYSsBvGPeotMJNvKpOq0DOYLqAUBiJ9x7OuDuOTiBFJolspB+C1Rq8L26Kg
	RI1EW/adYnx/it3Zf0waWtnQDcL7D9PeItx6Ldqgaga03Xfpha2ZdIyVxWLkGuLpz6srBo
	nYwJ7eVCqV6H3Fn2pngiezhLkJ+6UgM=
Date: Wed, 01 Jul 2026 02:45:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <eb9d8a511c83224d1af492799b551e33fca8c7d1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as
 packet
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260630154255.2954c33a@kernel.org>
References: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
 <20260629174458.6ebf647d@kernel.org>
 <e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
 <20260630154255.2954c33a@kernel.org>
X-Migadu-Flow: FLOW_OUT

July 1, 2026 at 6:42 AM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@ke=
rnel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:

>=20
>=20On Tue, 30 Jun 2026 10:30:53 +0000 Tianchu Chen wrote:
>=20
>=20>=20
>=20> June 30, 2026 at 8:44 AM, "Jakub Kicinski" <kuba@kernel.org mailto:=
kuba@kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > w=
rote:
> >  On Thu, 25 Jun 2026 15:32:04 +0000 Tianchu Chen wrote:
> >  > From: Tianchu Chen <flynnnchen@tencent.com>
> >  >=20
>=20>  > Discovered by Atuin - Automated Vulnerability Discovery Engine.
> >  >=20
>=20>  > cx82310_rx_fixup() treats an RX length of 0xffff as a device reb=
oot
> >  > marker and schedules work to re-enable ethernet mode, but then con=
tinues
> >  > processing the marker as a normal packet length. This is an out-of=
-bounds
> >  > heap write controlled by the usb device.
> >  >=20
>=20>  Where? Can you be more specific in the commit message? At a glance=
=20
>=20>  the accesses seem to be bound-checked with skb->len.
> >  --=20
>=20>  pw-bot: cr
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  The "len > skb->len" check bounds the source read, but the overflo=
w is on the
> >  destination buffer.
> >=20=20
>=20>  The buggy path is:
> >=20=20
>=20>  if (len =3D=3D 0xffff) {
> >  netdev_info(dev->net, "router was rebooted, re-enabling ethernet mod=
e");
> >  schedule_work(&priv->reenable_work);
> >  /* <- BUG: missing return; 0xffff bypasses the oversized-length reje=
ct */
> >  } else if (len > CX82310_MTU) {
> >  netdev_err(dev->net, "RX packet too long: %d B\n", len);
> >  return 0;
> >  }
> >  if (len > skb->len) {
> >  dev->partial_len =3D skb->len; // skb->len is bounded by the USB tra=
nsfer size (4K)
> >  dev->partial_rem =3D len - skb->len;
> >  memcpy((void *)dev->partial_data, skb->data,
> >  dev->partial_len); /* <- TRIGGER: can copy 4K bytes into 1516-byte p=
artial_data */
> >=20
>=20If skb->len (=3D=3D dev->partial_len) is not bound-checked to the siz=
e
> of dev->partial_data - aren't there more paths that could hit this
> overflow? Are you fixing the right thing?

Yes, skb->len and CX82310_MTU are different limits here.

skb->len is the amount of data received in the current USB RX URB. This
driver sets dev->rx_urb_size to 4096, so skb->len can be much larger than
the network frame MTU.

The safety invariant for the partial_data copy is not that skb->len is
MTU-bounded by itself. It is that, for normal frames, the code first reje=
cts
len > CX82310_MTU, and then reaches the partial-packet path only when
len > skb->len. Therefore, on the normal path:

	skb->len < len <=3D CX82310_MTU

so copying skb->len bytes into partial_data is safe, since partial_data i=
s
allocated as dev->hard_mtu =3D CX82310_MTU + 2.

The 0xffff reboot marker is the only case that breaks that invariant:
len =3D=3D 0xffff is handled in a separate branch, and it just bypasses t=
he
"len > CX82310_MTU" check entirely.

So the only case that may trigger this OOB-write is len =3D=3D 0xffff, wh=
ich is a
reboot signal and should be skipped from being parsed as normal packet.

Also, skb->len is governed by the USB RX URB size, not by the network MTU=
;
it is a different length limit from CX82310_MTU.

I believe this addresses the concern, but please let me know if you see a=
ny
remaining issue and/or would prefer a v2.


Best regards,
Tianchu
