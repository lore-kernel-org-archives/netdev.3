Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36B3D47C2
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843396; cv=none; b=Yw8h49FmhfFiyvcxJ024LhGomaotuJswGrHwewmyK1992ZpPJHhXGl3vuPgr2TdippeX3ZClew7+QGLvMmwLbx76c20hdWAO7/VM/xHJr0zx26AoBSARAynHfqA9fdpl6asI0WKPlKOw++M5xWPWZPwhbjTv2FfOMJHiF89atro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843396; c=relaxed/simple;
	bh=xi3n5MbOVU2PADP4sNxZy7npriMtRthKGdvBZZbb5bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIQgdoodPFWCchLCTpPOQBS+DfMf8cdGfjHxa+4EjuRpq7KTTUSQU/+sGNcvG+BDnw+J3PPrQYZovcGUGVPsvxb8OOwD0OKCnFdYLg394zbxuWiz4eK0LdrIXVfheAooCxZwdjH1d1bGoS04z3TiyhO0mB+74PqCW1z2qVFez5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=UlbpfNUL; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="UlbpfNUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1791843394;
 bh=wchQfqcyrBVL2nr5RpKL0fHh6Mylhy+Px8EJFVPf+6k=;
 b=UlbpfNULN4+aYjs1luRA0AGHtXXm1Q9JmMSF/vpjb27bDldyeknsCfn/KveeexpIuvjBrYwY1
 ouMT40PhAdNwIWMQ0gOeCnNWOLQS2U7JkduIkeyjj86k0wtwV7zU17opVZaF7AxYHMXzoZhgYUL
 4+XeE/yUZIyWIvxRDRr2/wg=
X-Forward-Email-ID: 6acd5c3bc497634d444505bf
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d4fc14f3-4308-4560-9012-43c09c1b3845@ovn.org>
Date: Tue, 13 Oct 2026 00:16:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: openvswitch: do not set transport header
 on later IPv4 fragments
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, joe@wand.net.nz,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, i.maximets@ovn.org, echaudro@redhat.com,
 aconole@redhat.com
References: <20261005150831.4831-1-fmancera@suse.de>
 <179142893147.434549.15118225602165856295@kernel.org>
 <b877c0b9-1e1e-4860-b35a-9a27524bea3e@suse.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <b877c0b9-1e1e-4860-b35a-9a27524bea3e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/26 2:24 PM, Fernando Fernandez Mancera wrote:
