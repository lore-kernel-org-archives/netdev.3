Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984567;
	b=gcAwvwnNwSjcXWS7tYVojWMKdruxCpDONYTiNLfQheWWrv8wDDcOxbphQ4ZjM1senuDa
	 hU4sqvd+6jr/T9pe/bJ5wcZX33x+456QtwDKd2O7EFGBfQ9CyGkVe0VYcKd9rsN40FXwN
	 LE0rSjYCRQHmac3Rn22xzuXfXF3tTtc1D3iUwihbYXBy1OT2mw1RmqnqfEEttF78JM4Tj
	 pi5Sa6AiV9tEUcyXm+gsi6U/ID8kjawbIHqyZqL02tqCGn2a4VVmBAUWtmDz10xy99/Ui
	 Bsrjwog4HUAG473wvliCoFAZnDnOwdT/NX6NbL3wmd86qQTqYJek8Rjqeta+W8MEMUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=MS+gTF6wslZlgGDN/JO+bBUyZYzUrJiS4XnttIs3yeiaIm/KtfnKZSR6jYEJbAJjdvDm
	 AQr5HCsJx4BzK9m//PCC7+OjQtR4bBBt19LBD9Stb6mxcuL65BkYNvpXwoRiGi5Y3iIwQ
	 rx8euo8AOwLZesy3nYRZvzja7vPTEomJSaWEMCdpayeMj28s21yb3u6i/2341BxF+bVgL
	 XIdf8sjKUVGztmmrxGWDJFszZ5ZA1qokIWkjpx0UrkzenizAr85h9UwYnFEyIL8tykAlN
	 DPsP1hJo2MkyGgUNjpfaHadYnARO71djvucYe4eQ6+XPEq6+T/i37Lcn99grVPqn1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKt07GNb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A0606A31B;
	Mon, 26 Oct 2026 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKt07GNb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859E51F01828;
	Mon, 26 Oct 2026 03:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984567;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKt07GNbm60bTIyum4SARmNyh65H/hAhPcX9HlA7qWxCaPFKcIpbi3/bIrdjpdv+c
	 O2kj9EQZ7tLb5N2TvVhHTwEBdwkj87aKot22p/sOjk/fwkihbbuiuBal2Uj5bOMLBW
	 pofLOCA070sHNJA3O7sDx6XVK94u1Y5xuZnSl7ytERItp7sOO/OTonna4jhNnUBX4p
	 D2sXo245VgLV1bJTF8Slinq0iEbSGJeMaa8fKdT2I188Bz+UmD7LxAcgbg2g77xJo6
	 gMKB/1VzOdd6ZqN7NasmUYkNfZV0UwCAoggdnEvs8vKBdnF3bd63D0JUmbBzl8qkPo
	 J2Vk7X7Qh1TIg==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook <kees@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>, Breno Leitao <leitao@debian.org>,
 Jeff Layton <jlayton@kernel.org>, Kexin Sun <kexinsun@smail.nju.edu.cn>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
Date: Mon, 26 Oct 2026 03:16:06 +0000
Message-ID: <179298456608.3327.7131333915330908659@kernel.org>
In-Reply-To: <20261026030928.719276-1-bsdhenrymartin@gmail.com>
References: <20261026030928.719276-1-bsdhenrymartin@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
