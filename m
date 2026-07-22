Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466D34CFAB
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702351; cv=pass; b=VqIQh47Py8ldSSRbng16aArtZUAHrSX7QOzVSZ+eijpUMWErLVk4fTbatIiBW0EsVZTVekcosb03E22UIYAMswds+9xOQhHa6SnFjfjmHWb6b09inwloqeOnv6U5mCHuLVybu9ueocuG5pTYaYGuDEIPGWyRLIO0+i2Kncdr2To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702351; c=relaxed/simple;
	bh=HIE37KoHMHAXC854461zGzisSjmMaHFopPnXYPxgwAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae4uEisdKmD4M9D7NJECYBRc6naOs9qvTZMyb/YYMk6p8S99jvEEwc/dPS1LZTyx2i5mivEF7xKvvXK4QiH+UuohFZtB7Qtyhje0amJsvrPfYrct4gvpr9yeQIfcWwXOHXUtI3bxTmkCJ1Jd+r3ePdI/UdKgADX1oKHG1x9F7nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf4VhFu2; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf4VhFu2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so15802627a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784702348; cv=none;
        d=google.com; s=arc-20260327;
        b=FTZvinSuNyS8wKXpb5vxbYPKsoYk+NwfF4fv1K2HJyOx16CnLUmWSP6THxAqmHME6Y
         2p96EM9VcJbQHpproAsiKoirIMaElaanitoU5SLMzH+/xK12a+bJdqDdTT7M6bjLmuei
         BSxO5Kbs4/CoIR2PdBG6we9r71MIbTBti8nbUsyy9BSvgE0sgbJJYq6hWPSwF4zAoPSC
         tqo0Gff/Zwnn4WMPtCRgBPHCylnp1hAnDFKtS7hToIchVuc1kMNoXYIstp90TAwhLHUw
         xXDNOw92QyJjbQo42yasv3hOgEIjPZRlFTLf0QfLUpk9ew6xgVl0gMPVXfZpyb5TZkFh
         DMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HqcZEVXr35WoIysnsLw/6omkNUTAVW1DhB5S9YH6cUQ=;
        fh=UfJuX3KYVXWOEJJKLELwebX8RPAzsvN+amLkoDrmnMU=;
        b=GZadeiKSG5h4td01Fv+7dpMUhB1GF9U+gxM+AIRWV3LbjWycKZONPp3KkfOfHxrdcL
         v2ZVkPBc1cQ4IO4U28DPRv9eYN/COn217AnVS0c6daYBbfYgjP0MWdKmqt8cdtlmhdnb
         18JM+WwcZQ6Du7CVE9t4um2ajIoDcwpwHjn/rbGCimD2DEca8PN0uw5S/nwtp0LSiYaF
         4dztTuNYIojL7eWAOnoGqZow04foogtrZXGw2qLntCmjI6kDy+E2j20ExyGGqYXA+Av0
         9PA0DQka7zStfAgl7GGE/1tHWvFpPSDvHvdfrs69QRauHlVQYTx161wqahLHuDrVJ6uw
         67nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784702348; x=1785307148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqcZEVXr35WoIysnsLw/6omkNUTAVW1DhB5S9YH6cUQ=;
        b=Vf4VhFu2UYMOUlcUPW/Ueh3XZj0uwJ3boFbffmWxUsPyCJig2tYwPLBW0GbPtriotq
         Cm9wBA9ulcTH9HUBxQ1sz5MFR7M7TO0WhHadI7oiC1y/f4EQgpPLDG6AYXJsn956Ijmz
         R+b2D+pG7dzByHXw4ksR616+rUEW0ZSqza9QCyY782fOhbkMn43eJIhYqn7yZ4y3JWM5
         0LAHJNoqGNIulfnM6/LdAXD6IKVZGIZfWOEBD5jUwX+vxi0LaHpBdFLwU1nrhV9Yja7C
         RNlrhUyT6t3HLnFt/TljniHi9x5E60tDEV2iDBziXqBrqaP/d7U3I9jzKxKeQu70iypk
         oidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784702348; x=1785307148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqcZEVXr35WoIysnsLw/6omkNUTAVW1DhB5S9YH6cUQ=;
        b=dkbtrIWr719nPoQqaEEKxFTsHRl4VNtmAiRx1yU8wT0gPlv9FJ+dA0R7Yc09VQsXLP
         w7Y6dQ6p3CF/l9jSsLEgDSlEoM5sL5DWRoB/kvpTa9Q4o8nlwrK0JIOtt6xYV1e5OPQU
         LAKJ1he0gb97fdQju34Nfz28j7eREyb3x1/hUroP/IwC7/f+B61mdt+9lfwtptwUR+Yb
         ZR9e1cmxGJGEQj8ARWiRPwPwFkkFasi1r7nJkecXGX34U45KGoQu+98ZFOwPIrUdShWE
         8+lcMw2b39Q7t0VoAht9XXhOzC2m9oL3yyvhzi1r3XLgJuyMwAbZg8+583a5oC6/MnSq
         Eo8A==
