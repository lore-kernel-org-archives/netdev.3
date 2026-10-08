Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359064F403F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483806; cv=pass; b=qY5lUB/wfketYLOT5wO2kAwW2g3KaeVTCXMNGZxthErnpCGOGpbsRUHiM1u+qnbLeosHrTzxNx0HV1Sx1Pszpi2pKOmE0UNVOot5+rUBFiWjuKdU6oRWEx/sUj/5QzgGwvZMe8BEbLqEHiU0PcrQG6xoOhaEet96ceirjAX8qyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483806; c=relaxed/simple;
	bh=Of40/D+2q7EuNroFiUgmRpSmrGdz3Ew/fHYx5vQm+dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/VOMNfA+vU5pSZUOzSfyZBqE7qAOXoy/Y31VGRtEfFqbgJRW16AkTfoscUmunD2py3fOROn3mpuggzggZ7JtrF+vhEwa76RrQNt6d6Thpu3sZITbFO+SDjR2GLLc+6t/HbWVDCpMq9y3LFZQkJZrij+CbtryeTAb3v/WLI+PG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzWY/B4K; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzWY/B4K"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afe29c08ccso4408491a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791483802; cv=none;
        d=google.com; s=arc-20260327;
        b=awg/W9WbwDwlCFagD3/2f/Y9W0o9QV/Dxocvk6I3/59sTFOJ3TLCxIOQbUbGPz8cYo
         r0ZNYxgmuO2A0KtfMPXLh1uZsjxPF7wXO6WHL0FN7/5BHE4miM1mh4sZj9boZU+oE5O7
         +kJZTPE49FpvhVNeYbFoZmDTvTwTJG5ZFo3PrMT3FxfpdD42DDz/aIJMa4ETq6ulqxNH
         WwaVrX83LcNCXUl8Orryw2LtUae+SezXxfVdNq0qCjGGoDtBSJU2tps73XdVaDh3JOQx
         C7zCDV1fLiYF4npQKd3xfF2oZav9qE3wWqf1AZGe8n5LXDbJVnvbVdXwbPWPdhzc4/nS
         ZDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qGB3yTtCVZXrcHj1e2uK63lVVVjDF5LreVlgkZI4Tg=;
        fh=FLoib5YiqgL6ykxYBlPNdHC5KEmILyuQRUEqWykv98M=;
        b=Q4IvGpnNgsFjM4AlmvZ4Jy3mLbE47JMAVISx/I4vEbVuD82bLpLJEMkR5Q/i8Qasln
         Fgqno9hQwuU/y2cIWME7XqhZoxCVZJadEXeYPymAoPfzWfCRzz0uosskO+X569l6YS16
         tasvGgdBFRlFbCc6gGiHV+vQiJwF5cB5qiRic13S5CpAcuf2qwVpEszy99vftHXo5rVi
         lODs+vvP/vwR6PASGoJrCi0VxPlE4KI1/vF9shxgC5Kz6w6hTGA98jX4AiXOYiFT0IzV
         OWPA4gjRexOogFxCXPI0a9SXKGpbJFN+X1LPpWttKubdfWwBKmEg9jwRvjyWG44Kt0iA
         2aCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483802; x=1792088602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qGB3yTtCVZXrcHj1e2uK63lVVVjDF5LreVlgkZI4Tg=;
        b=TzWY/B4KvWsgzmObIAZmNHbTrlXsmAG6OR+fL7vmQBtxa3eXDUgmkt4RfyarQtszHJ
         UjWcfVm7WlufvVCxuvOCQgYjpHSeApakemW7RuVduFZRBvyFugP0p3+T08A4Pxk5PeO/
         Gzd5mc/bQxmxqsGT5GYo+Ggl1/ncJ7OqOT7phm+NCq6TkZjCsW2igzexmYNsEngLsMoN
         bhsfBD22/IS/MEz9AAAHKFU6McUVaZLyR11/IpDFV/edUSdBD979ca1Lcd/3Dei63ubJ
         4b1EbPaiZWc7SJEOUHm3CS16lqb+22/BX/kYv5n48BIrfhlznedte4iiBOvMve+91vmQ
         VuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483802; x=1792088602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qGB3yTtCVZXrcHj1e2uK63lVVVjDF5LreVlgkZI4Tg=;
        b=zly/kkZZ9IxhRuM6jyXN62lz2BpsgAxgMJF8v4r93eqyIn26f2E+f7qVHItWIBBCsw
         cw8nMRFElDlEAVAaKEO3r6j1HT5tXGl0/hmH755FB7GBknushCskBGx+p5Q/3xenOVyl
         UyWioHzLTFJHAaqWkuleNJNdHL50Wy9i+8HPIbLSGpkY8hhNW7lZuv2itAFulPaPKOvg
         O2gmXbHz2z6X3EULlVO6lyzeLPrVydMY4q7rilzeZNjH4g74+KMcwIYSzjB8cNskImRs
         ruE3mdD7tR65ZQtkkkGHCd37N/n8j2LIZ8gYT4It4deZeETDkkrZ1qZj3nUIk8B0YymR
         8YcA==
