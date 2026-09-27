Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC7370D61
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515462; cv=none; b=MHyHUOVk86Ed1kzvGFl7IG6+qX6Co/72kAmfyzgrVHGJKR6yFIJMNzGZ0oqMTlnL4U+W1lnZ0+3GmzxAbnmfq0kmqi0RA2s2kEd8TBnoyNl02WQcHTVWltW9d3JW4ID2R0RjSo0FUo6mosncN3aFV5ya3ejjk7Il/hyyNlrmBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515462; c=relaxed/simple;
	bh=lzf9tPta5Vzylzl8O92gG2cdTFZw/BVuKt9gvE8NMHk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7XTtJZfiOfEOk/wHq56WubdkKtlbYyv1aCiedV+/kugKDhHSVur8ok5S56P7bx+7klJcMptLlMIstBWC/5HfY5zJeTCs4RcSr5QrhlP8WxDBYqZVh8Yh5vJkWCADDbPwNvt5saLz33ljBOAO+W+lPswjpRnbQcYaGZmXxNBUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYxw3Uhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYxw3Uhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E5B1F000FF;
	Sun, 27 Sep 2026 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515461;
	bh=LR31UWXQg8ParZAHkJFCojKyFM0ERNTQUm7MUsLPgLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hYxw3Uhc7JMysmSae/IA0sCQu0/hDzrjjUp95jxdYogAvaEWOCkuWVnC8bETTaAAS
	 4zbPA+ZJrkuIckLhyxox/px4zpY8I1gu6la12FtnpqaGI4GRPsARwvV0jyBpwLu26A
	 zcQirV2+6HOfQ+xFgpS53+QTqX+/6P3fvRzK19FcUAbPDDgSecI7Ul/ulg00KjqVIm
	 LzngsJFTAKY6Yi/ugIurMgsgAjnvrywgRrIFg0N5uyECw4uaikwQWmvVJ7VkoVErk7
	 y4Fc2aLQ8y9aDuDd3T26zVIWJEBdbrs6EnnnTgoSU2/HN78QFLCb30/sl1b+WFM9me
	 OrrrDd4q3WYhQ==
Subject: Re: [PATCH net-next v6 1/8] hsr: Add header_ops::parse_protocol
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Sun, 27 Sep 2026 13:24:20 +0000
Message-ID: <179051546004.2160803.13486346081627163430@kernel.org>
In-Reply-To: <20260923-hsr_ptp-v6-1-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-1-6ea07b3fb8a8@linutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch has no Fixes: tag.

--

hsr: Add header_ops::parse_protocol

This patch adds eth_header_parse_protocol() as the parse_protocol callback
in hsr_header_ops. With it, af_packet's dev_parse_header_protocol() sets
skb->protocol correctly on hsr devices. Before this change the callback was
missing and the field was set to 0.

> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index fc512204600cd..59df647d2fd45 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -247,6 +247,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  static const struct header_ops hsr_header_ops = {
>  	.create	 = eth_header,
>  	.parse	 = eth_header_parse,
> +	.parse_protocol = eth_header_parse_protocol,
>  };

[Severity: Low]
This isn't a bug, but should this patch carry a Fixes: tag?

hsr_dev_setup() calls ether_setup(), which installs eth_header_ops. It then
replaces them:

net/hsr/hsr_device.c:hsr_dev_setup() {
    ...
	dev->header_ops = &hsr_header_ops;
    ...
}

The eth_header_ops parse_protocol callback is lost at this point. So for
SOCK_RAW sends with protocol 0 or ETH_P_ALL on an hsr device,
packet_parse_headers() has been leaving skb->protocol at 0 on the master:

net/packet/af_packet.c:packet_parse_headers() {
    ...
		skb->protocol = dev_parse_header_protocol(skb);
    ...
}

The frames that reach the slave ports still look correct. In hsr_forward.c,
fill_frame_info() reads ethhdr->h_proto directly. hsr_fill_tag(),
prp_fill_rct() and create_stripped_skb_hsr() also re-derive skb->protocol
from the header, for example:

net/hsr/hsr_forward.c:hsr_fill_tag() {
    ...
	skb->protocol = hsr_ethhdr->ethhdr.h_proto;
    ...
}

The remaining effects look limited to things like protocol-based tc or tap
matching on hsr0 egress. The patch also reads as preparation for the PTP
series rather than a fix. If it isn't meant for stable, leaving out the
Fixes: tag seems fine. Was that the intent?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-hsr_ptp-v6-0-6ea07b3fb8a8%40linutronix.de
