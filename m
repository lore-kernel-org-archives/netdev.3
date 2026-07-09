Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121B39DBE5
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617190; cv=none; b=RM9nHLG6d1hqJFJnsYk31/ml0eoldA3OG7V+l9na4QazsfBGI+R6rtzGWqYG55ZSdHRkUxhGTHlkA6WR+8U9CKaN8qYQwCynOnPo7Tn6P4XazYGSIRhe5vpTA+8jeJrmoAhbAraB7gE7VG+BcEIM0jY0h2eQ+bXx+rv9VjcJbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617190; c=relaxed/simple;
	bh=zfzxst+OIscXUvbk8QAIbzukiIr8kIyDsKyM5EYA5rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFNzpAAiT2/6vVtJlsVkzAfVIvMOg7DBXxDmW3JwxcGtSJ+Fma2HFucWy84zH6zlfes3ZWlMKIEHsuKn77dDzzavlOlJbUBahnrze77HeUEPy92BXFnwXzjVntVlRRlssDYoFG64jwGai+mFHgYyUApzYzNWVd5pgwSrmjjz0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkSi7MVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkSi7MVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7581F000E9;
	Thu,  9 Jul 2026 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783617189;
	bh=1pV70xEOvQyB3ukvmw0oiht/Cdcq4jFyt2B8YWj7CXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QkSi7MVBWoMXoAzvPr4vFBO+UOTmSx0mkflKFEeuc7vobI3Jbqwu5iTWL1GvopSRb
	 f4SlmQRhVJ8Qf6+C/iSIVrvPXdD+Ljz2j6xRwtWg9/kepoLUkLXmEYxmZhveT5Jj9C
	 Jz2h/abnW5jgGd4+eLH0B0I7QOLliL74pkqi4mQGHVbb7rEMimQcdFoJfp4tpyrSmJ
	 7xA1/u/t8BH6C05HeazzEhfzzDQys5AJfYhBW4dJ1peg07TbJnnsxcqD9yTlpSJbqe
	 TrXWLB0qzD8ycP7cfZbGHGQXIXc9fFUchp9KMuguNs3eMWg9EWdm3RNhKnQkBKDvXY
	 9w7A9xnz+l+NA==
Date: Thu, 9 Jul 2026 18:13:04 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: fix ETS channel derivation in
 airoha_tc_setup_qdisc_ets()
Message-ID: <20260709171304.GV1364329@horms.kernel.org>
References: <20260704-airoha-ets-handle-fix-v1-1-42516b3549a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704-airoha-ets-handle-fix-v1-1-42516b3549a1@kernel.org>

On Sat, Jul 04, 2026 at 04:21:38PM +0200, Lorenzo Bianconi wrote:
> Derive the hardware QoS channel from opt->parent instead of opt->handle
> in airoha_tc_setup_qdisc_ets(). The ETS qdisc handle is either
> user-specified or auto-allocated by qdisc_alloc_handle() and bears no
> relation to the HTB leaf classid that identifies the hardware channel.
> HTB derives the channel from TC_H_MIN(opt->classid), and ETS is always
> attached as a child of an HTB leaf, so its opt->parent matches that
> classid. Using opt->handle instead can cause two ETS qdiscs on different
> HTB leaves to collide on the same hardware channel, corrupting scheduler
> configuration and stats.
> 
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

