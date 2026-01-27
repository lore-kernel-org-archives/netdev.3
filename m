Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F3204583;
	Tue, 27 Jan 2026 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484201; cv=none; b=Wo+VmxxsqG4ogHITpxjSc/WIjTbtRgmrbiOJbx6xr7OzmUYQX8Upane10RbPFB6lcL175OcBciJwji7l+oxbDvyPy5c+9RW1Ls8AXJd+BvGjOK/aUfSPDFgnBgoCrIxLneAenECURked3oO5xo4oktCbmsWUoeT47GgSWNJYYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484201; c=relaxed/simple;
	bh=QPXb8BANJCJaSlSYznlnm2/uV4g8XIeG+K7X637VVDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtpUrebsZm6sq20CBn0xrDWXoHT02uHdFczzkAGtqdVx+p9omE3NOEtAU+h6o4alA75tV4Lkc3DE4O48qsGRPX8/OfzCoTWRDQ9bKNACXclmoXdAOZEzhJZeKNQx6SOxsvLjdk/xl9AVJQIV0C7mnz6IPp7+aVPiLwKE1N1hsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDIYIjwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDIYIjwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546ABC116C6;
	Tue, 27 Jan 2026 03:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769484201;
	bh=QPXb8BANJCJaSlSYznlnm2/uV4g8XIeG+K7X637VVDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDIYIjwdQlVbSLKsmiPgaot8SlSPHnn+0Zv2w4HyQZrOkWHm7Ghyf2N20MaX+ZjMX
	 pOSie3Lf405rTBca7Yf/QYnlOQQzissVqUDO4a2trFIK270IjLQ/yojCYigSi4K3ax
	 sgK6juNrFE1A1ub/yUmXGfL5WDT2o8OQkjKcLtWfwomLz8qYsVswu4yCtV9g+ZIlvQ
	 DPxsheJxONy092OT6ckkBTcTkDbwXLunygVOB/HYY1/HUNuaFay8P4B34ZyuuKItTT
	 pWO2oMPTmZLReeyd99qQkZYbNDiCBBaz6QGiQ4WnR5g8COlvAWizJqdQ0NuLjanda3
	 g9vmDWaTij7hw==
From: Jakub Kicinski <kuba@kernel.org>
To: bhargava.marreddy@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	edumazet@google.com,
	ajit.khaparde@broadcom.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	vikas.gupta@broadcom.com
Subject: Re: [v6,net-next,8/8] bng_en: Add support for TPA events
Date: Mon, 26 Jan 2026 19:22:56 -0800
Message-ID: <20260127032255.3847218-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123193504.285573-9-bhargava.marreddy@broadcom.com>
References: <20260123193504.285573-9-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: Add support for TPA events

This commit enables TPA (Transport Protocol Aggregation) functionality
in the VNIC and adds functions to handle TPA events for LRO/GRO
processing.

> +static void bnge_tpa_agg(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
> +			 struct rx_agg_cmp *rx_agg)
> +{
> +	u16 agg_id = TPA_AGG_AGG_ID(rx_agg);
> +	struct bnge_tpa_info *tpa_info;
> +
> +	agg_id = bnge_lookup_agg_idx(rxr, agg_id);
> +	tpa_info = &rxr->rx_tpa[agg_id];
> +
> +	tpa_info->agg_arr[tpa_info->agg_count++] = *rx_agg;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^

The agg_arr is allocated with MAX_SKB_FRAGS entries, but there is no
bounds check before writing to it. The bnxt driver has a BUG_ON guard
at this location:

    BUG_ON(tpa_info->agg_count >= MAX_SKB_FRAGS);

Is there a reason this check was omitted? While the check in
bnge_tpa_end() catches agg_bufs > MAX_SKB_FRAGS, that happens after
the aggregation completions have already been stored. If hardware
misbehaves and sends more aggregation completions than expected, could
this overflow agg_arr[]?

> +}
-- 
pw-bot: cr
