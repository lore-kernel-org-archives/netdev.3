Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10B49A3C6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462283; cv=none; b=W3f01dW2oG7LLBTSvyLk+s/hJIv/95OSlwo0fugBoWZEuqn6CPHL2aINO6Pxy/JZXlMyeVF0yaKnQU9cBwZyOMDckpzQGuHPoaBee0K8yWR1Y0kpGZig3dVTOXI+Vp79Ed5H7zNU43R9aODsJokdOZso7nz4q2+txJVxAzSVp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462283; c=relaxed/simple;
	bh=f3EouvrWJbt7wR32vpuwzyhzCjzrq7NAPQlDV/CetpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phVJspZ/CwoRnBqK8+xo2jlFfiX2dRbksbkfACRulP5AsL9drd3PPIvMrnX5q2K487F49zqRocSVz/YbyM0+Bku2LE6KEUJI3X0a+YoxTKzZkgaLM2E3WUHavmL3h6m0NUW1nW1JMm4skdjTEtN5aa6nwGIgnsXD2kKPhFnwbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4D1B219A7;
	Thu,  8 Oct 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 053781339F;
	Thu,  8 Oct 2026 12:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VIMDM4aLx2rRPgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 08 Oct 2026 12:24:38 +0000
Message-ID: <b877c0b9-1e1e-4860-b35a-9a27524bea3e@suse.de>
Date: Thu, 8 Oct 2026 14:24:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: openvswitch: do not set transport header
 on later IPv4 fragments
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, blp@nicira.com,
 joe@wand.net.nz, jesse@nicira.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 i.maximets@ovn.org, echaudro@redhat.com, aconole@redhat.com
References: <20261005150831.4831-1-fmancera@suse.de>
 <179142893147.434549.15118225602165856295@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <179142893147.434549.15118225602165856295@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.00 / 50.00];
	TAGGED_RCPT(0.00)[sashiko]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E4D1B219A7
X-Spam-Flag: NO
X-Spam-Score: 0.00
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason

Hi all,

I have reviewed both comments, please see my reply below.

