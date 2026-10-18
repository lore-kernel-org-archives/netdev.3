Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3783BFAF2
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343770; cv=none; b=khzu5qv529LYX+LZzzXvBWW12nsjtUgGMNakpdWVejL5FgXX6E61KxUM1Y60J/gOuCOq/RnLE1vg3EoUO46sfhO0pzvUSXIQkvHDmwiomTfVGjglV0t1zWEf30gJNhtaamPUpEWDsPcKUUr1J8EvYB2fVfH/2ScrJGgDQbmTTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343770; c=relaxed/simple;
	bh=x5j9+3f6xhQOmLmyVzbF15CdSybDS0ae819+/n5IFLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWGd4tl/KKaOP4GClRKv+TUwlDAfPIE5ZqOOGKx0j2IxCEUJqzX/RfIeG/Wgj+VHHBgi9S7atHPx/fEqu+PskQU0IJJoZSHGJh6dZgRXt2LNZCu8rkXLXoYff3pxhBclHP116Pja5F/VLiO5XHYEXFzmSp+CswgVlm7INI0g/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XGYaMLel; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K8KXcIHw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XGYaMLel; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K8KXcIHw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XGYaMLel";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K8KXcIHw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XGYaMLel";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K8KXcIHw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 193DE1F38C;
	Sun, 18 Oct 2026 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792343765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xq02Yl4o8b6xg6rkq03WSDKkgltJXcI7ZOWAOTderA=;
	b=XGYaMLelxdWxp5Ypg3f1nWQd2LChf7c/fbCG9FlSoHG/eQVT/vVIXEKMY5t5aY3zrQu+vN
	Lt9z5Euyn1V1l1itAyJ/kSU1xQMMOD07QQ99+th5zvX5VlIqLAlyQwDC65JVIQ66h725AN
	mKF/0P4St0QYk7Fw6m1WmpjGo9Fgm0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792343765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xq02Yl4o8b6xg6rkq03WSDKkgltJXcI7ZOWAOTderA=;
	b=K8KXcIHwG1jrPyQ1Lt1Iz32DJSEl9jVXXlyWBqNOjSzWSUiyA9B31oIxX3RlFekjG+gqHg
	i5xYVuUmu4oxquCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XGYaMLel;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K8KXcIHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792343765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xq02Yl4o8b6xg6rkq03WSDKkgltJXcI7ZOWAOTderA=;
	b=XGYaMLelxdWxp5Ypg3f1nWQd2LChf7c/fbCG9FlSoHG/eQVT/vVIXEKMY5t5aY3zrQu+vN
	Lt9z5Euyn1V1l1itAyJ/kSU1xQMMOD07QQ99+th5zvX5VlIqLAlyQwDC65JVIQ66h725AN
	mKF/0P4St0QYk7Fw6m1WmpjGo9Fgm0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792343765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xq02Yl4o8b6xg6rkq03WSDKkgltJXcI7ZOWAOTderA=;
	b=K8KXcIHwG1jrPyQ1Lt1Iz32DJSEl9jVXXlyWBqNOjSzWSUiyA9B31oIxX3RlFekjG+gqHg
	i5xYVuUmu4oxquCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34872134B3;
	Sun, 18 Oct 2026 17:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WbqAAdT+1GqkTwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 18 Oct 2026 17:16:04 +0000
Message-ID: <7171b266-fbc7-478d-ba73-754be3b6b32c@suse.de>
Date: Sun, 18 Oct 2026 19:15:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] net: openvswitch: drop IP fragments on SCTP
 set action
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, jesse@nicira.com,
 aatteka@nicira.com, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, i.maximets@ovn.org,
 echaudro@redhat.com, aconole@redhat.com
References: <20261015124749.4694-2-fmancera@suse.de>
 <179221191010.434549.8856124906041431590@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <179221191010.434549.8856124906041431590@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -3.00
