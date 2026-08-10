Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76E346777
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376346; cv=none; b=IlRWLLGNCixfnMM1xQp+o7CvijZMzsRditdAA7a57k8NggQgnzooJbvioqIr/2FBslFoK9jXm0vochzTz3/ID0HQ+0r3aTRfxcUtBfiaO/IVFt4zTYv5LEs1+iRRwQNXwHqnjRvrB3JAyHAB74WHdJalnUUJlScN4jGrDBOaEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376346; c=relaxed/simple;
	bh=h9vShaD9an6N3Sel+XZ4jOZZ4V/VS3qy44nU8tMgbxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEgNSnSKieORdya0rYyegnzgibiAyppmUj1zZxz4zju+wofdF+MqWjHpu8++jiPl5nC12pP6XanSHrW4fsPd0OwE6bXlZWRvydHiRf0nIeMT7oHuSmRjXNrNCzh+Ia6YDFirwTC2ll6G6P3YahKANrrrRwKQ+dOAq6ptp0KTo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAODM7HK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAODM7HK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949B71F000E9;
	Mon, 10 Aug 2026 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376345;
	bh=nGFYVDoWX1RRJ0jFD2ivQtFu4q1KDFQxVy15wKYMDuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bAODM7HKZ8FjzbOmhMqoHU0kWzxIz8yaVo680oYfQ2eeN3XWno0L75Sk009BEOVUA
	 gfdlnoLvI8wXmI3Xe4TkEUAImsqPudxGlxl4X3CaNXL5Z12nE1hoWyjABXeDLjVh0V
	 58h4f32hl1AtpWvf0iVAWZzyNg7+lNnVtUPu3XTbyR4yzGojNUSYkwEvK4f5H1V3xf
	 utXgA9MsUdIqolRe+gegdy+csCjUR/98Rym+0HuE6ej72XQHZrHLGvZCSG7dxaZJ0a
	 N90ipyOfGEY1To6RE1aF1I11xnRsGkmOdacNsrUNcZGqx230AJALSWlBmVUp8zJmeE
	 pQokwD754a+Qw==
Date: Mon, 10 Aug 2026 16:39:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net v3] net: ngbe: fix NULL pointer dereference in
 non-MSI-X interrupt enabling
Message-ID: <20260810153900.GT51943@horms.kernel.org>
References: <B2693E9A8BFAD110+20260807062214.410838-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2693E9A8BFAD110+20260807062214.410838-1-jiawenwu@trustnetic.com>

On Fri, Aug 07, 2026 at 02:22:14PM +0800, Jiawen Wu wrote:
> In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
> not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
> wx->msix_entry->entry, leading to a NULL pointer dereference crash.
> 
> This issue was introduced by fixing the IRQ vector when the number of
> VFs is 7. Fix the issue by explicitly checking `pdev->msix_enabled` to
> determine the correct vector index.
> 
> Additionally, as a side fix, set the interrupt mask to BIT(0) for the
> non-MSI-X fallback. In MSI/INTx mode, the MISC and queue interrupts
> share vector 0, and the WX_PX_MISC_IVAR register is only valid in the
> MSI-X case. Thus, BIT(0) is the correct mask for the miscellaneous cause
> when MSI-X is disabled.
> 
> Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Breno Leitao <leitao@debian.org>

Hi Jiawen,

I know the topic of BIT(0) came up in v2 - the AI-generated review
forwarded by Jakub. And I appreciate you clarifying things in the commit
message. But the AI generated review on netdev-qi [1] raises concerns which
I'd appreciate you looking over.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B2693E9A8BFAD110%2B20260807062214.410838-1-jiawenwu%40trustnetic.com

Although the review rehashes the concerns raised for v2, which you have
addressed.  There are three related areas of concern which I can't resolve in
my mind.

  1) The question of unmasking IRQ 0,
     and the implication of possible interrupt storms.

  2) Compatibility of the BIT(0) change in this patch with the implementation
     of wx_configure_vectors()

  3) Is there a need for any similar changes to txgbe.

Text from the AI-generated review is as follows:

  Is BIT(0) the right mask here, or is it the mask bit of queue vector 0
  rather than of the misc cause?

  In MSI/INTx mode wx_set_interrupt_capability() sets wx->num_q_vectors = 1 and
  q_vector[0]->v_idx == 0, and the queue vector's mask bit is BIT(v_idx), since
  WX_INTR_Q(i) is BIT((i)) and wx_poll() re-arms the queue with:

  drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_poll() {
	...
	if (likely(napi_complete_done(napi, work_done))) {
		...
		if (!test_bit(WX_STATE_DOWN, wx->state))
			wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
	}
	...
  }

  So does the new fallback unmask the queue vector on a path whose callers
  describe it as "no lsc, no queues"?

  The concrete effect appears in ngbe_intr(), where the queue cause is
  auto-masked by hardware on the cause read:

  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_intr() {
	...
	/* would disable interrupts here but it is auto disabled */
	napi_schedule_irqoff(&q_vector->napi);
	if (!test_bit(WX_STATE_DOWN, wx->state))
		ngbe_irq_enable(wx, false);
	...
  }

  With BIT(0) the queue vector is unmasked again immediately while NAPI is
  still scheduled. Does this defeat the NAPI moderation in MSI/INTx mode, so
  the driver takes an interrupt per completion event instead of one per NAPI
  cycle?

  The peer driver on the same libwx register layout uses the opposite value,
  unconditionally, including on its non-MSI-X paths in txgbe_irq.c:

  drivers/net/ethernet/wangxun/txgbe/txgbe_type.h:

  #define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
  #define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)

  ngbe also used BIT(wx->num_q_vectors) for this path before 4174c0c331a2.
  Would BIT(wx->num_q_vectors) be the value that matches libwx and txgbe here,
  or alternatively programming WX_PX_MISC_IVAR to vector 0 when
  !pdev->msix_enabled so that routing and mask agree?

  Related to that, the changelog says:

      In MSI/INTx mode, the MISC and queue interrupts
      share vector 0, and the WX_PX_MISC_IVAR register is only valid in the
      MSI-X case. Thus, BIT(0) is the correct mask for the miscellaneous cause
      when MSI-X is disabled.

  Which code establishes that WX_PX_MISC_IVAR is only valid with MSI-X?
  wx_configure_vectors() writes the misc IVAR unconditionally with
  v_idx == wx->num_q_vectors, and only the following ITR write is gated on
  msix_enabled:

  drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_configure_vectors() {
	...
	wx_set_ivar(wx, -1, 0, v_idx);
	if (pdev->msix_enabled)
		wr32(wx, WX_PX_ITR(v_idx), 1950);
  }

  The only place that forces the misc vector index to 0 is the
  WX_FLAG_IRQ_VECTOR_SHARED path set by __wx_enable_sriov() for
  num_vfs == 7 && mac.type == wx_mac_em, which is itself an MSI-X case. Could
  the changelog be adjusted to match what the code does, or is there hardware
  behaviour behind the claim that is not visible in the driver?
