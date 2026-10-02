Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36770408026
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790922970; cv=none; b=pg+TV2EOK9MXnjX7CbzEHYWRmYKWlXimZZIMljZorLCeVav2boT/z9/lt64NMJgu3admGJ4KahEe8kiJX8oYVXtL7TFT+3Tf77J0e3h4Sy/VUMWlHBj1OzXVn60noHlcHWtRbEEWfrLrElSfQs7ZZPcZOoBTlRXUCf793mNiqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790922970; c=relaxed/simple;
	bh=5F5hhOivMCy5muv9AU0zy1sYFS48yMF+CCjicodz2i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxaaECQ4BBpRVKAjvsiNV3/Ay7MRBWu0IZBwNfdJpdoo8cbFa+/nZt6MQEf9eZBkqL3Co/pHTCA/woYGlrU1TPHcmp3lFcBJYL4jOD8K4C/smX6tjhwcTPKfXnFctSJ/A7skRP6RMVZe19h5VXrqYZTVvFXFiegeLXvD9rIdAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XJfQseez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a2pUHVmC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JSP1CHiP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DBRZT6Kq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XJfQseez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a2pUHVmC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JSP1CHiP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DBRZT6Kq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DB661FE49;
	Fri,  2 Oct 2026 06:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790922962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uN7fBX8MkQ1Pf8LNatrxfAhvfomqDYU0DiWqn+s7Jik=;
	b=XJfQseezvPuGlh0uPii2wgh4kEB1e0mKmCmSju3h0YDoMm3TYK1/8ym+86NwcJz0DMGj5O
	S5ZIYcfbE0FvxxK6/RmC6pkx5V1fL8j3cI13U9vDbZQqJV+Zs9q89jZYnrXc9U9LF/u9Kk
	OVP2CS4UJsca4wlbexsehOcM4OTpVes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790922962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uN7fBX8MkQ1Pf8LNatrxfAhvfomqDYU0DiWqn+s7Jik=;
	b=a2pUHVmCNbXjNUdHgczAaNR+in56+NMdhH7+ZmhcdFhoqTOhnyGpQOkr2MkgxdrdXcQzHr
	3BodREMr7g89eTCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JSP1CHiP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DBRZT6Kq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790922958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uN7fBX8MkQ1Pf8LNatrxfAhvfomqDYU0DiWqn+s7Jik=;
	b=JSP1CHiPbCWHR6Y3FlG7sG7HgFz5konXukjSqK9IOR3oU2stvOoVtVvPuESJxH+nqQYsP6
	vhSEDvIAlQZFsS6L+tvqo4kLgq5JQy1YeJ+IYUJIq4+f75kYd/VW1y5k4j2FKzowyDmBqA
	1VviWDZoyfhUeNE3qzpTsiQUlvSftN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790922958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uN7fBX8MkQ1Pf8LNatrxfAhvfomqDYU0DiWqn+s7Jik=;
	b=DBRZT6KqkEqRizmbcqt/IHKaSUe3gCix77csYR7tJNWePSkIK8YRHjml8XFV7QUn+TyTNi
	6GN2KIS9yzOdwQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC31213688;
	Fri,  2 Oct 2026 06:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gz2qIM1Qv2pBRwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 02 Oct 2026 06:35:57 +0000
Message-ID: <bd0810d4-4e7c-4c40-8ae8-89a3f531356b@suse.de>
Date: Fri, 2 Oct 2026 08:34:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: validate transport header
 presence in set_ipv6_addr
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 echaudro@redhat.com, aconole@redhat.com,
 syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
