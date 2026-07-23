Received: from out02-fra1-mx.uberspace.de (out02-fra1-mx.uberspace.de [185.139.157.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC041D22A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832970; cv=none; b=eEG6NsWT2mvWjqOEpis4EGbdhZiMJd8Hw66JBl3RVfl7Nw1Fr9yQ5NEJbctXdt1m618ovrMsxuyOeD736Zwh8ZYDuMoqUNQrnj5tVVqBvYEPhn+qstyEbF1l40P3c+f5txV+1Y73GyL940qs07wHSL1wyMHKVpeU09IQju/JYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832970; c=relaxed/simple;
	bh=5PlftITybdOWiHCFmiDyT2FQ89cVjYXASPGXPdlH/Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlsAahpK4h2cim/AidPICpw/hrJZR91nAFVN3lPHwBcupJ8pIdIayTI8G2+VaosMuUCr+vZuFBSqdaCuwUuoiznizbD/IhAXYnznZCNcmWisQXKkNXfdaYTipL7crLSfkUdcPNSbeRagWJBvSu0hALeD+KRbw+nc5cMoa41hI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=ihYHdAUl; arc=none smtp.client-ip=185.139.157.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="ihYHdAUl"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out02-fra1-mx.uberspace.de (Postfix) with ESMTPS id DDE58C0190;
	Thu, 23 Jul 2026 20:56:01 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1784832961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQ/kAW0OB8bZXPDyiR8tRkkHsgAPfGPzBZPmaA+kRO0=;
	b=ihYHdAUlVmInyQAN4gmawgMt5eZjX8NKIw94QefWuqhuPKhSea2wS7h9g6OlgrVoSAiMac
	ZoWREHcZZml4G5eYJKsHisQYUALNg92cyysymsATTt5C7lFQ5q/gWVQNLUkpvzSWRi4N4D
	7tX8Z79c3OhAap+EU1JAnXWdCuRQds2OX7K70IIFCTXS9GK2Dvp+mxMcqDISm/AY1JwgRO
	eMDNltdg3+KTYImr5LenViI5EiZhpu+zSUaPeriooDz+0duiTfCk4l8NiAxuLGoOV8MGgy
	dB+KuzIjogWtIVJD7WrwU8BAN+XEegudMJvivGeFahk7+Anm1vbf+U7aIR7TZA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	dietz23838@hs-ansbach.de,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Date: Thu, 23 Jul 2026 20:54:01 +0200
Message-ID: <20260723185401.2821188-1-simon.dietz@plantwatch.de>
In-Reply-To: <d3770c0a-ce8f-4ebf-9047-f8e268c3e2ca@lunn.ch>
References: <d3770c0a-ce8f-4ebf-9047-f8e268c3e2ca@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.58 / 999.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.32)[75.68%];
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

> Can this:
> Be defined in terms of:
> #define GN_MAX_HEADER_SZ (GN_GUC_HLEN + GN_GXC_HLEN + GN_SHB_HLEN + GN_TSB_HLEN + ...)

I think for sure, some of the headers are mutually exclusive, but there
should be a biggest one in each case, so yes, I assume.

> It does not look like all members have the same indentation here. I
> would suggest they are all indented to the same level, or none are
> indented. This is a general comment for the code as a whole.

Noted.

> a language lawyer might argue it is allowed to start at 42 and count
> upwards from there?

Well in that case I'd suggest to choose the Henry VI'th way. "Let's
kill all the lawyers".

> It is typical to use
>   UNKNOWN = 0,

Noted. I looked them up in the standard, to be sure, and actually, they
have to be assigned explicitly, because there is a gap for the numbers
12 to 14, which are undefined.

> Are these from the standard?

Yes, they are and yes, there should have been a comment stating that.

Simon
