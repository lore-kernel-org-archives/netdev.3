Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794497746;
	b=uHXVMqaaZcSUDKWBvaa2W7DYBUCPfj5Naar4JbvbcBySc8EYf0VoCZDrJNtWLK5+9GTW
	 aQaAaSL7ldQXcSjisYukfAihYGergm8UA1Cjby4jl4Km4/2Ner6V/RuB2hG8ZQYK+w4rQ
	 aBe48xMMJGpK8Mpz0elzbDZHqNpEcJWv/1uD5Rc29ycZGOQ8xOSIHSFDN1qejJrnbfu7W
	 1Etsyyxbe/7Uc86Q/ZaZvvaBcdAKQa1FbxWzmJOHRZfhTNX50B5GkMkgUm9r4L/MB9zdR
	 PxPGJXmKTUu2ybQgppPe+r0EGTmNFcArt8kEaEZ0JMaZJVPNVrBPZ85MiQxi92J43WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vL4vwsQsE5/zV/F3IafCkPB1dlrGK2hIbWUCOVgrMnA=;
	b=eTG60MDMQqrauJEHZLcMzUz/v+BEP3z8qL2i6/vhsDcjkrkJQ9fdojnk4Px0xg8ijxnr
	 bsELrfBo33nu8MAAQbJQ6Qv9D9QwQG2Ha5U6TK2+G77WpIS27OmYnDjr9a95bTVk9+gNz
	 0Vw104sVuRVGta8jJwQSShKmIm5QlaDn3aaqvUN+M5f3NcAefl/vjJb3b09eLIzvcUG+e
	 KjayC06HL5yWR6pdLNCFmp8MsMxKT2ugQ3WLQzEMgFDHR27zaybbIg95Fecf6vihdgVqC
	 nVKsU70ryrwCqBYAuRT1NSk7brPaRBcNCcC58/d193Ey05QClwVPYoDenGOwpCRWzzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQsIqYvw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C2606A332
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61C2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQsIqYvw
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4e5c8b3facaso239720b6e.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:35:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794497745; cv=none;
        d=google.com; s=arc-20260327;
        b=L+hhmgpxC39v7WInaRR7pkQQ5RSzs7nIPS4HLxNJFO8An4fNmWaFViPkh5UTL4lUxY
         sBxPorEJgwT8YRauU6vIbi6f9iQqFOLvu+oVcKaZLYB//rwgx/8DDeJE/vq74pIsgxSQ
         LUELnWgtE6sNoVT4Xe0pHuLzTd0Q3+qgh50qzauo3qUw2U1ygnDUlNFWYjSytvndxIsi
         ec7UeIQj+q5budANh+PJ+HwptGXIPUwfqfiSU9ph5sffNjCb5Fi3cL5rTk6CurjCbMLO
         GE0IrKvc6t2g/1kBs6IR9akSkVEOp0wh5bfQRv3ayYwIXaO5cdSzHyNF1+6iXvyhMGKZ
         ZYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vL4vwsQsE5/zV/F3IafCkPB1dlrGK2hIbWUCOVgrMnA=;
        fh=HPkdGrPJ0xBQKGkgucd4btzZqSW64XdHNe8TlITZqFw=;
        b=FDBUaNpohq49YWKlldg7aXP37EHN/74tC8oR9/A6Wl4eJ8c8yQBK2br9GP0Ne4F8IC
         uxsJwvztvht4mKFME1ne4+tSqkRCcInWIaR/JY25uO917YlVDXYgz+/BfNp3Md8xGsma
         2jZ54liqJxVM7YKgbM0ZILevbN6V0PN8AoFafTrQRwZ13zPJNpkDErtZWiBMhyaDKpRo
         xGAdPEc9J5T5zUpdnVSrrspKEkWHDj79HDxE/YCIfTmQD9H9YDcEgAq3GQ6p3lSbRAYK
         KJdPiO2pujux3iiUCwbVHzuQDGbYNdA3vAEpKBo7wp3iFKS3lHjX5FjEkA9tnQimiJsP
         2BRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497745; x=1795102545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vL4vwsQsE5/zV/F3IafCkPB1dlrGK2hIbWUCOVgrMnA=;
        b=TQsIqYvwtqHYtFKU0UlwxRAkmxO+dVnW+3b9OJNO3JmWQbvPKRsFqIEDcr7kCRTl8I
         yUZ47jfwwlPmV/UzJepyHdzI8zZStYCV8JAHKGg0z9HL4Es4436K/4egi08jpg4A9fYa
         EDihUiyJwIK7Ko3PxVnPIa8M+VJInUyM4bMP7vMACRlh/6XWNDOBLRFpOWMtmhjzgX93
         zqdonhJnX589lfOdLdQpl+AQQU43l+bOQmjn4yEf6eHIj4Y53B5plxpddDbNZnKPG9Hi
         EJYmhnyttvd+rCmOsR1PUdwrmBbMdV1/QFZJ1o43AAx+vHf+GfhaWNmKFaO3ii+e0ZEl
         YvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497745; x=1795102545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL4vwsQsE5/zV/F3IafCkPB1dlrGK2hIbWUCOVgrMnA=;
        b=W+rhDiP2oI53kbQ221Ne0r/1By0uXN4E2Y71obYMg54BiCcbT4rN7uKQ32cpfe4lTt
         YoGgouybgGhBeTq3ksZcoyBGkAWUECR7thYEwZmXcHEUiT23G9PX2DB4LaYEELhaeL5V
         UcOTNho5hfrreZbLrV0u3onc44oArcD7DPy92OdlGIbwNR/Szy7ZVc8XcevG6TIWpGh1
         d9AUVd4rRBngOdo5qIHtSsf1X81V/sj0K+HxJxRgaLCGcFPc7JZ3QaTwb38bFmw0ETEM
         iIvT3huw7qFaNTBirl9vKSgGidyo1DFWblBvuX9699P782GB75MHrK/KEeP7Mjz4ZF1y
         7LKQ==
