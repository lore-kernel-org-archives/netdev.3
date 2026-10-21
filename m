Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579238;
	b=wnl8q0GsbQDNgwhgE9NlYs719OB5GMPLLJX+NJjk6j/WsDrAM2gCvVUGViAQO3sfVPVZ
	 5IVnGOnHqCWhsoi3BT+xijdZnr7f/iAcDO4rIw/d+9eiMjv5N87gBkkC9n1bfXpnKwToz
	 UCqml1vCwsl60ziewN0428Tu/bqSvbeH5k3Uc7V4ec3Rh4oN8t6S2vDoyxBNO/lCiystP
	 Duv8ySSu6E8wIzo736+nFhwSezE7xS2R9/cTPXsIldQ3k/QMl/lIlHuv4B+wXa5bkIXjz
	 PmaJlZRclzWUBwW67VmId18vgKgqZn+HGGbrhrswXofFqtsJqp0yD6Or56PSdbw2JMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579238;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iTRvlW1Imgozypxl1TC1YSxD6mjzvTGyBKwXZxwl9Ok=;
	b=wqNnjQTZLzZafmBGqWVVK1Lklcf3k3PkOFZp/wy1LhmvbW4sNevvGsP4VjoX2bZ5hWVT
	 ZYUOlPjsIKPRRurIKj5tc4Wt/lv4KT6X4eBrnsd2U7jitTe4mWXjXAXCc2Qj5ZecqSYpT
	 B5/F+H3lbgsdXYCYhMEmOKy02bD3NT88Quzvw52X1AZ1qTN7bQmVRehQghrkgwAP+m1pO
	 cb2RW59YuJi9G+QZOvy7UpPORG9W3L0+TfTp1MBoQAxIfDdYb1vZDHr8/irrkdO+R6Jen
	 N+j3NQor1KrLgcJc5xnF43Qgq1I/S516JXUxktHk4GjEIJq3X4E286+7HVAGMV4BUUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G7ZiPhR1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=He456U3e;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F6606A325
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D39F6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G7ZiPhR1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=He456U3e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792579235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTRvlW1Imgozypxl1TC1YSxD6mjzvTGyBKwXZxwl9Ok=;
	b=G7ZiPhR1tRaPFiE5RsvLjPx0OrxQPy6RepS17AQeQ6LZooPWPPV0p/WwtMq3PqVU7n4s0E
	0VdmhzUhhKht2WnDfYjBzO9Cm0xoLYjNnwRHrMYO0/WJYlWO8Vl7Y6Fx+sEg91X9WKr3lK
	E0n1mZszQSnT/Okd12wc5uX5GiV/H/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-8yaZtpUNPCCQXrqiOaJFhQ-1; Wed, 21 Oct 2026 06:40:34 -0400
X-MC-Unique: 8yaZtpUNPCCQXrqiOaJFhQ-1
X-Mimecast-MFC-AGG-ID: 8yaZtpUNPCCQXrqiOaJFhQ_1792579233
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso2967625e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792579233; x=1793184033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTRvlW1Imgozypxl1TC1YSxD6mjzvTGyBKwXZxwl9Ok=;
        b=He456U3eVqQ41Al0wayQYxmtlLUiNVALuoKj2zgr8Vs1nlMpzjAKwVLsWtMLpE++tt
         Rh2iV6UOAc/chs5fGVIOw/miVE0MJAtXTWgk/VvzfcZsdGBqVCVLNPYZkpGw64xNDfa2
         RoknH7+FbjP0E6yiY7Oau6206HYUnUfDEyLN0EqfyBhdMrnHoEXg+AABDO8STCbCsYSL
         vaivakQ8OtIwwtfI4AeUhDluPelhSUtUIT5x85/vKXT8PzbGx/KzO5cX5Fx2Tcabxt6u
         28a8mksjMaG7YZbtNY3o6TrR0ujwXtsouK9+xrlwKPn6+I95veAGfSs9Ul1wYGMVSOxH
         52Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579233; x=1793184033;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTRvlW1Imgozypxl1TC1YSxD6mjzvTGyBKwXZxwl9Ok=;
        b=vNekcDkPb7EOYmjkVsw8Ue+fYww8goLf/ya0yRYi2YZuCqSdMFRZWpOcvu0fSnw0R5
         6Ymjt5V3kKWhNBLu7s7AagaCA8hbBZLqQIl+0HD+amhg4+n1oucXCGo4iq2IBIK4DMhe
         47dmekBuM7B4BDbTbTYJAJ7o9O3GYSoE2uIAMh1IBBbxDArdFzZxxR26mG1KfXfXwnll
         C3gnjSZVhuP6JByln+PmGnTA698vORNWU2M+5KWyVuMqKtidZGck6srCk3r7TvRXBIar
         IuO+k5Qo9FlUboLFfq1m+6wlBTvBqjgCzXrj7duoSaj/6rKK2IZ1oKXwYo8FgwjbNIFN
         A+FQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfZeBbx5dpI/V5gwKazBgArfzTm5uI0pcjF0bfT8lDYNW+m+wBhecpM9CWp7R5d5TxeFOc4kc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCC2SS8jroebESiXIQ7SRrmyt42EZfVjC75aXbvt1PvfE/8s6k
	DxFJ1GIq6EXyYhmUMTXCK/RJNCjik8xQvK1axx3/Wb1kF/TgxydoXaDR5799+tWjas2JgwV+Uhn
	6VX+TADwH/Np12DrASN6SasSD/9Xr/nIC9KCM7jLVGbTb8XYd5bjzrOQ4gw==
