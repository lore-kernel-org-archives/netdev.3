Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6F3E0C57
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048792; cv=none; b=BOCXTVFkEmith2ybpqQaJQs2kfiSRUsA6Ld2iyUMgdAb69QhGURYHk8VPz3W35GXmCZIq4DKdzzLxDMXu38mqlvejJdQJFCazstNvHAPyraW5mfCmw5KfAJ6fvzvHxto1nd8qGTrEsJCSG6KcCkpcFomSk7rHlKLqbAK0X+asm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048792; c=relaxed/simple;
	bh=xTBXyEwWIw9wzZtWneTmGh/ov5cSjhYi/ynl5QEcRxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLHU0Kr3u2qzUk0oQbgXDpdvMz1TZh3TeMDuYrZQBJzo+7vNoW7pPBQIs/2a/qs09ecsdZZq9FpeE+XZMdnrkxaadQlj41nPJ5iV8YBXerhlg4B4cpvEEpQk3ro0MFxEIpg92A0UmkxKKZcc0Zxb8FyH8iIz3TiUF+qJ3MQTc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVE1d5R/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVE1d5R/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787048788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfmRYSSD4DxmCDXiJmvMWFqGNL7fNNmumSI6KufgNeY=;
	b=VVE1d5R/s/VBiMqv+W0RCzBTTumMwOVylLxrXbVS2Aa6ZM+PWRuiDK8sSBr/hkjlH2z3f7
	pYpO4w6t3aZDn9ZqbVpdOW+l5ncOqv9AHv8KGdLvp7WBT9QqHtgFfZntp4bP8GXvHm2zVK
	D4N1hFM1sOpaQomBr+qjTANyNSaVxgk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-ls6zQAi1N2u0d-WDfWfsPQ-1; Tue,
 18 Aug 2026 06:26:13 -0400
X-MC-Unique: ls6zQAi1N2u0d-WDfWfsPQ-1
X-Mimecast-MFC-AGG-ID: ls6zQAi1N2u0d-WDfWfsPQ_1787048771
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C315318004A9;
	Tue, 18 Aug 2026 10:26:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB79D422;
	Tue, 18 Aug 2026 10:26:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: almasrymina@google.com
Cc: kuba@kernel.org,
	kaiyuanz@google.com,
	willemb@google.com,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	davem@davemloft.net,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	kerneljasonxing@gmail.com,
	asml.silence@gmail.com,
	bobbyeshleman@gmail.com,
	fw@strlen.de
Subject: Re: [PATCH net v4 1/2] net: core: propagate unreadable flag in skb_zerocopy
Date: Tue, 18 Aug 2026 12:25:57 +0200
Message-ID: <20260818102557.132214-1-pabeni@redhat.com>
In-Reply-To: <20260814191336.187243-1-almasrymina@google.com>
References: <20260814191336.187243-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: core: propagate unreadable flag in skb_zerocopy

The patch makes skb_zerocopy() propagate the unreadable flag to the
destination skb, returns -EFAULT when a readable head payload would be
mixed with unreadable frags, and rejects unreadable skbs in openvswitch
queue_userspace_packet().

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ba3dbac80fb49..d21af68156950 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -3905,10 +3906,17 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
>  		}
>  	}
>  
> +	if (!skb_frags_readable(from) && j > 0 && len) {
> +		put_page(virt_to_head_page(from->head));
> +		return -EFAULT;
> +	}
> +
>  	skb_len_add(to, len + plen);
>  
>  	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
>  		skb_tx_error(from);
> +		if (j > 0)
> +			put_page(virt_to_head_page(from->head));
>  		return -ENOMEM;
>  	}

[Severity: Medium]
On this -ENOMEM path, is it safe to re-derive the head page from
from->head after skb_orphan_frags() has already run?

skb_orphan_frags() -> skb_copy_ubufs() drops the clone first:

net/core/skbuff.c:skb_copy_ubufs() {
	...
	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
		return -EINVAL;
	...
		page = alloc_pages(gfp_mask | __GFP_COMP, order);
		if (!page) {
			...
			return -ENOMEM;
		}
}

and skb_unclone() -> pskb_expand_head() replaces the buffer:

net/core/skbuff.c:pskb_expand_head() {
	...
	skb->head     = data;
	skb->head_frag = 0;
	...
}

So when the -ENOMEM comes from the alloc_pages() loop, from->head can
already point at a different (freshly allocated) buffer than the page that
was get_page()'d earlier in the hlen == 0 branch:

	page = virt_to_head_page(from->head);
	offset = from->data - (unsigned char *)page_address(page);
	__skb_fill_netmem_desc(to, 0, page_to_netmem(page), offset, plen);
	get_page(page);
	j = 1;

Does that leak the reference on the original head-fragment page, and apply
the put_page() to an unrelated buffer? Today the misdirected put_page() is
quiet because pskb_expand_head() installs slab/kmalloc memory and put_page()
early-returns for folio_test_slab()/folio_test_large_kmalloc() folios, but
the reference on the page that was actually taken is never returned.

Would it be more robust to keep the page pointer captured before get_page()
in a local and use put_page(page) in both new error paths?

I was not able to find an in-tree producer that combines head_frag == 1 with
skb_zcopy() set, so this path may not be reachable today.

[Severity: Low]
This hunk looks like it also fixes an older, unrelated head-page reference
leak. __skb_fill_netmem_desc() does not bump skb_shinfo(to)->nr_frags:

include/linux/skbuff.h:__skb_fill_netmem_desc() {
	__skb_fill_netmem_desc_noacc(skb_shinfo(skb), i, netmem, off, size);
	...
}

and skb_zerocopy() only sets it at the very end with
skb_shinfo(to)->nr_frags = j;. So before this patch, returning -ENOMEM here
left @to with nr_frags == 0 and the extra head-page reference was never
dropped when the caller freed it (consume_skb(user_skb) in
queue_userspace_packet(), kfree_skb() in nfqnl_build_packet_message()).

That leak dates back to 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan
frags in skb_zerocopy and handle errors") and is unrelated to unreadable
frags, while the changelog only mentions unreadable-flag propagation and the
new -EFAULT returns, and the Fixes: tag points at 65249feb6b3d.

Could this hunk be split into its own patch with Fixes: 36d5fe6a0007, or at
least described in the commit message, so that stable backports reach the
pre-6.12 kernels that also contain the leak?

> +	if (i > 0 && from->unreadable)
> +		to->unreadable = 1;
> +

[ ... ]
-- 
This is an AI-generated review.

