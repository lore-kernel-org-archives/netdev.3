Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE821A01BE
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015437; cv=none; b=t15DY/HOzIMTJzQx1yV3vxHeDzF2shv9Wx1UinKfofsOX6GFtHVS5xEqR2QbEEq3je8Npo1M191kbZ+dq6eW/V15cCDtEEAJeQExyeLOzqou6GAe2RfRhMzRmVj6/Vk9hgE2PdkU3KpD/upL3C+gasIyFiQvDmA72K1FLUUKrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015437; c=relaxed/simple;
	bh=ohNaMrDQ/JgMPviWwOkKqKqHY/V2plWsxYZyD3MnJfU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SYfm0jqruBz27ElDAofhbckxPTrVVzENxW+FzqBMPnjM5VUQcf99CI7vmlX20A47hNt2+eh/nIOJ763k5kl3ix7whVwtXzoDfyM1IFLJ/sMcCiwPdXSd8cNVqPjSejD/o6S8TtP4yXtijTDTOlWCWdD3oa3GoE7shUYZ1wWXMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBtBBr+L; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBtBBr+L"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ec29f1d07so16907777b3.1
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785015435; x=1785620235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SLp9SoQShj263wGMie8yzaly9CcfswT8t57gtjtVJDA=;
        b=jBtBBr+LiMoBUaZroKP/FLDPQMzJJnxiGo/whZ0sfBbvX8kh3aoF7tcuTNbguuYmHb
         H/X562ZSEg9WH3F2IAMFx8X/n+MJPJZi0vP3OAXeRHTNAcmshhz78UrTAhpR1xJwmCmV
         QxsQ8QYBIilfKXkTcYmnVcFsrLoqDX3IsDTg+0sr9BMWwUVU3SJYBZ87RzYdW9ZV5Rnp
         c70Y/OWE1ReXtrYmkMTM6xXBBTits3HwA26kXBKVwLaUDsJa0layZ+oBLlNjffd+HYWZ
         QphfTLpjECCaQ2jEgP7QVQ8rPMlssy7A8Bqvucr9/pZtvjYRcmBRlaHL1QImhK8b37E4
         xiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785015435; x=1785620235;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SLp9SoQShj263wGMie8yzaly9CcfswT8t57gtjtVJDA=;
        b=OoAfYA4F+CbwjIwFOI4g6CxRWVyOm7tmJNdlgpVL0csokytYdi6talR1zDQ/V4rLXa
         CoO0HJHgtsnH/7DsM64E876sfD9WdQ+IhzIHwmRbueoiP4mQVIGdaYCvRNReZZiTwwJX
         SzKh24WgZyNcWZ4n8SdArClzC/pUCT1rqwjxkq6fQZDD5aR7puKAYPe3RHB+QpTaAs5k
         SjM+qM+k2paaYcDS0HNQGvP4p1fsoD3XCJTQzyMXJnuy9Kr3REtkdlCbBOowF9S6Pa3Q
         SkVEbWTWLG2u1TbA6jdtxRoEX6W3wsJNPvSn2vlU7qgclHrST1WRRoHvIbuIksm7eC7t
         wdhw==
X-Gm-Message-State: AOJu0YyEHqxV4ZXUbMJHvutcG+2xdtegs88dM/c4DalEQUZo4H1KheM5
	CBY8BY7C6z979J1KbFBGQK6zs2zwyaRLiswaRKdgJKN7imXiOI1er9/d
X-Gm-Gg: AR+sD10AM2jI2DmYJo9gXbn9OdrJrHOH1a6hRKBd+NY2GAWzcCCn5EgyiLv8wcXYEyr
	RK7ym5AV/d8fVbT7b86q9527Pr5d9d+2gpZSTxEQ67Dly5Eq1Qqrl562VcOridg4waWHbt0GXX5
	WO0BcaBtTH43mmxMK6gs+2CdWVfeCfaTYrqv1U5Dh2UbqAnki2za7kAbvoi3GXXOVy0HwzTBm30
	JTPB+ZLrsym/X0WdSrYZFIjFgM6YbamcvBoUzrdGzP+KM3uCnlJydNVnqSQd5S0w1NjMJP2d1JC
	0ONsEcaQofI15MZTmJkxZ7bRp645ZTfhzjBbmE+Du6p+iectDim+NKcUXgqwjGMnqoYWODtGmcc
	0t6yqD9eL1P/n5AurAtKlz59RUlH6zojXyFVaLVUUlHPNlQIXbdJdbc6/3BtcbjijChc2rNZZmg
	wnGhtc6KypP9WmzZc7cOFta2U5VkaQp92/QePcto8zyO4dYtVuWKmwwTE=
X-Received: by 2002:a05:690c:9a0b:b0:81c:b865:221e with SMTP id 00721157ae682-81f69eb7d34mr9839847b3.70.1785015435195;
        Sat, 25 Jul 2026 14:37:15 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f658d298fsm14756687b3.32.2026.07.25.14.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 14:37:14 -0700 (PDT)
