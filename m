Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203907;
	b=Vxgm7VDxKPlwoFBIPnmnj/YAWqjGqH9+Qmp+ndvbi9CTjc6nUGXryXVBDHhxnyfMXwlV
	 qfa5nB+n1pQ/7Gl41Bq5syhK2NyXeCbw+7DBNJvLAzLZmt3bpDqto31PyzUcpWDnDlLVP
	 fUN+8WsuiAjURV1JQb2VwgeRuEPSYBHGKHGdtxW1bFPQztyLLbUrwlN4t9Bc1p5diXe88
	 rKH/MaOPV5qi8vZo+WGDtCx3VTZhLic/a0G1LytIxg32pMXlf8yABtCGJMP9XHuj60WHY
	 akMk05ItK0Fj+hfndQLZ5AW4NYtQqkAaCeBo+P+ayl+72NvfoemPrVh6NU4ZQMHcQow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203907;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=ycZFYUK9Sq+liOsi4MTVoR/c8j8LTqcyDLHHKuP5SiM=;
	b=AP6opR1QD6mUF637+3y4iYH91PPFYZ4EC3u+XeFdmdOpe0YZNSGyzAsc+E7rLeFBPWsZ
	 pNJ0gYbAxrTQfOOhl2InxwbymsYfnLSJjF1AQkOK2LzfeJkQZBeptTgSkMNL62YTsaNQ0
	 fXMqANCKlDixRbBEsxdH6QuI5UkRYC0Y/5rVV5Cr6TOqhAyuIJjXuIHAlDYblp0vYrRsY
	 fjisg8SWsyPayZyep3PsbudHCIYwfQxDaYBfx2m6vYIbeUBy3JgBhqgEUWfwaB63DLjRw
	 Cr7o+TV0+XGIzxQTohKNQIIHJghfw30fjr8VUKKFQFp1DgZF3jur+NSKdhixzr2ldnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F1606A31C;
	Mon,  9 Nov 2026 05:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 715F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1794203850tc03b9236
X-QQ-Originating-IP: ey/P3VmyPwt/7VocnGrP0yVNH8IO4ZpzeeN5gi3fOKA=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 13:57:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7978584010437446865
EX-QQ-RecipientCnt: 10
Date: Mon, 9 Nov 2026 13:57:28 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next 2/5] net: rnpgbe: Report link settings through
 ethtool
Message-ID: <DC15754D4AADBCCC+20261109055728.GA286191@nic-Precision-5820-Tower>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
 <BB3F0BAB3B9947AF+20261106112522.43965-1-dong100@mucse.com>
 <228e8fd8-4f1d-40d7-aca6-fc8a304b9906@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228e8fd8-4f1d-40d7-aca6-fc8a304b9906@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OGRTx1KypL8CmvoyuQkiV8iTvYFTPIVMpa8CEJKa0tcFrJjTw7jA259m
	/LXNbt6dF92EbTLdvGBdXxD50AdkW2DxUmxjk/eFxLK6hFoPpe7O8mzJ2P5JfMGwpx8EJTQ
	fct+X0G/5hD6Rg1o6bnudxSKVsghG0QrSH+zC0WSpJMXX5To5SIdi4rEWRdOFQ2FzJDiDVv
	hrBvZi0PKZCYusw2ttBZam+kSeOPbniRxesBQSa5/TRMEVjG8I1zy9UIWsf9uUOVzjag4Ix
	F+8wpJEWjL+xQhhAcTjjl6aSRILmrsaJF8Kl47bLMEzghbpkFN8RW8iahZB1MEcK3N/jGWL
	Uif17eZ9RtF8+YiYgOuVx+YBKP6Da6LlkmpPIUHAouxz79Y3wr2F/c6U0xBXTzU/wbgl7EK
	8wtTIHrEEfQexBQO7gYMibdrZrIjutA9XNfw70DMd9AtLwSY+rmR2HBxNxrfX8Sbyq3xUxV
	SHn+xH8iDy5ckDxxNJ5UuPDyHViFQxoGHLlNGYhVKArXstX+rvE4mE/bKnqAvgYXtT1d6HQ
	KKxoiQettrsTZB4WRfH/wygdLqOtRZcxcy32BC1aG/k9u2o+H3R38q9dRxS5rPXT/UBcF6r
	JlsQBa3mAC2+hFACvZfJEgPUZeAL9RyA1wqdT0CmKkP8y20hxPvXFZACX7p46P4EhinuqQA
	CM18ixSYz7FOsAL/vrhbSXQzcISTmTZwwXZRdiQhmkIhmAwVexg8ZtHZx4BCRI88cPnQdPu
	7sytOn2+XwrtqRLcazFIjWvyt5fUlkUCJUtZzS9MIxA4hxLFfCKJTZOGgvQxoPMliqOF1AV
	qJVHC1hnQjfTogI3tj25MTLosfVm6VKObPp3RUdH2XM1UTE5lSWP11DopplptDf51kd9n73
	sbvUsB/hWvmxng0zmgaNL6FizVMQzNJkKtXJs1ujPCAMBDUgQhTOsZiSzLGM8zW+yRSzYk0
	3/LAe3V6Ps/6ztPYwX2n+It7CFCgSZ0mXAU9tPjL6h1iN7L70rOU6c0P6R0DwEGe7UlKNLv
	WAW9nf+4KwIURAYb3WEEAVOO81yMzCI4B+iEg5zA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Sat, Nov 07, 2026 at 06:57:45PM +0100, Andrew Lunn wrote:
