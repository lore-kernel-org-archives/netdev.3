Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800931353B
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464996; cv=none; b=qim8CFPdzMbmE8ARSlylQmUyAkqSVxRFKxpWfAr1FqqRpLEzmahL3F0ELKZFC5lChsP+v1rQ67VMNYwSfQpmrcRYiYAJdv+p73mv4vhTJJZctCtZZS6TP9pcXGrU+uDQkMl/TMTz8Snba5eRR7tyPtu6hNjmznNLXCokXvX+S4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464996; c=relaxed/simple;
	bh=P3mprWukiaXHTbkBDNZZyDnb/7KCSNTuZU4OBWrp550=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CeCoBPcSDxY0RwQ7KAMJhs9UQiip9Hw0ENUfHBfLmYGpeTLUZ8sxFUWCKv75NA2S0RH16w/Ym7KnPn/Nj0Jftf5NZjAjDWdg5QrU6JFlFPJyqNo/NaJhLIqW7lkwYjyZ9l8Y7ZNSw0zqzodPbqPaDoVXBEBVbbFkQzAKhurtqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync9t1785464941td87c0158
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.139.83])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11070488493498952182
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Rongguang Wei'" <weirongguang@kylinos.cn>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260724101309.23472-1-jiawenwu@trustnetic.com> <20260724101309.23472-6-jiawenwu@trustnetic.com> <20260730131908.GB51943@horms.kernel.org>
In-Reply-To: <20260730131908.GB51943@horms.kernel.org>
Subject: RE: [PATCH net-next v12 5/5] net: wangxun: add pcie error handler
Date: Fri, 31 Jul 2026 10:29:00 +0800
Message-ID: <04ee01dd2094$589e7050$09db50f0$@trustnetic.com>
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
Thread-Index: AQIS+4v0YnBoeMVdPoCsylDHc5O5qgHQvQ9rAQboc/i2BGdVYA==
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHvnCg/hm5B0McGl6/SAh1Edh+X6rRFmGmHmhsJ45ZBpZj+EKv1ruWja
	p9kldXZi+NZkUSQU5Yyo/98a/++wTPyw5UVW4HZLdsT/63MC8uGAdXtRbLmxxESAFWPb9JQ
	iX9SVJiThBY8UTUVWIcOIWalhR12pRbhAfKTJtOk1EipNCxcC3YIoj36aTp3m8wU1/WeYPC
	Oc+7TjPLrPVpbyNdYuraNAxMf9l0CIuJ6IB+Ad9oAqb6Q9mrR11VNsDPV8hke9L0V4uaZ2U
	8I3U0ZDwvv8c+HcikyeedusmUGk4zNo1Wnb4i64Cq57cWqPNgU90lzslQsGyvETL1nYGD7G
	L0s7LzP8+Zuboh0oZd3e+Y7cup557qhUhobitfib0wL25+7+O11Tvc9FoKMUjSM+RAJzoiw
	ZHepetGJ2cr6EjZZfjIRjG2tA4ZYmiX8jPX9kcQb2endCp7o6rlq+LXxCHXQlxlTpPPEzvM
	l2+SxzwnkRb83+NQa2sZPDUHa7JZ/5aTOFzLq4h1N+WEBSTmD7a+grrGHaJ0pvrcyNCTJAb
	gCF/7yrWvFk3kQ+9MwAm77Az5eHXcqhlT6jR/iNlRNtdg+ftOfPuTBDW996oPL/efNFD4vq
	8V56Y50MFYEjve8bWq76FsDfrv1RVU600a5tNFwj/VbfPE0pX+r9FxkeJQ9OoCR5aArv+k4
	vXpFRbBPTl7EVyjjf36IuD+ROsr80R2S1YVXEDPaR4gg1nMdW6JQ1wzvrxoH7RqU/SRW2u5
	7mrqlRqlmPkwA4deCLVVFxOxK0UI3rzUVTBNEiE9cOgffOZDHY0fcOW4k7D2k/9b4WivBlf
	40bCxOeZb/O2Hc44LD/ljdh/C2R/3u+Z0jMZPF4RFLS8DruWEME6juQVVEZlQ2WH8OQm3E1
	ZmTy88MSQvQ/kYgE1PA15mgmfb0UF+WFPU6lLe7TZxDhJSeHvzs4+OLlROlMvCLnLRcJb+V
	hNyw8A/mFH44RZuGUw3FZcuxVCCPKywWdMNJNHGvD0tYY8rcZ2cUi5EZsmBTR3qR2SRhSlK
	QVuLJ3ISz44ga7UlpnACL2Kd8WaFaH7aeXeh94vdqVRQZEjUNdt1m/xo9ZnmKTg4lJs++W+
	SWQSAUvglhzakzGo3iAmimKtLzvDYPCRQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

