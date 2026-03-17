Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60715624B;
	Tue, 17 Mar 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776946; cv=none; b=BzapF/AGaie/9hC7YFttNB82GYXGsZ4oU3iWq0tGcnlhThiZOEODDylXVs6wdFXKLDtWl4bsp4ivdF5V8eDftNE6AjO8Mv4TkdIHR9rCBcM5GH+UYwWrwFnvGLNag7/d8X66v4PcOxLxFhWLj/JAbBZ9HdYfmxPSa0BsX73YNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776946; c=relaxed/simple;
	bh=dUFZNnAFSBqpUctBICuMF16TyHeUxHrAz9CI2OPlGiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9N2dxV9yED8SjjKyVM68jxpgB+TPvocU3SEBwKDCOV60s0mkif5FtcCFIoqykm+FWTBiqBRLPpr2mPs6h6DGE6r5d0Qn8LBGvqLHXxXdiYlnISChU2Q4fJdTRWHeYSnrHEzcuRTNND+XKRpjV+ixW/OAYDxNAaBJUAp8SxTWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm5JypKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm5JypKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98099C4CEF7;
	Tue, 17 Mar 2026 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776946;
	bh=dUFZNnAFSBqpUctBICuMF16TyHeUxHrAz9CI2OPlGiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pm5JypKgq648/phjq3TLt4/bTcVYjtoUsAvxHTJViO5h21gNDBnnhq5bwIZY6Yyc5
	 9ubUFXlWr0yTXcuvmlc+rDl0tyZ8ZhPayd70CVimNaZJum3m6166zcITaZJnxbwDvS
	 l+IpsFy8dsqMf/Gr3CPVk+yue7FCCbZKE+eYOluDNjR329uyseDO2tyGcUQxjoGqKF
	 zTOtLsY4ywN0Z9mKML1r4+3PR5PrbxjysNmuLRV1E4Gc21Vwil2Y8yeqlMK07RAJxv
	 SOJul0oA2SAyXGl5b3gM+qsqnd8IwdGiN7OBDGMlWRw9+FaEJ5k0BsCo67XUSIw+zD
	 EqWb5dV003vbQ==
Date: Tue, 17 Mar 2026 12:49:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10 net-next v3] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260317124904.552d57e4@kernel.org>
In-Reply-To: <20260317140141.5723-1-fmancera@suse.de>
References: <20260317140141.5723-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 15:00:56 +0100 Fernando Fernandez Mancera wrote:
> Historically, the Linux kernel has supported compiling the IPv6 stack as
> a loadable module. While this made sense in the early days of IPv6
> adoption, modern deployments and distributions overwhelmingly either
> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
> entirely (CONFIG_IPV6=n). The modular IPv6 use-case offers image size
> and memory savings for specific setups, this benefit is outweighed by
> the architectural burden it imposes on the subsystems on implementation
> and maintenance.

Hi Fernando,

NIPA flags a few failures, still:

https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-17--18-00&pw-n=0&pass=0

See stderr for stack trace. The BPF build issue seems to be:

  ../net/bpf/test_run.c:1160:8: error: use of undeclared identifier 'ipv6_bpf_stub'
   1160 |                 if (!ipv6_bpf_stub) {
        |                      ^~~~~~~~~~~~~
  1 error generated.
  make[5]: *** [../scripts/Makefile.build:289: net/bpf/test_run.o] Error 1
  make[4]: *** [../scripts/Makefile.build:546: net/bpf] Error 2
  make[4]: *** Waiting for unfinished jobs....
-- 
pw-bot: cr
