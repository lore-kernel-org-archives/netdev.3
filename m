Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792832387;
	b=L4jGU53roTlbEaFFlfeJA1j1y/cUyoBTq9xcMPOsjmEPZCdOWwWWFvmjxj2xpBlRfh37
	 cNbQCvn1ZhPRjRgW9I7k5sdmSujc3UywStk/u47pjwSRT1UTu7sjJ2AdHa9ozl1evIW9K
	 LNgEBykinIn+2rHDMeMvQeXTjsSR1oLPcO40RvlLspNz/r+4HPpj9Rq3w1je1RAZE5Vmp
	 /+LfyTLGUy8bxJwjwsD1PofiLjMp4MUo14BV7llvjScSyR4vccoANUF0ET4FsX8BBvKWp
	 pDR/5U2mNh8L3FRSx3xtMmfM462S55HS/XEsMw/Qyk092KNor9qCxbuLcO53Q4U6+5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792832387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Aj0ctnHyFlf1mrEf1OjyH+Yd3MT+vDq9LG+nCIJwa/k=;
	b=ZBiS11o9JCjvqvOEI1qioL2599mW0QMSnMJa1lePtD/xgtVI4Q8l6sUDK+OhyzuuOiK3
	 r9c6spUnfZRpVMju83v5PkubZeCxojO02koXhRKw1cZRaPIkPm3Tbbi+/VV9ed57Rhx/E
	 V0ZVnaurfPCZKgIYXqLhnX4p5dxFuhh8sm+SCyQv35iePOlzWXps21hX98jw+lP9ZVZsc
	 G4qEJr/QzvLAPpyyruZOq20Dtd0PxaRiiKl5GB6jvsKG6u0+AVBIQo6Q5ubkz5EF7Ye5A
	 eVFoACBm8geu26M106XQF9FT4CGpMs15O46tpvaxPeQcMfCiEe6/lUEw7j9mDSQq7DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HryVdwJ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418D606A320
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2418D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HryVdwJ9
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so1413065e87.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 01:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792832385; cv=none;
        d=google.com; s=arc-20260327;
        b=qYO1MhbYraUfKwrKKVTcGpsC3F6DNBiy+ykyl7yloy7ANBSR3bGrFeJc6/jDhm6n0s
         Jkf9W6dDjnh/LAE5CgCEgG+yCtifN7juY3XUFlo7mSsw2AFa7cIVnW/NOyDTUCZ6gTii
         aDC5gmtx+CHQkcjqdM9isgDTC6FZCR7yob5uPhN6gg7whNnq6V0UETWSPTJAdE0BGrqP
         OBmZXv6Yv5wcYTgVgVppjxCGUtnMG2wLFrJzxB4aT3xM8FkU2vGIOlIX37VQmENk9TuH
         ihchMENHicQPc9OI5docmU/tSC5P1HJ7ijo2KWTabVMiMzMN2QWqDKdMAzVMu1AY3DwQ
         C9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aj0ctnHyFlf1mrEf1OjyH+Yd3MT+vDq9LG+nCIJwa/k=;
        fh=hHQVLkNDBO4bXovTWlmlzzoRVkvZZRdzeSPIESSgiw0=;
        b=dPnYIArVPZ+dxaMwC21VUFgX/Akhe0q+1hg686OWwWoRIr3fBgORqlr9xqoirPLnMP
         j+bEqowNWNb/ms7sxF6enANj8G1vIdsKbF5rEMpiunCHQUblsH5za6TCDM4DcbBY4kRg
         FR8+JFx2h4qCjEP8EE7mQnCC1UwpE7/r+yLuC2fxmxerX6PttrktUE2UHc+8+YdKYuNR
         kjKjzxI0NPTgiMaToZ4t+rD9pjrddO+8Bl63iV5yoFdsxbjbsm3LHNkZFkFFIn9RF9nK
         OhQy2ELKtnac14DZlZuANIPIzSUMv4pZTPoB+27wRLjXWvkTaJtL3yHs6tvZpCpOg+W7
         Rgkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792832385; x=1793437185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aj0ctnHyFlf1mrEf1OjyH+Yd3MT+vDq9LG+nCIJwa/k=;
        b=HryVdwJ9UjqgrA63j3oc0URaeYN1fc+ksrJnQ2sOjPDyag5GoDogMEjGAjMepyEnIR
         KwoUBoJFPVW3fA2H2Y2DClOcO+k/OEC11bW3sv/YIXyjP0dWLvhxSD0GZqpYKM2ywnqw
         QF401ClIonbPT4sQRRl1oRBQs6qWfQFhn2lkkRo8YikCjHD/3UyIYMqpYBzSVCE7xujg
         N1HoHC8YmUWjPdWwuIExqlJT6EwhCRUFYX+7p6V5Y7GadcR3cTJsBpBWd5iVxvINzXis
         8as3barP5BJfa4mayr5y67ED2pVAcNeu9FRzaf9dj522DcC7JN6PQT5eYfk0mJGrB73R
         oQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792832385; x=1793437185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aj0ctnHyFlf1mrEf1OjyH+Yd3MT+vDq9LG+nCIJwa/k=;
        b=1JphM0fcTQks8PfPyX8gsJltaaBNaNX6emBwO5JlR09e3bxLNBOOG8eBuP7H6heDKf
         IM4spPB/xXHYQ27d/HQq9z1+Kcab+HEGRTwcGIF5IGBx/MccDS88hqMshaVNB3NMiLyY
         6OVeWEfRf8o5diu0xWTfa/IQbDXAqWevBwcL8ojV196qWTtFOXtdOhE3usJRkPFvExwb
         OlFNT+zIqJXtkhIKUFW8z8GDc0LV0H+OzzxS0BZKrcaZ5tQ/pkSFLtDbrMIUQyBa36lV
         IP1w1aAzkK1pAEwB84FHNUyEDeRX5fYF17wd/5LlP1FJb/YKIbKwL4L5cDN80Qv0D51e
         bzWA==