On Thu, Jul 30, 2026 9:19 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260724101309.23472-2-jiawenwu@trustnetic.com?part=5
> ---
> --- Patch [5]: [PATCH net-next v12 5/5] net: wangxun: add pcie error handler ---
> commit bbdaff8533430e43d4fe6382b836808684487044
> Author: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> net: wangxun: add pcie error handler
> 
> Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
> Tx timeout happens before the AER error report when a PCIe error occurs,
> CPU blocking would be caused by MMIO during the reset process. To
> prevent it, check PCIe error status in .ndo_tx_timeout. The current
> function of ngbe is not yet fully developed, it will be completed in the
> future.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > index ee27f96735dc7..7936845c2894c 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> 
> [ ... ]
> 
> > @@ -139,6 +253,33 @@ void wx_check_hang_subtask(struct wx *wx)
> >  }
> >  EXPORT_SYMBOL(wx_check_hang_subtask);
> >
> > +static bool wx_check_pcie_error(struct wx *wx)
> > +{
> > +	u16 vid, pci_cmd;
> > +
> > +	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
> > +	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
> > +
> > +	/* PCIe link loss or memory space can't access */
> > +	if (vid == U16_MAX || !(pci_cmd & PCI_COMMAND_MEMORY))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void wx_tx_timeout_recovery(struct wx *wx)
> > +{
> > +	/*
> > +	 * When a PCIe hardware error occurs, the driver should initiate a PCIe
> > +	 * recovery mechanism. However, this recovery flow relies on the AER
> > +	 * driver for current kernel policy. Therefore, a self-contained
> > +	 * recovery mechanism is not implemented yet.
> > +	 */
> > +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +	wx_err(wx, "PCIe error detected during tx timeout\n");
> > +	queue_work(wx->reset_wq, &wx->reset_task);
> > +}
> 
> [Severity: Medium]
> Can a race condition between this timeout handler and concurrent AER recovery
> permanently disable the device?
> 
> If the timeout handler detects an error but is delayed, AER recovery might
> complete in the meantime, clearing the recovery flag and restoring the
> device.
> 
> When this delayed handler resumes, it would blindly set
> WX_FLAG_NEED_PCIE_RECOVERY and queue the reset task. This would cause
> wx_reset_task() to unconditionally call wx_soft_quiesce() on the freshly
> recovered device, leaving it permanently unresponsive.

I believe the window for this race condition is extremely small and the probability
of hitting it is very low. But I'll add a double-check mechanism in wx_reset_task()
to verify the PCIe error status before calling wx_soft_quiesce().

> 
> > +
> >  static void wx_tx_timeout_reset(struct wx *wx)
> >  {
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
> > @@ -529,12 +548,16 @@ static int ngbe_close(struct net_device *netdev)
> >  {
> >  	struct wx *wx = netdev_priv(netdev);
> >
> > +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> > +		goto out;
> > +
> 
> Simon says: I believe the issue below this was raised in the review of an
> 	    earlier version, and changes were made to address it. But could
> 	    you take another look?
> 
> [Severity: High]
> Does bypassing wx_ptp_stop() here leak the PTP clock device and cause a
> use-after-free?
> 
> When an AER error triggers a slot reset, wx_io_slot_reset() invokes
> ngbe_down_suspend() which sets WX_STATE_RES_FREED but does not call
> wx_ptp_stop().

wx_ptp_quiesce() was invoked in wx_io_error_detected(), which destroys clock device.
I think wx_io_error_detected() is called first when an AER error occurs.

> 
> If the device is subsequently closed, this check causes the driver to skip
> wx_ptp_stop(). The driver memory is then freed while the kernel PTP subsystem
> retains a dangling pointer to the destroyed clock device, which will panic
> upon any subsequent userspace access.
> 
> >  	wx_ptp_stop(wx);
> >  	ngbe_down(wx);
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index 11ac4b04f5ee3..582ee567e6b9c 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> 
> [ ... ]
> 
> > @@ -538,12 +557,16 @@ static int txgbe_close(struct net_device *netdev)
> >  {
> >  	struct wx *wx = netdev_priv(netdev);
> >
> > +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> > +		goto out;
> 
> Simon says: ditto
> 
> [Severity: High]
> Similarly, does bypassing wx_ptp_stop() here leak the PTP clock device
> and cause a use-after-free?
> 
> Just like in ngbe_close(), if an AER error triggers a slot reset,
> wx_io_slot_reset() invokes txgbe_down_suspend() which sets
> WX_STATE_RES_FREED without calling wx_ptp_stop().
> 
> If the device is then closed, this bypasses the cleanup, leaving the
> kernel PTP subsystem with a dangling pointer to the destroyed clock device.
> 
> Simon says: I think the issue below can be looked at in the context
>             of possible follow-up.

I'll consider handling this in another patch.

> 
> [Severity: High]
> This is a pre-existing issue, but does failing to open the device in
> txgbe_open() lead to a NULL pointer dereference on subsequent open attempts?
> 
> If txgbe_open() encounters an error, the error path calls
> wx_reset_interrupt_capability(), which frees wx->msix_q_entries and sets
> it to NULL.
> 
> If a user subsequently attempts to bring the interface up again,
> txgbe_request_queue_irqs() is called, which dereferences the NULL
> wx->msix_q_entries array.
> 
> >  	wx_ptp_stop(wx);
> >  	txgbe_down(wx);
> 

