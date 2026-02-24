Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5523033ED;
	Tue, 24 Feb 2026 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914668; cv=none; b=NEOP1kli2Hm55F2A2OfFNjqjX+TZ0GJWYocHCgu7w6yFdzJEfMb9O/JAsSiX/poG6vKSmOAWmplJkC32v/Jfd1EGwmL1X5Q1lF23g/cOHaA+L6sSYzpcx8RRVmhhxEjBfc1VWhirPuL7QjPhwikK4UDaR+rw2XHc0GSE+a8w7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914668; c=relaxed/simple;
	bh=MFCRFkOJ0zSc8IX2SLAhpmWe5njBsfMRq85xw6y64xA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEOLtaGt9lewRxUqZFDvFYcBqZunxFV182BgRGc/kzjqz5XA0cU84gD+YFhRT8N7Qf7AIHWdTUISG+ORnbMjuSZ7QS9DXU63HiJ5BO0gFoaQgId/xe/DoQzCZm4rXZI8mUoLy+YCoL7vsNdPQPlgDxy0/cS5sWohzef1In7I1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=E4SCBXTx; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="E4SCBXTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771914663;
	bh=MFCRFkOJ0zSc8IX2SLAhpmWe5njBsfMRq85xw6y64xA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E4SCBXTxMLYKM9MFmDcNhWlux1yPWBM4LcOsoajUpj6qtypUU8MwGon438kGxq/5N
	 m/ZI5Nr32/oPnUSqLI/GdMxrNEwo+JmyEQ65vrlMVhv5ilRjbpQ0ZXhCMWaKIPBYHk
	 2wFUhsm7/i0FlfvO2e2BbxYBru2VPKanZR9b94y+tQ6oyciB74tYAdCvLyZV9FBU2M
	 M+trE06So13AkjHmPa8hVdU/SRNLxiBXuUrLh/gVlDs2WJMwoZU98pJwSogbXUTtT/
	 /vIEbofOYISbcaTV7q5euU3GSExQnd5Z0rizlSzvLViEtOJ541TPF3xNIYlK4V6TGW
	 l56wy1/ba1W4g==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 674E76023B;
	Tue, 24 Feb 2026 14:31:03 +0800 (AWST)
Message-ID: <53bc468db1fe156cf949cb1774b701d209935a83.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: usb: properly drop the usb interface on
 probe error
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Johnston
	 <matt@codeconstruct.com.au>, stable <stable@kernel.org>
Date: Tue, 24 Feb 2026 14:31:03 +0800
In-Reply-To: <2026022314-retiring-accustom-ca7b@gregkh>
References: <2026022319-turbofan-darkened-206d@gregkh>
	 <0fc4daf8261ea1b163c81c5618aba74f248bc3a9.camel@codeconstruct.com.au>
	 <2026022314-retiring-accustom-ca7b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

> > > diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.=
c
> > > index ef860cfc629f..eef17ae89298 100644
> > > --- a/drivers/net/mctp/mctp-usb.c
> > > +++ b/drivers/net/mctp/mctp-usb.c
> > > @@ -355,6 +355,7 @@ static int mctp_usb_probe(struct usb_interface *i=
ntf,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_free_urb(dev->tx_=
urb);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_free_urb(dev->rx_=
urb);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_netdev(netdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_put_dev(dev->usbdev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > > =C2=A0}
> >=20
> > Should we not do the usb_put_dev() before the free_netdev()?
>=20
> Why?=C2=A0 The usb_put_dev() doesn't really do anything, except for the f=
act
> that you have to do it because you did a usb_get_dev() earlier.

More that the dev-> dereference may be invalid at that point, since the
netdev (and hence dev) has been free_netdev()-ed.

Cheers,


Jeremy
