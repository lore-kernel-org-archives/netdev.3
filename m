Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA8359A6B
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653458; cv=fail; b=j0jrXReoHVMd6SgVPDunnZlrAG7zVtBRna/z799JSOfzXvSg9wfQSHGuTtAF+hUs1OIrLGM8AQhCVWk3lO4o2r8OHOyWitcvP+Zk9a3Gw+ol8hZfEEIKQOtIOgErnnBs8QQvlyOepwNVFtJpB2MApNDtDv3gG6hdlE2sMY+TS6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653458; c=relaxed/simple;
	bh=WKn7LJUCOqqmXCqHvgyhPypEPtdtIhD0bSwun0ECrW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3huENb9BJQrSF69VB5XdSy+MjiCbHDzY7ptXX0BlIEsH7/wnnA+SDvuZV5NYmzj/i+cIYCE0O8lSrgtn7YFHFmOMGpnIKQ3Y/5HW/z+qraCXY7o0kc+v+NNVjS9V05gB9+EkGY+YYWB9NXOv6ulhga4ppFkcgJ/jS+HFHanPZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TQbIO8gx; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TQbIO8gx"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DKLPIB1518500
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:37:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=KO2aHEHBeKqMMmDolDDbPPIcrGj4c1wmA8j7J
	OmzMWI=; b=TQbIO8gxZiVy7VP4Yh6usZn1Cx/kY7yBATMdZpAg86MN0bmhF2S2h
	gRYjABH1eh7oXzOlCf8PEU5c0TQNpWiwEeh37s6RBL7+uYOzBgYPOQpnFWwVf2fd
	eXyE4O4NhslZjKTlJAhh+JbJe6D0sBjI+qbMnGg56ek9/P/umvmk2qL40uDC5eQ/
	COtSr3Tl/8CwIGzz+VLH2d+10f2J3Zxn1JdhoRBDH0WLarM7dOvxeIgamvjRzbn5
	g9xn/0CHE1rAmtnUFNvhTexF5VReEyrhCtBlxV/Uiokz/BQnyRjxf2TzdEJyOpaf
	dqqqtHmYhZ+ZYoUvIyVqcSsGMDrayxYxQ==
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g1as0c529-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:37:36 -0700 (PDT)
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c210c66672eso31195666b.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786653455; cv=none;
        d=google.com; s=arc-20260327;
        b=UNu+H+/Ku0almKRawCfE1VOUi1Gzg6jyAbb59TWf3GQ1JM2FgedAQKEpWEEfGQk7A1
         HMFJ8hIYXl/ZmFs3Is6AFlDwzKFANQp4HAF4N2eT/VzqiNDjWX5gsoaI0IvbMvCeXnMx
         u/b4Y0eXgZaUeFRTp31qJ02I/a95CbRVES8Y/RlQGWKyyKPa8yeLYdCOJH7sSneR7RHk
         BpatF3xasMFjk/dg2/sGfbFUfmsO25Eumb6pPbdVQzm6gVwVX18HPe27XnUf2F5Zy9Xa
         rk6kidkq92arW6PFakgmg3+5hRgLxJhlHaLaz0BZzezBSdH53hydtwK7JF7mCw0Vdlg5
         zgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=c/BkL2KSLj1UiiUctd+YoFQolC+h9hCfh0AtIb6XLIg=;
        fh=P/TvgljJbpQOhNJ/F0Fm9ettx9AKGvGy8NQFr5D53cg=;
        b=RZzp6qbM+XFLbxSU46fKfMeC1swLeluvyarMjNvo4QLrTfF8MSvsqU6BvV6nEupQU/
         vHqlYBj4gZzdclfEE/rpmjg9FcLpIr8/Jgtc7IhQFB3xnRJ0L1REIaB1NnY/9MI7Elyf
         UDRgOEPSCjL0lCRNUe+xjWrs3pUJYV7pb0nOEu9iIF4qFIwKGoaxfX4KZBELXbXAr56F
         VG3lSiJ1MDBWp3YNv+rUhJeO1cV0jS+OeSPuTu5JPRCq+D48fVOjr57Wf7NGYlwaDrWu
         sLdBbYygSVOHbGCVwFyJH1F+P4gRurxX9HrkD1r0FX4jQuwUS9o5h3NE4Q/Ipu+aKVKx
         2otA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653455; x=1787258255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c/BkL2KSLj1UiiUctd+YoFQolC+h9hCfh0AtIb6XLIg=;
        b=POOxr9Oup9U+Sq1lcoITDPXeAcKOZUENUpQWNBTMCcabrc5daUdZp6NKoAmuw3D+8V
         Guf4yFWUZtIJ/Q23KjQA1E+LZKy8pcNB2AmXzv19qA4DKzVBFi6gpndod3a6lOMB2nm8
         lQbFVEkFlusazAes9oXsNGUS/4tparup3GprWIqmlPBWbsnwfaubHcsEffR3ZOMVMx3t
         8aUB+ipzHD5XmE5gDEfqznwU5MqYxdYZDxZ4CSstJwXTrxTOrV41s4pAqP5NeN9N06vZ
         qeY2t0SN5N22sXLSQfWHVOFpjh6fPH5Idgep/heuaFsmZjojHajmx9RWbLIMF7hoeSLg
         jGyA==
