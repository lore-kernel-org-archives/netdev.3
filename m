Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430932;
	b=KY6VpsaAacyOcQh7Hr+w+8Jxfj/446oq0jx+bovx/vCdhvFi9xCla4fWv2Dh+d20qdmO
	 Z+Yomfd+M36KxIiB7kWWamtCUBsXVxOpBM8qIyyp2kcp+BDhHki4/UXjk+wGykYtt1Q6l
	 07T0s/yhVuqpeBJT/rxiSw0RLh6yN/6+KJj+o18qmW7nstpImtp6TLL5I9x7AmHXunyZR
	 cHSg34z94iTVx4WPXsk7Xm/F6vEqxk3O8+Z8lp1LMreokNy2DPi7D9tACKq+gb4ymUs83
	 a92/hWn3A/7/yh5+MHv4SUGPYGDX/c3CeL2t8eDN72WGOiYTzozkCQFOpw6/UVMrYgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430932;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ymiCoVfnivIzWbD4HRyFQxVEAH6xqE6XmG1Pklu+dH8=;
	b=JzfA2d8uD6ix+j197UumEyqFWpxKQyk7cXzye32Ru0igeeWiDuvc+pzw06SH3wDDbk0S
	 2sIGfNHS+lbgxyo3dtl5/hU0IGqLhQKmC+TCXQI/Uvcs6WmRnwzaaCd9LLOdvdKs0L3rn
	 63qINFeNLcw4ppfm/pza/VNPxjq57RT3Znn5p+FZus+6uMVlfJIlpVK3UrJOtm89hmok1
	 LhTZBPZ48etRrreGsVnLhr+BbjXvJWA+uknEDXN7DjZA1Rv55+1dCsz7f8TzMWmQ5iUw0
	 xBDZ9djnawVkHYgFfZGm/9ALqGsoJ+baYG56HeDPpU6PprH7WOaRZSa64oxru+8S8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSeWptPk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF13606A328
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSeWptPk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DCE1F000CC;
	Mon, 19 Oct 2026 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430931;
	bh=ymiCoVfnivIzWbD4HRyFQxVEAH6xqE6XmG1Pklu+dH8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PSeWptPkXnDZdN50LUmmXmn3FtBt7A9V+yPoo3b9b3/wbrcmjYzMCtOF+qVWFd7gv
	 aDm6HGwvtu0MWHU8yGqk/Oq5vzbho17hiOtTzMUVEfsLWyyEGXjMlITJVqWCrEamHK
	 whtX25+Sc1MtYvYFFt/6QxiWHTgPWUJ71lZYrs36mNmbrrWo/pCK5gThWdYP4ToC7V
	 9+7q+gwYuF1ouytwRzQ8N32z5LuWCS4LPyovWhcOTsyAYgXkQzNDMA9gWQv7tzCD+j
	 I05SQxMcsN55FWlwmBTMZFvqW/AzlVR9A8I8fmW96zC8suNPX4AOEc7ATSqxhYFJLU
	 5qBYkn25otYXA==
Subject: Re: [PATCH net-next v5 11/14] net: ethernet: cortina: Account RX
 buffer size in truesize
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:50 +0000
Message-ID: <179243093087.3135.5982028940228797936@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-11-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-11-b5c9e2f7b8a3@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit "net: ethernet: cortina: Account RX buffer size in
  truesize" fixes a long-standing bug but has no Fixes: trailer.

--

net: ethernet: cortina: Account RX buffer size in truesize

This commit changes gmac_rx() in drivers/net/ethernet/cortina/gemini.c so
that each attached RX page fragment adds the full posted free queue buffer
size (freeq_frag_len) to skb->truesize. Previously it added only the
received payload length (frag_len).

> net: ethernet: cortina: Account RX buffer size in truesize
>
> gmac_rx() charges only the received payload length for each page fragment
> attached to an skb. Each fragment pins a complete free queue DMA buffer, so
> short packets understate their memory use to GRO and socket accounting.

[ ... ]

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
The message describes the old truesize undercount as an issue being fixed.
Should this commit carry a Fixes: tag?

The line being replaced in gmac_rx() looks like it came in unchanged with
the original driver:

    skb->truesize += frag_len;

Git blame on the parent commit attributes it to:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

The other patches in this series that fix bugs from the same commit
("Keep shared free queue parent-owned", "Drain free queue IRQ before
resize" and "Preserve in-flight free queue pages") all carry
Fixes: 4d5ae32f5e1e, but this one does not.

Without the tag, stable tooling may not pick this fix up along with the
others.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