> Hi all,
> 
> I have reviewed both comments, please see my reply below.
> 
> On 10/8/26 5:08 AM, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] The patch changes check_iphdr() (net/openvswitch/flow.c) so
>>    that it no longer sets skb->transport_header for IPv4 later fragments…
>>
>> Pre-existing issues:
>> - [Medium] set_sctp() (net/openvswitch/actions.c) still runs on
>>    OVS_FRAG_TYPE_FIRST fragments of IPv4 and IPv6 SCTP packets.
>>
>> --
>>
>> net: openvswitch: do not set transport header on later IPv4 fragments
>>
>> The patch stops check_iphdr() from setting the transport header on IPv4
>> later fragments. It also moves the fragment offset check in
>> update_ip_l4_checksum() before the transport offset is read. Finally, it
>> adds OVS_FRAG_TYPE_LATER guards to set_tcp(), set_udp() and set_sctp() so
>> these actions no longer corrupt fragment pajesuly martillo y cincelyloads.
>>
>> Link: https://lore.kernel.org/netdev/59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org/
>>
>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>> index dc5ff859f1145..8556a5a74ccd0 100644
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>
>> [ ... ]
>>
>>> @@ -658,11 +666,16 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
>>>   		    const struct ovs_key_sctp *key,
>>>   		    const struct ovs_key_sctp *mask)
>>>   {
>>> -	unsigned int sctphoff = skb_transport_offset(skb);
>>> -	struct sctphdr *sh;
>>>   	__le32 old_correct_csum, new_csum, old_csum;
>>> +	unsigned int sctphoff;
>>> +	struct sctphdr *sh;
>>>   	int err;
>>>   
>>> +	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
>>> +		return 0;
>>> +
>>
>> [Severity: Medium]
>> This is a pre-existing issue and was not introduced by this patch. Even
>> so, set_sctp() still runs on OVS_FRAG_TYPE_FIRST fragments of both IPv4
>> and IPv6 SCTP packets.
>>
>> key_extract_l3l4() marks a fragment at offset 0 with IP_MF set as FIRST:
>>
>> net/openvswitch/flow.c:key_extract_l3l4() {
>>      ...
>> 		if (nh->frag_off & htons(IP_MF) ||
>> 			skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
>> 			key->ip.frag = OVS_FRAG_TYPE_FIRST;
>>      ...
>> }
>>
>> For OVS_KEY_ATTR_SCTP, validate_set() checks only eth_type and
>> ip.proto == IPPROTO_SCTP, so it accepts the action for such a flow.
>>
>> set_sctp() then computes old_correct_csum and new_csum with
>> sctp_compute_cksum(). That function covers only this fragment's bytes:
>>
>> include/net/sctp/checksum.h:sctp_compute_cksum() {
>>      ...
>> 	new = ~skb_crc32c(skb, offset, skb->len - offset, ~0);
>>      ...
>> }
>>
>> How much a CRC32c changes depends on how many bytes follow the changed
>> bytes. Does that make this result wrong for the reassembled datagram?
>>
>> 	sh->checksum = old_csum ^ old_correct_csum ^ new_csum;
>>
>> If so, the receiver would drop the reassembled packet. After this patch,
>> port rewrites on fragmented SCTP flows seem to remain broken end to end.
>> Only the corruption of later fragment payloads is fixed.
>>
> 
> I think this feedback is correct but I don't see a possible solution 
> other than reassembling the whole packet. Not sure how common fragmented 
> SCTP traffic is..

AFAIU the RFC, SCTP does it's own PMTUD and fragments the DATA chunks
inside of it based on path MTU.  So, IP fragmentation only comes into
play when effective path MTU changes after the discovery and the nodes
have to re-fragment in transit.  I hope, that means that IP-fragmented
SCTP should not be very common in practice.

> but maybe we can just return an error for fragmented 
> traffic and document it for SCTP. Any opinion?

In general, I'd say we should not allow the actions be installed for
the flow that doesn't ensure that the headers exist and it is safe to
update them.  I.e. flows that allow TCP/UDP later fragments should not
be allowed to have set(tcp/udp) actions and flows that allow any type
of IP-fragmented SCTP should not be allowed to have set(sctp) actions.

This aligns with the base assumption of openvswitch module that if the
actions are being executed, they must be safe.

The way to achieve that is to reject such flows inside validate_set().

While, I'm sure, sashiko would complain about uAPI, this should not
affect existing OVS users, as ovs-vswitchd always has an exact match
on the fragmentation bits.

However, validate_set() currently doesn't get the mask, only the masked
key.  Which means we can't distinguish a flow that exactly matches on
the OVS_FRAG_TYPE_NONE, from the one that doesn't match on the ip.frag
at all.  So, we'd need to provide that mask (either a full mask struct
or specifically the frag_mask), wiring it through the call stack, which
is not nice.  And also kind of misaligned with the fact that we're
passing down the masked key.  So, I'm not sure.

For now we may just do what your patch is doing for TCP and UDP, which
is return zero and just ignore the action this way.  This is safe for
TCP/UDP.

For SCTP, I agree, if we're not rejecting the flow in the first place,
then returning an error and dropping the packet might be reasonable
as we can't actually update the checksum for any type of an IP-fragment.

Note: there are might be some issues with the way the SCTP checksum
is calculated in general, as it does not seem to take into account L2
padding or CHECKSUM_PARTIAL/COMPLETE.

> 
> In any case, that is out of scope for this patch. I will write a script 
> to test this actually and find out what are the consequences.
> 
>>>   	err = skb_ensure_writable(skb, sctphoff + sizeof(struct sctphdr));
>>>   	if (unlikely(err))
>>>   		return err;
>>> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
>>> index 1c4f3a0790443..52cc63837445b 100644
>>> --- a/net/openvswitch/flow.c
>>> +++ b/net/openvswitch/flow.c
>>
>> [ ... ]
>>
>>> @@ -201,7 +202,10 @@ static int check_iphdr(struct sk_buff *skb)
>>>   		     skb->len < nh_ofs + ip_len))
>>>   		return -EINVAL;
>>>   
>>> -	skb_set_transport_header(skb, nh_ofs + ip_len);
>>> +	nh = ip_hdr(skb);
>>> +	if (!(nh->frag_off & htons(IP_OFFSET)))
>>> +		skb_set_transport_header(skb, nh_ofs + ip_len);
>>> +
>>
>> [Severity: Medium]
>> With this change, an IPv4 later fragment leaves the OVS datapath with
>> the transport_header it arrived with:
>>
>> - On the normal RX path it is the network header, because
>>    __netif_receive_skb_core() resets it.
>> - With CONFIG_DEBUG_NET, or for packets built through
>>    OVS_PACKET_CMD_EXECUTE, it is unset (~0).
>>
>> Before this patch it always pointed just past the IP header, as
>> ip_rcv_core() and ip_frag_next() do.
>>
>> The commit message says:
>>
>>      That is only safe if no later code relies on it.
>>
>> Is there code that runs after OVS and does rely on it? One example is
>> mlx5e_skb_l3_header_offset() in
>> drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:
>>
>> 	if (skb_transport_header_was_set(skb))
>> 		return skb_transport_offset(skb);
>> 	else
>> 		return mlx5e_skb_l2_header_offset(skb);
>>
>> With tx_min_inline_mode == MLX5_INLINE_MODE_IP, mlx5e_calc_min_inline()
>> used to inline L2 and L3 for these fragments. It now seems to inline only
>> L2.
>>
>> That mode is forced on a DSCP trust port by
>> mlx5e_trust_update_tx_min_inline_mode():
>>
>> 	if (trust_state == MLX5_QPTS_TRUST_DSCP &&
>> 	    params->tx_min_inline_mode == MLX5_INLINE_MODE_L2)
>> 		params->tx_min_inline_mode = MLX5_INLINE_MODE_IP;
>>
>> Could later fragments then be classified into a different traffic class
>> than the first fragment of the same datagram?
>>
>> The new OVS_FRAG_TYPE_LATER guards in set_tcp(), set_udp() and set_sctp()
>> appear to fix the payload corruption on their own. Only the reorder in
>> update_ip_l4_checksum() depends on this check_iphdr() change. Is the
>> change needed for the fix?
> 
> I can split the changes if needed but I would put them together anyway, 
> the check on set_tcp() and other variants is something I found while 
> writing the check_iphdr() change. What is the preference in this situation?
> 
> I can send a series of patches including the SCTP issue mentioned above.

