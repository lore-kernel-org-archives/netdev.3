Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30EE495518
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455623; cv=none; b=c42xTHFlFKcWYp3U7ac3pJSdJiNySdMyTku9QdRezvCtSjaQw48qeU7g2NpYbMEmSoU1gUtYMOAELJ5Z2WcrStxBiOfAfDcd5MTlHxZFKLEGDY8ScO6pP1VRmESQGCakDWjTaly8LAEFH9SeWP7l7HaUViL0a3l/CpatItNGFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455623; c=relaxed/simple;
	bh=oJ/g5S+5NVpp4+LxjRyoHKcanSlxMDhxF5hAF1oo6tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ty/qbblkt3PPehuVc5SLPOtrAfzt+82SydX06arQSER/83I06d9H19qvX7qMZK7HPH6OUXlf9vhpmEAbj2V4VpocQwVM9HK8Ua/DUeKOio3vOF/1BMKxsySEoJmCvnoVW1ZZQqY5BhAWsftRodq4ZIVEFSgG0b5465vXdnPT/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eVDOEfIo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TM+ArYeU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eBAbjeWT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O+v14yHC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eVDOEfIo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TM+ArYeU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eBAbjeWT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O+v14yHC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0AC821B9C;
	Thu,  8 Oct 2026 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791455620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98n4jv4PWKbCZPud96jVESqxNw6klclW7TFmtEAGJro=;
	b=eVDOEfIolBi8JkUFe8fzKwYhhrhugi5Ua+iN9jucLk9uYtffBeFoMpuaryWRq13yvsXVcM
	BHW+QFhXnWPiX7LydGwUqkNAhyyOCzeGqyEePeDzLgFoxdWQTC4PxdcfskvCX1raeJ6s/1
	gkN0YMMHE2bF3MrWoncRr4YQAwANqgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791455620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98n4jv4PWKbCZPud96jVESqxNw6klclW7TFmtEAGJro=;
	b=TM+ArYeUxgMCSdvocLcC6/+8AeUy40RJ73OYYV2lAUBoX4VU60SRgH4wBZva6OFtrbf6ap
	Jyw68jsYSJjnUMDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eBAbjeWT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O+v14yHC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791455619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98n4jv4PWKbCZPud96jVESqxNw6klclW7TFmtEAGJro=;
	b=eBAbjeWT09Rys/EaKEqxS0DxqcxfLQ5zfYrCfGqMkKZTtMXrZCiqfvsHBbE9NJXe/0KGFv
	pc4A9keE2S0SwglydZ3/O6Y/PELiPjjKwC2m7bKs7yjrktiiv/r0jx6fmiOU+D4dx4C8vN
	ESongc5RMQONYtMMGi3DB/cJZgJ3es8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791455619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98n4jv4PWKbCZPud96jVESqxNw6klclW7TFmtEAGJro=;
	b=O+v14yHC909gRTLmkJK0TER3PQqplKauEITkLSeuxukz8a8spR4C4H7UiVeJlcyFyT5kky
	TeO8gvV5s3OraCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE5FE1339F;
	Thu,  8 Oct 2026 10:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jBaVH4Jxx2oZRgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 08 Oct 2026 10:33:38 +0000
Message-ID: <18e9b3ba-bc48-4c07-80ed-2ddc5ed90083@suse.de>
Date: Thu, 8 Oct 2026 12:33:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: openvswitch: validate transport header
 presence in set_ipv6_addr
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, aatteka@nicira.com, jesse@nicira.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, echaudro@redhat.com, aconole@redhat.com,
 syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
References: <20261002075255.5015-1-fmancera@suse.de>
 <9c27ef7a-1af0-403e-9fb6-757c3555d051@ovn.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <9c27ef7a-1af0-403e-9fb6-757c3555d051@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
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
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action
X-Spam-Score: -3.00
X-Spam-Level: 
X-Rspamd-Queue-Id: D0AC821B9C

On 10/7/26 10:53 PM, Ilya Maximets wrote:
> On 10/2/26 9:52 AM, Fernando Fernandez Mancera wrote:
>> When executing IPv6 address rewrite actions on IPv6 fragments,
>> set_ipv6_addr() calls update_ipv6_checksum(). If parse_ipv6hdr()
>> processes a non-first IPv6 fragment, it sets key->ip.proto to
>> NEXTHDR_FRAGMENT and returns early without calling
>> skb_set_transport_header().
>>
>> update_ipv6_checksum() unconditionally evaluates skb_transport_offset()
>> on entry before checking l4_proto.  Because skb->transport_header is
>> uninitialized, this triggers a warning under CONFIG_DEBUG_NET=y although
>> it is completely harmless.
>>
>> Fix this by returning early in update_ipv6_checksum() if l4_proto is
>> NEXTHDR_FRAGMENT. This avoids reading the uninitialized transport offset
>> for fragments while preserving the debug warning for any other protocol
>> where the transport header is unexpectedly missing.
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
>>   net/openvswitch/actions.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index dc5ff859f114..68b42e900c73 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -358,7 +358,15 @@ static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
>>   static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
>>   				 __be32 addr[4], const __be32 new_addr[4])
>>   {
>> -	int transport_len = skb->len - skb_transport_offset(skb);
>> +	int transport_len;
>> +
>> +	/* avoid reading the transport header offset if it isn't set,
>> +	 * as it triggers a warning
>> +	 */
> 
> nit: We prefer full sentences, i.e. start with a capital and end with a dot.
> 
> But also, I think, since the switch to NEXTHDR_FRAGMENT check, the comment
> lost it's intended purpose as the code is pretty much self-documenting now.
> It's clear that the fragment doesn't have the transport header.  The comment
> made sense if we needed to explain in which case we can get here without
> having the offset initialized.  I'd suggest we drop the comment.
> 
> You're also not adding such comments in the other patch for ipv4.
> 

Fair, I thought that in IPv4 case it was more obvious than here. Anyway, 
let me just drop it in a v3. Thanks a lot for the reviews :-)

> Otherwise, LGTM.
> 
>> +	if (l4_proto == NEXTHDR_FRAGMENT)
>> +		return;
>> +
>> +	transport_len = skb->len - skb_transport_offset(skb);
>>   
>>   	if (l4_proto == NEXTHDR_TCP) {
>>   		if (likely(transport_len >= sizeof(struct tcphdr)))
> 
> Best regards, Ilya Maximets.
> 

