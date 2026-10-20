Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523156;
	b=B63pX4DUAtV2FfmU8u0rx8TJJteJHm27WmkjwkjUfcft+0Oy2DaGq3c3XuzPXI8j+YBE
	 3+VmHPr3awZ39tsmNtDJpf1cx4fSEzkpaQAfIc2TTyfCtCJ57EGIEbCmp0mvIEX1RzLit
	 H+UYvwOkD0HLtTugvH4+QuQ+1iJW4HYNfrGG4j9iKoL0mw316lwDnoumF5uZYxAgTk8se
	 Ican0ojsnp/HVI1e4/XpIzLJT+xBAfKfbH1dzw+3wOvxKS4oXWaGFSW3WPWrC9cI41awv
	 b8ujq+fgnYFeU/5cOm7I9j1hRm68xGzWBmZBpJN9oQktNowhplWucYh4wID/Qz6V8kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523156;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OPUieOgixUtlEZm2khANVbxuEzFoeGkE+eSrcmmNdHw=;
	b=KNGp8kCFFUiYJEVjGexgMokS8pShWHi7MD00aZBcoejCk/2qX7eeHv3jamAgHrLOq0cB
	 +A3gqqLb3037oXPJgUNr3j2XH4T9v1jETc8dfcGNJQhCzwQS4/Z2r+ArGEnGInpMOgnEW
	 D1c0lSwgvbTOmT8oeNHooCZwOa3GUHy6KwL8ErTjIAiFL2iqqXQ4w3wmzSY7oPJjHzVVs
	 JsRDCVVEcoR9uMGmdoSaATHPKBCa8gYO9QXqVX92iiiGhz3f7O9UOWuQT4ZthABxcpm6h
	 ZSs7iF83qzAdL1nEZL+xcW/qq//DIF15TyK3laqkn3l4Z5L90qcyjWJXmIEM3aJZqrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuNot+fg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D27606A323
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuNot+fg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6741F000CA;
	Tue, 20 Oct 2026 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792523156;
	bh=OPUieOgixUtlEZm2khANVbxuEzFoeGkE+eSrcmmNdHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OuNot+fgXHbV2vpbFF1YbOHyVhXJ+BAKEDiqgeheTSbUgFUEyo5bmKklu3odX/tzD
	 ygwvGIMz8OxtLDbwmN8FiIrhlGKnXKUqXL+hiPSWNebi3412N+JOIDYQ28JeQ8B+3w
	 Bg5+QGB5XpEsi8NGUlaIHVDHu/Ap2/cKptJDKJB1n/qJfO6y4XByZ15rDrSAiJIePY
	 7SmPm7x7uOepeFamRgpuIUygL9MN7hO7Kaf5FsDNFuWhOKnTNXR+u4ybWVeka5Ao2O
	 eKWYznKDDNzveRnBsw/XRgDYoc+mINZZjseNmDX33sXm+bQW8VRsTXn4g2FmDq+uf2
	 nWpPILKVYB+mg==
Date: Tue, 20 Oct 2026 12:05:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Claude <noreply@anthropic.com>
Subject: Re: [PATCH iproute] iptunnel: use worst case buffer for tunnel
 ioctls
Message-ID: <20261020120555.18bf4986@kernel.org>
In-Reply-To: <20261020154636.1097849-1-stephen@networkplumber.org>
References: <20261020154636.1097849-1-stephen@networkplumber.org>
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

On Tue, 20 Oct 2026 08:46:35 -0700 Stephen Hemminger wrote:
> Subject: [PATCH iproute] iptunnel: use worst case buffer for tunnel ioctls

Please tell your bot that the correct tag is iproute2 not iproute