I'd say the issue with set_tcp/udp/sctp and the check_iphdr() one
are a bit different, I'd suggest splitting in two patches.  The
set_tcp/udp/sctp shouldn't cause any serious issues since the write
is contained within the skb itself, so it may still be fine to have
it in net-next only even though it is sort of a bug fix.  I haven't
seen issues related to in in real world.  Also, because ovs-vswitchd
always has an exact mask on the fragmentation bits and it will never
produce an action that modifies L4 for the later fragment.

It may however produce SCTP port modification for the first fragment,
which I'll need to address in userspace as well.  But it is still a
bug, ovs-vswitchd shouldn't allow for that either.

Best regards, Ilya Maximets.

> 
>>
>> OVS already behaves this way for IPv6 later fragments since commit
>> 41e4e2cd7534. Bridged IPv4 fragments also already arrive with
>> transport_header == network_header, so this matches existing behaviour.
>>
>> If the change stays, could the commit message say why it is needed and
>> mention this effect on code that runs after OVS? The Fixes: tags will
>> carry it to stable together with the actual fix.
> 
> I think the explanation is correct but the fix belongs to the driver as 
> the problem would still be there for IPv6 OVS fragmented traffic and 
> bridged traffic for example.
> 
> I could try to find a NIC that I could use for testing this driver and 
> this path. In any case, I would not include this fix as part of the 
> openvswitch series.
> 
> Thanks,
> Fernando.
> 
>>
>>>   	return 0;
>>>   }
>>
>> [ ... ]
>>
> 

