Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB843CE6D
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448252; cv=pass; b=YgfCX42tUxLs29eE7BbFXpubNTLUTmF0VWFJIv2M3nX70kQGpKLyKlgrwCwa0uKYknbcYUvkf3jFjhSVId9yui4frEsk2Jy2HjDBkCnDvb7I0qVKpw2Hfnd0jcVNTlc5XkolPoQpFZYy3kBXFjiB76TLk+09Jb97pm6pk/nSxkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448252; c=relaxed/simple;
	bh=gpuZODGzj68Y84eTLk6uQfkMqrQHsTooID37VgaUIfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uk38J9dLAmdYiQSnoeEUcxtLDofYr580TuYjkH46KXGa9/zbzpUq1alfRsQnLVbxn8oVx7P53mC2FMocAaWnqCWXGMlnH3vDBxdWq+GEoyXgy2r1ay07xgpDuoD4MX51fqr7Jf+UEnPRUo4cBqV4OGixn2h8kCpNYyyo9OWrKNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbl+BHnU; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbl+BHnU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e8fa1b8d6so38805877b3.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 04:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786448250; cv=none;
        d=google.com; s=arc-20260327;
        b=A8JMHRzwgd+/KsKwkWwmfKy0RIRcavQur5DKyqqKeFVDlckgp2GER/2X1S1eKqUjpQ
         1q+T4PQ0RguRdpKKax0RHRpBldj/zT5pjfP+6aAIp5bSmiM9EpKRNZTNsq4fT5HZSO02
         jPoaZRVjry6YmNPhqCxznvApcxHemwunaUiTLLikaYDNYlUCWK5JJbK0RICdFOxomvvx
         oixD+dy0ifl6n4F/09VJ3mKroqfBTbe1yC6WeE/0tVEGYJKPBXIXWiIms9VD17itH8Ph
         lFmyzgl+NGfliWGEWC8Q12qe5MHOT027eZ3OaKNJ7IYLMBE3mxH36cdnqImXRvHyZneJ
         QdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02wA3GNr7vAUbL7lTzE1Bgm13rZFC+V6O8LJD+mzFT8=;
        fh=2zcy4DtAGJdTO5oqkak01pv+IqH87tKqZzYddCbP1Qk=;
        b=Rq5Bq8GRK2RJDtpYA0O5f5mQcRUTJ9tyN2n79Y1fXsYlyKfgHq2b4YIVhZK/E/YsDk
         /sqXo9NtWTvv2snlTpkij++37udvzGI6i/wYLo8NY+IzNPLio2iryniDrzDfvaWSKlp0
         HyBdYzxaluWkMq+fU9IEvj9YvIdyF9m5tkIqvr2U0B0C6PPxggwPjhe+MZdYTdf3BVQY
         ZSj2vfvS2oooB8BB417j3wtPP9S0zsE+l67MP9Q3RjJ6Pb1FLqxX4Nqzjj/M30t6XHMA
         STcXvx4MbtRM+yRDQxF6Q6svDltUB4tZSCnguPhQyvVJfXx9jDBPuv9k7RPGxeLgNvTV
         SmvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786448250; x=1787053050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02wA3GNr7vAUbL7lTzE1Bgm13rZFC+V6O8LJD+mzFT8=;
        b=Bbl+BHnUxmtUWv9+zlr8JdnyA5CY+o9iFiCEMdZaNDLHIFZf61jIFbJhpP60cOtmi4
         4HpHI4A8xcV3KD94rPzuanhGbpsBmbCIcXmIpVpK43OLJCySLNWOW6s8wu8IlZFcp9GE
         S3ZdTn/V9kMSvAkrlZMmbT63G/BDIcnoo4c53yUtP11lHERi/phjqvDmt1guB4QZXBic
         xoNuzdtO+dERrRG8bxWBzEOHsIeF2I+6Od9fRWmHIUr+zWpK4fkpv2A0HOchA8SGyxBQ
         NW6FoO5I0SW4Q4crdTx5MW+kZv4sI7gamVR78N/bj+Kzn6OjnoUgUGSLEwsqQHUOSFmd
         U1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448250; x=1787053050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02wA3GNr7vAUbL7lTzE1Bgm13rZFC+V6O8LJD+mzFT8=;
        b=Z0CKP68J3VMEj7HkkIpjMn+YPyZkrOAhC1gEH2RRj81VQQkT3EnTbKbi90xVz10ns2
         vwGihS7wv2rpyE53yWqaH6gJDDb7NbFEDGEFaiQxuYn3j/GWt1uK6yWJCDPPFxmUXKsW
         anMXyPGZSaiYnc5h3kPnZuAjNUiVPN1kA2Hw0S/Sg00DP5u1Z5bwqAZXIYPb4IpH4YLL
         /jdak0q1qTewf4MGY6sGQlzUUHAmRLkxacb2CXqyesWuM4uOfjkWYtyeieO/X2o+9UFh
         mmgQFUnWUON+9LAxFkiGZwYWAvtGTVj2R6JPB5NVQ7tJiWlR0HgPDrlQFW2+svszzRz7
         qm4A==
