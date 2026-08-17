Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A372771B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786932070; cv=none; b=ZKlVOesskmx5VW5ZmCnmSHZDCFmOtwfzfzjEivg4NSo5O5z+ZZlWOtB9KOYh9VYO3rS82GVpkXU7Px6FbMrmtMys/sOMZle2BVQaVbhqpqpqnB3Acpa6q54/jEhAQ/kXZg3BLq6FrEnfNMiVk0O3svI+ElmsxLb7KPySycLSQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786932070; c=relaxed/simple;
	bh=A+nlYZ4wSoNGgP/P7s7GETxsdDwsYKZ8QeN7n4Wddqw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eabP1LGmNscUxeisNdDWFjMxnOs2Uces+Q3EfIUVgddNFoUxmC2M1IJ0QcZdVOjXwWGX+flFegvA7Pkf1HsfKFHJh2mcELnGqKES/YIEUaRna+NXehF7eMwgDXKkaNleaV10rMz5zDagjQFygSXUUEWT+jRBHpAW9cfW/9WByN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync3t1786932051t95cc4a56
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.185.99])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3367461735995792584
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<jacob.e.keller@intel.com>,
	<kees@kernel.org>,
	<aleksandr.loktionov@intel.com>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>
References: <D43B3418D188B057+20260811065038.58345-1-jiawenwu@trustnetic.com> <20260814200052.3211538-2-kuba@kernel.org>
In-Reply-To: <20260814200052.3211538-2-kuba@kernel.org>
Subject: RE: [PATCH net-next] net: libwx: rename wx_pf_flags to wx_flags
Date: Mon, 17 Aug 2026 10:00:50 +0800
Message-ID: <007701dd2dec$3a62d3f0$af287bd0$@trustnetic.com>
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
Thread-Index: AQMGtlZzzdg+T58q94wASWbd+i/rYwF8KesqtEKJdQA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NzSDQCFWCzVT+EexulMYnVz0kghtuYH/gH0xWe85XV6qTWoNunm/WPi1
	6U2Wng3HDSxI1flsFfDs6ktpqX+9JwAztwwhHhHi1R7YHyjMgYUfR/TaFDtoeJO5ShjlpdX
	TEI9IbGQM+zlnpXfusCBrkKMmQPjRUc+7Nzp68k0RvwC3a1BOgkLGbFCxeDT0MJJEA66frS
	SrlcG/JU0e7/w4RoIaQCAZkbVs3DZguC0jw5MDWhNH03s1lFoPi2l184hrJ4oGRQM5UQAMp
	M5kW6N+sRdqLTto9Gan1AJCB8Vb4E7m2k4t+Hn5V2xxxOU8MUHWAqudKfHPp+OWuALBFNqs
	EgC3FRGv3kIfmnQ70nzQ7/a44J8qhUL5oyZeGKfqe+GJNXtE8oshBgjodoW4trCyPGhE8AJ
	3JNvvzKVaxyI+e8shl6o2B5MMtH1Vaj6dZP1URSjmtM8Rp6+5LlQz1ZHaKnIkyADm4vyNrL
	IlpBEMZCtr3nMkzf42UJn0ZhV426CW3xHtI/MGImHpjrOS5mQ5FHPNosuignQlFtzQIPniA
	qs0V1xrQgr6PG6nxb9boPNIFU8PgNt+xeOgoU3u1asQQR3kXx4QJ8pDBypfgpjl53aw/4zF
	QwX/vYKzKKQnBFJYV333YUQ6oUh4djJVVAF3jZXFyhWLCTlZWaM7KgaJWEXZ/p/rr8t83/D
	RqXvvb0zjHDRYuv0Y3LfJNSLwlE1hfeDRf4bPllPnRJpnhueFzCuIjPCvLzYRY61D2aDBpz
	2jNtSircJlYFX+Xa6KL094NmJdIfIB9FvtlrZDSEBp+rgMxLR4sdL97S/bBPiwv/DXCeQnb
	khse9v0Hv2WSi+gIjXQGqT36dnPPMLX+nJ02uerjLiDHBCJMJ8iv7insAAbWasHwNtLtYNl
	dMveHHYK4t1Y5F4tpPsyOLu+8nseCwBfMMo0tXwwBHx8pkNHnEkuVYMH8LfV/i8wKUC+70b
	Wwu+qShRxgocMsTIfmMgx6vWklPciga9egSevDFXsIdQ29xPSmVQKw0Q7h7V5Fa1q1VJtsW
	fQLf4YD/jAFeIIaDmKQIFmIsb6rLIhar6VEq7YzOpLFmYPM2Fs
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Sat, Aug 15, 2026 4:01 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Sashiko points out a pre-existing issue. Let's fix it
> first since the rename will conflict with the fix?"
> ---
> net: libwx: rename wx_pf_flags to wx_flags
> 
> This renames enum wx_pf_flags to enum wx_flags and its terminator
> WX_PF_FLAGS_NBITS to WX_FLAGS_NBITS, since the flags are used by both the
> PF and VF drivers.  The three users of the old terminator name in wx_hw.c,
> wx_ptp.c and wx_type.h are updated accordingly.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > index 3eea647c4742c..e35e854652ece 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > @@ -558,7 +558,7 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
> >  {
> >  	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
> >  	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
> > -	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
> > +	DECLARE_BITMAP(flags, WX_FLAGS_NBITS);
> >  	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
> >  	bool is_l2 = false;
> >  	u32 regval;
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but while this local bitmap is
> being touched by the rename: can the copy-in/copy-out of wx->flags in
> wx_ptp_set_timestamp_mode() drop bits that another CPU sets atomically?
> 
> The function snapshots the whole bitmap, changes only the two
> WX_FLAG_RX_HWTSTAMP_* bits in the local copy, programs several registers,
> and then writes the entire bitmap back:
> 
> drivers/net/ethernet/wangxun/libwx/wx_ptp.c:wx_ptp_set_timestamp_mode() {
> 	DECLARE_BITMAP(flags, WX_FLAGS_NBITS);
> 	...
> 	memcpy(flags, wx->flags, sizeof(wx->flags));
> 	...
> 	set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> 	set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> 	...
> 	WX_WRITE_FLUSH(wx);
> 
> 	/* configure adapter flags only when HW is actually configured */
> 	memcpy(wx->flags, flags, sizeof(wx->flags));
> }
> 
> All WX_FLAG_* bits fit in one unsigned long, and every other user in the
> driver updates individual bits with atomic bitops.  Some of those writers do
> not take rtnl, so they are not serialized against the ndo_hwtstamp_set path:
> 
> drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c:txgbe_gpio_irq_handler_aml()
> 	set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
> 
> drivers/net/ethernet/wangxun/libwx/wx_err.c:wx_tx_timeout_reset()
> 	set_bit(WX_FLAG_NEED_DO_RESET, wx->flags);
> 
> drivers/net/ethernet/wangxun/libwx/wx_err.c:wx_tx_timeout_recovery()
> 	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> 
> So a request set between the two memcpy calls would be overwritten by the
> write-back, and the service task would then find nothing to do:
> 
> drivers/net/ethernet/wangxun/txgbe/txgbe_main.c:txgbe_service_event_sfp() {
> 	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
> 		return;
> 	...
> }
> 
> The mirror case is a bit another CPU has just cleared being restored by the
> write-back, for example the clear in wx_err.c:
> 
> 	if (!test_and_clear_bit(WX_FLAG_NEED_DO_RESET, wx->flags))
> 
> which would then look like a fresh reset request.
> 
> Would applying the two bit changes directly to wx->flags with set_bit() and
> clear_bit() after the registers are programmed, instead of copying the whole
> bitmap in and out, work here?

Thanks, I'll send a separate patch to fix it first.
Local boolean variables and assign_bit() will be used here.


