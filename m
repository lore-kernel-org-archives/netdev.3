Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249704;
	b=TZUYwd6lESXWyF6qtmmYggWzWhzkXCdsqD/i4QdPxiJSDl9D4iUyFbcSI7dzdDurcOtt
	 fna3LUYPmollbwcXA1YKYjoxwxOum2BjJUTUKwLSIrhcO9gqIb15RBp1lW6DIwNbmoiLj
	 SW5nfHmW/DeZ+w5p+s7/SC8ZF6oXNFHZImwhDVefVPI0+SAN1KL66eLu/dClpDWVtIvfn
	 k8OJAnFQf2o7OlZc3/DtCuufSwmj6hxlUXneve9Pm8hSTM8QFFeBolu9x1/QVEAeJh2SQ
	 rHvB+K7tcM4Gt38ElMZaifLDgZd9c8n1uUdziEFSzSSlhlYMMhrw+rjVOgOZPR5PqoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249704;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0HgPsE/yzQvxRg/VPiLYa1EQNmt4HkXJrFJ8j7/ZIqg=;
	b=A9ZHDsH69zySbcIraKy0HisAiRkhUYgktr5KDouQMdjna5rLboAwrWNDF+hnHJ0+YgY+
	 iTCKycwP6eFOneCYHDbLBthD0UlW57JuyeDZeYGSVMsj0fzhupI3HblLNj8Unwl0FRYf9
	 UhkT2EnkH9t2nOAxzOvzk01NW7+yreTBlgYCZUR6eDoaqRvDfJfBSROp1Q36FJHr+1HxN
	 stZOUyF39P9VoiIGLwNPckihwrkYx1pLzLsxp4PyOjUI+vtOnMabHFp+Spps+RlCw6pUn
	 w+fqhz0v9k1t3WY4Znr0Kbg0slzib3xegy/fzPel4Mf7TsmXGcSPRchxuI/MjteZvSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKE1YbOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6433606A31C;
	Mon,  9 Nov 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKE1YbOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F3B1F008A1;
	Mon,  9 Nov 2026 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249703;
	bh=0HgPsE/yzQvxRg/VPiLYa1EQNmt4HkXJrFJ8j7/ZIqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RKE1YbOHt98e6Oi+JFCzGCun50I+F/tGbM7H58hOMPlSWKgSnkjYczqaaOzkG73/b
	 tKP/OyUSsfaoWcNJAHw1mw1wP322eEBipOy6fMSb1vzCbF9kZTZlU2EDYy+5DvdWqg
	 7MIjJ7WqoKX0HWA3RSYUlmygl727Be7X7qJGU4WU4jkgQ0QypxU9gSvhH0T6FVXHBq
	 kaOn51XXRe/OU3Wb4XtGqOhOQAJk3RwUrWQ0nwXE8vPJFFSxrOzQVeo63LIvMgo2p0
	 FJa1UB9sG/XwC4b3tTZ8t5WGism29+QfPfKocPQZrPKXYXqzgeJAUjb0X2VS45U+2h
	 P26V/iWYwwFuQ==
Date: Mon, 9 Nov 2026 10:41:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb: Fix skb reference leak in
 espibug_workaround_t204()
Message-ID: <20261109104142.238b55e1@kernel.org>
In-Reply-To: <20261108101000.2147805-1-vulab@iscas.ac.cn>
References: <20260917105425.2147804-1-vulab@iscas.ac.cn>
	<20260917073655.5d7c9ecb@kernel.org>
	<20261108101000.2147805-1-vulab@iscas.ac.cn>
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

On Sun, 08 Nov 2026 10:34:46 -0000 Wentao Liang wrote:
> The cxgb patch is a small reference leak fix in an old T2 driver. A v2
> that also covers the single-port timer callback with the same pattern is
> ready; I will send it separately as one patch rather than in this reply.
> If you would rather I drop it, please tell me and I will.

Do not send revised versions of your patches.

They are all worthless slop.
