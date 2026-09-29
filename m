Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C350C28E
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677544; cv=none; b=HFv1IZYXVymtYUHIs5KCi6tpL6Dylsk0nq78KJEKa1vuV0aSpIRFijboQiY2jRTWPeX8JYAMGeQszLsP0wQP/QnLvzyp8n47U7UvEKpUHfOJWNJyJM8/ccfNKIZWS8BK//9Fmw2eKD/Oi4bYszstdl0RD8LnFf2PIiZOmKh2LU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677544; c=relaxed/simple;
	bh=Lx37WPTatucBltUYtSZPoK45blPf4DzMyhGRTxO/xck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3IZTDHGkuMBF2fIjUFNrRJgtJR/ODw13eEt9HouGo0Y5SyYONeaY6Lfju9RD1xnD0+K2EQ5MdXpbvOAeEISnj/TBF5ZIr2WVfFAvgNRdnPrncRCcj8le3wqBztLQRuOSvUC4TS11A2EVyNY7e4pDgKM32I3C0Cf1qagKGdYoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=MOksh7yB; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="MOksh7yB"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so5330417eec.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790677533; x=1791282333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7jWEleaC9RgTlHlGdo3Mpukr7IOJ9j1xdAG0eXsBZ4=;
        b=MOksh7yBMP4AARDVQEqe5jujR+S2ju3zA6ke4wYEN3I1tzgiLdV8L00ct+cNA6y/Bn
         M1CQwg6H/JUz2wLlsKWlNjqQQMC2MA9gz+EhYiZdOBNBjj1JFaC0OynBB4MXSwn8Z7Iw
         /7YMMWkFERzQImKAJOKOTZJEWIFBEXy/hZ0WpZU1YOlcXkZOUvY0r5qgtrRrgIGYC+nD
         QObk7kxhfQcqsvtnvwHhsXtFyYnCsHYaKXU6IH5HfIgitIrMcBlkGM0N1df1fp96mVZW
         kgtSeBXol1gF4Eym2cPnTmxP8jiYRHMCfLzEj2eO2tM+5yIHUMxqGAzn6nzvUZ26llgF
         4KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677533; x=1791282333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7jWEleaC9RgTlHlGdo3Mpukr7IOJ9j1xdAG0eXsBZ4=;
        b=1/Wg349AfgYSe/gW0Cmf15rYzgVrfCQ88gB4Ks4CZctAMrwbp7KGguRQAnWpsBQvkL
         NwhXtgZAQ/2btqgtUx8m23sjrxTt9obyXb7yJV2As1zZRIw7WbR0Ht6+iOQLrfwVrHhw
         FsGLMA9P6D1VV8YZMcMOuuaEze+hYBD2W5xGRcKIDL2sBOIkjDUGCPNYUSdg0Qqt+tA0
         Sso7KfWNKV/6jiZhL0eCheLAUZNQ6hxUcBWgc+X2u7ZvZRNCtF+9mDrcWxUnHVlPk1L0
         s8FhVEkxog6aImxRoRrIfNv94RYVXSgpXZCD2NxIX0IhXrCyaCXhBAScMwDK5Oo1ac+O
         jZmw==
X-Gm-Message-State: AFuF++lNHh/dBrjccYMBtKuvNKS9d1Wb4BkZOyiP3x6+jOwRHwouluJW
	YiAJJQ0WzwJ3JXIga4AQ8lDya2Svj+t3767qyUjW9undRY7jNt0/I4J8OrgrgFx9fXbUyt5NwU5
	h1b6yenKzVY25RAfsRXdxbwqmb0vWX/qANu/mNM6e3RwaHiPYpmM3Xh1sckHOvDrpGmvUm1XE
X-Gm-Gg: AYBFou0uvsUhUmk7JOdpyLcmvURLWguSuCi44UDAtIZ7aXYdBObYWZ9VMSI/8vMkuWk
	QSfhNNvvXy8ymx7dTWFWw+ir6aafHZo9U6C8FAcaNmISlmdpSM0WXAU+IsRJqEWC4hT0pUd9h9Y
	vCJtpg13c2hBpR3JfVRNHBL2xbBiJQdTF0NAVWIIJEn3GmOPtX5Lx3cL/8DJQv5zDG4govE9YYf
	EjosOD3yzCZHlKX+hO9hfGESiqznSUsd7ms2E6Tp9X4ZHHIWtzdhhznEooMe9Ab92704QBbL3cb
	iue2GeKMd8bt06iTvBgk/6iNMw/ejgWgpemP9AgMLaUlKYq7lF3Jgvo0ZnKxpD9ynAZ7/G3w6kr
	dohl/s4/xn1crkOAPfvAa/24NWS8FefCxmLfgPyMQ9dwxcxuR3eHH6ZUfCen+jcjl8k4R3TNB+s
	kQOUYrbIunhFmAuM9aWl2JOXfYGO19FaV208L//mRp0H2GDIaAYNhBpnTeLuz8rW9h6+gjdr4by
	EiDjn+0CRnJ
X-Received: by 2002:a05:693c:65cd:b0:33f:3878:8e18 with SMTP id 5a478bee46e88-3426c6f4d95mr12596475eec.0.1790677532339;
        Tue, 29 Sep 2026 03:25:32 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a4a5ecsm36593730eec.3.2026.09.29.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:25:31 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
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
Subject: Re: [PATCH net-next v3 4/5] net: core: resegment oversized TCP GSO skbs
Date: Tue, 29 Sep 2026 18:25:17 +0800
Message-ID: <20260929102517.2005181-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.3b556463ed93f@gmail.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com> <20260928044102.1004310-5-wang.zhan@smartx.com> <willemdebruijn.kernel.3b556463ed93f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 19:47:43 -0400 Willem de Bruijn wrote:
> > +	/*
> > +	 * The TCP frag-list path segments through skb_segment_list(), which
> > +	 * does not carry max_segs, so bounded calls skip those skbs.
> > +	 */
>
> This comment answers only one of six conditions. And one that is
> pretty straightforward. I'd drop.
>
> In general, drop all too-obvious comments. AI has a habit of adding
> a lot more, and more low information, comments than is customary in
> kernel code (where we also have commit messages). Generally, repeating
> what the code does is of little value.

Dropped in v4.  I will check all the comments in the series.

> > +	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
> > +	    skb->encapsulation || skb_has_frag_list(skb) ||
> > +	    !skb_mac_header_was_set(skb) ||
> > +	    !skb_transport_header_was_set(skb))
>
> Conversely, they last two conditions are less obvious. Are they not
> always true for a TSO packet?

The transport header can be missing.  qdisc_pkt_len_segs_init() does the
same check on this path (net/core/dev.c:4245, a0dce8752193e).

The mac header is always set.  It can be dropped in v4.

> > +	gso_max_size = netif_get_gso_max_size(dev, vlan_get_protocol(skb));
>
> Third time this is now called in validate_xmit_skb. Not sure if that can
> easily be avoided.

Maybe we can pass the oversize and gso_max_size flags out of
__netif_skb_features, but it would be a bit ugly.  I think the current
cost is acceptable.
