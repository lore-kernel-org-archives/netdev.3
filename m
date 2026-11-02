Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647255;
	b=SO2GCLaxOMpjvDCzEfp2tKvnOn6bF/zohE+n/TjWrPubaDJOIM0aH0T6SmDGTJbjE6pz
	 xEB/S0RkcC1rnmMy5fy/QeXn8oTFsZir0LiDn3Jh3w+yrvcYCV96tWz1resgSJwav0wDm
	 dIbz/+Y3dg9EAf0H2gPhuBEaJNTmY+mzoU3x1uf904rRFqDaXymdgbKXlk/NhYYc90zas
	 Jes+vVEunoJJkydQEBvsDdzMz8N9TmqsjzjEqoUtLUh5PYz1qS1lWkdpnf+GwJyuTHAiU
	 ayAAI3uQk2R6DKuYHWsuwduwyw78w2+FpGfzCfjc1FhhgqWZUu034INpZYHvkKv5/xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647255;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=gJOGge4aaLulSjcadcuAVrGsVwMeKac0qCTO8+iW3MU=;
	b=JSOXaXDPUHsPUbpfpvOe3tRBKq/INdCq21SWw0dpxYV3AxSQTv8LWT8DOUNZZrB33xGM
	 WQgcJ12kWuZYcZpIgITmQ2VQnkumHoDDKvYA/sClr/0h9lNvS1yCAgOiyl+O83yl4COg9
	 gQXDxFSIi8cG2WN/ESBdhDFzYhs7qq2hN7BNOw6B0seY9wOcvVg5srBebVwMcAkov3CCV
	 fcdOEcM6Eg1WefUOWe78QMmsXKrt2ojEUbiJDoWMqqT/UAAJq2nviBYZ2nXBF5+d6riRc
	 8/sm3Dy0hwoqVvMsakJhZ3cc/d0aBv8caRi7gu61OUCv7TUZn12uH0bWMQxXkUf1s3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=t3AzeywR;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=bfCBnQcD;
	arc=none smtp.remote-ip=160.80.4.36
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.36])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74030606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74030606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=t3AzeywR;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=bfCBnQcD
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6A2JJuou028168;
	Mon, 2 Nov 2026 20:20:01 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 649AF1228D6;
	Mon,  2 Nov 2026 20:19:51 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793647192; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJOGge4aaLulSjcadcuAVrGsVwMeKac0qCTO8+iW3MU=;
	b=t3AzeywR5+y1kZoChyiEMEiMLbPxc7pQKh2pCCItFQzVAvK26AdhKjTRTus/s9RZ5MHSNm
	9R+AMxJfOPYoCvDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793647192; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJOGge4aaLulSjcadcuAVrGsVwMeKac0qCTO8+iW3MU=;
	b=bfCBnQcDFzuSOU0m97IRajxRBkV5sE+faOiT0T+aicA0y13aI+C9La47KgS3Le3sEjk8R6
	NXud74m/7XwQlvN3vj8WplRO4ctL8DAUVVwPG8DY4N21b6bXsSxzKV5+2sRS6Etmtg23aU
	mwlwEQdr4FG5SaNhAq2kJrxxR1CHJuow3s7eb+ZEHKnoIw9GyTEdlyrDfMw50WG3AOcM+y
	W+smPJvFQ+VbMYvHvBVjZxitecQSwkmnZzUFgq9oWerQmJZ40Kd/1ziY5JJpenpc+Ea9+2
	8o66d/Q6XfdOiMNby4U8yX67lAUD+qD5lzduiaXOt+4vAkIW93PEEXZOPYpEFA==
Date: Mon, 2 Nov 2026 20:19:50 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ren Wei <weir@nebusec.ai>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, horms@kernel.org, pablo@netfilter.org,
        contact@proelbtn.com, vega@nebusec.ai, sashiko-bot@kernel.org,
        petalzu987@gmail.com, liuhangbin@kylinos.cn,
        Stefano Salsano
 <stefano.salsano@uniroma2.it>,
        Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org,
        andrea.mayer@uniroma2.it
Subject: Re: [PATCH net v4] seg6: validate state in netfilter continuations
Message-Id: <20261102201950.3cc03ae412787a8bbacedae0@uniroma2.it>
In-Reply-To: <c9ec4da483c6c17dda703bcd6fc425ef2b53e320.1793207060.git.petalzu987@gmail.com>
References: <c9ec4da483c6c17dda703bcd6fc425ef2b53e320.1793207060.git.petalzu987@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sat, 31 Oct 2026 11:26:44 +0800
Ren Wei <weir@nebusec.ai> wrote:

> From: Zixuan Chai <petalzu987@gmail.com>
>
> Netfilter hooks can replace or drop skb_dst() before SRv6 continuation
> callbacks resume. Validate the current destination and lwtstate in each
> hook continuation, dropping packets with missing or incompatible state
> while preserving direct no-hook paths.
>
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Hi,

The commit message still does not say how the crash is triggered, what
it causes, and how the fix was tested. The patch is tagged for stable,
and this information helps whoever picks it up there. The Sashiko
review of this version also asks for the trigger and the impact [1].

> [snip]

> +static struct lwtunnel_state *seg6_lwt_state_from_skb(struct sk_buff *skb)
> +{
> +	struct dst_entry *dst;
> +
> +	if (unlikely(!skb_valid_dst(skb)))
> +		return NULL;
> +
> +	dst = skb_dst(skb);
> +	if (unlikely(!dst->lwtstate ||
> +		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6))
> +		return NULL;
> +
> +	return dst->lwtstate;
> +}

Right now, the callers do not use the returned pointer. They only
check whether the dst still carries an lwtstate of the expected type.
As I mentioned on the v3, I think the two helpers should return bool,
for example seg6_skb_has_lwtstate()/seg6_local_skb_has_lwtstate().
Is there a reason to keep the pointer?

> [snip]

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/c9ec4da483c6c17dda703bcd6fc425ef2b53e320.1793207060.git.petalzu987%40gmail.com

Thanks,
Andrea
