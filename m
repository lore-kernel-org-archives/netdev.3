Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A23D905D;
	Wed,  3 Jun 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504757; cv=none; b=qVPiGqrK7lPQXeviB4Cg9NMg+3BrdaxA5V+6elQni9ky3+2RcAsojXj0GEiQ83VLkyJ/Q2Jqlt0MrmXGvnlHSEfU6fiKZwSLJnLcy9qWDOpUzhRsZ6Ig5RgyHIcfuwnZvB1FaR2kqd51H93gWYf9JBurCpC7odjIuU6qkDsDwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504757; c=relaxed/simple;
	bh=TBdHUJfaDsXjPANripR8uhubEK8ynnTic1RPNl8RuC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6uQVw+DHuYX8tEWWa5qvfB3Y6uYXhrqmU8Qqlzvsw9V2ozgypUQlt4JChZNbr1XyL44O/aT1mYqvDiZ4TJrHAhMRerTDrJWyyduKGGx6GJF0DfkghusUL6Iz8upvIE7u9J4Qr2uBj3fYTv6B6f7BFp266Q5LG2ONPF48gRtkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oecTNtMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oecTNtMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C881F00893;
	Wed,  3 Jun 2026 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504756;
	bh=JXsNajzj+tGfCazHjDc7U52TA+I2/p4u2Jj+oxzqZsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oecTNtMcOt5gReOX6xHOFEh59CHpnSeboFPnx7sAlfnY0LKPELc5BG5ILKfyNEXhh
	 rTnBsujiiDke8L/zy3bes4IKrgeXq8PiDsi3nyqOLG08DkBiJCK1Quy0T3Q61xikpq
	 OINBZqbL5zCW+SBL/xpfBX2mPBSHbBcZRJoX4yvp+VS17VaXSoEYJnv9BEsYpjDgMb
	 UbD5b/TLw4czph4xOIO4mFlxfiu4aJtSHT2GYwgeFMD+FGAsEQcykY+0EI9xBsIybJ
	 tJEm4javYhFOlVOLy5eJZpG7FAJUsdGcGyKstcZVaJrCC7g3PCCVsPQbWeFpL/Ws83
	 Ge4GgnxHNnW4w==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: mcs: Fix unsupported secy stats read
Date: Wed,  3 Jun 2026 17:38:46 +0100
Message-ID: <20260603163846.3824713-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1780054661-17194-1-git-send-email-sbhatta@marvell.com>
References: <1780054661-17194-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
octeontx2-af: mcs: Fix unsupported secy stats read

This commit updates mcs_get_rx_secy_stats() to skip reading the Secy
control stats counter on CNF10KB platforms, since the register does
not exist.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index c1775bd01c2b4..a07e0b3d8d000 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> @@ -120,13 +120,13 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
>  	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
>  	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
>  
> -	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
> -	stats->pkt_ctl_cnt = mcs_reg_read(mcs, reg);
> -
>  	if (mcs->hw->mcs_blks > 1) {
>  		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(id);
>  		stats->pkt_notag_cnt = mcs_reg_read(mcs, reg);
> +		return;

[Severity: Medium]
Will this early return cause an uninitialized memory leak in debugfs?

In rvu_debugfs.c, rvu_dbg_mcs_rx_secy_stats_display() allocates the stats
structure on the stack without zero-initializing it, and passes it to
mcs_get_rx_secy_stats() to be populated.

Since the early return now skips setting stats->pkt_ctl_cnt, and the caller
unconditionally prints it via seq_printf(), could this result in leaking
uninitialized stack memory to userspace when the debugfs file is read?

>  	}
> +	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
> +	stats->pkt_ctl_cnt = mcs_reg_read(mcs, reg);
>  }
