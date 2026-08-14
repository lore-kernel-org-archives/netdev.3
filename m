Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41B48988D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726954; cv=pass; b=gD3ghgrk9jr2ZMRPmh692Y6e2hJq0RLpf1bNaTEgWG11/GGJT6eoznNyUpsQCyvHQkBbIQNmolnSrdB+vprcwS1TnsC7MVTITbmchPR6+YSjdOcGEV1YvvWu07ZjV47gBQGmvSf7bNizYrZzC4Wj2D89PN09/iiXGMsBYQpR3wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726954; c=relaxed/simple;
	bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J32TKLshEdS8ePol3jtseNCE+UcSPwuY7/OEhEPUI1cjqd8HxZc+wKTi3KYceAFaWvm5uORvq9SfidBe9NbnxRcXCL+4NvFVubUlEvnze3DOVBTpGVnguLqjhAPdbOvLAELEpapy99asP67GZy+ido7zQi541wRcizTCSdd1OyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Hi5YwYB7; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Hi5YwYB7"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so947315a12.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786726952; cv=none;
        d=google.com; s=arc-20260327;
        b=pPxaFHaCxRUlf4KBhmUCIRUosPKT/pXQR4VTJ6cGsWCfgHsOiBa+qckemGbxR7Qweg
         ioYvmGV9gnlEZ6+JlX/SLRcYVQe9Qqj5OHtzSX2K2EfMbL8UkzXFa7jYs6Aqv4rpAs0R
         NnUJK+vzMpBz1bP3mtrT/jzfi7If6eXYwnfJfNlWFT1W8IrzRaeA2smsE7Z+/VHsOAb2
         m2ELr8PziDCMKPNAR6OCZscHNebF6/1k5KowfYQEnQ3mbLEI742mwHHhQsaXNPrZW9yw
         7VDp80zJrlOANZMEx22MiReQQE/P7xD3kyDLKA3hlRgUslTXhkMW0g4k/Qc1OvQ3Mtt8
         M4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
        fh=Rdd81fncOk1+iqUXGNo6CoHWfyBNxYVJfzA8H8dUscQ=;
        b=iiPaFysqFXZa/djurqVsmNxBy+CA2v91naU6Uhn8s/l9p3BeULwD5Olv3QH71T1Wbm
         UkK1+6P8KdcGjsbUdIG73NPqeBc0Kp0d87Na6XfLXuxHL7JJcwyHH8lGXqNjQjSuHaJx
         aN6HXkO0l8Z1oqC+aROkqYTAvsLv2wyi+EQdeAc3xBAy5+krujiziVd8+rJuTrVJB5wt
         TYbx/4SHxNetBQFHI+5+7Eo70EbIbJnJeyucXXhUAl5W9o2V0C3kT+bZoEqothJLt4SF
         KoUeHq1nHbVxM1wAGuECJEp93bRpZ+Odg9Psu8qzErXwdZG/uN5KfvlhW436QHqDT/aU
         evmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786726952; x=1787331752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
        b=Hi5YwYB7xeueQ81NLg48IsZTjqgbslSM+Z2e0vOLdckwawmKSfSHXGKjFEMwXCxlxz
         J364SAAG3mccSrvGmqESRz8e+gMtw5CgB14q1cRWPQiZ+psVnelvqX/djLHS9ulupvXC
         w5nq6mqyE0sghA49l4iM2CdqNjOC6wyrzbKiX1MhoZ+w6M7QoKJRqAUajCeKS3+vcQPy
         E5wlvQWXcKqRZxlB/q4DgB4iouGeh3BUJG5NW7g8v3yvbazV2fJS0Snsm45U29uZAszZ
         PcaSGI81I9/M4+chuR1Htz4qAvuUE9YRWanY1lNRZXCORCEu5x0SZtN3GHOjAh8QK5+p
         8BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726952; x=1787331752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
        b=lgruTb6MboW4YRgUcXUUA20COYaUqUYjTE+MdumEavuHk57tqlIczscGHoLoCwWR83
         3DOQeW948I57J4CrTusPwz7OZawpKYfxGKf+2A9yfNk3T/VY2NWxa0+V7AT7gl7So1Ap
         RjiVTb47Y4xW0+ET5FG8D0IEYpNEiNXxqrfhoz1NWKhJzZg3KhcneZkN11w6sG6LDH4M
         zsGe3G5nMDKzdNxPPyhdQMXV4gpAD1SqcjGRXWUR7NQeWLyWBXd3/UuZOnkDvTnaB2Ty
         iYC8VoMkYwDLXhjqrzCSa7tW9O6U7zXw2f0qLaTGPy9CFM71S6kcvyHPZKTIkeh7Gd8R
         IFFw==
