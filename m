Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374541;
	b=2KN2einCEwuKbnW0M0mF1kW9fegNOnRfh859wLtasEpA3dvLm+0J3hEsLCzFXQOUmf68
	 1c/TjsqxxUMLHHO/bmhnqls/jQRdoCJ1L37M51ey8SfI486R6TWpzu38W1rt8GcysbYJn
	 1KusRsEbV/hVKaHqUpdlyY8JBXqaLXWKHGW8PDLaWxhMNYmT5rsbTuFh2xgCI/by3sT6y
	 BeQEYlx+6TF02JAkaqwmhr3EwZiUo7NblinLb3xhZOFLSON1TknDv2MZLssSmg/lRRLoZ
	 qrvZ+DCICZ04RyHzF5LTVnvSDJoQygiXEbjL0REkV5kf/DQ/ccFl7rZp28NJLZkr3Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374541;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fMxdmQyFME9L1n77Z81SAQMq62mqaAtJxwWzXEaVgck=;
	b=gcUYIY7RhWm1+8eyuy6AlRZgJ6qfoYWc9GYpwG++8YkqSar2y5ib51RCBhL4cvHkpVQQ
	 V7i2jX1kf63U1kOj5ft5t42QGaWmKSwUM04SIYEmz+xq1mt3cTpJoKcduZRkT75xn06b2
	 +eoxFyeBgv0CFUOnb8V7VDMky4cDIwSQV1HQlZcDvAzK3yprW76vMRb8xrIWJrRvM5o0q
	 RK2t9yDq8t8kq0MYChhqa9JCGQS4R0XzHGC6cPCf9raEcsZIohGnkqxtF0waTsmoLZB9j
	 QfMUYigSAXf8bGFW9xW6j6oe6QvfFKxpsVSf59Z3Nkle6vwuhfRTDTicETI/WxZ8srw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ovn.org;
	spf=pass smtp.mailfrom=fe-bounces.ovn.org;
	dkim=pass header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=g4KvcOil;
	arc=none smtp.remote-ip=149.28.215.223
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFC606A326
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFFC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=g4KvcOil
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1793374534;
 bh=fMxdmQyFME9L1n77Z81SAQMq62mqaAtJxwWzXEaVgck=;
 b=g4KvcOilBhN3qVzxsrDZG+Ed0eBq9VYlyGevNYMGQbQ5af/AgTjaYDjq1OrUm0Giq8xrLIbuT
 INEBeW0TXjwFXKpXgsdHe5dJqUInglX3Y47UDhCQJLB6AQRhKZt1enR7GTr4Rtj6WhVcgjUrp85
 6MBw8VQSvM7MXVih2vdPzDs=
X-Forward-Email-ID: 6ae4b93f7a1ddf7160eb7c98
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9a29aa0d-81ca-4406-83bf-ccbe55d0b2fa@ovn.org>
Date: Fri, 30 Oct 2026 16:35:23 +0100
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
Subject: Re: [PATCH] net: openvswitch: make transport checksums writable
To: Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Cc: Kyle Zeng <kylebot@openai.com>, dev@openvswitch.org,
 Eelco Chaudron <echaudro@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
References: <20261030042304.74291-1-kylebot@openai.com>
 <be4ec40b-ed32-41e3-b564-2acfc63f651f@ovn.org>
 <f7ta4nvjl2x.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <f7ta4nvjl2x.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 3:53 PM, Aaron Conole wrote:
