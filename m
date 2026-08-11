Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACF37A847
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414780; cv=none; b=RDlne8JUFtu0EDFpU6cS0j+mGGe2X5G94+y8CSCdIczhtyY9kIHwkXzDNi6QuOQQz4hT31FkHFcd9SvwenJVMdc+n0Z9gt3EuBE59gCGH8PiW1tTmi4JXqrpqE1k8kRHRJcpcPiNr7XNUsWDOYSKTjaP0xPPE1ZvifxiNdRiudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414780; c=relaxed/simple;
	bh=4W0lveGDCALG3C0WLUatcAazVnIDs8Jql5mwCblZh+k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OtcUTptslTsPfyvFsMeFSeJzKtqjT2V3TEJnyMnFU+98iQYXTC+uck8p6B6KQlYinC/TogqrmSsG+Xflt5vfsvKcHAaYwUc1WNtRSy8qzQ1Su7qUcJavVHrfIVtN3+tkoCquHm+TyjkzRiS2VmpJhSULgnXBg78Rn3SVm7X+Clc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync9t1786414769t71780ed6
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.204.248.201])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16436076458310495816
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	"'Rongguang Wei'" <weirongguang@kylinos.cn>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Breno Leitao'" <leitao@debian.org>
References: <B2693E9A8BFAD110+20260807062214.410838-1-jiawenwu@trustnetic.com> <20260810153900.GT51943@horms.kernel.org>
In-Reply-To: <20260810153900.GT51943@horms.kernel.org>
Subject: RE: [PATCH net v3] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
Date: Tue, 11 Aug 2026 10:19:28 +0800
Message-ID: <086b01dd2937$d65cf7e0$8316e7a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQG0yxxTRoXP/+y718nIWsAV0QS7gAGNupIyttxjC5A=
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OVusWqAS2hMl/UDUd76/p3Tt1v/vA3/HGaxUsc8wIAJu9q/RreUCCDcH
	Hfu/i8j+V72+kLt3FiIk5y9LLJ0avMJWSJvzo9PDglzGD6QpuX9JR/a42GDRFKVbTLrj4lZ
	Velx77Jv9E075OMQQ2z/KxnnVPUQpYALLERuHYxglYc032y8izfMrpNRTSGw3hF68UWcNv7
	V5EpaY4u/qjyBiqUdeQU9TsgwA9dgBzrPxQzsTl60iygkZBSTe+99f8IwaL7pYzebv54hyK
	940lPNSv0E19QmNFXwXkcNHDelhtVHiRZaX42C/uu2bHyNJy8WucGa0Y0Gf44p9AbcpA4W/
	+Je4Sr7T6bhoFiq8SKza+d/QQQCdboop08XiVtv7oSpDO/WSMLQYkp5gjh5NrJsWK7GyXta
	3gu7nrqwIJKZ4Ai/CHvDfdsTcrchTxrD8A1jSuEcNIocx1pqKx1HqMB4mpbUijO/uyyKBbw
	XxxYJuzCIpnSNZx40P75lVhw8Jp4V0cY4Akn5U5GiM7Jnje45lfKEO0wSydYM+pjO6OYKXD
	qotscvdJ7XZCioxh2oIjyTR2xm26TegENdnwP2Rzry0mGiKJfXYu2Zbv+CupjIOh+Fq2oIR
	1811+Xu71J+FHoEeutSPDDYCj3op7WpYXuje8MuKSDHh6b0Chc+avQAsA2VTDMbfk56aNSI
	x+YsT/ztF8YMU9E3oTX/KVF5QxlacPv3Qa1KGXTICn/0NUY51laZK0rYRUhzZhlI9ZAh8+E
	EqEZOYEHSmLaXp7GWoyr0/vmjKRSMSa31S2nUNBuSbFSnxTy90ZmTVxShQ/FGLPW67obz51
	a8WnLW92pU+EQy1IFGZFhbqwuu5KITSMlAx/5B9TjUetYqpXhNmDyoX2WTWtPBvfW6REc7a
	m53LTJEtCCcQyUuS/R8DX44leSfmRFVKgndAt2wId6EjuhUE/HtREf64bxmdp7F4upWUyJB
	PH84fTEU0o/g7yt+HVhYEx28+nYC5lrLA0mO2tM/juoDoBIsI7FI0O3O2SETvkpeZYmFDgL
	IvQBHsZgtyKqBlSs+DT92Ycvl17NwSqglBWCmjx7lX0ONb6vfiM5Tyieg+FBgc4gKDua4Ru
	S3SAUuJhP51
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Mon, Aug 10, 2026 11:39 PM, Simon Horman wrote:
> On Fri, Aug 07, 2026 at 02:22:14PM +0800, Jiawen Wu wrote:
> > In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
> > not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
> > wx->msix_entry->entry, leading to a NULL pointer dereference crash.
> >
> > This issue was introduced by fixing the IRQ vector when the number of
> > VFs is 7. Fix the issue by explicitly checking `pdev->msix_enabled` to
> > determine the correct vector index.
> >
> > Additionally, as a side fix, set the interrupt mask to BIT(0) for the
> > non-MSI-X fallback. In MSI/INTx mode, the MISC and queue interrupts
> > share vector 0, and the WX_PX_MISC_IVAR register is only valid in the
> > MSI-X case. Thus, BIT(0) is the correct mask for the miscellaneous cause
> > when MSI-X is disabled.
> >
> > Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > Reviewed-by: Breno Leitao <leitao@debian.org>
> 
> Hi Jiawen,
> 
> I know the topic of BIT(0) came up in v2 - the AI-generated review
> forwarded by Jakub. And I appreciate you clarifying things in the commit
> message. But the AI generated review on netdev-qi [1] raises concerns which
> I'd appreciate you looking over.
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B2693E9A8BFAD110%2B20260807062214.410838-1-jiawenwu%40trustnetic.com
> 
> Although the review rehashes the concerns raised for v2, which you have
> addressed.  There are three related areas of concern which I can't resolve in
> my mind.
> 
>   1) The question of unmasking IRQ 0,
>      and the implication of possible interrupt storms.
> 
>   2) Compatibility of the BIT(0) change in this patch with the implementation
>      of wx_configure_vectors()
> 
>   3) Is there a need for any similar changes to txgbe.

