Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A637FF43
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406454; cv=none; b=GhyBLX/TgtmjpGVJUcrSQQfaF8B0+S+CYk6Sfw0Ag6rX77Mlk2+M9CuO5zUvEM8NGBc9WC9HajgF5uzh9Xs7UqYX1KaGUErwUWuA9+9PH2/f+L8F9Rc0oTaZytFNhuvmWBjIKJv+Z50JidBW9gLl1HIhxYsI9RRoe++O4+rWhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406454; c=relaxed/simple;
	bh=/TR/jU7VKb02utdggs5X1bSHRWOz540AJNL0scopBlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL/n2VfhBI4Ws2Di0SqYbmK/bfjQpS1div9JjxtU/EvkId2dCGNNc32/AyyMaT6ukgXsOVS7RdMy3Za6r8uXqEHQFw6Lbj4yD4BQI7/gvyfABEDncTqunJfrjsRdnnYb0eS30WDkNezVW4X2ajzrX1hxFxeGE4jT17JEAT9Hp40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=BcItTDSg; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="BcItTDSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1791406447;
 bh=gmwRBpSYGwRdonMFddR8G3PonuFWdtXyaJ8PiFMH/kg=;
 b=BcItTDSgdGKkljJ5wmKDJyp4dWvU+WcOjUDjxKCVlfnBL0LmxJGX4tthLtAvfoQRf8S7ednPU
 e1LS6WUhNRnVXbdWtSAp++NlLA3g6iawWVr4XhDF64BKGpS+UDB16IdqJN3pDxp1YM3ePL06/XC
 foNRNc6rkmOag6QEhPTmkGU=
X-Forward-Email-ID: 6ac6b16b45c31bce6f957654
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9c27ef7a-1af0-403e-9fb6-757c3555d051@ovn.org>
Date: Wed, 7 Oct 2026 22:53:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: openvswitch: validate transport header
 presence in set_ipv6_addr
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, aatteka@nicira.com, jesse@nicira.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, i.maximets@ovn.org, echaudro@redhat.com,
 aconole@redhat.com, syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
References: <20261002075255.5015-1-fmancera@suse.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20261002075255.5015-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/26 9:52 AM, Fernando Fernandez Mancera wrote:
> When executing IPv6 address rewrite actions on IPv6 fragments,
> set_ipv6_addr() calls update_ipv6_checksum(). If parse_ipv6hdr()
> processes a non-first IPv6 fragment, it sets key->ip.proto to
> NEXTHDR_FRAGMENT and returns early without calling
> skb_set_transport_header().
> 
> update_ipv6_checksum() unconditionally evaluates skb_transport_offset()
> on entry before checking l4_proto.  Because skb->transport_header is
> uninitialized, this triggers a warning under CONFIG_DEBUG_NET=y although
> it is completely harmless.
> 
> Fix this by returning early in update_ipv6_checksum() if l4_proto is
> NEXTHDR_FRAGMENT. This avoids reading the uninitialized transport offset
> for fragments while preserving the debug warning for any other protocol
> where the transport header is unexpectedly missing.
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
>  net/openvswitch/actions.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index dc5ff859f114..68b42e900c73 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -358,7 +358,15 @@ static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
>  static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
>  				 __be32 addr[4], const __be32 new_addr[4])
>  {
> -	int transport_len = skb->len - skb_transport_offset(skb);
> +	int transport_len;
> +
> +	/* avoid reading the transport header offset if it isn't set,
> +	 * as it triggers a warning
> +	 */

nit: We prefer full sentences, i.e. start with a capital and end with a dot.

But also, I think, since the switch to NEXTHDR_FRAGMENT check, the comment
lost it's intended purpose as the code is pretty much self-documenting now.
It's clear that the fragment doesn't have the transport header.  The comment
made sense if we needed to explain in which case we can get here without
having the offset initialized.  I'd suggest we drop the comment.

You're also not adding such comments in the other patch for ipv4.

Otherwise, LGTM.

> +	if (l4_proto == NEXTHDR_FRAGMENT)
> +		return;
> +
> +	transport_len = skb->len - skb_transport_offset(skb);
>  
>  	if (l4_proto == NEXTHDR_TCP) {
>  		if (likely(transport_len >= sizeof(struct tcphdr)))

Best regards, Ilya Maximets.
