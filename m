Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CD36B91A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736647; cv=none; b=Z1xsm7zTX6FtNoFMc3LlfIK331CHzNQ55KNHM/WdBnEvcEw49/Q2hvtJw8Us4AsiiEgAIrQbCKJAJLNiJUzH7LkAeDBeGu/VWrAqCA5ut5TCjXh+pn7yoVoS8/S1dYPU86xnYAhNu5BVLw9DzUT/Qa6672xblA6FbGNMYlEScPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736647; c=relaxed/simple;
	bh=fZVH+eY1XlpaIzm2kfiFbB/JlZ0/oabYFTQQ0bAKpCM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NY7bX3hGuyPNpntWgk5a/3yXEWEzsC/qeOFPfu+1UOc0cv1rRjp/e1ZGBOUR7mw4NtFoyd7gDEee6ifkxcPIZhdC9/LLVirXCi5KhwXJ8kCIPA9C7YlFsBKv+qOrOIZaW/8bIUKE0BDlp+P7/8Ghc587IdF+27zivIGDtXGGRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOnPyA12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOnPyA12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE9D1F000FF;
	Wed, 30 Sep 2026 02:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736645;
	bh=qVtKP6CTv5yLnUDsf7M6oSmBtg6yOg2r7BToe3wYjH8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BOnPyA12qlh6wlxxkReaDlvxesD/gPSixIFbX3eNiqVWIdKA2AjyLLywCFUuPGyfC
	 TnwNlH84BAJ9T3PIyq2sqSKbkqoUK+r66BkxOvqYYMxzIQvdjF6xBuk1gZbj5xxPIS
	 iJnwHuIt179gOlwHBhkqb8KrK1HFdbukxm6RrmF0Ep+c2WAHg3/RvXw4kcYAIKN+Hq
	 S9to6LQXMEWOQzXPQ+VR74ddb9mozLfhl0ujyUSMfvJXmAxCoNYX7YsZ1C7PhChAx5
	 RQkj1v4yZqTZTWeUiu6F3jUZAH7z5iaPMdvjx/9Au5mp1xm2MnGQoUN8jtcHfLlhO/
	 huOoxD6Olt40A==
Subject: Re: [PATCH net-next v2 08/11] net: ethernet: cortina: Validate RX
 fragment lengths
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:44 +0000
Message-ID: <179073664449.434549.8311340298321388734@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-8-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-8-758a795d7a78@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new err_length label in gmac_rx() counts a frame as bad
  (rx_errors++, rx_length_errors++) after gmac_skb_if_good_frame() has…
- [Low] The commit "net: ethernet: cortina: Validate RX fragment lengths"
  fixes real defects in gmac_rx()…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but in
  drivers/net/ethernet/cortina/gemini.h the comment on `union…

--

net: ethernet: cortina: Validate RX fragment lengths

This patch adds bounds checks on RX descriptor lengths in gmac_rx(). It
rejects a short first fragment, an EOF frame length underflow, fragments
that run past the DMA fragment or the page, and zero-length fragments.
These drops are counted as rx_errors and rx_length_errors.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index d677d7431ab2..258bb44d5570 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1667,6 +1668,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			if (!skb)
>  				goto err_drop;
>  
> +			if (frag_len < NET_IP_ALIGN)
> +				goto err_length;
> +
>  			page_offs += NET_IP_ALIGN;
>  			frag_len -= NET_IP_ALIGN;

[Severity: Low]
This isn't a bug introduced by this patch, but the comment on
buffer_size in union gmac_rxdesc_0 in gemini.h looks like it was copied
from the field next to it:

drivers/net/ethernet/cortina/gemini.h:
		/* bit 15:0 number of descriptors used for the current frame */
		unsigned int buffer_size:16;
		/* bit 21:16 number of descriptors used for the current frame */
		unsigned int desc_count:6;

gmac_rx() treats word0.bits.buffer_size as a byte length. It subtracts
NET_IP_ALIGN from it and, with this patch, compares it against the
freeq fragment size and PAGE_SIZE.

Could the comment be changed to describe a per-buffer byte count? This
doesn't affect the new bounds arithmetic.

[ ... ]

> -		if (word3.bits32 & EOF_BIT)
> +		if (word3.bits32 & EOF_BIT) {
> +			if (frame_len < skb->len)
> +				goto err_length;
>  			frag_len = frame_len - skb->len;
> +		}

[Severity: Low]
Should this commit have a Fixes: tag?

Without this check, frame_len < skb->len at EOF wraps frag_len to a huge
unsigned value. That value then goes into skb_fill_page_desc(),
skb->len and skb->data_len.

The EOF computation and the unchecked skb_fill_page_desc() and skb->len
updates date back to the original driver:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Earlier RX fixes to gmac_rx() carry that tag, for example 6520198c430c
("net: ethernet: cortina: Count RX drops once per frame").

The commit uses the Assisted-by workflow, and step 6 of
Documentation/process/coding-assistants.rst also asks for a Fixes tag on
such fixes. The trailers here only have Assisted-by and Signed-off-by.

[ ... ]

> @@ -1698,6 +1713,11 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  		}
>  		goto next_desc;
>  
> +err_length:
> +		if (!dropping) {
> +			port->stats.rx_errors++;
> +			port->stats.rx_length_errors++;
> +		}

[Severity: Medium]
Does this count the same frame as both a good packet and a bad packet?

Each new goto err_length runs after gmac_skb_if_good_frame() has already
returned an skb for the SOF descriptor. By then that function has done:

drivers/net/ethernet/cortina/gemini.c:gmac_skb_if_good_frame() {
    ...
update_exit:
	port->stats.rx_bytes += frame_len;
	port->stats.rx_packets++;
	return skb;
}

So when a frame hits any of the new checks, it gets rx_packets and
rx_bytes from the SOF path, then rx_errors and rx_length_errors here,
then rx_dropped in err_drop. gmac_get_stats64() then reports it in both
groups.

In include/uapi/linux/if_link.h, rx_packets counts good packets and
rx_errors counts bad ones. Before this patch the two never overlapped,
because gmac_skb_if_good_frame() rejects error frames before it touches
rx_packets.

The same header defines rx_length_errors for 802.3 in terms of in-range
length, out-of-range length field and frame-too-long errors. An
inconsistent DMA descriptor length doesn't seem to fit any of those.

Would it be better either to undo the good-packet accounting here, or
to count these drops only in rx_dropped?

>  err_drop:
>  		if (skb) {
>  			napi_free_frags(&port->napi);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
