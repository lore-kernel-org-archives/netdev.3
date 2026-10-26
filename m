Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058428;
	b=JnEyqJsLm9CRe0SANgKVHbVcpep+f1AqTdbnnaOq8nqxy3BChYP11H0I4WGwdjrG/wXC
	 7Ja7/UKTN/X+n1/xN2B4RNGoOgPGoopT6NY+b8GDPHsy9RC7AbO/6WOAiV3EI6//F9Ye7
	 F6A4rgdmO0X2ksGmoTVP36okIM6rRwhG9cs3xHv2vhc1XCSxYJ7ULHWeE8lw0GKpIpiiO
	 Slcf1s8k2ooZH//TW9Itxx6tetPW0twAwlZhUdGPeay3zaMccg0Yuqw/PV+Ias1qe8nrR
	 ATYgUYqtXdBGXsQg/khTFrIH8Vind9piVY6PhFVHKEZzmRrdygymir1vErrdOC9yOHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058428;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HXZKbYcynQLTbFDm3Gu8qk0pYJCsBAblYFk5BGMFFls=;
	b=lYEQqaPrAtIkpWjrDwEzeDoP29ciYkSkAXmRrZumzIe5I/XV8btPXjPXf7K3CwYmdNIT
	 zqTbWEgv8qc2NPMQFjPqgOlJceuihfLtMCeRh4pGE5KzP/7msmKndcS9+qN6wF/S4CtHb
	 hli0WERGZitLCsKWUue71OyQjk92zFsiqiV43zpInTqp6w0NgD9mTHy2q6eIOocEkXqOw
	 yBn8DwRxb64J1T5KZJZU8TuCfVY+9xYVvuVPRLQ6mOAFKRfkzXEe2zaX7xxtc1zGqeEpK
	 mR4z1KZ/oy9RdFxfh2rPiTfsebgNSerml5UJ2qbbVtPI65nmNtumJALFIMzXFBVpM2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjhWGHV3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276B606A31A;
	Mon, 26 Oct 2026 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjhWGHV3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D561F01825;
	Mon, 26 Oct 2026 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058427;
	bh=HXZKbYcynQLTbFDm3Gu8qk0pYJCsBAblYFk5BGMFFls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cjhWGHV3PB635bLfXP/tf12iJDzu34gM3azvhTbLHkmE6G2UeHP3tpU4a+8r7ecLV
	 N7Z4OkZi3680l50Ov4IX46GPWdl1vs7diNbNrbCaL4LFE7r2xnOhAoByPJNg2lcJNZ
	 yMGj/dSyjTleiJPUgOYdiCzTNOc8y302iefOwONGog/GV//ABSkcgeVOWGpSFxoF3C
	 T4eE6uq5lozf2iF0VgAcA2Y7S6Mhx/2S0f62BPoBd8Uez/A6v9DINt2aR2kYc65aA3
	 TBbb1NGJWjiaQmKkW0lJVzu7ER1mgUf3HKdVzcsLCB8NZ5LySOz3D108I5z1jbwTl1
	 8ZYk9OO/4/3Gw==
Date: Mon, 26 Oct 2026 16:47:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com
Subject: Re: [PATCH net] vmxnet3: stop DMA mapping the adapter structure
Message-ID: <20261026164706.6847e39a@kernel.org>
In-Reply-To: <20261021221221.502428-1-kapoorarnav43@gmail.com>
References: <20261021221221.502428-1-kapoorarnav43@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 03:42:12 +0530 Arnav Kapoor wrote:
> vmxnet3_probe_device() maps the whole struct vmxnet3_adapter with
> dma_map_single() and passes its address to the device as the "driver
> data" (misc.ddPA/ddLen) in the shared area.
> 
> The adapter is the netdev private area, and alloc_netdev_mqs() allocates
> it with kvzalloc(). struct vmxnet3_adapter embeds 32 tx and 32 rx queues
> and is well above PAGE_SIZE, so when a high-order allocation fails the
> adapter ends up in vmalloc memory. dma_map_single() then warns
> ("rejecting DMA map of vmalloc memory") and returns DMA_MAPPING_ERROR,
> and probe fails with -EFAULT. syzbot hit this with page allocation
> fault injection.
> 
> The driver data is only informational: the mapping is DMA_TO_DEVICE,
> done once at probe and never synced, so the device could only ever see
> a stale copy. The per-queue descriptors in this driver already report
> no driver data with ddPA = ~0ULL and ddLen = 0, and other vmxnet3
> drivers, such as the one in DPDK, never set misc.ddPA at all.
> 
> Drop the mapping and report no driver data in the shared area as well.
> This also removes a probe failure path and the adapter_pa field.

Sounds fair but this does not seem like a real fix.
If nobody complained about this failure mode for 13 years
chances are we break more than we fix here.

Please repost this for net-next in a couple of weeks without
a Fixes tag.

Also please remove the "never synced" stuff. That's purely
relevant for intentionally hamstrung kernels. This is virt,
there's no DMA to sync other than swiotlb.
-- 
pw-bot: defer
