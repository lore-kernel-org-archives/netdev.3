Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792542059;
	b=0lF9x7T0U0fZMa8Xxm6Jldp5MHu2XvnsOANh33Azarq0zen/05GmVhv6CfkQNsvcu55b
	 qiLzJAVuFNHZ3nRcTg+hrkMoeLTj0ihWSpVAiY1RlCUqAT5W2H0h17uhxIFxSxAp6ZsLT
	 RgTOwOYc8Ne+fG4xNC32XSga4mYMhxdLgGLzBTy40PaYbXN9jVqfJp7ilD31f4gbstOWm
	 lv9ImarGfqAR++ay5LzPsZUk/babjSIJmP9A8ay06u4TPAQoVcOEvse2slw75u3T10Xpa
	 xuYbLQL5XkZdZFKMhqwG/9L7dYmCtO0nIqWD6tE0UfrSgBR27ri06VeMq4MtJJRxFkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792542059;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=spGaKP3thDpDBnv2EckEpiVWNFJtxHxSxvQHnY0tfC0=;
	b=D3N4UsxAst42t3VEx/hP0/B42zZDwJvHg/cGNRU49zIhPQd12MIPXyqyNqPGsac2+GW0
	 84JZEh6tVuqvCGJ/B7PU7oZm4qDSs8vZ+gRx3OSI2iqnPs7h9KNNApyi1bitsfC06wCgG
	 0es2RLm6ywEXOzJ2mzTaJVokh16obazGj1+PVBh1yjTkQVyJmNVxxS/iK16yqP8h+3JYk
	 58jFn4RgkZu6+d8AArQOb5X/9zrS6+BbUbVCmgBOVx+/Xqah7BM2rPXs6/GGRNnX5oYRH
	 3/ZCxZUMx7kYuZYFLhLq6tgbA8gI6uy50Mpcz+pHk20ukIznJtUSrhdprF/ESOUnbhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJOMYuwc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF46606A319;
	Wed, 21 Oct 2026 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJOMYuwc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E071F000C9;
	Wed, 21 Oct 2026 00:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792542059;
	bh=spGaKP3thDpDBnv2EckEpiVWNFJtxHxSxvQHnY0tfC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RJOMYuwchYiWLTsA7cassk+EW2nLv8rG4t2FrUf6sN/2vhGw52wOTbdFpTxVDv8Ah
	 MOwvsYY4cd6HqeIOBpopHt60zSGO26CuOGAvKXx2uoMAlQUNwZ/HZ2jbIkyv7bgXAm
	 hX62zJ1Cg+NfsIS+gGcN8MWHhFqBLs+vnjoPIaJ70z+Vo01PPxYf2qhIhW3+GxSMyl
	 FYMXBioldBHB+b4BSeMGxFKS/aAGK67VWAhS2MU2ZxbiVQV4SGQLbsyXLFECwmwvpb
	 0G0oc7OVl8R75YS8Mj4yqg45lRf1gC6EMqawsmbUi3cjgkqkCwAXBfUfzWV1cjKC7E
	 nOJChyfN9FD1A==
Date: Tue, 20 Oct 2026 17:20:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: rosenp@gmail.com, netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: don't process RX with a zero NAPI
 budget
Message-ID: <20261020172058.5201fa38@kernel.org>
In-Reply-To: <179228366859.3135.9158616222630607774@kernel.org>
References: <20261014001912.141532-1-rosenp@gmail.com>
	<179228366859.3135.9158616222630607774@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Oct 2026 00:34:28 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] In drivers/net/ethernet/broadcom/bgmac.c, bgmac_poll() still
>   acknowledges every interrupt source, including BGMAC_IS_RX, with=E2=80=
=A6

looks legit=20
