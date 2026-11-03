Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714230;
	b=SxthROSKiEud3MJnLHD/wP/LQGv4jnObY1CIHnaO1LbUWbda4LOWUUBVPrZaCnvwwPKp
	 EimWdIw5ucT02pMIiV4jH1c0gotgnrFFCBLMc7I+imrNdG6pmySzMZqWN0klq1JLu++Nf
	 zmw86/4+Y4qv8eyziPXVER+MdaOBRwB4W3Z1TUqMA0jNdmY0TVgo4Q/oi0FwoEEsJm7yJ
	 GQtZCl/fzvsE6T5ICw8W8v0D2Wnb4SizsNggXBdsgd9GGdpLMGzRwv4BbVrT4pzabrNuh
	 XQqYtbf23rXo5PDCIc+s/ApXi6LBv9NypcCAZZv6v7viyFDtZLEWYcQaqSvYIADFkgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714230;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=lcg1wBxiDdcDGgK7Dz3chEfZ6MvrdqS3Jh/+FcQy5Sg=;
	b=xS1qLjVCM7sVHxcjeG/woCCc7fU8V5+KCuhnZmKx2G6AnagAiEoMckvliin77a66rLhC
	 NtHpQVhytvxVsKJ+mdmAXtYJSiNPndABL4+Qt8S370/7+3a6tLjm1CECFbc1fQTGcGXs+
	 td+6VU1InLEsFWpVP/sWKZDX6P4xwzmyIc5Ad7VPBO+cbvwCLQAdt9Jja5sg2eahhh8pE
	 IeKnhqNf8dY/sRoE62ffgRgjT1p1vFQwVlXFmbcxeKNNtZpRxpLrBSgCs/4hsLvye9PLK
	 VzRadLVvLeDQCxbgaDEBO0PkITjXUcFzBY6zhxD0LtHfZ98oy3kbc68fShuvEZ9Obnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=qNi5cLVl;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A7606A328;
	Tue,  3 Nov 2026 13:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182A7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=qNi5cLVl
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACCC3A036B;
	Tue, 03 Nov 2026 14:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793714227; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lcg1wBxiDdcDGgK7Dz3chEfZ6MvrdqS3Jh/+FcQy5Sg=;
	b=qNi5cLVlSfUYbpjb4RcosnYY/OVuGLypm+UftvZAGws4OFdmSrE/Yb+jZD0LAiU85GuNCE
	UDlu0Y6FYSNMzT+/VtF2gt9GeYQ7WjmLP09jNyMUQabQ6+bacZN7XOF2qP89N2d8t9jafR
	5ju20EeK3QXBIaQtixADDhtX+8Uxh9eT2mwtvcHw6UvJm5n5ly/MLVKeIf7kox4BUxW23h
	PFsSdPVkzA3y6a4Za0O30jl4jpO31Vmz8qJ2Bl3MdAHlsdsytpj3N24IdebuOBQlOJ/hKg
	0ZhSbqo4tLqsbAMw/s36gfRyvnTupeHhGE/q8+mcWLWPePx6zDMkjLxIHwvsPw==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 14:57:06 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: selftests: Add missing endianness
 conversions
In-Reply-To: <20261103122249.951523-1-maxime.chevallier@bootlin.com>
References: <20261103122249.951523-1-maxime.chevallier@bootlin.com>
Message-ID: <d0629035094621d224bc30fa7fda09ec@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 3.11.2026 13:22, Maxime Chevallier wrote:
> The kbuild bot found some endianness issues in the stmmac ethtool
> selftests [1] let's address these.
> 
> In practice these missing conversions didn't cause any issue, as the
> masks / values on which the conversions were missing were either always
> 0 or ~0, so skipping the byte swaps lead to the same value being passed
> anyway.
> 
> [1]: 
> https://lore.kernel.org/oe-kbuild-all/202611010511.Mk620DTd-lkp@intel.com/
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