On 10/8/26 5:08 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch changes check_iphdr() (net/openvswitch/flow.c) so
>    that it no longer sets skb->transport_header for IPv4 later fragments…
> 
> Pre-existing issues:
> - [Medium] set_sctp() (net/openvswitch/actions.c) still runs on
>    OVS_FRAG_TYPE_FIRST fragments of IPv4 and IPv6 SCTP packets.
> 
> --
> 
> net: openvswitch: do not set transport header on later IPv4 fragments
> 
> The patch stops check_iphdr() from setting the transport header on IPv4
> later fragments. It also moves the fragment offset check in
> update_ip_l4_checksum() before the transport offset is read. Finally, it
> adds OVS_FRAG_TYPE_LATER guards to set_tcp(), set_udp() and set_sctp() so
> these actions no longer corrupt fragment pajesuly martillo y cincelyloads.
> 
> Link: https://lore.kernel.org/netdev/59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org/
> 
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index dc5ff859f1145..8556a5a74ccd0 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
> 
> [ ... ]
> 
>> @@ -658,11 +666,16 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
>>   		    const struct ovs_key_sctp *key,
>>   		    const struct ovs_key_sctp *mask)
>>   {
>> -	unsigned int sctphoff = skb_transport_offset(skb);
>> -	struct sctphdr *sh;
>>   	__le32 old_correct_csum, new_csum, old_csum;
>> +	unsigned int sctphoff;
>> +	struct sctphdr *sh;
>>   	int err;
>>   
>> +	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
>> +		return 0;
>> +
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch. Even
> so, set_sctp() still runs on OVS_FRAG_TYPE_FIRST fragments of both IPv4
> and IPv6 SCTP packets.
> 
> key_extract_l3l4() marks a fragment at offset 0 with IP_MF set as FIRST:
> 
> net/openvswitch/flow.c:key_extract_l3l4() {
>      ...
> 		if (nh->frag_off & htons(IP_MF) ||
> 			skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
> 			key->ip.frag = OVS_FRAG_TYPE_FIRST;
>      ...
> }
> 
> For OVS_KEY_ATTR_SCTP, validate_set() checks only eth_type and
> ip.proto == IPPROTO_SCTP, so it accepts the action for such a flow.
> 
> set_sctp() then computes old_correct_csum and new_csum with
> sctp_compute_cksum(). That function covers only this fragment's bytes:
> 
> include/net/sctp/checksum.h:sctp_compute_cksum() {
>      ...
> 	new = ~skb_crc32c(skb, offset, skb->len - offset, ~0);
>      ...
> }
> 
> How much a CRC32c changes depends on how many bytes follow the changed
> bytes. Does that make this result wrong for the reassembled datagram?
> 
> 	sh->checksum = old_csum ^ old_correct_csum ^ new_csum;
> 
> If so, the receiver would drop the reassembled packet. After this patch,
> port rewrites on fragmented SCTP flows seem to remain broken end to end.
> Only the corruption of later fragment payloads is fixed.
> 

I think this feedback is correct but I don't see a possible solution 
other than reassembling the whole packet. Not sure how common fragmented 
SCTP traffic is.. but maybe we can just return an error for fragmented 
traffic and document it for SCTP. Any opinion?

In any case, that is out of scope for this patch. I will write a script 
to test this actually and find out what are the consequences.

>>   	err = skb_ensure_writable(skb, sctphoff + sizeof(struct sctphdr));
>>   	if (unlikely(err))
>>   		return err;
>> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
>> index 1c4f3a0790443..52cc63837445b 100644
>> --- a/net/openvswitch/flow.c
>> +++ b/net/openvswitch/flow.c
> 
> [ ... ]
> 
>> @@ -201,7 +202,10 @@ static int check_iphdr(struct sk_buff *skb)
>>   		     skb->len < nh_ofs + ip_len))
>>   		return -EINVAL;
>>   
>> -	skb_set_transport_header(skb, nh_ofs + ip_len);
>> +	nh = ip_hdr(skb);
>> +	if (!(nh->frag_off & htons(IP_OFFSET)))
>> +		skb_set_transport_header(skb, nh_ofs + ip_len);
>> +
> 
> [Severity: Medium]
> With this change, an IPv4 later fragment leaves the OVS datapath with
> the transport_header it arrived with:
> 
> - On the normal RX path it is the network header, because
>    __netif_receive_skb_core() resets it.
> - With CONFIG_DEBUG_NET, or for packets built through
>    OVS_PACKET_CMD_EXECUTE, it is unset (~0).
> 
> Before this patch it always pointed just past the IP header, as
> ip_rcv_core() and ip_frag_next() do.
> 
> The commit message says:
> 
>      That is only safe if no later code relies on it.
> 
> Is there code that runs after OVS and does rely on it? One example is
> mlx5e_skb_l3_header_offset() in
> drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:
> 
> 	if (skb_transport_header_was_set(skb))
> 		return skb_transport_offset(skb);
> 	else
> 		return mlx5e_skb_l2_header_offset(skb);
> 
> With tx_min_inline_mode == MLX5_INLINE_MODE_IP, mlx5e_calc_min_inline()
> used to inline L2 and L3 for these fragments. It now seems to inline only
> L2.
> 
> That mode is forced on a DSCP trust port by
> mlx5e_trust_update_tx_min_inline_mode():
> 
> 	if (trust_state == MLX5_QPTS_TRUST_DSCP &&
> 	    params->tx_min_inline_mode == MLX5_INLINE_MODE_L2)
> 		params->tx_min_inline_mode = MLX5_INLINE_MODE_IP;
> 
> Could later fragments then be classified into a different traffic class
> than the first fragment of the same datagram?
> 
> The new OVS_FRAG_TYPE_LATER guards in set_tcp(), set_udp() and set_sctp()
> appear to fix the payload corruption on their own. Only the reorder in
> update_ip_l4_checksum() depends on this check_iphdr() change. Is the
> change needed for the fix?

I can split the changes if needed but I would put them together anyway, 
the check on set_tcp() and other variants is something I found while 
writing the check_iphdr() change. What is the preference in this situation?

I can send a series of patches including the SCTP issue mentioned above.

> 
> OVS already behaves this way for IPv6 later fragments since commit
> 41e4e2cd7534. Bridged IPv4 fragments also already arrive with
> transport_header == network_header, so this matches existing behaviour.
> 
> If the change stays, could the commit message say why it is needed and
> mention this effect on code that runs after OVS? The Fixes: tags will
> carry it to stable together with the actual fix.

I think the explanation is correct but the fix belongs to the driver as 
the problem would still be there for IPv6 OVS fragmented traffic and 
bridged traffic for example.

I could try to find a NIC that I could use for testing this driver and 
this path. In any case, I would not include this fix as part of the 
openvswitch series.

Thanks,
Fernando.

> 
>>   	return 0;
>>   }
> 
> [ ... ]
> 

