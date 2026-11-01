Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541342;
	b=AVaVcQV9ACY/oufdV0Qp8P8S2KF5wAm6TATpUGzBu2BhXzadZYREnaT2VdEoVGzezeIB
	 HFEHGlMJmnsNRxmGsyM1t/rphY7BDbk8OD6wapPMk1TH8w9yS0oBLY1bzRxsdTrjiPTdY
	 wruxnqozXxsiISxevNdj9mZHpQOc7UXzy5AGF1jGLfQk8McyhE4qdXsRhwPfHjFbw4jXA
	 NZw1619WM5zXe0RxFs6aC7XbN1xRqVco4S39RTyaNkjwLxhs1tHPDUxXxu7gOHksnpQfu
	 WwTcV2E29+irLGEVXmfTZZZ0Iwdodpa17nt9l0bYeTOZ7MC0E0141msM17pluV+z1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541342;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SFHUxyTe9QZ6LESJxwmHaoYtyHUY8quRXCEk8ZG4ceE=;
	b=kSd7D6U3Pci8oKuMGPAR5u4sMr5NkNmYGjAgYO297tcqYtnIHcwlz0LaywjN/ndxIwqX
	 ra16jgH0GkFZBKsK920VBuugD4lyy9hSeinHo6IrvsPbsHMVMbcmavWNUcvS22NNByBTi
	 3pNal1FuW3bxVOP99Cq1uxUumFWVju/64F6dR1lS5xXpj6fVxkPltuje83QS4RpWiFSy7
	 NIS5DKuQucDGevxMM3D83IdOi4Z+rR8QjOiHYJ5pVw1Y9v3U01KcZKdwi8KRyC6okPdNA
	 nPeGLNUftCi3YdkBiSlXYMeMgMAnqLE10BGewdpQL6zMunDnGtpwfrnGyz0+3nno33A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOqYYifb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43E606A324;
	Sun,  1 Nov 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOqYYifb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397501F000C1;
	Sun,  1 Nov 2026 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793541341;
	bh=SFHUxyTe9QZ6LESJxwmHaoYtyHUY8quRXCEk8ZG4ceE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XOqYYifb+aU+6Q2BqUqC6mJWjn1JXYRoHvgYSH8TPexTqRZkyTU1faOTb+gp5vLNL
	 Ypw5/RI/sVh4Ngr4QA7nadA808wuD7nZ1+eG6hM4EhpZoQM0GO4TfiF0LsEYuv2hzH
	 kwGy98TwemCgg3jXfjwqp9E6/1gOULZRJAusOkiAH3yJ9cTGaxALmy2EdObstxAFGs
	 AUkBeQVT9/amP1V348eGBCTjnbrO29Dt+w8FvYXVowtmeacqEnpI6lFTkhPwE/8bto
	 nE3grNhHiTKC4/JM3TZiF8WalCl8yBM2hDSHyTW5jZHtnOVTxbhas2doLhszlsj7KL
	 bbAsFokwsR27A==
Subject: Re: [PATCH net] net: parse the eighth nested VLAN tag
From: netdev-bot+sashiko@kernel.org
To: thnkslprpt@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, almasrymina@google.com, josef@toxicpanda.com,
 jiayuan.chen@linux.dev, toke@toke.dk, linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 13:55:40 +0000
Message-ID: <179354134078.3131.9650678574145259725@kernel.org>
In-Reply-To: <20261031135507.3970551-2-thnkslprpt@gmail.com>
References: <20261031135507.3970551-2-thnkslprpt@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the counter only when mac_len is 0 or covers the
  first VLAN header.

--

net: parse the eighth nested VLAN tag

This commit changes the parse_depth check in __vlan_get_protocol_offset()
from a pre-decrement to a post-decrement. The goal is for a packet with
eight nested VLAN tags to return the encapsulated EtherType instead of 0,
while a ninth tag is still rejected.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48f6764117243..b10ce1d46674b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7703,7 +7703,7 @@ struct vlan_type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
>  
>  		vh = skb_header_pointer(skb, mac_offset + vlan_depth,
>  					sizeof(vhdr), &vhdr);
> -		if (unlikely(!vh || !--parse_depth))
> +		if (unlikely(!vh || !parse_depth--))
>  			return (struct vlan_type_depth) { 0 };

[Severity: High]
Does this allow eight nested tags for every value of skb->mac_len?

parse_depth goes down once per loop pass, not once per VLAN header that is
actually parsed. What the first pass reads depends on where the loop
starts:

net/core/skbuff.c:__vlan_get_protocol_offset() {
    ...
	if (vlan_depth) {
		if (WARN_ON_ONCE(vlan_depth < VLAN_HLEN))
			return (struct vlan_type_depth) { 0 };
		vlan_depth -= VLAN_HLEN;
	} else {
		vlan_depth = ETH_HLEN;
	}
    ...
}

With mac_len == 0 or mac_len == ETH_HLEN + VLAN_HLEN, the first pass
parses the first tag, and eight tags now work.

With mac_len == ETH_HLEN and the first tag still in-band, vlan_depth
starts at 10. The first pass reads the last two bytes of the source MAC as
the TCI and the outer TPID as h_vlan_encapsulated_proto. That only re-reads
the type that was passed in.

Eight in-band tags then take nine passes. The ninth pass sees
parse_depth == 0 and returns { 0 }, which is the result the commit message
says is fixed.

The egress path on a device without VLAN TX offload seems to produce this
state:

validate_xmit_vlan()
  __vlan_hwaccel_push_inside()
    vlan_insert_tag_set_proto()
      __vlan_insert_inner_tag()

__vlan_insert_inner_tag() pushes the hwaccel tag inline and moves
skb->mac_header, but it does not update skb->mac_len:

	skb_push(skb, VLAN_HLEN);
	...
	if (skb_mac_header_was_set(skb))
		skb->mac_header -= VLAN_HLEN;

A forwarded skb that arrived with mac_len == ETH_HLEN keeps that value. A
later vlan_get_protocol() call, such as one in a driver's xmit checksum
path, would then still get 0 for a frame with eight tags.

On the plain RX path (skb_vlan_untag() followed by skb_reset_mac_len()),
the extra pass happens to line up with the stripped hwaccel tag, so eight
tags still work there.

Could parse_depth be decremented only for passes that parse a real VLAN
header? Alternatively, the start offset could be chosen so that every pass
parses one.

If the current behaviour is kept, should the commit message and the
VLAN_MAX_DEPTH comment mention that the result depends on mac_len? The two
texts in question are "allowing eight nested tags while continuing to
reject a ninth" and "Max. number of nested VLAN tags parsed".

>  
>  		type = vh->h_vlan_encapsulated_proto;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031135507.3970551-2-thnkslprpt%40gmail.com
