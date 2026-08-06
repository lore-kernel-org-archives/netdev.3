Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8F2C3768
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030301; cv=none; b=I/ezgn3GbsZi8h3tkMX+vnEkDUQNvtNZhL05ZO5emg7bZMtQ6FYoXiTU32fqM2h0YgnIDD6U/8uc6N9DtyRXpI58wXb3gota9BhPweZb95EGBzYyhwPyObSDFmtx6AlDY5bO0ehVU6XOnUaZ6Zg2+SRS5ZTJ7atZzQpJCTdF1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030301; c=relaxed/simple;
	bh=Sp0zEf6KPmO0rlstHCAEqhlW6xfx+tlA2d2CHkUBxrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uk4qSs2/yiqMywsd4U9Lw0OcfGgfD36uzc3ULbcBh1+t5A4Q7+BGUpFQBCnPwaI7wCmoujciwtae9S5NylDDyRC97LFyvU+KQPWjYAmTDl05Lf4i3rsJZvmC3C+mr03ZZor8YwkJN00EUEnR3Zy6g45/nZeGlJGXMmovFUO2E/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ0VbGfz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ0VbGfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DF01F000E9;
	Thu,  6 Aug 2026 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030300;
	bh=ehSjwbGQhcKtiFxnNIjwCp5apoigHhStk5UURx7APDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJ0VbGfzrrKCC+BbSelshvk+bcfKF2B/CwO5JQmToB8zsjA3DymgVpANhp+WUteDw
	 wCEmL9JU0KTIRqjMRxhx1GTZl5c+KTZJbEiHQT/BFpvwQ8bc8SNMPp57YtDiqlC23u
	 gywu1XNdoUbCBizuR4JUOPOudwPSXvIPXPQYhk1ctwWh0wIPWQ30ddUEmPVfduiUE/
	 KhkMFU6RXUWPDgVva2xBMyCOhAPgpsj3SMcc3qbzQwYfRxNSxoEhKwyJNTtA15no3V
	 OHbQnYCFFhzGZNstuDiO3q2zsQWmnOrKslnCEs9bmcfNARTA+SS4GUAW+6ftuCXS+M
	 fZWcbbl2eY+Mw==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	joe@dama.to,
	u.kleine-koenig@baylibre.com,
	weirongguang@kylinos.cn,
	larysa.zaremba@intel.com,
	horms@kernel.org
Subject: Re: [PATCH net v2] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
Date: Thu,  6 Aug 2026 08:31:38 -0700
Message-ID: <20260806153138.2580692-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5FE44222ED3FAC4B+20260803072022.377406-1-jiawenwu@trustnetic.com>
References: <5FE44222ED3FAC4B+20260803072022.377406-1-jiawenwu@trustnetic.com>
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
net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling

This patch avoids dereferencing wx->msix_entry in NGBE_INTR_MISC() when the
device is not running in MSI-X mode, by testing pdev->msix_enabled in
ngbe_irq_enable() and falling back to a hard-coded mask value otherwise.

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index a16221995909..cb653861aad8 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -180,8 +180,10 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
>  	/* mask interrupt */
>  	if (queues)
>  		wx_intr_enable(wx, NGBE_INTR_ALL);
> -	else
> +	else if (wx->pdev->msix_enabled)
>  		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
> +	else
> +		wx_intr_enable(wx, BIT(0));
>  }

[Severity: Medium]
Is BIT(0) the right mask bit for the misc cause in the non-MSI-X case?

In the MSI/INTx fallback, wx_set_interrupt_capability() sets
wx->num_q_vectors = 1, and ngbe_up() -> wx_configure_vectors() still
programs the misc IVAR:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_configure_vectors() {
	...
	wx_set_ivar(wx, -1, 0, v_idx);
}

with v_idx == wx->num_q_vectors == 1.  wx_set_ivar() only forces the
other-causes vector to 0 when WX_FLAG_IRQ_VECTOR_SHARED is set, which
happens for wx_mac_em with num_vfs == 7 in __wx_enable_sriov():

	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
		msix_vector = 0;

So in plain MSI/INTx the misc cause sits at bit 1, and bit 0 is queue
vector 0.  Does this branch then clear the wrong bit in PX_IMC, leaving
the misc cause masked while unmasking the queue cause?

The queue cause looks like it is meant to stay masked here, per
ngbe_intr():

	/* would disable interrupts here but it is auto disabled */
	napi_schedule_irqoff(&q_vector->napi);

	if (!test_bit(WX_STATE_DOWN, wx->state))
		ngbe_irq_enable(wx, false);

and wx_poll() is the place that re-arms it after NAPI completes:

	wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));

Can unmasking BIT(0) from the hard IRQ handler let the device re-assert
the (possibly shared) INTx/MSI line while NAPI is still scheduled,
leading to repeated hard-IRQ entries and, on the eicr == 0 path, to
IRQ_NONE returns followed by a full NGBE_INTR_ALL unmask?

Would BIT(wx->num_q_vectors) be the value that preserves the behaviour
prior to commit 4174c0c331a2, where NGBE_INTR_MISC(A) expanded to
BIT((A)->num_q_vectors)?  The sibling driver still uses that form
unconditionally, including on its non-MSI-X path:

drivers/net/ethernet/wangxun/txgbe/txgbe_type.h:
	#define TXGBE_INTR_MISC(A)	BIT((A)->num_q_vectors)

One more note on the changelog: it says the fix is to check
pdev->msix_enabled "to determine the correct vector index", but it does
not mention that the mask value written in non-MSI-X mode changes from
BIT(1) to BIT(0).  Could the changelog spell out the intended vector
index for the MSI/INTx case?
-- 
pw-bot: cr
