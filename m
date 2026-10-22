Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792683887;
	b=bCwZ2lWhXVyjMsOehMzlQKtGhPNDC20egs38gcDFQa8YIYpa7A6agvq2qxMiDw8KVnak
	 KknwJc3rUvCt0u27ayuuFZEOlVLD4UN201RHDmg5gv8z1in2uZU2Iolzn1uKOp5VsflHJ
	 Aq6UR3TcRldJcYVru3H35OFySr8v8rg3BGt1v1tRSAFE/DKnuQCMFzWAaV4m2Dswvha+I
	 nO9rzL5gEmUAZ+VI78ivgEetqHywYaa6e6HqaOJBS4JriEv0rDmNGpTdwWMpWNqEmA39N
	 IO8qQJykELeO748eA9G5xBhLGX3u930Iad6TVxOpGC/HSMHqDJTsK+NxYpVSf/awc8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
	b=nDbCddNxWkF30R2HOdT63YRL8y7owbr9m5e6evonWzERc0+QNZwhYnLjImWNw/Kg12K2
	 Vo4y4kC1ULp/EToIAY+wQY6kO+t33nNt+wDl9dUTCEjGz1jzs9ezZwjkXzp0qKgoIqJ0t
	 XzcOdYWrjkbsfXmPLgZuOp+/JC1g0lL9+uUJKqi989KpAuz8+KIezBO+6JxQlPzYxRfja
	 2iErQOtnHaPtkDJYOOECCmq/8PEh9LxcAHx3JCO5HO0esbeYi8ZZU9A9T9QZFdH5ZAv1f
	 f/VOaz7GabzsA5hOYVNhpgyfYOL+9YQRWQF/5ezXBblhEJaiZcMVH1pYI3ttDwCb5dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DwVJrdCN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4B606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A4B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DwVJrdCN
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0f59a5fdeso18996727b3.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683886; cv=none;
        d=google.com; s=arc-20260327;
        b=I5wROVa+Oh0jjyFy5PmwgsmihKZG86Tet9dSB5U+3nXGyT70I8Gdnb8VN2yMfBddGK
         cZtEDu2RRWvolV3KYaWLuoUM/gTG82dG+ZA6jA0sYCUgpvtX1rJTM9Xndgyn8IWdsZn7
         FJBbcoxQuLrUHVbh1HN/KhrE2Azsch2gz78OdEra1nkybRxcP4Bwh3TUSZV/Z3uQ7fVZ
         gbimNtv0UbdurQZvd1i9i6GM9h4Q81tg7ATwADpCoADX9Vdtw+aOfXN3Ih0bwBmQYJ4E
         5C/5iyi/zzNrk5UD29TbL8MsAcBZFypZPcJOIt+FlNavFMEFRU/o3mp3oDHlpsKpNdrl
         2nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
        fh=pdSyHLZhlLmdX7VS6uaEb9WyNdlj4CJKuN6AikV0tHk=;
        b=UgVGFwOotROe98Fnvi7bbv73nKdMInKdNGhd5eIP71Nboc5xnGd5fE+kpJ6EvOssGn
         Vriqx3rFff9cB6P3mU2G7NTZwvch7Ygs9CXdC6JaQ7hGmR2Qqdnx0So7n+lAT8F3GyF1
         hmZbH9dE4qilca7/t0EzsOFU5CrpqNpFtWBe8dAZeE6DNZysxjT3nN3s9WeS8pL4F4As
         QBu6K+HM1umVPUOiondd5o9fhcYCgloK3H2cH7ym6inwmrI1qknrFbS6g+GEYfDr1Ucu
         tJyq122G931VtTiNKFd9jh1AaehYn6Z3TZ0kVT/9bOUh6o7/12cLcKUkj8eu843nqlvx
         spOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683886; x=1793288686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
        b=DwVJrdCNVkNQ5bxC/hIGCwfripGCsW3fUmDxvP/biec1GRcgNcVtBY3FZEbEY9nRUq
         zSUtJHlXL+K1OVAzMXlsPf2qnh0TMknLQm3c4tAh73ms49FSgq5uqORLNTQkKtly38wH
         yf5WsRc0jOwkCMlkWU1CswHavTiFACy7qoKW38QZNXCcCVudKfHm9i/V9a0W7OmoIwWI
         k/TcT7XcI5Wwlq1oSq5q2FQFcqT2A2eMC3WuB/gkKkjMGkwBKOi5pou1szuwISQufQ7B
         Eih9Oq2RL1dSx4P9T8a19PoMKoHOV2/tnAZ3A94Je0mgqyo01bmXXCJttZNsl3jo4IXW
         1IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683886; x=1793288686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
        b=XNuSV/Ny2ELrcQpk+T0oY3hGr4NNUhWKdp53Br0BJIY8Z+zvtiIEX6Dcb6ppju70hA
         R9tuDntro1WhcdcBM04SOGfFFRVuzUpeejCET9pQ7GJcBztno5mb76qtBFdxfbt8iQOV
         RN7EScDb80vH/gSNy2iQS6PMNnzfFzfwasvl9uBjnP8fYE4dqdi6EBYq32VZeo2ayIP4
         WvASCP4/quxlwy9D4L6Doz2YABuGLXvToJEDvJdSepfrEYwLrsqjBSVhUZYgNJnP0ggg
         faimkR5V4qThsu3XkUuN+W6BNixNyXT2K6ExdVSGG+NjiFwYc5fEVU0agrhm/6YeyMIQ
         Z+iw==
