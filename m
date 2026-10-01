Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1649A3D6
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861472; cv=none; b=RZSQ8aYiaa2VI15mCV/ssFsVcGFfFaTmkCsk1ImyVXrgqALX0+Gd1XmRpI+XNB8pXAVbyHhh5B0eY6xFVqfSszt+NTA9TjoTmEsEfnal1ePHqen0z5LVIYqDJ4ohoIqg1P1EwvO/QV8tXjzhw+5nRiggBnSM2pz+1lpBr1tM/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861472; c=relaxed/simple;
	bh=Vi6choS33FKFjxPKipH3DUPu7N1HLZ5hjd9r6msAcCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c74oYKTi9+DmTE4xywdXWaO3Hy3VQBtXiQxEAGPMUQ90SCWcNlcD75p0zE8F3EapXXsz6bfgaelCrClOEeoZWY5jX1Ba211BZuUBOFcBXFOA6tT22nTqzYEqvnDjUivlzwR4uPdBjtKv8jNJVshrWGnx72Pl7QeyzJiGTB+jgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dtG7N4ei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3U0Su78Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mwvjDzif; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/3wvYVVf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dtG7N4ei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3U0Su78Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mwvjDzif";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/3wvYVVf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C17441FCE1;
	Thu,  1 Oct 2026 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xv41mYhh05ohbW2u6CfMOA6S2qcR8TtPnvVYNkhF7oc=;
	b=dtG7N4eiC8M+oeB0Rc0VS63iSeAdBwYGe+ICwINqVmTrP0NREBj7cb/fkMzDmsuuz4JNDQ
	I1Ggiq9txQBNvvdWB/ayzef0/CD35xNLPN/3zQgm1AYmMO3D0rTwitHdydbCLkXzyN/rqz
	jAzIKb+U8u729V28N3BycXaCvFs4tc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xv41mYhh05ohbW2u6CfMOA6S2qcR8TtPnvVYNkhF7oc=;
	b=3U0Su78QYNErhMX+qHPoGD6qgA7j9UTwXS3uHjjexO7aoPeh3lopjOh9v2JTNFcGx9EU8T
	JYaHk4nsghbOmVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xv41mYhh05ohbW2u6CfMOA6S2qcR8TtPnvVYNkhF7oc=;
	b=mwvjDzif/pWDRoRPwy9vKJRQBVYhSTB847YEsSk7BWEvSCAtkcmiyaSe3dmqq+uUWEsoIO
	UVsfDPLDOMH1gjkp2SRyTdfyWc6tGVea3B3AOQCnuyMVTQ9M128jUXnWRriwouyQtXvX+5
	zHq7beO8W5EiwGdPd6ULMH62g16bpVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xv41mYhh05ohbW2u6CfMOA6S2qcR8TtPnvVYNkhF7oc=;
	b=/3wvYVVfcYAbAJZ8o46ppKnb8PBe2XUYXAmWMC1PLm4BwtUdA0ns33QgphX3/pcdwouop8
	N0ouZV/Tq/WAX8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0F34134B3;
	Thu,  1 Oct 2026 13:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KwjZMZBgvmotMwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 01 Oct 2026 13:30:56 +0000
Message-ID: <25e03da1-d25c-4206-97c9-6d0fee4e9758@suse.de>
Date: Thu, 1 Oct 2026 15:29:54 +0200
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
Cc: dev@openvswitch.org, jesse@nicira.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, echaudro@redhat.com, aconole@redhat.com,
 syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
References: <20261001085205.3822-1-fmancera@suse.de>
 <50b0db80-7d42-44fc-81eb-d0fed8047871@ovn.org>
 <7590af05-e95a-4b34-9216-26e770bdfaaa@suse.de>
 <a9480ea8-314f-478f-ae9d-b8262600e2ad@ovn.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <a9480ea8-314f-478f-ae9d-b8262600e2ad@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.75 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.15)[-0.740];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.75
X-Spam-Level: 

On 10/1/26 2:00 PM, Ilya Maximets wrote:
> On 10/1/26 1:20 PM, Fernando Fernandez Mancera via dev wrote:
>> On 10/1/26 1:15 PM, Ilya Maximets wrote:
>>> On 10/1/26 10:52 AM, Fernando Fernandez Mancera wrote:
>>>> When executing IPv6 address rewrite actions on IPv6 fragments,
>>>> set_ipv6_addr() might attempt to recalculate the L4 header checksum
>>>> calling skb_transport_header() with an uninitialized transport header.
>>>> This can potentially lead to a OOB write.
>>>
>>> Not really.  later fragments have l4_proto set to NEXTHDR_FRAGMENT
>>> and so no writes will be performed.  See parse_ipv6hdr().
>>>
>>
>> Oh, I didn't notice that. In that case, this is harmless. I will update
>> the commit message, thanks!
>>
> 
> [...]
> 
>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>>> index dc5ff859f114..a14668565ec4 100644
>>>> --- a/net/openvswitch/actions.c
>>>> +++ b/net/openvswitch/actions.c
>>>> @@ -395,7 +395,7 @@ static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
>>>>    			  __be32 addr[4], const __be32 new_addr[4],
>>>>    			  bool recalculate_csum)
>>>>    {
>>>> -	if (recalculate_csum)
>>>> +	if (recalculate_csum && skb_transport_header_was_set(skb))
>>>>    		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
>>> I'd suggest moving the check into update_ipv6_checksum() and maybe add
>>> a small comment that the check is only to avoid warning on reading the
>>> offset that wasn't set, offset must always be set for any l4_proto for
>>> which the checksum is actually getting updated.
>>>
>>
>> Will do that. Thanks Ilya.
> Actually, it might be better to check for NEXTHDR_FRAGMENT and return
> early only in this case.  This way if we ever have the offset missing
> for any l4_ptoto that needs it, we'll still get a warning instead of
> silently not updating the checksum.  This will be close to what the
> update_ip_l4_checksum() is doing.
> 
> At the same time, update_ip_l4_checksum() is able to get the transport
> offset without a warning, so another alternative is to actually set the
> transport offset in parse_ipv6hdr() to something like frag_off, which
> would closer match the behavior of ipv4 where check_iphdr() sets the
> transport header unconditionally to the next byte after the network header.
> This is fine because transport headers are never accessed when they are
> not set in the key.  The network checksum update cases are the only ones
> where the actions are even allowed to execute and touch higher level
> headers that may not be present in the packet.  At the same time the
> frag_off is kind of an arbitrary value, so I'm not sure.
> 
> WDYT?

I noticed this but IMHO it is a worse pattern. In the sense that one 
persone in the future might use the transport header without noticing 
this and the warning won't show up because the transport header will be 
set incorrectly. This could cause an actual OOB.

I will trust your taste in this matter since I am not that familiar with 
the code.

Thanks,
Fernando.

> Eelco, Aaron, do you maybe have a preference?
> 
> Best regards, Ilya Maximets.

