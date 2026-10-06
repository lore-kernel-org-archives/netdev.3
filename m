Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843972F745C;
	Tue,  6 Oct 2026 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791252797; cv=none; b=na1qIyOVtpxBG2oP9hH91mRLexEm0i5k5nSslFFrEyYPW718SPAHFbk7vDPXudFa5oW7i4SBbKWtPjFs9wiQ8OL+bI1BVYvg0kv0cdRX6K0F2nMqu1zVuM2KmgyFm5IbH7QQgOrFhhUkyCp1COhC1sBbZ7vRUYRMeM7o2sNuo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791252797; c=relaxed/simple;
	bh=eJuI+8KhdJGEDbMAsMa6CanGsXtW3ivc2yIW5xZF5qg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8c2bBB9vFHkBQwK5q3rGSz95Q5C+9sDCTJT8/U1xU58NE6lVHV4A2R+lOTOLGViCwKswuUWSZWNPo76IlQZgoUbzperddbSeMGGDqgH6Cl563W1tE8Sy12xMQlLlmcydfJvGRnyGsBm2qVnqzkBqdeGJWxChSuNj2j9NdC1EuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPcB76YJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPcB76YJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3B61F000FF;
	Tue,  6 Oct 2026 02:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791252796;
	bh=2ymqZIASFZdtfBeoDcXKSYILNlVoxXjp95BnDf8r6Jw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XPcB76YJO5o8LFo6SIl4K3miJsEw8E8SNwuy8S/oH+xlWKCaPPa4Iu9TIBcA4HgdD
	 dTxKqHrLlvBpPkZPBMCsVswwT9iPsIZU/TImByvop+KVriMhjyVKbxUpQi1x5qUNbP
	 wbgZGLQzdgrCB15XweHtCLoCQVZ+phXDt6MQGaNOwfkO4QY8AbowIuitjfZh6AMXT5
	 X/eebqVgB4evdERBUhMMYd4wkxPw6POJzwVbOSkkU513sHo6196KKWbREdrAy4Stoj
	 TmPuuF8BprnidnQXEYJklplKdj/cAP9D7DL7XnuO9YbztNF8Xr39V9y+261VZ4YytM
	 XSY2iQjJKwmxA==
Subject: Re: [PATCH net v6 1/4] net: wwan: t7xx: fix runtime PM usage count
 underflow on -EACCES
From: netdev-bot+sashiko@kernel.org
To: tim770802@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ilpo.jarvinen@linux.intel.com, johannes@sipsolutions.net,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, linux-kernel@vger.kernel.org,
 tim.jh.chen@wnc.com.tw, Chih.Hung.Huang@wnc.com.tw
Date: Tue, 06 Oct 2026 02:13:14 +0000
Message-ID: <179125279468.434549.2491465464411302369@kernel.org>
In-Reply-To: <20261002014638.47981-2-tim770802@gmail.com>
References: <20261002014638.47981-2-tim770802@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  t7xx_cldma_send_skb() (drivers/net/wwan/t7xx/t7xx_hif_cldma.c) returns…
- [Low] At this commit, t7xx_dpmaif_tx_hw_push_thread() still runs `if
  (ret < 0 && ret != -EACCES) return ret;` when…

--

net: wwan: t7xx: fix runtime PM usage count underflow on -EACCES

This patch changes t7xx_dpmaif_tx_hw_push_thread(), t7xx_dpmaif_tx_done()
and t7xx_dpmaif_bat_release_work() so they skip
pm_runtime_put_autosuspend() when pm_runtime_resume_and_get() returned
-EACCES. In that case no usage count reference is held.

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> index 5af90ca6e0631..0e1174ee611df 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> @@ -1082,7 +1082,8 @@ static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
>  	}
>  
>  	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
> -	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
> +	if (ret != -EACCES)
> +		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
>  }

[Severity: High]
Are there other sites in this driver with the same unbalanced put that
still need fixing?

In this same file, t7xx_dpmaif_irq_rx_done() accepts -EACCES and still
schedules NAPI with no reference held:

t7xx_dpmaif_irq_rx_done() {
    ...
	ret = pm_runtime_resume_and_get(ctrl->dev);
	if (ret < 0 && ret != -EACCES) {
		dev_err(ctrl->dev, "Failed to resume device: %d\n", ret);
		return;
	}
	napi_schedule(&rxq->napi);
}

t7xx_dpmaif_napi_rx_poll() then drops a reference unconditionally, both
on the !rxq->que_started exit and on the work_done < budget completion
path:

