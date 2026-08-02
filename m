Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45A3BC668
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684255; cv=none; b=sLTpNpXXQzcczKEIqmaPtGXLITNUI6uWel651gOJSJFqEmB98i4v231XXQgx5BP4p2qLFa3ykBad/oWwtiRXOfU4ArT9izA1SBYoHCh9XAqKCQrRCo+CoRxzK5rWJ7uxpbaUJrVdaXKpDK/YM5xaxtlOefL3Kx0ma/CnU4OUeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684255; c=relaxed/simple;
	bh=NBIWxumnzTsxJP34PbfxAh3lCuJykFhWshOc21e//f8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LweOu2Kyl2bmupoNshEvZCJbNU6Ra72bREfhvMLagPwJfEU1X9EjSPanuRupvdWk+UE1j/VGJIIamZRgEKpbpjgUD3GTcZn1xBFZeWDHpRRpFn4rQnKOK7/rADH9El3A+7HADY5vv1mJMZuJc2ICQQlxQv9ekf1mXhe0aOQOA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8Oif0yL; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Oif0yL"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6688acd1a51so3732819d50.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785684248; x=1786289048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1yi0MlbglOo8ISfcdZsQ9nUGa/B8DfytigOzMq3SuF8=;
        b=J8Oif0yL2hbnX3ZPjtmj97vzBiCmeeLrdGSKSz/4XhsM2P6bkFxAIOuFKeJWatVnV8
         Inf1ZKRyUsipdUPsGkqds0Msbnn43dDWGTggHqqVeM6YKVbn45qFKP3jXvqg8m3MYIRA
         C6j/6pBjJJQjGpW8Hq1L0Mi1ZTEW2RBCV+wcLKmicEYyzCfELYQW0ybxumc+TwsVJpei
         pEKRFS5QDXtZKMdc2S45lasU4EUGnfsPGoF8XFY45YyATJRoLMv33UJeAs+eEkILDdNq
         do/MoEY54UfZC9sSpY5IFMCHShodZRR4qXndpqki6gVLK3Q0AlYXC34sHO7erv7GDWyY
         3B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684248; x=1786289048;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yi0MlbglOo8ISfcdZsQ9nUGa/B8DfytigOzMq3SuF8=;
        b=mJyNqVf+1eQPRH0KKqUR/+xzg/NqkUx739C3nxdx3cqFsIUrxomNi6a6nqcHzYrrKC
         vN/aMTPmSv1XnMOanZK0XRzbBBI+4dz18xNNbcCXD9dNG31KOKL3YFn+3lN/YelpVOHM
         t/bm4wnkXM8I8+t2OUqIkbwksDZRDGbecKd+9LDGWWvc6eav29HiqMTvJpW2bre4DgPE
         mHa7ZkUBaWkKs7AyqwGS6zkUBHMAL3VcPfVfri1i98Lmc3ZnfFnuZ7crRmDhsBsWrdZC
         K+0kCz9Ugd4x54Vg7LFgXq+8ilQi8s8U/mMOgAnUAM0cK29ZWAdsBXiCFkZQyku186JK
         Ddfg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9T9cewrdRK6rFqd9lgGfsLfWx3kT3l67mVVHF+l/7bbyvp57/h84j0wyBkbzk05vqgUE/2QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqJNToostVif+pe18N5ajubExj5m5X7uoYNiyRCJLLXNwKnwI
	b1axL45Yq9kE5SLSro0Nl1YhXQWCUJlEEZea+6wCgmwxZwg1oki14Dt5
X-Gm-Gg: AR+sD11flNsCG5DHSMnYCQhScLO+JAWlcPaaeF3zluQ80v5FQuj4CF6kqrbFtwXevGb
	3tEBU9+rWe/R/bUfNvPrT4Dd2dno15j2X3MVzlTXZBR7vdfcaXvE/FnpKH9lVwaK7y/+9xF4Jnr
	qrnS6Dm+RIaB+bQAplEOUTD7R9ZeWeGVtkkdmhuEJAYPEFKU1p7bOiBu38xJ6bMjKFfsHiAZe/l
	+7pQ64Khu9XwoyOiQMf2xpSlGMQN1hbZ/xxkwEhEIkFRtg9NT92TNOD4gF0Zzo8atws/x/LZGJw
	acYvD0o4dwhzwNR2HZNsBD+1z5MJjRyGaZQNNpflzVxEebs57WKcmL0IGJfIlet74fWWbzhsRh8
	U9X2quC2v3SOCce5z+Mj+mtM+M/LX/w/+8U+FSdKCwXJ6p7LD2JPkOLywaM1pubbmC7ljcBH6bE
	sR324XdN67oy2nlDNrybAWlzDH1v3KP+YR/QiyF+aWWQYASIzPzgH58iGHy4WPFnGJoxPDxXgGv
	20P6b5Yj8Fo3nXcOcH7gohjrwwVxJTULftz
