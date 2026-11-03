Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696962;
	b=ePXet+y1arB65rZJ7ZzuSXtVqCjdFZIj5T9x17PEGDgoKx++rjWVXYsnX/aKyt3hIp/b
	 /Naa34xoE3Bu+4yaW5MmchvRjCXql9okPp7xGTt0YaB9c8Z66VYiWsxDFY76zKP1lTk+8
	 zAzLPQe46kWgxBsx95AD79CLgbguZbc5V3sGU+cpktmkyrQ10udVSUiuO6xHhQQym0l6p
	 PqN0MVCXB8bvycnWtyRhE9kXECECBZ5gGBlSWZj0wkQ4uiWtr3Eupf7wIUfJY8TDZA2Hb
	 Nv+spnOtsZntqNmYogwCHQNBtR7vhWttDLc0Rxpfqc5hTJBr0+LCL36blKxNxZ8dY3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=cXSM7UB8Q5WAzFOHLK79Wv1frjT19UzX2lpXF5Un1wamFumWR6g+Z57YxMxFs0punevY
	 6sh0Dr/6u/uIj21tQFruouCiJaYGnrMkIie0r4wyhiADuoy7iCXfw/3WIGNSt8AKmHu7b
	 CwQobe3E+Q037MVnJbiX4KQy5y+Be7NYWSl6eU3oVhbf1PyCsmJNbaJ0O+gZCZ2GnGIMY
	 0O4O0ixjeCXw/173MSNA/wXpanRA9ahWMA3PMRr7eN3nwRRlOXtpMVh2Ldd9I4K/B5QZT
	 1GfXpMQqVROTaJ6Rf84wlJOjscRql2968y4lrDyqvQ+2KXJUIobcelibhunpHdB5EZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNX8CWrq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC114606A33B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNX8CWrq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE65F1F00A16;
	Tue,  3 Nov 2026 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696961;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aNX8CWrqQLTCTGVDtlmB0yiSmtjbR7hnrfAzxkGfoh7Nk2kvR2UNw9POf5fAy9Q7M
	 vLWtkA8VVuN4isLS42G+dwqc3QHT21tvNUlueihbrP+VkAAhnqqK/HqsBIjdSk7cSV
	 1dxd+4pz9hsay8in2LUL7uqPDP2gdb9ToL6vYk5PpkNBfVmGq6sxHll2Q8s8F95Fn7
	 QTsC1XIEVZHiTmy6DoJi/oKi68A1FYeu3x8s+Oq504w44oJbeuoBZ5chEnvWrZF1nd
	 Z0S8wOvXg/Lw41isVHCfVdOhNXYzoOct6cZxLyXa/dt+Brjl1VvDG19EqYM97UVGCQ
	 MGPI8OwkMPhVA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: 
 Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
Date: Tue, 03 Nov 2026 09:09:20 +0000
Message-ID: <179369696044.488859.13046087773855353137@kernel.org>
In-Reply-To: <20261103090011.4128420-1-edumazet@kernel.org>
References: <20261103090011.4128420-1-edumazet@kernel.org>
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