X-Forwarded-Encrypted: i=1; AKwUvByHiB40Okg96qHF3rryTS5urs8nCQyYjzdX4gru1Tc7JAFv2QMQwIfmnWjfhKWQubYxIOsghvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1Dn3ggo8P5P5Z9lkTSWtSBT9p19tt/ofcvlUwY+ftrNugR9dT
	BJaeZAb9i3qntzSAFuHZfoIAEio+NPTlMsAoMDa6zjSm41yCss2MB/MQNX80zSe4HPNKeVnec73
	G5aj6XedyNMSwp3tVsL6O5U97k30BRfo=
X-Gm-Gg: AYBFou0e5sOGMdY828xznWNdpGTINpFjicJuRU9wBdA+SgAYXCembJYvQntqAIz/XCv
	lq0+pwLATm7Bvd7epI/xwc/CUHi5ahnCTV0M8zQ/kLcovNADBhVjYEqxp5NQgZV7YVUZOeUtriM
	0R3OhfSZyKRmmPhmhCLPSrHnRFdqp5FkFSb6YCVV/AeUbNFLbavdiPh3gOjfpQ8qaEQxRbPm0R0
	QS81cwuQr6GScWVyvjS0wFY6kJYXxOTQM7BB0H5RFywN9Hg2tq0Mzh07eBkZ/kiLYEaJR4BKFcq
	iIoq96g3BmEchczvE0wnUT2B9qeKlC8HhB4suF4slrFbtVPXM/uPsKQK0gpyGEe5MF+ja5Mv3u6
	f+61TZD9STIWlsHQuHGe6UvZQzaiAQfhSlGiSxvkVqH46ukSneFZ9umUiB+OMfHbqgO6GmR4gAK
	G8yvCH0IHjoFHXFLMxNZsaYhI=
X-Received: by 2002:a05:690c:c4e6:b0:8b0:9409:5ff with SMTP id
 00721157ae682-8b133d5cdfamr36933817b3.47.1792683885510; Thu, 22 Oct 2026
 08:44:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
In-Reply-To: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Oct 2026 11:44:33 -0400
X-Gm-Features: AclHuK8pXn8hZFihyywvYqXLQvQqit6uFoz-znUkdBUwI-jQRhQ-0DBJGJyPSlU
Message-ID: <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm multi-subsystem
To: Paolo Abeni <pabeni@redhat.com>, Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Oct 22, 2026 at 11:38=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> New knobs should default to 'n'. The mentioned one depends on
> BT_HCIBTUSB, but the latter is enabled on most systems.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this is a last minute fixlet to avoid breaking expectation for the
> upcoming net-next PR. I'll merge it in a matter of minutes unless
> someone scream very loudly very soon!
> ---
>  drivers/bluetooth/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index db0189ca3cbe..0dca5e43edc5 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -96,13 +96,12 @@ config BT_HCIBTUSB_QCOM
>         select FW_LOADER
>         select GPIOLIB
>         select WANT_DEV_COREDUMP
> -       default y
> +       default n
>         help
>           Enables various required support, such as configuration, firmwa=
re
>           download, and error recovery, for Qualcomm Bluetooth controller=
s.
>
>           Say Y here to compile support for Qualcomm protocol.
> -         If unsure, say Y.
>
>  config BT_HCIBTSDIO
>         tristate "HCI SDIO driver"
> --
> 2.56.0

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

@Zijun Hu lets us know if you have any problem with it being default
n, perhaps it can be default y for a specific Qualcomm platform but
not in general.

--=20
Luiz Augusto von Dentz
