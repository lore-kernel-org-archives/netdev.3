Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5143EA66
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454791; cv=none; b=KXlBeNBTfx73gNBWVjetVUlGgaMXEZfksFB5IqDrD9g2/kPvDZ8wyBwANROqi4kb62flXw14mUVwsS5IUbBqRRLBE5godEld8t5jJqBU2pS8L+dUr/qtfl3LUKn/Pjg2d/gnh5Jwuz3Pw5JkmcWTwpMygW7B+VjoXSUlfFOjvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454791; c=relaxed/simple;
	bh=EKkZ9NgeWytPsAiYzn2nCZ/RZY092F6evb083BOCwxM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lJYNbxUCV5qwSrPpeUfoh1RlyVOQbh9grkIrcynXvipJCKkKdSk3PItlzEZaLmINRZA4mIIpXoT2IcEs0xoKZjV2MrbaREOahFt+QVAUmLV0YP2hZaKpquQyw4i9OxEhSZ8rWrHu1DVSMifBTtZQYEmSGRLKq+75bqJZsctIt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1780454715t664t06745
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.207.111])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1858584479734954077
To: "'Larysa Zaremba'" <larysa.zaremba@intel.com>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com> <20260601072221.2952-5-jiawenwu@trustnetic.com> <ah67geY9bPEbSKkX@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <ah67geY9bPEbSKkX@soc-5CG4396X81.clients.intel.com>
Subject: RE: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce callbacks for AER recovery
Date: Wed, 3 Jun 2026 10:45:14 +0800
Message-ID: <095901dcf303$016303f0$04290bd0$@trustnetic.com>
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
Thread-Index: AQEmZmPiFxLXVQw6wm5cjAUm9/PfJgGkmD0MAfjSC2G3fEh1EA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N879q09ZcJuCCCE/2OM2Kd7sr2zLImBBhvcd/4twOBFOaD1zSodKJvkg
	2eLnO6qjNIRoTOwCxmC1/l6cmf9WDKIOqZSJHMhUseAOWRbwbBTzkaPcS4xoiGvKo0PptCu
	BqLLFgKyV1jj85gpbPVfV3C0aMyz4CJTl8Z4jmxkJrrc9cZydj4i+HKSb9k7APjomwJRzhV
	rb5JvklotZDCURUO7WVbBAn3wvZ3nFiLOC0wRqjQ/nU7KL4VioTkpInhmRsRa3bKzwo1+VS
	2w1+NMfvDydI6pfzBdAbNfHAL9BK3KlEUWDFBfuzz9fJHrxvisZBsPOCm/TPXHPTf2wNqrD
	kHu2GUYrJmzrmykityz/b0AB688ryFlXJ1qQF3mA8T4oryGaDOa/yKU8w0ce2R/MM14PidK
	GzW9utnutDHuc7aMxGguMBPgGjzm9KurRz3tqrwfE9rhhazlWi5FzwL3H/pORUFO7X6icCK
	9ctD0VgIey3nT3Vwo0SRdEPc4jAeOQmwv6cEEbvxVHpp1fnciMvuhB/ev1eQVt8vb/Vq7KQ
	FUeGFQMpJbwodgNSu1eBcoZng3VZ+2sICeujjZ0Sip8m135sR7IPIJDgux5ZmBTdFLoGxol
	KDhFOUvAT0EKdC75Kfbd/pLi5JTb4yYRitpDLRyIN5NRRYunYjohqPJxWYtOQMdvF/mwzjl
	uPGbisk2bX/S0+vw1ao1snOoLYwIVqnFYj9u84Zk6qulBpRGYDfTiMQII3PJI6sY+mjoGH/
	w4xhLzX4UTOxo19jfeVCmZNwTtRUs2l3AgahThY3XEWsCPSZ42V9mOuvEXFo8QlzVIAkmXh
	soLcxvuHLHVmracTmKYW8EluRelUAuxji9pRAnWyHnUW7lcSGL8qQ215cAIspr8CbaqyxCJ
	SdBx2vCBAWmzEJLCAB3gca9sqgbn4r5AvoQ8e78MdDHUHsxb2zQgEWm+JRHT880yDjZU+AQ
	2MunmrIQTPtU7BXJOWqpfGn9MJFUODbO9RlQuszwblSzHdeMclmNyomoqlbQn6KwtEhCZc/
	i2xIObaKtk3D3w02mkcvddgt+mytq7g1UpXmUiLdFEA7WlYMzKjrtPC1OEDN1wJJkjXbeL8
	g==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Tue, Jun 2, 2026 7:16 PM, Larysa Zaremba wrote:
