Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807264F6474
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416934; cv=none; b=SHbHVHyVOg0clUVoRZvTIeCvK8a5mhYieA6s67zJQl2R2wGwvylNh7aDk5ruUAZiYQCLjhQ9yu1JNaNDzSCHkkW0UinNoQ/D1KXTMZhqssicCcezvEQl02odSyfWdRx8hKdxhv95eh1CyZ/j+GLP77RUbroTHxJoTetEwiGfK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416934; c=relaxed/simple;
	bh=wUJV2ZmUE/Gy93CuZ08Ep8TqNPPYJUF+uAKMnE3MRLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZrXhDwSqnDQjAMiAQbFoERIzPXYCHJGAkxWaGIH9lDx8Jxeu20yvjsblSU280RF0VQlgCYfLYdqKSG/s4A1j9EcwsO8MBmYA+8E3gBhtHWurtj78PxbIpIrOl3KftHSZzOa3G0f0UDcYWCR63tIuE6bCnmSM/G21hpaF1LWqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=me7BnNtS; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="me7BnNtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1792416926;
 bh=HYXPpdc7BTq4sm2sl2AX0mkUr94SZtztsRa0z639SDo=;
 b=me7BnNtSw0ZGV2+XGHZO+oq62bSH7dUgKNWOMlbqOQ5JYGs/D4QIGN7lv9GlQQWf617/uqlkM
 7jxlXIAwPm/GNCrOJMi6Y6/zfMnnBBAaKGI7vywIqv2CcvBoJl86KBw9zY57xruGjv61xLVjaSD
 pcjPrfZXWc6/m1KOcUotkgc=
X-Forward-Email-ID: 6ad61c9a54539d264d693a3e
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <33ecc4e5-7634-401d-bbbb-b71454720132@ovn.org>
Date: Mon, 19 Oct 2026 15:35:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] net: openvswitch: drop IP fragments on SCTP
 set action
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, i.maximets@ovn.org, echaudro@redhat.com,
 aconole@redhat.com
References: <20261015124749.4694-2-fmancera@suse.de>
 <179221191010.434549.8856124906041431590@kernel.org>
 <7171b266-fbc7-478d-ba73-754be3b6b32c@suse.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <7171b266-fbc7-478d-ba73-754be3b6b32c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/18/26 7:15 PM, Fernando Fernandez Mancera wrote:
> On 10/17/26 6:38 AM, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 4 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 1 · Low: 2
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] net/openvswitch: set_sctp corrupts SCTP checksum for padded
>>    packets
>> - [Medium] In net/openvswitch/actions.c, set_sctp() now returns -EINVAL
>>    whenever `flow_key->ip.frag != OVS_FRAG_TYPE_NONE`.
>> - [Low] The commit message says first and later fragments failed the same
>>    way: the skb holds part of the SCTP packet and 'the CRC delta of a…
>> - [Low] set_tcp() and set_udp() (actions.c:644-645, 598-599) skip
>>    OVS_FRAG_TYPE_LATER packets: they return 0 and the action list…
>>
>> --
>>
>> net: openvswitch: drop IP fragments on SCTP set action
>>
>> This patch makes set_sctp() return -EINVAL for any packet whose flow key
>> has ip.frag set to anything other than OVS_FRAG_TYPE_NONE. The goal is to
>> drop SCTP fragments with OVS_DROP_ACTION_ERROR instead of forwarding them
>> with rewritten ports and an invalid CRC32c checksum.
>>
>> Link: https://lore.kernel.org/netdev/d4fc14f3-4308-4560-9012-43c09c1b3845@ovn.org/
>>
>>> For a first fragment, and for
>>> a later fragment, it holds just a part of it, and the CRC delta of a
>>> change at the start of the packet depends on how many bytes follow, so
>>> the checksum written is wrong.
>>
> [...]>
>> [Severity: High]
>> This patch doesn't introduce it, but does the same CRC delta problem
>> also hit unfragmented packets that carry trailing link layer padding?
>>
>> sctp_compute_cksum() covers skb->len - sctphoff bytes. As far as I can
>> see, nothing on the OVS receive path trims skb->len down to the IPv4
>> total length or the IPv6 payload length before actions run. The only
>> trim I can find is ovs_skb_network_trim() in
>> net/openvswitch/conntrack.c, and that only runs for ct actions. So a
>> small SCTP packet that was padded to the 60 byte Ethernet minimum
>> reaches set_sctp() with the pad bytes still in the skb.
>>
>> In that case old_correct_csum and new_csum are both computed over the
>> SCTP packet plus the padding. As the commit message says, the CRC delta
>> of a change at the start of the packet depends on how many bytes follow
>> it. That makes old_correct_csum ^ new_csum the wrong delta for the
>> receiver, and old_correct_csum also no longer matches a correct
>> old_csum. The value written to sh->checksum is wrong even for a packet
>> that arrived with a valid checksum. ip_rcv() or ipv6_rcv() on the
>> receiver trims the padding, sctp_rcv() then sees a CRC32c mismatch, and
>> the packet is dropped.
>>
>> This looks easy to hit. Over IPv4, an SCTP packet that carries only a
>> COOKIE ACK, SHUTDOWN ACK or SHUTDOWN COMPLETE chunk is 36 bytes of IP,
>> well under the Ethernet minimum. A flow that rewrites SCTP ports, for
>> example for NAT, would then corrupt those chunks. I think losing COOKIE
>> ACK would keep an association from ever being established.
>>
>> Could set_sctp() limit the CRC computation to the length taken from the
>> IP header? Another option would be to trim the skb first, the way
>> ovs_skb_network_trim() does. Do you want to handle this in this series,
>> or as a separate fix?
>>
> 
> This might be right. I need to look better into SCTP and openvswitch 
> flows, I will write this down and look into it later. I think it should 
> be a separated patch

