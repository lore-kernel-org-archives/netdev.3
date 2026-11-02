Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620574;
	b=49Yzr3iqgk0hhRRLJDqj0JqQ3jtILIPwWmTH1+fVf8BqZYKFsrZH8zga/wr4ssp/eEBm
	 2V4Pzk85qcRkJcwNOp1qlG37dhIDwQNiFQNVJ1d+u5HiVebkKAt9e/EnW5E0yEAg0SC99
	 2Rr1eDycebZ7tK9eKZXJPAiVV3WZuyiH8343P16P/oFeBw0Tlg1E+Rlx4A80iHT4T+QUJ
	 t+G1uCA8ca537WN/nubCbGCmdolmNRwlvDXrsLkKPHc1j3aNutbHdilK7Ay8a0uLaHGfc
	 vbZm5I3e/NKemcuTjk8L4CoWqvBpC4+BJnadYSEeTADvnBoC6ZruVxBs033Um5oW34A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620574;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=edBP2A68Bu7W9EkTwCHYe8SPLgIZpJkGOjQwcfidHTM=;
	b=PgpOSObhuAyGw3ENpkAqDQjUB9iXajcCq39hStIg74ln+SbkMrnyeItUmYjT9dZpIsRB
	 tT5gzsmIAh9Mq1M9n7qL35qYGwtQCWZ3rJT8M2he9gT3OrN3m/6LpKasCKk4Rux6fhki+
	 ftTtrzFdxl66m86MRPj4CTg3lDRSWsbkDIjavGVAJotG+4Rx0Ykey1+T4fnZEP8gcz5AX
	 r2Eu36uZxkiG4os0NZ9F2CscvgAgZjSBcBKHvrQV59qQVFjhKEi2IDHVfoJ0/8gBNkbYF
	 lamplOpNNQiG5CoZSsczMt+azYsKhUl5f8t4Mk5040FzPezMmaWOWBpln7DaQtfzWfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZB9D6Xzw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52384606A329;
	Mon,  2 Nov 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZB9D6Xzw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782D31F00A16;
	Mon,  2 Nov 2026 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620573;
	bh=edBP2A68Bu7W9EkTwCHYe8SPLgIZpJkGOjQwcfidHTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZB9D6Xzwd9V0KWzgRay9qxu3z4JVvBe4OPAVsFf203Woxl4RClT/YrnH6K4nBD/na
	 DXtL9XYKSyieJh/JWVUVynigesvd3ygarNHTnkfg7MrJmJR5YacNNkCNyQQF+c7pJl
	 3p50jOAr74+5d8wBFkSjxBIpn5fbI4SMJ7/79+4qA1KtDo/zEXZh1igH9a9px8QOHy
	 wVlqSwLKt1LcsurRaPG7r4LuT1AGaEnWfjXeI13Ikl5Qmhry6E/wsxN3kbfGR4NJ0m
	 X5b1RKzvfkaGlqz1BXZrPz6dbdxN3LU295cMpqF5lx0H3AXYt+Jfk+3PuemaIss+26
	 miSzc4QBzyN2A==
Date: Mon, 2 Nov 2026 11:56:09 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
	horatiu.vultur@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5/lan969x: release the in-flight slot of a
 stale TX skb
Message-ID: <20261102115609.GA257209@horms.kernel.org>
References: <20261029-sparx5-ptp-stale-tx-slot-v1-1-ec15f391bbb7@microchip.com>
 <179339983815.3131.4933059375204484548@kernel.org>
 <20261102091449.oigddj44eapymqua@DEN-DL-M70577>
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
In-Reply-To: <20261102091449.oigddj44eapymqua@DEN-DL-M70577>

On Mon, Nov 02, 2026 at 10:14:49AM +0100, Daniel Machon wrote:

...

> > [Severity: Medium]
> > Can this decrement race with sparx5_ptp_txtstamp_release() and count the
> > same skb down twice?
> > 
> > Each port netdev has SPX5_PRIOS TX queues and there is no
> > ndo_select_queue, so two CPUs can run sparx5_port_xmit_impl() for the same
> > port at the same time. sparx5_ptp_txtstamp_old_release() unlinks while
> > holding only tx_skbs.lock. The busy path decrements without checking
> > whether the skb is still on the list:
> > 
> > drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c:sparx5_ptp_txtstamp_release() {
> >     ...
> >         spin_lock_irqsave(&sparx5->ptp_ts_id_lock, flags);
> >         port->ts_id--;
> >         sparx5->ptp_skbs--;
> >         skb_unlink(skb, &port->tx_skbs);
> >         spin_unlock_irqrestore(&sparx5->ptp_ts_id_lock, flags);
> > }
> > 
> > A possible sequence:
> > 
> > CPU0
> > sparx5_ptp_txtstamp_request()
> >     skb_queue_tail(&port->tx_skbs, X)
> >     sparx5->ptp_skbs++
> > spin_lock(&sparx5->tx_lock)   /* waits */
> > 
> > CPU1
> > sparx5_ptp_txtstamp_request()
> >     sparx5_ptp_txtstamp_old_release()
> >         /* X looks older than SPARX5_PTP_TIMEOUT */
> >         __skb_unlink(X); dev_kfree_skb_any(X); purged++
> >     sparx5->ptp_skbs -= purged
> > 
> > CPU0
> > ops->fdma_xmit() or sparx5_inject() returns -EBUSY
> > sparx5_ptp_txtstamp_release(port, X)
> >     sparx5->ptp_skbs--
> > 
> > At HZ=100, SPARX5_PTP_TIMEOUT is one jiffy, so crossing a single tick is
> > enough for X to look expired.
> > 
> > Before this patch the purge path did not decrement, so X was counted down
> > only once. ptp_skbs is a u16 and the limit check only tests for equality.
> > 
> > If the counter wraps to 65535, does the SPARX5_MAX_PTP_ID limit stop
> > working, so that ts_id values can be reused while they are still
> > outstanding?
> > 
> > The same window already lets CPU0 keep using X after CPU1 has freed it.
> > That part predates this patch; the double decrement is new.
> 
> This fixes a leak seen in normal operation. Each lost timestamp keeps
> an in-flight slot, and after SPARX5_MAX_PTP_ID losses, two step
> timestamping stops on all ports. The lan966x twin (074caa30a627) is
> already in net.
> 
> AFAICT, the wrong count can never be used. The second decrement is in the busy
> path, which on the very next line unlinks an skb that a purge on
> another TX queue has already freed. That use-after-free is
> pre-existing and crashes before the count matters.
> 
> I am working on a net-next series that reworks PTP TX timestamping and fixes
> this and several related issues.

Thanks Daniel,

I agree that is a good approach.

Reviewed-by: Simon Horman <horms@kernel.org>

...
