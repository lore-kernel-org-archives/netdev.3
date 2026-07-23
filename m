Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E940B11A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850097; cv=none; b=QNk8yA+DIH2VHYzDM5cEVO5NfddbI+VWuantnrk46JxMKMgEjf2yeWax+pR/vpndxGC+sICSRE3EIKAZ4zuEd6ZAzMAoxKW6MgfoGCrlrfbkfA2DJRBAdy39TSKUcWc5PV/z6hn8b9BFgeEInn0T7DqaP+6hsXdcGZTp8iDIe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850097; c=relaxed/simple;
	bh=0ZaNJ7GuqDz+hl4QL7g9M4Bh+wExI+j5BMyR/12kgQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2g/628q15Fjo2oBJGzdBCOe+Hct0cgLmRaSSGwjFENmhwP+eOWak7MrIR39v6sKtR5kz8cupVyWD4mFVs0EfDC3knXfZgfuigNzF/3gVE6PM8ZLSvA+yr1n3Luo2kY7wKNbOMRUIerRe5GexUOOjRYW1R1qbPRHXJZoCGStMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo58c8NC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo58c8NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143281F000E9;
	Thu, 23 Jul 2026 23:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784850096;
	bh=0ZaNJ7GuqDz+hl4QL7g9M4Bh+wExI+j5BMyR/12kgQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bo58c8NC6nSm9Ya/rI8OuuAEucgYTtNNe7XM2lK2vJ/cWNF63VSjabEW0h2de3YzU
	 GrhaBYYCri1LvJuOlVz+wX2S/eFB0xa6qAMoU7mmGeKafW71EnkTgexXUC49hSIqE9
	 ugKBYFlC5ZcP9rOAErluCmi+f1jKRVqV96ho9+AGO57ho786cgjaL99qyLUKjfufkm
	 5tz/CBqOeN7Nx8FpKFZODgooVZZoON9mHuem2AuB3W9gjpkT+Imu/KmMR2PQ4hHw88
	 9HZAOt3+tc+7UCGF7PZch28S1wjGkdYjswq6dszmNJHSZ+dcMUixU47KW+VX9whaqk
	 ULniYxxKkhjgg==
Date: Thu, 23 Jul 2026 16:41:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kaber@trash.net, vega@nebusec.ai, zihanx@nebusec.ai
Subject: Re: [PATCH net 1/1] ipv6: ip6mr: fix mr_table lifetime leak
Message-ID: <20260723164135.7d257e48@kernel.org>
In-Reply-To: <70026e78a5cafae9d3ccc560e2b5c4dd47f0a7b0.1784795838.git.zihanx@nebusec.ai>
References: <cover.1784795838.git.zihanx@nebusec.ai>
	<70026e78a5cafae9d3ccc560e2b5c4dd47f0a7b0.1784795838.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 01:38:23 +0800 Ren Wei wrote:
> MRT6_TABLE should only select a multicast routing table, but a fresh
> non-default mr_table can still outlive the socket once MRT6_INIT
> publishes it. After MRT6_DONE or socket close, ip6mr_sk_done() clears
> the routing state but leaves the empty table linked from mr6_tables, so
> repeated MRT6_TABLE(fresh id) -> MRT6_INIT -> MRT6_DONE/close cycles
> accumulate detached tables until netns teardown.

Sashiko says this is quite broken, plus it breaks the selftest for ipmr.
Please wait for Sashiko review to be released and take it from there..