t7xx_dpmaif_napi_rx_poll() {
    ...
	if (!rxq->que_started) {
		atomic_set(&rxq->rx_processing, 0);
		pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
    ...
	} else if (work_done < budget) {
		...
		t7xx_pci_enable_sleep(rxq->dpmaif_ctrl->t7xx_dev);
		pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
    ...
}

The get runs in IRQ context and the put runs in the NAPI poll, so a local
ret check can't be used. Would this need per-rxq state that is set in
t7xx_dpmaif_irq_rx_done() and checked in t7xx_dpmaif_napi_rx_poll()?

t7xx_cldma_send_skb() in t7xx_hif_cldma.c follows the same pattern. It
accepts -EACCES, and every exit goes through allow_sleep:

allow_sleep:
	t7xx_pci_enable_sleep(md_ctrl->t7xx_dev);
	pm_runtime_put_autosuspend(md_ctrl->dev);
	return ret;

There, ret gets overwritten later (-EIO, -ETIMEDOUT, or the result of
wait_event_interruptible_exclusive()). It would need a separate flag, like
the pm_ref this patch adds to t7xx_dpmaif_tx_done().

pm_runtime_get_active() has already called pm_runtime_put_noidle() before
it returns -EACCES. So each extra put either triggers the "Runtime PM
usage count underflow!" warning, or drops a reference that another context
holds (TX push thread, tx_done work, NAPI). Could that let the device
autosuspend while the other context is still doing MMIO?

As far as I can tell, the rest of the series doesn't cover these sites
either. At the end of the series, t7xx_dpmaif_napi_rx_poll() still puts
unconditionally (the last patch only adds napi_complete_done()), and CLDMA
is described as out of scope.

[ ... ]

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> index 236d632cf591b..bd6116a8c5413 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c

[ ... ]

> @@ -467,7 +472,8 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
>  		t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
>  		t7xx_do_tx_hw_push(dpmaif_ctrl);
>  		t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
> -		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
> +		if (ret != -EACCES)
> +			pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
>  	}

[Severity: Low]
This isn't a bug introduced by this patch, but just above this hunk the
thread still exits if the resume fails:

	ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
	if (ret < 0 && ret != -EACCES)
		return ret;

After the kthread returns, would TX stall for good?
t7xx_dpmaif_tx_send_skb() only enqueues the skb and wakes tx_wq.

dpmaif_ctrl->tx_thread also keeps pointing at the exited task, and no
reference was taken with get_task_struct(). Can the later kthread_stop()
in t7xx_dpmaif_tx_thread_rel() then touch a task_struct that has already
been freed?

A later patch in this series, "net: wwan: t7xx: do not exit the TX push
kthread on resume failure", replaces the return with
dev_err_ratelimited(), wait_event_freezable_timeout() and continue. That
fixes this in the final state of the series.

[Severity: High]
This is a pre-existing issue, but this patch keeps treating -EACCES as
success. Can t7xx_cldma_send_skb() in t7xx_hif_cldma.c return -EACCES
after it has already handed the skb to the TX ring?

When pm_runtime_resume_and_get() returns -EACCES, ret keeps that value.
On the first loop iteration with queue->budget > 0, nothing reassigns it:

t7xx_cldma_send_skb() {
    ...
	ret = pm_runtime_resume_and_get(md_ctrl->dev);
	if (ret < 0 && ret != -EACCES)
		return ret;
    ...
		if (queue->budget > 0 && !tx_req->skb) {
			...
			t7xx_cldma_gpd_handle_tx_request(queue, tx_req, skb);
			...
			spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
			t7xx_cldma_hw_start_send(md_ctrl, qno, tx_req);
			spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);

			break;
		}
    ...
	return ret;
}

By this point t7xx_cldma_gpd_handle_tx_request() has set
tx_req->skb = skb. The -EACCES goes back up through
t7xx_port_send_raw_skb() and t7xx_port_send_ccci_skb(), and the callers
free the skb on error:

t7xx_port_fastboot_write():  dev_kfree_skb(tx_skb)
t7xx_port_ctrl_tx():         dev_kfree_skb(cloned)
port_ctl_send_msg_to_md():   dev_kfree_skb_any(skb)

Later, t7xx_cldma_gpd_tx_collect() takes req->skb, unmaps it and calls
dev_kfree_skb_any() on it again.

Does this double free the skb? Could the device also DMA from the freed
memory before the second free?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002014638.47981-1-tim770802%40gmail.com
