Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B247887A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060242; cv=pass; b=C2o+gkfwYmU0RfTL42TLxRgZl6w5H0SXykvsa1J2zXDHknYQ3yBNkpsn6QKDH94PQyO3l3QlFXIb2FyD+vJRRf0tn1wTt2ZZVH5yw78Y94vOLltRbEkWCLgrPfcAFSuuZdMruXBzrlO28TPQaHuLP1GGJDQWRSQI5eXl7Q9iwg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060242; c=relaxed/simple;
	bh=DAA9B4W6+y7RSH+675skjYb+3ePFn6N3+NDo1A/GN1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQDrDQBDFxiGWkYK0rmYMdyyDk81bbv5704XmJRoJeSzDvY/VLF1XnVzKJbdsaGdjPJ9tDSafoEj6f1gifmp0EPDKXYbK5M2oxEUpodnx6aEjHBRQtg3UDwTTCac4SCngyswmeg7j30vuYmMNz7u28nLaJ1yDT7ju/jljPwMShk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTefeFGU; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTefeFGU"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52d56b08213so6057501cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787060239; cv=none;
        d=google.com; s=arc-20260327;
        b=Yzl5Q3QtI0LWgqvRCky0yjxScGLAZ4fc7EcrOBHKlv4biKVE4h1hQkozfZswpq7nh8
         I5SSurNowSwUJXebRxkovJ6dzUWanX5uML5SR5qr9w1rBcj+0GOKRTtzYFS8RwOcLJAG
         AcK6H0Isyjg3geROon5SqKL1CPCrflNWZrEp5oLUlg21vBftHgr4/4nS7p3g33S5SNvq
         u9+UWje0l0DPrFR5x2uWpIyPJkLKs2W/W9jmptvgey7phcPjHw0VDZMG4YUcPIp3Exd0
         M9cp0ZhvtMeoypYfqXnSK5Jaaz/V2ZVrQ95dErAYQ7+18QutmWYGrS6E+cQ3Ih4XjU3e
         S5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAA9B4W6+y7RSH+675skjYb+3ePFn6N3+NDo1A/GN1g=;
        fh=Efmfmg2lgzTpn8MjDA2KY1HtUtgL1Ydq04FjH6Gkq9w=;
        b=n1lPO8NyM7ysG6p1Qb+MvfgenFRWS1D/MHmE4JvhdN1yo8hXo3AW34mc7Rz3nTH0E4
         mScmfMbZygUvUgWh1CcyWtOO27YbrZtYo3v7Xk90s5XfzbXoGWlHEwB6c20XpES6U3zq
         nwHfZVU65GW/YZQQS8mJzp3KcDFyoEIZLsPwdB2Vg86ySWXO1OlEOaYVWpbh2QjjSryO
         pnnRdTY9PtvVcrESEVGt3DSrmkQUEuaL7ZcRNXZslwfsVqxAKhn+YIItPeKq5/N1bRSh
         l96ksyD/MKmLssMcpgn1DDn2rscjmDGAGIcr3jJDywEKw8QiJljKwB+MjeQ0fou1ftfN
         BgBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787060239; x=1787665039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DAA9B4W6+y7RSH+675skjYb+3ePFn6N3+NDo1A/GN1g=;
        b=aTefeFGUl8ExepLba7xBP3/Wn9+jNvmaUl6U6fx5dEcidQRUL3HHAyd6n5Sg6A4vrk
         rsrLzmFeQmxjO7CJCWlk5B2+qhLgdtmKE+Q6DrFuhEbDYJXjIHJh6nsdRhiWPKxGP+Wh
         ZHYkZY7/mlbLAbtpGJk94r+sJ/LfTUS7VMy+i01+aDpqElGaZcyyPppIZdveJ9oFy0xv
         sycHEN57c9L3PQen2UcXsBDREfUEURkcyV2gLuBJyeilbhmTGfXbUvXeX1etra/GT2ls
         ZCulenPg3SD8BnmB4PfqwuYfnnma9Dpj1pKZmePj7qU6H9kBFXHWO5xuROzBkpFkrK/C
         47hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060239; x=1787665039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAA9B4W6+y7RSH+675skjYb+3ePFn6N3+NDo1A/GN1g=;
        b=T6wy4kno1Q0vyTUEtBHGhVxCuqicRW83AYF4uG4Cx0niuyopI0e1aKupjht+CRH9mK
         OWEtK9JOeACQswN36MzLiv9ud4MU2A6hMBWDtYJOGQVHEkBoP5Ot7DXM8ZumNvlnVPIZ
         7upHl9fYXdPmjQmWUKechklsFjE7WrBI0Peri2zEKX0tXuKPa7tBeSMd7hswM9gbavXP
         RKQs3mg2VKP/x9eR+dRSoprzxm4tuxHtC9xxDIHiE5ZP79rQUtYpWpxhGwYvL8dNHd4G
         2dBql4zdC/wAuRiMwcUz95EGwWeSRmID6kuSiddDNxWLz4m/cQMjkc8ad6nXOVe2/cJq
         UVWw==