> On Mon, Jun 01, 2026 at 03:22:20PM +0800, Jiawen Wu wrote:
> > Introduce device-specific soft quiesce callbacks for ngbe and txgbe to
> > provide a lightweight shutdown path during PCI error recovery. It avoids
> > MMIO-dependent operations in PCI error status, for the later
> > implementation of PCIe error callback function in libwx.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 23 +++++++++++++++++++
> >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 ++++++++++++++++++
> >  3 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > index a8b4e84787f4..1b25a52188f7 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > @@ -1409,6 +1409,7 @@ struct wx {
> >  	void (*configure_fdir)(struct wx *wx);
> >  	int (*setup_tc)(struct net_device *netdev, u8 tc);
> >  	void (*do_reset)(struct net_device *netdev, bool reinit);
> > +	void (*soft_quiesce)(struct wx *wx);
> >  	int (*ptp_setup_sdp)(struct wx *wx);
> >  	void (*set_num_queues)(struct wx *wx);
> >
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index 3dc8342dd3a7..2484d3177034 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > @@ -47,6 +47,28 @@ static const struct pci_device_id ngbe_pci_tbl[] = {
> >  	{ }
> >  };
> >
> > +static void ngbe_soft_quiesce(struct wx *wx)
> > +{
> > +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> > +		return;
> 
> Careful about reusing the same flags for different reinit processes.

I think WX_STATE_DOWN should be used here.
The soft_quiesce calls back only in pcie error handler when netif is running.
It is desired to implement all software quiesce on the device close path.

> 
> > +
> > +	wx_ptp_stop(wx);
> > +	phylink_stop(wx->phylink);
> > +	pci_clear_master(wx->pdev);
> > +	wx_napi_disable_all(wx);
> 
> Sashiko says:
> 
>  "If NAPI is not disabled yet, the NAPI poll routine wx_clean_tx_irq() can run
>   concurrently. If WX_STATE_PTP_TX_IN_PROGRESS is set, wx_clean_tx_irq() might
>   call ptp_schedule_worker(), leading to a dereference of the ptp_clock
>   object just as it's being freed."
> 
> I am not sure, if such race actually happens, but stopping napi before any kind
> of deinit is not a terrible idea.

WX_STATE_PTP_TX_IN_PROGRESS is cleared in wx_ptp_stop().
But I'll change wx_ptp_stop() to wx_ptp_quiesce() that drop all MMIO operations.

> 
> > +
> > +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> 
> Same here, what if a caller needs a full reset?

PCIe error handler has a higher priority and it will achieve a more complete
reset. In fact, these two resets are not expected to be executed at the same
time.

> 
> > +	timer_delete_sync(&wx->service_timer);
> 
> Sashiko says:
> 
>  "The timer is stopped, but the corresponding cancel_work_sync(&wx->service_task)
>   is missing."
> 
> And it does seem to me that this is the case here. I see that you have explained
> this in another thread, but you proposal does not address the case, when
> ngbe_service_task() starts, interface is not down, and after that we have a PCI
> error, and its handling interferes with service task. While this is unlikely,
> synchronization should be more robust.

I plan to check WX_STATE_DOWN and WX_STATE_RESETTING at the entry of every work
item. Looks like a rough block, but is there a better way? :(

> 
> > +
> > +	wx_clean_all_tx_rings(wx);
> > +	wx_clean_all_rx_rings(wx);
> > +
> > +	wx_free_irq(wx);
> > +	wx_free_isb_resources(wx);
> > +	wx_free_resources(wx);
> > +	phylink_disconnect_phy(wx->phylink);
> > +}
> > +
> >  /**
> >   *  ngbe_init_type_code - Initialize the shared code
> >   *  @wx: pointer to hardware structure
> > @@ -135,6 +157,7 @@ static int ngbe_sw_init(struct wx *wx)
> >  	wx->mbx.size = WX_VXMAILBOX_SIZE;
> >  	wx->setup_tc = ngbe_setup_tc;
> >  	wx->do_reset = ngbe_do_reset;
> > +	wx->soft_quiesce = ngbe_soft_quiesce;
> >  	set_bit(0, &wx->fwd_bitmask);
> >
> >  	return 0;
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index b37c9ed57cf7..816aba4a9099 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > @@ -296,6 +296,27 @@ void txgbe_up(struct wx *wx)
> >  	txgbe_up_complete(wx);
> >  }
> >
> > +static void txgbe_soft_quiesce(struct wx *wx)
> > +{
> > +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> > +		return;
> > +
> > +	wx_ptp_stop(wx);
> > +	phylink_stop(wx->phylink);
> > +	pci_clear_master(wx->pdev);
> > +	wx_napi_disable_all(wx);
> > +
> > +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> > +	timer_delete_sync(&wx->service_timer);
> > +
> > +	wx_clean_all_tx_rings(wx);
> > +	wx_clean_all_rx_rings(wx);
> > +
> > +	wx_free_irq(wx);
> > +	txgbe_free_misc_irq(wx->priv);
> > +	wx_free_resources(wx);
> > +}
> > +
> >  /**
> >   *  txgbe_init_type_code - Initialize the shared code
> >   *  @wx: pointer to hardware structure
> > @@ -412,6 +433,7 @@ static int txgbe_sw_init(struct wx *wx)
> >
> >  	wx->setup_tc = txgbe_setup_tc;
> >  	wx->do_reset = txgbe_do_reset;
> > +	wx->soft_quiesce = txgbe_soft_quiesce;
> >  	set_bit(0, &wx->fwd_bitmask);
> >
> >  	switch (wx->mac.type) {
> > --
> > 2.51.0
> >
> 

