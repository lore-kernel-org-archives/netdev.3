Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C003B3C10
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338709; cv=none; b=ITQ2tQS4EjifUIj7P7gefvjGuzSvvjlHvOAQzFHl3owKC5XA+0QzqnRXb1nF0ZroMF2F/NjB63fw8dEUHpgQmG7HNMfUabUua3sGssel3InsOdzhsrhypO6Z3H+Olko91HQGeNIwhCe6mQTCI+icz4fJBzJO+pAmakuPyC1UyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338709; c=relaxed/simple;
	bh=e0LN3QeZ2QOwZml4mR6FSF+MZ2Ne+qSSlPS+O5W/Mlk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XB2j793JnXmC9tex2SSoD7L4E0ZSONMuF+DoKPBhGfenK5boEClcZsELqc10/7xOCJ6K92K0HjFm0Nvh6VZjFw8N4uTBQOxzc6xIb77MxqZVJvovmnvtag/FHMV6bERRnMZy3up/ziNDHXD2o+SilQ9QEkDaNydG4al/qVk1zrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSRw37Y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSRw37Y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE4A1F000C4;
	Sun, 18 Oct 2026 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792338706;
	bh=fzTsUBlmzkJ4WDtL/V9I83O9bKeWYser6SnmJFJirdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZSRw37Y5WDkDR6ADSfOu6f13eoM+wYW6Xksre3fNTFUl7zmFnJBAoH3WBysVhsto9
	 qlysJaj6rhT1Vddza2AywBD/bhb1YwRB1CbjOPl5BdggyMQmYgn5mCgUiTMXvgKEHL
	 1LxCrnuGhPrzfOMtxW8MSaWuF1hecgbYp6/mF2wawhX7SihOFG7z30h1ZCqLs2yrgB
	 Xz2viEGlSOqo8v2gzYnACy30vUPLjs0CI0zlICnxgA60ELMx/UWfTKAOsTmm2l8UVX
	 wYIgETfEnEKCq71ySIiP3iQt5C0V+ryl6/h46nT++gtlE9DVK1+JKdZmL20auZdagT
	 Q/caMDlG1PoFw==
Subject: Re: [PATCH net-next v9 8/8] selftests: hsr: Add test for the inline
 PTP header on HSR
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com, pabeni@redhat.com,
 praneeth@ti.com, pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
 vigneshr@ti.com, willemdebruijn.kernel@gmail.com, daniel.machon@microchip.com,
 edumazet@kernel.org
Date: Sun, 18 Oct 2026 15:51:44 +0000
Message-ID: <179233870469.3135.10550297131080916368@kernel.org>
In-Reply-To: <20261014-hsr_ptp-v9-8-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-8-2d20a2a0f816@linutronix.de>
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

- [Low] In tools/testing/selftests/net/hsr/hsr_ptp_test.c, the two 'hsr-
  header' cases never check whether the caller-supplied HSR header…
- [Low] The header comment of
  tools/testing/selftests/net/hsr/hsr_ptp_test.c (lines 5-7) says the…

--

selftests: hsr: Add test for the inline PTP header on HSR

This adds a selftest, hsr_ptp.sh and hsr_ptp_test.c, for the inline
ETH_P_1588 header that the HSR stack uses. The test sends a PTP frame
through the HSR master to port A or port B, with and without a
caller-supplied HSR header. It then checks that the frame shows up only on
the requested slave port and that the payload matches.

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

[Severity: Low]
Does this match what the kernel does? When the inline header has hsr_hdr
set, the frame gets has_foreign_header, and hsr_forward_do() sends the
caller's frame unchanged:

net/hsr/hsr_forward.c:hsr_forward_do() {
    ...
		if (frame->has_foreign_header && frame->skb_std) {
			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
    ...
}

That path skips hsr_create_tagged_frame(). hsr_xmit() also skips the
source address substitution for these frames:

	if (frame->port_rcv->type == HSR_PT_MASTER && !frame->has_foreign_header) {

So the foreign HSR header is kept and no second header is added. The test
expects this too: raw_recv() requires encap_type to be ETH_P_1588 right
after the first HSR header.

Should the comment say that the foreign header is kept as-is?

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
In the two hsr-header cases, does this check that the caller-supplied HSR
header reaches the slave port unchanged?

pkt_send() fills the foreign header with distinctive values:

	hdr->hsr_hdr.src[3] ^= 0x21;
	...
	hdr->hsr_hdr.sequence_nr = htons(hsr_seq++);
	...
	pathid_size |= (port - 1) << 12;

raw_recv() only compares the destination MAC, the outer type, encap_type
and the payload. It never reads the received src, sequence_nr or
pathid_and_LSDU_size.

Keeping these fields intact is what makes the has_foreign_header path in
hsr_forward_do() and hsr_xmit() different from the normal path. Suppose
hsr_dev_xmit() stopped passing the hsr_hdr flag through. The frame would
then be handled as an ordinary HSR-tagged master frame:
hsr_create_tagged_frame() would clone it, and hsr_xmit() would overwrite
h_source with the slave's address. The result would still pass every check
here. Only a doubled header would be caught, through the encap_type check.

Could the test also compare the received src, sequence_nr and path id with
the values pkt_send() wrote?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-hsr_ptp-v9-0-2d20a2a0f816%40linutronix.de