X-Spam-Flag: NO
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
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[sashiko];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: 193DE1F38C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On 10/17/26 6:38 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] net/openvswitch: set_sctp corrupts SCTP checksum for padded
>    packets
> - [Medium] In net/openvswitch/actions.c, set_sctp() now returns -EINVAL
>    whenever `flow_key->ip.frag != OVS_FRAG_TYPE_NONE`.
> - [Low] The commit message says first and later fragments failed the same
>    way: the skb holds part of the SCTP packet and 'the CRC delta of a…
> - [Low] set_tcp() and set_udp() (actions.c:644-645, 598-599) skip
>    OVS_FRAG_TYPE_LATER packets: they return 0 and the action list…
> 
> --
> 
> net: openvswitch: drop IP fragments on SCTP set action
> 
> This patch makes set_sctp() return -EINVAL for any packet whose flow key
> has ip.frag set to anything other than OVS_FRAG_TYPE_NONE. The goal is to
> drop SCTP fragments with OVS_DROP_ACTION_ERROR instead of forwarding them
> with rewritten ports and an invalid CRC32c checksum.
> 
> Link: https://lore.kernel.org/netdev/d4fc14f3-4308-4560-9012-43c09c1b3845@ovn.org/
> 
>> For a first fragment, and for
>> a later fragment, it holds just a part of it, and the CRC delta of a
>> change at the start of the packet depends on how many bytes follow, so
>> the checksum written is wrong.
> 
[...]>
> [Severity: High]
> This patch doesn't introduce it, but does the same CRC delta problem
> also hit unfragmented packets that carry trailing link layer padding?
> 
> sctp_compute_cksum() covers skb->len - sctphoff bytes. As far as I can
> see, nothing on the OVS receive path trims skb->len down to the IPv4
> total length or the IPv6 payload length before actions run. The only
> trim I can find is ovs_skb_network_trim() in
> net/openvswitch/conntrack.c, and that only runs for ct actions. So a
> small SCTP packet that was padded to the 60 byte Ethernet minimum
> reaches set_sctp() with the pad bytes still in the skb.
> 
> In that case old_correct_csum and new_csum are both computed over the
> SCTP packet plus the padding. As the commit message says, the CRC delta
> of a change at the start of the packet depends on how many bytes follow
> it. That makes old_correct_csum ^ new_csum the wrong delta for the
> receiver, and old_correct_csum also no longer matches a correct
> old_csum. The value written to sh->checksum is wrong even for a packet
> that arrived with a valid checksum. ip_rcv() or ipv6_rcv() on the
> receiver trims the padding, sctp_rcv() then sees a CRC32c mismatch, and
> the packet is dropped.
> 
> This looks easy to hit. Over IPv4, an SCTP packet that carries only a
> COOKIE ACK, SHUTDOWN ACK or SHUTDOWN COMPLETE chunk is 36 bytes of IP,
> well under the Ethernet minimum. A flow that rewrites SCTP ports, for
> example for NAT, would then corrupt those chunks. I think losing COOKIE
> ACK would keep an association from ever being established.
> 
> Could set_sctp() limit the CRC computation to the length taken from the
> IP header? Another option would be to trim the skb first, the way
> ovs_skb_network_trim() does. Do you want to handle this in this series,
> or as a separate fix?
> 

This might be right. I need to look better into SCTP and openvswitch 
flows, I will write this down and look into it later. I think it should 
be a separated patch

> [Severity: Medium]
> Does this also drop IPv6 atomic fragments? These are packets with a
> Fragment header whose offset is 0 and whose M bit is clear, so the skb
> holds the complete SCTP packet.
> 
> parse_ipv6hdr() in net/openvswitch/flow.c marks any Fragment header with
> a zero offset as OVS_FRAG_TYPE_FIRST:
> 
> 	nexthdr = ipv6_find_hdr(skb, &payload_ofs, -1, &frag_off, &flags);
> 	if (flags & IP6_FH_F_FRAG) {
> 		if (frag_off) {
> 			...
> 		}
> 		key->ip.frag = OVS_FRAG_TYPE_FIRST;
> 
> ipv6_find_hdr() in net/ipv6/exthdrs_core.c sets IP6_FH_F_FRAG whenever a
> Fragment header is present, and it masks off the M bit:
> 
> 	_frag_off = ntohs(*fp) & ~0x7;
> 
> As a result, set_sctp() cannot tell an atomic fragment from a real first
> fragment.
> 
> Before this patch, sctp_compute_cksum() covered the whole SCTP packet in
> this case, so the old_csum ^ old_correct_csum ^ new_csum update was
> correct and the packet was forwarded with its ports rewritten. Now
> do_execute_actions() frees it with OVS_DROP_ACTION_ERROR and skips the
> rest of the action list.
> 
> RFC 8021 deprecates generating atomic fragments, but RFC 6946 still says
> receivers must process them.
> 
> Could the check look at the M bit, or confirm that the skb covers the
> full IPv6 payload, rather than rejecting every OVS_FRAG_TYPE_FIRST packet?
> IPv4 SCTP looks fine here, because key_extract() only sets
> OVS_FRAG_TYPE_FIRST for it when IP_MF is set.
> 

Yes, it does that and AFAIU, we do not care about it. Indeed, the next 
step is to reject the flow directly for fragments.

> [Severity: Low]
> This isn't a bug, but should later fragments be handled the same way here
> as in set_tcp() and set_udp()? Both of those treat OVS_FRAG_TYPE_LATER as
> a successful no-op:
> 
> 	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
> 		return 0;
> 
> This check returns -EINVAL for both FIRST and LATER. Take a flow that
> wildcards ip.frag and rewrites L4 ports. IPv4 TCP/UDP later fragments are
> forwarded unchanged and the action list continues. IPv4 SCTP later
> fragments are dropped with OVS_DROP_ACTION_ERROR, and any actions after
> the set are skipped.
> 
> The commit message says the drop is intended. The same flow drops the
> first fragment anyway, so the visible difference is mostly drop
> accounting and whether later actions run.
> 
> The uAPI description of OVS_ACTION_ATTR_SET in
> include/uapi/linux/openvswitch.h also doesn't mention that a validated
> SCTP set can fail at runtime on fragments while TCP/UDP sets are skipped.
> 

Based on the discussions with the maintainers, we do not care about it 
and in the future we are rejecting it directly.

