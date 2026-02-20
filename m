Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F425FA30
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622974; cv=none; b=AEmgExO+MGxLyz8ybD/PZQhi3+pdZJJGTopq7bhxitUzSufvbF84mj7SQxJoPvmJAIOs5gvAuV+mL3MsTBuIlLBxPiYbk0zhNKLNVybepc+aWfrHcNr5C4Q2Ryd4SZ/wfRIgGNqqOPmmlufCGpqjtxACFsnY8ELHxkcdhQgrmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622974; c=relaxed/simple;
	bh=QbxYjpvYK5cmxzAfdadtzt8NEStFyTWxngJgeUmvcsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5LpJM1jWSD0koRnwiQphvIuDxrhtv7YzDo6e6mPB7g1fZYKUiR5k376h7iYAYi73BuCqFi/58MYAbJBAx3JDVVIK8QcAvW6hLYGIPlLO/Qqq7VzG5XLHVY2GOfmNEzP7aykohwwCKZaFAa5jA2chSw0Hp2hWcRZJfsXCiZu0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7iAZNFV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7iAZNFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87088C116C6;
	Fri, 20 Feb 2026 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771622974;
	bh=QbxYjpvYK5cmxzAfdadtzt8NEStFyTWxngJgeUmvcsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d7iAZNFVwMuttwV85k1ZQbjPfzvjhYgCGx/qV7jqeXLJqYHYHjMc/sUHux1WJj8Fo
	 Uf1T/R8pLb5mUKGRsqEfbbR6J6o0/paihGCPoc61tO3Pmu/qKUtofpNOljBg6AFNR4
	 0+8XV419g9KkHHT+xf7VNi6OMTVN9E2MsxJT+AraEvP48n3AzPmSFRvRPNAa9nm11P
	 /3YIsXOqM0yghEqVuxoBoygfyhwEMSHiI7X41zNvijeA0bDMu94mQk11neA4Zh+baT
	 0ZmlfD339inDjKzYBSRarmusrAjw4tMor+jh4FB2qJqY33LCDVjOgoJorZ920B4KOz
	 Bw+RXyB1tcUHw==
Date: Fri, 20 Feb 2026 13:29:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Kurt Kanzenbach <kurt@linutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260220132932.1ed45656@kernel.org>
In-Reply-To: <20260220183858.N4ERjFW6@linutronix.de>
References: <20260220183858.N4ERjFW6@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 19:38:58 +0100 Sebastian Andrzej Siewior wrote:
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.

Fine by me, the fix is fairly simple. But FWIW I can't stop myself from
restating that networking core is not supposed to be called by drivers
in hard IRQ context in general. Especially when it comes to anything
that may involve user sockets. So my intuition is that fixing the driver
to use a tasklet^w work_bh would make the expectations clearer.

Willem, you don't find that argument convincing?

BTW IIUC the driver in question was igc, and it did not exist for
another 3 years after the commit under Fixes, which is another bad
smell here.
