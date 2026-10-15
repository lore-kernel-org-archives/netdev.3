Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBC4CDA3F;
	Thu, 15 Oct 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054147; cv=none; b=TXkzqU97jnHlMlFxYVMtFhRv+TauXYoPqsvpqbUS9Q8HIQpyopupcV2i5RoMCDq+2FW5fa3IR/5hov/tmvZejAeNWp6/ljtHT2f+azFaDVhqI1GpaNj1nm89RCSQTPAjXahqhmR3lxQ5sNNZ7lSqwDmNkBVEsyNJqXBCU52FtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054147; c=relaxed/simple;
	bh=Hiqd/zvvKBmiQKIQH5rMJyLgZE4DjkUbPRiNbDZoKBE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i+YN22sePqMgyUNW4GecJhoQnY+k1SuSSlj20N8/B5aMq41i9DM9TfAlmHFIu3s45FmvUqPCITlszX04/l0KunYFP5aQFpGVqY4k4kc8+YD+gZpnEVz56VbQvbGAKdVHGSh6e0Qx+9G4LNy3G5BIiAvJ1ZXX4JBujOmp9j4anKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ieejP6NV; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ieejP6NV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43239A0919;
	Thu, 15 Oct 2026 10:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792054138; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U03P+gee1kqHVbwU1qUibsCZEopODaXsBUYp9T2uy9k=;
	b=ieejP6NVk6AbGAbWq0+x/TNkMvAjaehMgUEpdevm3Ke56m8Yuj8t1h5Sm0TudEwZ2uzqt0
	BRVPgzf0R1Kpe+FGIIMlshE8sp8SumymjVCIHNMbqqXMSL/PSEOJ66Qnrj5joAA/7IFdYi
	iRgiDf4H4h0GQ2wdr5FanscxG8Noyv/iD1amZXIyG1Qt8xPqkq0fXH7uI8ok8+cRW9VUC/
	EI5UvL1+TTUtqj/GruT/LNEWleDGUuLaG11wbT1iBxQIjp9PNXyd4W4isyDXZXuvAZJAtC
	PBfV9r4yoq62xhGci+NmEYThrmhzNkVJl/3VTjigvPyPkPPxKRCTHfhCY8po3Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Oct 2026 10:48:56 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next v5 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
In-Reply-To: <179198777582.434549.9712346725032064776@kernel.org>
References: <20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
 <179198777582.434549.9712346725032064776@kernel.org>
Message-ID: <889b45fa87ee8eff3903c1b9e9b96316@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.10.2026 16:22, netdev-bot+sashiko@kernel.org wrote:

> [...]

> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch. The 
> new
> dropped increments here run under ring->lock, but bcmgenet_timeout()
> updates the same syncp after the lock has been dropped:
> 
> drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_timeout() {
>     ...
> 	bcmgenet_tx_reclaim(dev, ring, true);
> 
> 	/* Re-enable the TX interrupt for this ring */
> 	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);
> 
> 	txq_trans_cond_update(txq);
> 
> 	BCMGENET_STATS64_INC((&ring->stats64), errors);
>     ...
> }
> 
> bcmgenet_tx_reclaim() takes ring->lock and releases it before 
> returning,
> and the TX interrupt has just been unmasked. TX NAPI writes the same 
> syncp
> under ring->lock:
> 
> bcmgenet_tx_poll()
>     spin_lock(&ring->lock);
>     __bcmgenet_tx_reclaim()
>         u64_stats_update_begin(&stats->syncp);
>         u64_stats_add(&stats->packets, pkts_compl);
>         u64_stats_add(&stats->bytes, bytes_compl);
>         u64_stats_update_end(&stats->syncp);
> 
> dev_watchdog() freezes the tx queues, but it doesn't stop TX NAPI.
> 
> On 32-bit SMP kernels, such as on BCM2711 or arm32 BCM7xxx, can these 
> two
> writers overlap on ring->stats64.syncp? Readers in 
> bcmgenet_get_stats64()
> and ethtool -S could then see torn counters. A lost sequence increment
> would also leave the seqcount odd, and readers would spin.
> 
> Would moving the errors increment in bcmgenet_timeout() under 
> ring->lock
> avoid this?

Yes. It is pre-existing though, bcmgenet_timeout() increments errors 
after
bcmgenet_tx_reclaim() has dropped ring->lock and the Tx interrupt is
unmasked again by then. I can fix it in net.

> [...]
