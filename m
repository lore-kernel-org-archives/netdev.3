Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE037267A;
	Sun, 10 May 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432693; cv=none; b=JxTTOTqdtmpZe9EIuH5PBds5gpxeGF67eSYuEUf3F2vztdGgH33w2NbvBGm4Wd5ajY1fDWUJkXW8cNHqm8JBtpPeaLQSr3uU9yyu+6csU0ReQoAYiBw1fd08vk25evJsSrlebqwkQWpwX7FJRBuQ238XAFyQdGqTtF+1AJvdQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432693; c=relaxed/simple;
	bh=riMwbHoWWj8CG0TJy7OFYnqVVbxxWG4jYNmtSt1FjPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COadAbukXM+jzeMx7S1EJ2e+CwShaEmg1NOLCjQKs2mgtutQP48I7somYZascRqPrqwiOPdnvjjSAWHNQu75YRJYc0SrUGi0CryIrHSs3eEZHrwkIEC/RyR+iYO9SRoBK9/uAGFv9GexAeJn4n1EKWnsmnByg8BFMNRzmbbL4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8sjY6Lm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8sjY6Lm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF970C2BCB8;
	Sun, 10 May 2026 17:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778432693;
	bh=riMwbHoWWj8CG0TJy7OFYnqVVbxxWG4jYNmtSt1FjPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8sjY6LmSWyTkWs17bQt+F6EeeeKfC0n252XvhgoKs5v4uGXVQgyU8LaMEL4l7QGR
	 i45mOWneaOWjxIlKlTXRJcA5WQCMIBVa3TqBf9sXTAYPqjrGXUkySxOvF7zVZkrlp/
	 uE3r7jFrOaUdL/x38BsT3Bq9OY0Fv+RdsAve0nmEYVvCVM40UVtgfpM3L4QY1K+Svs
	 s7Bv0z5aNmXw8ClSRlzU/Vr2i90EN9rix5mufKh1tUNraz8G44rq6jLL8Q4gvIYFXO
	 cOE2JrIzlw1Le3sJF8IbGb/QcmER27ke3JuxKatWSnTYktj+rkGUWq6SIzftVHnLIb
	 eAaq2IK572yaw==
From: Jakub Kicinski <kuba@kernel.org>
To: nihaal@cse.iitm.ac.in
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.chetan.kumar@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: iosm: fix potential memory leaks in ipc_imem_init()
Date: Sun, 10 May 2026 10:04:51 -0700
Message-ID: <20260510170451.3886726-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508092141.82495-1-nihaal@cse.iitm.ac.in>
References: <20260508092141.82495-1-nihaal@cse.iitm.ac.in>
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
net: wwan: iosm: fix potential memory leaks in ipc_imem_init()

The memory allocated in ipc_protocol_init() is not freed on the error
paths that follow in ipc_imem_init(). Fix that by calling the
corresponding release function ipc_protocol_deinit() in the error path.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> index 1b7bc7d63a2e8..f4edb277efd92 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> @@ -1422,6 +1422,7 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
>  	hrtimer_cancel(&ipc_imem->fast_update_timer);
>  	hrtimer_cancel(&ipc_imem->tdupdate_timer);
>  	hrtimer_cancel(&ipc_imem->startup_timer);
> +	ipc_protocol_deinit(ipc_imem->ipc_protocol);
>  protocol_init_fail:
>  	cancel_work_sync(&ipc_imem->run_state_worker);
>  	ipc_task_deinit(ipc_imem->ipc_task);

Could this introduce a use-after-free by destroying the protocol before
canceling the work and tasklet?

If an error occurs after the timers are started (for example, if devlink
registration fails), the hrtimer cancellation stops new timer events.
However, if the startup timer has already fired, it might have queued a
task into the ipc_task queue.

Calling ipc_protocol_deinit() here frees the ipc_protocol structure.
Since ipc_task_deinit() has not yet been called to flush the queue and
kill the tasklet, any pending tasklet may still execute.

If a queued task such as ipc_imem_tq_startup_timer_cb() runs, does it
access the freed ipc_protocol?

ipc_imem_tq_startup_timer_cb()
  ipc_imem_phase_update()
    ipc_imem_get_exec_stage_buffered()
      ipc_protocol_get_ap_exec_stage(ipc_imem->ipc_protocol)

Would it be safer to place the ipc_protocol_deinit() call after the
tasklet and worker are fully destroyed?
-- 
pw-bot: cr
