Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538357C72A;
	Tue,  8 Sep 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888809; cv=none; b=AdSPLKIhfqyHozERdbp8SvFkwb9W+82YMBa2mM1rOHrXNvEHMEkCOYPg/sAnTaFuKNhdLZqcQYpjhGOvMlA+sEJRMzBOQ64sQs0EMORWC/tfR45yCGf14bs/dR8Vr+TMG70PaHjuGSvSH2Dzw/d19c/rwcdZ59DTMTA1j/o/9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888809; c=relaxed/simple;
	bh=riLQM3jCIOgbEO5KBT4ODeM6PgUKNGMntzBwTchICro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5hgsZM62hdMbd6xC0nPOZeTvvudONAdyL52YMfzqGzadhtIgwPZjM7/uGzpLmBetK7nEX8t6H33kvkXDNi1Sxy/HtfKtBv8ehZSU8ys4lGhwNKgUMwKCEYoCNPmJVipjjvvqPRB4ItPpQQ1HGgcfq5aX4BPSwGpT2idTbDaINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXmxoRyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXmxoRyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448A91F00A3A;
	Tue,  8 Sep 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888807;
	bh=gSEqPWuWBmJeAqSai2THiLWUXlpw8Oc1Y/w0Xu2Fv2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PXmxoRyRIS4G0lsCUZSlW69zAipYeJ1iW0foLItYUp9vnnoBXRpEj0mC8waUUuWE9
	 EH/7sZbwoyBFc+S7fwbliYn9Lit7JBN8M4E3Xx7jtx1edRjeV2QTWcSOdjbpV3ijhJ
	 mCa6rkk60LPKoF2q0Lp6u8uONLS/E+HpYXT55SHjs7+u8mSXVKQ7hui9em05NTgru6
	 bSTJBLkGfGPXGUs4I6IbvEYtOAaWUs/xHScXU7bmmuv0xG095ERRHPVF/kp24E3Swv
	 jrjnwz10S5GenAGAnQGhmE0Ha30OLTq6amUYl13aqToRJB+POefMu5klqlmKILOhoG
	 XK3309awkivng==
Date: Tue, 8 Sep 2026 10:33:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: <patchwork-bot+netdevbpf@kernel.org>, <willemdebruijn.kernel@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] psp: make tx key ops optional for drivers
Message-ID: <20260908103326.7b240216@kernel.org>
In-Reply-To: <DL9ZTV87UI2A.2QIEPTDS2ROKA@gmail.com>
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
	<178882561539.3212362.10949911837502586488.git-patchwork-notify@kernel.org>
	<DL9ZTV87UI2A.2QIEPTDS2ROKA@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 10:09:56 -0400 Daniel Zahka wrote:
> On Mon Sep 7, 2026 at 8:00 PM EDT, patchwork-bot+netdevbpf wrote:
> > On Thu, 03 Sep 2026 18:33:58 -0700 you wrote:  
> >> This is the first of two series which together implement rekeying PSP
> >> protected tcp connections. Here are both series together on github:
> >> https://github.com/danieldzahka/linux/commits/psp-rekey-split/
> >> 
> >> This first series is mostly non-functional changes, except for the minor
> >> difference that netdevsim driver implements tx key ops. Its tx key ops
> >> were basically NOPs, and in the future PSP core can subsume the assoc
> >> counting that it was doing.
>
> Thanks. I think applying was the right move, but I would like to
> highlight something that sashiko flagged on patch 4, as I think it will
> need to be addressed with its own series. The hazard is preexisting and
> much broader than the way sashiko talks about it. 

Ugh, yes, the complaint was sort of besides the point so Clashiko
has dropped it. But the problem behind it is real.

> The high level idea is that netdev core should probably take extra care
> to make sure users of sk_validate_xmit_skb (psp and ktls) cannot clobber
> what each other has set for that callback. In the case of psp vs. ktls,
> there are probably fundamental reasons why these should be kept mutually
> exclusive and their uapis should reject attempts to transition between
> them.
> 
> More generally however, any offloads wishing to claim
> sk_validate_xmit_skb should be considered mutually exclusive, and netdev
> core may benefit from a generic system to enforce ownership. That would
> help in case another user of sk_validate_xmit_skb comes along later.

There could also be confusion about the meaning of the decrypted bit in
the skb. Off the top of my head Rx TLS is shared between offload and
non-offload so SW TLS Rx ingesting a PSP packet may think that it was
TLS decrypted today. We should reject any TLS+PSP, not just
validate_xmit.

Both setup paths are under socket lock so it's a relatively
straightforward fix? 
