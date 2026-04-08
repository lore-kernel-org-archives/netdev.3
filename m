Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4D397E65
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635556; cv=none; b=pZtsYMlLVR1XKtzbH1uZ5tPK0zCjeBSNlZRhiX0gi6g28uQuTjun3ZVya390LFvBlhGJ7awbJT77kzmk+qoglOR2f7GeioR/bnWQY18pH2sx1FWVMPLpy8oY6dJgsKhvGEaNXv99rlAcBsgK+8DVzU/1z/VZiuPutNRlY69NEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635556; c=relaxed/simple;
	bh=ZEwJOdBC3YkDsuAotd2KF3vio+CYUSTXjTOV1rbrdyc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gdsdX7UN6UaCXBOJuA1u2j5o6pRUEhvbQ/1Xgg1xmNEjCNMV61iRukhOkCQsQZktZgtnyKh7/3TfoQm4EQnIdTyzK0CVjBpRTkEg0XYUK4+yIaNS/9J/0krV+Odyfz9+hKG9chXGsbXquUg5ma6LpK7+a7UGBeC5fHTtCujte3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g0z45d4u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XWmGvymc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hnkCUcku; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E+dUNjaJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g0z45d4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XWmGvymc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hnkCUcku";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+dUNjaJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 958344E8C6;
	Wed,  8 Apr 2026 08:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775635548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzNVLVFbILaV5p0/6JDxEZrdwL8PfUQmSd8JlU/QzhE=;
	b=g0z45d4uFgXTEl9cqtmOjnvPWMsIO7vHR7jMSl9L5qWu6Vjsj2/kDXyp2cUvBlII1W1zRD
	i9S1i80N6UrwHe7Q9b1MnwF0wBP5V5YhzVQCj2/tBNoznbNOgZHP0L25ypc87/8Po7OtCk
	A226DkEzHVyWqcJs+9K5K9D/oz1trEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775635548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzNVLVFbILaV5p0/6JDxEZrdwL8PfUQmSd8JlU/QzhE=;
	b=XWmGvymcRiuZRFNIRtOHjdtzMeMom3szXBmP1c1Rj5W2kZ5cwxIhvK6suSKjWNbnWduGgJ
	Fj1JmWnZAOyClWDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hnkCUcku;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E+dUNjaJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775635543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzNVLVFbILaV5p0/6JDxEZrdwL8PfUQmSd8JlU/QzhE=;
	b=hnkCUcku1muNFjPZmkE+/9slbGymot+OMrk8m5M0X41VoQhpSza2P1xs2AGTwwMDcwy5Pf
	s2kYbwj8C97kG0KzYfjt224idWUUANUr52bqiYZoLU/ZU6UVDBuJROaM6WN4VZKMrUHHig
	K3J98q6uZia0Tb8L5/yuwW9BIURhtRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775635543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzNVLVFbILaV5p0/6JDxEZrdwL8PfUQmSd8JlU/QzhE=;
	b=E+dUNjaJQbITOEb/rP+hpKjb3WEoPb3PPCzngFX2FZnp/0Pyn4DzYDQC37MzS3oHEc7H+H
	6mAnpU2vX/1RXSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A7884A0B4;
	Wed,  8 Apr 2026 08:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jy1dA1cM1mksXAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 08 Apr 2026 08:05:43 +0000
Message-ID: <15888967-8372-4c6b-b3ec-3cb336dcebbb@suse.de>
Date: Wed, 8 Apr 2026 10:05:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision
 TLV
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: luka.gejak@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
References: <20260407162502.19462-1-luka.gejak@linux.dev>
 <20260407162502.19462-2-luka.gejak@linux.dev>
 <e29b7837-70ab-4db2-b9e5-abb59d8721d7@suse.de>
Content-Language: en-US
In-Reply-To: <e29b7837-70ab-4db2-b9e5-abb59d8721d7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[linux.dev:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[linux.dev:query timed out];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 958344E8C6
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 4/8/26 9:48 AM, Fernando Fernandez Mancera wrote:
> On 4/7/26 6:25 PM, luka.gejak@linux.dev wrote:
>> From: Luka Gejak <luka.gejak@linux.dev>
>>
>> Supervision frames are only valid if terminated with a zero-length EOT
>> TLV. The current check fails to reject non-EOT entries as the terminal
>> TLV, potentially allowing malformed supervision traffic.
>>
>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>> with a length of zero, and properly linearizing the TLV header before
>> access.
>>
>> Assisted-by: Gemini:Gemini-3.1-flash
>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
>> ---
>>   net/hsr/hsr_forward.c | 20 +++++++++-----------
>>   1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
>> index 0aca859c88cb..eb89cc44eac0 100644
>> --- a/net/hsr/hsr_forward.c
>> +++ b/net/hsr/hsr_forward.c
>> @@ -82,35 +82,33 @@ static bool is_supervision_frame(struct hsr_priv 
>> *hsr, struct sk_buff *skb)
>>           hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct 
>> hsr_sup_payload))
>>           return false;
>> -    /* Get next tlv */
>> +    /* Get next TLV */
>>       total_length += hsr_sup_tag->tlv.HSR_TLV_length;
>> -    if (!pskb_may_pull(skb, total_length))
>> +    if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>>           return false;
>>       skb_pull(skb, total_length);
>>       hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>>       skb_push(skb, total_length);
>> -    /* if this is a redbox supervision frame we need to verify
>> -     * that more data is available
>> -     */
>> +    /* If this is a RedBox supervision frame, verify additional data */
>>       if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
>> -        /* tlv length must be a length of a mac address */
>> +        /* TLV length must be the size of a MAC address */
>>           if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct 
>> hsr_sup_payload))
>>               return false;
>> -        /* make sure another tlv follows */
>> +        /* Make sure another TLV follows */
>>           total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv- 
>> >HSR_TLV_length;
>> -        if (!pskb_may_pull(skb, total_length))
>> +        if (!pskb_may_pull(skb, total_length + sizeof(struct 
>> hsr_sup_tlv)))
> 
> Hi Luka,
> 
> why is the length adjusted here? The current total length was adjusted 
> correctly above see:
> 

Never mind, it makes sense as the total_length must point to the 
beginning of the next TLV.

LGTM,

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks,
Fernando.

>>               return false;
>> -        /* get next tlv */
>> +        /* Get next TLV */
>>           skb_pull(skb, total_length);
>>           hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>>           skb_push(skb, total_length);
>>       }
>> -    /* end of tlvs must follow at the end */
>> -    if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
>> +    /* Supervision frame must end with EOT TLV */
>> +    if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
>>           hsr_sup_tlv->HSR_TLV_length != 0)
>>           return false;
> 

