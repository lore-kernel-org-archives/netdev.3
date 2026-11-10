Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319709;
	b=hNkCbHcEBXb7Gdf+iNtzHyXol+w4cDlBvv7NshV/jSKEPaQjfu2IzHUtBvoMEsjwQpMy
	 6XbdtJ5m0rAN2FMWml8mIVVkWJr3XOcmMDL0MjbZ5epOC7mxGxSJHfel2/cvS5R5vV+6s
	 P609Xj0vtFGYvI9b3HZSp3fF8C2kcT8Dq8JeNhz/QhBWXiHUi0Q5aEDMLmZGFyZa3u1nV
	 wFw2v0NWm9c6UWmYHjgJFx0QJtRwG9h3s5NzfWgw/15AekNRfjhph6bnHHTOB+GyS6r0D
	 qN7TeJcH+kl3oLG5mpzE5m4OeSoMwxVrg4TiGliCJzWlQsK3DnsPHFFGKInP2g2bCcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319709;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vNhlnmri8tkpaocxey5A5RblYZYq0RJUqjnsKn079Qw=;
	b=nTMkwOX4IxfV2cejl80Ci4NSOS969OOX5t/ibIH5lCWYYwayJOk/fBwm705M7N22X7k2
	 1fF8ciczgK4G6CPU338jrA4OXk2z51WqQwV+Nj0nzxCw3j0gVwPVKvAbKQzUFyj2WqsmS
	 p4d8/PveeZDngXSGWf7qlJukmhd1OJQ0mKmf+6vLSxgtTaH+7rGoKy+THCzH0gWv2yaoS
	 5V/nF2kWKRLC7iifa8xZC+e7gRDD/7UE8c2zXXxD3d52bPGuLQoNqqrW9W+XyzeZIWjlG
	 VN0VqBY1C/9eTSOo8gafzCudQg15hhmNnNNrLaSohU9eCIyMKl/nX+mvHqVQBfKyHLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8TfEccC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAA60A2621;
	Tue, 10 Nov 2026 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8TfEccC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6661F008A6;
	Tue, 10 Nov 2026 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319708;
	bh=vNhlnmri8tkpaocxey5A5RblYZYq0RJUqjnsKn079Qw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M8TfEccCouOUESmLlJqg3IFNnXQUfJhN6Hyi5ZhIIjk+ot590bStHPSEdzTRuoD0s
	 M6MUokkz6i/N9ym2tE+It2Sh9TjM1Murw1VOhjkNHur9br0NBq84/lXGVUrH4YPXK1
	 vsxWo1QrbA6nUJ2EawdLlURiuzD7I2ZhpxbyLPDWeMp/demSJAOeOTiqUDHalPQKlf
	 qHTJ4iBPcFXi1EFHvn6aa6QC4H3whldeqzFn/7pTkkCxc0GQ7jfQYq5bSxAEoAYIa9
	 xRBOCkWrKrf3zwaG4nDd7kt5VSpHcAxaIXojoIsEUQjV2IGQv5Jme/2vzlquRHoaym
	 xalRsHKTyUPMg==
Subject: Re: [PATCH net] net: usb: cdc_ncm: don't underflow the NDP room check
From: netdev-bot+sashiko@kernel.org
To: xujiahao@cmss.chinamobile.com
Cc: oliver@neukum.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com
Date: Tue, 10 Nov 2026 14:08:27 +0000
Message-ID: <179431970794.994134.5397680174063039863@kernel.org>
In-Reply-To: <20261109060913.526268-1-xujiahao@cmss.chinamobile.com>
References: <20261109060913.526268-1-xujiahao@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The code change is correct.
- [Low] The patch fixes a syzbot-reported skb_over_panic() (BUG() in
  net/core/skbuff.c) in the cdc_ncm/cdc_mbim TX path but has no Fixes:…

--

net: usb: cdc_ncm: don't underflow the NDP room check

This patch rewrites the NDP room check in cdc_ncm_ndp16() and
cdc_ncm_ndp32() as an addition instead of an unsigned subtraction. The
check can then no longer wrap and let the following skb_put_zero() of
max_ndp_size bytes overrun the NTB, which was reported by syzbot as an
skb_over_panic() in cdc_ncm_fill_tx_frame().

Closes: https://syzkaller.appspot.com/bug?extid=1994e2ecf323ed90f255

