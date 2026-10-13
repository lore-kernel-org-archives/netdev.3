Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A14052D4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887170; cv=pass; b=l2P27TW3C+HGBl6Rol9R1SODNw49o0kjQzV4aJl+Gukj6oCLpRNU8eneNYB3fN8kRt2aEtXU7IsAxbLgMl3UhfbsjczYdy/zH7CKU+iw09tQ+7iiLCPhzEYjx9e9CnfnoZNG3KYCgKaglBi069pExmsM5DaGa5GV9RCcscttQ90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887170; c=relaxed/simple;
	bh=30/nByOcJLdjUUYb6QfrK3u4hDpBRdXaw3vsv0P1mN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqn8wWcH+j9uIbFeTxHiS/WdZCFHw9oJYdrOIz5COrhb+7vL2d2jw2n2n2U9pfebh4qN3pM2zfCZO7i+wf8kTq3k/wU5Hn5kLa2Ki+qqygZJqDpDHwFNcxsVTrg62ZzqvGAKutZTdtkb2dnNISYfOfCyIFudbkc4o/d9ulKRGxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlvUzVj3; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlvUzVj3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a9787a14ecso19922921fa.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791887167; cv=none;
        d=google.com; s=arc-20260327;
        b=PHKxD7RjjNJX0FSPneWBwj0bO1BdYIq5G0r+kgEeVfSIKn1+IADL0ApggZGUbBWiEU
         5UExew1njezlo997WIoSu3W0HznA9o4BYQLe9ukAkx3vVeaTPaH607rkVdS5NLRXaY9Q
         R6RKWGbbFekz6LbDPDZjhOu3NrRAoDgjwNpkLZtYBqRmith9MEUmNjUK72EKtY58cZM0
         8t6jOQi1ZLVyjMEE+hS00mLxSXm0K6VmDJ+fvLQLv787e/qY0u7MSfNTG6FSWvKMJHqR
         raIvFLSSZmDg1FxaYrfQGr3d9d0E40y4W5rl8YtySaENWzt0Dpo0H/hbIvbBZOhQ1359
         eLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2iGlLnN9AnwU82QnbvfehXlTLjFdwbOP6w5F5kIy7w=;
        fh=LlN1ZhbXbsdSGGWetg0pt7KpjQSNrePMVupDja8sXI4=;
        b=IVYP3qjdbnC/QpwPVDXINipCW3HRDAVH4TbvhIrBdiZeNWbf5tsIv7Ph7g0yQogtEh
         mS6Q/YqESBJEF6yuF5RVtBkBFiaUs9LgS3tLMB4X6Jh81MeHJ75tmb3/SKQhVNu3FbJH
         UNPq9tLbPx+RbgJ8tBV/D2kqUXH9d/aZZRxdSRye9pRSv86BrB2VYtlk/yT3PruNtWNK
         HXnLXPN9CmlP6XRn3+JfPqrbwY5JDuvf8UVqb3AZoibcCwcbXsreXye/7ObU7nkU+wS5
         rTfhFu/BMizjEb/Tz0yL5scBusbSxgOCaLdAXta7GML2+AqdAibHVQS4vxzIwwneAqv+
         LJ4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791887167; x=1792491967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2iGlLnN9AnwU82QnbvfehXlTLjFdwbOP6w5F5kIy7w=;
        b=FlvUzVj3Hmts5PuHrpcKAJF9XR5pb0xq02Y804/4zuNTa65wn9HSIbWFmeVewetFdx
         JTqgqgiWGCweUr/fZCAinXjH4ZB/I9mtVem5TjUg2ihxvLDxAjZStYu7v6rQdsd0rJT0
         nYfrQRQne8y/u+OzJjLRTHAyfsfb2WQxuKoDOKQD6oklP23jsEz4jHzS5ood7tUlmviB
         nkgCEWtvpTMcE3Nqxlh6nz3no3u+tungwiX2xfP4uUUzi8vGbnNmoMVoBMDuHanIXFYb
         fAM5i9azUb1PVo1DNwih2DjHNYdwwL34LhjDOyJmedlg3U1DyWll6zw7FupdCChojSe1
         M0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887167; x=1792491967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2iGlLnN9AnwU82QnbvfehXlTLjFdwbOP6w5F5kIy7w=;
        b=VMRdZ+JgJgnQuGkWdLnn3VByoiiFae8d1SlLlxRBzs8ekFDucPcAaEgrrv6YFi8MrS
         rYsVg/6+r1IlOJAu/pPD9hrRUT233wpzJMjayuPxoozXiNFHZsEknPdTn2+NJ9cQ9j9B
         g+ct0D5qAUK9Es7t94lGIl3f4pD1fu2oct2/S7WX7t9emHiIJKXqHF9LH6aLWFkKk+TD
         MIOaDgIdk7nkS5MRfB79YEwEmMtJ+lha/FYZ8a04EUovG+E/AHS60MGC869+2tFwuFGC
         v8XB36lssZv3zRprEdkhmPqNpK5Dc3D3dyIS4Atek2EPv5ONFe31Cws12rTc2VUOeAUE
         a7wQ==
