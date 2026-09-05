Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C143451CD;
	Sat,  5 Sep 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571259; cv=none; b=nfm4PXoNsAa/38jAsglNvlcAWq08kY4YQzLEtRA46C/fVfTANu+5dthliKVEvRP8cTg3nHumX/HGUeDwN7kYa48vk7clLLxftE3QEfCVaBB9xr8PJwYVywMlzZoGRyO1pvWRrV1Nxw1su1gmtPgK1oDRHgwQ25knIDqktT5sRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571259; c=relaxed/simple;
	bh=1uqWMzjYhB+/p9aFKiVkrt9pHbKmdVinsZ1ddXopafw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xjps4pGlglLB/xPZFVL4oGOjkPbosKVWH6yVyFmZJXiH9FpL/DzfhiqcqcqANtwU3gPRHn5D1YYAcUQ3zGYYOB98+sXvDVVj/cQwgqvP33r1MmKmEMvcgCiQmING3DWas7i4E1FHmxwi2R3GEsVsqm+Ybp5dxKtPijuDPhAEw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5HeKfrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5HeKfrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692D21F00A3D;
	Sat,  5 Sep 2026 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788571257;
	bh=dXFQDMRpuC8+n06ZAFU1McYG4cVziz2MkxDkhKXuoQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d5HeKfrh46ToYV4qYyIq1dzyHYMqQe/E/AP4M4dK6Q/rmUBbfSgHBubvS0HC5x6qx
	 988AloHDFirj1uKDFw81vaoedpEIyBxpIiPsyiCpbzpNa9fyIEIECfuGVCjlmelQm6
	 91ahz33vUqZkpxc4btJ81q2+rVlNqqIOGw3+/wiZ3XXz4F3hnE8xXuPZ4YOYLRTaI1
	 GvxzFzjJWqG2WE8yH9UXep09yM50+mkWBmSbKxNSQePGsSFGYzw5wJqM5O57H6daaa
	 DhS6vo452niLT9Aw08mptPQQkjQIe3k2qEDnOMKIrb1XCV3sH+ZVuuhcyK8WAWljtH
	 AlB3VC5R9NEyA==
Date: Fri, 4 Sep 2026 18:20:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Wei Fang <wei.fang@nxp.com>, Frank Li
 <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: fec: support RX flushing via an
 ethtool private flag
Message-ID: <20260904182056.0d81cf1f@kernel.org>
In-Reply-To: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
References: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 09:47:29 +0200 A. Sverdlin wrote:
> The FEC controller can flush the RX FIFO of an individual receive queue
> through the RX_FLUSHn bits of the FEC_QOS_SCHEME (ENET_QOS) register.
> 
> RX flushing prevents frames in the RX FIFO from being blocked. Blocking
> can occur when the frame at the head of the RX FIFO cannot be forwarded
> because the ring it is associated with cannot accept it, i.e. when the
> ring's RxBD[EMPTY] is not set or ENET_RDARn is not set. When RX flushing
> is enabled for a ring, such a blocking frame is flushed (discarded)
> instead of stalling the FIFO and holding up the other rings.
> 
> Expose this per-queue capability as a runtime ethtool private flag
> ("rx-flush-qN").
> 
> Due to erratum ERR050395 (observed e.g. on i.MX8QXP), enabling RX flushing
> on more than one queue at a time can lock up the receive path, so only a
> single queue may have flushing enabled.
> 
> According to i.MX8QXP Reference Manual, "when both class 1 and class 2 are
> disabled, RX flushing for these rings must also be disabled". Both RX and
> TX QoS classes are enabled via DMA_CLASS_EN bit, currently tied to
> num_tx_queues in the driver. Currently there are no constraints on
> num_tx_queues == num_rx_queues, neither in DT nor in the code, even though
> having different values doesn't make much sense even without RX flushing.
> RX flushing code just takes min() of the both values for now.

For the errata - how is the user supposed to pick a queue?
The documentation talks a lot about device specific terms instead of
using generic easily understood terms. IOW it reads like slop.

In general AFAIU the flushing should be enabled in tandem with pause
frames right now. It'd be great if we can stick to that, or failing
that add a generic config knob rather than private flags.
There's nothing private about the drop decision when host ring is empty
