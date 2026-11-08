Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794096438;
	b=pHMCUxYMJFp5xhV9vvVxwsHwVUINDcCpXl3pkdlp4vOa2tGEFXtH4kOhmV+4gyiNlSUv
	 FtQMHi4fisEdblEGmF/5/6dciNAP9dFbCsvzDzNR48fSleKUncWKNV+ryocvm8UuiFICK
	 4jQxteTbtNwpEGUfNDJRF/u5QuTaHUejb3EAp5TwYFYFqSCUoXpgg/YpTH1SQjBY4p+rL
	 KERu11YrgJXQhFhGwNEo/5bbqfwzpoEK2bVDUQ4DKOGULV2yZzN7w42eIlOWyzoziul5x
	 RrFw0aydoa+LOGaHs/Ek7LfDGbrs8+BJH+46coSGtZxf5tG9sHKieaije78mPPgSvDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aLLoc0xRBwl/ZGo6WGJQ8sG3lRdUqK6Mnkv9+kWc41A=;
	b=GJf0AchdDXhuiRbUQdqN+iie/gagCU0B5Qn0jCnM/ZrUKFtQDOFUwhe96F2fK5p1tDVs
	 ZyrXpSr5L+DrLVjQMZeyFVd+PCabEQlaOwbtJVdz3WFa/r01m2U1EFtp4vUd6vRPLXr6N
	 PRVRnexfUa4eYZgJS9DFqkyIdNdymO5m5tqN2P52xetuIlhlitVl5wlia7AY16+nnAkqf
	 8FrTGoC+mRlTYj2XMZ2krQaZ6jwTpubxvzJA8op5Cq5xO4bFeddPFn2pAHjMo/xlbSYkf
	 3bwTK8aZpNK3RR1wXpMtxpJOPyxfEkbkGCqSJ8S9ckBzYig8bJNqGBjz04iCdom+BMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AZb4taJP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C1606A32E
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 00:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 191C1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AZb4taJP
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b56bbf8330so75662a12.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 16:07:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794096436; cv=none;
        d=google.com; s=arc-20260327;
        b=b29KFd+M5QCNszVhYv76mRumKPsCfDM2yzMKAoUa0g4K7UtkTXOf5SZ5LTydeZ/vVz
         pOltSnUsu7BpOf/n7lopccsOQTH27AiIlXEumWiUh1j94xCA8q9R6au+9v9BrOLPdFua
         BEVTuMNmSi2vZsxTY0D3nC+d3vRbDcYmmGPLnaeFMDEn0Pw6+JMjwv5u9xYqhtw9DBm7
         EiSSJdY1xkmXgubokycv/cpNonBA8cdYMgozjKs7TF3NhE4LYE3H7tD0B+YrXLwIF4nu
         GYQdhOxsQcDEO27/30FXX5+1qyjqVLW9nj7O4/VbjMJVTkxKDSYTKyjhsYePzkm5ZisA
         0Vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aLLoc0xRBwl/ZGo6WGJQ8sG3lRdUqK6Mnkv9+kWc41A=;
        fh=PpQO4NHzRJCCccBNywpsH/DGGJOqOe4eptqM9Ub6hqU=;
        b=B4tVxCbW0A8MeOhoxnF2y2/UhueUoWkO8h6eRLanlnBEvW2othb+p+RT7gr4nGVEjZ
         z3zlWRB8M5cCPxpmswqOSAvT5pi6nMiQhcWVAHhfrHz/t5hAd/qWBQNFIDvyCz226wWO
         W2b563zy1z1zigfgjxeaVi2nWRTOc1IT71vm1JobRIOsCVv55FMDxTKLiPoo9hgM5jRK
         /OT1AMpXxNocW9kodbCn79OonC/QIGLf2Q6QRF4wjCnmufYfoSuaH2WjtC3ayxTtVFLl
         T1Gt+ILieQXA1fL9BNm6C/Nl8hbIQbfi7ITd2cFWS5IUfsyx93N0CNB9F1xNB5kH5EcN
         KzPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794096436; x=1794701236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLLoc0xRBwl/ZGo6WGJQ8sG3lRdUqK6Mnkv9+kWc41A=;
        b=AZb4taJP7QgpmgO+zRWdgaGa927bsAhxTloCpxEcsGhNdMqWGVnqKMmKRHAc/0Y1Tc
         i29BzOVJ5ixxRepPjrsRtZVc9XVjymSiUNkj553b9r1QVvMj6KtZOiYgCroS5sdeUvSS
         YzGF2zYyiUjFqJUo0Zcmwa8M7xFnZ2LgYyGoYlrDH/BQHSG5y0pEWt8UO3NLhcmycuva
         241KWSv6edpqhuSAE3S/tG4l0mdC+DgMDYAv4R4dbdK/S5GmfKW2NYKDItz03y53V5bz
         VJJ/UGkteqSsWuwDeVjX7vPx20xI3EuYBoiA/d7u5hKG2nxwxMncRrAyEj1z7BAmVD+a
         xvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794096436; x=1794701236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLLoc0xRBwl/ZGo6WGJQ8sG3lRdUqK6Mnkv9+kWc41A=;
        b=RqtM37tMQUkGBO0qy2piNhG1Vbwco21iFOMDzIa9L/x+gTm285zbFAQUqC0qLml5nL
         Jvia1cRR4TE4YhpGGd4r+P8uRw5z1fNowX8lp+KDhVIsjnAtxGR8LoieuXVgMbDHq6Wu
         DnM4T/2s/a+B6ebnZ8uuDaTHIOlb/26JQqnvP3ttdsx2Sx1VKJ7DWXyQsIMeUJ1TgPWs
         5+qD13NKQJphy5j7wxHElVBc7fMkFkSivYjqQt8ovEPUG+iwa5BWH+wQtlUjS6R03TN3
         BKcGa9ECT3IFC07y/GXmEs8HnBqlg5KrAqGBYhKvhHpVTgzEinLYiQ2E35HIqiMLz85P
         J1pQ==
