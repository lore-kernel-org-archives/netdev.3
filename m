Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF15244685
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054828; cv=none; b=M7lkkQqyJUuboe3SByTaRk66DJKCoDoGagJCv/1xh/7kyRmZP1/9V7wCH0/CuhbdlUWK6lYeIaW6uHqE4EC7aauujpkf7ki8+tFRbfGtneCR8uQOIZck4I5G2pxmjVLwMN6G5n2Yd3fORUO03YvpwVJ1bET9rnNuE3cFQkKO2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054828; c=relaxed/simple;
	bh=xJ+CqyPpDr4RnKGIVXZY0Ht+UeYZcW48kLAFNsToGGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCVgKPLpPb+XpIUxZWx8R7ah7gZ2Nz487POyMRgDBq15pWB+9yc7zPbH5GzJyiFNJqEV6k1ArlOJ5uI9eQXFA0R6r1inlphDXjVccONtXm7oBf09pq5HFCTY0ChbDgZIbg1c5IO8vB+EWekjyDM0VYqJRC3Be/baLPJYHWv89Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKlfMgZ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hSQCAb3m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKlfMgZ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hSQCAb3m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKlfMgZ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hSQCAb3m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKlfMgZ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hSQCAb3m"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E2B34D1E1;
	Wed,  1 Apr 2026 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775054825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXvZg1FyR/cH6YcJsLt+q7RXOcXCtioeZOpkJEW3wNY=;
	b=KKlfMgZ2QUosLFfb9O/n9T4rZwSEcEtT6j5CzVqtB0Utl+W4R7yvhsWrbFE33JufwQ8NUH
	yF38IQwQeIBmDReSTdZZ9HkxHKGbR8hXxxSY97tZjQbu5aFlQJl1XyhwxDbYVXk0bvAioR
	HGJDZpqkITyikBGMxanalI4xWntdEAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775054825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXvZg1FyR/cH6YcJsLt+q7RXOcXCtioeZOpkJEW3wNY=;
	b=hSQCAb3mOIM0FtUm5O3nQoChrnPPKDWK9XPOJAOtUNferxmKt3Wn0UI/Wwjfv9tWZ1yU9+
	tgmO7TTwIqXMA1AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KKlfMgZ2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hSQCAb3m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775054825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXvZg1FyR/cH6YcJsLt+q7RXOcXCtioeZOpkJEW3wNY=;
	b=KKlfMgZ2QUosLFfb9O/n9T4rZwSEcEtT6j5CzVqtB0Utl+W4R7yvhsWrbFE33JufwQ8NUH
	yF38IQwQeIBmDReSTdZZ9HkxHKGbR8hXxxSY97tZjQbu5aFlQJl1XyhwxDbYVXk0bvAioR
	HGJDZpqkITyikBGMxanalI4xWntdEAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775054825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXvZg1FyR/cH6YcJsLt+q7RXOcXCtioeZOpkJEW3wNY=;
	b=hSQCAb3mOIM0FtUm5O3nQoChrnPPKDWK9XPOJAOtUNferxmKt3Wn0UI/Wwjfv9tWZ1yU9+
	tgmO7TTwIqXMA1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0D754A0B0;
	Wed,  1 Apr 2026 14:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UgP+M+gvzWl/GAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 14:47:04 +0000
Message-ID: <2d94a1a6-e6c5-427c-b10f-63377cb10407@suse.de>
Date: Wed, 1 Apr 2026 16:47:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
To: luka.gejak@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260401092324.52266-2-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5E2B34D1E1
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero.
> 
> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>   net/hsr/hsr_forward.c | 41 ++++++++++++++++++++++-------------------
>   1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0aca859c88cb..17b705235c4a 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -82,39 +82,42 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>   	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
>   		return false;
>   
> -	/* Get next tlv */
> +	/* Advance past the first TLV payload to reach next TLV header */
>   	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
> -	if (!pskb_may_pull(skb, total_length))
> +	/* Linearize next TLV header before access */
> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>   		return false;
>   	skb_pull(skb, total_length);
>   	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>   	skb_push(skb, total_length);
>   
> -	/* if this is a redbox supervision frame we need to verify
> -	 * that more data is available
> +	/* Walk through TLVs to find end-of-TLV marker, skipping any unknown
> +	 * extension TLVs to maintain forward compatibility.
>   	 */
> -	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> -		/* tlv length must be a length of a mac address */
> -		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
> -			return false;
> +	for (;;) {
> +		if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
> +		    hsr_sup_tlv->HSR_TLV_length == 0)
> +			return true;
>   

I do not follow this approach, why a loop? From IEC 62439-3, I do not 
understand that supervision frames could have multiple 
PRP_TLV_REDBOX_MAC TLVs. The current code handles the TLVs correctly.

Which makes me wonder, how are you testing this? Do you have some 
hardware with HSR/PRP support that is sending these frames? If so, which 
one? Are you testing this using a HSR/PRP environment with purely Linux 
devices?

Thanks,
Fernando.

> -		/* make sure another tlv follows */
> -		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
> -		if (!pskb_may_pull(skb, total_length))
> +		/* Validate known TLV types */
> +		if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> +			if (hsr_sup_tlv->HSR_TLV_length !=
> +			    sizeof(struct hsr_sup_payload))
> +				return false;
> +		}
> +
> +		/* Advance past current TLV: header + payload */
> +		total_length += sizeof(struct hsr_sup_tlv) +
> +				hsr_sup_tlv->HSR_TLV_length;
> +		/* Linearize next TLV header before access */
> +		if (!pskb_may_pull(skb,
> +				   total_length + sizeof(struct hsr_sup_tlv)))
>   			return false;
>   
> -		/* get next tlv */
>   		skb_pull(skb, total_length);
>   		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>   		skb_push(skb, total_length);
>   	}
