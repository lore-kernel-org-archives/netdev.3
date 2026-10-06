Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299AC54704E;
	Tue,  6 Oct 2026 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791251240; cv=none; b=MbJ4FG8NLhnV8Fwxs7AFHgWWsN995WCVOGhJwjAFcdkdKnT2uMKVd8Dm1T6mYCKzX1+CdcSAQuH78gr5PecTVzG4uHNkwH6eG2O3B8D9Q2pjUdeH2zRhFH3XTV/TKlwPYi0FmLRJG1K1pVaXdiwOgpsWQxk8MxTiSwPvb/6w+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791251240; c=relaxed/simple;
	bh=EsFgRCWyjvJZqCm7Aq6Swgf/HYHVwfcAsNYoXyetMGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm1ftxHJ+B/+9W+GwolmErdwXcVcas939Q11AQtBcvHWWd6XaePPKxsI9sDM4ntZk0c8v/lljpC4wLSp2+9GNJwrlImyE9bEBI/SRu+l7CJF00bt1FsX3bnDPpNRgIbgKazRi3a9bz5LK5RQLW7iSomXcmjVuyOhGEKQnF43d/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5y6xKyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5y6xKyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567061F000FF;
	Tue,  6 Oct 2026 01:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791251238;
	bh=eLeP6VbIpX/VuWrTCoAx460K0ej6i0vT/OpWHB37wEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M5y6xKyIcc20JZpQCCnt8n3d+ZwVpEVGQ2jZ7Gk/5fukaoXLhRmWTnC1e8yjmzBEh
	 kmEQhm4Szy/LFQQMH/2hTkZGLgec5T8ipFbmimtKFqaF3aOJV3psTKfFNBZOGaaDr9
	 puAIDoJpkG1yAQo6HH9Q9dPZrjuG9eIXO1jwKTNOKLqunIARHGEGk8w14M0Lhg+F0q
	 ORnj3hcSFiJPkdwlXVIQ9a3zS9md5//ED2gBN4dzH93T2UCH76tYh4dxLWqWBYV6/c
	 8TrVxr4+LBEnh32jsvDGN76KM5LPQ83njpjtTmc3GYFU8kdKe9UMWHQ0Ox4jfAu4SD
	 vcOHNboUqm+QA==
Date: Mon, 5 Oct 2026 18:47:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: leave the datapath running for
 normal-size MTU changes
Message-ID: <20261005184717.6c9a7f22@kernel.org>
In-Reply-To: <179082977927.31693.14994198839172125816@kernel.org>
References: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
	<179082977927.31693.14994198839172125816@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Oct 2026 04:42:59 +0000 netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

James, you have to reply to these.
