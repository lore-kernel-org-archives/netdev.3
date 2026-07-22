Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CE2E1F06;
	Wed, 22 Jul 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737126; cv=none; b=vAYKrYdVN7kaOsnWnyJ8Ha6cfR2vxSpR+G6iLDtTN4mHsdmo2nqTLlu3kcDzGdRijAZTeXvhtxkLfNIbpIpSiWM7ShvXXTN2y+gBlqcxbUURztAG0C4n4HDgSjoyNyrNH5BrPgEoNS44scjmGA+/lKQWCYEnDmW+fDbhMixrCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737126; c=relaxed/simple;
	bh=ijwvJXV+xy9CKVTRIkKn7PD/GR4IgLBduYFz7l9BuYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaAV0PbELZCbpkRmOU6Olf8bH2q4PzKjfIz6EsW5bbcpnR328bmv7SQXJTmwM8yuTvUXHV+lroScryC/dYXjE5nyGYNPy9Ws5LjAyGAdesAVcIoaANU8Wp4Folbag2ghgUBHV7A67FWstiiATwIAOQA+dBEbSARyfn649vGy2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIwYPKqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIwYPKqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD0F1F000E9;
	Wed, 22 Jul 2026 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784737124;
	bh=GGp7JkSm2uepD+Jz34R1YK4ZxPDXmhI1h6ZeT7G2HaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DIwYPKqgL8dQCZiHI2h3naLctasug779p1OZmRxZPGSv4o6Mk67/mF7Y4dmfhtgSy
	 nzOay37HxCZ7b9cUrORjDSJaA5PoWIVz0NKBNJrh8t/extG0U24RU3sLxUFeoGQcYE
	 2VeY3UdSzwEsMIk6diNtLoqLzt50vfhS/qMYQQALqDSP8mac0agBEvCKxyHYprAe+Z
	 oNZb9gAwGEn8yFlig50dC/3nqqd7zgBeEixRHY5RSsQxncRxudLziS8l2hraGLULXn
	 3QoekSFhqK07RPEEEmHkYqSgmS8ojtr6mjWWa/fZ6+I6mJnMwF7COmLmJXDkR1wSr0
	 /xbrhC04bu5gQ==
From: Simon Horman <horms@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Bharath.r@intel.com
Subject: Re: [PATCH net-next v5 14/15] ixd: add the core initialization
Date: Wed, 22 Jul 2026 17:18:36 +0100
Message-ID: <20260722161836.544694-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715180042.1972010-15-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-15-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260715180042.1972010-2-anthony.l.nguyen@intel.com?part=14
---
--- Patch [14]: [PATCH net-next v5 14/15] ixd: add the core initialization ---
commit 43763d63c75ee5bcdd9189c20cf8b272997bdfec
Author: Larysa Zaremba <larysa.zaremba@intel.com>

ixd: add the core initialization

This patch initializes the core when the mailbox is set up. The driver
confirms the virtchnl version, requests necessary capabilities, and sets up
the message handling framework.

> diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
> index 0000000000000..6d658be0695d4
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c

[ ... ]

> @@ -0,0 +1,146 @@

[ ... ]

> +void ixd_ctlq_rx_task(struct work_struct *work)
> +{
> +	struct ixd_adapter *adapter;
> +
> +	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
> +
> +	queue_delayed_work(system_unbound_wq, &adapter->mbx_task,
> +			   msecs_to_jiffies(300));
> +
> +	ixd_ctlq_recv_mb_msg(adapter);
> +}

[Severity: High]
Does queueing the delayed work before executing the main logic create a race
condition? If cancel_delayed_work_sync() is called (for example, during
teardown in ixd_deinit_dflt_mbx()), try_to_grab_pending() could successfully
delete the newly queued timer and return immediately, assuming the work is
fully cancelled.

This would bypass flush_work() and allow the teardown path to free
adapter->xnm and set adapter->arq to NULL while ixd_ctlq_recv_mb_msg() is
still running, potentially causing a use-after-free or NULL pointer
dereference. Should the re-arming be moved to the end of the task?

> diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> index afc413d3650fb..ce870aba143d4 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c

[ ... ]

> @@ -136,8 +145,27 @@ void ixd_init_task(struct work_struct *work)

[ ... ]

> +	libie_ctlq_xn_shutdown(adapter->xnm);
> +	ixd_trigger_reset(adapter);
> +	ixd_deinit_dflt_mbx(adapter);

[Severity: High]
Is it safe to trigger a hardware reset before cancelling the mailbox polling
task? ixd_deinit_dflt_mbx() is responsible for cancelling the mbx_task, but
calling ixd_trigger_reset() first means the polling task could run while the
hardware is resetting.

During reset, MMIO reads or DMA ring memory might temporarily contain invalid
states, and the still-running mbx_task might process corrupted descriptors.
Should the polling task be cancelled before asserting the hardware reset here,
as well as in ixd_remove() in ixd_main.c?
