Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556320;
	b=rylEmqwurJjjgTJDzbYefrkPfr0Jvtmu9o6PwTymIth2JQltyXDeVk1lGWbEVo5jBTtz
	 Si+xxMeb8abhXewGuowCU5LYK6H41zcoG0dpShkqf3B2JB4+S98Tch7rL2fwd6jlH4eUo
	 6AzAPdL//aNu7WuUw147zR9TJ0DZH4d/aG2uUjZ4MG9lhK9mWpGbgHBSvKXxmM+opXeRG
	 mLXqNhwt5BZLOdtyirBe1wbbyRKBzWb10EWxCjqOLuT06MAenO8L61RJVEwOYxVyUXsxH
	 KyRbyr7MfGh0lrLxZISXq6MD8MJ1zuiEEr66a8mCBPq/c1srZ5TbwHFjO6HIDBXMmgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556320;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=tekGQqshfpybvC/Ot+m/0L0XRNuJNk6yTuWYPdWVZvI=;
	b=nYj1hdcjK0sS9dqg109MR0sYerE/n19TWTuR2JTKFmaeX9hOjiGaidTSG8/v/zn8sMwt
	 RTHczyMrTm1Td07gem1pMRXFJAuRCrgq4gEsCp8lmn33wcjGdbdkQ1L9Epo9N7xyAd6+M
	 O0fZilTk7b3LvV89MfezLcPb3zzFeB4y1pT6IQ7AZMBucGREdV1eOBa5ZrWEoqtwI2eYE
	 PP71oSULIvS57VAy9sGMer4uv6IakxfiZyTQjdCuJSRfug3tMfpNuc5DHOcB4mSXf3sFI
	 6BNNg2tSWNmYTRsR+yNtLSGh4orf/Z4pEzdizIFGqzgdSwEQjs6WU66hNzToODXgoyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=tgRqhcgC;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D2606A327;
	Fri, 13 Nov 2026 07:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 262D2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=tgRqhcgC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794556327; x=1826092327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QpXOGADlyIDLBtQ/AXIhaGRDyCc/TJuilRmUmT/j9Yg=;
  b=tgRqhcgCEFzND+WFyIR4b4q8762hZXC+aa4GZrSodZHDeDc3KnsdYaiE
   fghlqxj+RkJUZ1QEh2uKuKD2KIxD7uG6YDIvwQpqA+zR3Lo+g+nFu9Inq
   cGWHhLhO1ExnGpwZAlfCO4OonjUtM5BCCl0Q+c4ZWqSMowbq5lQNKPvha
   W/QkhYkkG+nt3VJQV2pdmuexZonlXq5HlinX+nBHcbfXZU4e5ADs+3KBl
   S9qfMrLF1M0MPRLqnaLff+vwiYY9rf77TOIyKrlV+Qx7/GEKE8+TwIlc7
   XAznpT78+4Oyuj9Z4Df83EFGuTG+xIWjvlT7Cp55C1bOWSeRUE3+wb+Lm
   Q==;
X-CSE-ConnectionGUID: 4bJyuF6GQ2C5kHLlcJALfQ==
X-CSE-MsgGUID: GGwcvbqIRWSxsELSmojXWQ==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="297871954"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2026 00:52:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 00:51:58 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 00:51:55 -0700
Date: Fri, 13 Nov 2026 08:51:55 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robert.marko@sartura.hr>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next v2 1/9] net: sparx5/lan969x: stop the FDMA
 channels properly
