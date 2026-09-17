Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D62F39C7;
	Thu, 17 Sep 2026 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606167; cv=none; b=taiWx/Ekg0XAKHa/eGc2ikOvAjZXUdNxj7qTrWp4N93aYclUP7iS5qTafg9z93b8qIAVul3lCTJclYrtRlbjIAvDyKPlYVH1N0ADRC+XIflEWtEZYlaDCccM5yUyTzpHpnK/XC7OpoTxW7uJAcX7l/2JJ24hmpBB0xx6ANh4YZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606167; c=relaxed/simple;
	bh=eNNVJACpU1ZScvKZzDq439C14MGcJ+dhoapA2tDmHIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLqSpLFhU0Wvs0M+UimbM2kHZ0lKqQWUzl1wblYAcQHPK95IMX1ih3T67HBU/nEZg69JJmJJrZItZSruAZkquUpM1DJmTmb1HdOBEm8+m6bhvC1KFsmgaZzeJ29cOKIANs3KAapPF2+t2hObLwwYNUlAjB5285U81kfxmdi91/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFT5fm9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFT5fm9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0A91F000FF;
	Thu, 17 Sep 2026 00:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789606165;
	bh=Ol67W4BdM1lbUfwrzn7aJWQxsa3myQxFE8AQXEh5bp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFT5fm9OpcGslwhFBVkF08u9h2PeGXZcQQ7EqcIVP4e6juHgbC+bBzLvEzQpP+RDP
	 16Zk7km6HN+yigbsx+NfbTw8hiJ3WHxLBV45jV3ik8tpaJiJSdNNHQtMzUCTvxFvxP
	 zbl3FCkSLnc07TBfbQc+09WK7OLiaDGM1UHFHc2w2JkWIkEGsDFOmQ7F+WnzIYlTh0
	 sm9Fg2PS9/DbHQ92sAlEt/eBet7gzZsfXUqt5mHOejA3F0t8OGY/viWYuQgZuRQ4+X
	 +Li/AJssG3IctBM/po4HOZe2s//2kgaWu4+9XUJNBxb9xFbb1xX8IsHI61zj6mLsey
	 WCwpTE3GWwKAA==
From: Jakub Kicinski <kuba@kernel.org>
To: tamas@rimpianto.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	chris.snook@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gatis@mikrotik.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atl1c: fix soft lockup on out-of-range tpd_cons read
Date: Wed, 16 Sep 2026 17:49:23 -0700
Message-ID: <20260917004924.2461599-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911201718.1517366-1-tamas@rimpianto.com>
References: <20260911201718.1517366-1-tamas@rimpianto.com>
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
net: atl1c: fix soft lockup on out-of-range tpd_cons read

This adds a bounds check on the TX consumer index read from the hardware
in atl1c_clean_tx(), so that an out-of-range value (reported as 0xffff)
is treated as "nothing to clean" rather than driving the cleanup loop
forever.

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index 7efa3fc257b39..e58f1d2c26bdf 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -1602,6 +1602,9 @@ static int atl1c_clean_tx(struct napi_struct *napi, int budget)
>  	AT_READ_REGW(&adapter->hw, atl1c_qregs[tpd_ring->num].tpd_cons,
>  		     &hw_next_to_clean);
>  

[Severity: Medium]
Should this carry a Fixes: tag and a Cc: stable@vger.kernel.org?

git blame puts the unbounded loop in atl1c_clean_tx() at commit
43250ddd75a35d ("atl1c: Atheros L1C Gigabit Ethernet driver"), and the
per-queue register form of the read at commit 057f4af2b1716f, so all
stable trees appear to be affected:

Fixes: 43250ddd75a35d ("atl1c: Atheros L1C Gigabit Ethernet driver")

The loop really cannot terminate on its own: tpd_ring->count is fixed at
1024 in atl1c_setup_ring_resources() and the driver has no ethtool
ringparam callback, so a 0xffff read never matches any wrapped
next_to_clean value, and atl1c_clean_buffer() returns immediately once
the entries carry ATL1C_BUFFER_FREE.