> tx_max is only clamped to max_datagram_size + max_ndp_size + the NTH
> header size, so tx_curr_size is just big enough for one datagram and
> one NDP.  A second datagram in the same NTB is therefore exactly the
> case this check has to reject, and that is also the case where
> skb->len + reserve exceeds tx_curr_size: the subtraction wraps around to
> a huge value, the check passes, and the skb_put_zero() of max_ndp_size
> bytes that follows overruns the buffer:

[Severity: Medium]
The code change looks right, but does this paragraph describe the
trigger and the root cause accurately?

Can a second datagram in the same NTB reach this check at all? Before
the room check, cdc_ncm_ndp16() walks the NDP chain and returns any
existing NDP that has the same signature:

drivers/net/usb/cdc_ncm.c:cdc_ncm_ndp16() {
    ...
	while (ndpoffset) {
		ndp16 = (struct usb_cdc_ncm_ndp16 *)(skb->data + ndpoffset);
		if  (ndp16->dwSignature == sign)
			return ndp16;
		ndpoffset = le16_to_cpu(ndp16->wNextNdpIndex);
	}
    ...
}

cdc_ncm_tx_fixup() always passes one fixed signature
(USB_CDC_NCM_NDP16_NOCRC_SIGN or USB_CDC_NCM_NDP32_NOCRC_SIGN). On plain
cdc_ncm the check therefore only runs for the first datagram of each
NTB.

As far as I can tell, the only way to add another NDP to an NTB that
already holds datagrams is cdc_mbim_tx_fixup()->cdc_ncm_fill_tx_frame().
That path uses a different signature for each MBIM session.

The clamp also doesn't seem to guarantee room for one datagram plus one
NDP. cdc_ncm_setup() clamps tx_max before it sets the datagram size:

drivers/net/usb/cdc_ncm.c:cdc_ncm_setup() {
    ...
	/* clamp rx_max and tx_max and inform device */
	cdc_ncm_update_rxtx_max(dev, def_rx, def_tx);

	/* sanitize the modulus and remainder values */
	cdc_ncm_fix_modulus(dev);

	/* set max datagram size */
	cdc_ncm_set_dgram_size(dev, cdc_ncm_max_dgram_size(dev));
    ...
}

ctx is allocated with kzalloc() in cdc_ncm_bind_common(), so
ctx->max_datagram_size is still 0 when cdc_ncm_check_tx_max() computes:

	min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth16);

That makes the floor only 172 + 12 = 184 bytes. def_tx is
min(CDC_NCM_NTB_DEF_SIZE_TX, dwNtbOutMaxSize), so a device that reports
dwNtbOutMaxSize = 320 gets tx_max = 320. That matches end:0x140.

With that tx_max, the reported len:428 put:172 (skb_out->len is 256 when
the NDP is pushed) could come from either of two paths:

  - an NDP for a second MBIM session on cdc_mbim

  - the first datagram on plain cdc_ncm, when the device reports
    wNdpOutAlignment = 256. cdc_ncm_fix_modulus() accepts this because
    256 < tx_max. cdc_ncm_align_tail() then pads the 12-byte NTH up to
    256 before the room check.

> Here end is 0x140 = 320 = 140 + 172 + 8, i.e. the one-datagram minimum.

Where do the 140 and the 8 come from? sizeof(struct usb_cdc_ncm_nth16)
is 12, and 8 is sizeof(struct usb_cdc_ncm_ndp16). max_datagram_size
doesn't appear to ever be 140, and it is 0 when the tx_max floor is
computed.

Could the commit message be updated to describe the actual triggers?
Those are a device-controlled dwNtbOutMaxSize/wNdpOutAlignment, or MBIM
multi-session NDPs. It could also mention that cdc_ncm_setup() clamps
tx_max before max_datagram_size is set.

> Reported-by: syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1994e2ecf323ed90f255
> Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>

[Severity: Low]
Should this have a Fixes: tag? The patch fixes a kernel BUG that can be
reached from the cdc_ncm and cdc_mbim TX paths. netdev expects a Fixes:
tag on fixes, and stable backports rely on it.

According to blame, the subtraction-based room check in cdc_ncm_ndp16()
was added by:

  c78b7c586657 ("net: cdc_ncm: refactoring for tx multiplexing")

and its current tx_curr_size form comes from:

  e1069bbfcf3b ("net: cdc_ncm: Reduce memory use when kernel memory low")

cdc_ncm_ndp32() has the same check.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109060913.526268-1-xujiahao%40cmss.chinamobile.com
