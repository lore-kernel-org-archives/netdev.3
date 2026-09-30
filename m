Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1E3BED44;
	Wed, 30 Sep 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759611; cv=none; b=qdu3UNo9LytNb8vOUyQmk4pRPK8yQro8GuFqAvarODNpyHzA+YN6O2RryhBO8GgKHgtOa1aHXQKXy7Kk2hJtRemHXLE2tVSTXH9K/dGNvCVmlOyic8gRC+nlXhyo4XB+16D2ICeFuM4BO0keRXwxIaUOWujGjXkyuv8VWidCn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759611; c=relaxed/simple;
	bh=IxlfuqDrkgSpiLNaVb0NlpWFcUkIkNjXAMrsnCOOLr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeQn9tbFGI6r4+CfVmKxjqJbgxgyN44rG0r/nMEAchdU4HqfZYTAB7Xej6HTyE8NBRVFLAddK7dSju3HN9vR4UvIB9otAENksYqajGD0C22On8lUw6imeDfLS/dteocdEXtO55d7HDyG9koGgBj+GZLFvAoH5U7s/plTkcBMXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KJq4dS0o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0o40mPs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KJq4dS0o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0o40mPs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C8417A0702;
	Wed, 30 Sep 2026 05:13:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 05:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790759607; x=
	1790846007; bh=1nC1UVy4t2WwVoRJhfMm2fOdz3wxL0myhdMxjHdg71w=; b=K
	Jq4dS0oA1EIo3GmrqIzE+GJzmLXn40VB8b2e31jDH3s6PBs29kpTBmXPLjMPLBMf
	IjSweryD/hhpOcE9G5Ayy28OIDTCKtd+kA0UzfwqKsyGYI7t0gD5tTnPwiCRXFID
	kmsFSo4LgK+BoVvT4Tcf1e4k+i8+ilcuuTKP6+E7odcvVFTZTzwlAq5VXrLHVCBv
	EcJA51PuAiufCHk8oWYp1RuPpmV5n3m64mgF1vEzXC1obr9JHDtKISJTGrSGUtt+
	it7CXLGcrvmY7ky7KLbWw2rHWsi6B3ctCgEbTh7EvPM2mCLd/9MflBH8YbhYGFRG
	6N5CrSjBa6cisfuSp8Z9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790759607; x=1790846007; bh=1nC1UVy4t2WwVoRJhfMm2fOdz3wxL0myhdM
	xjHdg71w=; b=h0o40mPsNvfTx9ZQtH+avoJIbB5S53rZ2oGRhZdTL/w+C7wBRZk
	g+YzhaWPjV/NRuEGl8xEtY9XwnXdAS5kHg0OOWfshL40kggIvJFjEnTbtNwv/9Ah
	vtm7V73am3iSDDgdQDwRlLNN9ncMY5l/i+S1xVU29v3Mr86jK4FMVqkuttsu/OpE
	WiM4HYls5jEWOUDXpwyYYaYdeGyUyzPsLdquzABRnxr62vdfI53omZU8AHaOCRAm
	/qBDjglzAop8z4SgfaeUbXNrDYEDSn5yVVdinup13WPpgFRLNUy6L2dd6UkDcEQN
	46Oc6SgyR2sZh4aBzmzseKoj3FLPLIy+/Vg==
X-ME-Sender: <xms:ttK8asI-c_XWs_9mb26glu9Vv-S-DDl3R79e6UmL6afH3ys-sBMRCg>
    <xme:ttK8aqaKxIULdvo8ihbwoAfgcwdz1oTmNPdGeTV3_PdzR5oZGhsrfmqQLwHHmqs2K
    -m4t-LwsReorIcYIW9F7ZTaITeqI5CgtYW-GDwZQbDAQCu2TxWgOzDZ>
X-ME-Received: <xmr:ttK8amBwlkWgke1zcTJNi4XvKXNYYcCFOeaN4BY0hJoOIxQKWGHI4s8Noy2K>
X-ME-Proxy-Cause: dmFkZTE4NMMjpg7Cs9y62M7IqXGDu6jAzbpUHpCYUBrJAN5E0Y/1vziUUl76agErQ2RhAK
    xh2FNXbPgjXGsJuD0fT6Xtfn8n+sfe4P17fQi5lN2bRAEv7SKKO66ImIGHnuQEYIVZjSgX
    gIohwNenoIvT7d2qnh7ubM95O0oYbNr8BmXHvvtSbAIyAckaMaJ0EwM0qAcK3Cq2VJn8vF
    Lx1wOLelVcxcaVXVaWcfN2qFbMM7ATAsx8MIUXSbB9GyQ/zag6gYrKbwVhJLTCc7KHpzPL
    JlKSHQkpLD5XH6wMp2LYFP2OQMMjZZcHlhyU4bMGHE52FKcKw7S06XGK57hPqMvvYbh8i+
    wyjKojOwcVDkIompl2NgVWoZL3qVVuxTPIspqdAA4XeeC5RlFucZJaWrv1FcCC62J58ySv
    Atu7ZyBzXviDD2gojpZtX6YMI8LevM2Qs1JKPYY7uM8lxX4EmuE2G6QorehaHcWfkbyk7n
    NNSdXgm+phvr4SlfdK0oo1GOXweptKMp2XjwXDiwbuFV70/SEowE3XcOmA2bBfXtWIK/LX
    faT827YEGkN34p6Rj0wQ1R4NpLKw/JcA6suhyNqHhJxn77Xz/MmOf5XudN/k1kbAZWidm0
    pkZ0ZEjItx+csBRkUtbv0habmdc0q25YG4JeDGdFLLQ1qt9JzkWGEIdTAJYQ
X-ME-Proxy: <xmx:ttK8asbraJnHLhTjWRknIrSM8-pW2oiq3aefkiowILbDqeTVnDYbog>
    <xmx:ttK8amli03OL0DEakZB5djkDyhkWVLBgOyqdKykGFAmatM6AT5ar_Q>
    <xmx:ttK8apqnaL-LgTRxYWa3nJ25e6iQg1khBvZUXm6FlR1PKJ_mEStpkQ>
    <xmx:ttK8agDybFzou13gk2xfpNRSHOJDcj-PV7d8DFpfrkxLmLRZkZATqw>
    <xmx:t9K8agY8er1rN2km4WSR0QrWfdGIxNJFpFlhWbxzNeJojRqoS1eA7-Rv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 05:13:26 -0400 (EDT)
Date: Wed, 30 Sep 2026 11:13:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Qingfang Deng <qingfang.deng@linux.dev>, Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Dave Watson <davejwatson@fb.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
Message-ID: <arzStIrdizPp_vbI@krikkit>
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930052636.166007-1-qingfang.deng@linux.dev>

2026-09-30, 13:26:36 +0800, Qingfang Deng wrote:
> tls_sw_splice_read() returns 0 after receiving an empty application
> record. This looks like EOF for splice(), even though the connection
> remains open and more data may be available.
> 
> Consume empty application records and retry the receive path instead,
> following the approach used in tls_sw_read_sock() since commit
> 3be28e2c9cd0 ("net/tls: Consume empty data records in tls_sw_read_sock()").

This is similar to what Chuck proposed in July:
https://lore.kernel.org/all/20260726-tls-follow-on-v1-2-99bf4cc1c729@kernel.org

but Chuck's patch had some extra bits (handling of the "released" flag
and of signal_pending).

His series also had a selftest which should be included too
https://lore.kernel.org/all/20260726-tls-follow-on-v1-6-99bf4cc1c729@kernel.org/

-- 
Sabrina
