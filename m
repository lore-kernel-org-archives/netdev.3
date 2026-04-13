Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E631B838;
	Mon, 13 Apr 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087184; cv=none; b=eIHkCQmzpHLdb99CscY8ngQBAaDn7kj5YsH9qyf/UxiajapTFyWw1Q5ZCyMSMK+ZxAeHZQkmxoO1wiL+yk1AYI0ce5JncRRmxJJjupI6CFPQewfitMhRb+ZRRhqBwiYfRV0Fe8ENkQ3qeAZV/T2vveQiG6myMRdXfTbpCq7q2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087184; c=relaxed/simple;
	bh=lEN7FS8hoH1Af1Lmfb67tYn9dMmzAUGba/gIsKWqTDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huHtBL9d5MhxIIXf3T8oUkz3bNF5gAsssOV7M1s8ihFxYuI2d5UM9MQWx/9X5PFZpQMYNZu7amwtnIX8REDzVVIusF4Jhva65lpkO33RZ/bA7BTykk4ZsJ2YVrjPkfljC26tgauCeMKsVVDSbaPWoGWU2QNet3HdgLitO/M4Obs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=NGEQokCj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t7d7tP+O; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="NGEQokCj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t7d7tP+O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F0387A0169;
	Mon, 13 Apr 2026 09:33:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Apr 2026 09:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1776087179; x=
	1776173579; bh=gDbFF2INaQD7WCbZwTYhO/FEDwIaFi5St2SIcCMYG3s=; b=N
	GEQokCjqk+syLwOEcHiMQ/thpaQqpi5zFBv2RMZ4MH31pTEogjFckBLXRZ8VNPlV
	tIzTmLMDxtx5R2F8LOw02Qu9DTr+BrGz8SEQ1SfQvG/PzIo01q9RrD1Ba0XYZ7Wo
	8sY/C9CQcSa5lqL0KZNxghHW/QBdjC7NHC7v785ooJgA8eOtpybYAzQZn6X8Tc+J
	xGpWwtdydPw9NrTlyZb1GkkO+/dRwwwHNZwlN5fvaBkHf4shGppai2tIs5H4UDk0
	+Q8Efew/MTsm8QLSVejLagsm09mtbLVZ1yVG95cAdXvAObK+SXXaYyM9RzuDyqnF
	DV7WkGF4JUyxNah5tsZrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776087179; x=1776173579; bh=gDbFF2INaQD7WCbZwTYhO/FEDwIaFi5St2S
	IcCMYG3s=; b=t7d7tP+ONSvRk3lDiBEAh8t75fJxgQlaIj29SrpJqpKjlQX1p1X
	9VQoim3ryBpygmZtGeEdlqpFdwKx+VoikpEkJnP9SPQbYwqueFa4XlqyQo6Ksdjf
	er9BLeveeljQqdRV8P5guH94lPVZRVj0k0Iv7oDDnq4wHtZimD8LQZ/UbVWtYEBr
	4WuuVcu7iLQbi8TQ6r4nbEZWRul+LzyFqQ/Hkq8Zjoq9yiWpVWMXBxPnHuZSfkK3
	AuvL2ExxElExhiZdHWFvyn3bTmXPsp8VRxPGINTOGRE38kAjsDjIjH+bu5fWMOrp
	B7FAAVzYGQqjwY7Vd0XJqvSL4m2+k/qySug==
X-ME-Sender: <xms:ivDcabMawxCAq8ryN9rlENnt3zKa2yHHfLL_Ex0aN-fiiLM2fcgXTg>
    <xme:ivDcacfPgKk4toneojb347q7fGlg7LoZO9jlFU6oRm9r2cjjsOXUyiNrXDft2amhb
    VqLANd9aO1x7dWqTum2N2h7ex8EHlslp1RCSHRLRpau49dkfHsT>
X-ME-Received: <xmr:ivDcaYRM45zz9uASqFrqdFyljybxrYJ71PTZTH7xHjfruYQ_GXan4jNzZjHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhikhgvhiegtdeisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvght
    rdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorh
    hgrdgruhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvg
    honheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ivDcaSd44BKCvf2yl7XZsTrT3LC7Jcv6hdY7-iMEANiBSQDcFOgFsw>
    <xmx:ivDcaZsVaMXGEQ0OoDd0W8w5DhbzZzknrWLtmp0WK71A1HdQE7EtTA>
    <xmx:ivDcaWJoZIM_n6NP52ylBdTFoxommVulMMm_HPnl14ywgEeo2abfKQ>
    <xmx:ivDcaVbLVyVPVEEC-GnPisE7E7ypJKctjuUnXivfAugp8Z1yKC_Wvw>
    <xmx:i_DcaZ5XKbkVyk1MNfJawhuBqO6bJgUFry4_wejbcmXh9rJK-MZVUTcW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 09:32:57 -0400 (EDT)
Date: Mon, 13 Apr 2026 15:32:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, leon@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfrm: fix memory leak in xfrm_add_policy()
Message-ID: <adzwiKOPptwbNp7Y@krikkit>
References: <20260412020809.35465-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412020809.35465-1-kartikey406@gmail.com>

2026-04-12, 07:38:09 +0530, Deepanshu Kartikey wrote:
> When xfrm_policy_insert() fails, the error path performs manual
> cleanup by calling xfrm_dev_policy_free(), security_xfrm_policy_free()
> and kfree() directly. This is incorrect because xfrm_policy_destroy()
> already handles all of these, causing a memory leak detected by
> kmemleak.

What is missing in the current code? "we have a better way to do this"
is not a bugfix, it's a clean up. The kmemleak report says that we're
leaking the xfrm_policy struct on this codepath, which doesn't make
sense, that's covered by the existing kfree(xp).

Also, please use "PATCH ipsec" for fixes to net/xfrm and the rest of
the IPsec implementation.

-- 
Sabrina