X-Forwarded-Encrypted: i=1; AKwUvBz89GkzD/jmsdRtDfNCgy7h8wV3InNIOKL/hwi5oCHB7TcumEaz8XiDT1kbSy8yltthMxSGJq8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGDfyvh+1XkFSOv2N5SiLje1m0Z4i7HCy3sPFMGNeQ27hXxZb2
	j5LrJNVkiRF9j2XHLZeOUmd7A587vv43lJ6p+Eyl0aIkrqm7WQxvR8IUuIsgdKcGTO3O3BivtDl
	tZOPE9Cd7kKSB7oWzo6gOsudiD5sFXG5TiQl3
X-Gm-Gg: AYBFou2gRxSELIFq03PfGD/iaeux9hdu7XG8DHxfGrXMe5KftwdXyBUlV4X4pwy0Snv
	wauldAxd9pKGgAXaopAxiYE9S/dlbiQ7bK2bJsc6HLeHSDhgVrNVZ2a5n0hRvi6IcwF44JXwXTQ
	9/iX8ny2PR0DOXkkEllF+7SvkMsP2dlf03SfRojYYuvZqxG3BEAscfp7bZcGKjJXd3ziY95jG7N
	pBPmj4OSQpocLpJi8x7EzEPGJb6B9AfIZqid735XUrjgiqeShEufHEPCpr20e8aTprBs3QmqGs+
	1Wr8kwI6ijnmkqxUf88e2qECUESw7TlrEm9HEAMUCRoDwjAW8AFwsQkLO4XwEwfEzIbe7Jtkp3O
	SXOaKPhs1Ioel2mRoVI+8wwJUeMmEk6M2GnMWpV6h5/9memDVJx2Vme/PuAdmRh4GOmPrZO9Q4+
	Mq5XLT9UMDRdGEBoo5eTBbdHvtoE2nV6gphiIrP4n5AsLrie1Rm08=
X-Received: by 2002:a05:6512:3d93:b0:5be:590e:ea76 with SMTP id
 2adb3069b0e04-5bfb716f1e0mr512993e87.6.1792832384863; Sat, 24 Oct 2026
 01:59:44 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023114228.289161-1-jiayuan.chen@linux.dev>
 <20261023123102.3c30d01e@kernel.org> <607851eb-e42b-46bc-928f-91db542fa9c0@gmx.net>
 <20261023130812.1ba2462a@kernel.org>
In-Reply-To: <20261023130812.1ba2462a@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 24 Oct 2026 16:59:06 +0800
X-Gm-Features: AclHuK9POySI0ZvG5OMlRTW3dRxVhJhD2MB57P6NTNTOjlC8Nr_YYcS9vVabIjg
Message-ID: <CAL+tcoBiuu3f+XDkg1a+oZPgPfBYHbJEKYd4MKFv20Ma668ANA@mail.gmail.com>
Subject: Re: [PATCH net] net: reject dev_weight products that overflow int
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthias Tafelmeier <matthias.tafelmeier@gmx.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 4:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 23 Oct 2026 21:32:40 +0200 Matthias Tafelmeier wrote:
> > On 10/23/26 21:31, Jakub Kicinski wrote:
> > > On Fri, 23 Oct 2026 19:42:25 +0800 Jiayuan Chen wrote:
> > >> proc_do_dev_weight() sets the backlog NAPI weight and the qdisc quot=
a
> > >> to dev_weight * dev_weight_rx_bias and dev_weight * dev_weight_tx_bi=
as.
> > >> The three sysctls only have a lower bound of 1, so the products can
> > >> overflow int and end up <=3D 0, e.g. dev_weight=3D65536 and
> > >> dev_weight_rx_bias=3D65536 give a backlog weight of 0.
> > > Not sure anyone uses these, maybe we could cap them?
> > > 1k for dev weight 8 for bias?
> >
> > Capping does not make sense to me.
>
> Please don't email people off list.
>
> What are the values you know of being used in production?

I'm not Matthias. Revisiting my past experience doing AI tuning stuff
in the testbed/real workload, I once saw performance improvements when
I played with this weight and the driver weight. But I didn't manage
to see the deeper underlying reason for that scenario, which means I
was unable to replicate the methodology to another scenario. Maybe
it's a good candidate for blind AI tuning...

With that, I think capping at 1000 is fine by me.

Thanks,
Jason
