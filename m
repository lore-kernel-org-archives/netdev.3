Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E29411FA1;
	Fri, 25 Sep 2026 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324649; cv=none; b=Rbwc097ILGYJgNwUZyeUwmwXfF7ZNw9++EgjwzXVx20Z6utIgoRMr4YmXkRJklKoJfOhWSznS4pwp2ab40+h0XAArJoMd9tqsRfPkEpf8irs+bXqMe7X37RbLSTJJSZKT60Uo5rcL+3AR5SfOABntz+nfppuAQQSfkKQ4xzP1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324649; c=relaxed/simple;
	bh=xZ3AkP0mg/KShHyLhTn4b93mg5mqhGCdg908eQZmUYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtmF8n6/YiHFKEuL+Vjlb+q48smcz3HUb4dj5MHRokHSZX737DdJgY3eEiI1YtdgjLF/4NXqYLLSOxU2TygpJ4zcfrEjANYAvbH+KXBmNAmDvn/7PpwHQtgO5HhSzPaTCGfs1xZpk1KgTABOOvwtw+zKSALIgrTxAgvRUwGU0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=oQXVxAlF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="oQXVxAlF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=xZ3AkP0mg/KShHyLhTn4b93mg5mqhGCdg908eQZmUYI=; b=oQXVxAlFxWdf/+k0clEXYxnrwT
	q58SoaiuweMoXSPRktlQ2Gg7VeWpWUhYqH16kQDKN3I+9a9RS8UMTyR7mFxIpt86dqIwhOUeG/1Pc
	BUFgvSgmqWmasncnC2VTeRns9mb9KiiJ+WUT3o09pCgh84zHghYoC62TNnM+QLxso7Z8pr3i2wH1F
	Y/+lItaNfUfRBHhXDtEMnoUpWIT94yWk/FFA3vD61aQxRVpT2QZXdhY8Xun8499MShrOUgIwCkMiR
	Ae6LUoNG7YgL+8UxER8gxYblzdjLrzPvVnU+fl41KYu9G9QBWH4eVNn85qJcwCsg8G0H0InzBkaP0
	PleLFX0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA1Dk-005Abb-1a;
	Fri, 25 Sep 2026 08:23:52 +0000
Date: Fri, 25 Sep 2026 01:23:45 -0700
From: Breno Leitao <leitao@debian.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, 
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Mohsin Bashir <mohsin.bashr@gmail.com>, "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
	Simon Horman <horms@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	linux-kernel@vger.kernel.org, Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net v2] eth: fbnic: Keep real queue counts synchronized
Message-ID: <arYutH9Mvn3OzR8-@gmail.com>
References: <20260924191817.1843726-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924191817.1843726-1-bjorn@kernel.org>
X-Debian-User: leitao

Hello Björn,

On Thu, Sep 24, 2026 at 09:18:15PM +0200, Björn Töpel wrote:
> If resume gets fewer vectors than the configured
> layout needs, fail with -ENOSPC rather than silently change the queue
> configuration and its bindings. The netdev then stays detached until a
> later recovery or a device reprobe.

I am a bit surprised that I is better to get the device permanetly
disconnected other than just getting it running with fewer queues on
resume.

What is reprobing it later?
> Fixes: da43127a8edc ("eth: fbnic: support queue ops / zero-copy Rx")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org> Link:
> https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

PS: The question above shouldn't block the merge of the patch, it is
just for my own curiosity.