X-Received: by 2002:a05:690c:6d8f:b0:7b2:1bf1:8016 with SMTP id 00721157ae682-81fd49c8728mr97600337b3.2.1785684248030;
        Sun, 02 Aug 2026 08:24:08 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf994a4sm40800307b3.22.2026.08.02.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 08:24:07 -0700 (PDT)
Date: Sun, 02 Aug 2026 11:24:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: manizada <manizada@pm.me>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com
Message-ID: <willemdebruijn.kernel.6d2e5b527c46@gmail.com>
In-Reply-To: <xPAgsryD7ZWPCp4djQ2-FNguiK-v4wu_PDQFjCQ22hABd2Y8C8lIXzAskbJ3S_yJDysh9izzb82ELATvewS2RD0o2VH3q7yirg9HH_mrHd8=@pm.me>
References: <20260721014117.2234892-1-manizada@pm.me>
 <20260723171437.784955-1-kuba@kernel.org>
 <YzGdhAUpdIBVpl5kEwszNWBTaolCS34_1OLI3kj9BiUkrxJsgcpIlsQKi2LnuvGQy76ugEGsZvZdB2Fgbmq1_QMpAel2h--RFpYe2ZIX7aE=@pm.me>
 <willemdebruijn.kernel.296b127eabe3c@gmail.com>
 <xPAgsryD7ZWPCp4djQ2-FNguiK-v4wu_PDQFjCQ22hABd2Y8C8lIXzAskbJ3S_yJDysh9izzb82ELATvewS2RD0o2VH3q7yirg9HH_mrHd8=@pm.me>
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

