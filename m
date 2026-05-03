Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE33188596;
	Sun,  3 May 2026 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770257; cv=none; b=u11x8NNJ49oaHRpkyQNNGgYuchO/0tkZFSsCDkIhzaWowQwXn0jeUkE8vvZZRfAb88YA2QERF51YIN2PloT5j5G7obfrkVxrqnsLrc2y0gtL/msHQyzXWc0UjKjIYgkAZcJSAvNlx3yKH5Xt+Tk+vqcED0jm06z08QxoR1+dPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770257; c=relaxed/simple;
	bh=ixgBVm3QW0ZNZzBllIY/kXAyuON4Pz3FrKe4czUF0OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgwARltO7mljESQO3FI3NxXTWT2IzlKBQoMYrHxj3+xyzM1P7jwCFjAWBDGIU/8jA+W3GWk+Qpdbfxlv3Y8SwIFSSj9rOJBLx09BES+s4eiS+ZEOSCBkkkKIGcyMKT334lCwlcPVXQYs9mlJ0tGfJnkNUsFqRbY8gjbpxnbbvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvZIsrxy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvZIsrxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A5DC19425;
	Sun,  3 May 2026 01:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770257;
	bh=ixgBVm3QW0ZNZzBllIY/kXAyuON4Pz3FrKe4czUF0OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GvZIsrxyYCWyARZBDnQ9sYE2wd6mb39EQI5XHLk7T1AvaGR/5w6Z//+zs93Vn3SUN
	 Lpi+MovPDZ1d1azHXdTjQ9AKAK3Mw8sxej08kJtoF8PJHhuBdNXK8Yprk8zwLV70oi
	 B9zgb75JkbvTweT3hcsjrXI62QppHbsp0B95Hv0ZGsK7nl+QVdIqpH+KTUZjxD6Bw+
	 bSI+t5QgI3kSo+no1yVXA8L76dcjjPpxdDZCALR/NfURbtWGqmuDUHDLdK2Pb8OEYr
	 vMfmZS0Zig1xAxjPcblqotPh11B2ZD+XMjTlmlrokTsfeluhznl3RbI0ep3h+yKGYc
	 6/9avyi0y2e6Q==
Date: Sat, 2 May 2026 18:04:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v9 0/5] TLS read_sock performance scalability
Message-ID: <20260502180415.0b0bf12b@kernel.org>
In-Reply-To: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 17:48:07 -0400 Chuck Lever wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a few performance scalability issues
> with read_sock. 

Meaning, this series achieves.. what right now?
I mean - the headline is "performance scalability" and there's no
performance testing result in any of the messages :S
Patch 5 for instance "seems logical" but how much difference does
it make?

> However, batch async decryption and its
> submit/deliver scaffolding were dropped from this series because
> async_capable is always false for TLS 1.3, the TLS version that
> NFS and NVMe/TCP both require. Async crypto support for TLS 1.3
> is a prerequisite for revisiting that work.
> 
> This series is now only a set of clean-ups. Support for async
> has been deferred until after TLS KeyUpdate has been merged.

What does "after TLS KeyUpdate has been merged" mean?
KeyUpdate is supported.. You mean in NFS? Or in async?
FTR async support is a major pain and we'd rather get rid of it
(and switch away from cryto API) than extend it.
