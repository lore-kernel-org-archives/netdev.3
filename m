Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685775;
	b=QboYZ5r3IQshE4sOW0NrOUuXGuFaB2uAJLrZ8KzTDcLJF6OAXmwVJVqjfRrdauzuIqRc
	 jasjLzllo90Dzq2ySm4kjT8D944+NWxHgW2myoQ+D3ZzwAQS9ewlXa5CsZ8Jm/tk6VgP0
	 CgdUGWuXveklTIcC2IaA+IOoha3bqlIvj/0h+FCd8XDt8kTZ2dcP+LAVFiFKJ7UnCTAE/
	 Fr8eINb7u7Zk0xzPJybaq5k2YMoo1Dbw42gg0CnkZUlTGa1DhoWkQDjtAxn9UiGHUJlQZ
	 CJ7yNaI8Yaz7+tbKvHIfmROQ57KKJBWFROdhkY2Eqq0Q+C5Kw6xyj5s/+Z0bzAP7+DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685775;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OQG3Rpe6sTxKeQSDXn4PTSV6RnWCQvYTk9rhHTjrvog=;
	b=J/T3+Dd/m6CYW2yBow1DOsEc83a22c4ghYPFPg4YR92oa5buLrIShZGt+wHQi429q7VA
	 dI0oVCF8ErW9/o4xNCaIzxND2YOycg+A3Ti6NT/QHrKf83se4TcWZQGmgJmPOb2RVz0qm
	 sr2S51VDAlinff/RoFEostaSDhahrsXz59LbCKaHiohSa+klFd2iJW/Fn2FsUg0NNAm0Z
	 C9dDdzjduZX+5AyCfhytK4v6ITKSWKmuPZjBUaGTVtWXmaMqwfTABLM5WOP0X702gPIvn
	 wLKor7HfK2xyDgA5ppwLGXMHZDCTcNGwdDwCgDLeNwCOegFGY/9SysOP8OPikQyt3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="mZ/0YRCX";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E3606A324;
	Tue,  3 Nov 2026 06:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172E3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mZ/0YRCX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=OQG3Rpe6sTxKeQSDXn4PTSV6RnWCQvYTk9rhHTjrvog=;
	b=mZ/0YRCXPreDbWsTT2WI0GF1zW4Z7NZ25mxEHLaWuDJKTi+xeh+5HDnj+kOl1+
	gElUeb7xSjDPliWGtY3T3iCEBiUd5edBGj/3S8yawz+ZgCbCdF8gDD+PJQS20RBd
	0IExIPjFoeX5BFXhr603vdY/QBUmH5SUr1CGnSixKTQRs=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3vy2UeOlqvBZcFA--.42044S2;
	Tue, 03 Nov 2026 14:01:03 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: thomas.bourgoin@foss.st.com
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@kernel.org,
	fujiahui@lixiang.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	liuxuanjun@lixiang.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	zhoujing3@lixiang.com
Subject: Re:Re: [PATCH net v5 2/2] net: stmmac: restore RX descriptor buffer addresses on resume
Date: Tue,  3 Nov 2026 14:00:52 +0800
Message-Id: <20261103060052.2226087-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <872a93b8-4bd9-4718-89e2-019fd3c5b8ac@foss.st.com>
References: <872a93b8-4bd9-4718-89e2-019fd3c5b8ac@foss.st.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vy2UeOlqvBZcFA--.42044S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4ktr17GFW8ur17ZF4UXFb_yoWrWw1rp3
	yay39rtrykJr4xCr48Xw4xWFy2vFs8Xa15Gw1rJw1qy390krnavFy3KrWYya4xGFZ3Xw1F
	vF4UZ39xCF4DCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEna93UUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0h9ahmrpeJ9hkwAA3H

Hi Thomas,
 
Thank you for reproducing the issue on the STM32MP215-DK and for
backporting and testing the series. It is helpful to have confirmation
on another platform. I understand that the backport required changes,
so I will not describe this as testing the series as-is.

