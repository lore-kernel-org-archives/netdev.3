Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BDB46EC79
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853480; cv=none; b=aT2gi24F6onrsOLnvzA8C0lZGxHJoFO197om3lF8w5fEdnp+Z/TlSYob27nw7XEiZqBV1tJU/yy0rqOIsRK1ZibNNKe288zBZX7WBMxDW0SlhFVrIcxHh4NQwGS8ngVxITgQvHnfXwUTGVZADrm72NH8SItGYqvhw3hkdqEZSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853480; c=relaxed/simple;
	bh=U241GdGIVluRm8oGZBm41X5qru4sUD5Ky9XAbESWFz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxz5cDGT9udG+VfO9v7iaBoG9equjmRi1e+NB4GdAPEC1NRAniKH3pUgzswqMq5MFZrCZ2FjrA6tMDj0XCPzwpVxy5ny2xEDTqibBNx8RDIJ0KmZtPbT6nlROqcGjHznyt0acP1SNJRlTykw/h0Z0bYM/Fww1BS2KspEsM3Giv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=YoetUQ3i; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="YoetUQ3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1790853471;
 bh=KNyXMox+gGfoMkiEj3dPkECPGmeQOfpULYSxF1LIglo=;
 b=YoetUQ3iwu++gpxcV6LZ/rTB4kSicWWndRIQzxOfR5W0+C7YUJIkBMmX6hxaIQjwfF2Son8pR
 ZlikGKv3bjATWuK9cevVFYPc/nuRRbbfECP+T5cOw+E21hYAzTItxjTVAOzY4dJR6TlRn2kFxEa
 XIEP3sb8e8zQZ4/mPXDOfV0=
X-Forward-Email-ID: 6abe40cdd8b95ac0564be8b4
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.16.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <50b0db80-7d42-44fc-81eb-d0fed8047871@ovn.org>
Date: Thu, 1 Oct 2026 13:15:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: openvswitch: validate transport header presence
 in set_ipv6_addr
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, aatteka@nicira.com, jesse@nicira.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, i.maximets@ovn.org, echaudro@redhat.com,
 aconole@redhat.com, syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
References: <20261001085205.3822-1-fmancera@suse.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20261001085205.3822-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/26 10:52 AM, Fernando Fernandez Mancera wrote:
> When executing IPv6 address rewrite actions on IPv6 fragments,
> set_ipv6_addr() might attempt to recalculate the L4 header checksum
> calling skb_transport_header() with an uninitialized transport header.
> This can potentially lead to a OOB write.

Not really.  later fragments have l4_proto set to NEXTHDR_FRAGMENT
and so no writes will be performed.  See parse_ipv6hdr().

> A warning is triggered with DEBUG_NET=y.

Yeah, while the value is not actually used to access the packet data,
the skbuff core generates a warning on read.

> 
> Fix this by recalculating the checksum only if there is a valid
> transport header in the skb. Otherwise, assume this is a fragment and
> skip it.
> 
> See the syzbot trace:
> 
> !skb_transport_header_was_set(skb)
> WARNING: ./include/linux/skbuff.h:3075 at skb_transport_header include/linux/skbuff.h:3075 [inline], CPU#1: syz-executor463/5635
> WARNING: ./include/linux/skbuff.h:3075 at skb_transport_offset include/linux/skbuff.h:3250 [inline], CPU#1: syz-executor463/5635
> WARNING: ./include/linux/skbuff.h:3075 at update_ipv6_checksum net/openvswitch/actions.c:361 [inline], CPU#1: syz-executor463/5635
> WARNING: ./include/linux/skbuff.h:3075 at set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399, CPU#1: syz-executor463/5635
> [...]
> RIP: 0010:skb_transport_header include/linux/skbuff.h:3075 [inline]
> RIP: 0010:skb_transport_offset include/linux/skbuff.h:3250 [inline]
> RIP: 0010:update_ipv6_checksum net/openvswitch/actions.c:361 [inline]
> RIP: 0010:set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399
> [...]
> Call Trace:
>  <TASK>
>  set_ipv6 net/openvswitch/actions.c:531 [inline]
>  do_execute_actions+0x557e/0x8600 net/openvswitch/actions.c:1366
>  ovs_execute_actions+0xde/0x520 net/openvswitch/actions.c:1592
>  ovs_packet_cmd_execute+0xb4f/0xf10 net/openvswitch/datapath.c:705
>  genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
>  genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
>  netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>  netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
>  sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
> 
> Reported-by: syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4cc63fcfb3845e149969
> Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/openvswitch/actions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index dc5ff859f114..a14668565ec4 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -395,7 +395,7 @@ static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
>  			  __be32 addr[4], const __be32 new_addr[4],
>  			  bool recalculate_csum)
>  {
> -	if (recalculate_csum)
> +	if (recalculate_csum && skb_transport_header_was_set(skb))
>  		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
I'd suggest moving the check into update_ipv6_checksum() and maybe add
a small comment that the check is only to avoid warning on reading the
offset that wasn't set, offset must always be set for any l4_proto for
which the checksum is actually getting updated.

Best regards, Ilya Maximets.
