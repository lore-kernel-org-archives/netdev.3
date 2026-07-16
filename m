Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041727FD4F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185015; cv=none; b=lfNKnHD2zlHKnU7V8QRgnGHuHcuo3Eaa9twsEYo1TtIfo61dx8K2VsP1/biJ+DtufwVlkLCTP6OzVtC5icD6Kl+q+YIyZtFW0vEHE9w9EcyJ+FMPWwgIag5IpvSztlHzU1lE6Cm8NbgyIcdgPA2d0ChJo546831Blsss1ndX2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185015; c=relaxed/simple;
	bh=i3Ju16rcU4ecP/jxNFoioonLPru0ESo8QaGLQyksqtM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSST5RVSHoodo/67iBEW5YhO9kW9lVfd/jcx70IfO3p7RvIo/m3rWXkGyUAvQVW0yXCa2OwuWMnODrETCENgX6uj18Nv/kWXygPRFVQxd5KrQyip6FT5n3xQSY1w4/75SHS3AyyO8vtd0eJvnux25HIiJqD5ynINonHSBPCgmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync8t1784184931t362d7dd6
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.247.46])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4423270412133220589
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<aleksandr.loktionov@intel.com>,
	<jacob.e.keller@intel.com>,
	<michal.swiatkowski@linux.intel.com>,
	<kees@kernel.org>,
	<joe@dama.to>,
	<leitao@debian.org>,
	<shaojijie@huawei.com>,
	<u.kleine-koenig@baylibre.com>,
	<weirongguang@kylinos.cn>,
	<larysa.zaremba@intel.com>,
	<fabio.baltieri@gmail.com>
References: <20260707061455.39564-6-jiawenwu@trustnetic.com> <20260714091129.1815871-1-horms@kernel.org>
In-Reply-To: <20260714091129.1815871-1-horms@kernel.org>
Subject: RE: [PATCH net-next v10 5/5] net: wangxun: add pcie error handler
Date: Thu, 16 Jul 2026 14:55:30 +0800
Message-ID: <0ecb01dd14f0$17488c80$45d9a580$@trustnetic.com>
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
Content-Language: zh-cn
Thread-Index: AQEnm0a43WP6ur8fLrbjt0gO/NQ3DQGfni8Et82oB7A=
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NRLj+a+1JRyJpouuvsTRzSIbZuCIj5qpiVUOZ5fKpUyeZx82EQRGVwVp
	UFKc8JHylizS74WbWkpjPSLCrwZetR2fKvpvJiBBT9puHiYWAiJLvhsAGz7vipmr9ldZEh9
	v4OrVKk4VXZmYvxGGcYe7n58qFIHR6m08QGgiSmkDSfwThdnUQZp6y+dKyN/azQ7+N0vUw1
	enR/icwIq3HeH68h2n+uQFH0DrYf0O9YiFGiLQsL0D+3p/0y/2LE04QC36JAYV0dyE9sabP
	2NjHVj2LxiGmSeUD05IUup+0ndwQb+XBjisNvvZFWCi+wupjaSg8tTB/lf+MHYOF6fHoor8
	gTmc9mrq7kbwoa+2qxHRCvfBECsCxIkIRjSCmL/8iSgUVHJg5lD2ifwLgXRPdO9zbxhROXk
	jhaSp/CGg+N15XUjjXiJuYhy/sXH9P6p03IsP/IGikRgZGzUqSY9epDzu4R3/E7oA1oKcoH
	a/uALxw1vn9q1wFQ3IJfB9Vo4DfCIfUixxoH1/c+rHbAXznTi7xMlGM8Tpntg/UwzHxu64t
	1TwJeMHLQKb+l/D9EEjy3vdPvPn8HNF5d1gKEihpnds/A7vJnV87OgDwka/2qmCY7zfmdB7
	gA8NVt+z0FmkZzZ3GgIwfjanUyyQiddfUEeBlSm5fo6I2TehI57qukUKtgmOB+r3rOxzAtp
	YdEdtppBx6AbDHQDz2p6dfT+5nwQXvTuYNN1pqCrlbEP7OPmjLXcRZhXeYlrFYtO47D+n+O
	MQRRcqODE/Ex+5q4DvFPlwd3DlOx1ybaDfJODX4OaPKBcSuS4+9kg8HwnfrtP8xOgl418WN
	v8vHEBJQ2llqI91fvFb/wFvi/dQUPzWGh5gCudX4MDiuvXxa4r9Kk3yKL1FyWJWIkg4uzu2
	KjqqLdF9iEgoGrmu7otRG/ODzB9qsEnuls7lxPTl5R6HrVmPqN3YTgd+br+UjNUJKjiJQwY
	N72omnkcHREtiUJfu24NlooT8un5ZJWmfGVk2dzw/XMWfOPhL81SuSYWlhJy6WAbPPo5m5J
	fKKb9E1zBH0bQEIOpuDDspUVMJtuODE9qKfTeWNDRE3FgWHCyLfXN9Gjdb//cHgaOtp+pnr
	zYFsZvR2hnXR+Dj4m3Ep7A=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