X-Gm-Gg: AYBFou0DXHzSg5QD/JqoLXkYj+5IXsU70KnokprncRGhny5cn5xk+o6TVgLS7zHTCU5
	+WgoLJg6cAK3AIPyNCN0CYfrGkuMpp3QYdTdNW4nPDFY9xHj+6SXZ0CiQj9lb7Urkf1Um6pnwKH
	E9V167edAzafzCQvSTCb7xF8+oXdCZ5yQ0rejdpWMsPFEHFbt/3iIbYmYuyGdNFsN1jEmO+v2gi
	o7+mH39y7sI+JqMS460x108nAPJoJu5bLgAj4Qz1luqJBn0aqAXF5SOmj3YKGeelxsMLT0+G5jq
	iB6JZxLNEprrOQBj3ANqtIPTH3wAh6x6rm2BlC8JeM8XgEs4A9x49o07IjSceySJ9WRWX8wzC3H
	YH6pytzDzUdlNO0zzx5qpHiYDzL85ORMdz4JWWtWyIjEbmCkBdIh/9Yh7ft06uaGTmoeaFJXVVw
	==
X-Received: by 2002:a05:600c:8012:b0:4a1:a39b:e75b with SMTP id 5b1f17b1804b1-4a1fdd2434cmr32567205e9.21.1792579233089;
        Wed, 21 Oct 2026 03:40:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8012:b0:4a1:a39b:e75b with SMTP id 5b1f17b1804b1-4a1fdd2434cmr32566655e9.21.1792579232574;
        Wed, 21 Oct 2026 03:40:32 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0d4sm4624532f8f.13.2026.10.21.03.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:40:31 -0700 (PDT)
Message-ID: <944e6740-d91d-4251-be31-aab730a49d43@redhat.com>
Date: Wed, 21 Oct 2026 12:40:30 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: fix transport header for inner IPv4 with IP
 options
To: Hangbin Liu <hangbin.liu@linux.dev>,
 Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lebrun <david.lebrun@uclouvain.be>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Hazley Samsudin <hazleycryilis@gmail.com>,
 Stefano Salsano <stefano.salsano@uniroma2.it>
References: <20261020023336.34-1-andrea.mayer@uniroma2.it>
 <atgWEBZ5J9LQyULx@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <atgWEBZ5J9LQyULx@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 03:32, Hangbin Liu wrote:
