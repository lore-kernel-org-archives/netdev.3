Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFB376A0A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042165; cv=none; b=iN75EViDnYlHiPAwfo8wD2rTo21gvZVAdT9ijoMSGyUWOwi+EGWkERtYNQzIXp4FoOXQYurstGHgVSW/nUR5v42pZZfI198ZKu/hnFVI++h6DjMV3nu94836C8s0ezitNUfMUxz9FCmf9K7boQvt8ETsQ+FduNp32fd0bwGn+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042165; c=relaxed/simple;
	bh=T1mFpJzOw7sOlkX+IS2QUxEyraakMazQQbdvgJ7ay/U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UssXpRdm+rtuvELYm8Z6C0xgCigJ1WquCGEf1RM4GhVjbwUeIbDGffmfwpLY/TmAyOdHWTAU0uAq+YhluauIfYYa7/vEmj8rAkR1znlifMf1ppKDMGqN9GQ1zfjoiBUZ++eovE5BYo4e15cXk6XkinC6r0Xl6u7+GjqMrdZ17Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3aU2kse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3aU2kse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792961F00893;
	Tue, 22 Sep 2026 01:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042163;
	bh=y4reW+1yA5eY7DB/SnD17ZDstOEabh1zay9p6h2nj8w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l3aU2kseNIRzcex3kLCgdU2Jf0OovV2WGbx21rjShJ1uCPAq+OELSz7jSTWEcjYAV
	 Zn1ddGUCdXhP7d6Tjm5WCkRADjq7sO4tFfW9dbQdQP7MXqwBjiHOVAo43tydCMyEeT
	 2a2j/HDYzUwKBFkQfhLyVYhoSl37AD4Bon70ZVM9TMyDYy5+g7tnmAa2KZEcV7bmVZ
	 wSXtTBpC1p5RQ79lL11s2n2QbfX8+uqCoAVsNnXNsmsnLYx/kO1TmhXvUzfQIsgO7M
	 gQ4lxbkYZ4pm8ZRxFVtA+pObmZoYeAtsHcLtz8Jpp+e3PAvyFj6OwejYVzOV66QVFi
	 NdOrOJtu3AXIg==
Subject: Re: [PATCH net-next v17 06/15] tls: prep helpers and refactors for HW
 offload KeyUpdate
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:01 +0000
Message-ID: <179004216198.2160803.5393884416507823024@kernel.org>
In-Reply-To: <20260917224355.2288021-7-rjethwani@purestorage.com>
References: <20260917224355.2288021-7-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Concern (validated as NOT actionable): moving
  crypto_aead_setauthsize() into the `if (!*aead)` block of…

--

tls: prep helpers and refactors for HW offload KeyUpdate

This patch does preparatory refactoring for TX and RX HW rekey support:
hoisting cipher_context / tls_crypto_context, adding tls_tx_cipher_ctx(),
splitting tls_set_device_offload() and tls_sw_splice_eof(), and moving
crypto_aead_setauthsize() into the !*aead block of tls_sw_ctx_init().

One question below about the relocated crypto_aead_setauthsize() call.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 7b593dac2c31..5531303dd704 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -2576,6 +2592,10 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
>  
>  	key = crypto_info_key(src_crypto_info, cipher_desc);
>  
> +	/* A rekey normally reuses the existing tfm; the RX HW rekey hands over a
> +	 * NULL aead (the old one is retained for the drain), so allocate and
> +	 * configure authsize only when a fresh tfm is created here.
> +	 */
>  	if (!*aead) {
>  		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
>  		if (IS_ERR(*aead)) {
> @@ -2583,6 +2603,10 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
>  			*aead = NULL;
>  			goto free_priv;
>  		}
> +
> +		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
> +		if (rc)
> +			goto free_aead;
>  	}

[Severity: Medium]
Could the contract for this new error path be spelled out in the comment?

This adds a fallible step inside the !*aead block, and its unwind label
does:

net/tls/tls_sw.c:tls_sw_ctx_init() {
	...
free_aead:
	crypto_free_aead(*aead);
	*aead = NULL;
free_priv:
	if (!new_crypto_info) {
	...
}

So when a caller combines new_crypto_info != NULL with *aead == NULL, a
setauthsize failure leaves the live sw context with aead_recv == NULL and
free_priv skipped.

The same shape applies to the setkey branch just below, where a freshly
allocated tfm is left installed but unkeyed:

	rc = crypto_aead_setkey(*aead, key, cipher_desc->key);
	if (rc) {
		if (new_crypto_info)
			goto out;

At this commit neither case looks reachable: the only rekey caller reaches
tls_sw_ctx_init() with an already-allocated *aead, and both device helpers
still return -EOPNOTSUPP when tx_conf / rx_conf is not TLS_BASE, so
!*aead is never taken together with new_crypto_info != NULL.

The later RX rekey work in this series is the first user that hands over a
NULL aead, and it does restore context->rekey.old_aead_recv on every
tls_sw_ctx_init() failure, so the ownership rule seems intentional. Would
it be worth stating in the comment that a caller passing *aead == NULL with
new_crypto_info != NULL owns restoring the previous tfm on error, so a
future caller does not inherit a NULL or unkeyed aead_recv?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
