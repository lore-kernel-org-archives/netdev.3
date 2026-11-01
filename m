Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793565704;
	b=fqa/6bP9GwfbLaRDsN9B/wqwPNcqwbgUubK36KkRrzHm2g02woeWdaVELv6G/nl3bZZA
	 kbtCYt/9QGY1g4YmdGDOHJEG/YghLr3CnDawz7GtAi3qvi7rF+Zn90nwb2ZDxLRkGRvfh
	 3cJdIlglytxzrLvr3KKn3wKObP3j2tz2I126KF7+23BcrOlFIROn2BZYZ6OHCbWoXNAcn
	 MaAvxY5UmW88LFdzUgrC6WVkpdfP7Tx3JczIH45H6S1waiAc7WtciFt44EIG5Mg6bkNED
	 RdOmosUL5ntAL38gPtLqllNUuo9QcOzgqz8EtH1qJ6EQAy04g8bYJsxdnuIrQ2sgOfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793565704;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Unite-Industry:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=OE+bhGYt+JzO0So7FuaUclK5Zg9NdzaN4nwwSetcWfg=;
	b=fsdKIGM7qJq+vmUeVKT6X15p6oAb6zS9RRHjPB4YB+0xl+wM37ZwSmbXe8UqAE+WinIj
	 SBsZeCNAUyI2Mr6AqZ1qWyseZvpwIrfkMp3N5NwXyUYTdhcyH+46KU5FFnB/6AETgBxys
	 R0FvJst63uLyPcwLsuorMYQLhw4rG4DzDY/OpClNRWva/el1u5rP9SbFZPVD7lq1PtZND
	 9zIrNSQBWw3YnMYoxkJlLuVdVePfWpOuujiUMZD72pOYE1r29coDgSrB255iJ8q9YmBXQ
	 u/m58JCk/HnhtIGOBktOW2QZyxLKBmAIuAJ1FZqDrsY5VSH4be6FfiGCTzoCYguqhKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="Up/Ir8lW";
	arc=none smtp.remote-ip=23.83.218.252
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A4606A324;
	Sun,  1 Nov 2026 20:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E02A4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Up/Ir8lW
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 20438800379;
	Sun, 01 Nov 2026 20:41:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (100-99-198-86.trex-nlb.outbound.svc.cluster.local [100.99.198.86])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A69258015A5;
	Sun, 01 Nov 2026 20:41:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Industry: 7b97c46a0a41dca9_1793565696913_1501605269
X-MC-Loop-Signature: 1793565696913:402893550
X-MC-Ingress-Time: 1793565696913
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.198.86 (trex/8.0.2);
	Sun, 01 Nov 2026 20:41:36 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4jHmw00cqxz2l;
	Sun,  1 Nov 2026 12:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793565696;
	bh=OE+bhGYt+JzO0So7FuaUclK5Zg9NdzaN4nwwSetcWfg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Up/Ir8lWN2rQMEREb9m8BT2/Gff98v+2nGsl/cgAZDz2ChIuaiEd4bTTPDvBe/QB0
	 QxEyaJ36JbtlQ0ka7IDCx3eXbPi/qG060lQR68Iay9DYJdQu03Nm4Pt/Zu0KGQcWhW
	 DnRqYDM35R4J3nDd2A8Wi0vSH1rscsPKh9WheC0MnnfoYpMmIrTkOwMzA7oJNZZrOC
	 TMjjj1MVanaxk3siDJMOoBD25qNQqvqsYkGH+0cr+aK+2EafwC4l1wUTwELekoJCxy
	 rbfAVT/CQa2kBGMf7TACJonfhoQEWxFss23zvnJUEoHn88/xc6CtvixKj9fEa1Oz8T
	 kq6lPZdYOcFIQ==
Date: Sun, 1 Nov 2026 12:41:32 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: netdev-bot+sinfo@kernel.org
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, kuba@kernel.org,
	pabeni@redhat.com, anisa.su@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mctp: accept MSG_CMSG_COMPAT in recvmsg
Message-ID: <20261101204132.eifrbvmpjjktdkno@offworld>
References: <20261101200331.1956836-1-dave@stgolabs.net>
 <179356374166.3286.2383588037768263377@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179356374166.3286.2383588037768263377@kernel.org>
User-Agent: NeoMutt/20220429

On Sun, 01 Nov 2026, netdev-bot+sinfo@kernel.org wrote:

>Hi!
>
>This is an automated message. This series looks like a fix, but its
>commit messages seem to be missing some information:
>
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
>
>Please do not repost the series just to address the above. Instead,
>reply to this email with the missing information, so that reviewers
>can take it into account. If the series needs another revision for
>other reasons, please include the information in the commit messages
>then.

This is not a random fix, I actually ran into this while testing 32-bit
support for libcxlmi: https://github.com/computexpresslink/libcxlmi/pull/62

>
>The evaluation is done by an LLM so it may be wrong, if you think
>that is the case please reply and explain.