X-Forwarded-Encrypted: i=1; AHgh+RrinVZrYE18m8QOGFKuAcrpr/DWUVA9WVqBhfZSNTv66y0btvddETmfrlXNuYVYZVeqc+98TsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGcW/NUfYTIOgO4T0GAeS7PPvHeGIP/L4nJOrKECHz1fZChqC
	fnxOfFz12MNzPSkP8iwTGpn+Ok8o8TBgG73DUUxYaefxoolqXwVFFrF6pOqnDSvpNNNBnpXIWfg
	B9N4Sk4j4V2mul8r+wpsWcY4mwYubvyvjEYLB+MLe
X-Gm-Gg: AR+sD10g1mMaFpkxMRIGZbT3Zdg9jOl6yTzwnPt44wuORcW092yNRVbkXaetFhMUopk
	CGF3kwNLmPYiH4MzRK7a88u7q/XmR/nolKMosN3FSwvocrhtIjffbyNioC+X079SxZMl0lI/2rA
	6V2vsl61qLlALPf5UTn44KOEspR2blxNLzs3b3oXkHFFBcmEK7rgfpwUwsj+uEInBqB/scpfWKS
	AO3Y1j2hw/mVVM5jZqeTKtgUEM9P1TCddQXkSzntcARgGsPsQZQur60OCOnZLh6h/YivwkcQvFm
	uVb8BWHU2ZnjCSPAXbkJk4R6NIPhQoruku0hjnoPx7K7kKiU9V5i2FCHWFG2Kul80+oEV+V+8re
	wHdVSdIc8Bp695/8OKm8xqKbqlmq/KH31BSlw51VHfyKXLb21GSasx+pftD//Fs9OD+AmxRdny9
	0JOSiVXcAbKipk7Oo=
X-Received: by 2002:ac8:5e06:0:b0:50b:29da:ec58 with SMTP id
 d75a77b69052e-52dbed36026mr57945651cf.8.1787060238034; Tue, 18 Aug 2026
 06:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a7f3555.dbb3a75c.20434b.0005.GAE@google.com> <CANn89iLye45x8mhXm5-rcttmCqjDKEEXR70o9jJeFy0kOp0zbQ@mail.gmail.com>
 <an-hOd_nV-xUqpUq@krikkit>
In-Reply-To: <an-hOd_nV-xUqpUq@krikkit>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Aug 2026 15:37:06 +0200
X-Gm-Features: AcwNN1UcrJ5IZAqOPvRttNrvl55Knq5orrs6ZcU2L_AyLlI_kSB63FEa_T834ts
Message-ID: <CANn89i+iHTsnR=TCfkvtFPse6KCEuPwRfzmttTEyN+oKXEQZTg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in rtmsg_ifinfo_build_skb
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: syzbot <syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com>, 
	davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 1:14=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:

> It's not possible to create a macsec device with a key length other
> than those 2, but it's true that returning -EMSGSIZE in this case is
> not correct (-EINVAL + DEBUG_NET_WARN_ON_ONCE I guess).
>
> The real problem is that we register the netdev before private data
> has been fully initialized (macsec_newlink calls register_netdevice,
> then macsec_add_dev), so we end up reaching fill_info before key_len
> has been set.

SGTM, I let you send a patch.

>
> So I think we should run macsec_add_dev before registering (and maybe
> move those allocs to ndo_init), and possibly macsec_changelink_common
> too. Setting the sci was intentionally done late, so this bit should
> stay where it is.

Thanks
