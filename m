Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167B361DA9
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017662; cv=none; b=k10Bp1/qlBwQS5Y5yzSRt4WLZK3B0nTr3PjfapojjJkzpNWRaZShPkPE1aoN/9M01oW4K5Rbc6UnYi3gxLOxWJsz2efzhEQdLUg4UTRuZP8zjDvmSY9IzuFyAUkx+dONLte0bMfw+PcJ+fup4t/BcRM97h8rnGflRARojeiAe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017662; c=relaxed/simple;
	bh=WEKjfHzYB7siVdzw/4bAAgkdwtVlzmfXtZTA++joCmw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VoMigblmUO7lu5k+dPkHvLCYDhXJdjTdEqnSkrJCZcu70wSl5T7oxIj2c2J4cIsRoXmozmnou9FPmz+/geAW2nQ7x/bkUJYTMl61uhL77wPCLo1my7UEA2EMMRRjN9uMT/yhMDBe3z77ur1Xi6+oXk0vD2Ec9KX8RDp/YX+pKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync5t1787017594t3c053508
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.185.99])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8872861188661157403
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<larysa.zaremba@intel.com>
References: <59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com> <20260817205809.3620094-1-kuba@kernel.org>
In-Reply-To: <20260817205809.3620094-1-kuba@kernel.org>
Subject: RE: [PATCH net] net: txgbe: fix interrupt mask for MISC cause in non-MSI-X mode
Date: Tue, 18 Aug 2026 09:46:33 +0800
Message-ID: <00df01dd2eb3$65ef53f0$31cdfbd0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGTHdpTZY9AWyFEJiKyI+ubAlWBawEnVPE2ty3v3GA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nl7eTg5yGHnw+8LHcaEugfWT0AgKsRA3Iv/rPaEqjW5WhfuofaIOylQc
	c0vr9Nte7IjgTQAG2/Z+lsHIKpfmCiNUdUgWj1LBmmzBiKv4KgErGCK/XHXtQzGBR2Qe7uw
	Ovgr/csMbSJLrOYRkFUibDVjjaTvXvnjrG1UUtI6Ruj6G9HAkqdN5pMcv6dsZ1DxF29Uzgw
	y/tE7oe9LXQO1ZoyV29xP7a/cbqk9K8Sf/0r1Yn1fVbhoViMV50Q8fMCqAhBbP71w3ia3s5
	5M3bkIjXs1VMCsddgzzmq5acwcreQeOFyr/EI6w1RFrNtBUWkpWkR3YDg/7G81q0cH/jVjI
	gN18fzi09Zo7M9t7nvvC/uvnzWeU2CyNHc19a6CJxZFSCP/aUWz4tqq7e+Hq/1Cr3MocZlO
	7hwdSoPWlg+w3KOHPxfzMzhhPp78MhQIZ/BXPdtKpilG0iHZRGTdt+rt3OS9lyISezXfR8K
	pyVyhi3kyNvwGB0U6fKv2vTlFWUNkOZsWfFgvJ1qe9N2eLXoPchxk28Phx3Gxd0KRNYg3af
	Kdp/ztciRiwhr4DL15Z76JZnUDKU28OzZdU9+7of+wpUBVnRq2KWHyHncGGFSGJSK8fcGMh
	n7G1sNuMjNsUmIsbYv895I55oMohloQEFUrEH+gyrhlefxzXXk0GUIWyRXzXdWZANulCA3t
	LpqVXlwtpxiZe9NOLJtax/0sFhBIV8kqKgvH10b8M4X5cmiFZlUP5O7NpYu09KfR75PKI7M
	A2Z3GBOU7KpKkIaPjVJ4wswUixGkvBtQhNRORA8LQnFFIEblHBlA4CScP0pmgWNxKelBxSL
	+PC8HQTp9NBsFFo5EA+m0mbyoOV8H6HnWgsHApeyIXcjup53NDz85ukdbSqgTpajVRKFcA+
	93qV2n/0izuYPMDdLV+BdcGZ3GmYRoO2T4D4wLzYImrmSphrqsE+PCLTEiHa+NGMyQiPAk3
	1Ffw+cVv7c0OmIW0TjSNvdQv3cEWewKW5c/A30Iju6lXhS8GQXAwIh2jNV4o2xfqsSvU7gR
	WiVo+StIvq+TWtxIf/iz+MM9euT+IRT8Gq+0PTs2GcYrax3GQoKDdok8DnwX4ZdXgHmTBoa
	0b/hzaqcOg2NW6NTTvQdYA=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Tue, Aug 18, 2026 4:58 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: txgbe: fix interrupt mask for MISC cause in non-MSI-X mode
