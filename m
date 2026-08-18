Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B319046E;
	Tue, 18 Aug 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079812; cv=none; b=K9mGU4i1couNyk3/SXWW7rpAEmeKdURVcp0HA7LpWyvPVtXT6o8A4qkl5D+e+UPs8wvhd1iQ18Ap6iTPc4h3nr7NZCZy3dZ3PNujVEhvwLddTfxPX/TQKGydfu1rDrmNXnIs2KdLJQVslHC60I5euW5p1fsZtL+ZDPhiebYlodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079812; c=relaxed/simple;
	bh=6Q9MYq1RmIPk511y2ywuJgKjIwIoL35aGBAHqTs255g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEipCl2SWEwUjKoFY7844jnlOuiPEe2XJnizPt5BFHrpwoq+z2FaCAOc8a+TQ5gNrARqMFptH5n7YYmW5CjGe2kOwEkq3nsbltuqqoGYJoHzHtYvgnDhPA/48Dz0DdDSwtcfSdGlkvsqWO/MSYl7L0eRbzEisYQ48mfEpWdjr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz4ZlfwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz4ZlfwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95DE1F000E9;
	Tue, 18 Aug 2026 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787079811;
	bh=F0e5+G0vV5Well2KvOFevtSAKjhaDqSGAOE7M0X8n20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fz4ZlfwIvk0wGnzj+3WNm8DbVQBpil0+dtxkBgm1eW0wDaiflOSuuWW5/aK1RkjDj
	 phehXPFU2A+wVcPDtjNPNspEUIWhm/VuaD1g2lkCj5LG3BNdlH8U2c2xxQQe3hl01i
	 11bep7GjjNIo6qU7SaV6Lrj/qJ8U+fWxAK7zBq+jipj9C5+HdHSRJIDRsviv2sGe7h
	 G8BElFrrRoUP6vhn8Jip8PQM8beLN/x+zTx8Ul5tbBytcxzBEd9voo0/VbPnr8k3NH
	 h11BNWc0r0NRjVG6W8wxJa52ocUC87wdczs0niVUhVYaZ/NB3lWRA45E+K3w4F9kzF
	 jkvpKMuZuCSwQ==
Date: Tue, 18 Aug 2026 20:03:26 +0100
From: Simon Horman <horms@kernel.org>
To: fy15309206903@gmail.com
Cc: Mika Westerberg <westeri@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: thunderbolt: Count delivered packets in
 rx_packets and rx_bytes
Message-ID: <20260818190326.GI265046@horms.kernel.org>
References: <20260815-tbnet-rx-stats-v1-1-8da375c2cd09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815-tbnet-rx-stats-v1-1-8da375c2cd09@gmail.com>

On Sat, Aug 15, 2026 at 10:21:52AM +0000, Fan Ye via B4 Relay wrote:
> From: Fan Ye <fy15309206903@gmail.com>
> 
> tbnet_poll() increments rx_packets once per received frame because that is
> the NAPI work unit, and then adds the same number to stats.rx_packets. An
> skb is handed to the stack only when the last frame of a packet arrives,
> so once the MTU exceeds TBNET_MAX_PAYLOAD_SIZE the statistic reports
> frames. tx_packets is bumped once per skb, so the two ends of a link
> disagree: at MTU 65330 the receiver reports 16 times the packets its
> sender sent.
> 
> rx_bytes has the matching problem: frames of a packet that is later
> dropped mid-assembly are already accounted, so it does not correspond to
> rx_packets as documented. Account for both where the packet is completed,
> and leave the NAPI work counter alone.
> 
> Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Fan Ye <fy15309206903@gmail.com>
> ---
> Seen at MTU 65330 on an ASM4242 host-to-host link, where a packet is 16
> frames. On the receiver rx_bytes/rx_packets came out at 4083.9, i.e.
> TBNET_MAX_PAYLOAD_SIZE, and rx_packets ran 15.9x the IP layer's InReceives;
> with the patch they are 65308.3 and 0.99. At the default MTU a packet fits
> in one frame and the counters already agree, which is why this went
> unnoticed.

Reviewed-by: Simon Horman <horms@kernel.org>