On Tue, Jul 14, 2026 5:11 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [5]: [PATCH net-next v10 5/5] net: wangxun: add pcie error handler ---
> commit 91baa4e77d07ab6772569a7d37ed86cfda625c00
> Author: Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: net: wangxun: add pcie error handler
> 
> This commit adds PCIe error handling support (AER) to the wangxun drivers
> (ngbe and txgbe). It detects hardware errors, attempts to soft quiesce,
> and registers standard PCI error handler callbacks.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > index ee27f96735dc7..0cb99e456a1c9 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> 
> [ ... ]
> 
> > +static void wx_io_resume(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +	int err;
> > +
> > +	netdev = wx->netdev;
> > +	rtnl_lock();
> > +	if (netif_running(netdev)) {
> > +		err = netdev->netdev_ops->ndo_open(netdev);
> 
> [Severity: High]
> Does this sequence risk corrupting the hw_tc_lock seqlock?
> 
> During AER recovery, wx_io_slot_reset() calls down_suspend(), which bypasses
> wx_ptp_stop(). This leaves the PTP clock registered and potentially in use by
> userspace.
> 
> When wx_io_resume() then calls ndo_open(), this triggers txgbe_up() or
> ngbe_up(), which in turn calls wx_ptp_init(). Since wx_ptp_init()
> unconditionally calls seqlock_init(&wx->hw_tc_lock), won't this corrupt the
> lock if userspace is actively issuing PTP ioctls?

PTP clock was destroyed in wx_ptp_quiesce() before V8 patch set.
The piece of code was removed based on the Sashiko's comment.
I think it should be added back because the order of the calls in wx_soft_quiesce()
has been changed.

> 
> > +		if (err) {
> > +			wx_err(wx, "Failed to open netdev after reset\n");
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index 92895f5035118..56d4b63387fd6 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> 
> [ ... ]
> 
> > @@ -413,6 +428,9 @@ static void ngbe_disable_device(struct wx *wx)
> >
> >  static void ngbe_reset(struct wx *wx)
> >  {
> > +	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
> > +		return;
> > +
> >  	wx_flush_sw_mac_table(wx);
> 
> [Severity: High]
> Is the hardware properly reinitialized here after an AER slot reset?
> 
> In wx_io_slot_reset(), the hardware needs to be restarted from scratch.
> While txgbe_reset() calls txgbe_reset_hw(), ngbe_reset() only flushes the
> software MAC tables and skips calling ngbe_reset_hw().
> 
> Because this patch registers wx_err_handler for the ngbe driver, won't this
> leave the hardware uninitialized and the interface broken after a PCIe slot
> reset?

I think I have answered this question many times and also described ngbe's lack
of functionality in the commit and cover-letter messages.

> 
> [ ... ]
> 
> > @@ -529,12 +548,16 @@ static int ngbe_close(struct net_device *netdev)
> >  {
> >  	struct wx *wx = netdev_priv(netdev);
> >
> > +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> > +		goto out;
> > +
> >  	wx_ptp_stop(wx);
> 
> [Severity: High]
> Does this early return cause a use-after-free for the PTP clock?
> 
> If a PCI error occurs, down_suspend() sets WX_STATE_RES_FREED but
> intentionally skips wx_ptp_stop(). If the interface is subsequently closed or
> unregistered, ngbe_close() will return early here and never call
> wx_ptp_stop().
> 
> Because the PTP clock device is never unregistered, it remains exposed to
> userspace after the driver's memory is freed. Can this lead to a
> use-after-free if userspace interacts with the clock later?
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index a7bde03a98feb..d85ee83192e4f 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> 
> [ ... ]
> 
> > @@ -530,12 +549,16 @@ static int txgbe_close(struct net_device *netdev)
> >  {
> >  	struct wx *wx = netdev_priv(netdev);
> >
> > +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> > +		goto out;
> > +
> >  	wx_ptp_stop(wx);
> 
> [Severity: High]
> Similar to ngbe_close() above, does this early return skip wx_ptp_stop() and
> lead to a use-after-free if the txgbe device is closed after an AER suspend?
> 

