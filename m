Received: from out03-fra1-mx.uberspace.de (out03-fra1-mx.uberspace.de [185.139.157.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02B33DEF9
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826865; cv=none; b=aqS22L7q9ByqJHxbImT+mRpl5M/3xeUJWJw7n3sOALsBZ4AbMAeQ0+Sl3S6tCaSq3Qd/iMxExnBJg90ojdvq2IF+iG1H8rR0qsriQxBvYU7AiGawabJU/YEeHKLPrSTwwR2RyFwOmlCj9p34EqNckLkGODm5X0BzGAMALZxkWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826865; c=relaxed/simple;
	bh=r1kg2Mn6M5bgbo3/pHKPUZAuvTXPrpVHKXGYbtu+QQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw2FUSa67K5FfuvtVPbNJx/ajrxdT4lOPVWtcvvfNylac2k6Js2kSGqukhcozKcY0dwvTtcEFAuBEDRccHZOeYhhDObtKVKC//E4e2ZLGgVaVJW61SoIbaNL4JN1If8sqwgw6AvO5aEkh1bV7MOab3XWhVcHeid2YlthkeZZ2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=XUvmeHjF; arc=none smtp.client-ip=185.139.157.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="XUvmeHjF"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out03-fra1-mx.uberspace.de (Postfix) with ESMTPS id 54F3D100065;
	Thu, 23 Jul 2026 19:14:20 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1784826860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZYkLj5FuhxQUhaqR7vuVjTgu0i12naoxSQr0yLvpYU=;
	b=XUvmeHjFie6SVBc75oeLzRzCKIgOkfi0fFzfWEWdnFb5yPVDnRxRRw7HU1jtcMzbQXHAe2
	x1QkdGNxIb1oIaP29QHHBvH9BT8IcvVOk2/QJRDYGPaK991BPuVpV75Dw8W/jaROYU84KI
	ZzLuoRzGCahTMvd4kW3cvAW4OG/L2l0YBa7FOtEbHiFns6nNdlASBb2WK58BWwHFvDeYi5
	gXMSzonpqPrRgcITiAjM31hUHFRW4a1Xf+4KvTBG0qYmg9q/kjs9G1l1sdwOBxzThhQocy
	AVy5vRzT3XxRNuw4FNbNgwOnAaksFWL+tKzg/KGNHiP32nirt6dvkEykP4eYGw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de,
	dietz23838@hs-ansbach.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Date: Thu, 23 Jul 2026 19:12:19 +0200
Message-ID: <20260723171219.2293282-1-simon.dietz@plantwatch.de>
In-Reply-To: <88182be4-f7c2-4012-8661-881415124a15@lunn.ch>
References: <88182be4-f7c2-4012-8661-881415124a15@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.32 / 999.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.58)[81.41%];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	LOCAL_OUTBOUND(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[plantwatch.de:s=uberspace1];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[]

> Passing a binary structure as a netlink attribute is not going to fly.

More like this (using generic netlink)?

static const struct nla_policy gn_coord_policy[GN_COORD_MAX + 1] = {
	[GN_COORD_LAT] = { .type = NLA_S32 },
	[GN_COORD_LON] = { .type = NLA_S32 },
};

static const struct nla_policy gn_genl_policy[GN_ATTR_MAX + 1] = {
	[GN_ATTR_COORD] = NLA_POLICY_NESTED(gn_coord_policy),
};

static int gn_get_position(struct sk_buff *skb, struct genl_info *info)
/* ... */

    nest = nla_nest_start(reply_skb, GN_ATTR_COORD);
	if (!nest) {
		nlmsg_free(reply_skb);
		return -EMSGSIZE;
	}

	if (nla_put_s32(reply_skb, GN_COORD_LAT, val.lat) ||
	    nla_put_s32(reply_skb, GN_COORD_LON, val.lon)) {
		nlmsg_free(reply_skb);
		return -EMSGSIZE;
	}
	nla_nest_end(reply_skb, nest);

/* ... */

> This also does not feel correct. Why is location a property of an
> interface? Can one machines interfaces be in different locations?

I would answer: Unfortunately, yes. Consider a 700m long train (which
is the upper limit of train length in europe, in US there may be even
longer ones). It is one vehicle, but may have at least two gn (wifi)
devices, one at the front and one at the back. That is a niche use case
but it is one.

That of course would make the implementation a bit more difficult
because if the position is saved for each device, then the gn address
must be passed along with the position so that the kernel is able to
map the via netlink passed position to the right device, which affects
the kernel / user space interface.

In the version I am currently testing, the position is set for all
devices to the same value, which can be changed both ways.

Simon
