Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EF35C1BD;
	Tue, 22 Sep 2026 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038737; cv=none; b=eDxkxazI6SWnvmHxZGknLcZOv4iLEo9wL9WYKyT4lpbM2o28IpP+a/Z1VWSu3Yc8TNh2eE7s3c4nIssxQZ3Qz943wUnnfJd5Oz+pVSHNIw6dxSGC6bkLvutfQFujaz+5gLRef9j/piQdCTbOheHqthaQCCXdXvwL4yt5qnC3QSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038737; c=relaxed/simple;
	bh=wux2OFc60V2FiD4cR+ZN46H7qW46pddLP9ktlksRm3A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NZAbcQ5bV320jUidwOV+HQA6aNQtdEmqs6Y9vVh375EEIMWJ8CXlwdLZPHKCxe/P1aOBwOwY30/Trtzb/sAHQUfKyiuIPKjMgFn1arrkFTIi6HbxPtUHHyC8FX+1mX5o0bYD8R4/sSpY+EWDkRBSD0zhFrZuX6Uv54SitKar7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nICoV47u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nICoV47u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E3A1F0089A;
	Tue, 22 Sep 2026 00:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038735;
	bh=2jLYM6iZhA566FxJ8jqw7ws5R6FieD4flOKfAjp/alk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nICoV47u4wRWtxsMrgNlLvvYq7514OM4ZSjtAFvzaxXxG54rD6/uTtuH0L/dTePew
	 o+8/w4QsxC8V95DJdutGrLwKxQDz2kRW7nj9nmhwBjq8lWqlZjmrvyN2//FTC5nquI
	 BERkq0IC7kQiKrCHg2/uqL68GzCypP0ZbnC3/CtKM3c0/f71kUHlQ4AY1yS55x6Udi
	 3dQk118haP1cj7cjYT2pSJa5xl3inHNTFBaBS8ILUEyfTCV+DpIyOrQoyPBZmqaZkR
	 WS3iVMo+EBPtw058cypAzQd8DyoEljy3MbWR6UgcRyRdi26WP+mpfxxMCtleUej+wY
	 N+18f7h0V4Q1Q==
Subject: Re: [PATCH net 8/8] net: bcmgenet: mask DMA_TIMEOUT_MASK when reading
 DMA_RING0_TIMEOUT
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:54 +0000
Message-ID: <179003873467.2160803.416450150516822587@kernel.org>
In-Reply-To: <20260918000732.276506-9-florian.fainelli@broadcom.com>
References: <20260918000732.276506-9-florian.fainelli@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Submission metadata is not upstream-acceptable: the commit has no
  Signed-off-by line (mandatory DCO certification per…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patched
  conversion line makes it visible: bcmgenet_get_coalesce() can report…

--

net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

This patch makes bcmgenet_get_coalesce() mask the DMA_RING0_TIMEOUT
register read with DMA_TIMEOUT_MASK before converting the tick count
into microseconds, so bits outside the 16-bit timeout field no longer
affect the rx_coalesce_usecs value reported to userspace.

Two observations below, one on the commit trailers and one on the
get/set round trip through this conversion.

[Severity: Low]
Looking at the trailers in the commit message:

    Fixes: 4a29645bfe6c ("net: bcmgenet: Implement RX coalescing control knobs")
    Assisted-by: LLM
    Co-authored-by: Cursor <cursoragent@cursor.com>
    Change-Id: I4c5b5019e764dbd0c7e51bd8c7365939a4736e44

There is no Signed-off-by line, which
Documentation/process/submitting-patches.rst requires for the DCO
certification.

Should the Gerrit "Change-Id:" trailer and the
"Co-authored-by: Cursor <cursoragent@cursor.com>" trailer be dropped as
well, given a tool account cannot certify the DCO?

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 3a6a2f0759598..b15e64a484b43 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -852,7 +852,8 @@ static int bcmgenet_get_coalesce(struct net_device *dev,
>  	ec->rx_max_coalesced_frames =
>  		bcmgenet_rdma_ring_readl(priv, 0, DMA_MBUF_DONE_THRESH);
>  	ec->rx_coalesce_usecs =
> -		bcmgenet_rdma_readl(priv, DMA_RING0_TIMEOUT) * 8192 / 1000;
> +		(bcmgenet_rdma_readl(priv, DMA_RING0_TIMEOUT) &
> +		 DMA_TIMEOUT_MASK) * 8192 / 1000;

[Severity: Medium]
This isn't a bug introduced by this patch, but since the conversion on
this line is being touched: can the value reported here be rejected by
bcmgenet_set_coalesce()?

bcmgenet_set_coalesce() accepts up to (DMA_TIMEOUT_MASK * 8) + 1, i.e.
524281 us:

	if (ec->tx_max_coalesced_frames > DMA_INTR_THRESHOLD_MASK ||
	    ec->tx_max_coalesced_frames == 0 ||
	    ec->rx_max_coalesced_frames > DMA_INTR_THRESHOLD_MASK ||
	    ec->rx_coalesce_usecs > (DMA_TIMEOUT_MASK * 8) + 1)
		return -EINVAL;

bcmgenet_set_rx_coalesce() then rounds that up:

	reg |= DIV_ROUND_UP(usecs * 1000, 8192);

8192 * 63999 = 524279808, which is below 524281000, so 524281 us is
programmed as 64000 ticks.

Reading it back through the patched conversion gives
64000 * 8192 / 1000 = 524288, which is larger than the 524281 the
setter accepts.

Since the ethtool utility does ETHTOOL_GCOALESCE, modifies one field and
then issues ETHTOOL_SCOALESCE with the full structure, after
"ethtool -C eth0 rx-usecs 524281" a later "ethtool -C eth0 rx-frames N"
would return -EINVAL until rx-usecs is lowered.

Would it make sense to derive the range check in
bcmgenet_set_coalesce() from the same tick conversion and rounding used
by bcmgenet_set_rx_coalesce() and this getter, so the round trip is
consistent?

>  
>  	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
>  		ring = &priv->rx_rings[i];

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com
