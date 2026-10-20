Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522957;
	b=QwQgTL2ry5ye+V/eCNTfATESQfslBSUoRI1N4PV8hksLf9YQ1wr0fLcqzWVgf7h9xTpP
	 uo5p4j7cgxHYvZwle53kUex9bchiZzy7rf2+N4hhxFSvgD8I7f0hcbzLR75jTHaUo9hMv
	 PnNPj+jjYqA6mkv/glxDyIHnUZTNFAxs//mPNpBlF4+tP4TSYe9/+/F8dSpgJ4VIN1wjo
	 IcG0U7utBEAS7yHZ68hJPhYoR5SAw6Mjpsens70YT1KJqZB+F1ee8pU7yJXZGTNwSrUrF
	 hZNVokqvkJRWKXUkj5qY51RzOwlNLeaUC45bV5sZ139Mqdj8PMixtgfIIqULyL2Uv4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rW/jACDVaEyqKtByUIED15cmwLmekwhz+6PLjSz/DjA=;
	b=2iO5CtfCwQg86w36RByfu4WFFpkNWQ1BcMFO779juH10yl/hR6q5IO21oOS7I+IUoyKy
	 fcxAH8rFPXurRtxkg1Ldu5obn2tx5bpi7AFVNOMn/tY5gtq9CqpOGfWZfCILSON1u3ITZ
	 /HPKWZ8sTQlVtmPXmdFhrQRZgS3uzDbV0nQ/tWYEh2vQuwMVb/NEurOr+K2MThn/wM1u8
	 DbItm4qAAta/ivXkwM1cCvhBFEYc5MPskI68HKKfyWaTXK0TvqCRcfYkR87Z7NoHR4q7m
	 4/IX4WgA5v42CxhG5Ln2o8zko5ymm2DfFta0flwfMBtV8pR9Y9gC61OXnVZVG9G4+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUO4nI+T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667E606A319;
	Tue, 20 Oct 2026 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUO4nI+T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0BD1F000C9;
	Tue, 20 Oct 2026 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522956;
	bh=rW/jACDVaEyqKtByUIED15cmwLmekwhz+6PLjSz/DjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XUO4nI+Te2i5KM8qqTYtd/L+cznicBaVPwwEp5BgGNSIdKDMRTXE5GCh8ZPi14K9j
	 735dKLZ9y97zLOSo89SwFO5UZWimzUTMeocRnpsZWOi3HNMFZ5qMar9xaNCekoQn0l
	 cyehfFvvAx9MCC3lttBA+PDO4AHi7XJaCBQsXbGrMuqGMxDpF4Hi2sJekj5z8bDJ7S
	 NvHCDesc0VD5gBTpF8lyDmCDctmiEw9o5Y6zu63CAhigXHUBx0T2K0Ibk1fyC9dV9a
	 +FC2V1B/lFigXXgKvx6nUBI+6f2u4/KKfHvL4+z4C/npeKpgYTkymVBHXkpvRLfAp2
	 fA/yTdu77s9JQ==
Date: Tue, 20 Oct 2026 12:02:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <hppiscas@163.com>
Cc: Elad Nachman <enachman@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: prestera: avoid overreading a short
 firmware tail
Message-ID: <20261020120236.56f680c3@kernel.org>
In-Reply-To: <20261014032540.14311-1-hppiscas@163.com>
References: <20261014032540.14311-1-hppiscas@163.com>
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

On Wed, 14 Oct 2026 11:25:40 +0800 Pengpeng Hou wrote:
> prestera_ldr_fw_send() passes complete 1024-byte blocks to the loader
> and then sends fw_size - pos as the final chunk. Firmware header validation
> does not require the payload size to be a multiple of four. Consequently
> that last chunk can end with one to three bytes, while prestera_ldr_send()
> still loads a full u32 from it and transfers bytes beyond the supplied
> firmware image to the device.
> 
> Reserve space for the rounded-up transfer, use unaligned-safe full-word
> loads, and construct the final word from only the remaining bytes with
> zero padding. The firmware image-size register still describes the exact
> payload size. Preserve the existing native-word load and writel_relaxed()
> byte-order convention.

Sounds like well formed image should not require such writes,
so why not reject such send calls as an error?
