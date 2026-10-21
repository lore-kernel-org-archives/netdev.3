Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619300;
	b=rYeepxGySA0LfsICxRnmvvFLaNiKT8i/e4NVDjQfIo1sk12F5v54LkKhK0Ul4KdpaxSI
	 GqaxtcJiHouvQLWuTYrqnKjkqoJyIFXytntNAQoMl7O53sKUpzGuKMIB3TjLN8XUouBer
	 mic+zB2EckN1c/f7tTfQs+paXEge0Y8ZqpduWaEQpdPLj0XGkCgc0nUbpLY3JXs37IYTT
	 OVufmv9pY8Q1xIDCv8ERdOUxMpR0PFyl9CO8gh0TwiEsAtzHUIfLxKTJA3a9WsB2nqRmJ
	 +pMefAAVtz/TXAxv7klIC0GlXIUrGJTTz9ZZjw2+uwCalBq5yZX1NDEL1xg7V7Ti6/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619300;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=BNmG7yJjoNt8Ptd0MZtdJ7UznCSNc7rDzGQLdC+cy7E=;
	b=fN+TfE3ZshXawm6fjFovlI38SDBUQt8YZ02ndtR8DLHUOR1wBPq5zoQEwmyGSyXvtyTn
	 7nzRGxx0lUBi71v5yftrWLUG40ROHQCPIVtxFfOcaVfpPPIFwEGW9xG3AgmtDp8lDLm1o
	 rAm6vb5qD4ZFaMAc+BP6DfxqxSqe9V80yuAchA2ar6LfhC5NGaIjZ8Z70HayIe9WLf7ix
	 8dO+EAid0UBoUQ+2+2mhI/yzqmkiDeah04JpKGDqNoVAB1NB3ZBvcY4fNoyklQ02noweS
	 /ZcZ1gji9kODwojLDPWpF/5UCzxp/UUaOdeKHSxqEpf2MFGrXSAkxK1RNKQo0Vz+Asw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hH9mrAs+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9cQhfpLx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y3Ubh2X8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ebfsji5B;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA1606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36CA1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hH9mrAs+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9cQhfpLx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y3Ubh2X8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ebfsji5B
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EC8321EB7;
	Wed, 21 Oct 2026 21:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792619297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNmG7yJjoNt8Ptd0MZtdJ7UznCSNc7rDzGQLdC+cy7E=;
	b=hH9mrAs+lGttPEdAZ+jo0InqkNhclnMv4XuNiMRATQ4PjlVV0zHco/+SzKs//zx21BcZ/K
	gPu0KLnwEEX1Z4BuUxAoAQ4Hm37+RICdcey1Idy//GkMUwa2rBtB6PKj090lJ5XWPP/9Vx
	AhQn7VHS4+st9NoJTO/Ib6fBN3g+EAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792619297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNmG7yJjoNt8Ptd0MZtdJ7UznCSNc7rDzGQLdC+cy7E=;
	b=9cQhfpLxrrw1J+mL2fXF7dWeueIKBLqOgVoX8bbG6vEXm+t145ZqklRc9MpcrdGl4VNgyw
	BMHAlL5HI45kpsCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792619296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNmG7yJjoNt8Ptd0MZtdJ7UznCSNc7rDzGQLdC+cy7E=;
	b=y3Ubh2X8v83c46Ug5/Szywg+F1P/GtlKjE0xV5bUMccd2OWhBO7fSpO6+NqCmTeimSumdK
	hjoleivsMQWnwfKh8yWoMIfLwUHnB44MyISJD52I5zsQ/eAVdBeiML80E5uj5le6+8zWKs
	j0H8aFzZqWBDyaGYQZ0lLSc2X4HGdlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792619296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNmG7yJjoNt8Ptd0MZtdJ7UznCSNc7rDzGQLdC+cy7E=;
	b=Ebfsji5BJjia+pyQ2jigm735PEtXPc0WOy8PYwae8s9aXHfXlWXQoRYyNXFszm4Wz5Dy8b
	gIFDiHsVPzn+oFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B295134A5;
	Wed, 21 Oct 2026 21:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QC/lCh8z2WpAGgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 21 Oct 2026 21:48:15 +0000
