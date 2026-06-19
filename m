Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D466365A11;
	Fri, 19 Jun 2026 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862833; cv=none; b=iC3rStRA5fsZ6lI0eK+UyTPVReQk2F+mkvhFsZYZfYf2hSb+RPYjkF1T12SvJ+5+FIEjAIzRAW4D22cmPoc9bheyyOIZk3OtHY1yvPCNiR49hD7QpsRxT3BewqkORNfI5Ge6iCOIV0pC1714fLO8qAuRj4iPxSCDBeT9NNKPf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862833; c=relaxed/simple;
	bh=oRQQFZKzQiLFW/pZ9s5Xq9sNgO5G8J8EukMbRA6kD10=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=N6hL2CnI7bkfsvbMkPEd3C1rSEBmekOoo2UWcnEAmwL1dPkTUB+fugRMXvxKze0QRP28bLOe6PWtKVDbSEgzNZcDNVJqdecNfwSB/6Fod0ZpItpExlrSISuNTwShtCJz3oHshmq3H3HcVzmURBBfx/lAFBHFG7gnwkIfZekadic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=aDNyWtOJ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="aDNyWtOJ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3246CA0378;
	Fri, 19 Jun 2026 11:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781862827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/WAo8TzqFb7hDUkv6TQqniOf6hHCRnPknHRBd3UajO0=;
	b=aDNyWtOJiuNogn/zfnGr7iR4o9dLVM3/+yeAZJrWrGjSbJw8U5cQbXx9Y5TiMi144ogQcD
	q/25YEsr8+d0OS17IcHx76KqghRfTbc71/JGTurSiVUZK6F3OYt7f4ueLogEDmE/SMSbZI
	isLPbTp2IAb0B52cIjkXq1BrRpmCXygqW4bN+81aFTUHi+A+JZ9GZCuVu5h70VKck3vo7Y
	AitzZKhkZ6cQdcNn6+1hssYUU8WbGClJMrFEjkuiMmrK6fjnQhrdEe1/GR2Pu9FraO/5vn
	SrgYbm2ifF0hjBDUwsNwlfQ6baF5aJwSjES3y79eQZgP+SbdiaawZrEmX6KaSA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 11:53:45 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter table
 after device reset
In-Reply-To: <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
 <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Message-ID: <4abfc9b1e8860da93c03639863bd0232@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sven

On 19.6.2026 11:18, Sven Schuchmann wrote:
> Hello Nicolai,
> 
> my first opservation is that calling lan78xx_write_vlan_table()
> at the end lan78xx_start_rx_path() fixes the problem. I was able
> to do over 200 connect/disconnects without any problem.

Thanks, that's the right direction. For the final patch I'd move it
to lan78xx_mac_link_up(), which is IMHO a bit "cleaner":

[...]
  static void lan78xx_rx_urb_submit_all(struct lan78xx_net *dev);
+static int lan78xx_write_vlan_table(struct lan78xx_net *dev);
[...]
static void lan78xx_mac_link_up(struct phylink_config *config,
[...]
  	if (ret < 0)
  		goto link_up_fail;

+	ret = lan78xx_write_vlan_table(dev);
+	if (ret < 0)
+		goto link_up_fail;
+
  	netif_start_queue(net);
[...]

Could you give this version a quick test and confirm? Then I'll add
your Tested-by.

> [...]

Thanks
Nicolai