> Ilya Maximets <i.maximets@ovn.org> writes:
> 
>> On 10/30/26 5:23 AM, Kyle Zeng wrote:
>>> An IP address rewrite can execute even if the transport-header pull in
>>> key_extract_l3l4() failed. In that case the transport key is cleared,
>>> but the IP protocol and transport offset remain available. The address
>>> rewrite helpers check the total skb length before updating the transport
>>> checksum. This does not guarantee that the checksum is in the linear
>>> head, or that it is writable.
>>>
>>> A non-linear IPv6 packet with a long, valid extension-header chain can
>>> therefore cause an out-of-bounds checksum read/modify/write when the
>>> GFP_ATOMIC head expansion fails. KASAN reports the access in
>>> inet_proto_csum_replace16(). The IPv4 TCP/UDP and IPv6 TCP/UDP/ICMPv6
>>> address rewrite paths all have the same missing check.
>>
>> While sending patches, make sure you Cc all maintainers.  And you need
>> to specify the target tree, which is 'net' in this case.
>>
>>>
>>> Make the applicable transport header writable before changing an
>>> address, and propagate failure through the existing action error path.
>>> Reload cached network-header and address pointers after the operation,
>>> since it can move the skb head. Preserve the existing behavior for
>>> unchanged addresses, truncated transport headers, non-first fragments,
>>> and IPv6 destination rewrites that do not affect the pseudo-header.
>>>
>>> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
>>> Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
>>> Signed-off-by: Kyle Zeng <kylebot@openai.com>
>>> ---
>>> I have a reproducer for this issue and can share via DM
>>>
>>>  net/openvswitch/actions.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>
>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>> index 12e339cbf791..36c2a1963222 100644
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>> @@ -319,6 +319,35 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
>>>  	return 0;
>>>  }
>>>  
>>> +static int ensure_l4_checksum_writable(struct sk_buff *skb, u8 l4_proto)
>>> +{
>>> +	unsigned int offset, len;
>>> +
>>> +	switch (l4_proto) {
>>> +	case IPPROTO_TCP:
>>> +		len = sizeof(struct tcphdr);
>>> +		break;
>>> +	case IPPROTO_UDP:
>>> +		len = sizeof(struct udphdr);
>>> +		break;
>>> +	case IPPROTO_ICMPV6:
>>> +		len = sizeof(struct icmp6hdr);
>>> +		break;
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +
>>> +	offset = skb_transport_offset(skb);
>>> +	if (unlikely(offset > skb->len))
>>> +		return -EINVAL;
>>> +
>>> +	/* Truncated transport headers have no checksum to update. */
>>> +	if (unlikely(skb->len - offset < len))
>>> +		return 0;
>>
>> All the checks above are already executed at different places on the same
>> path.  With this and the new checks in set_ipv4(), the l4 protocol is
>> checked at least 3 times for no good reason.
>>
>> While inability to update L3 header is fatal for set_ipv4/6(), failure to
>> update L4 checksum should not be.  And so, there is no point propagating
>> the error.  If the header doesn't exist - there is nothing to update.  And
>> if we ran out of memory trying to expand the linear parts of the skb, then
>> we have a more significant problem at hand than a non-updated L4 checksum.
>> In the worst case, the destination will just drop the packet.
> 
> Agreed.
> 
> We already do an skb_ensure_writable() on entry into the set_ipv(4/6)
> functions that covers the IP header portion.  It's probably too early
> there to try pulling, unless we want to bleed protocol details up one
> level, and propagate down whether or not something like a pskb_may_pull
> had an error (to skip updating the l4 region).  That would mean doing
> the re-assignment of nh once.
> 
>> Can we just replace trnasport_len checks with skb_ensure_writable()?
> 
> If we do that, the nh can become stale within the scope of the
> set_ip_addr function, too, I think (skb_ensure_writable inside
> update_l4_* functions pulls and potentially unclones the head to a new
> region).  So we might have to change the set_ip_* functions to fetch and
> re-fetch their own header details.

Yep.  We could drop the 'nh' argument from set_ip_addr and make it just
use ip_hdr() directly in place of it.

> 
>> It sounds like that would be sufficient here.  And re-fetch the 'nh'
>> pointers right after the set_ipv4/6() calls with an inline comment like
>> this:
>>
>> @@ -481,6 +480,7 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
>>                 if (unlikely(new_addr != nh->saddr)) {
>>                         set_ip_addr(skb, nh, &nh->saddr, new_addr);
>>                         flow_key->ipv4.addr.src = new_addr;
>> +                       nh = ip_hdr(skb); /* Potentially reallocated. */
>>                 }
>>         }
>>         if (mask->ipv4_dst) {
>> ---
>>
>> Creating a separate function with all the duplicated checks doesn't make
>> much sense to me.
> 
> +1
> 
> My personal preference is to do the header movement once at the start,
> since it keeps the write paths looking cleaner - but I don't know if
> there's really a performance cost in some traffic cases.
I'm not sure I understand what you're suggesting here.  Could you elaborate
or give an example?

Best regards, Ilya Maximets.
