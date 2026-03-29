Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED532E040E;
	Sun, 29 Mar 2026 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819202; cv=none; b=tP3+BT9io2cyanlQ6g3ztV8jQ1XVW3ABk4B0tot8njxM/QDxkLUkEt9BkoLx81OSSx5Qd07/GsBHxRMooFhslc5NCtngJdv311mPDlkO1ezXP2YwP230L4S2VNpbjA8dwmBj/lrt0IIAtgJSUkroXo4dGGZ0pRj+ugt9UJKSsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819202; c=relaxed/simple;
	bh=S1uFCIxkrPT2YoMOkN2aLPV/xIL2DGaeopxboUzveXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbvXC3SCnE3Ha9+ENhkm0swh+1sChtFv2PL+GTbJ/KGhhtcKHe54Oeseix0nuMekvw24F02+h9pPEIgpMYawa8D9r6mrxYeObTZVtPaz5N754oWzBdqaaPwS4SfKSAwq7Xzf22Z5fs6vFO62/SY7JT+WW/lpK5QX5CXMcSi/i2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmGN4SZv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmGN4SZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A0BC116C6;
	Sun, 29 Mar 2026 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774819201;
	bh=S1uFCIxkrPT2YoMOkN2aLPV/xIL2DGaeopxboUzveXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmGN4SZvL7nYDxPTq+OkwVWaFWiLNzSkTSR9GEl+o85wiUh1HZq2BPSzgj0C9R9QD
	 Y4a62lBlMA+q5UZz38mIA/u8J9UUIu5zmqXBwISml77RCWJZbsTrbSuMRysUB9sB/W
	 NrtQH5pnbgTUiRIESbMdr2qlSl8uW/m8b0bl39oI4TPqOsSQlo3dRxM0bnhsC7c/dU
	 mGcNqOgucnkQxtMfioTxGwellsNRojvb9bk6j/VfrcdvDgNxXp9OwvKnmBlp1NyLii
	 B7tgh7xshPv64vS3NQJX80ehfSf3DsQnJJYjS+ThTl3IWxueP6EdbKdPcjo14k6437
	 PlIZQWkRhpUoQ==
From: Jakub Kicinski <kuba@kernel.org>
To: hramamurthy@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	joshwash@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	willemb@google.com,
	nktgrg@google.com,
	jfraker@google.com,
	ziweixiao@google.com,
	maolson@google.com,
	thostet@google.com,
	jordanrhee@google.com,
	jefrogers@google.com,
	alok.a.tiwari@oracle.com,
	yyd@google.com,
	linux-kernel@vger.kernel.org,
	namangulati@google.com
Subject: Re: [PATCH net-next v2 2/3] gve: make nic clock reads thread safe
Date: Sun, 29 Mar 2026 14:19:58 -0700
Message-ID: <20260329211958.2875749-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326224527.1044097-3-hramamurthy@google.com>
References: <20260326224527.1044097-3-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
gve: make nic clock reads thread safe

This commit adds a mutex to protect the shared DMA buffer used for receiving
NIC timestamp reports. The lock is needed to synchronize the periodic worker
and the upcoming gettimex64 ioctl.

> diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
> index 06b1cf4a5efc..140b8fbce4f4 100644
> --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> +++ b/drivers/net/ethernet/google/gve/gve_ptp.c

[ ... ]

> @@ -109,6 +114,7 @@ static void gve_ptp_release(struct gve_priv *priv)
>  
>  int gve_init_clock(struct gve_priv *priv)
>  {
> +	u64 nic_raw;
>  	int err;
>  
>  	err = gve_ptp_init(priv);

[ ... ]

> @@ -125,17 +131,20 @@ int gve_init_clock(struct gve_priv *priv)
>  		err = -ENOMEM;
>  		goto release_ptp;
>  	}
> -	err = gve_clock_nic_ts_read(priv);
> +	mutex_init(&priv->nic_ts_read_lock);
> +	err = gve_clock_nic_ts_read(priv, &nic_raw);

Could this lead to a race condition with userspace?

If gve_ptp_init() registers the PTP clock via ptp_clock_register(), the
device is exposed to userspace immediately. If a userspace process opens the
device and calls the gettimex64 ioctl before the mutex and DMA buffer are
initialized here, it could cause a NULL pointer dereference or operate on an
uninitialized mutex.

>  	if (err) {
>  		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
>  		goto release_nic_ts_report;
>  	}
> +	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
>  	ptp_schedule_worker(priv->ptp->clock,
>  			    msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS));
>  
>  	return 0;
>  
>  release_nic_ts_report:
> +	mutex_destroy(&priv->nic_ts_read_lock);
>  	dma_free_coherent(&priv->pdev->dev,
>  			  sizeof(struct gve_nic_ts_report),
>  			  priv->nic_ts_report, priv->nic_ts_report_bus);

Is it safe to destroy the mutex and free the DMA buffer before calling
gve_ptp_release() here?

If the PTP clock is already registered and exposed to userspace by
gve_ptp_init(), this error path frees resources while the clock is still
active. A concurrent userspace ioctl could access the destroyed mutex or
freed buffer before gve_ptp_release() unregisters the clock.

Should all resource allocation and initialization strictly precede
ptp_clock_register(), and the error path unregister the clock before tearing
down the resources?
-- 
pw-bot: cr