> > These devices support autonegotiation only on TP ports. Configure TP
> > ports with autonegotiation enabled and fibre and backplane ports with
> > fixed 1 Gb/s full duplex.
> >  int rnpgbe_setup_default_link(struct mucse_hw *hw)
> >  {
> > -	return mucse_mbx_set_link(hw, RNPGBE_DEFAULT_ADV, true, 0, 0,
> > -				  ETH_TP_MDI_AUTO);
> > +	u32 advertising = hw->link_config.supported & RNPGBE_DEFAULT_ADV;
> > +	bool autoneg = hw->link_config.status & MUCSE_LINK_TP;
> > +	u8 duplex = DUPLEX_UNKNOWN;
> > +	u32 speed = SPEED_UNKNOWN;
> > +	int err;
> > +
> > +	if (!autoneg) {
> > +		advertising &= RNPGBE_FW_ADV_1000_FULL;
> > +		speed = SPEED_1000;
> > +		duplex = DUPLEX_FULL;
> > +	}
> > +
> > +	err = mucse_mbx_set_link(hw, advertising, autoneg,
> > +				 autoneg ? 0 : speed, autoneg ? 0 : duplex,
> > +				 ETH_TP_MDI_AUTO);
> 
> This looks odd. If autoneg is off, you expect user space to indicate
> how the MAC should be configured. 10, 100, 1G, full or half.
> 
This function sets the initial configuration during probe. It does not
handle an ethtool configuration request.
For the supported fibre and backplane configurations, the link operates
at fixed 1 Gb/s full duplex without autonegotiation. TP ports default to
autonegotiation, and the subsequent patch adds support for user-selected
forced 10/100 Mb/s speed and duplex settings.
The port type is fixed by the device firmware. TP, fibre and backplane
are mutually exclusive configurations, and the driver cannot switch a
port between them.
> > +static int rnpgbe_get_link_ksettings(struct net_device *netdev,
> > +				     struct ethtool_link_ksettings *cmd)
> > +{
> > +	struct mucse *mucse = netdev_priv(netdev);
> > +	struct mucse_hw *hw = &mucse->hw;
> > +	u32 supported, advertising;
> > +	unsigned long flags;
> > +	u16 status;
> > +	int mode;
> > +
> > +	status = hw->link_config.status;
> > +	supported = hw->link_config.supported;
> > +	advertising = hw->link_config.advertising;
> > +	ethtool_link_ksettings_zero_link_mode(cmd, supported);
> > +	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
> > +	ethtool_link_ksettings_zero_link_mode(cmd, lp_advertising);
> 
> Do you have access to the LP advertisement value? It is useful for debugging.
> 
Firmware manages PHY configuration, autonegotiation and reading the link
partner advertisement. However, the mailbox response currently used by
this driver only exposes the local capabilities and advertisement.
> > +	} else {
> > +		if (status & MUCSE_LINK_BACKPLANE) {
> > +			mode = ETHTOOL_LINK_MODE_1000baseKX_Full_BIT;
> > +			ethtool_link_ksettings_add_link_mode(cmd, supported,
> > +							     Backplane);
> > +			ethtool_link_ksettings_add_link_mode(cmd, advertising,
> > +							     Backplane);
> 
> Does it actually advertise Backplane?
> 
> 
> > +			cmd->base.port = PORT_NONE;
> > +		} else {
> > +			mode = ETHTOOL_LINK_MODE_1000baseX_Full_BIT;
> > +			ethtool_link_ksettings_add_link_mode(cmd, supported,
> > +							     FIBRE);
> > +			ethtool_link_ksettings_add_link_mode(cmd, advertising,
> > +							     FIBRE);
> 
> Again, does it advertise fibre? What happens if the LP wants to do TP?
> 
These bits were added based on the fixed port type, rather than an
advertisement reported by firmware. I agree that this does not establish
that they are actually advertised.
A fibre port cannot switch to TP based on the link partner's capabilities.
The firmware-selected port type remains fixed.
Maybe I should revise the reporting for the fixed non-TP configurations?
retain the port type and supported link mode in supported/base.port, Andrew
leave advertising empty since these configurations do not use autonegotiation.
> You probably want to look at phylib, it figure out the correct way to
> to implement ksetting set/get.
> 
The current design leaves PHY management with firmware, with the driver
using mailbox commands to configure and query the link.
I will use phylib as a reference for validating user settings
and reporting link capabilities and configuration, while keeping PHY
management in firmware.
I will correct the advertisement reporting for fixed non-TP ports.
> 
>     Andrew
> 
> ---
Thanks for your feedback.

> pw-bot: cr
> 
