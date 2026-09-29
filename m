Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D553A8B9
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694027; cv=none; b=HQYk8to8Iu0ciyHkr4mzgbLpSZaIxJ0wWtoPh9CuFvT4wBsS5mnP++j7ZVYo5imRGTuPpoK/Nr4kLGx9pzVR/s+emrrx5My6APVnK0rzlZjozK0PNT2RaAGJhBxsKIor49/BKN5zDkaEVrCyGwzzc1quWBWmtCqOxeZambOHLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694027; c=relaxed/simple;
	bh=CAmudlg0xn2hGjNMEOPUyBlm+xJ09A4y2z8+MD5wJjs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ARxo/JGVdptWU+X3evTAW2iqVzyORLTOZ2oSZxikZpp84oGUiri5+D6sSteh3GbnTTinkuAXUCXrMSsHRKLztw9GuTZGXlmgOM92iH0s5P6WB9IJuXZBTyekUjqT8yjohXO15RpTIOp9qxAAnPEUlbUlPp6jhm8hG83apzbSw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqRFVRT0; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqRFVRT0"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67568357b63so531233d50.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694018; x=1791298818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b6UErMubCmO2CcNyI1La3nRnGEZWzLXBEgmwIv/Q3R8=;
        b=sqRFVRT0f8eAmkEsPdIvK6+3gfgiNEfboD1jli+xSDJyZ2P92801+Q1qI9ZhBBY4iE
         WvblSLFZyw1hPnIzBUNpAYxyimcIfwL4yPPo5KMuzDQK4EAVDlxBy3UD6HA54T6YHEAj
         r4QX+3fH90yGh6khYRQafacgiI2KUBP1BEHojTNfOWbuIYE2iZDEEWBIgK3dA//p0TKw
         GFXD5W6zXlj0BIK18RdbLOpcsHT14odVNU19mRYVF68KOjonbU6Fyc72kxEisnB8FixK
         v70oTrday2Is4laNFi1dCA0S6igFFEvVBfVqJWqLOxHcaHlkQIISSPGNGndw8pIBuYUh
         lCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694018; x=1791298818;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6UErMubCmO2CcNyI1La3nRnGEZWzLXBEgmwIv/Q3R8=;
        b=vtQBcNB8NU9tgW4fvdWJ1f93y1+FEeDAl1epd6VhVzsv839/mbu0vhUkBzMMHr7VC6
         wAncFlrGIDnc+f+xeCV/mgOYwC3qkGl2AwVpF8++K/mO89FOIfvmKJzT4PEDYKzP+5J7
         vvuTR0EN1zkiu2rUef1hAhA60+KUbccMB3BlgdpwZr2EE8oAFRrgCv0yw53S53Db1Wlp
         ZclXmOpPnMe2xfBijnPs7BTpeUh7y6OwKdB6jwxCtWXnjeF0fx1x85Erm4y9VNLEAY15
         8vsacw1mqDmmcq7O5Upn06hYcU/vR9aYT0nZoIES1+zrdnlMdgHXnCzQIBjfNoVkIdkk
         mOPw==
X-Forwarded-Encrypted: i=1; AKwUvBw0kKOxHM+v96zsWIoRq3tcYPfP9tpvZ4eVSgFmrYn3mWwCqCh2kDf/46mJFeJApqwjj5mP4O8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8KBgTqjnuMTLp0tkc9cGfyRc/cihNWhKhdQq29oUrAn284lTQ
	0HiOFi5PVXG4eLjyEoCwssipdvDN9B301f7EPzKCGctEAxDSp21S0x7x
X-Gm-Gg: AYBFou04hZ8trt4YJqjoJHjxEzJCpIwDv08OuFCGD4XB+9q6K+asVTOSd+7QRGEBY6+
	ZaZwkA2s3mrRIm8+MaG/5zjDWpSFcMalRKV4zhl6wC9fzgw51zeTlY8YgPwEMUZOh6oJFldWpLx
	bF9SfIKchRaIORy8cCQTBZLGK4tyUyIAv0qHLuCEZF5CZ72d1SoagYWXaMRd+dId3AYNNpCfTk+
	eEFlz1HQ3f0ANXJ82ZlvF8v4LqSxFlqWZJ4tpUzk6xZsb1o0+BDdCW54pqwNf7s6JScEBaO4UH3
	JGBALmHKJYWaQvjWei7EevR9DyCku+DFeT19dMsLfzvJkUT9yPUAmkzYLjvXFE3MAHxcGdKH/4x
	v4yXhbztNI5gGlPAEJuqLWM69cFKJwk46aTL7U/KxqI94P8ngQjj4CyXmQRM+b52qLWqh5eRm7H
	mvSrkY5qSVNjH7nxgPsdAHpgY2//1Po56nLGnT1WtjAPSIM+Irm1m2mMw0lMHibZjK50fyoE/Js
	Vz5o7nSMnXk2xYYYyV1LwJ/ZQGTNMVKEjT+tzgIjyPaxzvlM9m3
X-Received: by 2002:a05:690e:14c7:b0:672:f620:3563 with SMTP id 956f58d0204a3-672f6204d21mr7574223d50.97.1790694017824;
        Tue, 29 Sep 2026 08:00:17 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-675b286ecfdsm68306d50.12.2026.09.29.08.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:00:17 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:00:16 -0400
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
 Wang Zhan <wang.zhan@smartx.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>
Message-ID: <willemdebruijn.kernel.d76bb9b38235@gmail.com>
In-Reply-To: <20260929102517.2005181-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-5-wang.zhan@smartx.com>
 <willemdebruijn.kernel.3b556463ed93f@gmail.com>
 <20260929102517.2005181-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 4/5] net: core: resegment oversized TCP GSO
 skbs
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
> On Mon, 28 Sep 2026 19:47:43 -0400 Willem de Bruijn wrote:
> > > +	/*
> > > +	 * The TCP frag-list path segments through skb_segment_list(), which
> > > +	 * does not carry max_segs, so bounded calls skip those skbs.
> > > +	 */
> >
> > This comment answers only one of six conditions. And one that is
> > pretty straightforward. I'd drop.
> >
> > In general, drop all too-obvious comments. AI has a habit of adding
> > a lot more, and more low information, comments than is customary in
> > kernel code (where we also have commit messages). Generally, repeating
> > what the code does is of little value.
> 
> Dropped in v4.  I will check all the comments in the series.
> 
> > > +	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
> > > +	    skb->encapsulation || skb_has_frag_list(skb) ||
> > > +	    !skb_mac_header_was_set(skb) ||
> > > +	    !skb_transport_header_was_set(skb))
> >
> > Conversely, they last two conditions are less obvious. Are they not
> > always true for a TSO packet?
> 
> The transport header can be missing.  qdisc_pkt_len_segs_init() does the
> same check on this path (net/core/dev.c:4245, a0dce8752193e).
> 
> The mac header is always set.  It can be dropped in v4.
> 
> > > +	gso_max_size = netif_get_gso_max_size(dev, vlan_get_protocol(skb));
> >
> > Third time this is now called in validate_xmit_skb. Not sure if that can
> > easily be avoided.
> 
> Maybe we can pass the oversize and gso_max_size flags out of
> __netif_skb_features, but it would be a bit ugly.  I think the current
> cost is acceptable.

Agreed. I was hoping otherwise, but don't see an easy fix (and didn't
explore more deeply to be fair).
