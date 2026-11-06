Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966287;
	b=CD+zPdOpEDDHOGDPzpNAFnJWmbjX98axqTFAMaT7FQnGh2EhYFaWYm+jWj7nplSfsJri
	 qk43zAOu5LOBh0tJCyiGMH24qTEw9zZoB2dvcNKLioD4wejwlHTCBEkeCfMuxjqRgtPDL
	 4imAS8YWkPBBYND7ylb9it+SVSXUDfLnFWfj4a36zoyAVTEhtb226wVH5uZ+FXucIBpGe
	 D82i/UFYapvf2ePOF8lS9y1n8l3smgYZ958gSPJ/8J0kMDBXrv+xi8WF7y7SkXM52XdFz
	 H0lH7zPJWMROuei2ZCur39RSYSfpStPmZcP39foY2yDmHFzA/KGIR0p7se6TPkb7ewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966287;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qXElk5PugpyVf5k3C3F++pfZccLi0XswczLgnJkFEG4=;
	b=QO7m6bRqUgP0qjcwWDqUWRfpDkfin3VGg0jmT7TReXt6hQrqVH2uv4E+RumAherWtZ41
	 benHsgeDTifw5aydh+zlx/NAbvtoQB0fhcxRjRkWtJ+/SJf4bJc9D3rJftuk5KeMhvGZu
	 5wDIjWGo8Rxpi6SBGzxBgguzFYy7l03nGIM7DOOI5K92LrIHr/16+p8bPiQgYs5cUo0x3
	 md/kGtiTKp2z4Mde2rGW4BH5hkXt3uhbdtZiowmwQWoKjnJXjlza1QMpjRpalUURn2R4s
	 HPiXPjuI9EWtCNPBpoVRl0naxkOxFeF6s4Yupgh1xBC1hAkw329LMAxaVOR+skSj9pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLvpteUb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D65606A326;
	Fri,  6 Nov 2026 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLvpteUb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2BC1F0089F;
	Fri,  6 Nov 2026 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793966287;
	bh=qXElk5PugpyVf5k3C3F++pfZccLi0XswczLgnJkFEG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NLvpteUbgbM1MYjR7Mrkw/WaMj1a39/DTWFVzmsrR0BfS7PAOa65se0l3DVIrl0iV
	 bWybkg2regLRR2bf3SryoG2VTP7veKXzS/TzajJINJm9IY76Z2kqjaMi/dLCf58pPe
	 QwiQQahCXguQ3vaV0W00Yhi7T9lIbqsim1ueK2oT1NOOtZy9Yx6GVdb4ehmg10zN6P
	 DsHWEecLWZEtd0sXUfSJv2qItPtynMjQgXq9O5CLqecxY6US4OfzD/56W3etouhYmH
	 Er9WlLma/ZtoEGA8EmF900yoVzgxAAqLLPKnDxyY4eHuHnJ1sfeSay03+eLwQZeiH5
	 VoOFS0Exxt46g==
Date: Fri, 6 Nov 2026 11:58:02 +0000
From: Simon Horman <horms@kernel.org>
To: "Jesper L. Nielsen" <jln@pascal-audio.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpts: keep port and
 direction when matching PTPv1 TX timestamps
Message-ID: <20261106115802.GG865646@horms.kernel.org>
References: <20261103-am65-cpts-ptpv1-v2-1-e1f79ed1ba60@pascal-audio.com>
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
In-Reply-To: <20261103-am65-cpts-ptpv1-v2-1-e1f79ed1ba60@pascal-audio.com>

On Tue, Nov 03, 2026 at 09:42:52AM +0100, Jesper L. Nielsen wrote:
> The CPTS reports the message type of a timestamp event using the PTPv2
> header layout, i.e. the low nibble of the first header byte. In a PTPv1
> header that byte is the upper byte of versionPTP and always 0, so every
> PTPv1 event is reported as message type 0, while
> am65_skb_get_mtype_seqid() reads the PTPv1 message type from the control
> field. To make PTPv1 match at all, commit 1b9e743e923b ("net: ethernet:
> ti: am65-cpts: Fix PTPv1 message type on TX packets") overwrites the
> whole value compared against the skb with the skb's own value once the
> sequence ids are equal. That throws away the event type and the port
> number of the event as well, so a PTPv1 skb matches any TX event with
> the same sequence id on either port. For PTPv1 this defeats
> commit a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port
> number to identify timestamps"). The overwritten value also sticks for
> the rest of the TX queue walk.
> 
> Since every PTPv1 frame reads as message type 0, the hardware timestamps
> all PTPv1 frames to UDP ports 319 and 320, including Follow_Up and
> Delay_Resp, for which no skb waits. With a PTPv1 master on both ports
> whose sequence ids run in step (e.g. a Dante device with primary and
> secondary network started at the same time), the unclaimed TX event of
> Follow_Up N on one port is still on the event list when the other port
> queues Sync N, and am65_cpts_find_tx_ts() tries to match before it
> checks for expiry. Sync N then gets the transmit time of the other
> port's Follow_Up N, and the master announces a preciseOriginTimestamp up
> to one Sync interval early to every slave on that network.
> 
> For PTPv1 replace only the message type of the event with the skb's and
> keep its event type, port number and sequence id, and compute the value
> per skb.
> 
> Tested on AM62x with ti-linux-6.12.y and the port number commit backported:
> without this patch every boot in which both ports started PTP together
> (10 of 10) sent wrong Sync timestamps, with it none did (0 of 29).
> 
> The bug was tracked down, and this fix and changelog drafted, with the
> help of an AI coding assistant (Claude). I reviewed and tested it on
> hardware as described above.
> 
> Fixes: a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps")
> Signed-off-by: Jesper L. Nielsen <jln@pascal-audio.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Changes in v2:
> - Wrap the commit a23c657e332f reference like the one above it (Siddharth)
> - Use netdev comment style for the new comment (Siddharth)
> - Collect Reviewed-by from Siddharth
> - Link to v1: https://patch.msgid.link/20261030-am65-cpts-ptpv1-v1-1-0bb4c370d970@pascal-audio.com

Reviewed-by: Simon Horman <horms@kernel.org>

