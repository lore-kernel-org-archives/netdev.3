Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7731363C57;
	Tue,  9 Jun 2026 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974684; cv=none; b=I0vuOnB8q/kKVBppd9gq1puRWfM6KZt59oefcjWkI+nVHxxsV6kKJ9JMfa5CgIXmOX94jriTdc+ke/nTPpBBxE9h5gk1YH0VKhA+1WJ/OO3bFP5naQ7zHaT1YFNsNZB1/XJS8PL4ZwgRqP/nV/Jp6cK9Uux/y7tDKKP6XmGX4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974684; c=relaxed/simple;
	bh=Pd10usMEu2aDvJ7SDugSDXmPcOvHYOes02ogwr8cKa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRdgidA/qe6xjIRTl0LvP1/lxxwTa3CMvJK29XdfO5coGLhq5Gc7RR8efqSINcAMgxrbr1jxq0Z0apOT2Lp4/Pcmz7Bm1dhHWEa+HqttytEeTL7t1MmM3vfCeRk1rtKthu5+7A+EERsK6sROaJD4zjzi6nwFO3RRB+6BXXFGJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDPAXF+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDPAXF+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158CE1F00893;
	Tue,  9 Jun 2026 03:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780974683;
	bh=7n8Xha7y/8l9LARUxBQjdIVK8pW1dU++pwn+FBHj0Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lDPAXF+UYbFuhiRyEaph9Bz5n3pqoMZFlyXHAglfAIrjKHQwq1Vxt1xG8zX5armN+
	 M3V/dHdZUDen6TWiy5jz/EKcOi4JUWVpLnU4cM06G/Nrns28LVlbb/7cbXU/h9XOng
	 Ik2v6mrOeP1SZUD1h4pw9BWioCDRQncuLNwvx5pc4PftGIHX/S2vd06/8U7Ao/bTSI
	 Ldo3tYh1nviWJfOxZgA29kYxVtYYU4KT4+FYFWq+KVQLJrFMw7f5u/9NaZL5IhkVFu
	 Pl9cvySCddxlo321OBtNWRrokvM4oq+3bkkl9Jc9youOgHrF7+bHBaCwIGGspgZtbK
	 bjlrNrvZvNK+w==
Date: Mon, 8 Jun 2026 20:11:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
 <hare@kernel.org>, Hannes Reinecke <hare@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v12 0/6] tls: receive-path fixes and clean-ups
Message-ID: <20260608201122.0ca7b1f1@kernel.org>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Jun 2026 13:48:23 -0400 Chuck Lever wrote:
> I'd like to encourage in-kernel kTLS consumers (NFSD, NVMe/TCP) to
> coalesce on the use of read_sock. While auditing read_sock for that
> purpose, Hannes and Sabrina flagged a few rough edges in the receive
> paths.
> 
> This series is a set of clean-ups, not a performance series. Async
> batch decryption and its submit/deliver scaffolding were dropped
> during previous review: async_capable is always false for TLS 1.3,
> the version NFSD and NVMe/TCP both require, so async-related
> improvements were unreachable for the in-kernel consumers this
> work targets.
> 
> A subsequent series will introduce infrastructure to support
> KeyUpdate for in-kernel kTLS consumers, which need to handle TLS
> Alert messages that trigger a tlshd upcall.

I still feel like the last patch should have _some_ kind of benchmark /
experimental result included, but okay, let me not torture you :)
