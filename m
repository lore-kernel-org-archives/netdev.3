Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622198;
	b=4tG946H0KEPMmeYaxCshMZDeIfcS2Qc/aH9ZvM+OHJp6RpUY6lywbms3GbTDE4vGZeM1
	 buazK4uXTZML/Z+QjiKgFklFslsCPZVV+bkWmq4dQGQ5sgIjqYDxuJa0Z+dbMXnZUzwCg
	 nQ2cy3qij1q0Zga+5FnSP43RoYZz+9bwJ8zSdsDD+T9X4xS0DyB+FXP/nv9hFMSAoE0/c
	 f34o9+eTE92iFQr3oiRrSvV0ekv35FL7Nb1duKTL+TPNzqOdl0w7dveAFwwXyTXdydRNp
	 tSBvbBv+QUmCFZAUTKbg12imzIELLlrFjp4TXdTVd/UvWKCQTOLY5mWgBW1GVeHO9RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622198;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=iNzlXZ25cjHC8Y6LWtQ26Wk3I5gdPM3oyHxlgoDmVo4=;
	b=EoGSjTAeGylZGvOGedqtSXC4HU2JxhAbcY7cxiTquRnAD9kZo6SaRrRTq0VYkjOzz/dT
	 6ZPlMfIvDQvx0SLagb66JUq/AT7hXKWu2PoxVWDzuzhCteopRKhodx1rMBTR2xtnN1acG
	 6oCqQYF46S6GdvlItgI8yFxKT6s7J0hfVsg2qEvuwHWe/scqz4EtxrB9d3kLWBjTnRlmk
	 2Qf/hwU4vsOQoF8Z+BKDzLoS/Ck3FXpNY80jJskbNdY4Iqve51Z1/4Zn4ViFbHpe+vs2D
	 L/E4vZ9jl31M7SL/fdt0jsdFZ1fB3wwZZY6M+OuyZ81x8++x/uqUmt/ZXVqs7AZ4vTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KsF2WCld;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hXhw2CRu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KsF2WCld;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hXhw2CRu;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E93606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E93606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KsF2WCld;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hXhw2CRu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KsF2WCld;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hXhw2CRu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FBE521F3C;
	Wed, 21 Oct 2026 22:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792622196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNzlXZ25cjHC8Y6LWtQ26Wk3I5gdPM3oyHxlgoDmVo4=;
	b=KsF2WCldQNsuqC3NqvKuKXOASQ1UngC5UEwN/QlKYkxKFaBdVR7LdQsZt8CKeBVK9xF4Zh
	tDxxsILXIxgE71dLzK5DJ8e444Oz6MXxFq91tZgFaq4ScaPo2st/+I/yTzlGEP/yS6wg9Y
	qmz2j0MRT88601TQpXVfnX+KJvmW3GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792622196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNzlXZ25cjHC8Y6LWtQ26Wk3I5gdPM3oyHxlgoDmVo4=;
	b=hXhw2CRuRRlRiG/T2l96Afr3T/8uJ+502OxDXlU4OnlPyazJLFenNVjawZo47rG0VPSY5N
	clk79m+E4JxVusDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792622196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNzlXZ25cjHC8Y6LWtQ26Wk3I5gdPM3oyHxlgoDmVo4=;
	b=KsF2WCldQNsuqC3NqvKuKXOASQ1UngC5UEwN/QlKYkxKFaBdVR7LdQsZt8CKeBVK9xF4Zh
	tDxxsILXIxgE71dLzK5DJ8e444Oz6MXxFq91tZgFaq4ScaPo2st/+I/yTzlGEP/yS6wg9Y
	qmz2j0MRT88601TQpXVfnX+KJvmW3GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792622196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNzlXZ25cjHC8Y6LWtQ26Wk3I5gdPM3oyHxlgoDmVo4=;
	b=hXhw2CRuRRlRiG/T2l96Afr3T/8uJ+502OxDXlU4OnlPyazJLFenNVjawZo47rG0VPSY5N
	clk79m+E4JxVusDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 273B5134FD;
	Wed, 21 Oct 2026 22:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BuZaOnI+2WpvSgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 21 Oct 2026 22:36:35 +0000
Message-ID: <c8cfc286-df64-49dc-b386-2e89ecc701b2@suse.de>
Date: Thu, 22 Oct 2026 00:36:26 +0200
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
Subject: Re: [PATCH net-next v2 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
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
 <20261021-b4-skbuff-bug-on-followups-v2-4-2aa780a03524@toxicpanda.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-4-2aa780a03524@toxicpanda.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,gmail.com,google.com,vger.kernel.org,lists.xenproject.org];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email]
X-Spam-Score: -11.79
X-Spam-Level: 
X-Spam-Flag: NO

On 10/21/26 3:46 PM, Josef Bacik wrote:
> When the device can't checksum the protocol, skb_segment() computes
> each segment's checksum in software with skb_checksum().  With SG on,
> the segments share the original frags, and a devmem TCP skb keeps its
> whole payload in unreadable frags.  The devmem MSG_ZEROCOPY path never
> sets SKBFL_SHARED_FRAG, so the __skb_linearize() fallback is skipped
> too.  skb_checksum() then warns and returns 0, and tcp_gso_segment()
> writes a TCP checksum that doesn't cover the payload that goes out.
> 
> That's reachable with tx-checksumming off and SG on: sk_setup_caps()
> still gives TCP SG and HW_CSUM, so the dmabuf send is accepted, and
> harmonize_features() strips the checksum features but keeps SG.
> 
> Use skb_checksum_full() and fail the segmentation with -EFAULT when it
> can't checksum a segment, as skb_segment() already does when it can't
> copy one.
> 
> Found by the Sashiko AI review of an earlier fix for the same path with
> SG off.
> 
> Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

>   net/core/skbuff.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 40d2dd20d47d..88ed2dd99dc0 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5239,9 +5239,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   
>   			if (!nskb->remcsum_offload)
>   				nskb->ip_summed = CHECKSUM_NONE;
> -			SKB_GSO_CB(nskb)->csum =
> -				skb_checksum(nskb, doffset,
> -					     nskb->len - doffset, 0);
> +			SKB_GSO_CB(nskb)->csum = 0;
> +			if (skb_checksum_full(nskb, doffset,
> +					      nskb->len - doffset,
> +					      &SKB_GSO_CB(nskb)->csum)) {
> +				err = -EFAULT;
> +				goto err;
> +			}
>   			SKB_GSO_CB(nskb)->csum_start =
>   				skb_headroom(nskb) + doffset;
>   		}
> 

