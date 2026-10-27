Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793088287;
	b=tR5qAjXCXHDHr9vQj+UtvIUUfwFz6lWLGFX+Folq3JYlrD8HdxYUqKQINvdHFwzK1NQW
	 oRWDYUdPAYsYHLkIj/Y/r44OjpduzsS0BMzemgq4MMf0pseipU2C+W1T0npKMGIxissqS
	 bwMGAZeRDZY/d4S5ynENbeD3sXQQa92HUINHaOjiYUTARw79KSChPk9pgpPrzQbyheDyR
	 9E7N2UFT0n3Rx5TlFywmQB4WyN6TNEtFSHQTzBj6MvP/oenvXw9+ns39ouIlNCvj7qhth
	 5dVtvDJXjF0GRZEu1ESovST6R/vHmZFjeuC/386aKauwxVI8YOL+dtMZTWaBxdqw2Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
	b=Wfh6W6g4s9CAzWSuHYBuhVSotFtg0WI1XDWb10NV497inTvT/ridhIWIoLmSc/9k3KGo
	 JU2We2Uxw2tREMOh2QWt3f5Bjw3yT0LA8e/6QSLE8Upl4CnsPwLdza8DJkUTH2pk9rCnI
	 PgKm8UiaFixgHwRY/fFivt9BxMEv/Vd71aE7V/zaW4fO9IawkpUKcmNb25cPfS7HvcDq6
	 c0nr62pNiV+vHNQ20JiZ97kGhIBHyi8TCVHd9c8C2TMPGKtb0N1otGA/lf5zrrYi6YCWh
	 1PvLV+nRdGNeB3gF0KVZrttzBvM9z/UVlGWBHCMy8NdIV/kt5nQ4ekTMEpgLHa2AZgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qGblQpZU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF63606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF63606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qGblQpZU
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89ff475a152so1532800b3a.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793088286; cv=none;
        d=google.com; s=arc-20260327;
        b=kMFVW6I/MbqNFNIX91cX5PpETssATSjjVA8zm2vxps6dHbslIzsVljreVD7gbyB1ns
         YnZvWmNHxy8680E8rJ5OHy0yqZLHKWmGKd6hFpR9i4DX3AB/pjlpmee3d5tw1Yp88kcy
         uifAPsaraUQLSGoSYi/TOBhHrFQ91dyUaZaWDVf/sNxFwdmi+UJhF+tsTvwX7R4va3KM
         aZLax7/SExdJZT8j5sNq1zKvFXwvGDRSvGgHXE4xSVBAxgYBiDko32lN+9L0OPaxairK
         wMKoGT4ZkVYhrvlOkkTJfb1pcjxMHtzbF7FLoqCSntkWSdUR5QHB22G6vnIMDfjD9om5
         iY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
        fh=Ms9g5nx9w4wLHe4Yb02yQSoYYlyg9yN+L2P2tt6pZpg=;
        b=XTKrQdExaDmHa2s4EEu6L5Uji8zoQgvoJ9WgG74xyuuDEqUQV6pF3ckORyNJPqpLWZ
         RKpv9K4JTooPhDKMkr0CWRJ6Na0CoD0iF+tQXiF+rSPwNvC3n/eCazpxowrdyIaVxKd0
         9Ohj9TmafVqk93dBR9jh2oPM59akm7EZUZBQMyUceeoGg+xwdn4Daiw2e8Tr1qSxowHU
         B00KxTKmYd4SBsX3VLe9ZakwTfsxiHeBTavk18CkcuGOxRxczgGg/+FI/xdlKb1+qquJ
         6dWyDOpUVnLh5ipETuhdWHYlTV/qV7TBjCv3qkhLkiiXyTR76e4ru6BJmzbn9QAhm3+t
         TRIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793088286; x=1793693086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
        b=qGblQpZU/vrwCydehnxMnDAmePPsneRZLdrxFgVhU0KJNNc/ur0T4HlIONfSW+soiN
         ij0UawoILbPi9RdwxfM9m/CMsScsBMIo2VpHhep5HJGSYlYILb/d3v4Q/6fImx4Hl0P7
         tipPmp6XYYVDS3m6L/bMiwivv9R2gjt2bYaDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793088286; x=1793693086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
        b=bUg4xVVaRjOPeTMo+yYXPx9LPaHuP+P7lq/PxIgJOlxvigwMEf5gHseRbbIWPnrDg/
         vzJHvshiYvWML4ZZ+B67k5Eba6xf6XkmAPIUlvN5uKfkeRSuadjAG/sFr1kumb3bupNm
         vR2HtbNCadjWwedqXwPoGBqq84ypDyjsUTvNkXLLF5yr8Fd0rIrRHTUDDrek1yb9SdG2
         SX4y70N3pA+DvI/tGJT878fv0of7YnLANkDLKNMZQp3RyQ8Y9L+fmbVwXSVQCPkHpYt7
         5viTeoWjHMwYEAcXskH6qOsqkyqIzKg+fwc0XaCXGAzQZ+LVZAjyTkdefHvyLTy6ZcsA
         ARKg==