X-Forwarded-Encrypted: i=1; AHgh+RrTYxjV6byOR2ec1eDsl+0b2E7iRcF9DjAecXe2En00cyfhz1tvn/cnGNp3OU2b6ONx+rOyWJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Lxc5Jl3H5CeXZSqcvNp7o0UvdbZFcwVPGJJxCyq936Flfmaa
	oOdqep8h/+MXFL/nkAxKR7+ibcNW52okDJGg44svjWlsjvafsQ1QOG843XoEbcFXcIJ3jTUH0zh
	KvzZX4JxUKli4DuT2cgTV25HMR8L1/Lc=
X-Gm-Gg: AR+sD10ghwYXW/xENDcTRhHc1NPQUG7S3NkYmrX2exdBfYl5oM7e9Z0onxx9uLbWxTf
	8u8qwJBQhETE/FADAlO4mh2taxi7uhitcuqptBfwMzF/i9Y9hfQH7nwvD2KsX3DAlFOwdyA9Arf
	vlUEvA001eHd0ok5ikeyZrj9EDDgU49IaDrXpGQhmZConmEOQn43L44czCDM41eBWCVXTJ+EL48
	gzWRe2shtb5lFY5F2nXq/Tx9gpSUYj5Ii4esVqlibbqI+Lo7atpq0LMI2g4OFnS8rltyTdbjEIp
	vWXBxbl6mL4FT7c=
X-Received: by 2002:a17:907:3e9a:b0:c15:cccd:336b with SMTP id
 a640c23a62f3a-c16b477c675mr1073652166b.31.1784702348036; Tue, 21 Jul 2026
 23:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709144718.64535-2-bestswngs@gmail.com> <20260721115912.7438f90d@kernel.org>
In-Reply-To: <20260721115912.7438f90d@kernel.org>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 22 Jul 2026 14:38:31 +0800
X-Gm-Features: AUfX_mw1GtdkaM2O1EvJgyJUI-NJthQRq6sSmKRvYnn_6H4g7HZ3GMMXKVK-0Qg
Message-ID: <CANgPUi1zzByN=x8kNHMQm0Mo-_Py4E4OLX6VvNbPseNxunpKEg@mail.gmail.com>
Subject: Re: [PATCH net v3] tipc: fix NULL deref in tipc_lxc_xmit() on node up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=89 02:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu,  9 Jul 2026 07:47:19 -0700 Weiming Shi wrote:
> > tipc_named_node_up() builds a bulk of this node's cluster-scope service
> > bindings for a peer that just came up and sends it with tipc_node_xmit(=
).
> > Neither step tolerates an empty skb chain: named_distribute() finishes
> > with buf_msg(skb_peek_tail(list)) to tag the last message, and for a
> > same-host peer tipc_node_xmit() routes into tipc_lxc_xmit(), which read=
s
> > buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
> > buf_msg(NULL) faults.
>
> This patch has been sitting in PW for 2 weeks, due to maintainers being
> on vacation. Please repost if it's still relevant.
> --
> pw-bot: defer

Hi Jakub,

Thanks for the ping. This is already being actively worked in another threa=
d:

https://lore.kernel.org/all/GV1P189MB1988CB4E92D2BDFB80894B4BC6C22@GV1P189M=
B1988.EURP189.PROD.OUTLOOK.COM/

No need to repost this v3 separatel.

Thanks,
Weiming
