Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E94A2058;
	Fri, 18 Sep 2026 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716400; cv=none; b=owXPD82O2gt+GH2U4D+6jGW7Ee1eivy8dYj0X150SlzeXYbApEvGez/6TQRz1MxAsJqImSholCzCSlD23r1RR0tcJQGRY9HC9i5CSP/JM9ggoslLcwRhmyo/5rUxmeuQ0Ww4ld8W7GnqtUXpcjtuT4Py7MRCkgG2Xp5tt8B5WWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716400; c=relaxed/simple;
	bh=OD1nObYz+iriRRKXFZRddUeaUP/ZubhdHL/JyB21Dho=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o35Sm6FGY4THjJIZr8pOihKt8ocDBEMdomNJ2QhEJEvrV8YOzklxIck+67YUIQmPjEr/aQkVTpkrkZd1wGLSescQe28heBYMo/j9P2AelzzD0154VyKZXEOh5oKxLAt3xDUqp7C6sKr40JelAvsWzV98Xf2t5Qq7vFZFUOFzDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrXCx9Ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrXCx9Ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D001F000FF;
	Fri, 18 Sep 2026 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789716384;
	bh=4KmxL9Fv8n4Ai+0tgTlGXTOeasejKM7nyWEMNXHnBxM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WrXCx9CtpXzR4PVy8A6+xo5tQ1u5otmAALQFTQ5UFWFQNV1GbkUmIcEBK8xoFyE5/
	 Pr9UAAyiwmMgFGnQ+lq64scR8hpua4vktBCT64OxNu37q4vlEcPfssGM3Qu43G1rCc
	 uFxJ60SiQzNPOQ1dG58Y9gy0NfgrNjvCrhXaHFdJU3g4Is/b1vMRCB2TZvUEfcsRPl
	 rzIL/Y5p73gwbCswMY9vZlzWdKG6+9TivlFfUY4CLmBnt90lWV3wtB+OLvi4Pfn3vN
	 el9UMTa9MNi2dQVoRcnJdsE7ow7hY5s8ZI/beUgJMgjyHQ4qxBp7e8u2W48PvOQGEg
	 K3XAGGCwhuNmw==
Subject: Re: [PATCH net] octeontx2-af: nix: Export CN10K admin queue enqueue
 mbox handler
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com
Date: Fri, 18 Sep 2026 07:26:23 +0000
Message-ID: <178971638355.22033.14086854049232485813@kernel.org>
In-Reply-To: <20260915072357.980485-1-rkannoth@marvell.com>
References: <20260915072357.980485-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] New EXPORT_SYMBOL() with no in-tree consumer:
  `EXPORT_SYMBOL(rvu_mbox_handler_nix_cn10k_aq_enq)` is added in…

--

octeontx2-af: nix: Export CN10K admin queue enqueue mbox handler

This adds EXPORT_SYMBOL() for rvu_mbox_handler_nix_cn10k_aq_enq() in the
octeontx2 AF driver, with the stated motivation that out-of-tree CN10K
modules fail to load with an unresolved symbol.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad067..95776ab924e57 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -1501,6 +1501,7 @@ int rvu_mbox_handler_nix_cn10k_aq_enq(struct rvu *rvu,
>  	return rvu_nix_aq_enq_inst(rvu, (struct nix_aq_enq_req *)req,
>  				  (struct nix_aq_enq_rsp *)rsp);
>  }
> +EXPORT_SYMBOL(rvu_mbox_handler_nix_cn10k_aq_enq);

[Severity: High]
Is there an in-tree user for this new export?

Grepping under drivers/net/ethernet/marvell/octeontx2/ shows
rvu_mbox_handler_nix_cn10k_aq_enq is referenced only by its own definition
in rvu_nix.c and by the mailbox dispatch that the MBOX_MESSAGES M() list in
af/mbox.h expands inside rvu_process_mbox_msg() in af/rvu.c.

That dispatch lives in the same module as the handler, per af/Makefile:

    rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
		  ...

So how can the commit message's "causing unresolved symbol failures at
module load time" be reproduced with an in-tree configuration?  With
rvu_nix.o and the dispatch both linked into rvu_af, there does not appear to
be any mainline module that has to resolve this symbol at load time.

The commit message says the caller is out-of-tree:

    "rvu_mbox_handler_nix_cn10k_aq_enq() is used by out-of-tree CN10K
     modules but was not exported"

Would it make more sense to drop this hunk, or to post it together with the
in-tree driver that consumes it?  As it stands the export widens the AF
module ABI to include direct NIX admin-queue context programming, struct rvu
internals and the mailbox request layout struct nix_cn10k_aq_enq_req, with
nothing in the tree using it.

A related question on consistency: the sibling handler
rvu_mbox_handler_nix_cn20k_aq_enq() in af/cn20k/nix.c is not exported, while
rvu_mbox_handler_npa_cn20k_aq_enq() in af/cn20k/npa.c is.  Is the CN20K NIX
handler needed by the same out-of-tree modules, or is the intent to export
only this one?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915072357.980485-1-rkannoth%40marvell.com
