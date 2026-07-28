Received: from out01-fra1-mx.uberspace.de (out01-fra1-mx.uberspace.de [185.139.157.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C493A9DB1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242652; cv=none; b=PyatwdMOLp/qNcZF4I00siEOkN4qtH2kw5GBl5k7gUOxrWSrwHptYjTR+jfFt8xf9ytuORezJu7MXsQFxs6todK4/GaxkLxhKrf1113WCJzQJ2HRcby+2pLZHFEz6QSs3Va9U1rCe3fKZdSDKf8PJ8UCmnzb4y0UaTtdawZHdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242652; c=relaxed/simple;
	bh=h41Tzu6TMGFDOoaEIMsqgF2uCoW1K/yXbNzeDryH/Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT2m7vX3eJrD8w26mN3PbCcsG/tmG5y/5L/8Gi3vSOfSV0NVq+axBWnUslXTSX7fsnG+wNGV70R/7VEvymtURrS958nMTvPvw0fantHYnRjH6vJqIDU0SAFj/778V0yqRzUqCab4P0tAO1A6kOEIzEzqj2PdcHqvfLpzpYNsz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=Ns3tNh5Y; arc=none smtp.client-ip=185.139.157.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="Ns3tNh5Y"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out01-fra1-mx.uberspace.de (Postfix) with ESMTPS id D30C64045D;
	Tue, 28 Jul 2026 14:43:59 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1785242639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h41Tzu6TMGFDOoaEIMsqgF2uCoW1K/yXbNzeDryH/Ow=;
	b=Ns3tNh5Y62loVRXLLughGbWi+ATRnIDpch317vroLI/Rv5gNHD2/GZRpy+bhg0lhCbb1jK
	0N6alsjBnmp6o1kOayBXzrntkiq/7iQ5I4LmW3dVm3b/3eCjQTb89A2FYXP+ZCN3UvRcz5
	9NR/tREYZhqddzj5gK/dAeygqb+OeVcVlkdzp7T6dz9KsCT2GtPbA9nFjag/KFX04FulSk
	AJmxoUAg2rba1u0sq1PVXzSOl5dpGEsIZoLvaJHdA11+lcYMQ1TK1SWelkdh6nb7YkackN
	ehOHOvYMVSd6ANok9ZZWNsp9IHf61f2r1bLuymTAi7BH5tAHBuPOuV7yNocbEw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	dietz23838@hs-ansbach.de,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Date: Tue, 28 Jul 2026 14:41:46 +0200
Message-ID: <20260728124146.1554385-1-simon.dietz@plantwatch.de>
In-Reply-To: <baa3f76d-ef8d-43bd-b72d-d9b67e33a738@lunn.ch>
References: <baa3f76d-ef8d-43bd-b72d-d9b67e33a738@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.76 / 999.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.14)[68.23%];
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

> Or a GSM link, or even GSM-R, etc.

> At minimum, the architecture work being done now should consider
> it. I'm not saying we need to implement it, but we should have an
> idea how it would be implemented, and ensure what is implemented now
> will not block it, but make a good building block for multi interface
> heterogeneous router node.

So you mean that two nodes could be connected, e.g. by GSM, ethernet,
GSM-R or other means and exchange GeoNetworking relevant information
over this other channel? Or even tunnel gn packets over that other
channel?

Simon
