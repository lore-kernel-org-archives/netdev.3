Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430931;
	b=PX2Ta+Se45Ry5LO4kqMYHwTIywVWXysD5WRU9G1tiSM/lEo//uRelLkM2LOHCl7/Rjxu
	 DXq5UCbN3DCbiAayiXX9NsY9GSQZ6F63LDkBBWibgTQuu+cL2P4fJ57S6LvDjD9g9hLF0
	 jb8Fdugr7kIZY92t1SM8yn1Ct56nqXt/CfWwMjhL2Lm7bjFuWGyDUcqc2vZk8+xFz3bur
	 UzL5h+gVVlmybLqqWuCS/Yus5Yl3kArCpCsGHsTj8xKc7leWR5jmOLc/776WHvQu1mcMA
	 CO6UcMfeXBW2thjiSSJSywFT9buD9/9QDGlDXvzKcoJJoOfvZK1dJOCfAkiZPdTXrQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430931;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4gcg6oC8l2xA1/HXUOL9sEi7N+d1L8SkB2UMBzvf9A4=;
	b=EfrbsZ2a5VI4TCc8fTFdZ8MJZ97MVzby0kl9YyNv5V5FQAcoaQz4Um+w0oDDSxnXwEN4
	 Dz4bsO99vkQb58yN7QyWeyVytirzB8XQDXria4ajwZ0UF2USEGELV1S5FQI4G26xHfjsx
	 nNu9wVBTQUwevPyij0NuEJkRTMqugwjBeUe8HyVrJSwEDUnOVhR4OElvxnCfg+uWSvBTD
	 /R0kEb4H/FS6fsN5KGwVPeaG0kAmhwOHxhRUkOshPoau97ZbPW6wItIjs3ooBf0SKgh/O
	 auJoWk95b+MDcCM8dnBsfUfwroB+NJ/pAZQSuHZjv8tBzTp8mte0GGVnba0JxzhU6Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWAsD4cb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821960A2612
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWAsD4cb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A82E1F000C7;
	Mon, 19 Oct 2026 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430930;
	bh=4gcg6oC8l2xA1/HXUOL9sEi7N+d1L8SkB2UMBzvf9A4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hWAsD4cbJsBz0/4W97BDeaUyItIYQdpoSuGjv/gb8rzPvszYz26FTh7rRKC1ax++I
	 ijvrxBwd5p7QHdZPF6FOhiu/V0z3PYcQ6rGaO4sFJytzoHxaz8/Rhqor2m1G0VkakP
	 NuTaKtGfMYVXS//EOCUht6bjbfzofXMeB+4AOBpmcgQIsAAq6e52fLI3OptUcDIaPi
	 TuMUIgfkmRa74W64C7qe4mZi8TF2sDrCXIvh2rUfWurbfTVJjz6lCmbojZlHJR+Vmm
	 0Yi7Kug+sNqpYzRB6WWeW23ReSmiY47r/Dpo1/dzqjmlbLfLVy+aqd7xOLJ8KBlwDo
	 gv/Leu9SfkM4Q==
Subject: Re: [PATCH net-next v5 10/14] net: ethernet: cortina: Validate RX
 fragment lengths
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:49 +0000
Message-ID: <179243092962.3135.17012100029248694408@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-10-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-10-b5c9e2f7b8a3@kernel.org>
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

- [Low] The commit "net: ethernet: cortina: Validate RX fragment lengths"
  fixes real RX descriptor defects that have been in gmac_rx() since the…
- [Low] The commit message says the patch will "Derive the final fragment
  length from the total frame byte count rather than treating the…

--

net: ethernet: cortina: Validate RX fragment lengths

This patch adds bounds checks on RX descriptor lengths in gmac_rx(). It
rejects a short initial fragment before NET_IP_ALIGN is applied, frame
length underflow on EOF, zero-length non-final descriptors, and fragments
that run past the DMA fragment or the page. An empty EOF descriptor now
completes the skb that was already assembled, and the buffer_size comment
in gemini.h is corrected.

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
Should this patch have a Fixes: tag? The defects it closes in gmac_rx()
look like they go back to when the driver was added:

  - frag_len -= NET_IP_ALIGN with no lower bound check
  - frag_len = frame_len - skb->len on EOF with no underflow check, so a
    wrapped length can reach skb_fill_page_desc()
  - a zero-length fragment that is logged but still appended

Other patches in this series that fix bugs of the same age carry this tag.
Examples are "Keep shared free queue parent-owned", "Drain free queue IRQ
before resize" and "Preserve in-flight free queue pages":

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Without the tag, stable backporters may not pick up the underflow fix.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index e42eeefd4d195..70aa418d70370 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1827,15 +1831,33 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		if (word3.bits32 & EOF_BIT)
> +		if (word3.bits32 & EOF_BIT) {
> +			if (frame_len < ETH_ZLEN ||
> +			    frame_len < skb->len)
> +				goto err_drop;
>  			frag_len = frame_len - skb->len;
> +		}

[Severity: Low]
The commit message says:

  Derive the final fragment length from the total frame byte count
  rather than treating the descriptor buffer size as an EOF payload length.

Does that match the code? Before this patch, gmac_rx() already derived
the EOF fragment length from byte_count:

	if (word3.bits32 & EOF_BIT)
		frag_len = frame_len - skb->len;

In this hunk the assignment is an unchanged context line. The only new
code here is the frame_len < ETH_ZLEN || frame_len < skb->len guard.

Could this sentence be reworded so it doesn't suggest that the old code
used buffer_size as the EOF payload length?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
