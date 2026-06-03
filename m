Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25F191F98
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455144; cv=none; b=Y7kFJCo/VCEFu9bTYmcqyX5FPabrusjBnugLVFH56Dxb6bs4t8F50BQK9pF7kVh6N/OpCsXqce8RQRL2LFOd4wCbob0Nn17IaswuFCWw3KgaTPa26mzHRKoh664hg4k+oqDfZ+6rnVJPxJPcxuzdQf80x8WrXd0zuwHuMbw6YdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455144; c=relaxed/simple;
	bh=Q6eR0SAT/uKHN/6h7YuGqZBEURlSyy2gNsq2bj3TXiY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kh5s9wC7t9BNOoMkUBFdidrGG3yFC92JBrskoM7oj6AWyDSJf/I+7nvKPh7GYdYutYKCFtOn5kIHBGm4jGanodHZCl8y4LWHAkrzm0FSyWasOZJZeqK/8/7/IXUwm1vCDCzyENGzOaqWBvlJgEn7KxhjPxftnCV3TA2IVXvzjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas8t1780455089t594t31214
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.207.111])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 486067191020761161
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
References: <20260601072221.2952-1-jiawenwu@trustnetic.com> <20260601072221.2952-6-jiawenwu@trustnetic.com> <ah6-x9CJHwxh_3Qt@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <ah6-x9CJHwxh_3Qt@soc-5CG4396X81.clients.intel.com>
Subject: RE: [PATCH net-next v4 5/5] net: wangxun: implement pci_error_handlers ops
Date: Wed, 3 Jun 2026 10:51:28 +0800
Message-ID: <095a01dcf303$e03d08a0$a0b719e0$@trustnetic.com>
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
Thread-Index: AQEmZmPiFxLXVQw6wm5cjAUm9/PfJgEIHjjLAbXhlRG3g0pdsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MKut7GF+UZm9gj21eL6U7wzx7XMwbtj1SL/jq616fwfP5IKufGn3D5l3
	pse0sxhBzsDeHA+Rg8HJHa7VOKg7K7lVhfq9ipnMwnetTIb5F/G/wypWuPtpuTUv+LW1yFz
	s62FfErEB4iDbAMWpTWrFFSYBASdJJ3MFJf5kLyL8xvURAGzjaJ5hhLF9grTJk2Z/4GOHci
	ZlNnEmhQSgTz1G/Ih0DBRUxPH2rRYH6USI/BmpygmjZhCtC+eZUtYF3k/k+QCKm3qqH14Pa
	Nv5DZmPhpu71MpBPW/XLjH3kC5HakPCPbc6KY29LBqBiDNxINaPLLvrybZI0XilV/4g1onT
	EyX3y/ZsIbUbHlEJOvBJTFIW0ewAVSpKRBpXWZo4nsUMfPzzfAqp7bGKqOqo4jzGBThWvm4
	/6mEBLLMC4bABU7o5ug0M7JnxkvYcb/IFScfhAsJXuMHWlEPm0a/Rn3xO9NC7NoAbEVx8zM
	Pk3WDpAKET20weOu4YQiU8qmtefBPAq7Mim5cYljqXq9QkvznYhrzn7EPGhA+ST87IQ/hYx
	/jaC7Mp29duKkpvtYcT7jMK001WloKOsZqF+/H/UG52e4R7tHFIyyA4judGbcLphxoGet7w
	fHIgPSh4AT1wRtCSAaQCMUFbzMB19h0qu1W2ZizYlzeqURaN4w3kjOPywENbdrcLmdM3wgq
	RF2s4xcmXFYHbVAG+DxIqV3RhJ99aKSo9ycTvXEIbthoPpZNCSHtLjgpGkDkZHqWJNLhB66
	CNWte4XCPtkGI6RReQLV7COeBzO4a8XbOQGlnsTIwJ/htE5RO5a8W2bk35Cb9ZbZGHzeCPA
	UC8CmY75sz+mrR3hkTjXwWIgrYuBRxPSMddChFbWCdsNe8OcLpMq84PtLMoYs3SSoga5E9W
	8nctKyl+t/V/Nk7Df1tXDmiyTDyLHs0yH9xczTuSoyXA146Mm6ySlZzh3uTni2NZTedv5Er
	Kl17aQmR3hOq/LC+e3FkAsYHs0PoWQnQOmjNTW/Vru71AmCBn8Ja359e+YmzGFAuHOxsgbR
	DAbn9BRp5zyBRPkb08imnEcN+om/jH+24kw7Is1SYExf1fVTDGQkTWxB9xzMDGFTrjqyrYv
	MlbcpR0MEqS03znEUvjjueFHlZboMNtDXLuKlxvIEZFpHWJX4NC6/Tv4blE1QC0sA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Tue, Jun 2, 2026 7:30 PM, Larysa Zaremba wrote:
> On Mon, Jun 01, 2026 at 03:22:21PM +0800, Jiawen Wu wrote:
> > Support AER driver to handle the PCIe errors.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_err.c   | 111 ++++++++++++++++++
> >  drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   9 +-
> >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 +-
> >  5 files changed, 127 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > index e249cea874be..ae5d14071f3d 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > @@ -4,11 +4,122 @@
> >
> >  #include <linux/netdevice.h>
> >  #include <linux/pci.h>
> > +#include <linux/aer.h>
> >
> >  #include "wx_type.h"
> >  #include "wx_lib.h"
> >  #include "wx_err.h"
> >
> > +/**
> > + * wx_io_error_detected - called when PCI error is detected
> > + * @pdev: Pointer to PCI device
> > + * @state: The current pci connection state
> > + *
> > + * Return: pci_ers_result_t.
> > + *
> > + * This function is called after a PCI bus error affecting
> > + * this device has been detected.
> > + */
> > +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> > +					     pci_channel_state_t state)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +
> > +	if (!wx)
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	netdev = wx->netdev;
> > +	if (!netif_device_present(netdev))
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	if (state == pci_channel_io_perm_failure)
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	rtnl_lock();
> > +	netif_device_detach(netdev);
> 
> Sashiko says:
> 
>  "Calling netif_device_detach() stops new packets from entering the TX queue but
>   doesn't wait for currently executing ndo_start_xmit operations to complete,
>   which netif_tx_disable() would do."
> 
> Device detaching does not grab __netif_tx_lock(), so it does seem like
> netif_device_detach() leaves some race possibilities.

netif_tx_disable() is missed in soft_quiesce(). I'll add it.
 

