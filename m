Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B72233A;
	Sat, 18 Apr 2026 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540403; cv=none; b=kP7HARvsnae4Tg3h1F+KB7c51xIbqF4Kou1hkPCRyE5ClI2pG0UvgfbHbpibM7mSt1wxmVZGMrc37gveq1wirSbiST8sd4Sz+VX92lQg1FMSflLFFwptxziihgUdh/yR8M0KUZAwAfIjysvW/E5I6lJsymTKnHm6XMDodwjT9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540403; c=relaxed/simple;
	bh=DHrtp6rAT2XyegdBwkwqlJVeG5TU31X9Y2DK5NUH0N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO5uggOYtaykuSd+PYZP4wPpRQKBU02SW90PpsIg0eIxCMQ4u63pta93YJt3lGSLtxKV9elTTYSvANO+o1GWMQgG8tIYMdY+K4LANykkERHE05kTCyJxFlwtsYyqK02jkERTc2wrOdcHZc8pJOQk0XOL09hhcikJwFoWXUiVNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByZsa5nj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByZsa5nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F08C19424;
	Sat, 18 Apr 2026 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540403;
	bh=DHrtp6rAT2XyegdBwkwqlJVeG5TU31X9Y2DK5NUH0N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ByZsa5njLnQGk1HcrvEhP8ZtOa8XAFSNbXisIjUD9ZieDOR6ZovSZZsK1GVmFOs6j
	 Ccv9vOzjqJZ33+st0Nrp/W1f7Wu2LKYzCXDLzs84oY/9wks5FlC0BTuLFoPtTyvH+Y
	 ZcZQdftpYUb7vabTrbhsgrBzBxciIStY8sy3tKtjnctYfu3eYMuC2wgacguqKs/J1l
	 tH5e+bCC5878vLcOXrTpE+EKClCQx/ewvOobz85RnCXTIzeqNV4nTIa9P5QTkU1rAh
	 Z0v0Ye85NkjueIGGw6fI/Bicd0lqCRyTlfLaqBVa8PDcahH5YUOOSHA4QAiuxlr0bG
	 3+cwJcawFUpFA==
From: Jakub Kicinski <kuba@kernel.org>
To: qingfang.deng@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-ppp@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	hataegu0826@gmail.com,
	horms@kernel.org,
	kees@kernel.org,
	kuniyu@google.com,
	bigeasy@linutronix.de,
	gnault@redhat.com,
	ericwouds@gmail.com,
	semen.protsenko@linaro.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulus@ozlabs.org,
	jaco@uls.co.za,
	carlsonj@workingcode.com,
	wojciech.drewek@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net v6 2/2] pppoe: drop PFC frames
Date: Sat, 18 Apr 2026 12:11:45 -0700
Message-ID: <20260418191145.213625-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415022456.141758-2-qingfang.deng@linux.dev>
References: <20260415022456.141758-2-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pppoe: drop PFC frames

This commit drops Protocol Field Compression (PFC) frames for PPPoE to avoid
unaligned access exceptions caused by the network header being shifted. A
helper function is introduced to identify compressed protocol fields.

> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
[ ... ]
> @@ -434,6 +434,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (skb->len < len)
>  		goto drop;
>  
> +	/* skb->data points to the PPP protocol header after skb_pull_rcsum.
> +	 * Drop PFC frames.
> +	 */
> +	if (ppp_skb_is_compressed_proto(skb))

Does this code safely access the PPP protocol byte?

After pulling the PPPoE header, skb->data points to the inner payload.
However, the new ppp_skb_is_compressed_proto() helper unconditionally
dereferences skb->data[0].

If a crafted PPPoE packet is received with an inner length of 0 and no
Ethernet padding, the linear buffer might end exactly after the PPPoE header.
In that scenario, this would read past the allocated linear buffer.

Even if the inner length is greater than 0, could the payload reside entirely
in non-linear paged fragments, causing an out-of-bounds read?

Would it be safer to verify the packet has at least 1 byte and use
pskb_may_pull() to ensure the protocol byte is in the linear region before
inspecting it, perhaps after the pskb_trim_rcsum() call?

> +		goto drop;
> +
>  	if (pskb_trim_rcsum(skb, len))
>  		goto drop;
[ ... ]
> diff --git a/include/linux/ppp_defs.h b/include/linux/ppp_defs.h
> --- a/include/linux/ppp_defs.h
> +++ b/include/linux/ppp_defs.h
[ ... ]
> +static inline bool ppp_skb_is_compressed_proto(const struct sk_buff *skb)
> +{
> +	return unlikely(skb->data[0] & 0x01);
> +}
-- 
pw-bot: cr