X-Forwarded-Encrypted: i=1; AKwUvBzIS4eyu9P6LbJk7/m58fvxv0/iUulT/5XdYAgJgFDecL7QQWrWvFTXfHeU96uS3RiSiNEquCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7ERnkjBZsi2i+ah4kpVUgdq8XUcnolxhX5Oxdh5QeZn00Ytzg
	OIU9nLni6RWIw8OSj1LU40FBvPoZM2DcdYuyhbJSsmD7J2SpAzA/wLEw1oNAThhjbiTRDJgTW6E
	rC2MW8wAeJEKBDJisysnYKI9cAN0UzUE8xbvv5+Ss
X-Gm-Gg: AYBFou0g+iWw96mBB5ZPK9oRfQx5y2+PdQcsI0Q+4TJuavEPOz3VfcZVT80d/2kZA0L
	zzzccWp0gR6RCzkce9Pz84BkkYHoGXF0Pre1ot+t6zEAZKC313tfxBhWCzTV+Is1Hnqh00Ci421
	EaftgJjSgtSWKDYTg73U3iRG4pR5u0fRrvXrJ1B20/+tbPi2Nrc/53frz9c4WKlvtb1AANmyQfS
	2frGjZjAH47qkmQWu622w4Kr501nCeU7xf00WyfKk80fX7zelRztgUsfJgY0Z3pSDU1nf55Y9L8
	G0927V/rGx97LBdTq9z3+J9x5tdbunDA/uCf2Zx5hMfUVWHkvVA5ILMpncwdgSPDu07qQo7oswL
	UxeFVp81G3bnHyRyEp/Yy6fnD7fstAiNeLQra28NiuQ61U+XqYcNXx9zQ54I0fExTJeiXQnNESE
	5/kESYCrkDu/vXISI=
X-Received: by 2002:a05:6a00:21d5:b0:89f:3c81:e733 with SMTP id
 d2e1a72fcca58-8a3684d2be6mr6451664b3a.25.1793088286278; Tue, 27 Oct 2026
 01:04:46 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org> <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
 <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
In-Reply-To: <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 04:04:34 -0400
X-Gm-Features: AclHuK840k9irP3d1n36aWH39cgcyPna2KxP6UOHD5J1yZKTog1Eti3xiI9sJ0U
Message-ID: <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > > This is an AI-generated review of your patch. The human sending t=
his
> > > > > email says "Hi Jamal, passing this on for your consideration as i=
t
> > > > > seems to have got stuck somewhere."
> > > >
> > > > There was nothing wrong with the headers this time - so not sure wh=
at
> > > > is going on. A bit frustrating.
> > >
> > > It is frustrating, you are the only one with these issues.
> > > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> > >
> >
> > Let me send a repost3 - will take the opportunity to pedantically fix
> > the commit message (no code change).
>
> BTW, checking i see the threading was:
>      0/2 cover  (root)
>        1/2      (reply to 0/2)
>          2/2    (reply to 1/2)
>
> I checked other postings that didnt have issues and it was fine. I
> also found the approach
>    0/2 cover  (root)
>        1/2      (reply to 0/2)
>         2/2    (reply to 0/2)
>

And for repost3:
- 0/2 (root)
     1/2  In-Reply-To/References: 0/2
     2/2  In-Reply-To: 1/2; References: 0/2 + 1/2

I am sticking to this approach going forward.

cheers,
jamal
