Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747876;
	b=oVvrxRPmyi9j6xsNqQVr0JSod/YDvRcyn/ojEYanZp02SZisl1YhdSAN84GfiedpS4nc
	 v8Kg10UbxnWSGTce2hHS8AdqffmBU0lhC/GUL3lC234JgohCoZnQMwzBFGdtgjoWaRPRK
	 smt+/VRhzn3BK3NUFkU3iJ4BVn5S3URuQg7x+qSnM/IRUVZCL4YbiUEvtq3wQYDJxmTjd
	 NQAHYT0oEIfWVXcZTksud0PgA4DJ+e9XR8F/zOzPBr0LvLxDcWuaRBUVBKjAG5mvu82As
	 xi7+6NQNExKys8TM8YeWLpr9LnbWls8nY4vCbRv8bS151uMYrc19dMNLBKJ+UxanDwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747876;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=WqNNSoFVGkzMo6pK4A+r0nyZRgEKN7rRbtYYlknDqFI=;
	b=oU6kLIdHlhKJzQSkqgdwgfGWPXt70E8h2xisv7IH+ZipT+4h+BifutVdsq8dkvi2kFBc
	 7KjB8spQGN3yFkznC+dIKW1R5wzck/d+OfpYJnTUBjsTbsPoerAtK99GMa/2Fq3H0kwNb
	 c8XH8j1sMNJGNI2PrESjSS6QTeBDn/DEtin8RFcYPlXY1WTEg38MltXz5MyLhqKwiWDbY
	 qrNIPlarUAjp7hMN0L2YyChdiCBiENLVPtn0aam57iQ0kY69UCW6Dptku+BM/C5fljuoM
	 oMziCBeuHRFfKmQ4Bip0+RYw75GJF3M+1fHnaV2GPBorURzcR5Y5n9GMxrR1ssGwEXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zXsf7Yoc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PMv1RD75;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64315606A324;
	Tue,  3 Nov 2026 23:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64315606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zXsf7Yoc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PMv1RD75
Date: Wed, 4 Nov 2026 00:17:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793747871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WqNNSoFVGkzMo6pK4A+r0nyZRgEKN7rRbtYYlknDqFI=;
	b=zXsf7YocqOwQekIPxLBpeH4vlcgq4v/Z0L8nj8+Z4O3hML1phARFLTDqy8KX0fKXf0o/Vp
	EcnJoU5NMrwFaQREMur1rx2HgmPSEv8ebDUzs7oSs+1oH7kN/0IzjvVcqg1CpLENoHhgZ0
	U7OVwspuKkkDEA5MNIl6ZwivoBOwKCs24uEIpNUAPr+GJL3GDARfu/nmwi0v7NEhSZZzdw
	oADhD2a+tzD6aNVDxdYBc5H8/81XShJ7LCeiaMBByF6FPyblOZ//gI/gcBxekp7Uf+Tt/j
	TqKdWJEfpxX8j/meODcOPmm0F4jjCGinQa0Tf0dVHlxR+n3AGO8/UzPV+hb1Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793747871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WqNNSoFVGkzMo6pK4A+r0nyZRgEKN7rRbtYYlknDqFI=;
	b=PMv1RD75fNiAj3wq/WumgKR4Go0gQrlRBHhZfd24HZcaEcOy/e7eC+sMLmjcrH7j32aGcV
	sM7LyPf0/T+aDjAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: James Clark <jjc@jclark.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Chintan Vankar <c-vankar@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Alexander Vassilevski <oss@vassilevski.com>,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Enable
 timestamping of unicast PTP packets
Message-ID: <20261103231750.R8W01B3E@linutronix.de>
References: <20261102135117.419539-1-jjc@jclark.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102135117.419539-1-jjc@jclark.com>

On 2026-11-02 20:51:17 [+0700], James Clark wrote:
> On a BeagleY-AI (J722S), ptp4l as a unicast master (unicast_listen) logs
> "received DELAY_REQ without timestamp" for each unicast Delay_Req, and
> its port goes to FAULTY after "timed out while polling for tx timestamp"
> for the first unicast Sync.
> 
> am65_cpsw_nuss_hwtstamp_set() does not set the TS_UNI_EN bit (bit 24) of
> the port's TS_CTL_LTYPE2 register. According to the TRM (J722S TRM
> SPRUJB3D, 12.2.1.4.7.13.5.1 Ethernet Port Receive Event and
> 12.2.1.4.7.13.5.2 Ethernet Port Transmit Event), this bit must be set
> for the port to timestamp PTP event messages over UDP sent to a unicast
> address; without it, only messages sent to the PTP multicast addresses
> selected by the TS_107 and TS_129 to TS_132 bits are timestamped. TI's
> netcp_ethss driver for the Keystone 2 Ethernet switch, which has the
> same timestamping registers, always sets TS_UNI_EN.
> 
> Set TS_UNI_EN along with the other bits. With this change, ptp4l in the
> same setup gets timestamps for the unicast Delay_Req and Sync messages.
> 
> Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
> This was discovered while using ntpperf -D/-N to evaluate PTP hardware
> timestamping performance. The patch was generated by an LLM coding
> assistant.

I have here a AM642 EVM and eth0 here uses am65-cpsw-nuss. I didn't
manage to get ntpperf up but 
	ptp4l -i eth0 configs/UNICAST-{MASTER|SLAVE}.cfg

uses UDPv4 and should do what you describe. But then I noticed that it
uses 224.0.1.129 as destination which is enabled by TS_129 and does not
look like a unicast address. Buh.
netcp_ethss sets TS_UNI_EN but it does not set the other TS_ bits. The
reference manual in Annex D (for am64x) describes how matching works but
it does not say if TS_UNI_EN should be enabled in addition to the other
TS_ bits, which match a specific address, or not. It just says it
matches either this with the specific bit set or anything with the UNI
bit.

It continues to work for MC with this bit set so
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
