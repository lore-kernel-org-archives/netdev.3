Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FA3C5DBF;
	Mon, 15 Jun 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539932; cv=none; b=ey4YucxkC1weJ+d0XbV3N4EzPBbZ9m7826CS4+H2h2MPeh/PaG4knxObAVcQJ4yHNZOi6tAxkUztH/XwX3aBY01TO1f1cGJfkQvg7+H316U9VEjX313hHIVWkePKpt5x65S02ZGzWDjwyPETFiwKzK6BCIDp14GrYJQVSVjOZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539932; c=relaxed/simple;
	bh=/aqVyEk01tea2mvL87B51F/QbejWzJ3sgxr6tVYZSK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYHGHKb11uLri897NvkpCsR1aW9fQvHGCPxkuAPHyCxQDajW1IOXkzkorO6Cg367ALJK+UftEevyb5NgIDfWIhTMxsSMkGSKZBf45rz6iiSqTJvU5OmwY4/dmpGGjSwjLSu90aYhAQEUP4a6aBRcZwGpyH3t0w1PZJylXkPZU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzgcoK32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzgcoK32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F791F000E9;
	Mon, 15 Jun 2026 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539930;
	bh=cv890V/mwL1sjI7Anz4bRGw8JXgE0Yg4I5UGdDNE3iA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TzgcoK32bjlyvXPs1cIK9gYDCJZ5l80kZ3lFyOL9+wiSAK7G9h9U2XDa8fneheD7+
	 hCUGk3wTAFDULEySHQ2fwe1sN0bngAWGg8+wT+hR08llz7NY6d49wyqA6SZdztx4Bf
	 EFh7D9M66IKQGIaeei6Sr/mhyRwUfKDuiaimE526PI9l6rdeGmcMRv+uwC2OVjv0mK
	 rdseWP2blksCrW5+Z94zjkalnusK7n3FRtv3+koInH7MF4TzZWbxmePiQrqEptCRlA
	 knxZ+oxpdZfeSUsGH8W4gjl5dcAXQIQmdHbdAg7Lb63WSWpMkvzKJUbAZuXt7uNsHY
	 82YtzmDSoq3bA==
Date: Mon, 15 Jun 2026 09:12:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Amritha Nambiar
 <amritha.nambiar@intel.com>, Simon Horman <horms@kernel.org>, David Wei
 <dw@davidwei.uk>, Stanislav Fomichev <sdf@fomichev.me>, Samiullah Khawaja
 <skhawaja@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: netdev-genl: NETDEV_A_NAPI_PID is the init-ns pid, not the
 caller's
Message-ID: <20260615091209.633c6e2f@kernel.org>
In-Reply-To: <20260615070152.1211050-1-maoyixie.tju@gmail.com>
References: <20260615070152.1211050-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 15:01:52 +0800 Maoyi Xie wrote:
> Hi all,
> 
> I noticed something in netdev_nl_napi_fill_one() and would appreciate
> your view on whether it is a real problem.
> 
> It reports the NAPI kthread pid like this:
> 
> 	if (napi->thread) {
> 		pid = task_pid_nr(napi->thread);
> 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
> 
> task_pid_nr() returns the pid in the initial pid namespace. It is put
> into NETDEV_A_NAPI_PID without any translation to the caller's pid
> namespace.
> 
> NETDEV_CMD_NAPI_GET has no GENL_ADMIN_PERM and the family is netnsok.
> So a caller in a child pid namespace can read it. That caller then sees
> the kthread's global pid. The kthread is not in that namespace, so the
> value there should be 0.
> 
> This looks like the same case as commit 3799c2570982 ("io_uring/fdinfo:
> translate SqThread PID through caller's pid_ns").
> 
> I checked it with a small reproducer and a fix. From a child pid
> namespace the reproducer reads the kthread's global pid. With the fix it
> reads 0. I am not sure how much this matters in practice. I would
> appreciate it if you could let me know whether it is worth a fix. I am
> happy to send the patch.

Please send a patch, we should try to obey the PID namespace, indeed.
