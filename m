Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909A3CF69F
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577959; cv=none; b=SRlU1KWq+Ig7iy/pB6hlhH+DNann8DrG1WIi64Img53JQE3XlM7LGfcn5yQoYUNKdhnLXk3NR8saBNI8CS0lTkPbzNHuR+lEoFnRWkYxM8fUr9CqRmOXSPCMSb2rYth4APwjtRn7ygCJk55CKSW8WAzdmDlvHQWCRZfU4jut4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577959; c=relaxed/simple;
	bh=WftREMo1u84xLMr+6YLVGdH39LN0KbhOC3B/w0TvlxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqWJzG+c+Q+U4Yg3pRuNOmYv4rKVPwFl6R9mElfcqy3F2Su8yLdfql0j4lw935fYsSb0UI1dTzRVtZ2Wh+iC4WqLMp6XVzGXdsBM4D/+IWKdjWGkrNdGhK820elQdA59tRB8X1IPJMMb1j4fm6Gy1P8NbCcEmgRgA2oma+jWIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY4xCBGb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY4xCBGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC9C19424;
	Tue,  7 Apr 2026 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775577958;
	bh=WftREMo1u84xLMr+6YLVGdH39LN0KbhOC3B/w0TvlxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GY4xCBGbTrz3MQyQjJvGIovIL3b8DFki2JMe0YyX/aJyHaXLmp0wD0EdRJHobRv17
	 MmEszpcm8yOnzRPMq14WJ+Isl/3PuBJ82jp0VogQrutYGHKzW9xSFoGyyyTIKxnMCe
	 l9MrQ84JCICzknpnhQq2B8FkEeoulfgjrQcoLVLIYarYsPgTqHQAArLmkj7NLcOrHO
	 KhOak4aZVZXlQE/P+TFnjCLSmwqQq8F7Zalr0fLLQazio2UT7ORF7MQaGi2Lt2yS2d
	 ICGV/WXhbYGTD/zWV4GbzDXrvE1xFV6l54h5re1wahmRkJLsKTkuFzpOd/Tod7J8X2
	 zog+Yf7aerwEg==
From: Simon Horman <horms@kernel.org>
To: emil.s.tantilov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	jacob.e.keller@intel.com,
	konstantin.ilichev@intel.com
Subject: Re: [PATCH iwl-net] idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()
Date: Tue,  7 Apr 2026 17:02:43 +0100
Message-ID: <20260407160241.470945-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403153538.11516-1-emil.s.tantilov@intel.com>
References: <20260403153538.11516-1-emil.s.tantilov@intel.com>
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

Simon says: I don't agree with the regression characterisation made by
the AI review - I think this patch is good. But I do think the issues
flagged by the AI review warrant investigation.

---
idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()

This commit moves the initialization of read_dev_clk_lock earlier in
idpf_ptp_init() to ensure it is initialized before the PTP auxiliary
worker is scheduled.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> index eec91c4f0a75a..4a51d2727547d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -952,6 +952,8 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
>  		goto free_ptp;
>  	}
>  
> +	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
> +
>  	err = idpf_ptp_create_clock(adapter);

This patch moves the lock initialization to prevent the worker from accessing
an uninitialized lock. However, idpf_ptp_create_clock() registers the PTP
device, and shortly after, ptp_schedule_worker() is called. Both happen
before the hardware clock baseline and initial time are set later in
idpf_ptp_init().

Could this introduce a regression where userspace opens the PTP device and
interacts with an uninitialized clock, or has its settings overwritten by
the driver's delayed idpf_ptp_settime64() call?

Additionally, could the scheduled worker read the uninitialized zero-time
and overwrite the software cache after the main thread sets the real time?

Moving the device registration and worker scheduling to the very end of
idpf_ptp_init() might resolve these races and naturally fix the lock
initialization ordering.

Also, since this code manages worker synchronization, is there a regression
when updating cached_phc_time and cached_phc_jiffies?

In idpf_ptp_update_cached_phctime(), these variables are updated
sequentially using the WRITE_ONCE() macro.

Because this function can be executed concurrently by the PTP worker
thread and ioctls, thread interleaving could result in an inconsistent
state where one variable is from one thread and the other from another.

Readers like idpf_ptp_extend_ts() load these variables using plain C
accesses without mutual exclusion or a seqlock.

Could this cause valid timestamps to be extended using an incorrect or
outdated baseline, silently corrupting network timestamps?

[ ... ]
