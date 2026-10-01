Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E716456E1A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853688; cv=none; b=ahIeTlQNF643Wjn6oNKQ2i8D98Mtm91uIltIHLawEGeFwwXSRYHBXy7UTCVRZIAn8fr21SDkX+0krx6v4fRVyZ472iOylywW74Q7G0iPUQq+FKjIrDxiJ847PNseokbTrkk3yC+9f/WuL6XNGBD3xFt+zJfVlwq6SSmGPC59cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853688; c=relaxed/simple;
	bh=s6qjTFEubSr63tRyRx0APXgzm1DtFSjKYijFuzPYxu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQzX55q+iv81yX6wzDRsrI5BDOrqQpgYbIfn1cMBBmnLnMqNQUHoTyTe+YzYCbjdUMvhWc1SyIEatImHY9OpjUtlkrOaTIizDSG+WLvwAu4JJY2/QrIfuRV22bFaMuJMcIXTlvflOoe0qjcjPyC04qAq8FTkQCKMIka3s0Kldzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QYu1X21Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sA3gNi1O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ex2/FVF/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H0NRR5K9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QYu1X21Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sA3gNi1O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ex2/FVF/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H0NRR5K9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AC4E21B9B;
	Thu,  1 Oct 2026 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790853680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4jmVU1Km43eA2l66XPSDHdcTiO1Y39M7KTdgbHzRPk=;
	b=QYu1X21Y/9TyIsoVGBpPxPbmvcyGZU1TPiw24sXMOl5TvWEYi2xq9wPViD9+cXU8yNJVu7
	6EzfCgINy8oh1F4tMJ/D0g9ZB/KpaVFMLB5tS4kKzkFJz2XQBSOKjGQ40ej4WTHMjI16+d
	kxy/9bQxHbEoVAGu+rsglCo7QLPLA98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790853680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4jmVU1Km43eA2l66XPSDHdcTiO1Y39M7KTdgbHzRPk=;
	b=sA3gNi1OKfB50HqKViOdWkUadl/zuYyVC5Aysyumin2bFo0oDh+jiysHJ012kOqkulSONj
	3qUSoOQI8eoPJBBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790853676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4jmVU1Km43eA2l66XPSDHdcTiO1Y39M7KTdgbHzRPk=;
	b=ex2/FVF/Yt0RnbZqF6oj0MSmezYJuZeVp0OOJI1F2YtU0A58/IjVO0347wccaxt1piFMHC
	vCYKwysP0vMqQqmnYmmOntaGLvY7rIz9WaYQG5YpvrGgjGJtowzRNkJwemQRK8N65sfDEj
	phpTMP2W/V54HahGNV5h+GG6kJZi6wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790853676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4jmVU1Km43eA2l66XPSDHdcTiO1Y39M7KTdgbHzRPk=;
	b=H0NRR5K9MNrJ8qxnKHI0Vp3tnPBeQURJnc2jmHJ74tuarTeJAUDYBwd/45JlKQYfek25RT
	jJUAkJIkHslmWKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B44134B3;
	Thu,  1 Oct 2026 11:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3MivFCtCvmqoJAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 01 Oct 2026 11:21:15 +0000
Message-ID: <7590af05-e95a-4b34-9216-26e770bdfaaa@suse.de>
Date: Thu, 1 Oct 2026 13:20:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: openvswitch: validate transport header presence
 in set_ipv6_addr
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, aatteka@nicira.com, jesse@nicira.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, echaudro@redhat.com, aconole@redhat.com,
 syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
References: <20261001085205.3822-1-fmancera@suse.de>
 <50b0db80-7d42-44fc-81eb-d0fed8047871@ovn.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <50b0db80-7d42-44fc-81eb-d0fed8047871@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On 10/1/26 1:15 PM, Ilya Maximets wrote:
> On 10/1/26 10:52 AM, Fernando Fernandez Mancera wrote:
>> When executing IPv6 address rewrite actions on IPv6 fragments,
>> set_ipv6_addr() might attempt to recalculate the L4 header checksum
>> calling skb_transport_header() with an uninitialized transport header.
>> This can potentially lead to a OOB write.
> 
> Not really.  later fragments have l4_proto set to NEXTHDR_FRAGMENT
> and so no writes will be performed.  See parse_ipv6hdr().
> 

Oh, I didn't notice that. In that case, this is harmless. I will update 
the commit message, thanks!

>> A warning is triggered with DEBUG_NET=y.
> 
> Yeah, while the value is not actually used to access the packet data,
> the skbuff core generates a warning on read.
> 
>>
>> Fix this by recalculating the checksum only if there is a valid
>> transport header in the skb. Otherwise, assume this is a fragment and
>> skip it.
>>
>> See the syzbot trace:
>>
>> !skb_transport_header_was_set(skb)
>> WARNING: ./include/linux/skbuff.h:3075 at skb_transport_header include/linux/skbuff.h:3075 [inline], CPU#1: syz-executor463/5635
>> WARNING: ./include/linux/skbuff.h:3075 at skb_transport_offset include/linux/skbuff.h:3250 [inline], CPU#1: syz-executor463/5635
>> WARNING: ./include/linux/skbuff.h:3075 at update_ipv6_checksum net/openvswitch/actions.c:361 [inline], CPU#1: syz-executor463/5635
>> WARNING: ./include/linux/skbuff.h:3075 at set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399, CPU#1: syz-executor463/5635
>> [...]
>> RIP: 0010:skb_transport_header include/linux/skbuff.h:3075 [inline]
>> RIP: 0010:skb_transport_offset include/linux/skbuff.h:3250 [inline]
>> RIP: 0010:update_ipv6_checksum net/openvswitch/actions.c:361 [inline]
>> RIP: 0010:set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399
>> [...]
>> Call Trace:
>>   <TASK>
>>   set_ipv6 net/openvswitch/actions.c:531 [inline]
>>   do_execute_actions+0x557e/0x8600 net/openvswitch/actions.c:1366
>>   ovs_execute_actions+0xde/0x520 net/openvswitch/actions.c:1592
>>   ovs_packet_cmd_execute+0xb4f/0xf10 net/openvswitch/datapath.c:705
>>   genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
>>   genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
>>   netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
>>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>>   netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
>>   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
>>   sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
>>
>> Reported-by: syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=4cc63fcfb3845e149969
>> Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/openvswitch/actions.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index dc5ff859f114..a14668565ec4 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -395,7 +395,7 @@ static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
>>   			  __be32 addr[4], const __be32 new_addr[4],
>>   			  bool recalculate_csum)
>>   {
>> -	if (recalculate_csum)
>> +	if (recalculate_csum && skb_transport_header_was_set(skb))
>>   		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
> I'd suggest moving the check into update_ipv6_checksum() and maybe add
> a small comment that the check is only to avoid warning on reading the
> offset that wasn't set, offset must always be set for any l4_proto for
> which the checksum is actually getting updated.
> 

Will do that. Thanks Ilya.

> Best regards, Ilya Maximets.

