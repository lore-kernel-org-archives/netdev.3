Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135C37F015
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042164; cv=none; b=B7lCVa/kznomRNy0vR3VcfNPfocwldGL1CmFPdvBGl9Byc6jlmgfLlUlIpf7EN+LpYKEE07oNfzFovEHO/zBG5XAG96Qj8cklVt9g+u36XvgbmG32cFKyRGVg89qtfFR052p92bedfgJZpX6Ppxr9M4el6Do+QROGMsv2vUfSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042164; c=relaxed/simple;
	bh=KoN1igMCr2SeDuR6AzkuqSz6vzG8qtbs2xyLYLhmKy4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4B6ytnbe2cin/6MKJ/hDm4ft1PhqzRPCx/1rbGl6Z4QRelhcUmB176s92ghUxBqoXyP7fuL3IVg5qRIQRxyH33IKJMsu9MPU9i94npwLAWugb+iRrFT6uESdAEYpku4FrRV0JfLKF2IPzxX1D3Ff6HgIHgbx7S7R7OZXSKqD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF2t74OK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF2t74OK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC0E1F000FF;
	Tue, 22 Sep 2026 01:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042161;
	bh=jsBdn3QO9BrXoBb4A4azisdxry0jEbTx/FycxyM5NxQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YF2t74OKPr8+SU7URRk5XzXye/sA6LoR/Cz+qLgJx30sVRswxfnhmJ5M7p3ItReXr
	 FNJWMOpgbUz0SmkRJti1t5WrfLhWGXzGVAp3+cCS3/atlEdaJI2pbSUlTUYv0vSUNS
	 XKc4brMrtirnDYPQXMtsuchhyiV/z1i/z4INrb9ZlU8/6gCKb8Z8/oVFlecncLgnPP
	 GQOffkfpeWexPx64JR7vE8LQz8f/ZAAK/mj5Ix0MIyH8nHa4fnqlXiKTm6I9R8gJTw
	 CmHV0bnmGaor+Ni5r4+CG1+cSQ9Ef3DkTzeAjn9uIHtX40mIWKD93TsamPhXXcPDbp
	 YozXQeh2pFkCA==
Subject:
 Re: [PATCH net-next v17 04/15] tls: add TLS 1.3 hardware offload support
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:00 +0000
Message-ID: <179004216049.2160803.7175771420897392767@kernel.org>
In-Reply-To: <20260917224355.2288021-5-rjethwani@purestorage.com>
References: <20260917224355.2288021-5-rjethwani@purestorage.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] tls: add TLS 1.3 hardware offload support drops the
  TLS_1_2_VERSION guards in tls_set_device_offload() and…
- [Low] Documentation/networking/tls-offload.rst (Rekey section, lines
  404-408 at the parent commit) states that offload does not support TLS…

--

tls: add TLS 1.3 hardware offload support

This patch enables TLS 1.3 on the kTLS device offload path by dropping the
TLS_1_2_VERSION checks in tls_set_device_offload() and
tls_set_device_offload_rx(), appending the 1.3 content_type byte with the
tag in tls_device_record_close(), and teaching the device fallback
encryption path about the 1.3 IV, AAD and prepend layouts.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f5e1b6b61ce38..ada66c0bd0756 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -1101,11 +1110,6 @@ int tls_set_device_offload(struct sock *sk)
>  	}
>  
>  	crypto_info = &ctx->crypto_send.info;
> -	if (crypto_info->version != TLS_1_2_VERSION) {
> -		rc = -EOPNOTSUPP;
> -		goto release_netdev;
> -	}
> -
>  	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
>  	if (!cipher_desc || !cipher_desc->offloadable) {
>  		rc = -EINVAL;
> @@ -1208,9 +1212,6 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
>  	struct net_device *netdev;
>  	int rc = 0;
>  
> -	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
> -		return -EOPNOTSUPP;
> -
>  	/* A rekey (setsockopt on an already-configured socket) is not
>  	 * supported on the device offload path yet; reject it here so the
>  	 * caller can decide (propagate the error for a HW connection, or

[Severity: Medium]

At this point in the series, TLS 1.3 becomes offloadable in both directions
while the rekey rejection right below in tls_set_device_offload_rx() is
still in place.  Can a HW-offloaded TLS 1.3 RX socket get permanently
stuck if the peer sends a KeyUpdate?

The peer KeyUpdate makes tls_check_pending_rekey() in net/tls/tls_sw.c set
sw_ctx->key_update_pending, and tls_rx_rec_wait() then bails out
unconditionally:

	/* a rekey is pending, let userspace deal with it */
	if (unlikely(ctx->key_update_pending))
		return -EKEYEXPIRED;

tls_sk_poll() also masks EPOLLIN in that state.  The only place that clears
the flag is tls_finish_key_update(), reached from the SW setup path, but
the setsockopt(TLS_RX) that would install the new key is rejected in
tls_set_device_offload_rx() for rx_conf != TLS_BASE and the error is
propagated by do_tls_setsockopt_conf() without a SW fallback.  So recvmsg()
keeps returning -EKEYEXPIRED with no way for userspace to recover.

TX side, a TLS 1.3 KeyUpdate that used to work via software now turns into
a hard setsockopt failure on an offload-capable NIC.

The later patches in this series ("tls: device: add TX KeyUpdate support"
and "tls: device: add RX KeyUpdate support") implement the rekey and make
tls_set_device_offload_rx() end in tls_sw_ctx_finalize(), which clears
key_update_pending, so the end state of the series looks fine.  Would it
make sense to reorder so this patch does not leave a bisectable window
where a remote peer can wedge an offloaded 1.3 socket?

[Severity: Low]

Should the Rekey section of Documentation/networking/tls-offload.rst be
updated in this patch?  It currently says:

	Rekey
	=====

	Offload does not currently support TLS 1.3, therefore key rotation
	is not a concern for offloaded connections at this point.

which no longer holds once the version guards above are gone and 1.3
crypto_info is programmed into the NIC for both directions.  The "TLS 1.3
Key Updates" section of Documentation/networking/tls.rst also describes
installing a new key with setsockopt(TLS_TX/TLS_RX) without mentioning the
hardware offload limitation that this patch temporarily leaves behind.

The later patch "tls: document TLS 1.3 hardware offload rekey handling"
does rewrite that section with the TX and RX rekey description, so this is
only a mismatch in the intermediate state of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
