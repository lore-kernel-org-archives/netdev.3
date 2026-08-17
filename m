Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA913AEF5F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004702; cv=none; b=XV0RVi0LYEPFEjEVxYnRFM7nsFo3Z2ZCCQYlejxrUcUM4QbHacPA29EyLHj53P3VU2ZuRGSa3g8RQqQy/xA3fDidbP8jsReyZL/5+guV16qQTwXTUI+rYjTi8i901+EaOAjW/oz74VmoVzFUWbsuTfCVNkrDKInsmLWYhKn3sUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004702; c=relaxed/simple;
	bh=jr4eL4rza9b4m2o13CTM9yRHK7Tl2iTQy5QTWStmDYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2TaKJImrqedlCuY6Z/X8tmEPDgxIf4jgkz1k9PpBU/BN1AbenHWiGYWgqNtZzdZR2kNvOak8HNT6lZSLwTkRR0Tv01z/4ZFidtG2CnGQ6qZubeRfM3WjMCSAdOfC/WOqnmdA4mbqrmwqCjPafaientVGnh6aCD5AaCsKT36jyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGuPERGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGuPERGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EE11F000E9;
	Mon, 17 Aug 2026 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004700;
	bh=fUkFER06XpdiqCN8B/QEJAWz2+D9SBfwp9JNQyNre0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SGuPERGS5Voui44gq+dGtwh+r3powQU83A1WufgfvbaDce6YKoGkTeZE2QvAqWhF4
	 gxdVibqg0R7MSSB6kT7LM1u3xnC2M58OwHm10/jl9TYtx9HANQx1unRD55AScBN1Wi
	 NjruqKYU/w9a8b/X0Icuqmmq9bTBJUzaVQJjlW5ZUkWzgjANCKl5qjx7aN8bnLDpHI
	 ArqhlRI9PJfjxb/y4Jt7AeUPxkqB9pKCDf9KjWtGPkMh7XTOhl30aUrATjPYIczG9T
	 RKvxhR0meC22c7ts++Ka+kyK/1LhgAgZUbrcRMsovN7Gj1VESTkWJ0XVHjtzAQ7KDJ
	 wDdJ1zvs+KCRw==
From: Jakub Kicinski <kuba@kernel.org>
To: rjethwani@purestorage.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v16 04/10] tls: add TLS 1.3 hardware offload support
Date: Mon, 17 Aug 2026 15:11:28 -0700
Message-ID: <20260817221128.3666336-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807183853.2288959-5-rjethwani@purestorage.com>
References: <20260807183853.2288959-5-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    tls: add TLS 1.3 hardware offload support

This drops the TLS_1_2_VERSION gates in tls_set_device_offload() and
tls_set_device_offload_rx(), teaches tls_device_record_close() to append
the TLS 1.3 content_type byte along with the tag, and switches the
device fallback encryption path to prot->prepend_size / prot->aad_size
so the 1.3 layouts work.  tls_device_init() also pre-populates
dummy_page with an identity byte map.

