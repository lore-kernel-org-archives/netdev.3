Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9C397944
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885582; cv=none; b=Hau5YSq/hEmI2UJmB0Uz+nE0MKyGkRl+PmR6MP8zit4rzclPkUIKmZ6qo6uBH6k+FGiGV9e4E1dBFObh2dDxlQH762ePz+mZVnQoO4O4aufgvv8AGfilPHO/ZAIRD1cIEf1/pSzS3JXaZPExe61p5p/rxa4WCWVdRwuqzAmPfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885582; c=relaxed/simple;
	bh=nys62QB7M4IdoehMRxNfKBj996YLTcdFhXXRyDvgc00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLy5+tFBzAlIGiHQFFyBtJcIMpns1AgDNBwvqgygccpbsmjyrlPA2ifP3MbcwoYdyOwcRtlteO2gVypTcqqju7orv7aA13Q4FX7dQL9dR21w5vZF/asCbv5b1MF35gAybxJwSZPYbZ7WJd0uO4GZtswnu2tA5FuuYNZ8Au6l2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=N72f7Ohx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E91GVHLU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="N72f7Ohx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E91GVHLU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DC791400114
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 05:59:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 05:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1791885579; x=1791971979; bh=rBglKPoywqmvxvf10VqHmASfzR/Nfnva
	3Myxkj614U8=; b=N72f7OhxIkL0fCOwPSdMXK83sd0QXtGlc1YQNtTZRLU2Aa34
	ZLo9Fq+pghghf5Mkf8hanrF6aCBrrdFjFTcWwY5uh73eLvh5oy2NHqNS3fR8r7FO
	qSP7oBdH9B8SzAC3oiupvrh7ah8qt1Nt3vrCcufi9Cczz0x8yltcPsQ7YpFxYsan
	qJOQofFrm51YHlSF6k4j85DrY4sxCJg6x/9nZi5EEaF8sxjjGVl9GxltOE6bIalH
	gdMB+F72xWEA4Ml6aumKTVqf5bSrT/4BPVdvVwUwQkvXhUcCzBTEP8rDd7G7WGVp
	C5cwzLJ0/2wfQTC39TXXFJDLweq81LAXK7VzTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791885579; x=
	1791971979; bh=rBglKPoywqmvxvf10VqHmASfzR/Nfnva3Myxkj614U8=; b=E
	91GVHLUiBsxq4sbVAgZh5y0F2l8tPZSCaHoW61qr/bfNrYTaZR6RTKBqvXyO4tet
	9ZqKWW2icT64awk9U7wpmqlU9DRGxdz248fptQE643TwOnhlJNE1bNzN9sHqY0Qe
	i55y4vcH2g9PwkaR5jDwoPuUmPPv0V2quJ7U0JoJCCFiSF3DudHr+Y5to0N8cbVG
	8Ok5pKEgJ7XUw14xzm8v0nsRngnKGaGwnrw28PJ+P2Q+k/Lmiak6vx+oqbv5baVN
	dsMalvb/vSgEOv8vTKcyBaaaHS8+n+Mlvnt5jGLTDNC0nmZBSu8SH79slHbckBOd
	IqAEBdfCtXQu7zWT/Moig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791885579; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Rxq4eOHrW+1a0YGJBLY1UFawZC/+8k7fa5I8ymVyuLLVE2r
	GbSXEOjNDpb3R5PfSOa8bSN8w7zfPMoZRF6XrxrflqsGeds/M4dHTDPD1itNOoro
	sDcDhV1R6xwTcfsVJAk6mDIlwTYV6k3/MoC6AnEZgll7gAfzBHrS67I26AN0u4oB
	FKmVEu1VVe7OyfflW7krQMFmhrdFztqCyUejJvfalas5vZTfQrL1moulvtZeMzNF
	reF26qtIG41EB/ioXOzhjpxlYXYB1hmQCmRwEywjNplFcpb5PTzI9lzEs68/D8jp
	HKMN/AXE9gfmIQUL8u8zWI66TLmHm70x5w0J65Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:W7SnUqtS0lvNqG+Q+ZF4OSZhk5YDc2m8wszGv0BSm5c=:nys62QB7M4IdoehMRxNfKBj996YLTcdFhXXRyDvgc00=;
