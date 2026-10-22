Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686285;
	b=KpPrSXNMFoPDIvYb6QHuqiuPizphRuL9aXsyHzB7suDq6finkt8fO9zbcsBo6e7tY0MF
	 XYnxeJGLPhonMfQ0Hi8xvcp6bKvtLySS8lZPtt0TWvwE4AWHxOHJLqfDxs9yO/eiDT/Un
	 s0NS+faq0mar6Dl2M+j+3oPL902bZdIsk2Z0TjQb6uWniNeu45D/Yj3Mhay7iaX5qlzu+
	 H+dAZyM+MX8gVqRCXcXSopNzJ7SC7KyKcyQ8otJfxno7Pqj6NyHBktMmxZAhWg6WVAf9E
	 lS0qY5gQHlpF4lOkXzrYcCpJVtiHwidMKrtsHayHlnzyrof2lXrTOXeSv7g35HxQv6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686285;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=e34/LbT2KiVBxSjoVzxoxlm+/Dhj+RXEgBl1nd9xMFk=;
	b=NoOFxzS6nbxpdG7V/TkLRUlqUBlPKB5mWBIbXvtwJFkpqRI6hWeuWT+nIpfSdUttsBok
	 L6hxfWAh1PDlMAcWHEhAUjuv6ViWZfoB4xN1a71iIdzygSh8B2nsLUGWi2dqiB6n8zdRH
	 xYP0QMomNbT2euC3zgelaI/E0yuO0nho0+rr1mz7gN6AxtJzGJQRIGYA/eHNReQyNVCqB
	 sR8/v9DBPRkP+a3e7+rH3lgelGZOIUpS1KnBu1S4WjadjtGPnr/0gmQpe7y2uYd1rP/eZ
	 3fMIWyOXYeSgwnZcTCkPwCpGpgTk6oQaoHXBtAfO/ajmnfQyihBeQz1SpWLV/Xm1dKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=qD2QFerf;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF15606A319;
	Thu, 22 Oct 2026 16:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF15606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=qD2QFerf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1792686281; bh=e34/LbT2KiVBxSjoVzxoxlm+/Dhj+RXEgBl1nd9xMFk=;
	h=From:Message-ID:From;
	b=qD2QFerfVpFjf88aQeV9orCfkWw0pAb1o0/fxq+hS0pR9d4WPtS38yaf4Wv5Jv/nR
	 QzR4zbj/RZ4YGyl68tjm0pbE3lxP8RqBhkypcS1Zi0+KCzp0Cp5TPvGlOh/8s0+tZG
	 p7VcTMvBT3Ozst5zM8JYwLQ5bnfc54eUm8oSoEiQ=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 9F0C9C0944;
	Thu, 22 Oct 2026 18:24:41 +0200 (CEST)
Date: Thu, 22 Oct 2026 18:24:41 +0200
From: Willy Tarreau <w@1wt.eu>
To: shaos <shawnq1@163.com>
Cc: jhs@mojatatu.com, Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org
Subject: Re: [BUG] net/sched: TEQL qdisc can modify init-net teql0 from
 another netns
Message-ID: <ato4yRBZ6iz-F77o@1wt.eu>
References: <20261022144830.67948-1-shawnq1@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022144830.67948-1-shawnq1@163.com>

Hello,

On Thu, Oct 22, 2026 at 02:48:30PM +0000, shaos wrote:
> Hello,
> 
> A process running as UID/GID 65534 creates a user and network namespace, sets
> a namespace-local dummy device to MTU 60000, and installs a root qdisc of
> kind teql0. TEQL reuses its global master and changes the init network
> namespace teql0 device from MTU 1500 to 60000.
(...)

I know this was mentioned elsewhere, but since you're sending so many
reports at once:

   please oh please stop CCing the security list for messages that
   you're already sending to public lists. It serves no purposes
   and adds extra work for several of us (review, triage, response).

Ccing the security list for a public message won't get your message
handled faster and might even cause the opposite by showing that you
don't read docs and seem to post in a hurry.

Thanks,
Willy
