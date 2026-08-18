Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232D3812DB
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017878; cv=none; b=iWJWx+mclLAYVaZ8eXO+bnud7C77UYLMQp/QKgGGXgsZe/Pan7m69vnF3rQsMZl987vF+GAbhi7h3ljrhNlsv3qagHVeA0PG5No/eLZzMQCmfx2CUnsF9MysDhpwrLIFv6cMETNPtDOg7aWiKvxT/Qj+9UbqoTGLqKHLGJ8djRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017878; c=relaxed/simple;
	bh=doTIuN6r59RYP23l9Pgs3OqTVefv9hSNLFf0Tein5CQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEIpypvh21nfHzesmOZm1RXa7EY/UvSsqpV+sptwdDAsjuVrnlSy9Z1hpVeD/lJNTCJCA4GVBiRgpsamPKwdy4x+rvmQRMt7H2T93ogCKTIrJiSPr1TPpQmyRzwOEhTnhJsIx+JZmJi+SXg19lF6ZoTIWh9LyjWYxvdwPQog6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:ivesync10t1787017803tccc618d1
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.185.99])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2406459824416166894
To: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>
References: <F97867A3AA2696FD+20260817021708.37975-1-jiawenwu@trustnetic.com> <31eca887-50d8-40b2-b206-eff0a50b4a8f@linux.dev>
In-Reply-To: <31eca887-50d8-40b2-b206-eff0a50b4a8f@linux.dev>
Subject: RE: [PATCH net] net: libwx: fix concurrent bitmap overwrite in PTP setup
Date: Tue, 18 Aug 2026 09:50:02 +0800
Message-ID: <00e001dd2eb3$e2c6b580$a8542080$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbLEgmLNyPgvwTrDtPO7LLQoFhNgGmkeeDtpnZtIA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: ivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MZ6Tfega+cDUfqJRzKtvgL9j9fitBdFIVa1CWIAmJrJsW+L+gDU+fCOY
	UpOhyupg6PytpwmUgZLzCeYaN1jRoCK+vziB90jFDRNg84P0Jzn6umQsvoPMIjiL7Mgkiqu
	wUm/M1qrpkFaOnjuCAX9dShpkhMioEkKkwZg1MWuO8htrp9u0ip2/jsfkudcYtkH7j8+a46
	0tIy3Xw8L3H5wGMN0Jc4PxHfmXU9ZUjFWe30pALJsRKsj4x6rlH5Rg9RZhVBpmyUDFnBkf7
	gRWxrOH/lzqjB3fTkmifTYPBXZZ0WpnbhBxqJMcUMDQtk9mlBBI6hp8vyUKltJwonlIs4yc
	KoFusgykRaUOuRUfGDChOU9VMfGzsejOomJqvysTato/kVnfkKpJAciGt+QyBAUwmAsC6Lf
	mcMSVXQi3bM7PVk4QDNOMAV4Em5KKafAyvVevq7sH1hTQqgTBUXd6sGT0HIVyj36ueKn/t2
	Sz2MNcXhOZKUr7CwOmjSM4/TcjgK2AOnUfosy93+ASLk12vilsIt+jfBg0RgbO2Atfjzf2I
	Mt53pVnDejU1JRIi448xmkocc9+v49NPLM8okV6PL6Jijo7fDN5nuh99dSOy3SMsJbi6EC5
	flYs8GXu2EacKmH3sIchB1eykjkTjc/cD+yBQvIgPdpSy9+0zFscUwzQu/9h6gcZ6UVbeBR
	bpJxpSUdZZN0gIC3beoLh6PHvtRvBgTf4nayS5FHgAAaowFyoCvU2vIc220ueJ/edHB5H2Z
	ioxd05MFyvR2zn8zcWn6wAnSTOtTp4XQniWg7RaaGk6+VOf3Cx4TGhTKsGixQeJekoj3pkB
	qBo7so9a1/OBFTUCUKK8tCGEMSK1xGv4Cmg2G4O0/roA7c7TQ/upjyyQZXCh7zf+euu1xQl
	48W/v0TSlChhz94f9RkjYLkNA+jOqa9y8btp5LHa/cWKGazZiXnvmhDw94gTY/aml5x1V1W
	fd56obUPxc1OTzcKyN2FfzvJwe9jWatRZvxGWBxARZzMcmLkngseKBbKE2LwW1Vyfbg4yo3
	3Tu9fzhgSgR34vTBleIymUT9dNWB+wlUlIXv6JpzYKXd3jEqNmbxsqy1Ro3dICqGi1zC0nU
	ljYBzsODAGEhYB9L2IKgWtWbU+G1RGXyIF+dsepAY68w+w2smTBCI4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

