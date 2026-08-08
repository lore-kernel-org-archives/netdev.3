Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7124238C2A
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149397; cv=pass; b=BEgLM2Lun6PLZDRS3pHclxchoHPuPYxyi7myfwJFN3uMEm+ZKTv8y8xDc0BvRKBeLUL5Tp3OYlZ5d52UzjRtM+zlvfeE6kkoeY0vCxMLizsGsFJBx3mi/dNvNhMg690JUUaGoXdCLbed5QfGkGjvTmiQ45goHHTU7TzzrJ1EgR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149397; c=relaxed/simple;
	bh=yebjqZBPrW/dDD47/Rf4D0u98+RmazqLXCvYFxedQBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq/DsZxNR/SnQqeSpHmyoDPrVX2u+RwzC5jFoPlOPA7lCptq9ypvpTbV6cnHCQdnYpMdeo/CI2U54XFwEeN9Hiq2df6XZwui63r9NyuKpz3eJGeiwgEDqKZuTqHsmJm9glPbFdXdrXjygA9At7SMH0M+CW4LAUyalUg1rmk6XNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqrU4NEo; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqrU4NEo"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so55983e87.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786149394; cv=none;
        d=google.com; s=arc-20260327;
        b=mmii/DFhsaFNd5FHIJ4Rr/x6Tp0EklZAWSeGHV+WUV7KW6DASWwX97TqZK463hV8wC
         Naomft3TWR95RPvb/H+ZRz3Biy1lyi2o/dcy3GMCEeU00H5KiWyqru5T0FfFawbSu7Yf
         gGZx4o+uywpxPyEByZ4wSSJb+9HI44yMWIvMLPwYK4HVjAeJ2eENL+Cz+cf+mE5NIaXS
         V0tp9Xp7Gha5zr/wUh0kQgGRRT3ovc2b1adpPKyf3L4FCpawZp6cFUbIOQIffzWeMaQu
         SjP0Oyddklqvg5XTOUBN8tGfeZEzL3Zng7sMH/e37x6g71kS87lbg+OjnFG7c0h+ECiY
         Hi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yebjqZBPrW/dDD47/Rf4D0u98+RmazqLXCvYFxedQBQ=;
        fh=sMU+TDykBeneEGMUQIOm6WaFTGB9XiaRDUS0zHta6xk=;
        b=V8m+EWrUWNRju5+8zG8gpQ+i6Qi/PuZ1Snm7wczmS5bs2/V/QvJgdCkD44aSJqFT3h
         V8oC5lKcKk1PICkGydY6f/1Ol6B8oSnza206fdIE6ETN4OK4imZn0ubgh+txs2wWl2Ms
         GIHj7BMBdhMy00Msj8AZwlDPbJpB6c+s610dnBL9wN+BizQas/qxXtrAKrr+4lmoFnhm
         gh1tI1m9FiDg6FKMwNpv3b6DYAHzllZOQ3YwYbetAKuiIbJBhVl9etUjmEsGDgFkIVFR
         ZhsWitX53xZUhMC6Y1LNs1xpL7Fy9T5QsJBnM/UfJQ1q0E/KAzDjUgIF555FhBzXKubg
         gv5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149394; x=1786754194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yebjqZBPrW/dDD47/Rf4D0u98+RmazqLXCvYFxedQBQ=;
        b=LqrU4NEou5u5eKIl851Jw6O0bplgV7lstTiPtYuqQxeuj15nEJQ/KP8v0XVchdVrAL
         0wbe2rkqXTXfR964CulU7VUmpOhhogXJRt1AZkOvl/4VY1NOjIquvMM2Os0721F6aCLd
         letUuDHtknxfNPbw5v3U/5JY8ofRP5HPjIXZ6absfzS4Fdv2mdxqxzqxm3bwpbklg8Q0
         g/JFINj36bAVYjmrsEnSTl/9LCoFFy1EOzlr6VIDLT+anHaZAfdDhfe5hhKmalm/AY5u
         3Gaymh527cDy65GPTeY1F4Ew9f9OznBSoGvlTLIrbVvC26wN0JtsOAoGaHYBgpCfpccb
         iw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149394; x=1786754194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yebjqZBPrW/dDD47/Rf4D0u98+RmazqLXCvYFxedQBQ=;
        b=OKQZDrVYs2FdJHacdE6XPLjn8V4OeehHob1vXUfJHqQK55DzPJwVeVS8H2itECI4bu
         14XC7qqoQkMkVIFbpFT48O9ICaoYxp3U6NWMQEhOtJ3avwgxxdeAx6VPPJJ7DAaHvygr
         KnAxAaNcE2Voqznt41JTXfYNyqknm5jRaT5Zrk3Tz2c01zVOnMA7mRCA5iKX3lz4Co3N
         ZnFZ23C6ehSlXLbU1Qrt6tSADFGsV/jcE6Q6ezvYE6+bvOLjqG0hziX/XTywCeYp0pMs
         DjPCglEWA21vxg0WpAX52P59qYSfkZfEqtb1Qbr0SisJfCj3k/FdnSGiCOVgAJXQKFvN
         b+Yw==
