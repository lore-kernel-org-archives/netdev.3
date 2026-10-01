Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1549E142
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856046; cv=none; b=ohMhqf8ZG/Yg1Xl4s/4RH3VLb8j2bZR1+5wTfRzj5iORSwBaRcU6yPchsEA23xyRkeskBkj+7UG9d7Vhb4hAF7WpFGaaAwvvq/GV2McNcbHm/6Pkx9Qlc0+dd+hNAVIRUsYOoGtaFQU7dQy72ELp2t7CFZRsXlSS6TDt0z+xxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856046; c=relaxed/simple;
	bh=DsRYQb5jZzAgoPoOn4fjcMyks50gikfjpN2QYlVYmCc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zy8DdXuM4RfW169aSZLDJvKwHIUtX4irwwBgBNRmSK3NgKlB5RWQkURsb91OQs9CSy7PuvByNBWag5q3GVQfANUM1zmswKOBccOiGSQvzX0dpzvemSqAmBWk8Jtk82UNHIPNfEN8LjcIRdCLCZRJnxvf+DaHS5wzUUyiMgD+KKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=FbHLKZZq; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="FbHLKZZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 To: Subject: Cc: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1790856040;
 bh=nFuni006nQd4Bqcc1i0hXPOqN2IhX8PKb1h1I5WAhZQ=;
 b=FbHLKZZq4NG49j4BePR55HEwwzActNTTPenU1Ha1snDuRZS3OJKK7euNhchBKRj7N71cOO3Qb
 hlPOTJIEHljeWELDinEaiSUp527zbTV/5UXTGZoTgJvpJVvY4Iol2bxTZEIsvmmvfEBklCu7qoD
 0huQ/fyiYLrPz5EP6QdMgGc=
X-Forward-Email-ID: 6abe4b670a5cc7becf3754b6
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.16.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a9480ea8-314f-478f-ae9d-b8262600e2ad@ovn.org>
Date: Thu, 1 Oct 2026 14:00:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: dev@openvswitch.org, jesse@nicira.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, echaudro@redhat.com, aconole@redhat.com,
 syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: validate transport header
 presence in set_ipv6_addr
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
References: <20261001085205.3822-1-fmancera@suse.de>
 <50b0db80-7d42-44fc-81eb-d0fed8047871@ovn.org>
 <7590af05-e95a-4b34-9216-26e770bdfaaa@suse.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <7590af05-e95a-4b34-9216-26e770bdfaaa@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/26 1:20 PM, Fernando Fernandez Mancera via dev wrote:
> On 10/1/26 1:15 PM, Ilya Maximets wrote:
>> On 10/1/26 10:52 AM, Fernando Fernandez Mancera wrote:
>>> When executing IPv6 address rewrite actions on IPv6 fragments,
>>> set_ipv6_addr() might attempt to recalculate the L4 header checksum
>>> calling skb_transport_header() with an uninitialized transport header.
>>> This can potentially lead to a OOB write.
>>
>> Not really.  later fragments have l4_proto set to NEXTHDR_FRAGMENT
>> and so no writes will be performed.  See parse_ipv6hdr().
>>
> 
> Oh, I didn't notice that. In that case, this is harmless. I will update 
> the commit message, thanks!
> 

[...]

>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>> index dc5ff859f114..a14668565ec4 100644
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>> @@ -395,7 +395,7 @@ static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
>>>   			  __be32 addr[4], const __be32 new_addr[4],
>>>   			  bool recalculate_csum)
>>>   {
>>> -	if (recalculate_csum)
>>> +	if (recalculate_csum && skb_transport_header_was_set(skb))
>>>   		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
>> I'd suggest moving the check into update_ipv6_checksum() and maybe add
>> a small comment that the check is only to avoid warning on reading the
>> offset that wasn't set, offset must always be set for any l4_proto for
>> which the checksum is actually getting updated.
>>
> 
> Will do that. Thanks Ilya.
Actually, it might be better to check for NEXTHDR_FRAGMENT and return
early only in this case.  This way if we ever have the offset missing
for any l4_ptoto that needs it, we'll still get a warning instead of
silently not updating the checksum.  This will be close to what the
update_ip_l4_checksum() is doing.

At the same time, update_ip_l4_checksum() is able to get the transport
offset without a warning, so another alternative is to actually set the
transport offset in parse_ipv6hdr() to something like frag_off, which
would closer match the behavior of ipv4 where check_iphdr() sets the
transport header unconditionally to the next byte after the network header.
This is fine because transport headers are never accessed when they are
not set in the key.  The network checksum update cases are the only ones
where the actions are even allowed to execute and touch higher level
headers that may not be present in the packet.  At the same time the
frag_off is kind of an arbitrary value, so I'm not sure.

WDYT?

Eelco, Aaron, do you maybe have a preference?

Best regards, Ilya Maximets.
