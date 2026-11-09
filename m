Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794260613;
	b=AAjpfQPfU9i/L5lTshinsVKyJ5YlGyLTpWjydiflXR2bzcVHPyIi4hlzbRkVSND3RKKw
	 ryp/qb1COuviJmHhRz6CXAllGiTO1Q6FDyQZNgGc1U9iKC76xNVg8QniKUW2/e0TUG3ha
	 Kmqb6kUfxLTODd9UoiIGtJNrnNAl2tM30Upy5GzvCNX7bxsXoACEYYz942AiYiwQCCvm0
	 cF0U/Rq+5DBC83rLfWy5FJPjAbYIfGjaYA7CB6X7mIPTgrGLdpCRpicrVGHFzSVlIT0iM
	 DraiUZDqzA9QD1ETyMuB1tHT4R9mmAfB/N5Zs37M9yVT/cOIumQEDeeJtLawpf0BoGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
	b=YDUi9R3ggYGc23tomxNCnJSB1T7PXbLh3BYnEkBSj4X2FjUy9E+s0N1/8YEPPx4Ex9FZ
	 utms3Ysv59M37+eqQijV2u0AnX15t2rXSAEXIshtSHrftvtU3zdp4pt5W3xGO4U2O/rrm
	 jArxFRuULp3LxJn/9L8XKIHhZJfDXj7ZRJFRuSZyKqx2bFwuLPlPtv3ZrOlgtiHOymSjs
	 2YTEx/f9o0ICeXHIJxqBzEPQp3ZrEMZbDCPlHu8Vtdla7OLUHxWAunIGkaFjRcY6IXgK7
	 +VVQT9tyhOEr9TqoJsBsEevtDPYkGKn6MWzF8seQucDNbahFNwrsbFqKiTxCcFTJu2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FW4gnI7a;
	arc=fail smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE026606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE026606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FW4gnI7a
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea7190aea1so5998725ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:43:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794260612; cv=none;
        d=google.com; s=arc-20260327;
        b=F/C3/K89dvgp11ikgkAIuHqMiFWU4E3wJ9qYFTw7/e+HM/tgnTkeIfHg+mRuNo6/bT
         5GmuPJbe4m1J538ZU8RTcQJNyHx2TVovsA+EqJ3BQ8XZ0qr3JxA3siHorje6Cz2QjokY
         DfsHltpQfd2DWULbKNtBQjyWABiYDSbilDYvCwfKa1oZlDIdPleREDaNwtn9pqHSBd1k
         g55afbSZUBEOO7U1o9Qa3teEF+XYtF/+VyTtv2T7zKYrp9M2GecUTjEZBvMn/OuBBBfv
         SLycBtScMLEW+lZoKOL3KNU/HucC3krymLI0ouAiOiR5zfgnqAAscvYlNVPCTeZ74rV6
         pdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
        fh=av+8BDzheAUA2Cn4n+ZRXNrzYYGDUwmh0CvrkYia7Mw=;
        b=MXMILQZJBgfUANk0Yi0wMd2Snwely24C2exI5PwBh02EwcD8SAvjjrhVj6eLoT8Efb
         uqi8GeaTgTnZjgKb4EFRNHv7g5Ly6M8thmMVLgta0FAc/PRJfAmvGGAAr1cpuewhcJmY
         BiPhn1Lxmz0lkJk1iceAEUR+6sTyw1VvP62pDYBx7d1HZJjl06dGJ32VYU9jBip/qkpr
         e4kvjM+jI4dPgAD5wO2D/fui32re3aPV1vo5+cFWufDlC7fLYMIfHv/wPrdHzldCNZ0T
         AMrbaGJcaznH8XiYrnIHTa//vdh5QNXzL88cbJHZQV4TYUWtMnZEt0X5dtjKLdV8DFPv
         Tk0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794260612; x=1794865412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
        b=FW4gnI7aMUlA323PNxL015rukDYP04Zp2osLJYPTqp3cS7461mJbHNd5hvGgPfpIug
         L+0Doxyf2kU+3vFiciaolTBmV+ckqNY3nJAkw1+cZsmzDfX4nloMnQzdnKVJeX5cdnfK
         2wotiY4ynIUAgt66k7tD96aX0m3W2b2O9AQLAHaMmMe5KT9xZgD9kTHtwz4lIwsHtZve
         PtJNB6GXee8MKEY7ZymfwJMvkYKh9eFuzoPXYWhzRb9YS9OSBNTkweNp/uEGFSa9iGpQ
         k5rHAO+2EsG+r1J4qNIQJR5OoVe9LWRll48pS1Q9avCI47fRiWCb4zk5ljzciYcsUAvk
         Dk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260612; x=1794865412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
        b=1X9chmKgLsD05EQzg1C7V7/sJVntAdcH0oACmVV/uY/COV2Uky0BzVv/+rniTJVtwx
         SWuJZX5dRGyDc7zaKTpiZe36I7Nx1iWqTp41Vt/+MRN0XAEefa+oJCOvDWaeOMRXn64l
         rXLyXT6OWQ50K5qSRpd05uzir8jQWBxYwinkRkQlcZThnL/Q8o54MKCcgWUk8xt0U0mz
         EwuHHPO50WCva8ef7FIKMAmTD92Im7GtZmsanRyzumZfg80Jp5jHlmQwKtw8GDDQuSyZ
         RneLkDEUlWxy7NKUUXFz+FbisJ//PEzbJ1+jLWj1JPucRa81Y+MB0HEj1OmaBdT3YFyX
         qRsg==
