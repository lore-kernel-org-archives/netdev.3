Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE736215D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728465; cv=fail; b=J9PCXcbrrBIdm69Np8dFg1GP+zrKvMIG/PqN8U1up6GCNgccGPWl7G6UkIEjwjphcN+a/iiLcwoSfyJwuB4Tk47CdpU/R18jFSVKvrrfcnw0qcGeXoFvO6zCpPMXxSJC/oyds2DvO4zCmfJ9c6+fSe7WvfGv7Q5BtCwYTPoROPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728465; c=relaxed/simple;
	bh=Xb4C+0Y2b7e+5CwGYrBkAgB97i6y/2skUYJllHGvSt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkieNjOKhnzDv3/hCB7WUZWgV7AQhtOdVsa8MdFsxhWck0k+HvwBrbvc9TB4s36lhBxRNcqaw1pDOvm64sjN1aiKBHTvIwWzDl89OlqxSqOECgA58B8OesjCopZEYDh+cqC0chCCbdtBat24gUQ7m6LoZOpsfGKJ/oaG2BRuYdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NhUPELYA; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NhUPELYA"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EGj99x930180
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:27:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Xb4C+0Y2b7e+5CwGYrBkAgB97i6y/2skUYJll
	HGvSt8=; b=NhUPELYAR76RX/s9DFcZMbhmCa3L5wJNjSaWQVvsl01yL9nYWtg/s
	Dbq00FThnpI2qcwMJlNVnDbcMhBpUNTYS6uEbk+tluQ91xQYNnZW2JCTx/9k+isE
	FN1kU6RqrpFFhcr48U5YWTf8Bt+avWeQdU2MZrdtNp925i3Lnbk66x36nH+ulfPl
	gbqfChIgslHXbaQBG6q5SLZqNF177mkJzKFXUy6jyLePgg9MPxxuk/EQpegesbgs
	P4DGlllVoQ5AIXavOmv+J7LeeAyX7Yj4XaL8RpWmjb5gYOyhKAnkiZxhT3aKFLc8
	LHh1vA9AkXGmbBVbDV5xJanVOoVWGvWkw==
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g1qv0vs90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:27:42 -0700 (PDT)
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1670dd0f5dso97627466b.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786728461; cv=none;
        d=google.com; s=arc-20260327;
        b=O+ParUG96CsDgU4ePRh4O8W9V7pClN3XsPQGAMbBCDo7rB7PFCd5l0Sg5fIVrORMR/
         h3LPzeK4gxNsvHKkjIITeEaKpRnKkZ534xZABv6jRBAFicBVL4S+k3UOczmbWIKVxcfO
         iX51iUcLrBxbPCI7/YHZwO5rI93bc2O6VM7HBhmXZj8kpegak4tXI49YTkwJ/POd0HUh
         uhmJDzgNV9qPlqJ4xgRuOMjkv3Z9oeSGyq9emwBZJIkl8qASR5Pk/7f6yQYVGQ56INSL
         mypw3ktX5gU+/x/K33mjBqOrZUUDHiVxsWBDiLXbIy4OEWNar0+h6ByePh99U+SI5jkb
         ywMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=o+k8j4y/VnaR5FmBoDiT4iEaRYOHIsUYmXgpu7xbQdg=;
        fh=qAPK0rsEtS1b7+EmU3NbLpcsXJMJO267Z/SyCXqOPoc=;
        b=U7KeNXh21jRgA3v0gp1KxV8NtML8SgpHeTh0U8hwd68jnYQxRJtYM3TMkQKs3K8Cyx
         fqc8oUFTH5mMnUo3e2tP+CHoj+P9yS04vz7ZRpuuH70uA7WNt/HDbCEOeM3f7Ume/hBn
         PB0IeIwTOlR92Y4HoK95SuXBEViqlpBFaPLg9NEQK0M36B9WQFqe5fg/OpRQUd+33Ybt
         t/HOnULBbf4tuJ/kvWCbABYC5nrvEtmUljhMqQDaz5xCv3EPWUqJ2a7iUV+NhBafW4hU
         QjRCdj6WXa9MsJ8HaKxKmMJtX9jZmol040o1sWF4G3Y/0mDAeYo63MNKLR9SPDGAT9rU
         gciQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786728461; x=1787333261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+k8j4y/VnaR5FmBoDiT4iEaRYOHIsUYmXgpu7xbQdg=;
        b=AgB6HTA6OHyvzZkSpaEPw9D3mNGdHi7iTpEpLpnNxLivn9bTxbla8b2+aW79ujiow9
         VDtC6SUKB8uVv5kv36u4qO8UG3UWgJk7Ns7wPsiRd0WLpDcs5MR0P7C+3f3QzCPAHVHO
         k9KSwm5WD1IQGISoHjyBFsS9/M5Bv/o98orRW50E9isEYwF+YAKD2f4XyQkMw4fegETc
         KR61HNUSKxrPxlMoNEHLSSvDOXuVPpRre3XmyDpRTPlQhlLD03VsPvQniRgcicn+fcAQ
         vU+KVSyju9DyW0M6isbxbjqiglKmC2/r4tpwu5d0Z7n9WDDdHBhQJ5h+r0ncRKHYUvA+
         p7Kg==
