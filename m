Received: from out01-fra1-mx.uberspace.de (out01-fra1-mx.uberspace.de [185.139.157.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9617B50A
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785093098; cv=none; b=No6eQ1jsnkmFqygL22YhKakNs2w0X8Cd4k1yvbOcUJf7Zn4c1f/SXrxJAno5AxhgxFz+8ZnnnXLI6ziEsuY5xAbBz0o3y/T772aCF6dBhvtPrph/tYPLnvcuM1u/cfb/61ZwuJisCS9ph4XD9zkXUP4ZzMYd3XcaXO0uoXT960M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785093098; c=relaxed/simple;
	bh=+tkTV2VPyukxsF99FoGNVvo4KDYJWn4/8olNzT2h76c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0zvcN32jOndfvQapM2EW2ap/y1+wN35lzLNkPVaOGfrDpUPfOLne4eZx0BNC8ZgAC5fD8FK3wIMKcaKBtOybQe7LOOX/ge0Y6+kO0ztn4NMHF1WVKmGkpxNLlO34nnqMLUmMxKXMsmfPIGEaU5lDrkyO8SJVfFLan3VRtiBNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=iuFcX0f+; arc=none smtp.client-ip=185.139.157.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="iuFcX0f+"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out01-fra1-mx.uberspace.de (Postfix) with ESMTPS id CD44B4010D;
	Sun, 26 Jul 2026 21:11:26 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1785093085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tkTV2VPyukxsF99FoGNVvo4KDYJWn4/8olNzT2h76c=;
	b=iuFcX0f+kuFU55o1gkh7+K9y/bcpLzmmTxoQ7Jxgxi4B4z+03kZGzmB8ISjjyoMTjtk53O
	WbF3z5z2LeB3ZZy4GGVsPwG77VfISyVoC7WzggqwN1BQv1tj7ppiPLHE7fCqNTIFuVMmrW
	5WFYfkduOT69cfR3NhV5lp47haQKeRL0wu2nhww47Y+4nPVTuRQPVgbNCeXbDkBfMCAvO8
	VpHE+/CcPsIkEx9s1Zn/uKNVSZdtl+Ku1I2iS8DpKGRuh3VETCTv94EnsVCAWFBy81VGYB
	U/QBlWEKYJ+8Ru+xsoQN5f7uMOobBJZRlJ3scmu0jDEuU8gBC8BcXbu4k8/hvA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	dietz23838@hs-ansbach.de,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Date: Sun, 26 Jul 2026 21:09:20 +0200
Message-ID: <20260726190920.744842-1-simon.dietz@plantwatch.de>
In-Reply-To: <4e09a943-d116-452f-93f3-93fb363b09f5@lunn.ch>
References: <4e09a943-d116-452f-93f3-93fb363b09f5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.63 / 999.00];
	BAYES_HAM(-2.27)[96.60%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
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

> This then leads me to thinking about having two nodes, one on each
> end, with an Ethernet link between them. Ethernet, or any cable based
> medium, has different semantics. A broadcast is received by all.
> There is no point rebroadcasting on the same interface.

That's a good point.

> But what about the fixed infrastructure? How often do you see nodes
> along some sort of linear structure, connected together by cable?

I think there is a use case for fixed infrastructure, e.g. to advertise
road works or closed lanes. I can't remember that there is a use case,
where nodes of a linear structure are connected together by cable.

> Or a row of blind corners which is known for accidents, you
> could put fixed infrastructure along the way and cable them together,
> so the vehicles can "see" around the corners?

I think the most canonical way to implement this would be to use
'repeater' nodes (e.g. traffic lights, electronical highway signs),
which forward these warnings via topologically scoped broadcast wide
enough. But I do not see anything in the standard(s) that would forbid
such a connected by cable bunch of nodes approach.

Simon
