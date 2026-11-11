Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392459;
	b=k/6WUcF496r8baKHS7Lq6HM/zBh3uhDaj4xmtNEd/eqR3wPaD4cWmeiGbSM30DynPAIG
	 q9COrCCPJyT8d4y2sJi+eUqCe5qoLc2t4H8c14Geb5c+rRrIZoXXlR2lz/2heMFMuRtvp
	 wlnzhicN4iiUPXq8D7pyMlL4oWXyN0Hqq6PnM0EC8gOd48o2QihrxA0o4oAjGutI0wUkQ
	 5YjxvtDpHHYv8usC6CaQ/iA3gnwaAy2zgiIbCv8hnkzDOq/hORZU4wOXfZKuDUz+eCkWO
	 D5kdtSadcH8w+vTT9jQ+5eLcbtTe1LIRTUPW1E/UAah5vpSi0Yw2uqEiiYe7ryPY4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392459;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	b=vtFdbEKsyDpmfMrDQ3jXoxwA4AfrSGUEgwpYvP7yds9NssPiHfyO1UcuqL7UJLgYYmja
	 nNI8gWupf4OvKugj26DbOkLqTrGCXjY+Fm0cypmEU0sFfH6ZStkH74TglYms4kqHhYklz
	 zzAmcxIdlbOdwNXLIELs25fdDhF0CdMiGSHtY9itMVQVXxCSjWRSK7r87ozvH1W5MBybp
	 Vr/JqMxVjRB8/46vh6CbBcC65Yj8NLnZk+ud9T0hUqYBKttBdV2auu7tCTRcUQHAu3eLm
	 RlReSdtLUCI4sDKcrxpqm8CwolXPscQf59McReEOaF3/tB8VDVTMf399rREnr1m9ebA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lw7XGR4P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED82606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lw7XGR4P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A1F1F00A05;
	Wed, 11 Nov 2026 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392459;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lw7XGR4PoOoj/r0qE9ybC6RuXRVRqLbtlxsX5gjt14I3sx+OdNICgMsLSfHL1B5SW
	 tNSQjPjp0O55W2dfMWBLIbuWb0tj5T3RZYEhZM0wzUDLzL9SwoujKN2v2r8gxTlbD1
	 L10zx7/n5ZLBTiMZTPmpjtqmGjHdNpKepd9bOFyDxdSQwbFEKP2EK8JKVgmLxnYsZ/
	 2+ra0YE4nGjyYoh/FRI2WisHtKZCsh5m0/TdyO0H420/PtfCEwZXiy5Wkn7++PATtj
	 s0/kGAHZ5/YPa3k6wovE+8HM0NDXSv3W3C7BjqnzxmJFDLcV0PfOQORzOnFI32ON4q
	 ANDA/tLtazk7w==
From: netdev-bot+sinfo@kernel.org
To: Imre Kaloz <kaloz@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Elad Nachman <enachman@marvell.com>,
 Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Subject: Re: [PATCH net] net: marvell: prestera: disable port before changing
 its MAC mode
Date: Wed, 11 Nov 2026 10:20:58 +0000
Message-ID: <179439245803.2168702.4056378954487348665@kernel.org>
In-Reply-To: <20261111101521.9878-1-kaloz@kernel.org>
References: <20261111101521.9878-1-kaloz@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