X-Forwarded-Encrypted: i=1; AHgh+Rojf4ob1G4uasAk+vpU0KBmruonDcLB42pcCZeeC9m5qSj7A+SvReIXXNJCT3wMaEBxpCDdKJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAr69deJ4LPDp7bLmfKpjfbdmFEhGuVp0x7DBt0Lllt4agcMS
	1DSOn2oA5Wo2Z2ob7Y/j/7b04theYsuyWJ8Eu2bKwWJPxzibKNlsE5tfrtLnTGv1KOn0EdsPAjy
	8eibTdyh2GaBrZ7rMlBf+1///a2dtC85nYbU0qPa7JokAuDexcXF8875n
X-Gm-Gg: AR+sD11MJPZ+T5ZWHhQDLIDpiFNzUayOsW0xiJOy7NYS7CSosbuK/LkeyWCFztXKg2R
	/HTURmSZWqaUwTRDf/tnGwD6676HDUKefEXwIqLkGw1MTE7UOq3QPCHhVY/bfoZ3rHkcFLYf6Lo
	TCt9gsXna5jpwyAOILL/ZX4qkt94kAF5jeewBx3aryqC7cxsVqoywujydy+vso0woxuhKJrcgxa
	UG7oDQ1xmBGPZ2F38XkTCDI2q9T4IezCFIK57L06kzdJ/t124KcZyIEX7sJgl/q/jhtvOiFAxBd
	N0hm31qD8xbDx9FFza5yzcy3/FWKeBri+NleW7T1VefcCw==
X-Received: by 2002:a05:6a20:c6c1:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cc71e1b525mr8653190637.29.1786726951998; Fri, 14 Aug 2026
 10:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it>
 <20260814052541.1198373-1-xmei5@asu.edu> <CAPpSM+RCXzepVid2qnPky33Sx4j4uy-gWZ74UuG6E1k3pGsKeg@mail.gmail.com>
 <20260814151453.4d45d5af5fd7bcecf0e0dbdf@uniroma2.it>
In-Reply-To: <20260814151453.4d45d5af5fd7bcecf0e0dbdf@uniroma2.it>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 14 Aug 2026 10:02:21 -0700
X-Gm-Features: AUfX_mxtrL3Wam_weCjrMzDuL-wUbcw55UCi0JBIG1z06zuBFY6JgqeKDdO-beA
Message-ID: <CAPpSM+TRJc6ALASmezNPV49osyc3gvw3Ea8-1aGYPdfXgYhe1g@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: dsahern@kernel.org, edumazet@google.com, netdev@vger.kernel.org, 
	bestswngs@gmail.com, justin.iurman@gmail.com, alex.aring@gmail.com, 
	davem@davemloft.net, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	pabeni@redhat.com, stefano.salsano@uniroma2.it, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 6:15=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
>
> On Thu, 13 Aug 2026 22:31:18 -0700
> Xiang Mei <xmei5@asu.edu> wrote:
>
> >> [snip]
> >
> > Sorry for my English. I mean, if you agree with this patch, you can
> > take it (it's based on the proposed version you mentioned).
> > You don't need to follow our version of imp.
> >
> > Thanks,
> > Xiang
>
> Hi Xiang,
>
> thank you for testing this and for the kind offer.
>
> I will go with option (a) from my earlier reply [1].
>
> I will send v3. It is identical to the diff you posted, so what you teste=
d
> is what I am sending. If you want a Tested-by on it, please tell me and I
> will add it before I post. Otherwise you can reply with it once v3 is on
> the list.
>
Feel free to add my Tested-by to the identical diff.

Thanks,
Xiang

> [1] https://lore.kernel.org/netdev/20260521200859.816b8923b5f27bba6124461=
e@uniroma2.it/
>
> Ciao,
> Andrea
