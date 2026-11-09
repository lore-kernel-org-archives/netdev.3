Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265351;
	b=0zf4Dpi0ZhdjAUyRHbK+5RFAi2vCJmpeIYmgr/YoAf8bE7znXKkYq8h7qnVbgQw4rVWk
	 w3ZLmpOHfBzdqnd1JDKSDj+3MbHT/J4Y3MlExJ6PetUwf2qLPAC9TFKMdMxrmIB/5uuWm
	 VH52gZb8G51UjBXMT5PfRNuVO6UkruCNcQqPs4fvgsfd9Wp5LtEiBOmuwUzIG+KcwYNp4
	 Bvh0Yvf6lb3FGb5It8H0jClQzATopFRIUusSkyrQW5xg2jCpX6Rajcxirc89RAlFhq+5M
	 7tzx0NbrAF+/50wV6d/4E8AQVeQFB+6wHUdOHh+yi1oNIv6pnWFJEm/jMzk5wXpP2vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265351;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=46y7602YTfhoa+pZNU3EQ9THKts6U3FC1YzFDGUGHTc=;
	b=aPtUaopIBq7hsDW3L5EjzmUu0x51SOjaUMaliGDQj11COU8yaWKiL8GrXjYhElSyAxoQ
	 4GDJhUGF22I51qYfW3hwd3+VBjDFXxahJdi3I1LvbTmXYA28DHECI2qzybx/1QKkfkaKc
	 ZeAYbqpmzt1FXhTEw1EPfKF2mcyAzo35f2qdlAuqbZ7ZlC+EzNq2CdfLpaMbflZ75waCR
	 1VqIbDblf2yij1aWLMQpgXVTSvh1pjhkTHyFDsea8b366XP4jwM+gunTfiGEE9ppNv9pL
	 aH2yBh9FLsc78G6d/ID9c1QDmzfOyGoF9BtPM20SOJCsMDueaofuHxKqV1QIX3VrwIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlAsxvae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195E606A31C;
	Mon,  9 Nov 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlAsxvae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256CA1F0089F;
	Mon,  9 Nov 2026 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265350;
	bh=46y7602YTfhoa+pZNU3EQ9THKts6U3FC1YzFDGUGHTc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FlAsxvaeMDArxHIG/5wJJHfkfp6cWYTGd6orowChaqxjdPh0oNkTaBW+wdBYMnyvJ
	 QhWuW0G6AbHhVuZ+tAQtv1VdeZ/rteLzU0AfMIdHz5EM5VMOPXOlq0sOATfXxJl6Jl
	 ClGt1EZY3+heaT0G0rf9Fmd4ogukJ7CaVwjrQNnF5alYsKFgX84o1KjUBk/4fdc6r1
	 SD5/Pa5A+FPGnDYABZ2zD7Tg6hmfvMq2WrTyFlkhZtZQagHeh3DN1T3Ed2/V6lWDU1
	 eztxJXzQlIypPHhdk0+AMTmos9dWoGOhffa6mDs3vXzG3uFzMxh35yy613YvQUC30m
	 Jfd05qHiCLihQ==
Subject: Re: [PATCH] nfc: llcp: pull DM reason byte before use
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:02:29 +0000
Message-ID: <179426534967.994134.7609721697490865811@kernel.org>
In-Reply-To: <mcyWWpY9VDnsb1o6EnHOMwEinRkPRORIx9_O6DMiKhWHsDIrbITdgbL2PkFkJKgxIIs_0euqmOIT9eCZVFZ9-F8y_g_dFysV8EEOHP6UxmY=@proton.me>
References: <mcyWWpY9VDnsb1o6EnHOMwEinRkPRORIx9_O6DMiKhWHsDIrbITdgbL2PkFkJKgxIIs_0euqmOIT9eCZVFZ9-F8y_g_dFysV8EEOHP6UxmY=@proton.me>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit has no Signed-off-by: trailer.
- [Low] The patch fixes an uninitialized read that a remote NFC peer can
  trigger in nfc_llcp_recv_dm() (net/nfc/llcp_core.c), but it carries no…
- [Low] The commit body is written as a cover letter or bug report, not a
  changelog.

--

nfc: llcp: pull DM reason byte before use

This patch adds a pskb_may_pull() check for the LLCP header plus one byte
at the top of nfc_llcp_recv_dm(). With it, the DM reason code in
skb->data[2] is only read when that byte is actually present. Until now,
__nfc_llcp_recv() pulled only the two-byte header before dispatching.

> nfc: llcp: pull DM reason byte before use

[ ... ]

> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

[Severity: Medium]
There is no Signed-off-by: in the trailer block. The only trailer is a
Reported-by: that names the commit author.

Documentation/process/submitting-patches.rst requires a Signed-off-by: for
the Developer's Certificate of Origin. A Reported-by: for yourself doesn't
replace it.

Could this be resent with a Signed-off-by: so it can be applied?

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 74bf817007cf2..733e643e02234 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1276,13 +1276,16 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
>  }
>  
>  static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
> -			     const struct sk_buff *skb)
> +			     struct sk_buff *skb)
>  {
>  	struct nfc_llcp_sock *llcp_sock;
>  	struct sock *sk;
>  	u8 dsap, ssap, reason;
>  	bool connecting = false;
>  
> +	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE + 1))
> +		return;

[Severity: Low]
This early return now drops truncated DM frames without logging anything.
Before this patch, a two-byte DM still looked up a socket and moved it to
LLCP_CLOSED, using whatever byte happened to be in skb->data[2].

Should the commit message mention this change in behaviour?

Other malformed PDU paths in this file log a message. For example,
nfc_llcp_recv_agf() does this:

	pr_err("Malformed AGF PDU\n");

Would a pr_debug() or pr_err() be useful here too?

A separate point: the commit body reads more like a cover letter than a
changelog. It opens with:

  "Hello,"

It also includes the notes about the AI-assisted review and the tree it
was done against, and says the patch has not been compiled or runtime
tested. It ends with:

  "Please treat this as a report for verification rather than a
  battle-tested fix."

Could this text go below the --- separator so it doesn't end up in git
history?

> +
>  	dsap = nfc_llcp_dsap(skb);
>  	ssap = nfc_llcp_ssap(skb);
>  	reason = skb->data[2];

[Severity: Low]
Should this carry a Fixes: tag and a stable Cc? The unchecked read of
skb->data[2] goes back to the commit that added DM handling:

Fixes: 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode frames")

A remote peer can reach this read in two ways. The first is a plain
two-byte DM:

__nfc_llcp_recv()
    pskb_may_pull(skb, LLCP_HEADER_SIZE)    /* only 2 bytes */
  -> nfc_llcp_rx_skb()
    -> nfc_llcp_recv_dm()
         reason = skb->data[2];

The second is a DM sub-PDU inside an AGF. nfc_llcp_recv_agf() accepts any
sub-PDU with pdu_len >= LLCP_HEADER_SIZE. It allocates a new skb with
nfc_alloc_recv_skb(pdu_len) and copies only pdu_len bytes into it, so
data[2] is uninitialized tailroom.

That byte decides whether nfc_llcp_connecting_sock_get() or
nfc_llcp_sock_get() is called. That in turn decides which socket gets
sk_err = ENXIO and is moved to LLCP_CLOSED.

Without a Fixes: tag, stable backporters may not pick this up.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/mcyWWpY9VDnsb1o6EnHOMwEinRkPRORIx9_O6DMiKhWHsDIrbITdgbL2PkFkJKgxIIs_0euqmOIT9eCZVFZ9-F8y_g_dFysV8EEOHP6UxmY%3D%40proton.me
