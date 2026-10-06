Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6973EB0E3
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297075; cv=none; b=t0c+2a9tWWMuz0Gp4dqrG83c4ZNYm9kGrDbhDoLYoRBuyDLlhq3SZ4uJm9uk+WhifU0wk/w+XJIH0H3QDOSt3Y4gVExJvi6no3JIPld2wwAsHY+BXDxuHJqMtsMIwhdcgtHEvTnLXfSwkzWzaLoGEAeHIjggbcfCx3YfAF3G+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297075; c=relaxed/simple;
	bh=LxKFdWhodFwoQ6c/zXazunhFjcvCIHOkiYoeKAVWlyQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JmjLgKkR12JIBnjTqAjxvIKBvsHNgE6ViK3g2Gqrf+56bvL8SLQzIptAQS2c+7Q8o83MDz7BYm396+qpYMRBe9qbHn8m7WXNt2j6mX9h9H1khXOHj+TZ7fphjS5VJmjR85v2/OSsA7HgsE/6YWBP59rNWn4MNVLx8Sbhy7ROzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJH0fox2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJH0fox2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29001F0089B;
	Tue,  6 Oct 2026 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297073;
	bh=rBJFm4aVXLUBV84CNzd027ApnvlM4iWNrC0HrMk13Ck=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SJH0fox2sWTDHjigWKYftLqXPjTXelRNC30sNjGNiZe7wsCRo1H/5sIMBLp7XMjqA
	 hkiCbYVXjFg2h5nBk4B2e4IFKdFBZUYlgX3sZmIU0SS+kMxLcVkPxD/8K/2QtFlcfW
	 nc4l+BgL9UE+eyfq2cslpYJrRRITX2gLIQxiUPJK/jiXMighfNNhwFFfKayCMmBPEh
	 c9Lwwh5D/AlJgsS265wpPgZxLWyokjVoX6qM36V6kgkg8N5UQ4pHT50ACzdZ7D61OK
	 i/UjpLA3oBwRLBn1FA2KQxEEMXOL0D4X1+l+j76U06L/e86x/FdzqCrKxdyJ2c8zzQ
	 3fEbt/3JV5F0g==
Subject: Re: [PATCH net-next v8 1/8] hsr: Add header_ops::parse_protocol
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 06 Oct 2026 14:31:12 +0000
Message-ID: <179129707240.434549.8562830732842344341@kernel.org>
In-Reply-To: <20261002-hsr_ptp-v8-1-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-1-60dabc07e554@linutronix.de>
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

- [Low] The commit message for "hsr: Add header_ops::parse_protocol"
  (net/hsr/hsr_device.c, hsr_header_ops) is accurate but thin.

--

hsr: Add header_ops::parse_protocol

This commit sets eth_header_parse_protocol() as the parse_protocol
callback in hsr_header_ops in net/hsr/hsr_device.c. Without the callback,
dev_parse_header_protocol() returns 0 for hsr devices. As a result,
af_packet leaves skb->protocol at 0 for SOCK_RAW senders.

> af_packet uses dev_parse_header_protocol() to assign skb::protocol.
> The hsr stack does not assign a callback so the field is assigned to 0.

[Severity: Low]
This isn't a bug, but could the commit message also say why this is
needed?

The description is correct. In net/packet/af_packet.c,
packet_parse_headers() does:

    if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
        sock->type == SOCK_RAW)
        skb->protocol = dev_parse_header_protocol(skb);

    skb_probe_transport_header(skb);

As far as I can tell, the reason for the change is the later patch in
this series, "hsr: Add a magic header for sending PTP packets". That
patch adds this check in hsr_dev_xmit():

    if (skb->protocol == htons(ETH_P_1588)) {

A SOCK_RAW sender bound to protocol 0 or ETH_P_ALL only passes that
check because of this callback. Should the message mention this
dependency?

Users of the hsr device will also see some changes. They now get the
real ethertype instead of 0 in these places:

  - skb_probe_transport_header()
  - the VLAN network header adjustment in packet_parse_headers()
  - tc/clsact protocol matching on the hsr device
  - taps on the hsr device

There is also no Fixes: tag. Could the message say whether this is a
standalone fix or a prerequisite for the PTP work, so backporters can
decide whether they need it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-hsr_ptp-v8-0-60dabc07e554%40linutronix.de
