Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995546D573
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297085; cv=none; b=OQcV+7SW/OTyVwxudJ6wqsPQrlttaMjWhg5zL7PMd5U+IH4/sjfgg2gl7Nut6xBqAQRLWRv4UbiTnxgRR14pUN0Ia67sA3yJMtM0BNmYgtv3eFEPt8NVSfDzCje0jxambwnCvTJoCvPLTnKEGAlBmyrz9amXjOU3arWQr+pbICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297085; c=relaxed/simple;
	bh=hq9WD+poN3XN8M9QzL6AS3PJuhBXALbTd7jJBa24YBg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nk6lu/N/YfUyvpcqjtR/BzNUa8hEzopIou5CdcA+UL+AmYNoOiQiWMi7nCTbTF4Ryt0rQkcTfWtfvxwQEvtA36Nm8RJgTvDNzOJgC5alzzKfLotTLWsQyUwPvmp77WWG9ocwoGTpCklURrs8cvOb4WScoDEH08o2MYRtnrBY/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlyqRKDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlyqRKDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5591F0089B;
	Tue,  6 Oct 2026 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297083;
	bh=TwJV6yeG9517/N4qQcV1Jg6vXxk89KQPdKlvqhYrzdc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KlyqRKDyFRe+XqrPaIR1XKu0/k524t3j1A+IixjMWcDMKSu3ApLrmefY223nvhY0i
	 qxclu7TS3BPJvsLaC9J9rw4mprnkmMZffbpE0cm7ox7LtstfHiJ3+9WdpS7yKyjXlr
	 z6f0sTzz8EMaTdoo1ukNEvfAZiU4Kl7I6kpqNOfg/cS56O8z+hdKA3ADBWCyHIjo5+
	 SMhBKUv543eR7Xv3TsdPWwUZcuLHGtRveGNMhKVt4cf/CHSOb9A3MdguqtGqQqibol
	 a6gdUBJCAPWylVUCfHgafL5irD5SNom1RMjlSROXF3cxZpppA7d5UCJOMFm5LTpJDv
	 UZwfpZ7/JYfxg==
Subject: Re: [PATCH net-next v8 8/8] selftests: hsr: Add test for the inline
 PTP header on HSR
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 06 Oct 2026 14:31:22 +0000
Message-ID: <179129708214.434549.3458194670714306366@kernel.org>
In-Reply-To: <20261002-hsr_ptp-v8-8-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-8-60dabc07e554@linutronix.de>
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

- [Low] The 'PortA, hsr-header' and 'PortB, hsr-header' cases of
  hsr_ptp_test do not check that the kernel preserves a supplied…

--

selftests: hsr: Add test for the inline PTP header on HSR

This adds a selftest for the inline header the HSR stack uses with ether
type ETH_P_1588. The test sends four sample PTP packets through the HSR
device: one to each port, each sent with and without an HSR header. It
checks that each packet shows up only on the requested slave port and
that the received payload matches what was sent.

> diff --git a/tools/testing/selftests/net/hsr/hsr_ptp_test.c b/tools/testing/selftests/net/hsr/hsr_ptp_test.c
> new file mode 100644
> index 0000000000000..5b69d4594768b
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_ptp_test.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Simple test to verify the usage of the inline header used for HSR with
> + * ether type ETH_P_1588.
> + * The inline header has to be stripped, the sent packet must only appear on the
> + * specified port and the interface needs to accept a foreign HSR header and
> + * prepend its own header.

[ ... ]

> +static int raw_recv(int fd, void *sample, int sample_len)
> +{

[ ... ]

> +	if (memcmp(hsr_hdr->dst, p2p_dst_mac, MAC_LEN))
> +		goto again;
> +
> +	if (hsr_hdr->type != htons(ETH_P_HSR)) {
> +		printf("Error: Unexpected ether type: 0x%x\n", ntohs(hsr_hdr->type));
> +		return -1;
> +	}
> +
> +	if (hsr_hdr->encap_type != htons(ETH_P_1588)) {
> +		printf("Error: Unexpected encapsulated type: 0x%x\n",
> +		       htons(hsr_hdr->encap_type));
> +		return -1;
> +	}
> +
> +	if (cnt < sizeof(struct hsr_hdr) + sample_len) {
> +		printf("Error: Packet %d is too small for data check\n", cnt);
> +		return -1;
> +	}
> +
> +	if (!memcmp(&buf[sizeof(struct hsr_hdr)], sample, sample_len))
> +		return 1;

[Severity: Low]
Do the "PortA, hsr-header" and "PortB, hsr-header" cases check that the
kernel keeps the HSR header supplied by the caller?

pkt_send() fills the foreign header with values that would identify it:

	hdr->hsr_hdr.src[3] ^= 0x21;
	...
	hdr->hsr_hdr.sequence_nr = htons(hsr_seq++);
	...
	pathid_size |= (port - 1) << 12;

raw_recv() only checks dst, type, encap_type and the payload. It never
compares src, sequence_nr or pathid_and_LSDU_size with the values that
were sent.

On the kernel side, you can only see the foreign header handling on the
wire through these two paths in net/hsr/hsr_forward.c:

hsr_xmit() {
	if (frame->port_rcv->type == HSR_PT_MASTER && !frame->has_foreign_header) {
		hsr_addr_subst_dest(frame->node_src, skb, port);
		...
		ether_addr_copy(eth_hdr(skb)->h_source, port->dev->dev_addr);
	}
	...
}

hsr_forward_do() {
	...
		if (frame->has_foreign_header && frame->skb_std) {
			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
	...
}

Suppose the !frame->has_foreign_header check in hsr_xmit() were dropped.
The source MAC would then be rewritten to the slave's address, and
hsr_addr_subst_dest() returns early for the multicast 01:80:c2:00:00:0e
destination. Would every check in raw_recv() still pass in that case?

Could raw_recv() also compare the source MAC, sequence_nr and path id
against the values pkt_send() used for the hsr-header cases?

Also, the file header comment says the interface needs to "accept a
foreign HSR header and prepend its own header". Is that accurate?
hsr_forward_do() seems to keep the supplied header ("PTP TX packets may
already have a HSR header which needs to be preserved") and does not
prepend a new one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-hsr_ptp-v8-0-60dabc07e554%40linutronix.de
