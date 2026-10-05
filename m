Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E23A7848;
	Mon,  5 Oct 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236158; cv=none; b=beiNOOukcVlg7JC+Tl56t4w9SaQYskrmNOee6+gUr7bOrFarJ3r3cmSNoCCQA2BJBnmnjZxYCee90tqHlrTEyNswEN0sIVXIR0i8CdEpr8e/BlfJW2ukUo6RqdW9HS4Z3+yPu1DuwQNXKq4fQC6IzXaymuUqNtnQEiCZXHKUk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236158; c=relaxed/simple;
	bh=AsnU+mrz1OvPtX7gWIQchfvkLausToGNRwmmmgijMOI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NowCkodz4KbYlCbf4Ak6aqsIXB4+tYvHRWHylrWjenR+4270Pn7+0WvvvfRY4epezxMG+wxb00vSOU7tXF145Yb3wAcw4hZv/jIDW4G5l+B68bC+dQMMlWtL+BC+TB+9XWzfLZaUQdCR7y18BLH7QazxEt1BtPM/ak0mcS/vqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mKt54jND; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mKt54jND"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B440CA0573;
	Mon,  5 Oct 2026 23:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791236139; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=04nUUfkuoaGNpFX+ZzuVjD0cQk7qtFyLfVWrsI+wfco=;
	b=mKt54jNDGrOpLXFhDRYVYhYPB1PSLwUszNOMaG445b01jixwhHlXJTvhD1ZLYzQq26CbdH
	+I8u7dgFylVBQ+VjG9iNUCX2OkTO2h9dZJIW94pFCZQ3xdJ9I6S67B39NJ9WIv/Wpb0gFY
	W/7stu9eP9dO9p7xD2KwAS0A7cXa4bkpdeute2+RkSpW4/wdhrohj2ElFE5IoYP8RYQXlt
	kQZ5DAEJopwA6zIL/JDVPKjVMbIT4OLFABMF8SGXTPt9DOHPj8jbptLmEjwdIQoBdT7rM4
	FlEMv31DU2ePHGJS5EbTWtPla9pz2dOTrb2HCF2p2AmqBChCjnAXK1kajQNbNA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 23:35:30 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Subject: Re: [PATCH net-next 6/7] net: bcmgenet: pad transmit frames out of
 the packet ready window
In-Reply-To: <179121268616.434549.17024293577065479280@kernel.org>
References: <20261002-nb-genet-mtu-nn-v2-v1-6-96dc6d54cbee@tipi-net.de>
 <179121268616.434549.17024293577065479280@kernel.org>
Message-ID: <1baf50de2be64687a815202370a54c68@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 5.10.2026 17:04, netdev-bot+sashiko@kernel.org wrote:

> [...]

> At this commit, on kernels with 16K or larger pages and an MTU of
> 3809..3820, the threshold drops to 3584. Frames of 3585..3647 bytes 
> then
> get padded.
> 
> Later in the series, "net: bcmgenet: reassemble jumbo frames from 
> status
> block fragments" raises max_mtu to ENET_MAX_JUMBO_MTU on all page 
> sizes.
> After that, any MTU of 3890 or more pads every frame of 3841..3903
> bytes. MTUs of 3809..3889 pad frames of 3585..3647 bytes. Nothing later
> in the series appears to fix this.
> 
> Should frames that carry a trailer be kept out of this window some 
> other
> way, rather than by appending bytes?

I do not see a way. Any frame length can fall in the window, so moving 
the
threshold only moves the window. Keeping every frame below the threshold
caps the MTU at 3808 and removes the point of the series.

Worth noting the window is unreachable below MTU 3809. At the default 
MTU
the longest frame is 1532 against a threshold of 3840, so nothing is 
ever
padded. This only affects jumbo configurations!

The alternatives are dropping those frames or leaving the transmitter
stalled until the interface is reopened. Padding seemed the least bad, 
but
I will note the trailer limitation in the commit message.

> [...]

For the other findings I will respin anyway, so:

---
pw-bot: cr