>Overall, I’m okay with your patch, I have a few suggestions:
>
> > +			stmmac_legacy_serdes_power_down(priv);
> > +			mutex_unlock(&priv->lock);
> > +			rtnl_unlock();
> > +			return ret;
>replace these 4 lines with: `goto error_unlock;`
>
Regarding the error path, agreed. I have replaced the duplicated cleanup
with "goto error_unlock" in my local revision.

> > @@ -8503,6 +8577,18 @@ int stmmac_resume(struct device *dev)
> >   	stmmac_free_tx_skbufs(priv);
> >   	stmmac_clear_descriptors(priv, &priv->dma_conf);
> >
> > +	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
> > +		ret = stmmac_reinit_rx_descriptors(priv, &priv->dma_conf, queue);
> > +		if (ret) {
> > +			netdev_err(ndev, "Failed to restore RX queue %u: %d\n",
> > +				   queue, ret);
> > +			stmmac_legacy_serdes_power_down(priv);
> > +			mutex_unlock(&priv->lock);
> > +			rtnl_unlock();
> > +			return ret;
> > +		}
> > +	}
> > +
> >   	ret = stmmac_hw_setup(ndev);
> >   	if (ret < 0) {
> >   		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
>
>You could move the calls to `stmmac_free_tx_skbufs()`, 
>`stmmac_clear_descriptors()`, and your loop into a dedicated function, 
>perhaps something like `stmmac_resume_descriptors()`.
>
>In my PR, I also factorized the loops so there is one for TX and one for 
>RX, instead of one loop for TX and RX in `stmmac_clear_descriptors()`, 
>one loop for TX in `stmmac_free_tx_skbufs()`, and one loop for RX to 
>rebuild them.
>By doing this, I managed to remove the `stmmac_free_tx_skbufs()` 
>function. It changes the PM sequence a bit, but I think it is okay. I’ll 
>let you decide whether you want to do it or not.
>
Extracting a stmmac_resume_descriptors() helper also makes sense. I will
look at organizing the work per TX and RX queue.

> > +	/* GMAC4/XGMAC secondary address writes overwrite the OWN bit. */
> > +	dma_wmb();
> > +	for (i = 0; i < dma_conf->dma_rx_size; i++) {
> > +		buf = &rx_q->buf_pool[i];
> > +		if (rx_q->xsk_pool && !buf->xdp)
> > +			continue;
> > +
> > +		p = stmmac_get_rx_desc(priv, rx_q, i);
> > +		stmmac_set_rx_owner(priv, p, false);
> > +	}
>
>Since on GMAC4/XGMAC we need to set the owner bit after writing the 
>secondary address, why do we need to call `stmmac_clear_descriptors()` 
>before reinitializing the RX descriptors?
>Since `stmmac_clear_descriptors()` is a loop that calls 
>`stmmac_init_rx_desc()`, and I verified that all `.init_rx_desc` ops set 
>the OWN bit to 1, could we call `stmmac_clear_descriptors()` after 
>rebuilding the RX descriptors instead and remove this loop ?
>
Regarding moving stmmac_clear_descriptors() after restoring the buffer
addresses, you are right that the GMAC4/XGMAC init_rx_desc callbacks do
not overwrite those addresses. For a fully populated RX ring, doing the
initialization afterwards could replace the separate re-arm pass.
 
The complication is the partially populated AF_XDP ring. In v5,
stmmac_clear_descriptors() unconditionally sets OWN on every RX
descriptor. Moving that call after buffer restoration would therefore
also give descriptors without an XSK buffer to DMA.
 
The v5 ordering was intended to leave those slots CPU-owned afterwards,
but further review exposed problems with that approach: the legacy
clear callbacks do not clear OWN, and the unfilled slots also need to
be represented correctly in the software refill state.
 
I am addressing those issues in the next revision. I agree that the
better ordering is to restore addresses and chain pointers first, then
initialize/re-arm only the valid descriptors, while preserving the
legacy descriptor control fields and the existing RX watchdog policy.
Unfilled XSK descriptors must remain CPU-owned and available for a
later refill.

Thanks again for the suggestions and the testing feedback.
 
Best regards,
Ding Hui

