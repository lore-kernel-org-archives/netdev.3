Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DA3BE168
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000292; cv=none; b=rqqCVMJW9SnuAoB8EglkyKWdWLhzQuKOv0hREGDSiIqhOQL2oR7PobqyDuH77V6Kbf5EMpdIbCaGWAlowV2ZLAm+qbTOPVx7XnYDa+o3c975igEciIIblT7ai/hjtUEu1z3YcLsnr0KqU+544pV8NzS9b6H/ZxuGlbs4j6OhioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000292; c=relaxed/simple;
	bh=qU+cEMM38jaogS36VjHCVYi/AvodElvMLgFzWofPPvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKF41xovCwOa5b/64MZX+1pOjvqK2LbcYJCCPvQR8AlSzADtHyMdzD8+9NhKJWW6hcts20ei5TiesMas+i1o3IKBsUZrj7GJjq0vdc3rJbQihX5Z47dFdTGiLGm9N17ZhATe5CVdman4hpGWtvW3UDjUUSpjpiT/KqTjYyXh0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9CJ0C00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9CJ0C00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969641F000E9;
	Mon, 17 Aug 2026 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787000291;
	bh=E1RI7UTVFb/Y540SUAsOOHpc9fK5PeqCmFEXXd0swhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9CJ0C00FoSnpE1PRR5KhaSvawTXt4Jt42b4hK4OP1uJU9C7bXk3U8XfrnB5mtOTW
	 HTkltyddq25SfhCoEwkGuD9sX9kMNL7yOg8Hp/v/cg5OvtijfmYyfBLJCh3kbnCovt
	 XMj7cBA60L0R6MzeZE+f0YRrNvmyID9u31Qgcdaga8y9SgdUnTUmTNDO2TSYNpntEP
	 5xdExX9lBRyOr0g9s5IR3iDL4rPsFtIhg2g9qnqEmwzakzSKjZRDXKcm/52Uzb4BF3
	 rs1OZVjUYgi/jHKiJkpZGGCecu5Gr4d7gjlI49J3829XDQRtAu6IMYCjxbUwr/xgTF
	 P1pTLeX5g0vyw==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	larysa.zaremba@intel.com
Subject: Re: [PATCH net] net: txgbe: fix interrupt mask for MISC cause in non-MSI-X mode
Date: Mon, 17 Aug 2026 13:58:09 -0700
Message-ID: <20260817205809.3620094-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com>
References: <59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com>
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
net: txgbe: fix interrupt mask for MISC cause in non-MSI-X mode

The patch changes the trailing unmask in txgbe_misc_irq_thread_fn() so that
it uses BIT(0) instead of TXGBE_INTR_MISC(wx) when MSI-X is not enabled,
because the hardware merges all interrupt causes into BIT(0) in MSI/INTx
mode. This is meant to avoid delaying subsequent MISC interrupts until NAPI
polling completes.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index 8746318ad3bcb..05b318f4e6ed6 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c

[ ... ]

> @@ -183,7 +184,8 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
>  		nhandled++;
>  	}
>  
> -	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> +	misc_mask = wx->pdev->msix_enabled ? TXGBE_INTR_MISC(wx) : BIT(0);
> +	wx_intr_enable(wx, misc_mask);
>  	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
>  }

[Severity: Medium]
Should this unmask be guarded by WX_STATE_DOWN now that it touches the live
BIT(0) cause?

In non-MSI-X mode this write becomes a real WX_PX_IMC(0) = BIT(0), which
re-arms the single merged queue+MISC cause. Before the change the value was
BIT(wx->num_q_vectors) = BIT(1) with num_q_vectors == 1 in this mode, i.e. a
bit the hardware does not use here, so the write left no hardware residue.

wx_irq_disable() in libwx/wx_hw.c masks everything before it waits for
in-flight handlers:

void wx_irq_disable(struct wx *wx)
{
	struct pci_dev *pdev = wx->pdev;

	wr32(wx, WX_PX_MISC_IEN, 0);
	wx_intr_disable(wx, WX_INTR_ALL);

	if (pdev->msix_enabled) {
		...
	} else {
		synchronize_irq(pdev->irq);
	}
}

Can a misc thread that is already running execute its trailing
wx_intr_enable(wx, BIT(0)) after those mask writes, so that synchronize_irq()
returns with the only active cause unmasked while the driver considers
interrupts off?

The window in txgbe_disable_device() spans wx_irq_disable() through
wx_napi_disable_all(), timer_delete_sync(), cancel_work_sync() and the TX ring
shutdown, and the mask is only restored later via txgbe_reset() ->
txgbe_reset_hw() -> wx_stop_adapter(). Since the TX rings and TX DMA engine
are stopped after wx_irq_disable(), a TX completion cause could assert on the
re-unmasked BIT(0) during that window; on a shared INTx line the hard handler
then takes the eicr == 0 path, returns IRQ_NONE and does not write
WX_PX_INTA.

Every other unmask site in this driver family wraps the same operation in the
down check, for example wx_poll() in libwx/wx_lib.c:

	if (!test_bit(WX_STATE_DOWN, wx->state))
		wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));

and ngbe_intr() in ngbe/ngbe_main.c:

	if (!test_bit(WX_STATE_DOWN, wx->state))
		ngbe_irq_enable(wx, false);

txgbe_misc_irq_handle() itself uses the guard on its shared interrupt path.
Would something like the following be more consistent?

	misc_mask = wx->pdev->msix_enabled ? TXGBE_INTR_MISC(wx) : BIT(0);
	if (!test_bit(WX_STATE_DOWN, wx->state))
		wx_intr_enable(wx, misc_mask);
-- 
pw-bot: cr
