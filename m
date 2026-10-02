Received: from mail-lr2-f33.google.com (mail-lr2-f33.google.com [74.125.230.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F847532A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935534; cv=pass; b=Yz0jQ5WPDkKSGTDCGFeEKmZ+lcC0/DCiT1h7kjXRbLlnn7oCbMVQlmAG/eqA70lBIfzzsNoolOB6gbqbV63ITVyyAUccgQ6/iYl18SkYeTBQ6wSoVkr8z5HiLznkn/HpAy/8+5fl1KaNa0s1xdERS0lBpkPa+yzOSyoD4bkavaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935534; c=relaxed/simple;
	bh=KpRkC7nlG1sV7SwjB4i6DmP6K82SrvV9/kz1iBtQzrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLs4LZS9DAwDHOmoBBFjK6NvU1Ey07Qu9Bl26TVAAeBOC1IebVOAw/eU72LroND5LVjbgx0qnomXxnXmMir1fPOlChpP+ZTi0TNZMmwqTwHmJsTSgNElt2212N5XN3j3swBBSTrWXKKkiQy4QVSQjqgNubPSa+EzJQB5c3jqLA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwW9ak6U; arc=pass smtp.client-ip=74.125.230.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwW9ak6U"
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a87e95a73fso5239621fa.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790935530; cv=none;
        d=google.com; s=arc-20260327;
        b=fzgVgVZrNH+1AQP8jl8zhdGyCA/mjCc1z+Xk3BhqFleratidhFxgUlecfG9RQE28oA
         MhH/vxLCYVy1PAn22SY9K0p0+oK/91aVjesHce8lZLd7lG40v6r5XpGMBiCCHqSNaZld
         Shdn7q1YjttF/WmYL/pv4TQDEYO5Fi0VWWj378WZAqBqrD2lj/9dxsNtd/sGXUGWWx3w
         TarCh/Y3LXBTf+xrxK8FQ4RDA5pTnq/luBlYaD5KhHd/vpFa9IOS3UBm72226qXLikzH
         u5m0+UFvJlqg/Vway5H9HaRmw6zBgwGxQHbgTuHjArJt6wUiYTk/m9NrPSa7079DSVkG
         v+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrEmBqIQ5U75wKjWXMmdbPNpi9eyodu4H+Zn5/tv004=;
        fh=T7cBV5RR1Z0I9aiv8xu4h1Qxs09lDOtIOkRsBF3CCDE=;
        b=FT5hB9XP9AbCxDh+PZnjgdByebMXvAG9xP/riP9H/Kilhxb7zLCG4et5Jac+ivsB6p
         ThAXhe0LH0ONNI6WY8z1JeJP6Iz5Y4zV8OadMbxADBBfzYvBR6RhGB1BBXnJRRF8Dt6S
         QMktBGHe5VqjaGDjtcbylAbMG9+98bh84C/4zbQHOfbsbnKZlvPKTCugdPOXbiTH+ALS
         /LgyLw2Devu2UPCxUfNWzUmdleW5qYeqrvwizY0VIoVxQ3f+LVxh72lODpgSjoQIwdJX
         Zv37dmVENqYrx+Fyf+lPVPyY7Dqae+V2kiEIhI1Z9/56yi6p9HSnX7q2KyQpP72PTk+6
         qP0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790935530; x=1791540330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrEmBqIQ5U75wKjWXMmdbPNpi9eyodu4H+Zn5/tv004=;
        b=NwW9ak6UOQPxpFv/FmQerM5MLjLv+Ncp8wyBfFhNHr7Frmo3D5usdQAcvL/0rroVNY
         k8YRj8mu96jsANBiMFziP+PGFl3rkflsa2oymXeweFfVPAqQRx5ZOzgRo4FOeP433MZb
         2u8noZ13OVp2e1qYqAHlH3EOsvLAw0vGyINgYv9XzZp6b6p8cnAFA5Uqirb4MXUhrGhr
         GaZWoE0JwWsLRbsNKwi9pPN9b47YBDzXIxAhKCOeixsdJ+MgXTFgzAobrZ4MZlnbYlO/
         VsDZg5awe7FQliyPFAyZnpXLZEnmJvKNubOSTzu1ulwni3p9z9gq8GUgBqYXfu1pbv7/
         1XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935530; x=1791540330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrEmBqIQ5U75wKjWXMmdbPNpi9eyodu4H+Zn5/tv004=;
        b=pyyk2EyPIrRNyl3p4bAqFSOVJZj1KeAIAX+d1Rok+6COQOFx/st1TVbv3IOsyKNo+y
         rQnqBjUQz4Z1lkv/v56iLav0Pv1b7D3zgdfv12U5ygv2cY+pcvV59hQJKgAYr/Xerijq
         dP6DnolxcCqbITKnG03o1vugh4VnY1iDJ56zsdtFrKqsh3Cvs/Zgv6q9LT2vEPUPyN2Q
         bvutykX70zGzEAgQR0/kSDkLcasfxWoSpHzV+uBsrx68aG9jPmZjdiMw+kMa1uoU3s13
         B6kvu1GJRfbdiJjR/G+Lyw51imcJLn0cgAeHvIYW8tBkipN8IhmW3ABlpfUWNw3Tu2DC
         yiAA==
X-Forwarded-Encrypted: i=1; AKwUvBx73QCbhowTqQkd1VffR9PGvYR2Bu5xCW4D4da9InJmbOBSHWKdeBB6Rm8tUPQoRn2cGHM+v6s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPn4OMhgroe3bLqSQf+0ys85+3jn5MbhS71GmkJ5iukGxbSwf0
	opdWjtuJRBrzG8YkbWmC7Lw5Zvndp72btaXNIIE+2x90p+pPALjCnSQHAh3bm33YoMSfz+pdWP6
	PP0yIl3wVe7S9N+UhFJy6IWYjwP1Tv0Q=
X-Gm-Gg: AYBFou14Pkxt70CuBeFvLWniVESvumwKiR5AF71Ng3erKIs6vbHr6x0PqsnhJkWl737
	VOcC29quuNGnjTbdDaADjCvH1JJrk3AQ6NMx3XphdmrmJexsPRP7sg8jJqpPkaJKTqUp7PknOje
	vEM2sHbs5Rs/MMyyEJdoo4PJ80IQmk3lKhr2+PawzaosiZuSvy1LT4u3JGrItXHcBJKQEHG9siS
	TxYXZIGKGNTP5N7bgmUPgIIUCRUYKYGBkLjsWM7K3g6jfKdJx7guhDXtfxy9nrBGYzIGN4Y/ZzF
	3HQZPqiwdIS/4KXoJJFm55qIQKQ2otjUhCm+SIfX03VfTZHMtklbwEVkzrmh6jVn7pdVfwhHmXE
	K1vlNNNxzDt4=
X-Received: by 2002:a05:651c:1442:b0:3a3:42cf:c014 with SMTP id
 38308e7fff4ca-3a88765a8afmr6175741fa.7.1790935530006; Fri, 02 Oct 2026
 03:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-2-sigefriedhyy@gmail.com> <179089747717.434549.10025971158678601177@kernel.org>
In-Reply-To: <179089747717.434549.10025971158678601177@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 2 Oct 2026 19:05:20 +0900
X-Gm-Features: AclHuK835RXya2QRfyWHcfAV1rz2yv5rXyfDJb6TRXTUTekf2P7RB2gM9v6I-4Y
Message-ID: <CA+7S2vK-rJ7oJ89onostQbPeNq8A7rLgsd_=_D2AZ27Bg3Dizg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/6] netlink: specs: rt-addr: fix the type of target-netnsid
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

> - [Low] The commit "netlink: specs: rt-addr: fix the type of target-
>   netnsid" fixes a bug in one specific earlier commit, but its message=E2=
=80=A6

The Fixes tag was dropped in v4 on purpose, this is a spec fix for
net-next, not stable material.

> - [Low] This problem wasn't introduced by this patch, but after this
>   commit rt-addr.yaml still lists target-netnsid in no operation's=E2=80=
=A6

Pre-existing and unrelated to multicast dumps, can be fixed separately.
