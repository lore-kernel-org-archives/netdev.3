Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208217;
	b=f/bCEIrGDFA5uDJ2ktWukiCHF0aoG7P46awoau+e7ZbOktQOkjZwKRBL2NDm1ewzFtY+
	 R7LksRNKKjoKZlZivBFRk6vqoxmnnOnkNGSUG9yaqIjaqGWnmDy6GT2rd8qOqrqtGU5UT
	 SeGGAWTJ7uCVOvrRw0mKTKEGXxDHByXAzNIoMxkMDRZFQ4hvUsm3Lc4PExTt872mzoAUk
	 3IZVqYIy/Vk97/qUsr4WhjGgdvB1dH2IFAkbX167CyuBTS/1scppF1+K0NShAjJeHb4Ro
	 Cxeioww+Z5A3ZZahCJOQYQryKwmL4J7F9mwI1jNzHvPYync+Yk7r1q2v7QV77YmUsFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208217;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T7vJFC3Wg/d5PIXaik+pg4rNV8+aKUM3fMPWRDZWFtU=;
	b=HKRDuex3UoIR2nECaO60aVBZ5rfLOXFubeGWS1VTo3Js+8D9IJW/GYOHRraxz16X7H+p
	 C+1CVoVDpRzjBvI6cue5Nr+aYn/VWKBMe6TEcwIrjEc2FXrp7q7Lc1pZBByGanLP9WvY0
	 L3CYAKjdYulrkj0vgpv/8awJYpo/ft+fsjO9qLAlrAY5Pc1ScAN/lZUo7WTkNb+1UrFGE
	 F3zRXd8jsPrRAi1wNv/I7bgpjmcSuuB/ulxqEk1S57NF7vHAlzVkQjd56xWM7tUExvUcB
	 nKmsr3++3DN3JXmvfagC97x5kJrF4eH+hIcrNmkAQEc90+lF+P1TZ+hpQnYDjmrB6Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft7f4sFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A57606A31C;
	Wed, 28 Oct 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft7f4sFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39041F031E0;
	Wed, 28 Oct 2026 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208217;
	bh=T7vJFC3Wg/d5PIXaik+pg4rNV8+aKUM3fMPWRDZWFtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ft7f4sFAkJ23OkuFr6wTqEafZWkP8BQj9XJiwPfvEQdh16mDEzncQbidS53AndTCz
	 8Sx72sZLCCjdMJhB0klAIxJ1FmRQOD6BGblxQWbNNy5FcpDghaCwqv6isEkmVErsQ1
	 0kxMQ3vr0umBlr++AUhwb/G42RiBidFnBj6+6VD+HQ/VSZRc7sU7XueV4syo8oiJfP
	 9ptNnvfpj8k9fPAPmDNtF8ifhx4NoV/0ILFvnZeDqkH0RGeJ/oIdVk7HY90Ia3qQsT
	 PUk/5wXvQBCUeUFLwxpSLFlSOao7mMTRZdBDbsbmxIDx2EjkdLGEHK+2TlrHp8KT5I
	 cES8tVHxGlyVA==
Date: Wed, 28 Oct 2026 17:23:32 +0000
From: Simon Horman <horms@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: bcmgenet: restore the Tx coalescing
 setting when the rings are rebuilt
Message-ID: <20261028172332.GC257209@horms.kernel.org>
References: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
 <20261022-nb-genet-fini-dma-net-v3-2-6e9fc89c0156@tipi-net.de>
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
In-Reply-To: <20261022-nb-genet-fini-dma-net-v3-2-6e9fc89c0156@tipi-net.de>

On Thu, Oct 22, 2026 at 10:54:07AM +0200, Nicolai Buchwitz wrote:
> bcmgenet_set_coalesce() writes tx_max_coalesced_frames straight into
> DMA_MBUF_DONE_THRESH and keeps no copy of it, while
> bcmgenet_init_tx_ring() programs a fixed 1. An ifdown and ifup or a resume
> then puts the Tx coalescing back to one frame per interrupt.
> 
> Rx keeps its value per ring and reapplies it on init. Do the same for Tx.
> 
> Fixes: 2f9130709d2c ("net: bcmgenet: Implement TX coalescing control knobs")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Simon Horman <horms@kernel.org>

