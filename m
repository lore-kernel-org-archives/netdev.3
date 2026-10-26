Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054910;
	b=4Whsns/Tqw6Ibipf/t3ThPRg/+GcaQy3sW+kNZ1EjljKrbmDvLqzOFFxm3IHf3cFnnzQ
	 c1qAyvNo1gXhf0B1Cen1xzsGHoJfm2bCs1ufbKVtpGMVPF2tocJQFvfXy6dINCPfghdq8
	 P6hYdfeHMbF5WjFX96zIMp+3fIkfc9vZr/rZJROftNjpAQFtf98eGhN4D2BUR8gxnG7Xc
	 sQ8/FfAyCj5AIvcUY9nLKpKa3QWEzUp4lIXQD2QkzgI3BLZUY2wF3Pxw9XY9XqEDs6SFx
	 KuyrMz9k8C0XxYG1MNxv+qy1t1fKTyHg7ruX394NQguTB9lbOoS1UbV9CyNCqFJKCCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054910;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jcxyz7Cy7L3/Rzx1d3XkFGe0VxaGpBfmgU6arFQu+pk=;
	b=2neaXF3yj4h/Xlf0qOw8CCTEPFFZxy/CaUnLKI6dJ2KwkpMjmJJorTTBOp5olG2LByXS
	 P6dDCn/xchnYwqD7HLB79r5u1g0wFmu3CL/+CknfGVpgu1H87fd+Lg/XjSBOTjbQ9H4u1
	 Dl0BwGKtZ8KdUICt0wxxPH6HkYTP3NScp5Zc2mu+CJCSBmTrXj9zKN74+cX3BUf4j3wLS
	 CI7J34Wr9NCuLnxFkXRZ2KsP7S7sXVimnoyNvWMGAL1cL2sGMANF+HpHjnubmLGxPwcPU
	 Uw2b3wvMyDWRmgnCEecIltQTN/39UDnnJIVrftft50PpEEFU1JnZOYMOCtEi6Lf3chA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJfD80vz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE9606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJfD80vz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677C41F01825;
	Mon, 26 Oct 2026 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793054909;
	bh=jcxyz7Cy7L3/Rzx1d3XkFGe0VxaGpBfmgU6arFQu+pk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XJfD80vzREdmw8Gq2FfRAxfgx0ZC+24a0p0VVUbyWKj7BgrVR+fgTlSykOJ9MSJtB
	 mdFhzSxiKbidCu3L/czUKNRcuwl4TtdolAyabYF6M6l39bylVAwf2WJ61h+RrAESkC
	 2jY7/Iz62p6zu9C8Pl5bDgCN6UT1WJz9dFX0YOicisqsrKULJzZufsbKDwzWGXdCRP
	 qzy0s5xHDn7qUfTvS3M8yUJrBfy7LhndO30KSGgw6UJ937MF83ofSoKuhYYRYZ9cJT
	 YSLazyGuzvSydOqHhfQjxk23+am5AYrhqxbVSS7FqweJ7uEBB16OmZzhDOSCf7JmY5
	 cuUlmfHljh7TA==
Subject: Re: [PATCH net v2 2/4] tls: device: fix next-record sequence in
 core-driven RX resync
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, kuba@kernel.org
Date: Mon, 26 Oct 2026 22:48:28 +0000
Message-ID: <179305490892.3134.14812552886616716829@kernel.org>
In-Reply-To: <20261022221732.1397620-3-rjethwani@purestorage.com>
References: <20261022221732.1397620-3-rjethwani@purestorage.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tls_device_core_ctrl_rx_resync() (net/tls/tls_device.c),
  this patch makes the next-record sequence sent to the device…

Pre-existing issues:
- [Medium] The other CORE_NEXT_HINT resync path, tls_rx_msg_size() ->
  tls_device_rx_resync_new_rec() (net/tls/tls_sw.c:2234-2235 at this…

--

tls: device: fix next-record sequence in core-driven RX resync

tls_device_core_ctrl_rx_resync() used to pass tcp_sk(sk)->copied_seq to
tls_device_resync_rx() as the TCP sequence of the next record. This patch
passes tls_strp_msg_seq() + rxm->full_len instead. The commit message
says the result is the start of the next record in both strparser modes.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index fbfe6ec3df048..a6c4d0cc54c73 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -877,8 +878,9 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
>  		memcpy(rcd_sn, tls_ctx->rx.rec_seq, prot->rec_seq_size);
>  		tls_bigint_increment(rcd_sn, prot->rec_seq_size);
>  
> -		tls_device_resync_rx(tls_ctx, sk, tcp_sk(sk)->copied_seq,
> -				     rcd_sn);
> +		tls_device_resync_rx(tls_ctx, sk,
> +				     tls_strp_msg_seq(sw_ctx) +
> +				     rxm->full_len, rcd_sn);

[Severity: Medium]
The sequence passed here no longer depends on the strparser mode. Does the
check that picks this branch still depend on it?

Earlier in tls_device_core_ctrl_rx_resync():

	/* head of next rec is already in, parser will sync for us */
	if (tcp_inq(sk) > rxm->full_len) {
		trace_tls_device_rx_resync_nh_schedule(sk);
		ctx->resync_nh_do_now = 1;
	} else {

tcp_inq() counts from copied_seq. In copy mode, tls_strp_read_copy() has
already moved copied_seq past the current record, so tcp_inq() counts only
the bytes of the next record.

Suppose between 1 and rxm->full_len bytes of the next record are already
queued. The else branch runs, and tls_dev_resync() is called for a TCP
position the device has already passed. resync_nh_do_now is never set, so
tls_device_rx_resync_new_rec() also returns early:

	case TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT:
		if (likely(!rx_ctx->resync_nh_do_now))
			return;

Would this waste the resync attempt and keep the stream on software
decryption until the backed-off retry?

This tcp_inq() check was already there before this patch. The later commit
"tls: device: fix next-record queued checks in core-driven RX resync" in
this series appears to fix it. That commit replaces the check with
after(READ_ONCE(tcp_sk(sk)->rcv_nxt), next_seq).

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The
commit message says the reported sequence "no longer depends on which mode
the strparser is in". Does that also hold for the other CORE_NEXT_HINT
path?

tls_rx_msg_size() in net/tls/tls_sw.c still computes the record start from
the anchor skb:

	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
				     TCP_SKB_CB(skb)->seq + strp->stm.offset);

In copy mode, tls_strp_read_copy() resets stm.offset to 0 but keeps the
anchor's old cb. The value above can then be lower than the real record
start, while tls_device_core_ctrl_rx_resync() now uses strp->seq.

When tls_device_core_ctrl_rx_resync() sets resync_nh_do_now, it hands the
resync to this path. tls_device_rx_resync_new_rec() also still assumes
normal mode:

		/* head of next rec is already in, note that the sock_inq will
		 * include the currently parsed message when called from parser
		 */
		sock_data = tcp_inq(sk);
		if (sock_data > rcd_len) {

In copy mode, could the device then get the wrong next-record boundary for
CORE_NEXT_HINT? Could the request sequence also fail to match for
DRIVER_REQ and DRIVER_REQ_ASYNC?

Two later commits in this series look like they fix this:

  "tls: device: fix record start reported to RX resync in copy mode"
  changes the argument to strp->seq.

  "tls: device: fix next-record queued checks in core-driven RX resync"
  changes the tcp_inq() check in tls_device_rx_resync_new_rec() to
  READ_ONCE(tcp_sk(sk)->rcv_nxt) - seq.

>  	}
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022221732.1397620-1-rjethwani%40purestorage.com
