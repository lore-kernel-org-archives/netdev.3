Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790881;
	b=HKRtOic/AyDhhNBaEAwSnWekD1q8stGdiHr+OrUgUpSQkL3WkoRllv5RwKJMnb8SmJla
	 uue8PQXsiyPHv4iPOB5SVR28eV7AHqIBe534QFt2g4IuSPnguB7smZ7t7ckQus5kBx+yB
	 1Y+gnL7uVXUtF5uuMV6K2XKDXzvf2WNXpiAKmQBggYKGFeR+npIt4tF830YHj5vgTVuRI
	 WeN8lwZbOuRFlvchSUK5yqDt2Y9uCCj3ay81iviZ+oPb69n6/MIMe6dY9ypbTPPElUYGn
	 SbDAb5Dl76jwEd0RPrZCAfviRGjDSfk/h7cHIh4pLif0UGtscf0j/x/58Jr8V+3jO7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790881;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xMM7Ge/dTxyzn7HB0ZIs+I29KP01a/tEonbkKPexm/M=;
	b=ZGKSvMK+wfoxtHsS/4HxyOr7QKyZ6g63RGNgehA7sJYTCNZ3pTrOeB56ZfqxNPvrPhQl
	 ZSUgBleHy4O9tv1Q2GBP1cTA2Dk9WqcrzBjsIajTw/T5D3pnJlIpD1G0o0YJgiW3ZDEj5
	 39/GxMzLJArywRmfX5puUAJyByvBGLoc1gPmnkV2U8Bsambv5T78vI6AKj2IP5F2utUdj
	 xKjKdfdsvro4PFNiq6u0TMFcNusrTTj76ATw6fvkCiOJnkN19TyvtYVZdlK/iGI+BGs+T
	 hegtSUMSQZbC65AnW1JXSNMVUTfdGXw1av22Zpwordw1L7xsw0gBmo5ZOhfdQPigo2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MufEJFsj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE10606A31A;
	Fri, 23 Oct 2026 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MufEJFsj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5882D1F01825;
	Fri, 23 Oct 2026 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792790880;
	bh=xMM7Ge/dTxyzn7HB0ZIs+I29KP01a/tEonbkKPexm/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MufEJFsjNn53L9rNsbsfus/3V/0rYLDg6OvHKjfURPuswKi5MXrsPiExjHoRL7Dfa
	 vfbpged445VNsC0LfB+VElOaMeS6H9mJSCmE0A5zWFKY9LGWVmwhD0lc0/pZ+gFnW6
	 m5uTxYUh71EBqUPyKzA3haZ7D4IM5I48iCeeOscdMSmD5m9mkdNNwCv2QcS2gYBOX4
	 XGkYDfgarWLdMftfiJGZTccf3sv+2gZpAdwVKff1fnUs5YR0ezB5Q3eEaMgLku3RCG
	 W7vAlN/WQ7sVw3iciedb1UDMPCsLLkE0PgUnq3YqgdA86AjSlTAmNSECt5/Z8hSrBS
	 aROD13zU3aViQ==
Date: Fri, 23 Oct 2026 14:27:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Jiale Yao <yaojiale02@163.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Daney
 <ddaney@caviumnetworks.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: octeon: mgmt: drain TX cleanup tasklet on stop
Message-ID: <20261023142759.33b51535@kernel.org>
In-Reply-To: <179229680286.3290.9156952367563364577@kernel.org>
References: <20261018040634.533757-1-yaojiale02@163.com>
	<179229680286.3290.9156952367563364577@kernel.org>
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

On Sun, 18 Oct 2026 04:13:22 +0000 netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

You must include this info in the commit msg. Also the patch reportedly
conflicts with something else on the list so dropping it.