X-Forwarded-Encrypted: i=1; AHgh+RoAUEHS/TBQOx6BfAdp4MHzc0ag9LeaLY9iY/A1WYfbPvYRGQ2Mzl6YEdWHy8EErxW++vwuxoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfT+HXxP0C2RFrqa8BN/3NTVsYvOAi07FhaIVUNc0wHmSXZLiu
	RhYnEGvvfcW7ey54RfBbt7acSDrr8/9omcD6t9Lk0Nn8qoaxlXJTpY7rtWSEaavVVOWj6errb4Z
	S519cISVWps60FOjf9ij8PFu84mfcX9pBBl+L9ux9Bu8PM6sf9r+VjI3vWHYkTNb4UZKfP/CIg8
	dSGSy6cWStv6uDMVHM0wObWHRavWZBJQ==
X-Gm-Gg: AR+sD100c/wXplAsmObkamRYkOpiEaFWsaivb9L/MRZxVBZitlIJJnQQD5gTFUauRPg
	gP6ibWdM+OIH6XRHZC4zG+JrUZgw0kGeRnS0vjLxQKpaIH/5GnLU/0h+Qpvm18vpEMds/pSjQmw
	efhNcvOV790MrJcz5VQ99bDpnLsTerNNPwqX04eHT5KdIKvYOwmKLqE311GYykkV4WgHR4AQs=
X-Received: by 2002:a17:907:3ea7:b0:c20:edda:ef5b with SMTP id a640c23a62f3a-c212a08f8famr306320066b.14.1786728460773;
        Fri, 14 Aug 2026 10:27:40 -0700 (PDT)
X-Received: by 2002:a17:907:3ea7:b0:c20:edda:ef5b with SMTP id
 a640c23a62f3a-c212a08f8famr306317166b.14.1786728460336; Fri, 14 Aug 2026
 10:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813193416.1544518-1-weibunny.kernel@gmail.com>
 <522517bd-869c-442d-81c8-c0236563a925@gmail.com> <CADe0Y=sQ0e=snxJBd6kBz08eYR4BrX_9Xbr=XEHGVcXzybfQow@mail.gmail.com>
 <20260814100732.542308e1@kernel.org>
In-Reply-To: <20260814100732.542308e1@kernel.org>
From: Wei Wang <weibunny@meta.com>
Date: Fri, 14 Aug 2026 10:27:28 -0700
X-Gm-Features: AUfX_mxPGHlKz8-5yLCPA5TgJjQIlKwLHH0F71ohWGdEqvi32Z041hdQ7OVkUdE
Message-ID: <CADe0Y=tcrzLrD3ORJo+bhBGnPdL34zfgjORMc4vftENYDiHnFQ@mail.gmail.com>
Subject: Re: [PATCH net] psp: use unrcu_pointer() for the cmpxchg() on netdev psp_dev
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>,
        Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Wang <weibunny@fb.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzNCBTYWx0ZWRfXxdSBb2ZlrLGz
 nJbBrYvRfJ6EqlaE94g2vV2/ybYBYU4aQzu/p3pIgbEn/UGHhu9qjhtEfxmOoxls7E/2UR0MH2z
 wRvBzl8Xb9OLie/jRJQUCDkCPZu+ms8=
X-Proofpoint-ORIG-GUID: 9DaVhz33R_xyFgzMb0oLoJW_tpHG9YIQ
X-Proofpoint-GUID: 9DaVhz33R_xyFgzMb0oLoJW_tpHG9YIQ
X-Authority-Analysis: v=2.4 cv=QIBYgALL c=1 sm=1 tr=0 ts=6a7f500e cx=c_pps
 a=Ak8bExYEjeps3Jj0Zi+cTQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=FOH2dFAWAAAA:8 a=DPiIZG5viqn5yQokmPgA:9
 a=QEXdDO2ut3YA:10 a=IIT_bRn7abC_HnDGr_W6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzNCBTYWx0ZWRfX8vzAf9zOuLdd
 3Ykqe71FQ5AqCsDmBt4SRbn/e0U2SLSsMLZqFfOWE9J8oJNPSvamrCQeqTSYah0Yu6UY0iU6YsF
 Z1PwNE97dXRcgZtalAtfzSIv8usETI594793ieT0klbmrstdJbOs5fi7U4lfT5uz1wmbL8K4KCU
 nEo8+cvBTwCldWP7plAz5V7CeCI55mzWwV/orKI5vLJ4YAQyvxZ55sWrvhE8f6CGEQj0Jf8GC7z
 kfVwBm/3ci7f3tw7o2984GQEFblSKIsivDI4IU5zVQWlL0v7kKwAS3Dya3y7yUxeQoadh55HASU
 q2LtYj2sdmfBH42ZHY9Kf7NxQHr1B0NdB3RYdtA1ftzbe0/YZokwPxAj54Nlu5pBgE9KGEdjk7n
 MxAzYuwS9UmpCLkm1QMB2jdncQU36nOeBWzty5wOXjwVBOeBrzCZnMAcnkSSOl3zIn0a0XXRT+w
 8+N6NJdUO7NzfRV2j1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01

On Fri, Aug 14, 2026 at 10:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> >
> On Thu, 13 Aug 2026 13:37:23 -0700 Wei Wang wrote:
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202608080910.l9KvOH7O=
-lkp@intel.com/
> > > > Signed-off-by: Wei Wang <weibunny@fb.com>
> > > Commits targeting the net tree need a fixes tag.
> >
> > This is a sparse warning fix, my understanding is that it's not a
> > functional fix and therefore should not use a Fixes tag. Please let me
> > know if my understanding is wrong.
>
> I mentioned "no Fixes tag needed" in internal review, I should have
> been more clear that this implies net-next, sorry.
>
> No need to repost - we'll route it to net-next when applying.

Thanks! Noted for next time.