Could the changelog also say how the 0xffff value was observed - kernel
version, hardware, and the log or reproducer? That makes the hardware
claim easier to confirm.

[Severity: High]
This isn't a bug introduced by this patch, but the sibling Atheros
drivers have the same loop and are left untouched here. Were they
audited?

atl1e_clean_tx_irq() in drivers/net/ethernet/atheros/atl1e/atl1e_main.c
uses the same accessor and the same modulo-count loop:

	u16 hw_next_to_clean = AT_READ_REGW(&adapter->hw, REG_TPD_CONS_IDX);
	u16 next_to_clean = atomic_read(&tx_ring->next_to_clean);

	while (next_to_clean != hw_next_to_clean) {

An all-ones read from a dead or resetting PCIe link is generic bus
behaviour, so this spins forever in softirq context on atl1e too.

atl1_intr_tx() in drivers/net/ethernet/atheros/atlx/atl1.c has the same
shape, driven by the device-written CMB field:

	cmb_tpd_next_to_clean = le16_to_cpu(adapter->cmb.cmb->tpd_cons_idx);

	while (cmb_tpd_next_to_clean != sw_tpd_next_to_clean) {

Would a note in the changelog about these two, or matching patches, make
sense?

> +	if (unlikely(hw_next_to_clean >= tpd_ring->count))
> +		hw_next_to_clean = next_to_clean;
> +
>  	while (next_to_clean != hw_next_to_clean) {
>  		buffer_info = &tpd_ring->buffer_info[next_to_clean];
>  		if (buffer_info->skb) {

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but the
"while the PCIe link/MAC is resetting" scenario named in the changelog
looks like it also has an unsynchronized reset-versus-poll window that
this clamp does not close.

atl1c_common_task() handles the link change by masking interrupts and
then resetting the rings from process context:

	if (test_and_clear_bit(ATL1C_WORK_EVENT_LINK_CHANGE,
		&adapter->work_event)) {
		atl1c_irq_disable(adapter);
		atl1c_check_link_status(adapter);
		atl1c_irq_enable(adapter);
	}

atl1c_irq_disable() only masks IMR and waits for the hard IRQ handler:

	atomic_inc(&adapter->irq_sem);
	AT_WRITE_REG(&adapter->hw, REG_IMR, 0);
	AT_WRITE_REG(&adapter->hw, REG_ISR, ISR_DIS_INT);
	AT_WRITE_FLUSH(&adapter->hw);
	synchronize_irq(adapter->pdev->irq);

There is no napi_disable() or napi_synchronize() on this path, unlike
atl1c_down(). On link down, atl1c_check_link_status() then goes on to
atl1c_reset_mac(), atl1c_reset_dma_ring() and atl1c_configure() with all
TX NAPI instances still enabled.

atl1c_reset_dma_ring() -> atl1c_clean_tx_ring() walks every entry and
resets the index:

	for (index = 0; index < ring_count; index++) {
		buffer_info = &tpd_ring->buffer_info[index];
		atl1c_clean_buffer(pdev, buffer_info, 0);
	}
	...
	atomic_set(&tpd_ring->next_to_clean, 0);

Meanwhile atl1c_clean_tx() calls atl1c_clean_buffer() on the same
entries and writes its entry-time snapshot back:

	atl1c_clean_buffer(pdev, buffer_info, budget);
	if (++next_to_clean == tpd_ring->count)
		next_to_clean = 0;
	atomic_set(&tpd_ring->next_to_clean, next_to_clean);

The only guard against releasing a buffer twice is a plain read of a u16
field in atl1c_clean_buffer():

	if (buffer_info->flags & ATL1C_BUFFER_FREE)
		return;

Can both contexts pass that test for the same buffer_info and end up
doing two dma_unmap_single() and two napi_consume_skb() calls on it?
And can the poll's atomic_set() overwrite the reset path's
next_to_clean = 0, leaving the software index out of sync with the
freshly reset hardware?

Would adding napi_disable()/napi_synchronize() around the reset in the
link-change path be the right complement to this clamp? The clamp still
looks needed on its own, since surprise removal produces all-ones reads
that NAPI synchronization cannot prevent.
-- 
pw-bot: cr
