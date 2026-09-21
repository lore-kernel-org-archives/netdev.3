Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC262E6CB8
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024833; cv=none; b=VJSY+BLrEt3Xbky2ndbSCtjMSTx8xCSuUhzdxCdH/2jmZQxXoMUNhugfvEnIVekWqao4hbsAcv8SGYisO0O1KVmdjbzIt3bf7W5Ya5bSSmdz6DwNdQ//Sm4ZmeTm6Ol3nCRVFFkGNWiWxvGsy/ek5l4szgxkxUmjXHbnzEJiDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024833; c=relaxed/simple;
	bh=Qgg2jfj8I0DSyFxrZZfdeMmjANs6OmQ1w2AFzDFHIkc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=el1EOkOqHIt9rJOzfRNthnkzmTzCyvCFqf23mDbHH5ShnCEXKAEu9KtLSuijSdRiokU66YdgzFbG2kgHw50apPQwoc9pHMmc/OmpvtcTG3ikvdR/SxBQyEznwQ2NgdSlI6XdsTKx2ZqZrSAb0HaH9wETbDr+Ekdwr8eLYArUS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtrDsGCP; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtrDsGCP"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac8d1eso26564547b3.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024831; x=1790629631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ii7Gh4oAdaXOZZuSQ3QehEmb1DVYOhw82tgsap0BzQA=;
        b=NtrDsGCPzDJepIIUUHCtjsOJTdE5NN+uWxhGyBFqRWbtpz41KXEHDwtswAclArYI6l
         askW+n+upTks73rZEzWxpGErQAPiePurX0SJ9/t6MuWzTBoHsG42HzgCrMfS8NvL+Y3b
         YnfEmOhWijpwfmQZbtApwmxe7O7lpsuQSzfuvQaYJog/A9d7rgmRio7l3vuImos0SXQi
         1feZaDfOLbFkGbMhh5UWdDcS+u5v87/68ho+8crZOGJ5IGYHhXPtZ9pZ57z7madUZriC
         HbRwiz20DGpSc75ha7dzC1YUNQpsw6J8uFvnxmwB+Mkq2EtwpJlLF8bIju2r0DjQ+jiL
         sfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024831; x=1790629631;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ii7Gh4oAdaXOZZuSQ3QehEmb1DVYOhw82tgsap0BzQA=;
        b=KcgmtJB1QqH7+mKsQ6ONkW4oT7vaPxomPdmGRXtfqaFS/+mK3b5UlKWFLkh3/UYvXE
         aw2g4vHiwdTKgrN5qVPnnvRxa/n7/XYmkj/fQuxxwQG32ACJ++eMe8+opmq6Nz96114w
         kj32AGLtupcePepwQHApC1yFD+7tRLeB2mwgLC9TwrnqsG5zcFeyIJom3g7QykEi5gMG
         5GPVXpNlZ2FiUJbDc7QbHNRQ3Cac65EZL168ZEYenK/LKhxH6DYI71Lo+K/bo7ephPFB
         Vft0OVzDrk3x6dPgJO0j96SFWYZypVDRTIWPQO7d/ETkxO16RQX5zWDfIA4iSn4tdpK0
         HjXg==
X-Forwarded-Encrypted: i=1; AKwUvBzyfeuHwI5rUHd4N3MoHyoUetvWJPaYyAW03xp3N7EFC9BF1URPpmhz1Eq7Qrs5NrjUnyUixlE=@vger.kernel.org
X-Gm-Message-State: AFuF++luSazjUPsgtJffo/FXOXs0vy6u1ZxmWHW3g1uCSeOcuag5z1lu
	JScUxMAhVCyAZk472VXEL2+dN+A/YUv3jfMaGy4mjiAStZxP2XodCRUj
X-Gm-Gg: AYBFou0urOXz4p2HVAuHBBWtzl8b1rctzwViyQbXzx/OvGbSU/q3gIlx5s1d78g+fW4
	9aodPT9oN1o26rZKbaki3IR9z0FcD7gIb6vqhvcq5zWPiy5UatgWGyNsJIOzCxd+qemeA89AWxA
	BmWTyiwGn5qFOdczzGYKLb66kEq+jjSWqXxTs2u7JKX561yZS8Xd3B9uM82RMymYfoVXHyaXi1t
	a9mOxXReFMfsRXW3yH25Y3ESYYpwT+RcLdMT8jLsXPnbkejhhiRo9KPiklLp/hWKLtXNU5ukhKU
	z5bAqPEVXE9S/ppKJpU60CSZkQHZy+KPV8blQaqGSlmh2Vgboc0oQfEFfJebgpuuahxZ2OIISvk
	K+bicSlv+D5gBltQNHTWAAzvQ8JFEv8XcsJicZTL1uKNOmsHLNno7D48YTl/KWuNLw8KMF4EM0x
	PLwirwgVLCoZe39qIOPhj6pCrBE6T0JUCJWMiJ2Ot7Y3kPZPzw5SNvPfEpLNXys8buhgpczFRyz
	TFEpwHUKqEDYnuhK0WTv7zTkcX0Wbbd6e6V4JlOTFWyjViGEeKL
X-Received: by 2002:a05:690c:6e85:b0:884:c81e:f868 with SMTP id 00721157ae682-8a253faf0eemr1790997b3.13.1790024830574;
        Mon, 21 Sep 2026 14:07:10 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a23dea35fasm1439557b3.27.2026.09.21.14.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:07:09 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:07:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 dev@openvswitch.org, 
 Wang Zhan <wang.zhan@smartx.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jason Wang <jasowangio@gmail.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.eb2b72530041@gmail.com>
In-Reply-To: <20260920131231.3610688-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-3-wang.zhan@smartx.com>
 <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com>
 <20260920131231.3610688-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP
 segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> On Sat, 19 Sep 2026 11:35:17 -0400 Willem de Bruijn wrote:
> > > -		struct sk_buff *segs = __skb_gso_segment(skb, features, false);
> > > +		struct sk_buff *segs;
> > >  		struct sk_buff *next;
> > > +		segs = __skb_gso_segment(skb, features, false, 0);
> >
> > irrelevant?
> 
> Not unrelated: with the extra argument that line is 82 columns, so the
> initializer moved to its own line.  The call itself is unchanged.
> 
> > > +	unsigned int max_segs = SKB_GSO_CB(head_skb)->max_segs;
> >
> > could this be computed inside skb_segment, rather than having to be
> > passed through SKB_GSO_CB. I haven't checked, but it would simplify.
> 
> I tried it: https://github.com/zwtop/linux/pull/3
> 
> It does read better, but whether to resegment is the caller's choice: the
> qdiscs strip the GSO bits to get one packet per segment (sch_netem.c:443),
> and a device-derived limit groups that output instead - which sch_netem then
> drops, because skb_checksum_help() on the first segment rejects a GSO skb
> (sch_netem.c:538, net/core/dev.c:3626).  The features cannot tell the two
> cases apart either: gso_features_check() clears the same bits for an
> over-limit skb (net/core/dev.c:3843).
> 
> So the bound stays an input from the caller.

Somewhat tangential, but an entirely different practical approach
could be to disable BIG-TCP when such a patch from BIG-TCP capable to
non-capable device is encountered.
