Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68985351C2B
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774104117; cv=none; b=FovPMQXr/pk65Vjndl6I4KZCSW9CeM3AMqbpWNJPNBOgx4E/SqXMA6TCdjB7+ydor2gdG6uGXDAg2unR62oXezrf6smEjpdAHdgMXSxEEf9xfmpAQ91K1yubg18aRh9wuuEbyZbhGtQk1zVow+V5RWkdGFYSWlfSfETP2RGDfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774104117; c=relaxed/simple;
	bh=JJky1CSZ+ztNJyU7tYfXcDziJG+GFQxaKY2dUOW433U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcAqPiPCfp4fyD9M3nUxthJSnRvHDsedUZp0AcxErA0ATDLYtNl6jSV9HYpcSQ3IUF6oa4/t1IVR8V23+DgUxR/c82hiBfDi9agwwEHpV1h5EJeDKC0Sy6nfLz8t8uIvv+R6+cmlvklLqQMipAZf8b6vJAuRLigldhHW7q/NKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxhVbgIG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxhVbgIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DFCC19421;
	Sat, 21 Mar 2026 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774104117;
	bh=JJky1CSZ+ztNJyU7tYfXcDziJG+GFQxaKY2dUOW433U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KxhVbgIG25bJnRESbPRdiMVuDXWpPXon46mWGccNRzmDZHYHiGAtC9kCA2af2ZWz+
	 ZDGMMGVmf5Mpbzx3VDCdWNMQRRv6aj9VIOIHgPa+/EPjfFHcku6TXox2WvxGY2Fbx2
	 52/YPKhIks7vzOmy6ET1IJAj91jzNkjLuvp3S5H71eMkr5gwEPuugc+fAL4akvOOLF
	 lTb0kjb0Jf7Mwgo8gPJb2/xga427Bizmlv2h09+GYimtiiaNPv8s4fGhbqBhrkGnUQ
	 XOBvuo3LChFC0tLzPuxFZ7nL3FJli4z/PknlnP0dtUZXjXPrI8sgJ/f25wmAyffVGh
	 bun+qMtjnw1HA==
Date: Sat, 21 Mar 2026 07:41:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xw x <v3rdant.xiang@gmail.com>
Cc: Jiayuan Chen <mrpre@163.com>, jakub@cloudflare.com, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] tls: reject attaching TLS to sockets already in sockmap
Message-ID: <20260321074155.6fdb79dc@kernel.org>
In-Reply-To: <CAFFJMPyDpKwW9O127JkS1B3bgGGzWPpiw5MqFEbGB6Qpq0nsVQ@mail.gmail.com>
References: <20260321033027.4044119-1-v3rdant.xiang@gmail.com>
	<8509360a-21b8-4d28-8999-67a82796b8b6@163.com>
	<CAFFJMPyDpKwW9O127JkS1B3bgGGzWPpiw5MqFEbGB6Qpq0nsVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 17:47:07 +0800 xw x wrote:
> I apologize. I fixed it this way because during my exploitation, I
> discovered that sk_psock_init checks for the existence of ULP in sk,
> which led me to believe that disabling sk with TLS from being added to
> sockmap was expected behavior, and I thought this fix might have the
> least impact.
> 
> In fact, the other patch which I believe is a more fundamental
> solution, is similar to CVE-2025-37756. In
> `tls_strp_load_anchor_with_queue`,
> `skb_shinfo(strp->anchor)->frag_list = first` acquires a reference to
> an skb but doesn't own it. This causes a  dangling pointer when other
> kernel components not specifically adapted to TLS (tcp_disconnect in
> CVE-2025-37756 and bpt in that vuln) release TLS skbs.
> 
> I will try to add my test program to
> tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c so that you can
> test it and understand the root cause.

FWIW you can open a pull request against this repo, and it will run all
the sockmap+TLS tests for you: https://github.com/kernel-patches/bpf

reminder: please don't top post on the list
