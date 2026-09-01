Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F67443A97;
	Tue,  1 Sep 2026 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292058; cv=none; b=QOOG+Wt8v/u0HVB+OQF8NZ03O2rRF7G7WLr7ved5VCsasXpRypd/oVbuS1pek6N3WCBtomT7fBrL4M1+k8NcxKA72iLEiibTWeWue3LcJaSwyONvfP4zXgWul50cfEf/Z/xXvXG45hJpbB0zpRtNi9fGtFs34mHKR8LXKUIy/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292058; c=relaxed/simple;
	bh=S6Ze5dH30c1sk13lINsxsruT9DPKAtqX7682wKNvFoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY76xw/baSTX3dPcyhSibNs4OoTR1G8Xn1rt6ZkiawOajpbk7ntjHcWB2eQRrtDaGuX2ICPECuZwCg67FI3wW/6qP/zzxJ5JNyvYMji+ei4ToKjZRkfnLoEfRHjhSU+2l1NcDk3mLGW1uhY4uxFvcM65gBgeuKKq18l8dMToNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KGQ6Sv5V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMGMW1+A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KGQ6Sv5V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMGMW1+A"
Date: Tue, 1 Sep 2026 21:47:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788292050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kVakSZKJ+/biQmo1FhyfgpI2TOx3aJuye+azQYfGnU=;
	b=KGQ6Sv5V/WARQz5NH6d3Sb3JusTpH/c7YNqpIgnd9h+VIJikdiibfvsSkNPtm2bSP/sNrE
	AvHRhw0oEpHKfBQZW28q8HHevQzjUQdV4cj7aH7bgegDqLPaMvv5rlmLb9YdaAASayjDzJ
	xVlgYYJBlHfQhauHSraIKwBiw3GZR6FVxUYNYgUeeeBA0exkdQe8TVBBAh0RBWdGZWXBvF
	h3NuDkP6SH5UBdfiI5GtXrMum8aDWrwZ4iiAoPmhDv2/N8lPNbi1ApDs+lQBJonjZYRdM7
	zXdBN2cuHfTH8WIKTdW+KcAncRBjoEAr8ptEteLUVDWDo0bwvmdcdOyjZCGUcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788292050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kVakSZKJ+/biQmo1FhyfgpI2TOx3aJuye+azQYfGnU=;
	b=iMGMW1+AP/4HcbKeF6pbp3Co1it0nekDJR7mljsr5oAtbOpE4Avv74bSlvj0UHwdzmMNy2
	/d0cJ8VUYMLn94Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yicong Hui <yiconghui@gmail.com>, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v1] net: ks8851: Fix receiver error in 100BASE-TX
 mode following software power-down
Message-ID: <20260901194729.r9N1Z-4-@linutronix.de>
References: <20260901173925.96183-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901173925.96183-1-marex@nabladev.com>

On 2026-09-01 19:39:14 [+0200], Marek Vasut wrote:
> KSZ8851 errata sheet DS80000716D-page 4 Module 3 [1] states that,
> when issuing a software power-down (PMECR[1:0] = 10) followed by a
> power-on (PMECR[1:0] = 00), the receiver circuit can fail to start
> properly preventing communication. The Transmitter will still send
> data, but no data will be received.
> 
> The errata sheet also includes a workaround, which states that,
> it is recommended that the software power-down feature not be used.
> 
> Implement that workaround and drop the entry into software power-down
> mode. The ks8851_write_mac_addr() calls entry into normal power-on
> mode at the very beginning of the function, therefore dropping the
> second call to enter software power-down mode is sufficient here.
> The ks8851_net_stop() can only be called after ks8851_net_start()
> was already called, and ks8851_net_start() also makes the MAC enter
> normal power-on mode, therefore it is also fine to drop the call to
> enter software power-down mode from ks8851_net_stop().
> 
> This will lead to slight increase in power consumption, but it also
> fixes a sporadic problem which occurs at least on KSZ8851-16MLL, on
> which this fix is tested.
> 
> [1] https://ww1.microchip.com/downloads/en/DeviceDoc/80000716D.pdf
> 
> Fixes: 3ba81f3ece3c ("net: Micrel KS8851 SPI network driver")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The patch description matches the errata document and the change.

Sebastian
