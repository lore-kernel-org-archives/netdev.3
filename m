Received: from out02-fra1-mx.uberspace.de (out02-fra1-mx.uberspace.de [185.139.157.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5A3B0AF5
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190907; cv=none; b=ff03/wgyJwV2DB39wAh82lX1VaHBIWvmCIzrTHn4NFra9jfagjBp0l6kFuf7634B3IGILj+3i5TQnaGc4fi57YpmkJbnANO8oka0Q/qyNSFmcmPav1bhoPayoavL2zW8SmjstYEos6sMgw/9iN7YZ4qe7trG80AgTuIrGm99xtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190907; c=relaxed/simple;
	bh=kkmxmgCuPkzEat5WPNYJfMhRJWb6Q3dPlUALq+5DBwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPsSq2lPKFVFgXf2h+S/4F2HvRTTiA+kQAj4Fg/GD/oh0mXFNds9wakX7wiDNqDzIJUYwgbZc6C+sRriZ4P6+EXvEvIYlpfuwF6Ccu/q4BIRYTbVMlivcL90K6Dar/ryoVDguXYXgsi2L9zXCEMdtkSrfDIXJZlx9Ni8LLjdpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=A1DR4hIE; arc=none smtp.client-ip=185.139.157.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="A1DR4hIE"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out02-fra1-mx.uberspace.de (Postfix) with ESMTPS id C13B6C042A;
	Thu, 16 Jul 2026 10:28:34 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1784190513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkmxmgCuPkzEat5WPNYJfMhRJWb6Q3dPlUALq+5DBwE=;
	b=A1DR4hIETs9Yt2fBl2QNNDTN7BQdxJ9UImNowKhGR9Qzyv1S0+WaANtD4wXQUMwE6bZ25P
	6zEZlGo8UBoPzjZkWVccPV9nAPjcfwUwoflcTvn1xhHmA7rTsoiRzrpSD3gknqkjQNPHYP
	/r51F8ZQrzZZ1vDXjo8X5vPwK+fEj4VJm0mRUyaGp7HNgEmvlZBc/JVs8RVy7aOpSmu1Tj
	O7VJ4mGSrB0tfuTExjI9zLtPCz2otWNbDbl+4/x/WBYmdcrI3xe91zVF3Nomu+lB2ZscEA
	ZsKaN4z5Wz62Jed87YjPxpitC44wCI/DAX2Ugt06ERDbbCLMQ1HnwkJML8rQJg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	dietz23838@hs-ansbach.de,
	edumazet@google.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de
Subject: Re: [RFC PATCH net-next 0/6] net: add GeoNetworking protocol
Date: Thu, 16 Jul 2026 10:26:50 +0200
Message-ID: <20260716082650.1202710-1-simon.dietz@plantwatch.de>
In-Reply-To: <a1440c5d-2848-4587-a2c8-b3d65dd4272a@lunn.ch>
References: <a1440c5d-2848-4587-a2c8-b3d65dd4272a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.73 / 999.00];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.67)[82.99%];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
	MISSING_XM_UA(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[plantwatch.de:s=uberspace1];
	FROM_HAS_DN(0.00)[]

Due to - let's call it a misconfiguration of my mail server - indeed
only the cover letter made it to the list. I'm now waiting the 24h
resubmission period to cool down to submit it again (including the
patches this time).

I'll then include the linux-wireless list and the 802.11 maintainers.
OCB is already implemented in the mac80211 code base, so changes to
the wireless related parts should be minimal. I'll include them,
nevertheless.

Simon