Message-ID: <08f938a3-8315-425e-86f8-3e622f035f3e@suse.de>
Date: Wed, 21 Oct 2026 23:48:05 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/15] net: skbuff: make
 skb_copy_and_csum_bits() report unreadable frags
To: Josef Bacik <josef@toxicpanda.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Mina Almasry <almasrymina@google.com>,
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
 <20261021-b4-skbuff-bug-on-followups-v2-1-2aa780a03524@toxicpanda.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-1-2aa780a03524@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,gmail.com,google.com,vger.kernel.org,lists.xenproject.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
X-Spam-Level: 
X-Spam-Flag: NO

On 10/21/26 3:46 PM, Josef Bacik wrote:
> skb_copy_and_csum_bits() has no way to fail.  When it reaches
> unreadable frags it zero-fills the rest of the buffer and returns 0,
> and since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
> skb_copy_and_csum_bits()") that 0 is the correct checksum for what's in
> the buffer.  Its callers can't tell the copy didn't happen.
> 
> That matters in the !sg && !csum branch of skb_segment().  A devmem TCP
> skb keeps its whole payload in unreadable frags, so every segment ends
> up with a payload of zeroes, tcp_gso_segment() writes a valid TCP
> checksum over it, and the peer accepts the zeroes as stream data.  This
> is reachable when both SG and TX checksum offload are turned off on a
> device used for devmem TX: sk_setup_caps() still gives TCP SG and
> HW_CSUM, so the dmabuf send is accepted, validate_xmit_unreadable_skb()
> lets the skb through for a NETMEM_TX_NO_DMA device or a matching
> binding, and software GSO segments it with neither feature.  Before
> that commit the segments carried uninitialized memory with a checksum
> that almost never matched.
> 
> This was reproduced with a test module rather than on devmem hardware:
> skb_segment() on a TCPv4 GSO skb with 3000 bytes of payload in a page
> frag marked unreadable, with features == 0, returns 3 segments whose
> payloads are all zeroes, each with a checksum of 0, which is correct for
> zeroes.  There's no warning or error; the data is silently replaced.
> With this patch skb_segment() returns -EFAULT.
> 
> Make skb_copy_and_csum_bits() return 0 or -EFAULT and hand the checksum
> back through a pointer, and make it __must_check so a new caller can't
> ignore the failure.  Running out of skb before @len returns -EFAULT
> too; commit 417261779eab ("net: skbuff: don't BUG() on leftover length
> in skb_copy_and_csum_bits()") made that a zero-fill and a checksum of 0.
> Each caller takes the error path it already has for a failed copy:
> 
>   - skb_segment() fails the segmentation, as the csum branch already
>     does when skb_copy_bits() fails.
>   - icmp_glue_bits() and icmpv6_getfrag() return the error, so the ICMP
>     error isn't sent.
>   - __ip_append_data() and __ip6_append_data() drop the new skb and
>     return -EFAULT, as they do when getfrag fails.
>   - vnet_skb_shape() fails the same way it does when its skb_copy_bits()
>     call fails.
>   - xdr_skb_read_bits() returns 0 without consuming anything, as it does
>     when skb_copy_bits() fails, so desc.count stays non-zero and
>     csum_partial_copy_to_xdr() fails.  csum_partial_copy_to_xdr() used
>     to checksum the bytes it hadn't copied before checking desc.count.
>     desc.offset and desc.count always add up to skb->len, so that only
>     ran when it was about to fail anyway, and on an unreadable skb
>     skb_checksum() would WARN.  Drop it.
>   - skb_copy_and_csum_dev() can't return an error, so it leaves the
>     checksum alone and the frame goes out with a bad one.  Its callers
>     are drivers that never see unreadable skbs anyway.
> 
> The zero-fill stays, so a caller that does send the buffer still
> doesn't leak anything.
> 
> This was found by the Sashiko AI review of that commit, and
> Mina suggested reporting the error from the helper rather than checking
> for unreadable frags in skb_segment().
> 
> Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Hm, I do wonder isn't this missing the Fixes tag for ab9414ed70bd and 
417261779eab? I don't have a strong opinion but since ab9414ed70bd will 
be backported to stable (quite likely..) it makes sense to me.

> ---
>   drivers/net/ethernet/sun/sunvnet_common.c | 10 +++--
>   include/linux/skbuff.h                    |  4 +-
>   net/core/skbuff.c                         | 63 +++++++++++++++++++++----------
>   net/ipv4/icmp.c                           |  9 +++--
>   net/ipv4/ip_output.c                      | 11 ++++--
>   net/ipv6/icmp.c                           |  7 +++-
>   net/ipv6/ip6_output.c                     | 11 ++++--
>   net/sunrpc/socklib.c                      |  9 ++---
>   8 files changed, 83 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
> index 5cca95869052..4f229fcecc32 100644
> --- a/drivers/net/ethernet/sun/sunvnet_common.c
> +++ b/drivers/net/ethernet/sun/sunvnet_common.c
> @@ -1167,9 +1167,13 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
>   
>   			/* copy the rest, with csum calculation */
>   			*(__sum16 *)(skb->data + offset) = 0;
> -			csum = skb_copy_and_csum_bits(skb, start,
> -						      nskb->data + start,
> -						      skb->len - start);
> +			if (skb_copy_and_csum_bits(skb, start,
> +						   nskb->data + start,
> +						   skb->len - start, &csum)) {
> +				dev_kfree_skb(nskb);
> +				dev_kfree_skb(skb);
> +				return NULL;
> +			}
>   
>   			/* add in the header checksums */
>   			if (skb->protocol == htons(ETH_P_IP)) {
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index af1cbc2799b7..09db32f70b53 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4277,8 +4277,8 @@ void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
>   int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
>   int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
>   int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
> -__wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset, u8 *to,
> -			      int len);
> +int __must_check skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
> +					u8 *to, int len, __wsum *csum);

