Received: from out01-fra1-mx.uberspace.de (out01-fra1-mx.uberspace.de [185.139.157.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE11448E0
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832030; cv=none; b=q8q7XORMS1/lKnu78kBTfua6bRdg/BaxfKlYsJY+1B3j/KPWXJSmaIuU0m5BKOMV3BRwkSrKO0kYWHNlx3007SOgRO3PQBS5YdE39H68gvS4dS/WXi9OsiUJpdyR6BfULmvmA0f1UKHnm/5WAAQuwJVvxIbCxPiMsSmxVK721ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832030; c=relaxed/simple;
	bh=qAqmzyXTC9NvYGlDFaU0owkFxKPK107/2qy3dX3DHjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5guuHlnsV3R3aV92vyRAB2FsWQU/12a3a+XE1zqth9JYOU9FP6Ur6j7eLvywwjaZJQsEK0rkAwim3SrHB41b0WNGTb5GSxuC1INA8g1c6vOo5hDzmorp8JFrKCuYwe78V9wE0iR2LKGNid+4shDp7MStNA6C1VNr7Of7sSNiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=RcTw5xHL; arc=none smtp.client-ip=185.139.157.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="RcTw5xHL"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out01-fra1-mx.uberspace.de (Postfix) with ESMTPS id 457F64029B;
	Thu, 23 Jul 2026 20:40:20 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1784832019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAqmzyXTC9NvYGlDFaU0owkFxKPK107/2qy3dX3DHjo=;
	b=RcTw5xHLqU4BI2uDlpDkaUUOvehH0wQT++YOvHMGqI03TDOwmXTmu4IjOsrVunPDRW6ra2
	SSGbj3OoG8awDeqaQQGTfHXtfT2hx/jV263jSKK6zNB2+ykCLl5BMaLVikVWnSES6NVaXQ
	U2w4cEU2q0t1IuPa6jk5RrPOwjzmdMy7gM0NDtnf7wS4hCHuHu+FekmVxSlDbo1ssWa7MX
	8Aqofaix3PZ7rEdt3wFbybbVkCWtWWczfpcOdlgTC0aJ0vuuPwN9UuUw6Z4ELu6db5Vhmi
	C0MqAT7cvXANwsmdTS2FEJ66T/44YX/cftpwpTXRdXV8pMB837PYMof3pNMEEw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	dietz23838@hs-ansbach.de,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Date: Thu, 23 Jul 2026 20:38:19 +0200
Message-ID: <20260723183819.2740024-1-simon.dietz@plantwatch.de>
In-Reply-To: <7d4846fd-b997-4e74-b58e-42c3dd1de898@lunn.ch>
References: <7d4846fd-b997-4e74-b58e-42c3dd1de898@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.45 / 999.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.45)[91.35%];
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

> Does 802.11p require these protocols?

As far as my understanding of the standard goes, yes.

> Are you allowed to use plain, boring, TCP/IP over 802.11p?

I don't think so; the standard defines the option to transmit IPv6
over GeoNetworking and the higher layer protocols (BTP, DNEM) kind of
depend on the location, which is transmitted in the GeoNetworking layer
and e.g. in case of BTP in GeoNetworking layer, only.

> What quality are these patches? Hacks or mainline worthy? Is the
> frequency management correctly done, which i guess means
> wireless-regdb?

They are not too complex, mainly adding a few entries to a list (namely
REG_RULEs). You may take a look at them, you'll find them, e.g. here
[1]. Completely mainline worthy maybe not, because once world domain is
used instead of the right one. But - at least I think - they are not
too far away from mainline worthyness.

Simon

[1] https://gitlab.com/hpi-potsdam/osm/g5-on-linux/11p-on-linux/-/blob/master/patches/linux-6.12.patch