On Mon, Aug 17, 2026 9:07 PM, Vadim Fedorenko wrote:
> On 17/08/2026 03:17, Jiawen Wu wrote:
> > In wx_ptp_set_timestamp_mode(), the driver copies the global `wx->flags`
> > bitmap to a local variable, modifies the PTP-related bits, and then writes
> > the entire bitmap back using memcpy().
> >
> > This Read-Copy-Update pattern is unsafe and introduces a critical race
> > condition. Other asynchronous contexts (such as Tx timeout routines or
> > GPIO IRQ handlers) update individual bits in `wx->flags` concurrently
> > using atomic bitops like set_bit() or clear_bit(). The memcpy() write-back
> > can silently overwrite and drop these concurrent changes, potentially
> > causing the driver to miss critical module reset or PCIe recovery requests.
> >
> > Fix this by removing the local bitmap copy. Instead, evaluate the intended
> > PTP flag states locally and apply them directly to `wx->flags` using
> > atomic set_bit() and clear_bit() operations only after the hardware is
> > successfully configured.
> >
> > Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >   drivers/net/ethernet/wangxun/libwx/wx_ptp.c | 22 ++++++++++-----------
> >   1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > index 44f3e6505246..7d4bd7b258b7 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > @@ -555,13 +555,12 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
> >   {
> >   	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
> >   	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
> > -	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
> >   	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
> > +	bool rx_in_register = false;
> > +	bool rx_enabled = false;
> 
> why do you need 2 variables if their values are equal in all cases?

You are right!

> 
> >   	bool is_l2 = false;
> >   	u32 regval;
> >
> > -	memcpy(flags, wx->flags, sizeof(wx->flags));
> > -
> >   	switch (config->tx_type) {
> >   	case HWTSTAMP_TX_OFF:
> >   		tsync_tx_ctl = 0;
> > @@ -576,20 +575,18 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
> >   	case HWTSTAMP_FILTER_NONE:
> >   		tsync_rx_ctl = 0;
> >   		tsync_rx_mtrl = 0;
> > -		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > -		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> >   		break;
> >   	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> >   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
> >   		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_SYNC;
> > -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> > +		rx_enabled = true;
> > +		rx_in_register = true;
> >   		break;
> >   	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> >   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
> >   		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
> > -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> > +		rx_enabled = true;
> > +		rx_in_register = true;
> >   		break;
> >   	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> >   	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> > @@ -602,9 +599,9 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
> >   	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> >   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
> >   		is_l2 = true;
> > +		rx_enabled = true;
> > +		rx_in_register = true;
> >   		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> > -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> >   		break;
> >   	default:
> >   		/* register PSR_1588_MSG must be set in order to do V1 packets,
> > @@ -643,7 +640,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
> >   	WX_WRITE_FLUSH(wx);
> >
> >   	/* configure adapter flags only when HW is actually configured */
> > -	memcpy(wx->flags, flags, sizeof(wx->flags));
> > +	assign_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags, rx_enabled);
> > +	assign_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags, rx_in_register);
> >
> >   	/* clear TX/RX timestamp state, just to be sure */
> >   	wx_ptp_clear_tx_timestamp(wx);
> 
> 