1) The hardware truth regarding WX_PX_MISC_IVAR and BIT(0):
Sashiko assumes that in non-MSI-X mode, the MISC interrupt cause is mapped to
BIT(1) because wx_configure_vectors() unconditionally writes to the
WX_PX_MISC_IVAR register. 

In reality, on Wangxun hardware, the WX_PX_MISC_IVAR register is *completely
ignored by the hardware* when MSI-X is not enabled. In legacy INTx or single
MSI mode, the hardware forcibly merges all interrupt causes (both Queue and
MISC) into a single bit: BIT(0) of the interrupt cause register. The
configuration in wx_configure_vectors() for non-MSI-X mode is essentially dead
code that has no hardware effect. Therefore, BIT(0) is the only correct mask to
clear.

2) Why it won't cause an interrupt storm:
wx_intr_enable() clears the mask register to *allow* the next interrupt to be
asserted, it does not force-trigger an interrupt.

Since Queue and MISC are physically bound to BIT(0) in this mode, if we do not
unmask BIT(0) here, or mistakenly unmask BIT(1) (which the hardware never uses
in this mode), the MISC interrupt will remain masked indefinitely. This would
lead to lost MISC interrupts. The NAPI polling will still correctly handle the
Rx/Tx cleanups without looping endlessly.

3) Regarding txgbe consistency:
txgbe suffers from the exact same conceptual bug in its non-MSI-X fallback path.
I will be submitting a separate patch to fix txgbe as well.

> 
> Text from the AI-generated review is as follows:
> 
>   Is BIT(0) the right mask here, or is it the mask bit of queue vector 0
>   rather than of the misc cause?
> 
>   In MSI/INTx mode wx_set_interrupt_capability() sets wx->num_q_vectors = 1 and
>   q_vector[0]->v_idx == 0, and the queue vector's mask bit is BIT(v_idx), since
>   WX_INTR_Q(i) is BIT((i)) and wx_poll() re-arms the queue with:
> 
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_poll() {
> 	...
> 	if (likely(napi_complete_done(napi, work_done))) {
> 		...
> 		if (!test_bit(WX_STATE_DOWN, wx->state))
> 			wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
> 	}
> 	...
>   }
> 
>   So does the new fallback unmask the queue vector on a path whose callers
>   describe it as "no lsc, no queues"?
> 
>   The concrete effect appears in ngbe_intr(), where the queue cause is
>   auto-masked by hardware on the cause read:
> 
>   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_intr() {
> 	...
> 	/* would disable interrupts here but it is auto disabled */
> 	napi_schedule_irqoff(&q_vector->napi);
> 	if (!test_bit(WX_STATE_DOWN, wx->state))
> 		ngbe_irq_enable(wx, false);
> 	...
>   }
> 
>   With BIT(0) the queue vector is unmasked again immediately while NAPI is
>   still scheduled. Does this defeat the NAPI moderation in MSI/INTx mode, so
>   the driver takes an interrupt per completion event instead of one per NAPI
>   cycle?
> 
>   The peer driver on the same libwx register layout uses the opposite value,
>   unconditionally, including on its non-MSI-X paths in txgbe_irq.c:
> 
>   drivers/net/ethernet/wangxun/txgbe/txgbe_type.h:
> 
>   #define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
>   #define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
> 
>   ngbe also used BIT(wx->num_q_vectors) for this path before 4174c0c331a2.
>   Would BIT(wx->num_q_vectors) be the value that matches libwx and txgbe here,
>   or alternatively programming WX_PX_MISC_IVAR to vector 0 when
>   !pdev->msix_enabled so that routing and mask agree?
> 
>   Related to that, the changelog says:
> 
>       In MSI/INTx mode, the MISC and queue interrupts
>       share vector 0, and the WX_PX_MISC_IVAR register is only valid in the
>       MSI-X case. Thus, BIT(0) is the correct mask for the miscellaneous cause
>       when MSI-X is disabled.
> 
>   Which code establishes that WX_PX_MISC_IVAR is only valid with MSI-X?
>   wx_configure_vectors() writes the misc IVAR unconditionally with
>   v_idx == wx->num_q_vectors, and only the following ITR write is gated on
>   msix_enabled:
> 
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_configure_vectors() {
> 	...
> 	wx_set_ivar(wx, -1, 0, v_idx);
> 	if (pdev->msix_enabled)
> 		wr32(wx, WX_PX_ITR(v_idx), 1950);
>   }
> 
>   The only place that forces the misc vector index to 0 is the
>   WX_FLAG_IRQ_VECTOR_SHARED path set by __wx_enable_sriov() for
>   num_vfs == 7 && mac.type == wx_mac_em, which is itself an MSI-X case. Could
>   the changelog be adjusted to match what the code does, or is there hardware
>   behaviour behind the claim that is not visible in the driver?

