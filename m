Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAB3B3C1F
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288467; cv=none; b=Z4fsxVeEHmvdfItcoC38yHCSJqZLHFHNdxUzfLq7aiGtBVQRZ6ZJ9/dV3K2eERqewRekq4oA4zaSDaRkdEz/g5PbrUO/RFkHrCXxUl2zxiYpRqRb9uKn/x3MfwF2JCX26SSdGHtODQO4balSmqMvVoN5AjNHYz/my1blJO6TCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288467; c=relaxed/simple;
	bh=j3uuyFppsM78ScOuEVLyKyW4kJd4D1z8nnUFmf8NBCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcn4CtQ6hC9cWQ5mRZC+59O/19tVdt8zf/e9ztbUYGjQ1WtTdHE+jLLRDo0HH8ecXpvlJ0t1BR7iich+4bTxEroxVau7fYmHkRboydCv0vUZDJbGRoa0OtUEVxck2YMgC7xyxxNyLpr4vgtNvA5eDJNi4N7ztM91rd1QRTjq+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq3I0UP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq3I0UP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352621F00A3A;
	Fri, 17 Jul 2026 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784288463;
	bh=cIzMN4306X7NLudADecXammvcEsgxmX6qbWfhmbLqP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eq3I0UP9rVWzD/YfyCpm+hYLhX5QPGeKQOEdmVo+k/AYQE0zhq1Uj20ENzT8k/A2J
	 pHCvw7fyI/a4qXvPPXy2FG6kaMsIU05dXe7ovqr1wIeks1g2K+hnCsZoTFDkdiT405
	 U4YFJLfAqxPAHTDiKaHrIhnrxQSFxbz9i6BjTNnBwiwXy+NZt6fCtuKcAJ+2e1DWXg
	 Ybdn2aB+iwcFmVvA6FS5fLwPUViZMlgp9Yzu6i7GgWhLkbpu7IBqmCKlFRJuEigq9F
	 FdtQmcEOxJF97L5og2d3gn1cBD3+UzOyU4nxrX4pu+GMK0rCMwL14HiOR1iiyQQ111
	 u3YJ7sG1Mz4mA==
Date: Fri, 17 Jul 2026 12:40:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	linux@armlinux.org.uk, aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com, michal.swiatkowski@linux.intel.com,
	kees@kernel.org, joe@dama.to, leitao@debian.org,
	shaojijie@huawei.com, u.kleine-koenig@baylibre.com,
	weirongguang@kylinos.cn, larysa.zaremba@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v10 5/5] net: wangxun: add pcie error handler
Message-ID: <20260717114056.GN95246@horms.kernel.org>
References: <20260707061455.39564-6-jiawenwu@trustnetic.com>
 <20260714091129.1815871-1-horms@kernel.org>
 <0ecb01dd14f0$17488c80$45d9a580$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ecb01dd14f0$17488c80$45d9a580$@trustnetic.com>

On Thu, Jul 16, 2026 at 02:55:30PM +0800, Jiawen Wu wrote:
> On Tue, Jul 14, 2026 5:11 PM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > --- Patch [5]: [PATCH net-next v10 5/5] net: wangxun: add pcie error handler ---
> > commit 91baa4e77d07ab6772569a7d37ed86cfda625c00
> > Author: Jiawen Wu <jiawenwu@trustnetic.com>
> > Subject: net: wangxun: add pcie error handler
> > 
> > This commit adds PCIe error handling support (AER) to the wangxun drivers
> > (ngbe and txgbe). It detects hardware errors, attempts to soft quiesce,
> > and registers standard PCI error handler callbacks.
> > 
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > > index ee27f96735dc7..0cb99e456a1c9 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > 
> > [ ... ]
> > 
> > > +static void wx_io_resume(struct pci_dev *pdev)
> > > +{
> > > +	struct wx *wx = pci_get_drvdata(pdev);
> > > +	struct net_device *netdev;
> > > +	int err;
> > > +
> > > +	netdev = wx->netdev;
> > > +	rtnl_lock();
> > > +	if (netif_running(netdev)) {
> > > +		err = netdev->netdev_ops->ndo_open(netdev);
> > 
> > [Severity: High]
> > Does this sequence risk corrupting the hw_tc_lock seqlock?
> > 
> > During AER recovery, wx_io_slot_reset() calls down_suspend(), which bypasses
> > wx_ptp_stop(). This leaves the PTP clock registered and potentially in use by
> > userspace.
> > 
> > When wx_io_resume() then calls ndo_open(), this triggers txgbe_up() or
> > ngbe_up(), which in turn calls wx_ptp_init(). Since wx_ptp_init()
> > unconditionally calls seqlock_init(&wx->hw_tc_lock), won't this corrupt the
> > lock if userspace is actively issuing PTP ioctls?
> 
> PTP clock was destroyed in wx_ptp_quiesce() before V8 patch set.  The
> piece of code was removed based on the Sashiko's comment.  I think it
> should be added back because the order of the calls in wx_soft_quiesce()
> has been changed.

Thanks.

> 
> > 
> > > +		if (err) {
> > > +			wx_err(wx, "Failed to open netdev after reset\n");
> > 
> > [ ... ]
> > 
> > > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > > index 92895f5035118..56d4b63387fd6 100644
> > > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > 
> > [ ... ]
> > 
> > > @@ -413,6 +428,9 @@ static void ngbe_disable_device(struct wx *wx)
> > >
> > >  static void ngbe_reset(struct wx *wx)
> > >  {
> > > +	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
> > > +		return;
> > > +
> > >  	wx_flush_sw_mac_table(wx);
> > 
> > [Severity: High]
> > Is the hardware properly reinitialized here after an AER slot reset?
> > 
> > In wx_io_slot_reset(), the hardware needs to be restarted from scratch.
> > While txgbe_reset() calls txgbe_reset_hw(), ngbe_reset() only flushes the
> > software MAC tables and skips calling ngbe_reset_hw().
> > 
> > Because this patch registers wx_err_handler for the ngbe driver, won't this
> > leave the hardware uninitialized and the interface broken after a PCIe slot
> > reset?
> 
> I think I have answered this question many times and also described
> ngbe's lack of functionality in the commit and cover-letter messages.

Sorry about that, I missed that this is already covered.

...
