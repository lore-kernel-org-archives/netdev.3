Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1F3A9D9F;
	Wed,  2 Sep 2026 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788389332; cv=none; b=M4fgjnhSHA5QwT95djojhvDakgg7+UMUtrNCL+tZTIRnsuLelXkV5iv34KFr/3Hy7Y8FeIQwqhmp21yf7lvwoqN2K6AaRvN8G0KjtuVqWkbV8nE4xR9bFqX/hxQnoKZxf09zRqT3ibryALkvTqENRH/jY99do9k+uv2juF4MWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788389332; c=relaxed/simple;
	bh=40t0hgxS4XPNzElFaEEuYNYujSlwACiFk5X0jpDQpso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKCdW6lmvF5nOPTyUNIWwdsRSAKdiLxIZS/HL3tJwxQXNsIC5UVOkVJ+BETMK5oUmyGaZGkM4FwQ8gl3gplszwvIGx6pKLz79n45Lu/sEPFZyH96V1ih0VWEXM3UWSY68BzaDGiKZLB0O/3XHqtU3uDOfJrHfGu4uOUZc65Ij+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8iixU8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8iixU8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA251F000E9;
	Wed,  2 Sep 2026 22:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788389317;
	bh=igDMCCmz5PGq9Z6y9npw9FedQbUox+5LrQVQalZWSfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S8iixU8I8BEDSv5fKt/+HP/nxfzMlb4bUORL89PEuLZC1L+yPj5WbTTBOfgCK37Yy
	 X1jlFUmcMjHpfsKODpeItB2T7TZ4g7GY7DmP90PHm5pM06hVpn5q5nEty2o07fzk1v
	 V2l3iwwppU/uQ8j6LF0AY5pYTtXdPlIGxqdK6N5m2yMyc7puB7oAEsfWkE4JSwDmKW
	 oTXKamLUj7+fHuU7Q8b7Nnf5TecHHeD2BCiY2nXRrmXHFR8MyxjGvIiQ0PY5WSpQWw
	 wqE+7aW0RHZyBvFz+X0hw/UwnASCzi0tzyLEpThoY/YHhCnlnxE+cswjbS+UeeB6Vz
	 hOBB57DYOn6RA==
Date: Wed, 2 Sep 2026 15:48:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, Wei Wang <weiwan@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: yield the CPU on every exit of the threaded
 NAPI poll loop
Message-ID: <20260902154836.19a497e5@kernel.org>
In-Reply-To: <20260902210053.263070-1-sochnev.v.74@gmail.com>
References: <20260902210053.263070-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 22:00:53 +0100 Vitaliy Sochnev wrote:
> On preemption, raised in v1: same board and load, unpatched, two halves
> differing only in that choice - worst "ip link del" 248.48 s with 8 stalls
> under PREEMPT_NONE against 0.39 s and none under PREEMPT_LAZY. So lazy
> preemption does hide the symptom, and PREEMPT_NONE and PREEMPT_VOLUNTARY
> builds are what is left. It is not the NAPI thread being preempted more -
> nonvoluntary_ctxt_switches on it is 4.6/s under LAZY against 13.9/s under
> PREEMPT_NONE - so that is a measurement, not a mechanism. The missing yield
> is there under either model.
> 
> The loop is unchanged in Linus's tree - net/core/dev.c at v7.3-rc1 is
> identical here to net/main. The numbers come from 6.18 because that is the
> only kernel this board runs: mainline carries en7581-evb alone, while the
> SoC dtsi, the board DTS and the airoha_eth changes it needs are still out
> of tree. On 6.18 the loop has no busy_poll_last_qs parameter, but with that
> pointer NULL the two are the same code, so the change under test is this
> one. The busy-poll path is unaffected; cond_resched() was already reached
> there.

Rebase your OOT patches on latest and test the tree you're targeting
or keep this patch in your downstream kernel as well.