X-Forwarded-Encrypted: i=1; AKwUvByx6ZjQ4aBQ+siBifK7cLU63nrYhbHGXk2aLx95cSSIfJoSn2DHdtBsl/xMuZGWSN1gtrGesPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGSWFJ7quATvyS6l7Nnh5pLaffuPKCcm5DBp4cqK1zKw0G14mq
	a5aiLDaDja+SEMpY+fD2lBTjovMK5fN0DnwFAnKosBnuu+qqLwVCtt0ZQdJKk7aQpxEkwVmL1yq
	JFA/7vruWm2h9hKIA4abmMJ5eYCLYqQY=
X-Gm-Gg: AYBFou0738w0GeIjwJKgvAZUAjYheeJbIfFfbig8YnZUsbR/FrOqfX3st+u0B536kfN
	xF7FaaaGt8qO5QWg1RnXnWb4bZcM6CSKFL5fanKOcI2VPFTcRcpv/HFm391+gk0pna7dI/HeVD6
	bdIy10OHwS4pTT/Zr7T9f8AbvYZL/Y6PYkayCMaDEsCAq23H7h+9v6YygTd9PdBJuKjTzJEicV6
	g7t44OmcXK/OjDR3Tv1UthRUGqMZtQhSWL4ebzdNRurz2IfILKrcL3Cp5aEttc3b68MmHB3JBKS
	5dkpl3rZMDfNhOrqH8gZSn1bQksPyR6hlS8gotWVfY20JN0+7GbMLnWbezp0Xn3tDXQ4MNQPDVk
	nMFLeHrql1L89SZXj01gUVg==
X-Received: by 2002:a2e:bc23:0:b0:3a6:636b:63c5 with SMTP id
 38308e7fff4ca-3a9c5384f54mr25409041fa.16.1791887167208; Tue, 13 Oct 2026
 03:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012011707.3378-4-sigefriedhyy@gmail.com> <179185709988.434549.15422498299449004512@kernel.org>
In-Reply-To: <179185709988.434549.15422498299449004512@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 13 Oct 2026 19:25:56 +0900
X-Gm-Features: AclHuK9xbgdrkpalW9mtMclsWr4HeA1zLw1yC-dAP0vRwaQkMlm23OayOZqQ2Hw
Message-ID: <CA+7S2v+LHUWXQMD-cYPEzT5-f3Qhw_vz+LEssQH_A_oqDKtnnA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 3/6] net: add a generation counter for
 dev->mc changes
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> - [Low] The commit message misdescribes the precedent it copies.

Looks like a nit, will adjust it if need new revision.

> - [Low] The patch adds an 8-byte 'struct net_device *mc_dev' to every
>   struct netdev_hw_addr_list (include/linux/netdevice.h:253), but only=E2=
=80=A6

It seems to me this issue by itself doesn't deserve a revision. Will
fix it if new revision is required.

> - [Low] __hw_addr_changed() (net/core/dev_addr_lists.c:22-26) reads the
>   device netns with plain dev_net(list->mc_dev).

This was raised on earlier versions. Every dev->mc writer already
reads dev_net() under only the address lock, so this adds no new race.
