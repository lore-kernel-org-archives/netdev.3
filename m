Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0C343D8F;
	Mon, 24 Aug 2026 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578767; cv=none; b=eeTfgM6yy97R5vCb+p69sKQpC92PuJlXR1bEitMKibRlpwfNArXsjgagcyKH5tSjh0idjAeodUtfKIsXWRJ4uiROUiFt0Tx5gqxzn92ss4g3xRSYy5MHpIMKz6r2R07AGb9e3oAm/TNXtc0dNybSg3K4L4gy7s7m3ss826Rs8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578767; c=relaxed/simple;
	bh=yKqGWjGp3rHF6omkTB0bqqNoD0qLPY39GgvUNlHrS0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNkSoBs5SdimZtd63mBXHW2fPkmNsMb+PnHU/QovwenRvX4zG2MiJ3WGbFvMnslpXyEdrIAUnzF37tTxdcoTFmGt9szQufXYL/q1NIXJ9bqaOgnq4h4E8QGS9KT/SyIPJTRF+E4T+g065XTnKZBAopssMfslu4D19U9Zf1LCvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYK35Z7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYK35Z7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99421F000E9;
	Mon, 24 Aug 2026 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578764;
	bh=XJdIxHVPwuHe/RAOOk/4sfALm/vbkNUDkga0EDq9Tuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nYK35Z7lNGTh0d0nwDBjCBsI1Nkk6yolUK0J8ZarFWmWNDQzO4eBAxQxrFisQtuuC
	 0WNy7Mx6yWNHYmc+9WJo6sLYM6qihWAWEshMYrjExpYuFSBqJOs+o1honvQwCZ+AIF
	 jmF8xWNV1AjxsCiONmVffNcPE/SvMBBGRrzcnPWSQMJg+gcLUZ698A3Ujk22Y4Ggkn
	 y5lgr3ZrNDUyxzkWRfQ7WmbUuP+d+77F0kIbC09GV/w58G7bc56uj+haR49CULuWTr
	 ocKWUthYT/+K1hcLV0G4hbYrgZKUOOv8ywM8hDe4MYia1VGReBK7mIp10f6gWlDSD8
	 bZ7nDMLrrIM8g==
Date: Mon, 24 Aug 2026 14:39:20 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	saikrishnag@marvell.com, sbhatta@marvell.com, sgoutham@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v2 net] octeontx2-af: fix cn20k mailbox lifetime on
 repeated rvu_mbox_init()
Message-ID: <20260824133920.GV265046@horms.kernel.org>
References: <20260821102337.2989169-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821102337.2989169-1-rkannoth@marvell.com>

On Fri, Aug 21, 2026 at 03:53:37PM +0530, Ratheesh Kannoth wrote:
> From: Sai Krishna <saikrishnag@marvell.com>
> 
> rvu_mbox_init() is called separately for AF-PF mailboxes during probe
> and for AF-VF mailboxes when SR-IOV is enabled.  Each call used to
> allocate a new ng_rvu object, leaking the first allocation when the
> pointer was overwritten on the second call.
> 
> Sharing one ng_rvu across both paths exposed several teardown bugs:
> the error path freed all cn20k mailbox DMA and kfree()d ng_rvu even
> when only the failing init type should be unwound, leaving live AF-PF
> mailbox memory in use after an AF-VF init failure.  mutex_init() was
> also re-run on the AF-VF path while AF-PF mailbox handlers could still
> hold rvu->mbox_lock.  Probe and SR-IOV failure paths did not release
> cn20k mailbox DMA either, since cleanup only happened in rvu_remove().
> 
> Allocate ng_rvu once with devm_kzalloc(), initialize mbox_lock in the
> same block, unwind only the mailbox memory for the failing init type,
> and free cn20k mailbox DMA from the probe and pci_enable_sriov()
> error paths.
> 
> Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v1 -> v2: Addressed sashiko comments
> 	https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260820053656.2614614-1-rkannoth%40marvell.com

Reviewed-by: Simon Horman <horms@kernel.org>