A few questions below.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 37bb06a8e8f5..bbb1aa733500 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -317,25 +317,34 @@ static void tls_device_record_close(struct sock *sk,
>  				    unsigned char record_type)
>  {
>  	struct tls_prot_info *prot = &ctx->prot_info;
> -	struct page_frag dummy_tag_frag;
> -
> -	/* append tag
> -	 * device will fill in the tag, we just need to append a placeholder
> -	 * use socket memory to improve coalescing (re-using a single buffer
> -	 * increases frag count)
> -	 * if we can't allocate memory now use the dummy page
> +	int tail = prot->tag_size + prot->tail_size;
> +
> +	/* Append tail: tag for TLS 1.2, content_type + tag for TLS 1.3.
> +	 * Device fills in the tag, we just need to append a placeholder.
> +	 * Use socket memory to improve coalescing (re-using a single buffer
> +	 * increases frag count); if allocation fails use dummy_page
> +	 * (offset = record_type gives correct content_type byte via
> +	 * identity mapping)
>  	 */
> -	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
> -	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
> -		dummy_tag_frag.page = dummy_page;
> -		dummy_tag_frag.offset = 0;
> -		pfrag = &dummy_tag_frag;
> +	if (unlikely(pfrag->size - pfrag->offset < tail) &&
> +	    !skb_page_frag_refill(tail, pfrag, sk->sk_allocation)) {
> +		struct page_frag dummy_pfrag = {
> +			.page = dummy_page,
> +			.offset = record_type,
> +		};
> +		tls_append_frag(record, &dummy_pfrag, tail);

[Severity: Medium]
Here record_type is used directly as an offset into the shared global
dummy_page, and tail = prot->tag_size + prot->tail_size bytes are appended
starting from that offset.  tls_device_init() only writes the first 256
bytes of the page, and the page comes from a plain alloc_page(GFP_KERNEL),
so the rest is not zeroed.

With AES-GCM (tag_size 16) and TLS 1.3 (tail_size 1), a record_type of 240
or above makes the appended frag cover dummy_page bytes
[256, record_type + 17), which are never initialized.

record_type is taken verbatim from the user cmsg; tls_process_cmsg() in
tls_main.c checks only cmsg_len and MSG_MORE:

	case TLS_SET_RECORD_TYPE:
		if (cmsg->cmsg_len < CMSG_LEN(sizeof(*record_type)))
			return -EINVAL;
		if (msg->msg_flags & MSG_MORE)
			return -EINVAL;
		...
		*record_type = *(unsigned char *)CMSG_DATA(cmsg);

so all 256 offsets are reachable from an unprivileged process.  Can this
put uninitialized page contents into the tag placeholder area of the
record?  Would zeroing the page (__GFP_ZERO), initializing
256 + max tag bytes, or bounding the offset be preferable?

Related to this, the comment added in tls_device_init() says "By populating
all 256 values, we avoid needing to validate record_type at runtime", but
the identity map only covers the content_type byte, not the tag portion of
the tail that follows it.

> +	} else {
> +		if (prot->tail_size) {
> +			char *content_type_addr = page_address(pfrag->page) +
> +						  pfrag->offset;
> +			*content_type_addr = record_type;
> +		}
> +		tls_append_frag(record, pfrag, tail);
>  	}
> -	tls_append_frag(record, pfrag, prot->tag_size);

[Severity: High]
This isn't a bug introduced by this patch, but the else branch now
dereferences pfrag->page one step earlier than before, and pfrag->page is
never checked for NULL.

Consider the state skb_page_frag_refill() leaves behind on failure in
net/core/sock.c:

	pfrag->offset = 0;
	...
	pfrag->page = alloc_page(gfp);
	if (likely(pfrag->page)) {
		pfrag->size = PAGE_SIZE;
		return true;
	}
	return false;

offset is zeroed and page is NULL, but size keeps its previous non-zero
value, so pfrag->size - pfrag->offset is at least PAGE_SIZE and the
"< tail" guard here is false.  The dummy_page fallback is skipped and the
else branch runs.

Can tls_device_record_close() then be reached with that pfrag?  In
tls_push_data(), with an already-open record (record->len >
prot->prepend_size, e.g. after a previous MSG_MORE sendmsg),
tls_do_allocation() takes the sk_page_frag_refill(sk, pfrag) path; on
allocation failure it returns -ENOMEM, sk_stream_wait_memory() returns
non-zero (immediately -EAGAIN for MSG_DONTWAIT), and control does:

	} else if (record->len > prot->prepend_size) {
		goto last_record;
	}

which sets done = true and calls tls_device_record_close(sk, tls_ctx,
record, pfrag, record_type).

For TLS 1.3 (prot->tail_size == 1) that computes page_address(NULL) + 0 and
stores record_type through it, then tls_append_frag() does get_page(NULL).
The pre-patch code took the same false branch and crashed in
tls_append_frag(), so the NULL deref itself is older, but should this test
pfrag->page (or reset pfrag->size on refill failure) so the dummy_page
fallback that exists for exactly this situation is actually used?

>  
>  	/* fill prepend */
>  	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
> -			 record->len - prot->overhead_size,
> +			 record->len - prot->overhead_size + prot->tail_size,
>  			 record_type);
>  }
>  

[ ... ]

> @@ -1091,11 +1100,6 @@ int tls_set_device_offload(struct sock *sk)
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

[Severity: Low]
Should Documentation/networking/tls-offload.rst be updated along with this?
Its Rekey section still says:

	Offload does not currently support TLS 1.3, therefore key rotation
	is not a concern for offloaded connections at this point.

Removing the version gates here and in tls_set_device_offload_rx() makes
the first half untrue, and the later patches in the series ("tls: device:
add TX KeyUpdate support", "tls: device: add RX KeyUpdate support") make
the second half untrue.  No patch in the series touches that file, so the
sentence is still there at the end of the series.

>  
> @@ -1410,12 +1411,22 @@ static struct notifier_block tls_dev_notifier = {
>  
>  int __init tls_device_init(void)
>  {
> -	int err;
> +	unsigned char *page_addr;
> +	int err, i;
>  
>  	dummy_page = alloc_page(GFP_KERNEL);
>  	if (!dummy_page)
>  		return -ENOMEM;
>  
> +	/* Pre-populate dummy_page with identity mapping for all byte values.
> +	 * This is used as fallback for TLS 1.3 content type when memory
> +	 * allocation fails. By populating all 256 values, we avoid needing
> +	 * to validate record_type at runtime.
> +	 */
> +	page_addr = page_address(dummy_page);
> +	for (i = 0; i < 256; i++)
> +		page_addr[i] = (unsigned char)i;
> +
>  	destruct_wq = alloc_workqueue("ktls_device_destruct", WQ_PERCPU, 0);
>  	if (!destruct_wq) {
>  		err = -ENOMEM;
-- 
pw-bot: cr