X-Forwarded-Encrypted: i=1; AL+hErGY/+u2cPEiThHiPpbPfiRurs3s8O7qBik51IN2HbxeWXFSip4sbAzHe3RgWMlZd49THKx/cZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DcyA8vqYZO4Zp+5+ugJ2hckNX2NXdbesaFdbwtzZ+HV3nvPdG
	TNRYvm7y6RgjY1q7D+C1QPj92srwNVjY5/ryEGZiKKjWqlLZBiGu19uig8m9wopiWXpPTzchigV
	wMYpmbsJyLoOQ1qb9f3wkHQuGsI+tJqP6rSJ9tQ4=
X-Gm-Gg: AYBFou00bZoHg2h2NpDaR1GgvzZYELT0vpRhm0CtOlM9fj5I3xX4WQ3LPDZoi6y8DN7
	4EwISAWngO4Blxrwi1fMweHqsNCwskT7nszMmd1iu4CGoh3nkln1Lhf6t+vVSbs5cvSnlh1jogI
	Fb2Ke/sy/EdqjlmKQj9pmMAxDD0EiU7eue7Y50CUIEiZk8c3ImNihVP+Rmi1IkSu2Ws1W6Daj9X
	mGF9643UmJd7OAcKE1tETrpcrmWEXA+flSK9fA3WeDpUC2xkA8ywvVWSDM6GD2+ZS+Sy3QUC2dw
	KhTDEp+BlleTHHg/P0aPd4+fdSxyqpmnd7jMuCVNmdiCUcZ+T9FCBr4ssZxg+9pHE1xkYnRuk7w
	hUnmm8n4/YJpqsuDKFD6UYwwzqZpoaYC4OzQ9K/NNCPkb+/fp0xGYyA==
X-Received: by 2002:a05:6808:10cd:b0:53a:5618:af49 with SMTP id
 5614622812f47-56b9334ada5mr7407026b6e.1.1794497744766; Thu, 12 Nov 2026
 07:35:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-netcons_double_cleanup-v1-1-d5ff8167e05a@debian.org>
In-Reply-To: <20261112-netcons_double_cleanup-v1-1-d5ff8167e05a@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 12 Nov 2026 15:35:33 +0000
X-Gm-Features: AclHuK-tQJrPNW5sGGep4G60vDD9vdFiHHDLPuiFhEtYncUeLh7f5-NDadEgubE
Message-ID: <CAGSyskXhb_d9q0-+NDyVYtNF4oBVhEuv4M6kx0GGP-QrwYRn7w@mail.gmail.com>
Subject: Re: [PATCH net] netconsole: harden the enablement through configfs.
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 2:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> There is a possible race when enabling/disabling the target through
> configfs with netdev events that can call a null pointer dereference.
>
> My robot was able to come up with a reproducer by adding a bunch of
> msleeps() around.
>
> The race is basically this one:
>
>   CPU 0 (enabled_store)             CPU 1 (netconsole_netdev_event)
>   current_enabled =3D true
>                                     nt->state =3D STATE_DEACTIVATED
>                                     do_netpoll_cleanup()
>                                       np->dev =3D NULL
>   nt->state =3D STATE_DISABLED
>   list_move(&nt->list, &target_cleanup_list)
>   do_netpoll_cleanup()
>     __netpoll_cleanup(): np->dev->npinfo
>
> And kasan reports:
>
>   KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
>   RIP: 0010:__netpoll_cleanup
>   Call Trace:
>    do_netpoll_cleanup
>    netconsole_process_cleanups_core
>    enabled_store
>    configfs_write_iter
>
> The disable path used to call netpoll_cleanup(), which skips a netpoll
> without a device, until it started deferring the release to
> target_cleanup_list.
>
> Re-check the state under target_list_lock, which the notifier holds when
> it stops a target, and queue the target only if it is still enabled.
> Mark it disabled either way, as before.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Good catch!
Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
