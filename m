Received: from out03-fra1-mx.uberspace.de (out03-fra1-mx.uberspace.de [185.139.157.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CD486BA8
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828754; cv=none; b=XA90kDA3aWTJKoX+kO4N0cyRynOHxC/CSgCuhYPGO8s59QzcrVS7z4b/leba4U1FKat6k2E5HSPTzatGcoLpfMu6lRgaMyuI3eqEwL7K4711X0kKZbgRf+sGiIaPPpOoMYCPD5+dmc3xNF+D70rF+047thedt68Ub+AICCsMMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828754; c=relaxed/simple;
	bh=WkgqZom9FrOLA9beH4/wEG4cpX75P3vhIUqURKaBGeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRsO7xtMO1N84hsBSy20sAjP+lW4dF54FCyFxZ73FJ4Y/fpZSZ+LaLHskge0G8DsELnexAEbGHq1MioB+vAU7ExCd+oFO1902cq1xg9DvBz6tQMeaPhLDEa52x93n+S+0hI26NVRlY5jO7DSJc7LyWkbeMIJWXv6BQh4jAGIr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=qMwPg1Gi; arc=none smtp.client-ip=185.139.157.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="qMwPg1Gi"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out03-fra1-mx.uberspace.de (Postfix) with ESMTPS id 972A9100065;
	Thu, 23 Jul 2026 19:45:47 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1784828747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkgqZom9FrOLA9beH4/wEG4cpX75P3vhIUqURKaBGeE=;
	b=qMwPg1Giz4PBDsu+QUL88Eatbacp6a1ldYNsgyCwNNlpHsgWUdJn4Xd4JMUszoZ2cNtlQG
	a7aGDdp6fRDqQ7tysbuf405QtQ5uUFDf1xTV/r9tkQG5f9DSWsqnmpSZ8xismecxxVdnnA
	Rn/YERdyecvbGpiFrXTFAYGMtsYGBKVdYPPKz4sGa0Xxu/634B7LcRH1o0jZQI+FLkQwyJ
	9Hpv9Tm37xzgjuSlfBqJXslvAGcDDQ0XBaBaBAx1Dl+0Yd6PPCyVbbDAHrjy34XwbN8YRE
	Igl+otSNhTBV8dSofhIqi5jOcKLm+S28+nvLMPQdLP1peIWI+Q2MTXdIvoGhJg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de,
	dietz23838@hs-ansbach.de
Subject: Re: short description of GeoNetworking
Date: Thu, 23 Jul 2026 19:43:47 +0200
Message-ID: <20260723174347.2458082-1-simon.dietz@plantwatch.de>
In-Reply-To: <88182be4-f7c2-4012-8661-881415124a15@lunn.ch>
References: <88182be4-f7c2-4012-8661-881415124a15@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.89 / 999.00];
	BAYES_HAM(-2.01)[95.12%];
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
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	HAS_WP_URI(0.00)[];
	DKIM_SIGNED(0.00)[plantwatch.de:s=uberspace1];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[]

Hi Andrew,

> That is another issue. It make no sense to merge without having at
> least one wifi driver support the needed frequency bands.

In the V2V research community there are working out-of-tree patches
for at least ath9k and proposed changes for ath10k. I think here applys
the chicken and the egg problem. Why should 802.11p patches be merged
upstream, when nothing is using them?

> how does the Linux Foundation Automotive Grade Linux fit in?

Up to now I didn't know such thing as Automotive Grade Linux exists.
In a quick online search I only found stuff related to 5G [1], not to
802.11p. In their mailing list there was one discussion regarding
802.11p, which actually was about OCB and ath9k stuff [2] and an lwn
article about it [3]. I think that is too less of discussion, if they
had a working implementation.

Simon

[1] https://lfedge.org/wp-content/uploads/sites/24/2025/12/lfe_cs_instantx_121225a-1.pdf
[2] https://lists.automotivelinux.org/g/agl-dev-community/topic/open_source_wave_1609_x_stack/36365674#
[3] https://lwn.net/Articles/611635/