X-Forwarded-Encrypted: i=1; AL+hErGsLKjZllC/rTiNMH3rXLESj6gShtCxhQlDFU+vXFPUHjaPWO4pYAarFAkgzJukm6u41vzqR3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uqygQ6XXN0r++yh/JQT0VChMnN3aQwVSmp423Ythfws8uT4IF
	bk6o/8lEfivXfkPhk7GOhcbsV5gsZHtjFw/K+6TC0d2i6uBWciQFdmvf0X4eILvW6yVRm1RFkse
	61pjZW7IKP26d0wJKbOg2vxYtWOTZdARcu8yr4e8F
X-Gm-Gg: AYBFou1s0soVOeWOjonsf56Eh0NsGkA007TN+QGuOPFCAbSyMy9G3YcCiisifUlGjlR
	eNH/x6fPV7krkQ38S/hWVrEU3dv/y0g6bc/swK8F715Jy7r2keMtSsGqc1ORMsdcKPQXLThrNza
	j1RcTNZr+Q+APqlUyYGzHLFme1U4mSKsnGgtFL338zJtbWf26a1hIOtvH6s32oaOuAnuNjoPQBM
	5s9BkbCMrtgLQ3nlr9iOFHesAopqZznPlNFJhlxzwXjJ72+wTXWwEM1i1S3vBay9PLU8lQzDjCU
	hqsEciPhisRz332lcyaqmQywtg/Tuhx+OTj519yR7Kyv3XF3Us9T5SMI7s8tzljeYfsyAz0yt8a
	M7VsQsSlwJjXtzjRi89MZElmiwet2tVCqRjOXGXaUPQLGjgxwuimKPsHt1HZZcIOPwHpF
X-Received: by 2002:a17:903:26cc:b0:2e9:5059:4477 with SMTP id
 d9443c01a7336-2edb9204fc8mr3620005ad.23.1794260612359; Mon, 09 Nov 2026
 13:43:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109131736.3060756-1-edumazet@kernel.org> <20261109131736.3060756-3-edumazet@kernel.org>
In-Reply-To: <20261109131736.3060756-3-edumazet@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 16:43:19 -0500
X-Gm-Features: AclHuK-NpM3KCLNneh-FJ4Qf-jlAznfnWoEfbHj5uijUkh9x-gO47OPcJX6vtyo
Message-ID: <CAHC9VhSxp6VuS_UKir8K_SPktik9Jto7rp-y+yi=V6b3rHR4+A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] cipso: unshare headers before recompiling IP
 options in cipso_v4_error()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 8:17=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> cipso_v4_error() recompiles the IP options of the offending packet with
> __ip_options_compile() before echoing them in an ICMP error.
> __ip_options_compile() updates Record Route and Timestamp options in
> place.
>
> cipso_v4_error() is called from the LSM socket receive hooks through
> netlbl_skbuff_err(). ip_rcv_options() unshared the IPv4 header earlier,
> but at socket delivery time the skb can again be a clone sharing its
> data with other skbs, such as the per-socket clones made for raw sockets
> or multicast/broadcast delivery. Writing to the options then modifies
> packet data seen by the other users of the buffer, and a concurrent
> recompilation would hit the same check-then-write race as the one fixed
> in ipv4_send_dest_unreach().
>
> Make the header private before recompiling options, as ip_rcv_options()
> already does. If the copy fails, do not send the ICMP error.
>
> The issue was found by an AI code review agent. It was not reproduced,
> and the fix was only build-tested.
>
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> v2: no change.
> v1: https://lore.kernel.org/netdev/20261106234313.2537882-1-edumazet@kern=
el.org/
>
>  net/ipv4/cipso_ipv4.c | 3 +++
>  1 file changed, 3 insertions(+)

My apologies, I missed that the v2 had been posted while ACK'ing the
v1.  Anyway, just so it's explicit ...

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