For consistency skb_copy_and_csum_bits() should use csump instead of 
csum in the prototype to match the implementation and kernel-doc 
parameter name.

>   int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>   		    struct pipe_inode_info *pipe, unsigned int len,
>   		    unsigned int flags);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 93c2f440b9ec..a2b52a5a61a9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3630,14 +3630,27 @@ EXPORT_SYMBOL(skb_checksum);
>   
>   /* Both of above in one bottle. */
>   

I guess we can now remove this comment. I mean the kernel-doc being 
added here makes it a bit redundant in my opinion.

> -__wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
> -				    u8 *to, int len)
> +/**
> + *	skb_copy_and_csum_bits - copy data out of an skb and checksum it
> + *	@skb: source buffer
> + *	@offset: offset in @skb to start copying from
> + *	@to: destination buffer
> + *	@len: number of bytes to copy
> + *	@csump: where to store the checksum of the copied bytes
> + *
> + *	Return: 0 on success, or -EFAULT if @skb has unreadable frags or runs
> + *	out before @len does.  On failure *@csump is not set and the part of
> + *	@to that couldn't be filled is zeroed.
> + */
> +int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
> +			   u8 *to, int len, __wsum *csump)
>   {
>   	int start = skb_headlen(skb);
>   	int i, copy = start - offset;
>   	struct sk_buff *frag_iter;
>   	int pos = 0;
>   	__wsum csum = 0;
> +	int err;
>   
>   	/* Copy header. */
>   	if (copy > 0) {
> @@ -3646,7 +3659,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>   		csum = csum_partial_copy_nocheck(skb->data + offset, to,
>   						 copy);
>   		if ((len -= copy) == 0)
> -			return csum;
> +			goto out;
>   		offset += copy;
>   		to     += copy;
>   		pos	= copy;
> @@ -3656,7 +3669,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>   		/* Don't hand the caller a buffer with stale bytes in it. */
>   		if (len > 0)
>   			memset(to, 0, len);
> -		return 0;
> +		return -EFAULT;
>   	}
>   
>   	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> @@ -3688,7 +3701,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>   			}
>   
>   			if (!(len -= copy))
> -				return csum;
> +				goto out;
>   			offset += copy;
>   			to     += copy;
>   		}
> @@ -3705,12 +3718,16 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>   		if ((copy = end - offset) > 0) {
>   			if (copy > len)
>   				copy = len;
> -			csum2 = skb_copy_and_csum_bits(frag_iter,
> -						       offset - start,
> -						       to, copy);
> +			err = skb_copy_and_csum_bits(frag_iter, offset - start,
> +						     to, copy, &csum2);
> +			if (err) {
> +				/* The child zeroed its part; zero the rest. */
> +				memset(to + copy, 0, len - copy);
> +				return err;
> +			}
>   			csum = csum_block_add(csum, csum2, pos);
>   			if ((len -= copy) == 0)
> -				return csum;
> +				goto out;
>   			offset += copy;
>   			to     += copy;
>   			pos    += copy;
> @@ -3722,9 +3739,11 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>   		/* Don't hand the caller a buffer with stale bytes in it. */
>   		if (len > 0)
>   			memset(to, 0, len);
> -		return 0;
> +		return -EFAULT;
>   	}
> -	return csum;
> +out:
> +	*csump = csum;
> +	return 0;
>   }
>   EXPORT_SYMBOL(skb_copy_and_csum_bits);
>   
> @@ -4006,9 +4025,13 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
>   	skb_copy_from_linear_data(skb, to, csstart);
>   
>   	csum = 0;
> -	if (csstart != skb->len)
> -		csum = skb_copy_and_csum_bits(skb, csstart, to + csstart,
> -					      skb->len - csstart);
> +	/* On failure the rest of @to is zeroed; leave the checksum alone so
> +	 * the frame goes out with a bad one.
> +	 */
> +	if (csstart != skb->len &&
> +	    skb_copy_and_csum_bits(skb, csstart, to + csstart,
> +				   skb->len - csstart, &csum))
> +		return;
>   
>   	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>   		long csstuff = csstart + skb->csum_offset;
> @@ -5057,11 +5080,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   			if (!csum) {
>   				if (!nskb->remcsum_offload)
>   					nskb->ip_summed = CHECKSUM_NONE;
> -				SKB_GSO_CB(nskb)->csum =
> -					skb_copy_and_csum_bits(head_skb, offset,
> -							       skb_put(nskb,
> -								       len),
> -							       len);
> +				if (skb_copy_and_csum_bits(head_skb, offset,
> +							   skb_put(nskb, len),
> +							   len,
> +							   &SKB_GSO_CB(nskb)->csum)) {
> +					err = -EFAULT;
> +					goto err;
> +				}
>   				SKB_GSO_CB(nskb)->csum_start =
>   					skb_headroom(nskb) + doffset;
>   			} else {
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 90c0e22c29be..35008785e3d2 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -364,12 +364,15 @@ static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
>   	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
>   			IP_OPTIONS_DATA_FIXED_SIZE);
>   	__wsum csum;
> +	int err;
>   
>   	icmp_param = from;
>   
> -	csum = skb_copy_and_csum_bits(icmp_param->skb,
> -				      icmp_param->offset + offset,
> -				      to, len);
> +	err = skb_copy_and_csum_bits(icmp_param->skb,
> +				     icmp_param->offset + offset,
> +				     to, len, &csum);
> +	if (err)
> +		return err;
>   
>   	skb->csum = csum_block_add(skb->csum, csum, odd);
>   	if (icmp_param->data.icmph.type <= NR_ICMP_TYPES &&
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 3396f177a18d..f7da4538d05b 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1162,9 +1162,14 @@ static int __ip_append_data(struct sock *sk,
>   			data += fragheaderlen + exthdrlen;
>   
>   			if (fraggap) {
> -				skb->csum = skb_copy_and_csum_bits(
> -					skb_prev, maxfraglen,
> -					data + transhdrlen, fraggap);
> +				if (skb_copy_and_csum_bits(skb_prev, maxfraglen,
> +							   data + transhdrlen,
> +							   fraggap,
> +							   &skb->csum)) {
> +					err = -EFAULT;
> +					kfree_skb(skb);
> +					goto error;
> +				}
>   				skb_prev->csum = csum_sub(skb_prev->csum,
>   							  skb->csum);
>   				data += fraggap;
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index a95b0351824f..31ca3da80b1f 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -322,9 +322,12 @@ static int icmpv6_getfrag(void *from, char *to, int offset, int len, int odd, st
>   	struct icmpv6_msg *msg = (struct icmpv6_msg *) from;
>   	struct sk_buff *org_skb = msg->skb;
>   	__wsum csum;
> +	int err;
>   
> -	csum = skb_copy_and_csum_bits(org_skb, msg->offset + offset,
> -				      to, len);
> +	err = skb_copy_and_csum_bits(org_skb, msg->offset + offset,
> +				     to, len, &csum);
> +	if (err)
> +		return err;
>   	skb->csum = csum_block_add(skb->csum, csum, odd);
>   	if (!(msg->type & ICMPV6_INFOMSG_MASK))
>   		nf_ct_attach(skb, org_skb);
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a..d259e7dca8ba 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1724,9 +1724,14 @@ static int __ip6_append_data(struct sock *sk,
>   			skb->transport_header = (skb->network_header +
>   						 fragheaderlen);
>   			if (fraggap) {
> -				skb->csum = skb_copy_and_csum_bits(
> -					skb_prev, maxfraglen,
> -					data + transhdrlen, fraggap);
> +				if (skb_copy_and_csum_bits(skb_prev, maxfraglen,
> +							   data + transhdrlen,
> +							   fraggap,
> +							   &skb->csum)) {
> +					err = -EFAULT;
> +					kfree_skb(skb);
> +					goto error;
> +				}
>   				skb_prev->csum = csum_sub(skb_prev->csum,
>   							  skb->csum);
>   				data += fraggap;
> diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
> index d8d8842c7de5..5d780ad4ae3a 100644
> --- a/net/sunrpc/socklib.c
> +++ b/net/sunrpc/socklib.c
> @@ -49,7 +49,9 @@ xdr_skb_read_bits(struct xdr_skb_reader *desc, void *to, size_t len)
>   	if (desc->need_checksum) {
>   		__wsum csum;
>   
> -		csum = skb_copy_and_csum_bits(desc->skb, desc->offset, to, len);
> +		if (unlikely(skb_copy_and_csum_bits(desc->skb, desc->offset,
> +						    to, len, &csum)))
> +			return 0;
>   		desc->csum = csum_block_add(desc->csum, csum, desc->offset);
>   	} else {
>   		if (unlikely(skb_copy_bits(desc->skb, desc->offset, to, len)))
> @@ -142,11 +144,6 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
>   	desc.csum = csum_partial(skb->data, desc.offset, skb->csum);
>   	if (xdr_partial_copy_from_skb(xdr, &desc) < 0)
>   		return -1;
> -	if (desc.offset != skb->len) {
> -		__wsum csum2;
> -		csum2 = skb_checksum(skb, desc.offset, skb->len - desc.offset, 0);
> -		desc.csum = csum_block_add(desc.csum, csum2, desc.offset);
> -	}
>   	if (desc.count)
>   		return -1;
>   	if (csum_fold(desc.csum))
> 