X-Forwarded-Encrypted: i=1; AKwUvByhkEagtC+9qDULWb3Tf1UiZxGFuFAeeRdHagufngXaT5urmrLMEbHrtntWLRLhpWvcwK7hYzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcaPwnMNd/+uOKi8PrK/vYtEExd+LDGKsULq3f/tuZzJtn434U
	7fjj/pHwEBGsVHgyiXNSI1VvH9/sD1qCDIE+jFwm2yx3X/FYU/+yo0x+gheLQnL0yVUkRlDqrwS
	jY29Ypk+/Tg4FT7WaBp2Ckf756PBYF8E=
X-Gm-Gg: AYBFou1O5tYWaPmz6uujDxUHntz0jtU2/SF/prMlEHfb8douihXLuctQ6SEVk1C7jkc
	LAuu8xKRLTC+64hTcYX9Is2e+8l5FQTE6x1k2RnXQQ01w2XzTLBoFcA5aoOANQUnS6Fqna4XKOh
	MUmNWI1QATDkWfZ9lmCLeSL4yXAlxFKn41LDwgFRKvQ8QTmEvGhWc2WiXlUWc6j0sVgL2/4GwKQ
	48VQ++wcIjlKxVqFbCn+1xYXDnrDWFfHZBLcWoIQGrbc2ODW2GfP84VS39MGRi4MpP1oQDxfBy1
	8NE2FxWka3iPdPTNpSJRmPd0xFQerTpW9sXDi1mrfUjdUB/GavKAcVd1Pq74Z+8GXGenZ+yaUld
	dtj4U5cqbUMoeFisu/IzXxMH0rWbfoO9++oOOc6O6NQ==
X-Received: by 2002:a05:6402:2348:b0:6ac:b3e7:2357 with SMTP id
 4fb4d7f45d1cf-6aff28fc46cmr6370997a12.21.1791483802293; Thu, 08 Oct 2026
 11:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002161515.932316-1-linmag7@gmail.com> <20261002161515.932316-7-linmag7@gmail.com>
 <20261008095802.79671bd1@kernel.org>
In-Reply-To: <20261008095802.79671bd1@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 8 Oct 2026 20:23:11 +0200
X-Gm-Features: AclHuK_YT4n7UtkmP7VNOeDIFq25O2F-pzFmRQ2myWVzNADzZnCn6eteznczwqQ
Message-ID: <CA+=Fv5RzceCozPFvpffbgoiV=V6t+mRxgk+UzF=TEBNO9aaeUg@mail.gmail.com>
Subject: Re: [PATCH 6/7] tg3: normalize inherited M3000 register byte order
To: Jakub Kicinski <kuba@kernel.org>
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Oct 8, 2026 at 6:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  2 Oct 2026 18:14:28 +0200 Magnus Lindholm wrote:
> > M3000 firmware can leave BCM5718 vendor registers byte-swapped while
> > standard PCI fields retain normal byte order. Match the Fujitsu 10cf:16=
5a
> > subsystem, IKKAKU model and swapped revision/product signature before
> > restoring host control; reject failed PCI accesses or register readback=
s.
>
> Is there any dependency on other patches in the series?
> if not please send this patch out separately
> --

There are no code dependencies on the other patches, so this can
go through the netdev tree independently. It applies to v7.3-rc1.
Booting the M3000 to test it requires platform support from
the rest of the series.

I'll send this patch separately as requested, dropping it from the full
series as I send out its v2.

Thanks,
Magnus
