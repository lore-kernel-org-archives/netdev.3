Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149E3B0AE7
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374142; cv=none; b=Pi0Yjw8wK/uM169mtid6aBqGKj5p9OaOhwlFZcEf1yRc0jZRn146PY86SemlLzrc2+Cet2h4OL0+v7YMvQXwuNb8/VNp28NkWQULB9S+IqrL0UhPPNdXOo0aPkRyN5CBzH6awhUhQgxvOwJk0MOruQaz1s/RBrqlBx5/1pV7CCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374142; c=relaxed/simple;
	bh=iS1uNkQXFgCX8PJRW9JhPNGs994LGJfKYd7zWtir2CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG0UPO1HeDOqkRIl7SsIoUZV/2oeyH3YkwOqXyAWweF4xaxEWhOxYKSBKfLFxyqdfZ9mg0rZDcPaEEXe5t5ml6W+p39cT+a4dE1eZTigRriMtrm2GQySz5OHlYz2UKqy+8REXZACqAt68o13Rm56dZ2hIpGo/zKFGGiIq/g8vS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv/1P6Qe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv/1P6Qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D24B1F00893;
	Mon, 14 Sep 2026 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374141;
	bh=C0kiO3xDZtUMHsa0u9r1xvOw9nqhPki7GtqPDBl79Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dv/1P6QezOQMg2QtDjXtAAbTSyYFrXkQGxMpPRX7BZFHjx3b9xVo6OtougRRN3bjN
	 hvYxnE9DqC7VNPjqQ3leWv8W9BDrYeUqBX+E1K4FIoJkHuaPRa75rKbKA9LWGKjJ9V
	 suZjLiopsuNUudCNWx3W5TD1jWN/LCmvcHJOobzXuKj6i5cQiTCBQDboSpBmN1BFwJ
	 X+C6xV8+yCSiq3NaQpweaC5JiNkpZQhtH2cuVUya9troUL3YA7Dg3Kpl1rp4eBElVI
	 b2KFcFFdcu7g16/yw3lSEMu2+qz1We/KE8xHbRhvAdIi0yz8tqSXkuJSVWQprMir9o
	 OrOzynMSMtmtA==
Date: Mon, 14 Sep 2026 09:22:16 +0100
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	vega@nebusec.ai, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in
 qdisc_alloc_handle
Message-ID: <20260914082216.GL48209@horms.kernel.org>
References: <20260911133146.3440982-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911133146.3440982-1-victor@mojatatu.com>

On Fri, Sep 11, 2026 at 10:31:46AM -0300, Victor Nogueira wrote:
> qdisc_alloc_handle scans for a free auto-handle by probing the
> per-device qdisc hash one handle at a time. With the 16-bucket hash
> populated by tens of thousands of qdiscs, the failing scan is O(N^2)
> under rtnl_lock. Each failing add holds RTNL for 0.6-0.9 s on a
> production kernel and about 1.7 s with KASAN and lock debugging, and it
> can be repeated back to back, stalling network administration in every
> namespace.
> 
> First try the handle after the rotating cursor with one qdisc_lookup,
> as the first iteration of the current loop does; that handle is
> normally free. Only when it is taken, build a bitmap of the occupied
> auto-handle majors in one pass over the hash and pick the first free
> major from the cursor. The scan is cyclic over all 0x7FFF majors
> starting from the same autohandle + 1 position as the current loop, so
> it returns the same handle for the same device state and fails only
> when all 0x7FFF majors are taken.
> 
> The root qdisc is seeded separately because qdisc_hash_add skips
> parent == TC_H_ROOT.
> 
> When the next handle is free, only the single qdisc_lookup of the
> current loop's first iteration runs; when it is taken, one O(N) walk
> follows.
> 
> Measured as tc wall time on a defconfig kernel in a 2-vCPU guest, with
> an HTB root holding 32768 classes and all 32767 auto-handles in use (a
> no-op tc command takes 5-6.5 ms):
> 
>                                     unpatched     patched
>   failing add, space exhausted      613-749 ms    8-10 ms
>   add after a mid-range delete      572-573 ms    9 ms
> 
> The failure path returns -ENOMEM (bitmap allocation) or -ENOSPC (space
> exhausted) through a handle out-parameter instead of the overloaded 0
> return. Since either error is now possible, the extack message changes
> from "Maximum number of qdisc handles was exceeded" to "Failed to
> allocate a qdisc handle".
> 
> This is a less intrusive fix meant for backporting; a cleaner approach that
> uses a per-device IDA over all qdisc handles is planned for net-next.
> 
> Conditions to recreate the bug:
>   - unshare -Urn (Level 2, namespace-local CAP_NET_ADMIN)
>   - classful qdisc (e.g. HTB) with many classes
>   - attach ~32767 auto-handle child qdiscs to fill the handle space
>   - the final tc qdisc add with no explicit handle scans the full space
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Vega <vega@nebusec.ai>
> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