X-ME-Sender: <xms:CgHOajwRxT6FGdHQ6gQQ1PZZX3ZGqWdfrSOhfkzcAHwrNUZKnx61Sw>
    <xme:CgHOaiT_4hVGRSJgEhaW99dRIenl983w20HDdtufVR_uWvq-RIkhGzkBUW77fc4rn
    LxHRxgYL1Ll70aIVDiAgxH4EvRZOUVnPutcc9rCgbYKFkyAfpyevHDs>
X-ME-Received: <xmr:CgHOaiUI-x3YCg0tTPRKgS0gE9j-7Y7-aJHVA3hfdm5_7an69TKLLN7Ym3c>
X-ME-Proxy-Cause: dmFkZTFhkk5qbBeXrg4hI48tsqkC5Q8ixzr/GZhEvF+YXiMZUC6JUy6scZs8gj/V6FeJLP
    qAcTgr3kpATb+Re87Hvycn/c6QX22LDu6gWK++da1I9g+dJ8fvD6ypJ31xJ1UC6iyu45cC
    9RmYrKY+Te4wlhvXXEHg9sOk3wsSRbJaG91cF84lxNAJPz0TWhyzQUZTCs5XVXjYWnrKs5
    11QK4Rzo69kJxasHh54xhAWOBI7q819P0yuJ75A8fnaNnX/Qik9HLiWXepKdA+lZ7EHc5h
    Kf0qDNIcn3llSmGwO2lTl6onLDA/ua5GnBxpX1Iwo+/FFdnIJE1Umw4cFm60QuBIcw2jj6
    tXv1rPM09fuVbQ/ra9UOkYDhdx2Xc5LX2zFYXirMzfBCma6DrHDmZk3SFoH+Cek4H9S6r6
    pvTAiExHdbhYVLLuZm8UjmJwCbQdhZsrV5pES/PtD5q5JplHVuQLBsDma86iDIVl8LHi1g
    5L2dtNV7csEr7a4YVyXot8xK0EjveB/i12MfPsW9H/+s7cUCi4no60PApGkqfF3CdL9N1x
    pGsFfp3CNwYK/FlMHwibHpzgoXX7manMUkh+RZ1ErR92tqTlMDyB9hPz5sKaqflq8l50At
    FZ0/8Y3nTmXX4mrDtdUbFQuXkCyZB/0OrmyQzpwSOZawRyDd2B8CO39UWhYg
X-ME-Proxy: <xmx:CgHOasbDb74sBcRqvkySdbPIs1DC0-TChUR2j21ypfzsHmia_V9F_Q>
    <xmx:CgHOag11Q1t7qB3evHyczg5eRJP6TK5EpJiKVK9dYy3e51IEpcNiTw>
    <xmx:CgHOamjSdPPo6DJWY-n_TSNzV6AUyYfsaWZx48XGl0ARyflvnjJVxA>
    <xmx:CgHOasYZkk3xEm1ql5uUXIcpbSWa-1VqOUmv7DoiilmWSQWQuyPURw>
    <xmx:CwHOakRgS7EvIxql8skrW6TVoHLn6mqqpDp4jM97gAG74o0S09JWHQ0g>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 05:59:38 -0400 (EDT)
Date: Tue, 13 Oct 2026 11:59:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: tjdqudcks0424@naver.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net] macsec: ignore inactive receive secure channels
Message-ID: <as4BCNWzgbgm1rGR@krikkit>
References: <20261008082612.350120-1-tjdqudcks0424@naver.com>
 <179179597621.434549.15908000438396641185@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179179597621.434549.15908000438396641185@kernel.org>

2026-10-12, 09:06:16 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 1 (1) · Low: 2

Given all this, it's probably better to just accept the rxsc->active
flag is useless. It's been useless for over 10 years and nobody seems
to have noticed.

-- 
Sabrina