manizada wrote:
> 
> 
> 
> 
> On Saturday, July 25th, 2026 at 2:37 PM, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > manizada wrote:
> > >
> > >
> > >
> > >
> > > On Thursday, July 23rd, 2026 at 10:14 AM, Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > > This is an AI-generated review of your patch. The human sending this
> > > > email has considered the AI review valid, or at least plausible.
> > > > ---
> > > > tun: prevent underflow in rx headroom calculation
> > > >
> > > > This patch clamps good_linear to zero in tun_get_user() so that a large
> > > > tun->align value coming from ndo_set_rx_headroom() does not cause
> > > > SKB_MAX_HEAD(align) to underflow into a huge size_t when assigned to the
> > > > linear variable, and later cause the skb data pointer to end up outside
> > > > the allocated head.
> > > >
> > > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > > index ffbe6f13fb1f..d3be0f2d5df8 100644
> > > > > --- a/drivers/net/tun.c
> > > > > +++ b/drivers/net/tun.c
> > > > > @@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> > > > >  	}
> > > > >
> > > > >  	good_linear = SKB_MAX_HEAD(align);
> > > > > +	good_linear = max(good_linear, 0);
> > > >
> > > > [High]
> > > > Does this fully cover the IFF_TAP path when align is large enough that
> > > > SKB_MAX_HEAD(align) is <= 0?
> > > >
> > > > With the clamp, good_linear becomes 0, and later in tun_get_user() the
> > > > non-zerocopy path does:
> > > >
> > > >     copylen = len;
> > > >     linear = min(hdr_len, good_linear);
> > > >     ...
> > > >     if (!linear)
> > > >         linear = min_t(size_t, good_linear, copylen);
> > > >     skb = tun_alloc_skb(tfile, align, copylen, linear, noblock);
> > > >
> > > > so linear ends up 0 and the resulting skb has skb_headlen(skb) == 0.
> > > >
> > > > For IFF_TAP without IFF_NAPI_FRAGS the code then calls:
> > > >
> > > >     skb->protocol = eth_type_trans(skb, tun->dev);
> > > >
> > > > eth_type_trans() -> eth_skb_pull_mac() -> __skb_pull(skb, ETH_HLEN),
> > > > and __skb_pull() has:
> > > >
> > > >     if (unlikely(skb->len < skb->data_len))
> > > >         BUG();
> > > >
> > > > Since skb->len and skb->data_len both start at the packet length and
> > > > skb->len is decremented by ETH_HLEN in the pull, would this reach the
> > > > BUG() when a user writes to /dev/net/tun with tun->align pushed above
> > > > the SKB_MAX_HEAD threshold via the OVS/netkit/VXLAN stacking described
> > > > in the commit message?
> > > >
> > > > The pre-existing behavior at align == 3776 appears to hit the same
> > > > BUG() and align > 3776 pre-patch corrupted memory before reaching it,
> > > > so this change is an improvement, but would forcing linear >= ETH_HLEN
> > > > in the IFF_TAP path (or calling pskb_may_pull() before eth_type_trans()
> > > > regardless of the frags flag) be needed to close the remaining panic?
> > >
> > > Oh this is a good catch. But while making the TAP pskb_may_pull
> > > (ETH_HLEN) check unconditional would address the eth_type_trans() case,
> > > raw TUN with IFF_NO_PI also directly reads the first protocol byte from
> > > skb->data, so we'd have the same issue there.
> > >
> > > Rather than add consumer-side handling for a fully nonlinear skb state
> > > introduced by the repair, maybe the cleanest is preventing TUN from
> > > creating this state?
> > >
> > > 	#define TUN_MAX_HEADROOM 512
> > >
> > > 	tun->align = clamp(new_hr, NET_SKB_PAD, TUN_MAX_HEADROOM);
> > >
> > > This fixes the original SKB_MAX_HEAD() arithmetic issue, and also preserves
> > > linear space for both the raw-TUN protocol byte and the TAP Ethernet
> > > header. The 512-byte value matches the existing ceiling in
> > > ip_tunnel_adj_headroom(), so requests above the cap can require later
> > 
> > Is that a ceiling specific to ip_tunnel or universal for tuntap? I
> > suspect only the second. In which case this would add a new condition.
> 
> Yeah you're right, that was specific to ip_tunnel_adj_headroom(), not universal.
> Sorry for the delay here, the more I look into this the more potential issues
> I find (including couple more I'll send a patch for separately):
> 
> > 
> > > skb expansion instead of unsafe preallocation by TUN.
> > >
> > > Does this sound reasonable? If so, I can post v2 using the TUN-side cap.
> > 
> > Why NET_SKB_PAD, aside from that it happens to be larger than both
> > IFF_TAP and IFF_NO_PI cases?  (good catch on that NO_PI btw.)
> > 
> > The IFF_TAP case already has a pskb_may_pull, but only for frags.
> > Perhaps we should just always enable that. And a similar check before
> > the NO_PI case reads skb->data[0]. That is in line with standard rx
> > protocol parsing logic.
> > 
> > Alternatively indeed clamp, but to the true minimum required values in
> > these cases, which coincide with the values tested in pskb_may_pull.
> > 
> 
> With NET_SKB_PAD I just meant to preserve the existing lower-bound behavior in
> tun_set_headroom() for negative/very small requests, not set a protocol
> minimum for either side. 
> 
> RE: pull-based alternative, it sounds reasonable, and making pskb_may_pull(skb, ETH_HLEN)
> unconditional and pulling 1 byte before the IFF_NO_PI read would fix the
> immediate fully non-linear skb. 

This is probably most robust. The network stack in general supports
non-linear skbuffs and uses pskb_may_pull for safe access.

> But, those pulls would still leave
> skb_headroom() unbounded.

Would it? That good_linear limit itself was introduced to bound
headroom, in commit 96f8d9ecf227 ("tuntap: limit head length of skb
allocated").

If we ensure good_linear is safe, then all allocation paths should
create skbs with a bounded skb_headroom.

> mac_header and network_header are stored as 16-bit
> offsets from skb->head, so a large-enough headroom can still truncate
> those offsets, so just pulling the packet bytes linear would not prevent an
> overflow from excessive headroom value.
> 
> How about this instead?
> 
>   max_headroom = min_t(size_t, SKB_MAX_HEAD(0), U16_MAX - 1);
>   
>   if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
>           max_headroom -= ETH_HLEN + NET_IP_ALIGN;
>   else
>           max_headroom -= 1;
> 
>   tun->align = clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
> 
> This leaves 1 linear byte for the IFF_NO_PI version check, or a complete Ethernet
> header for TAP, while accounting for the NET_IP_ALIGN added later via TAP.
> It also keeps the requested headroom within both the usable 1-page skb head and
> the largest valid skb header offset. The 16 bit limit would constrain just the initial
> headroom reserved by TUN, not any packet-relative offsets added in later elsewhere.
> 
> Would this make sense?
> 