X-Forwarded-Encrypted: i=1; AHgh+Rp3VF+EDXckePv4WgSMbViurfvPaAEUHDzYSNDeZXGBFUwqBu2CUJKdjtdHOdrUQGLiOcrfuyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCs+h6mPgfu0q/Ye3ffszRF6FTuvgjjIWjzsrq5SfRAz9Y+2O9
	sxpLN2dmbAPjk/J8Yr/nrIe4wLq9DEXrt28wGQ1tfdRiZ9y0rzh1fxbQ5IlB6bR/V5FlM92IPpO
	XzxVLibe3pBSXGFFQFojJHVp4lcrGn+E=
X-Gm-Gg: AR+sD10/pIOdlDfCuDEd5LyBbSTb7QEA5/kvNBKsk5O+6oYoh6GYkpx4t9eFiwI1FCb
	+nXK5HEtFuVz7bxNPAcaCxWM3sp2LL+wf+COumWxXg6JF+h/3//c9ptfWlV6ZFKgteav0X2ObOU
	8KxWDstJo6AHmtlMbHarc/d1axVBy9G97NJP8Fb59bOHQxZC0SQEy5Qd7B2QWKYkiLgggZihak3
	+YjXAg9crw54+JdVRZik4soZNOrLlzrg28MVHZmw8TdJrW8Ry+xa3mTOk64YEqZDsa1LmkXJvTr
	Vl9psd2colPWAoojjUm6v5CO6/yu+YtXaUWGAet1grBG
X-Received: by 2002:a05:690c:630c:b0:814:7a54:3a93 with SMTP id
 00721157ae682-82f2ceefb77mr17793617b3.23.1786448249594; Tue, 11 Aug 2026
 04:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANE+tVp8_NhE+KL6ZNPGjaGMLPxrCWw_A5sY0jotrvThB6idXg@mail.gmail.com>
 <anr3YZJrnS_2RbEp@strlen.de> <CANE+tVr69qqyreBbWWk_2FqpMfQAqde-JF=weECditGJF=uZ3g@mail.gmail.com>
 <anr-MVb8okTwL1X2@strlen.de> <CANE+tVqc+NNN8EfpK+cEYV63Pmn3OHS81PBAGqB1RHidraChLw@mail.gmail.com>
 <ansISMIJIOfIUrAA@strlen.de>
In-Reply-To: <ansISMIJIOfIUrAA@strlen.de>
From: Wei Fang <void0red@gmail.com>
Date: Tue, 11 Aug 2026 19:37:15 +0800
X-Gm-Features: AUfX_mwteNvpOL0nmjT_bwBHdao2sjOLME1eLVUy0NIXXnKZXOzimnkR0H5Sxdw
Message-ID: <CANE+tVoK9apuFYNpm13tUHU6TvtNgdNi-GkYg03B6gOPHVaRUQ@mail.gmail.com>
Subject: Re: [nf_tables] pipapo: inserting an interval that strictly contains
 an existing one is accepted; rbtree rejects the same insert
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, k.chen@smail.nju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood - thanks for the detailed explanations.

Best regards,


On Tue, Aug 11, 2026 at 7:32=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Wei Fang <void0red@gmail.com> wrote:
> > The report is about inserting a *new interval that strictly
> > contains an existing one*.  On a pipapo set: first insert
> > [1.1.1.1..1.1.1.11), then insert [1.1.1.0..1.1.1.12).
> > On the kernel under test:
>
> There is currently no way to detect this is in an efficient
> manner.
>
> Kernel would have to lookup all combinations of
> 1.1.1.0..1.1.1.12: 1.1.1.1, 1.1.1.2, 1.1.1.3, ...
>
> It checks start and end key only.