X-Gm-Message-State: APuU4Z+L6v1MZYoidTL5AmlTb9tK1PIkEBH4mTLkRBbUQMluPa8teN+B
	/Wj+l9MSd/oiQrlpKGV9S3GagEZa+h27mprFnJr3HghBp0U61ynUH+0ZGBiMCjjFuPhF8+CGwlI
	aHQbz4EpcpL3XZK4hhcuU8U2AfBH4aw4=
X-Gm-Gg: AYBFou3UCcMVNtsL8UdLHtc128Ec/nFURzMXEou/8KiwGsUU87WuxbfjuvR6DZcSVEw
	xbLBOSU2FRM4elLGoTM83dxLy+V/HUh+Pe057Nbr/mR/dilRj4K4p2EiTbCd9BP228fE9MjiZBV
	juH1f9kymYjoNNwwiQpnsyotbT5eMbmk9LtgJqGrDIxK6V+5BRp3Q/XehvM6pn+7IZjjZaYq0aD
	Iw25luS6cKNjczPnX1EdtImwrflmcpaTsV2fb3se4gpmrnzJE+8/dvd7asZZOuOikGoOLahfVgT
	OSZ+3Oi8aUUeiq9zlQMjKSKUWs6GrK++opFXM0S8T4ss2ND954cgGoxYikJLBLSOmzVyh5BSG7s
	zRYCcf1RUqus1g4ngIquiTgf4GU9WlhisULhG368Sobr1u7LutGZYDkKFAxSIVQyeeoLHmvTWxM
	zdvmC6vpXhbJJkftXvdi8+V9taS55AvOTbXt1J9JsmbsVtNi0oDTeZt6rsvBg4DIE1a1U6DgXnv
	BMHyMyW3oy7Q/U6ySbIqpn8O2Vu+DgKKM8ANDOB3l4qItM/Bw==
X-Received: by 2002:a05:6402:3202:b0:6b5:646d:be3b with SMTP id
 4fb4d7f45d1cf-6b722462c1bmr139907a12.18.1794096436370; Sat, 07 Nov 2026
 16:07:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105231417.119930-1-rosenp@gmail.com> <59326527-5002-483a-b418-fef18eeab5d4@lunn.ch>
In-Reply-To: <59326527-5002-483a-b418-fef18eeab5d4@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 7 Nov 2026 16:07:04 -0800
X-Gm-Features: AclHuK_6K2L6LJvgG9zaPsn_XSuhmhRlq2dPAWbQ9XPKBewY97fg0FWq5sGwZf4
Message-ID: <CAKxU2N_wqu_HmX59B-M4htLq2HbBpdcd_f2cChn1QayANPUTFw@mail.gmail.com>
Subject: Re: [PATCH net] net: ibm: emac: fix MR0 write in emac_rx_enable()
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, 
	David Gibson <david@gibson.dropbear.id.au>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:35=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Nov 05, 2026 at 03:14:17PM -0800, Rosen Penev wrote:
> > When an asynchronous RX disable is still in progress, emac_rx_enable()
> > waits for MR0[RXI] with
> >
> >       while (!(r =3D in_be32(&p->mr0) & EMAC_MR0_RXI) && n)
> >
> > which assigns only the RXI bit to r, as & binds tighter than =3D. The
> > following write of r | EMAC_MR0_RXE then clears every other MR0 bit,
> > including TXE, and TX stays stopped until the watchdog resets the EMAC.
> >
> > This path is taken when RX is restarted after an RX descriptor error.
> >
> > Tested on a Cisco Meraki MX60.
> >
> > Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/emac/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/etherne=
t/ibm/emac/core.c
> > index 640618c0a09e..b676b286e339 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -249,7 +249,7 @@ static void emac_rx_enable(struct emac_instance *de=
v)
> >               if (unlikely(!(r & EMAC_MR0_RXI))) {
> >                       /* Wait if previous async disable is still in pro=
gress */
> >                       int n =3D dev->stop_timeout;
> > -                     while (!(r =3D in_be32(&p->mr0) & EMAC_MR0_RXI) &=
& n) {
> > +                     while (!((r =3D in_be32(&p->mr0)) & EMAC_MR0_RXI)=
 && n) {
> >                               udelay(1);
> >                               --n;
>
> This sort of code should really make use of iopoll.h
I agree. Is it appropriate for net?
>
>         Andrew