> 
> The patch changes the trailing unmask in txgbe_misc_irq_thread_fn() so that
> it uses BIT(0) instead of TXGBE_INTR_MISC(wx) when MSI-X is not enabled,
> because the hardware merges all interrupt causes into BIT(0) in MSI/INTx
> mode. This is meant to avoid delaying subsequent MISC interrupts until NAPI
> polling completes.
> 
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > index 8746318ad3bcb..05b318f4e6ed6 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> 
> [ ... ]
> 
> > @@ -183,7 +184,8 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
> >  		nhandled++;
> >  	}
> >
> > -	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> > +	misc_mask = wx->pdev->msix_enabled ? TXGBE_INTR_MISC(wx) : BIT(0);
> > +	wx_intr_enable(wx, misc_mask);
> >  	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
> >  }
> 
> [Severity: Medium]
> Should this unmask be guarded by WX_STATE_DOWN now that it touches the live
> BIT(0) cause?
> 
> In non-MSI-X mode this write becomes a real WX_PX_IMC(0) = BIT(0), which
> re-arms the single merged queue+MISC cause. Before the change the value was
> BIT(wx->num_q_vectors) = BIT(1) with num_q_vectors == 1 in this mode, i.e. a
> bit the hardware does not use here, so the write left no hardware residue.
> 
> wx_irq_disable() in libwx/wx_hw.c masks everything before it waits for
> in-flight handlers:
> 
> void wx_irq_disable(struct wx *wx)
> {
> 	struct pci_dev *pdev = wx->pdev;
> 
> 	wr32(wx, WX_PX_MISC_IEN, 0);
> 	wx_intr_disable(wx, WX_INTR_ALL);
> 
> 	if (pdev->msix_enabled) {
> 		...
> 	} else {
> 		synchronize_irq(pdev->irq);
> 	}
> }
> 
> Can a misc thread that is already running execute its trailing
> wx_intr_enable(wx, BIT(0)) after those mask writes, so that synchronize_irq()
> returns with the only active cause unmasked while the driver considers
> interrupts off?
> 
> The window in txgbe_disable_device() spans wx_irq_disable() through
> wx_napi_disable_all(), timer_delete_sync(), cancel_work_sync() and the TX ring
> shutdown, and the mask is only restored later via txgbe_reset() ->
> txgbe_reset_hw() -> wx_stop_adapter(). Since the TX rings and TX DMA engine
> are stopped after wx_irq_disable(), a TX completion cause could assert on the
> re-unmasked BIT(0) during that window; on a shared INTx line the hard handler
> then takes the eicr == 0 path, returns IRQ_NONE and does not write
> WX_PX_INTA.
> 
> Every other unmask site in this driver family wraps the same operation in the
> down check, for example wx_poll() in libwx/wx_lib.c:
> 
> 	if (!test_bit(WX_STATE_DOWN, wx->state))
> 		wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
> 
> and ngbe_intr() in ngbe/ngbe_main.c:
> 
> 	if (!test_bit(WX_STATE_DOWN, wx->state))
> 		ngbe_irq_enable(wx, false);
> 
> txgbe_misc_irq_handle() itself uses the guard on its shared interrupt path.
> Would something like the following be more consistent?
> 
> 	misc_mask = wx->pdev->msix_enabled ? TXGBE_INTR_MISC(wx) : BIT(0);
> 	if (!test_bit(WX_STATE_DOWN, wx->state))
> 		wx_intr_enable(wx, misc_mask);

Right, I'll fix it in V2.