References: <20261001085205.3822-1-fmancera@suse.de>
 <50b0db80-7d42-44fc-81eb-d0fed8047871@ovn.org>
 <7590af05-e95a-4b34-9216-26e770bdfaaa@suse.de>
 <a9480ea8-314f-478f-ae9d-b8262600e2ad@ovn.org>
 <25e03da1-d25c-4206-97c9-6d0fee4e9758@suse.de>
 <59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8DB661FE49
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 10/2/26 12:10 AM, Ilya Maximets wrote:
> On 10/1/26 3:29 PM, Fernando Fernandez Mancera wrote:
>> On 10/1/26 2:00 PM, Ilya Maximets wrote:
>>> On 10/1/26 1:20 PM, Fernando Fernandez Mancera via dev wrote:
>>>> On 10/1/26 1:15 PM, Ilya Maximets wrote:
>>>>> On 10/1/26 10:52 AM, Fernando Fernandez Mancera wrote:
>>>>>> When executing IPv6 address rewrite actions on IPv6 fragments,
>>>>>> set_ipv6_addr() might attempt to recalculate the L4 header checksum
>>>>>> calling skb_transport_header() with an uninitialized transport header.
>>>>>> This can potentially lead to a OOB write.
>>>>>
>>>>> Not really.  later fragments have l4_proto set to NEXTHDR_FRAGMENT
>>>>> and so no writes will be performed.  See parse_ipv6hdr().
>>>>>
>>>>
>>>> Oh, I didn't notice that. In that case, this is harmless. I will update
>>>> the commit message, thanks!
>>>>
>>>
>>> [...]
>>>
>>>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>>>>> index dc5ff859f114..a14668565ec4 100644
>>>>>> --- a/net/openvswitch/actions.c
>>>>>> +++ b/net/openvswitch/actions.c
>>>>>> @@ -395,7 +395,7 @@ static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
>>>>>>     			  __be32 addr[4], const __be32 new_addr[4],
>>>>>>     			  bool recalculate_csum)
>>>>>>     {
>>>>>> -	if (recalculate_csum)
>>>>>> +	if (recalculate_csum && skb_transport_header_was_set(skb))
>>>>>>     		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
>>>>> I'd suggest moving the check into update_ipv6_checksum() and maybe add
>>>>> a small comment that the check is only to avoid warning on reading the
>>>>> offset that wasn't set, offset must always be set for any l4_proto for
>>>>> which the checksum is actually getting updated.
>>>>>
>>>>
>>>> Will do that. Thanks Ilya.
>>> Actually, it might be better to check for NEXTHDR_FRAGMENT and return
>>> early only in this case.  This way if we ever have the offset missing
>>> for any l4_ptoto that needs it, we'll still get a warning instead of
>>> silently not updating the checksum.  This will be close to what the
>>> update_ip_l4_checksum() is doing.
>>>
>>> At the same time, update_ip_l4_checksum() is able to get the transport
>>> offset without a warning, so another alternative is to actually set the
>>> transport offset in parse_ipv6hdr() to something like frag_off, which
>>> would closer match the behavior of ipv4 where check_iphdr() sets the
>>> transport header unconditionally to the next byte after the network header.
>>> This is fine because transport headers are never accessed when they are
>>> not set in the key.  The network checksum update cases are the only ones
>>> where the actions are even allowed to execute and touch higher level
>>> headers that may not be present in the packet.  At the same time the
>>> frag_off is kind of an arbitrary value, so I'm not sure.
>>>
>>> WDYT?
>>
>> I noticed this but IMHO it is a worse pattern. In the sense that one
>> persone in the future might use the transport header without noticing
>> this and the warning won't show up because the transport header will be
>> set incorrectly. This could cause an actual OOB.
> 
> Yeah, that's true.  It's better to keep the transport header unset if
> there is actually no transport header.  We may also adjust the ipv4 path
> to avoid having it set for later fragments, but that's unrelated for the
> issue at hand.
> 

I do not mind giving a try to that in net-next. Good, so I will send the 
v2 with the proper check and commit message.

Thanks,
Fernando.

>> I will trust your taste in this matter since I am not that familiar with
>> the code.
> 
> Let's just go with the check inside update_ipv6_checksum() before reading
> the value.  Seems like the best option.
> 
> Best regards, Ilya Maximets.
> 
>>
>> Thanks,
>> Fernando.
>>
>>> Eelco, Aaron, do you maybe have a preference?
>>>
>>> Best regards, Ilya Maximets.
>>
> 