Date: Sat, 25 Jul 2026 17:37:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: manizada <manizada@pm.me>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com
Message-ID: <willemdebruijn.kernel.296b127eabe3c@gmail.com>
In-Reply-To: <YzGdhAUpdIBVpl5kEwszNWBTaolCS34_1OLI3kj9BiUkrxJsgcpIlsQKi2LnuvGQy76ugEGsZvZdB2Fgbmq1_QMpAel2h--RFpYe2ZIX7aE=@pm.me>
References: <20260721014117.2234892-1-manizada@pm.me>
 <20260723171437.784955-1-kuba@kernel.org>
 <YzGdhAUpdIBVpl5kEwszNWBTaolCS34_1OLI3kj9BiUkrxJsgcpIlsQKi2LnuvGQy76ugEGsZvZdB2Fgbmq1_QMpAel2h--RFpYe2ZIX7aE=@pm.me>
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
> On Thursday, July 23rd, 2026 at 10:14 AM, Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > tun: prevent underflow in rx headroom calculation
> > 
> > This patch clamps good_linear to zero in tun_get_user() so that a large
> > tun->align value coming from ndo_set_rx_headroom() does not cause
> > SKB_MAX_HEAD(align) to underflow into a huge size_t when assigned to the
> > linear variable, and later cause the skb data pointer to end up outside
> > the allocated head.
> > 
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > index ffbe6f13fb1f..d3be0f2d5df8 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> > >  	}
> > >
> > >  	good_linear = SKB_MAX_HEAD(align);
> > > +	good_linear = max(good_linear, 0);
> > 
> > [High]
> > Does this fully cover the IFF_TAP path when align is large enough that
> > SKB_MAX_HEAD(align) is <= 0?
> > 
> > With the clamp, good_linear becomes 0, and later in tun_get_user() the
> > non-zerocopy path does:
> > 
> >     copylen = len;
> >     linear = min(hdr_len, good_linear);
> >     ...
> >     if (!linear)
> >         linear = min_t(size_t, good_linear, copylen);
> >     skb = tun_alloc_skb(tfile, align, copylen, linear, noblock);
> > 
> > so linear ends up 0 and the resulting skb has skb_headlen(skb) == 0.
> > 
> > For IFF_TAP without IFF_NAPI_FRAGS the code then calls:
> > 
> >     skb->protocol = eth_type_trans(skb, tun->dev);
> > 
> > eth_type_trans() -> eth_skb_pull_mac() -> __skb_pull(skb, ETH_HLEN),
> > and __skb_pull() has:
> > 
> >     if (unlikely(skb->len < skb->data_len))
> >         BUG();
> > 
> > Since skb->len and skb->data_len both start at the packet length and
> > skb->len is decremented by ETH_HLEN in the pull, would this reach the
> > BUG() when a user writes to /dev/net/tun with tun->align pushed above
> > the SKB_MAX_HEAD threshold via the OVS/netkit/VXLAN stacking described
> > in the commit message?
> > 
> > The pre-existing behavior at align == 3776 appears to hit the same
> > BUG() and align > 3776 pre-patch corrupted memory before reaching it,
> > so this change is an improvement, but would forcing linear >= ETH_HLEN
> > in the IFF_TAP path (or calling pskb_may_pull() before eth_type_trans()
> > regardless of the frags flag) be needed to close the remaining panic?
> 
> Oh this is a good catch. But while making the TAP pskb_may_pull
> (ETH_HLEN) check unconditional would address the eth_type_trans() case,
> raw TUN with IFF_NO_PI also directly reads the first protocol byte from
> skb->data, so we'd have the same issue there.
> 
> Rather than add consumer-side handling for a fully nonlinear skb state
> introduced by the repair, maybe the cleanest is preventing TUN from
> creating this state?
> 
> 	#define TUN_MAX_HEADROOM 512
> 
> 	tun->align = clamp(new_hr, NET_SKB_PAD, TUN_MAX_HEADROOM);
> 
> This fixes the original SKB_MAX_HEAD() arithmetic issue, and also preserves
> linear space for both the raw-TUN protocol byte and the TAP Ethernet
> header. The 512-byte value matches the existing ceiling in
> ip_tunnel_adj_headroom(), so requests above the cap can require later

Is that a ceiling specific to ip_tunnel or universal for tuntap? I
suspect only the second. In which case this would add a new condition.

> skb expansion instead of unsafe preallocation by TUN.
> 
> Does this sound reasonable? If so, I can post v2 using the TUN-side cap.

Why NET_SKB_PAD, aside from that it happens to be larger than both
IFF_TAP and IFF_NO_PI cases?  (good catch on that NO_PI btw.)

The IFF_TAP case already has a pskb_may_pull, but only for frags.
Perhaps we should just always enable that. And a similar check before
the NO_PI case reads skb->data[0]. That is in line with standard rx
protocol parsing logic.

Alternatively indeed clamp, but to the true minimum required values in
these cases, which coincide with the values tested in pskb_may_pull.