X-Forwarded-Encrypted: i=1; AHgh+RqFrkAQAmqrSRn6NrJ8BssdxbCqvEBveWNbJ8gUL8iQgusu3wx6ibbVxCDo3pjmq/cHTSW2lNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tTXh3zowKBRkjZbstI8w1KwAqdTh4+P/oToRveAD10Imkb0e
	KHFsXboBixmrdd+Hrqx/hpxMq+6UZFZ1fN/gFtBh5Jtfj6cdgzjWfC6vDKVit832H6siclqSKvW
	WaHUGMZYEtjr6dl0hheu8Nre60SrvOaY=
X-Gm-Gg: AR+sD13PFfSM9D3WyoT37h6ihVmZM1dFiUBh1VYXMTBn1FYy6NRQWb4wpGWYkn0SIgD
	Q4doDZcrt8DdktwgXojtKSK37MYL0yY78e7OSmfCA/IcjEOENcYLFmk0Wksfya+6e96d0ehobsv
	NWS4wNDxORXC/bLKaJuaXZmdzS/VAMs9C49VuAi+dJI0J4j5J4wSIjNq/GYsPZ1lJHQVYmxXoix
	tkPhDlOs3E4LmmMHbgYBrIFff+/1dnr5l1HSJiPD1OfdSThp9+ZXfjvZnCDQPKVChmvNafw9jUe
	XEKjN78VoLxtpqlNFB6ky0zp4YVTZHsFkrBqLM7cfwUj6HZIZfj6Jb24ocDKCGiW+jhrdFWn8rT
	XRFDxovmf/sIr3aTM2PWm6JlB7Z8385naF+47iYiTf9zWiA==
X-Received: by 2002:a05:6512:a444:b0:5b2:9599:b5f1 with SMTP id
 2adb3069b0e04-5b2f4cd03c0mr2647132e87.42.1786149393742; Fri, 07 Aug 2026
 17:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804014714.4362-1-sigefriedhyy@gmail.com> <CA+7S2vKRASitG1pK_RPG1L-hDsJyev1q-+ViRhCppBg9aFuZvQ@mail.gmail.com>
 <CA+7S2v+upifiRtBmGjHqBbOLFWn_m1dj+mezi7rFZGYLb-DChQ@mail.gmail.com> <20260807155241.GA2186508@shredder>
In-Reply-To: <20260807155241.GA2186508@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 8 Aug 2026 09:36:22 +0900
X-Gm-Features: AUfX_mx-98KOh01MxXCDuJTO0muUiF3gWbuaEF-FahzwnAMnC3D1ZCi4xwC66HA
Message-ID: <CA+7S2vJL_5GL0bBJRu6pu3fdiw1mq-106K9fXA-ZAtgsvrr86Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/10] ipv6: report why a route was deleted in RTM_DELROUTE
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Chris J Arges <carges@cloudflare.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, 
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Nimrod Oren <noren@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 12:52=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:

> But why put it under '#if IS_ENABLED(CONFIG_IPV6)' in the first place?
> Just move it above, next to ip6_ins_rt()...

Thanks for the comment, will fix it in patchset v6.
