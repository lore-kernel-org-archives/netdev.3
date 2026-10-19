Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26E36495F;
	Mon, 19 Oct 2026 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383335; cv=none; b=g7q4R1Ax2MJdkc0mbPE/6hqqOX+Fe078SmvfnFjgJ6HVFBeMA3Y8KLWqzZZeNgEOe8nNFUb5OOm6nQIKNDMkfqVJq/M9+489Do3f0N884eHU3lC/IsfJlPogP/U4EXqAGiI/H0qYGk1n+MtTkcj/KwrJFLkQ1ki//5R7xgrGTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383335; c=relaxed/simple;
	bh=lbQApwyFsK1AN/jDGCjX+azc0pqRBIVecj48Wl+oCJk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYVSSHmBOgndVq32T57j6VBBg2dVZdfb2kQoH89um2MRP/B5puaXlD1iIo5WK9c9NpC7Twmg1lKE0PW9VZGk9SgQFUCww54GyesD+v3k/oM7qr/BwrpBC/IaPcrK65DfXfTgDTccSM4xCej4yJn2jzOHNy3fnOumqXQBdneaEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg+P1ugP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg+P1ugP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075EE1F000C4;
	Mon, 19 Oct 2026 04:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792383333;
	bh=eEDFB4c3y2TMX52j0LxtXZBSRR4PLSmQsxKLZd62VBI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lg+P1ugPy3ykckHtO6I2Hbve64h2/VkZY22JjujCJ2cboiAaBmCg1+3pQigcNHloh
	 9I1rGEJbq/XnLquDJXLR/1DAlZwSS2VJCoNNONP57pEG5UWX7SeyRJG0UyTxolnMnv
	 ugMbxups6MCkghF9+NjxvZ6VQsJlsLGciD5NfI+ZLxPkSPtIDmJcn9eLOvE10j0uLV
	 gx3dsdRguc8a31xD8CDOe9EuZ9Xbdr8E5WzXVl1ZHm2c3Wan1O0/Lj07+llRxhL3j8
	 fD+uO32AGn42iUD5lPSc3uEJjJ3eAFarXAYFgyQJ+1sUKJlLVhfYh+VNrvjy1yQMDC
	 bQRY41v+PJcAw==
Subject: Re: [PATCH net v1] tipc: fix use-after-free of broadcast reception
 link at node release
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 04:15:32 +0000
Message-ID: <179238333253.3135.7191451921379768629@kernel.org>
In-Reply-To: <20261015041435.33561-1-18983559317@163.com>
References: <20261015041435.33561-1-18983559317@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message contradicts itself about runtime evidence.
- [Low] The commit message says the issue was found with a Coccinelle
  rule and 'LLM-assisted (GLM-5.3) code inspection', but the trailer…

--

tipc: fix use-after-free of broadcast reception link at node release

This patch moves the kfree() of n->bc_entry.link out of
tipc_node_kref_release() and into the tipc_node_free() RCU callback. As a
result, the broadcast reception link is freed together with the enclosing
tipc_node, after a grace period. Netlink walkers holding rcu_read_lock()
can then no longer reach freed link memory.

> Reproduced in a QEMU/KVM guest running v7.3.0 with KASAN and
> PREEMPT(full): 10 TIPC peer namespaces on veth bearers, bearer removal
> staggered so the 300 s node cleanup timers expire while other tasks
> loop link dumps with the broadcast filter and reset-link-stats lookups.
> KASAN hit within two cleanup cycles:
>
>   BUG: KASAN: slab-use-after-free in strlen+0x85/0xa0

[ ... ]

> with the freed object being the kmalloc-1k tipc_link allocated by
> tipc_link_bc_create() during peer discovery.  The same defect fires in
> strcmp() called from tipc_nl_node_reset_link_stats().

[ ... ]

> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
> not observed at runtime; it is identified by code inspection only.

[Severity: Medium]
These two paragraphs seem to contradict each other. Which one is accurate?

The earlier paragraph describes a QEMU/KVM reproduction. It includes a
KASAN slab-use-after-free splat from:

  tipc_nl_node_dump_link()
    __tipc_nl_add_node_links()
      tipc_nl_add_bc_link()
        strlen()

with the object freed from tipc_node_timeout() in timer softirq context. It
also says the same defect fires in strcmp() called from
tipc_nl_node_reset_link_stats().

The closing paragraph says the issue was not observed at runtime and was
found by code inspection only.

If the reproduction and the KASAN log were really captured, could the "not
observed at runtime" sentence be dropped? If the issue was found by
inspection only, could the reproduction paragraph and the splat be removed?

> Fixes: d25a01257e42 ("tipc: fix crash during node removal")
> Signed-off-by: Binbin Deng <18983559317@163.com>

[Severity: Low]
This isn't a bug, but the message says a Coccinelle rule and GLM-5.3 were
used, and there is no Assisted-by: trailer.

Documentation/process/coding-assistants.rst asks for one in this format:

  Assisted-by: LLM [TOOL1] [TOOL2]

The "Using Assisted-by:" section of
Documentation/process/submitting-patches.rst says:

  If you used any sort of advanced coding tool in the creation of your
  patch, you need to acknowledge that use by adding an Assisted-by tag.
  Failure to do so may impede the acceptance of your work.

Could a trailer such as "Assisted-by: GLM-5.3 coccinelle" be added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015041435.33561-1-18983559317%40163.com
