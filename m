Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621726;
	b=B6AIZkXBqmO59/c5I8CmVQCe8SRF/zhQUBpdvHDFlWvrgUot/6WYuGuZsyD8oL63FvP/
	 Uv+iR4BRV89mPm4gmM1CU0pxlZHesx5Kg8bodXWZ40v8h/ZyfQgjBK9d0UTw34imCm1UB
	 8HJd/Zs3+ZEqggtZw9DCwJPBVGq/+x1vH9aStQdR2WWTAA622TunOvGX3r5Qps9zKn7Kz
	 UYBYfXy66kAqwhYe5BsQBAmwM/XePA6hsKQ9EpOzwdHtRYSxX7sV8WAQSs3+siBiw9AU7
	 RQUAKlsfeHl4cTPvDNBXNpEFoCxpE+iFR5b0yfnngF+jmTfsGGFf5vwhWrm0gV0kMlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621726;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=p7rHmKltDagdeXBwbSUIWnDSA+9oMoG0gueCO5tixVo=;
	b=R0481xIZ/Pa3zrefE7rfUqQCLRqazthMpdEOThC0Dw0+bI7yqX2p9HuBqYwhEbBLzyeS
	 Uz3UWiBeEr6I7C9M1tzZ+jPBby7f3xwW+7CtYjAAvNav8wa67YrAZGcKTEm3E3IaP84ny
	 qSQ+Ooe9bYQ0tGC+ZLXlBtDe+QkX/wemRk1oPlcUzyvgRpkV3vZVsyqQBosq1rGU+N6qS
	 JhRsbdEESR7vUmw8Ha7i6o0/CfxvX+aNtoBWe93z0S49ZBDC91o5RmWbL9xTsVJeUAtn/
	 lGSlbMD0RCqvSe7jOZ/wZFl79AYW1GiKKQLZrwDUyMIVMhwo6JpMQsalhp6kP/sU8Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qSvcmgVm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LhWVhQb9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qSvcmgVm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LhWVhQb9;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E2606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318E2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qSvcmgVm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LhWVhQb9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qSvcmgVm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LhWVhQb9
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 416A91F8A6;
	Wed, 21 Oct 2026 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792621724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7rHmKltDagdeXBwbSUIWnDSA+9oMoG0gueCO5tixVo=;
	b=qSvcmgVm+BSUT+Y2CtbZ0O4dYmTXb5CuLwxiciKZ7TyLwb9qMLpXghOQtlEaJb676BM20A
	tuwYQNJ59je6gI4w98ZmFtaV2EHe/E0dPVpkgebutLIvM7FKQP3sF9hkxnNUVNt/n9q403
	aNKGiMs/5lp6H5pKxre3KuSRjDDnrj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792621724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7rHmKltDagdeXBwbSUIWnDSA+9oMoG0gueCO5tixVo=;
	b=LhWVhQb9vwHAQBOEPpo386fSUOryzcUDsS5CtY1E1yNEBmuKEf/PiG1e6lTwhmWMBVcSxz
	hsr7D6u1e11SKfBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qSvcmgVm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LhWVhQb9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792621724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7rHmKltDagdeXBwbSUIWnDSA+9oMoG0gueCO5tixVo=;
	b=qSvcmgVm+BSUT+Y2CtbZ0O4dYmTXb5CuLwxiciKZ7TyLwb9qMLpXghOQtlEaJb676BM20A
	tuwYQNJ59je6gI4w98ZmFtaV2EHe/E0dPVpkgebutLIvM7FKQP3sF9hkxnNUVNt/n9q403
	aNKGiMs/5lp6H5pKxre3KuSRjDDnrj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792621724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7rHmKltDagdeXBwbSUIWnDSA+9oMoG0gueCO5tixVo=;
	b=LhWVhQb9vwHAQBOEPpo386fSUOryzcUDsS5CtY1E1yNEBmuKEf/PiG1e6lTwhmWMBVcSxz
	hsr7D6u1e11SKfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 542FE134A5;
	Wed, 21 Oct 2026 22:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pi6BCZs82WoNQwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 21 Oct 2026 22:28:43 +0000
Message-ID: <c658a88f-c5cf-4e74-a6ea-28f14a1db0c2@suse.de>
Date: Thu, 22 Oct 2026 00:28:42 +0200
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
Subject: Re: [PATCH net-next v2 03/15] net: skbuff: fail checksum validation
 when the skb can't be checksummed
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
 <20261021-b4-skbuff-bug-on-followups-v2-3-2aa780a03524@toxicpanda.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-3-2aa780a03524@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 416A91F8A6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,gmail.com,google.com,vger.kernel.org,lists.xenproject.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Score: -12.00

On 10/21/26 3:46 PM, Josef Bacik wrote:
> __skb_checksum_complete() verifies a received packet with
> skb_checksum(), which returns 0 when the range runs into unreadable
> frags or past the end of the skb.  0 is a valid sum, so it's treated as
> one: it adds skb->csum, the pseudo-header sum, and folds the result.
> With a sum of 0 that's csum_fold(skb->csum), which is 0 whenever the
> pseudo-header sum folds to 0xffff, so a packet whose payload was never
> checksummed is accepted, marked csum_valid, and left with a wrong
> CHECKSUM_COMPLETE value in skb->csum.
> 
> __skb_checksum_complete_head() passes skb->csum in as the seed, so a
> failure there folds 0 and the packet fails validation, but only because
> skb_checksum() happened to drop the seed.
> 
> Use skb_checksum_full() in both, and report a packet that can't be
> checksummed as having a bad checksum, so callers drop it the way they
> drop any other bad checksum.  Clear csum_valid, and leave skb->csum and
> ip_summed alone, since there's no full packet checksum to store.
> 
> Found by the Sashiko AI review of the series that made skb_checksum()
> return 0 for a range past the end of the skb.
> 
> Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
> Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Doesn't __skb_gro_checksum_complete() have the same problem? I think it 
could be fixed in this patch too.

> ---
>   net/core/skbuff.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 061c61422a38..40d2dd20d47d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3860,9 +3860,17 @@ EXPORT_SYMBOL(skb_crc32c);
>   
>   __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
>   {
> +	__wsum csum = skb->csum;
>   	__sum16 sum;
>   
> -	sum = csum_fold(skb_checksum(skb, 0, len, skb->csum));
> +	/* If the data can't be checksummed it can't be valid either. */
> +	if (skb_checksum_full(skb, 0, len, &csum)) {
> +		if (!skb_shared(skb))
> +			skb->csum_valid = 0;
> +		return (__force __sum16)1;
> +	}
> +
> +	sum = csum_fold(csum);
>   	/* See comments in __skb_checksum_complete(). */
>   	if (likely(!sum)) {
>   		if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE) &&
> @@ -3886,10 +3894,17 @@ EXPORT_SYMBOL(__skb_checksum_complete_head);
>    */
>   __sum16 __skb_checksum_complete(struct sk_buff *skb)
>   {
> -	__wsum csum;
> +	__wsum csum = 0;
>   	__sum16 sum;
>   
> -	csum = skb_checksum(skb, 0, skb->len, 0);
> +	/* If the data can't be checksummed it can't be valid either.  Leave
> +	 * skb->csum alone, it's not a full packet checksum.
> +	 */
> +	if (skb_checksum_full(skb, 0, skb->len, &csum)) {
> +		if (!skb_shared(skb))
> +			skb->csum_valid = 0;
> +		return (__force __sum16)1;
> +	}
>   
>   	sum = csum_fold(csum_add(skb->csum, csum));
>   	/* This check is inverted, because we already knew the hardware
> 