Message-ID: <20261113075155.srvezxa2arqti64e@DEN-DL-M70577.microsemi.net>
References: <20261111-sparx5-mtu-change-v2-1-59c91357e8f6@microchip.com>
 <179450479493.2199510.4440156833220844993@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179450479493.2199510.4440156833220844993@kernel.org>

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] If the FDMA_CH_ACTIVE poll in sparx5_fdma_stop()
>   (sparx5_fdma.c:486-493) times out, the function only calls…
> - [Low] In sparx5_fdma_stop()
>   (drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c:472-509), the…
> 
> --
> 
> net: sparx5/lan969x: stop the FDMA channels properly
> 
> This commit changes sparx5_fdma_stop() to disable the FDMA channels
> through FDMA_CH_DISABLE and to poll the new FDMA_CH_ACTIVE register until
> they are inactive. It also stops the injection port through INJ_STOP. The
> XTR_BUF_IS_EMPTY poll now waits for the buffer to be empty instead of
> non-empty.
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > index 15ec9b053824f..bcae0bbd5e44e 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> 
> [ ... ]
> 
> > @@ -468,20 +471,39 @@ int sparx5_fdma_start(struct sparx5 *sparx5)
> >  
> >  int sparx5_fdma_stop(struct sparx5 *sparx5)
> >  {
> > +	u32 channels = BIT(sparx5->rx.fdma.channel_id) |
> > +		       BIT(sparx5->tx.fdma.channel_id);
> >  	struct sparx5_rx *rx = &sparx5->rx;
> >  	struct sparx5_tx *tx = &sparx5->tx;
> >  	u32 val;
> >  
> >  	napi_disable(&rx->napi);
> >  
> > -	/* Stop the fdma and channel interrupts */
> > +	/* Disable the channels, and wait for them to finish the current DCB */
> > +	spx5_wr(FDMA_CH_DISABLE_CH_DISABLE_SET(channels), sparx5,
> > +		FDMA_CH_DISABLE);
> > +
> > +	if (read_poll_timeout(sparx5_fdma_ch_active,
> > +			      val,
> > +			      !(FDMA_CH_ACTIVE_CH_ACTIVE_GET(val) & channels),
> > +			      SPX5_FDMA_STOP_SLEEP_US,
> > +			      SPX5_FDMA_STOP_TIMEOUT_US,
> > +			      false,
> > +			      sparx5))
> > +		dev_warn(sparx5->dev, "Failed to stop FDMA channels\n");
> 
> [Severity: Medium]
> If this FDMA_CH_ACTIVE poll times out, what stops the channels from
> continuing to DMA into memory that the callers free right afterwards?
> 
> In that case sparx5_fdma_stop() only warns and still returns 0. Both
> deinit callers ignore the return value anyway, and free the DMA memory
> without resetting the FDMA:
> 
> sparx5_fdma_deinit() {
> 	sparx5_fdma_stop(sparx5);
> 	fdma_free_phys(&sparx5->rx.fdma);
> 	fdma_free_phys(&sparx5->tx.fdma);
> 	...
> }
> 
> lan969x_fdma_deinit() {
> 	...
> 	sparx5_fdma_stop(sparx5);
> 	fdma_free_coherent(sparx5->dev, &tx->fdma);
> 	fdma_free_coherent(sparx5->dev, &rx->fdma);
> 	lan969x_fdma_free_pages(rx);
> 	page_pool_destroy(rx->page_pool);
> 	...
> }
> 
> A channel that is still active keeps the DCB addresses in its LLP
> registers. Could it then fetch DCBs from the freed coherent rings, or
> write extracted frames into RX pages or skbs that have already gone back
> to the allocator? Unbind/remove reaches this through
> sparx5_frame_io_deinit()->ops->fdma_deinit()->sparx5_fdma_stop().
> 
> The code alone doesn't show whether a channel can really stay active
> longer than SPX5_FDMA_STOP_TIMEOUT_US after CH_DISABLE. Still, the timeout
> branch exists, and the frees after it run no matter what the stop returns.
> 
> Later in this series, "net: sparx5/lan969x: add support for resizing the
> FDMA buffers" adds sparx5_fdma_pause(). It follows sparx5_fdma_stop() with
> an FDMA_CTRL NRESET before the buffers are freed. That covers the resize
> path, but the deinit paths still have no reset.
> 
> Would it make sense to return -ETIMEDOUT from sparx5_fdma_stop(), or to
> assert FDMA_CTRL NRESET in the deinit paths before releasing the DMA
> memory, or both?

I dont think this is an issue. Even if the poll times out, XTR_STOP is still set
right after it, and it blocks any new memory write accesses from the extraction
side. CH_ACTIVE only waits for an outstanding DCB fetch to complete, so a
timeout here does not mean that the channel keeps writing to the buffers.

> 
> > +
> > +	/* Stop the fdma and the RX channel interrupt */
> >  	sparx5_fdma_rx_deactivate(sparx5, rx);
> >  	sparx5_fdma_tx_deactivate(sparx5, tx);
> >  
> > -	/* Wait for the RX channel to stop */
> > -	read_poll_timeout(sparx5_fdma_port_ctrl, val,
> > -			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val) == 0,
> > -			  500, 10000, 0, sparx5);
> > +	/* Wait for the extraction buffer to be empty */
> > +	read_poll_timeout(sparx5_fdma_port_ctrl,
> > +			  val,
> > +			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val),
> > +			  SPX5_FDMA_STOP_SLEEP_US,
> > +			  SPX5_FDMA_STOP_TIMEOUT_US,
> > +			  false,
> > +			  sparx5);
> 
> [Severity: Low]
> Can this poll still time out while RX traffic is arriving?
> 
> The extraction channel is disabled and polled inactive first, while the
> extraction port is still running. XTR_STOP is only set after that, in
> sparx5_fdma_rx_deactivate():
> 
> 	/* Stop RX fdma */
> 	spx5_rmw(FDMA_PORT_CTRL_XTR_STOP_SET(1), FDMA_PORT_CTRL_XTR_STOP,
> 		 sparx5, FDMA_PORT_CTRL(0));
> 
> Frames may keep reaching the CPU extraction queue during that window, and
> CPU forwarding (QFWD_SWITCH_PORT_MODE_PORT_ENA) stays enabled on the
> deinit path. If so, there may be no active channel left to move data out
> of the extraction buffer, and XTR_BUF_IS_EMPTY might never become 1.
> 
> The result of this read_poll_timeout() is also discarded and nothing is
> printed. A non-empty buffer therefore looks the same as a clean stop.
> 
> The commit message says the old wait "always runs until it times out".
> Could the new wait still do that in this case?
> 
> Later in the series, sparx5_fdma_pause() disables CPU forwarding and
> drains the CPU queues before it calls sparx5_fdma_stop(). That suggests
> the stop sequence alone does not handle extraction that is still in
> progress.
> 
> Would it help to set XTR_STOP before disabling the channel and poll
> XTR_BUF_IS_EMPTY while the channel is still active? Another option is to
> flush the buffer with FDMA_PORT_CTRL_XTR_BUF_RST, which is defined in
> sparx5_main_regs.h but never used. At the very least, checking and
> reporting the poll result would keep the diagnostic.
> 
> >  
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-sparx5-mtu-change-v2-0-59c91357e8f6%40microchip.com
