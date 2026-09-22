Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210024501D
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042160; cv=none; b=hlGoBZsZLPQ/18SfaEm3fFEIf4wDgP1I9hr9eGWkEnrWwERB2PX+hrnY+JmI1tf9S5rdxaQcI3SAD4nwLPid2EPma+bXn1lK9GcFxOBNj0YAV3b2d0+ONvSgp3L0xOfJ8YiiNPOSbA9yeH0gXdxqMSOpXWFxPVUmd/WxW65+Fiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042160; c=relaxed/simple;
	bh=BpBGgDpqV9ksrqZ16ZXweY+75sFYrMJFOevwWr8kkDg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awuCQi+Sh8JLZdR1BD5MgaHy/M8RSoDDpmda1hf69pFUjsB7IsncgTjhy6ee/dXjSOFcdOMPmSYM3xRU1MbpAajAheoHcVyVScwIJu4lQe2AjRRbc2xhQwXJMs+oJ2t4p3yosHU4iOL9IJ6kYeHm+XwOfW3bDs9Sx46s3roY3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQl8/GMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQl8/GMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58761F000FF;
	Tue, 22 Sep 2026 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042158;
	bh=fJt2+IHZ0Tor0dOqF36XcL2IvTrSIBSAjA4aF8eDIx4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AQl8/GMCouXldlClkeo9xI3sj1BkZg1Tq6SIkPJUBP10XfdmDXtphNpKyBth8YY2h
	 Cckz6gVKkeWEAPwLK+B1njv1BClpF9HAu5Ty9ADLRdMcoVN/YhG+6Z1oX4BkY47OfH
	 v6bn84Qelaz98YvWex/CEYX0I1ZvT0ao+ClX2HZqBGBWYGX+HuNeBHqvUF898Sxo2E
	 7AbVsruzRJ1h3Ysdx+ldgEi3gbjwD+MaaLdOJCCY4iMIrTx2zXrQngq4phvWIyqxSj
	 aDBK+tRoujBMDYTGt0mGAvhKay2B3Psb5Y0x3ueB2dA9wdiYvyPb/rXaXBv4667npo
	 AlBARAR2qQJ0g==
Subject: Re: [PATCH net-next v17 01/15] net: tls: reject TLS 1.3 offload in
 chcr_ktls and nfp drivers
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:55:57 +0000
Message-ID: <179004215742.2160803.15371116345141495279@kernel.org>
In-Reply-To: <20260917224355.2288021-2-rjethwani@purestorage.com>
References: <20260917224355.2288021-2-rjethwani@purestorage.com>
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

- [Low] Claim: the two new `crypto_info->version != TLS_1_2_VERSION`
  guards in chcr_ktls_dev_add() and nfp_net_tls_add() are dead code,…
- [Low] Claim: the patch implements the same rejection with two different
  semantics — nfp_net_tls_add() returns -EOPNOTSUPP while…

--

net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers

The patch adds an early version check to the ->tls_dev_add callbacks of
the chcr_ktls and nfp drivers so that a crypto_info whose version is not
TLS_1_2_VERSION is refused before any hardware state is programmed.

A couple of questions on the two new checks below.

> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> index f5acd4be1e69d..29e108ce67645 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> @@ -431,6 +431,9 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
>  	atomic64_inc(&port_stats->ktls_tx_connection_open);
>  	u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;
>  
> +	if (crypto_info->version != TLS_1_2_VERSION)
> +		goto out;
> +

[Severity: Low]
Is this new check in chcr_ktls_dev_add() reachable as of this commit?  At
this point net/tls still filters the version before calling
->tls_dev_add:

net/tls/tls_device.c:tls_set_device_offload() {
	...
	if (crypto_info->version != TLS_1_2_VERSION) {
		rc = -EOPNOTSUPP;
		goto release_netdev;
	}
	...
}

and the same for the receive side in tls_set_device_offload_rx():

	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
		return -EOPNOTSUPP;

The guards do become live once those two core checks are dropped later in
the series, and the ordering here looks bisect-safe, so this is only a
changelog question: could the commit message say that this is a
prerequisite for the later core change that starts accepting TLS 1.3
crypto_info, rather than describing it as preventing attempts that the
core currently already blocks?

For nfp the guard is also not covered by nfp_net_cipher_supported(), which
only looks at cipher_type, so a TLS 1.3 AES-GCM-128 crypto_info would pass
that helper once the core stops filtering versions.

[Severity: Low]
This isn't a bug, but the two halves of the patch report the same
condition differently.  nfp_net_tls_add() returns -EOPNOTSUPP while
chcr_ktls_dev_add() jumps to the shared failure label:

out:
	atomic64_inc(&port_stats->ktls_tx_connection_fail);
	return -1;

so chcr reports -EPERM for an unsupported version and also counts the
request in both ktls_tx_connection_open and ktls_tx_connection_fail.

The errno does not reach userspace on the only reachable path, since
do_tls_setsockopt_conf() treats any nonzero return from
tls_set_device_offload() on an initial install as a software fallback:

net/tls/tls_main.c:do_tls_setsockopt_conf() {
	...
	rc = tls_set_device_offload(sk);
	conf = TLS_HW;
	if (!rc) {
	...
	} else {
		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
	...
}

and the counter behaviour matches the existing reject branches in the same
function (RX direction, chcr_get_ktls_tx_info(), u_ctx->detach), which all
use the same out: label.  Would it still be preferable to return
-EOPNOTSUPP here to match nfp_net_tls_add() and the core?

>  	if (direction == TLS_OFFLOAD_CTX_DIR_RX) {
>  		pr_err("not expecting for RX direction\n");
>  		goto out;
> diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
> index 9983d7aa2b9cd..13864c6a55dce 100644
> --- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
> +++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
> @@ -287,6 +287,9 @@ nfp_net_tls_add(struct net_device *netdev, struct sock *sk,
>  	BUILD_BUG_ON(offsetof(struct nfp_net_tls_offload_ctx, rx_end) >
>  		     TLS_DRIVER_STATE_SIZE_RX);
>  
> +	if (crypto_info->version != TLS_1_2_VERSION)
> +		return -EOPNOTSUPP;
> +
>  	if (!nfp_net_cipher_supported(nn, crypto_info->cipher_type, direction))
>  		return -EOPNOTSUPP;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
