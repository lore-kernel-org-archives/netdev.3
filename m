Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057818;
	b=o+/kU3SSXBbEeu9ffSbAIpNQmRyExvPEjDOCa7qKMOVs7OEODIbjPt78xsEwIwtynFEp
	 6C8DNkOQxbe61Cu+mdLrHmD2xNit3rSedxktwz2Dz5FPMnu7R00hQPSB6LZTrVOzndz3o
	 whQg4sHdXxqoGiFsB8akivpu216goaXBBopdrJ1/nRswotwkv/qfDc/I+dcglMdry/rO2
	 QnoztLurJ24LaforEJa1nsN+Wtro1VWurgPCiz2awK2fc0jkVeOh67N78n/4Gyy+aSQQq
	 q9jUXe0Zoco21d8EGFFYWkKQ4RXQ76c/SXzdollOuqyYeMBL3m0QFHZSRoc9g++7C+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057818;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iZ9qlG7Qoyxd+eBKyw4IThIbll3a9n903uIiotpa1Iw=;
	b=xvnCGBOQhpeKze32Kts5OeEgIIrjvWXN85p7J73Dx6iTdQkuqLvhnNYLLj9yVrzLfBIQ
	 rMEw5IIzIM7AhKd46FzK2Huxw6jPHTWc0D/LrqUAQEP+DJsBllOh+1xHemgTt7ovQ1lHe
	 6DhZUsM0LOtnKKHDsMddCnF+zWDHK9XxBO//AqgbRn5bNaWuxe5vfxMEXggLZBqUPZkca
	 jjW/bQldZOd7VuinE6nP8AZv5OMoKBVNLvIVONFSokBnXw+icDM7rFLPn3RIkJK8Say1L
	 eeZrHgOWLS0yMDkntstCLLHrG7Hr7T/Gu4y8yym6UAnVBr4oG8yCmFKWpyMeVrjSDFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RpckNBo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A7606A31B;
	Mon, 26 Oct 2026 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RpckNBo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4891F01825;
	Mon, 26 Oct 2026 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057817;
	bh=iZ9qlG7Qoyxd+eBKyw4IThIbll3a9n903uIiotpa1Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RpckNBo/u8QrMl2KzA0AZfAoj58ytndZ4l0klp4DwiHcNxkyOqW1U0eNJUboD+q51
	 gV9II0XW5nhkCBSt6kRTpCo7nNFm3rPRlltibU10DbYLd41PllO0XG+PsQ7CT412DE
	 y4gkUpjvKNO2uPSrRNQdoKX6KwBH3Cszv9fTxKcpj8JUcQv0l5kX7ei3O0xsoiM/Ws
	 bCZ5WYMaT2l2dZb213A/x2kwdVphU/HZo8AnKF/rTyybIju4nrCgP3ikgc5zC6h/GQ
	 FbYvrFx8CNqmQ19gjMSNfOIpQz0tBp24HeUaEqFE1zW/yHHi1GIRt6Bq7E153bo361
	 rYQCSldOu9wPA==
Date: Mon, 26 Oct 2026 16:36:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Justin Chen
 <justin.chen@broadcom.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Florian
 Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] net: bcmgenet: fixes for a failed resume and
 the ring rebuild
Message-ID: <20261026163656.5c1e7a38@kernel.org>
In-Reply-To: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
References: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
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

On Thu, 22 Oct 2026 10:54:05 +0200 Nicolai Buchwitz wrote:
> Florian, Justin: if you have a board where the WoL irq is actually
> wired, I'd appreciate a run on it too.

Florian, Justin: could you LMK if you'd like use to wait or apply as is
and test later?
