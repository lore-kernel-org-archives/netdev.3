Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224262;
	b=ywRhQD6XjfU8rOQ/k/3/lEhhX8uQQPa2PY0lW6lx5oby1rUVDCVDQ85nlBmiB5VMhcS9
	 h03VnWOHZvzdNPOF0pick0KI8FiSkQ5hssq6ffbppxohcCtHLj2/4vg/w0wBE01Jq+hR6
	 00IfbUn+D3TqxIYAX0JO0C0PcnVaje3P+ZjHFCkzKZpewLQMyk2Vav2lPqRFuZUmP2fNr
	 F9gfSKJgc30nY61NqBCQ8IdoaXp+o47GEwz1aEBFbqiVbi28tPrj10MuscJKv5YC5qZB4
	 c/30dbfE9TiqeymyMl+V3Lo7yZ75qgvD+7EKpQWKs2a5BESSN5clsyzrhh8YS0lkeAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224262;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ra1fC2S9+lGAFs58r1hB5O3b6TvAPmFU05roFi58CwQ=;
	b=eL7DH7r8w48s8rbgrYOGn+H+sp/J50QTzLHo5W8bNwuIqCyIMsShTh6QhOX+HHFQkeUk
	 BEUsXVziPnLqHVEtMoWekQ3t7kvVRcN+J+UUNTFel5pLxeUBtKw2pjvkPlwAa7x1Vrm7k
	 MxLM7iZmXIrgkSNMvU9Ps8z6oXqERtvEMzVUgWSN9wXnkTN96cJxcvYbbpinYdKLjifOa
	 BIXYZ95ghxbG/lczitLMYtAWcYjDOFHDZtuOAWtqaFP/tDohH5XgZHHijSjw4VcyOZhEW
	 2GmBR7NW5QX3IVx4BWQu93cyBWhg+N7qmXA4YFQ/fIaJPSqz9CLomgjhm+6Lp+hwCFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5QMewRA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B38606A321;
	Mon,  9 Nov 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5QMewRA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383A51F0089F;
	Mon,  9 Nov 2026 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224261;
	bh=ra1fC2S9+lGAFs58r1hB5O3b6TvAPmFU05roFi58CwQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n5QMewRACm8ciQlfnpJ8JFBX9Q1H+hU87oTkjYVy+y/Q9w5xQus/DaYGRfrl0tSSf
	 GsFXisnnn/Pk5TOkAHZiDhyXj2lrWWiK9+BL1/2mAGvv6TXx1z4nnXePpKXw5ee/yM
	 s5S2YLJs9ru5QHNwGyKLaGWmJ1NtesBo15X18MuJpXkHl4bTPm+XA/QATdSL81lm4e
	 ywFOEtu1F+edhTai/wicJLUE+b0eeb0zrCVRbwuiCv6WzJmNgTUgmFuzL2OPwBQiFU
	 XTAdrWzOJoPz5oQ1sSwvbY+0Maf4XdFcHFahvi3960/T53vVK9v1w2hUDD9lr89uk8
	 uMHKCukk92RpA==
Subject:
 Re: [PATCH net-next v3] erspan: drop packets with an unknown ERSPAN version
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, witu@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 11:37:40 +0000
Message-ID: <179422426074.994134.14851036970867047596@kernel.org>
In-Reply-To: <20261108193504.73393-1-yanhaishuang@cmss.chinamobile.com>
References: <20261108193504.73393-1-yanhaishuang@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On IPv6, the new ERSPAN version check in ip6erspan_rcv()
  (net/ipv6/ip6_gre.c) can read its version from the wrong bytes, so…

--

erspan: drop packets with an unknown ERSPAN version

This patch makes the IPv4 and IPv6 ERSPAN receive paths drop packets
whose ERSPAN version is not 1 (type II) or 2 (type III). On IPv4, it
also checks for ETH_P_ERSPAN when classifying a packet as type I, so a
4-byte-GRE ETH_P_ERSPAN2 packet now gets the version check too.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index b5d6ed8f0c369..46fac89a07437 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -507,6 +507,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>  	if (tunnel) {
>  		int len = erspan_hdr_len(ver);
>
> +		if (unlikely(ver != ERSPAN_VERSION && ver != ERSPAN_VERSION2))
> +			return PACKET_REJECT;
> +

[Severity: Medium]

Can some type I packets still get through this check on IPv6?

gre_parse_header() treats an ETH_P_ERSPAN packet with a 4-byte GRE
header as type I, with no ERSPAN header. In that case it leaves
tpi->key at 0:

net/ipv4/gre_demux.c:gre_parse_header() {
    ...
	if ((greh->protocol == htons(ETH_P_ERSPAN) && hdr_len != 4) ||
	    greh->protocol == htons(ETH_P_ERSPAN2)) {
    ...
}

The IPv6 gre_rcv() pulls the GRE header first. It then passes every
ETH_P_ERSPAN and ETH_P_ERSPAN2 packet to ip6erspan_rcv(), which has no
type I branch and reads the version straight from skb->data:

	ershdr = (struct erspan_base_hdr *)skb->data;
	ver = ershdr->ver;

For a 4-byte-GRE ETH_P_ERSPAN packet, ver is the high nibble of the
first byte of the inner Ethernet destination MAC. If that nibble is 1
or 2:

- the new check passes
- erspan_hdr_len(ver) strips 8 or 12 bytes of the real inner frame
- the tunnel lookup uses key 0 instead of a session ID
- in collect_md mode, erspan_metadata is filled from inner frame bytes

The commit message describes the version 0 case like this:

  "passed up as the start of the inner Ethernet frame, and in
  collect_md mode the metadata is filled from the wrong part of the
  header"

This is the same symptom, with the offset wrong in the other
direction. Whether such a packet is dropped now depends on the inner
destination MAC. Nibbles 0 and 3-15 are rejected. Nibbles 1 and 2 are
accepted, and the frame is passed up from the wrong offset.

In v3, the IPv4 side was brought in line with gre_parse_header() by
checking tpi->proto in is_erspan_type1(). Would ip6erspan_rcv() need a
matching change? It could reject packets where tpi->proto ==
htons(ETH_P_ERSPAN) && gre_hdr_len == 4, since ip6erspan_tap_validate()
only allows versions 1 and 2 for IPv6 ERSPAN devices.

>  		if (unlikely(!pskb_may_pull(skb, len)))
>  			return PACKET_REJECT;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108193504.73393-1-yanhaishuang%40cmss.chinamobile.com