> On Tue, Oct 20, 2026 at 04:33:36AM +0200, Andrea Mayer wrote:
>> The End.DT4, End.DT46 (its IPv4 path only) and End.DX4 behaviors set the
>> transport header of the decapsulated IPv4 packet at a fixed 20 bytes, the
>> size of an IPv4 header without options. They do not validate the header
>> length either. With options, the transport header points at the first
>> option byte. The effects include:
>> - ping -R sends an echo request with a 60-byte IPv4 header to a local
>>    address through an End.DT4 or an End.DX4 SID. Since icmp_rcv()
>>    computes the ICMP checksum from the first option byte, the request
>>    fails the check and is counted in IcmpInCsumErrors.
>> - A UDP datagram can reach a port that an iptables rule drops. The rule
>>    checks the UDP header after the full IPv4 header, while the socket
>>    lookup reads it at the fixed 20-byte offset.
>> - With an inbound AH state, ah_input() reads the AH header at the fixed
>>    20-byte offset, but copies the IPv4 header over it with the length in
>>    the IHL field. A packet shorter than that length can make ah_input()
>>    write past the end of the data, into skb_shared_info when the skb has
>>    no tailroom.
>>
>> Validate the inner IPv4 header length with the new helper
>> seg6_validate_iphdr_len() and set the transport header at that length. A
>> packet that is not IPv4, whose header length field is below 5, or whose
>> header is truncated, is dropped with a drop reason. The fix is limited to
>> the header length, which the transport header relies on. Other checks done
>> on IPv4 input, such as the header checksum, the total length and the IP
>> options, are not addressed here.
>>
>> Found by code inspection while reviewing commit 44930446dde4 ("ipv6: seg6:
>> clear IPv4 control block on IPIP decapsulation"), as a pre-existing issue
>> that Sashiko also reported on v2 of that patch. Without this patch, a
>> bpftrace probe on ah_input() shows the reporter's reproducer packet
>> written into skb_shared_info. With it, that packet is dropped before
>> ah_input(), ping -R no longer fails the ICMP checksum, the UDP datagram
>> reaches its real port, and the SRv6 selftests still pass. These effects
>> reproduce on an unmodified kernel, without error injection.
>>
>> Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
>> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
>> Reported-by: Hazley Samsudin <hazleycryilis@gmail.com>
>> Closes: https://lore.kernel.org/netdev/20260809221915.2ffc1ecd0f445fcb70270e31@uniroma2.it/
>> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
>> ---
>>   net/ipv6/seg6_local.c | 56 ++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 48 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
>> index 53f7b2452575..c249f7751d41 100644
>> --- a/net/ipv6/seg6_local.c
>> +++ b/net/ipv6/seg6_local.c
>> @@ -1056,6 +1056,40 @@ static int input_action_end_dx6(struct sk_buff *skb,
>>   	return -EINVAL;
>>   }
>>   
>> +/* Validate the length of the IPv4 header at skb->data (which must point to
>> + * the network header) and report that length, options included.
>> + * Only the version, the header length and the presence of the whole header
>> + * are checked.
>> + * The length is written only when SKB_NOT_DROPPED_YET is returned.
>> + *
>> + * skb pointers may change: after this call, the caller must evaluate again
>> + * any pointer into the packet data.
>> + */
>> +static enum skb_drop_reason
>> +seg6_validate_iphdr_len(struct sk_buff *skb, int *hdrlen)
>> +{
>> +	enum skb_drop_reason reason;
>> +	const struct iphdr *iph;
>> +	int len;
>> +
>> +	reason = pskb_may_pull_reason(skb, sizeof(struct iphdr));
>> +	if (reason)
>> +		return reason;
>> +
>> +	iph = ip_hdr(skb);
>> +	if (iph->version != 4 || iph->ihl < 5)
>> +		return SKB_DROP_REASON_IP_INHDR;
>> +
>> +	len = ip_hdrlen(skb);
>> +
>> +	reason = pskb_may_pull_reason(skb, len);
>> +	if (reason)
>> +		return reason;
>> +
>> +	*hdrlen = len;
>> +	return SKB_NOT_DROPPED_YET;
>> +}
>> +
>>   static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
>>   				       struct sk_buff *skb)
>>   {
>> @@ -1085,14 +1119,18 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
>>   static int input_action_end_dx4(struct sk_buff *skb,
>>   				struct seg6_local_lwt *slwt)
>>   {
>> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>> +	int hdrlen;
>> +
>>   	if (!decap_and_validate(skb, IPPROTO_IPIP))
>>   		goto drop;
>>   
>> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
>> +	reason = seg6_validate_iphdr_len(skb, &hdrlen);
>> +	if (reason)
>>   		goto drop;
>>   
>>   	skb->protocol = htons(ETH_P_IP);
>> -	skb_set_transport_header(skb, sizeof(struct iphdr));
>> +	skb_set_transport_header(skb, hdrlen);
>>   	nf_reset_ct(skb);
>>   
>>   	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
>> @@ -1102,7 +1140,7 @@ static int input_action_end_dx4(struct sk_buff *skb,
>>   
>>   	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
>>   drop:
>> -	kfree_skb(skb);
>> +	kfree_skb_reason(skb, reason);
>>   	return -EINVAL;
>>   }
>>   
>> @@ -1234,6 +1272,7 @@ static struct net_device *end_dt_get_vrf_rcu(struct sk_buff *skb,
>>   static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
>>   				       struct seg6_local_lwt *slwt, u16 family)
>>   {
>> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
> 
> Nit: We can use SKB_DR(reason) without the long definition.
> 
>>   	struct seg6_end_dt_info *info = &slwt->dt_info;
>>   	struct net_device *vrf;
>>   	__be16 protocol;
>> @@ -1246,7 +1285,9 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
>>   	switch (family) {
>>   	case AF_INET:
>>   		protocol = htons(ETH_P_IP);
>> -		hdrlen = sizeof(struct iphdr);
>> +		reason = seg6_validate_iphdr_len(skb, &hdrlen);
>> +		if (unlikely(reason))
>> +			goto drop;
>>   		break;
>>   	case AF_INET6:
>>   		protocol = htons(ETH_P_IPV6);
>> @@ -1260,6 +1301,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
>>   
>>   	if (unlikely(info->family != AF_UNSPEC && info->family != family)) {
>>   		pr_warn_once("seg6local: SRv6 End.DT* family mismatch");
>> +		reason = SKB_DROP_REASON_NOT_SPECIFIED;
>>   		goto drop;
>>   	}
> 
> And maybe move this checking upper before switch(), then we don't need
> to reset reason.
I think both suggestions make sense, please send a v2.

Thanks,

Paolo