X-Forwarded-Encrypted: i=1; AHgh+RqoP0BjNj1xGsQnvzzo5UZNcVEEG6bXpoXgly7O2Ug7jS8ZntXBdw8er9uuFRNrHReGpjQTG0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpnaeIj4tugLLS0L6BEd/DAG17w6JzTvrUqy3nQR1AWywkqXt
	AOvHqBoAXYtVTn+sytAbSRlzVBe5uDu26lHkZIgRH8BLOtk4NcCSeX0Q5hbx74v5wB7URycZ2VV
	7d879vzn64jyJ/qk9PcTThMgPxHasM2SDfWlEwxGaqpTRxwHFIBRNR9pmjkGPIUc5nwtTsZgDWo
	6gL+Q1UsAc7+1gn67ptBFviPCqHWM3mw==
X-Gm-Gg: AR+sD119EDEOpog7HEmC7uOANYzMnoqApztLHZLLYO69ETbKyw7FutcVNnR1SW73dwR
	gH7THkOM2cUEUitlSZPZgvdwd1QxqnRYoBaahWy63LDaAnRfMk2JY4glkCDxOrxYoG98S1IDRzK
	RWUXZLwJr2l9tPem7Jy2y4TmpfYvd7igyP0GDjP5xnhthzCisG5txdDw==
X-Received: by 2002:a17:906:9f8e:b0:c16:5f28:4575 with SMTP id a640c23a62f3a-c212a2664ecmr37359966b.31.1786653454859;
        Thu, 13 Aug 2026 13:37:34 -0700 (PDT)
X-Received: by 2002:a17:906:9f8e:b0:c16:5f28:4575 with SMTP id
 a640c23a62f3a-c212a2664ecmr37357866b.31.1786653454514; Thu, 13 Aug 2026
 13:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813193416.1544518-1-weibunny.kernel@gmail.com> <522517bd-869c-442d-81c8-c0236563a925@gmail.com>
In-Reply-To: <522517bd-869c-442d-81c8-c0236563a925@gmail.com>
From: Wei Wang <weibunny@meta.com>
Date: Thu, 13 Aug 2026 13:37:23 -0700
X-Gm-Features: AUfX_myKHvwnx_wx4xdnb6f7wSncaRXt8qrBEwYu7i2TduFX_kyDziGu1E5NR1g
Message-ID: <CADe0Y=sQ0e=snxJBd6kBz08eYR4BrX_9Xbr=XEHGVcXzybfQow@mail.gmail.com>
Subject: Re: [PATCH net] psp: use unrcu_pointer() for the cmpxchg() on netdev psp_dev
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Wei Wang <weibunny.kernel@gmail.com>, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Wang <weibunny@fb.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE1MCBTYWx0ZWRfXzmsQtfwet1Ea
 d3/1BsR+7U4zfqgj+BINMO8l/RzZ1fnRxfSuDKJ3beZpuFV73w4ZdUoEb7ds2mDwrVlY8ATFQw+
 N9LEGl67rMVOHoegOQZEcNhQDS3BJhQ=
X-Authority-Analysis: v=2.4 cv=GvVyPE1C c=1 sm=1 tr=0 ts=6a7e2b10 cx=c_pps
 a=jJvPsHQLKLf2UdvVr97r4g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=FOH2dFAWAAAA:8
 a=6MU5JDbc5_lXVzBpxg0A:9 a=QEXdDO2ut3YA:10 a=q7aydO1c4wibL4nb3gNS:22
X-Proofpoint-GUID: 7nPeXmoJQdex05LO1C7qRSX_z-tQNC1G
X-Proofpoint-ORIG-GUID: 7nPeXmoJQdex05LO1C7qRSX_z-tQNC1G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE1MCBTYWx0ZWRfX5UzXfl8wlesH
 P2Yhwtuz9YmFJHx1h/bVUeh0l6AYLx3D48GcKww9C9ZaYlVyEnRWbnrTSGL0FMcxnpkywhijlhw
 H4YSu2WSui7VxOhPRfJLVKlcFTezwjE3O81VlBIe0YO46cpnCe8DeeSAKjQbeqs1R2N4qX2ARXw
 jR93WC3V+ZDPEf5zdbKvESAMmd0/eBts/FGWiONpIpPEcqHyGbq1wYuRKkLDMkCKsN1rnDKzTfl
 Gyt/qdIzIfvpoZbMjQLfkOfALSl3OktxBxPdeIJ223IAnwyboeEk2+545TdsEXJoYyv91RRyzZb
 hr3UH2IaIt9zG4p9yL/rN0t48XgPa474Q/ztxLCCeiK7v6WY9OBWeAHuPR5hcZyZbbD464Ysdk6
 qSO8+eV435tcyRyFICPH79xCMuxI9Ve3d2zciiCbPp3Ppy3E22Cb4NxH+/XRNa998qsDwALqG6l
 4h+U739dnCO+/5rTKGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_06,2026-08-12_01,2025-10-01_01

On Thu, Aug 13, 2026 at 12:57=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.c=
om> wrote:
>
> >
>
>
> On 8/13/26 3:34 PM, Wei Wang wrote:
> > From: Wei Wang <weibunny@fb.com>
> >
> > sparse reports:
> >
> >    net/psp/psp_nl.c:513:13: sparse: sparse: cast removes address space
> >    '__rcu' of expression
> >
> > cmpxchg() returns typeof(*ptr) and its internal casts strip the __rcu
> > annotation. Wrap it in unrcu_pointer(), the documented way to use an
> > __rcu pointer with xchg() and friends.
> >
> > This was introduced by commit 06c2dce2d0f6 ("psp: add new netlink cmd
> > for dev-assoc and dev-disassoc").
> >
> > No functional change intended.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202608080910.l9KvOH7O-lkp=
@intel.com/
> > Signed-off-by: Wei Wang <weibunny@fb.com>
> Commits targeting the net tree need a fixes tag.

This is a sparse warning fix, my understanding is that it's not a
functional fix and therefore should not use a Fixes tag. Please let me
know if my understanding is wrong.