+1

> 
>> [Severity: Medium]
>> Does this also drop IPv6 atomic fragments? These are packets with a
>> Fragment header whose offset is 0 and whose M bit is clear, so the skb
>> holds the complete SCTP packet.
>>
>> parse_ipv6hdr() in net/openvswitch/flow.c marks any Fragment header with
>> a zero offset as OVS_FRAG_TYPE_FIRST:
>>
>> 	nexthdr = ipv6_find_hdr(skb, &payload_ofs, -1, &frag_off, &flags);
>> 	if (flags & IP6_FH_F_FRAG) {
>> 		if (frag_off) {
>> 			...
>> 		}
>> 		key->ip.frag = OVS_FRAG_TYPE_FIRST;
>>
>> ipv6_find_hdr() in net/ipv6/exthdrs_core.c sets IP6_FH_F_FRAG whenever a
>> Fragment header is present, and it masks off the M bit:
>>
>> 	_frag_off = ntohs(*fp) & ~0x7;
>>
>> As a result, set_sctp() cannot tell an atomic fragment from a real first
>> fragment.
>>
>> Before this patch, sctp_compute_cksum() covered the whole SCTP packet in
>> this case, so the old_csum ^ old_correct_csum ^ new_csum update was
>> correct and the packet was forwarded with its ports rewritten. Now
>> do_execute_actions() frees it with OVS_DROP_ACTION_ERROR and skips the
>> rest of the action list.
>>
>> RFC 8021 deprecates generating atomic fragments, but RFC 6946 still says
>> receivers must process them.
>>
>> Could the check look at the M bit, or confirm that the skb covers the
>> full IPv6 payload, rather than rejecting every OVS_FRAG_TYPE_FIRST packet?
>> IPv4 SCTP looks fine here, because key_extract() only sets
>> OVS_FRAG_TYPE_FIRST for it when IP_MF is set.
>>
> 
> Yes, it does that and AFAIU, we do not care about it. Indeed, the next 
> step is to reject the flow directly for fragments.

Atomic fragments are not actually fragments, so we could handle them
more gracefully, e.g. by not setting ip.frag in parse_ipv6hdr() when
there are no more fragments.  But that would be a separate change and
it should not be necessary in real world cases.

> 
>> [Severity: Low]
>> This isn't a bug, but should later fragments be handled the same way here
>> as in set_tcp() and set_udp()? Both of those treat OVS_FRAG_TYPE_LATER as
>> a successful no-op:
>>
>> 	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
>> 		return 0;
>>
>> This check returns -EINVAL for both FIRST and LATER. Take a flow that
>> wildcards ip.frag and rewrites L4 ports. IPv4 TCP/UDP later fragments are
>> forwarded unchanged and the action list continues. IPv4 SCTP later
>> fragments are dropped with OVS_DROP_ACTION_ERROR, and any actions after
>> the set are skipped.
>>
>> The commit message says the drop is intended. The same flow drops the
>> first fragment anyway, so the visible difference is mostly drop
>> accounting and whether later actions run.
>>
>> The uAPI description of OVS_ACTION_ATTR_SET in
>> include/uapi/linux/openvswitch.h also doesn't mention that a validated
>> SCTP set can fail at runtime on fragments while TCP/UDP sets are skipped.
>>
> 
> Based on the discussions with the maintainers, we do not care about it 
> and in the future we are rejecting it directly.

Also, if we're dropping the first fragment it doesn't make much sense
to allow the later ones through.

Best regards, Ilya Maximets.
