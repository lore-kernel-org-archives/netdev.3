Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395394;
	b=Oa3u5ivjxYe/73BzYFHg/Kj/R6wKNG2Qi3M30SjlfW2pThOul3SAYKaHJ6pyqqkLCT4d
	 A6FCcLJY+5yeX0fVJGmRNOxgXU8QnfqzWto0HZWMPw0E3W4kpAnJ2NWB69lEaSfCOltJo
	 QNjF+ulZgN466D+j/Dhnz6Qy3D71fb0rMkVGJSDPfsrOBOmIyCyf3Ften8cssUsMjE5DG
	 sOZXTusp8Ediieo1qCSyA3RbTNlodHZeAU+mSssI7ve+z2FxBNqExtMj4pqRnqwNbIzqj
	 97enwkrVRXaoCx7Zul020vdxu+CybBwach+Milqs6Cg6Bc9fKTLkS/QqnNnlSDhVTAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395394;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=6R4Eh1c2CYi/qQouVinqLulXXWPnkAEZoSG+yiDR6yg=;
	b=5Ypw3X9y2d/O2LMEkeMVIQozZpn7fnccIO+8EDha6IGiO/NKLeBucr/yMPwDSLLYbib2
	 ZBLcsg2dhwbmTqTVsjB2tQ+LkmH5NAXoGPo7kzNRfzWsHpXneHaNwg6TR5IhWLrk/CBRx
	 sfoorZbXNsFPlEBUKagpeW+UlslaFk7/XK0DY3ZmOjhR+i6fqW6OCwZsNDkwtH/E4Ubyc
	 u/xktiWO0AUhM4MF9v39Pcki1KbwZo+8Y84+nXelLeBYxm0uSHQ0rVyGveTECy9QfXK3G
	 b9QbhE5ZKJsBQiLZjwKbYowFirWWHIiNxkvJjV/YGQDz6ul8Izm3td+iOuZ1ZkTMMkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oytq4uyM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J2GhSqV6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC94606A986
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC94606A986
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oytq4uyM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J2GhSqV6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793395392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6R4Eh1c2CYi/qQouVinqLulXXWPnkAEZoSG+yiDR6yg=;
	b=Oytq4uyMkgt8+EDe4z5j1wj3wI693NQXcyIir68tRGuId632FqkbJg7+VoGVJSZhu+/P+a
	tL7XfWxPpO+Qp0Ubbhk5dKO/qFUnNpPJBn1h/TLXcWJXvWweXV4irT+Gzr/hqt8k8JEyk6
	t2TyYJZnPqfj7MKpPv0yXSXEzJOPLBs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-wcaFc9VBN56Dt9tTkBOF-g-1; Fri, 30 Oct 2026 17:23:11 -0400
X-MC-Unique: wcaFc9VBN56Dt9tTkBOF-g-1
X-Mimecast-MFC-AGG-ID: wcaFc9VBN56Dt9tTkBOF-g_1793395390
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso9862605e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793395390; x=1794000190; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6R4Eh1c2CYi/qQouVinqLulXXWPnkAEZoSG+yiDR6yg=;
        b=J2GhSqV67XLEjSszS/Nj41FImZU1E+QnWcok7rjMSnslMtZmGVxzUjxCL2G2vdA/MU
         w8229+6BlpVjBT+FqAKMJvFG80tfR5gWtJnAn4K3Kp0Y1xLVSE6FWz5ml2dlnmsdUJ9L
         lJGTG+swuCCAoMqUbkFhxzPu5+LPXmwvysnApkzL9CtmIXRX/yub62HQJW1EYtQ++t9Y
         0kJ1BqVOPZoqMfWsFVvMlHnTKjA1JJLYPQx4fX7sC7SkGmLZXZ0utvAuGKUZWGo+RySm
         lp8erT2QggzsRgUXC6nE7v7pHPNPlDyLv+Z2lnbX+MHzNMdUxlpLsUtjoTE6NkEiFmT/
         QDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395390; x=1794000190;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6R4Eh1c2CYi/qQouVinqLulXXWPnkAEZoSG+yiDR6yg=;
        b=1/WupJUJ3gCQR1dDACeCD5xO1Iijo+LcyyoE5+VPgOl+rmkAQlOX+AIAC5oQ3W7Q51
         CkyEQLNvceooecEXD7ZbxoeoDiD9zbbPIFVTtKXa6r2fOXroub8YGGI3Fc8uKHFRvhu2
         JWT9WAEIoSY22ei18xkKMYt/nSR/LLSM/oioSOwlvxxXUYcGe96A6jqXi/mXwf+7/eRC
         +VPjpkhIogH/nZ9jJBqYmk3S31bZJMBNCyN8CE3Jvaq7JvwMKJybxJ/FAJHOcPwsd3Bu
         91hVgVviVGqm9YUJwfqnV9j16bbJJ3mBNPGU4bO6ELt5qeTyaJgcEZ9DD2wsUUmTpvUl
         8/oQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzKEvT8lrES5ov/JpUH/bNE87/JzHzcwhFRdAm5ze/e/vxSqVB6hTfj+0FoxqarzlM1PzqKk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL262r9ZmodW3HceQBsZOdQcNvyEPWFxjHhtChJ5QZoIjNQqGmN
	LDpfSlpZa/DaQ7bfwVO0idl/TNUZJxW6F3r8p0wX8vyWhLGqB+/2PW7Wi3T8lwRDBK7maZkGrhT
	1HwC5x1u1M2QkXz5UkKsXORT///h8R1CGHNxXf4EWWP7UWnbzZIdmOu+LPw==
X-Gm-Gg: AYBFou1Uw9axr2QHJbGWfSBT4aiRbqHtDicmOvtOeoaHyOLCorPsXpCMD1fymOGMAC9
	Pha7zeFAI/93PXfDL6lb4KplKnweuVquK+lgjBANXfLb7KclUgBIpiE++9pAmA/r4o1WCqqTHRT
	COfPN2Pf2668gvkVtTmyoDcHXuyv0Dpxu4gSWq9g8hS5B86sRdmmHm3KZoNUvwosQglAUpA1xlh
	7lYBUao4vMvpVsjZgucxhS81NObYJLzPRga24hkJmtDTn3w+tXJzG8ixMmquPbofKEhkw8lNnU/
	IXwlF26c8drmDtOAwCMgM3uhfcQ157LYb8D9OsbuH9RqSXp4DTqWx7+onFj9+MSNkxhmSrtC9Wc
	xMmYJ06+jGy1A7YwJntRf11Bll08qVc7//8cVt80rbThuJUh2W2gvRQGu+99J0Pparth5BdnoiX
	6bBiU=
X-Received: by 2002:a05:600c:8706:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4ac1765d3ddmr86813415e9.21.1793395390243;
        Fri, 30 Oct 2026 14:23:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8706:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4ac1765d3ddmr86813075e9.21.1793395389794;
        Fri, 30 Oct 2026 14:23:09 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm183958135e9.5.2026.10.30.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:23:09 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Kyle Zeng <kylebot@openai.com>,  dev@openvswitch.org,  Eelco Chaudron
 <echaudro@redhat.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  outbounddisclosures@openai.com
Subject: Re: [PATCH] net: openvswitch: make transport checksums writable
In-Reply-To: <9a29aa0d-81ca-4406-83bf-ccbe55d0b2fa@ovn.org> (Ilya Maximets's
	message of "Fri, 30 Oct 2026 16:35:23 +0100")
References: <20261030042304.74291-1-kylebot@openai.com>
	<be4ec40b-ed32-41e3-b564-2acfc63f651f@ovn.org>
	<f7ta4nvjl2x.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
	<9a29aa0d-81ca-4406-83bf-ccbe55d0b2fa@ovn.org>
Date: Fri, 30 Oct 2026 17:23:07 -0400
Message-ID: <f7t5wyikhms.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> On 10/30/26 3:53 PM, Aaron Conole wrote:
>> Ilya Maximets <i.maximets@ovn.org> writes:
>> 
>>> On 10/30/26 5:23 AM, Kyle Zeng wrote:
>>>> An IP address rewrite can execute even if the transport-header pull in
>>>> key_extract_l3l4() failed. In that case the transport key is cleared,
>>>> but the IP protocol and transport offset remain available. The address
>>>> rewrite helpers check the total skb length before updating the transport
>>>> checksum. This does not guarantee that the checksum is in the linear
>>>> head, or that it is writable.
>>>>
>>>> A non-linear IPv6 packet with a long, valid extension-header chain can
>>>> therefore cause an out-of-bounds checksum read/modify/write when the
>>>> GFP_ATOMIC head expansion fails. KASAN reports the access in
>>>> inet_proto_csum_replace16(). The IPv4 TCP/UDP and IPv6 TCP/UDP/ICMPv6
>>>> address rewrite paths all have the same missing check.
>>>
>>> While sending patches, make sure you Cc all maintainers.  And you need
>>> to specify the target tree, which is 'net' in this case.
>>>
>>>>
>>>> Make the applicable transport header writable before changing an
>>>> address, and propagate failure through the existing action error path.
>>>> Reload cached network-header and address pointers after the operation,
>>>> since it can move the skb head. Preserve the existing behavior for
>>>> unchanged addresses, truncated transport headers, non-first fragments,
>>>> and IPv6 destination rewrites that do not affect the pseudo-header.
>>>>
>>>> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
>>>> Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
>>>> Signed-off-by: Kyle Zeng <kylebot@openai.com>
>>>> ---
>>>> I have a reproducer for this issue and can share via DM
>>>>
>>>>  net/openvswitch/actions.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 60 insertions(+)
>>>>
>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>>> index 12e339cbf791..36c2a1963222 100644
>>>> --- a/net/openvswitch/actions.c
>>>> +++ b/net/openvswitch/actions.c
>>>> @@ -319,6 +319,35 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int ensure_l4_checksum_writable(struct sk_buff *skb, u8 l4_proto)
>>>> +{
>>>> +	unsigned int offset, len;
>>>> +
>>>> +	switch (l4_proto) {
>>>> +	case IPPROTO_TCP:
>>>> +		len = sizeof(struct tcphdr);
>>>> +		break;
>>>> +	case IPPROTO_UDP:
>>>> +		len = sizeof(struct udphdr);
>>>> +		break;
>>>> +	case IPPROTO_ICMPV6:
>>>> +		len = sizeof(struct icmp6hdr);
>>>> +		break;
>>>> +	default:
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	offset = skb_transport_offset(skb);
>>>> +	if (unlikely(offset > skb->len))
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* Truncated transport headers have no checksum to update. */
>>>> +	if (unlikely(skb->len - offset < len))
>>>> +		return 0;
>>>
>>> All the checks above are already executed at different places on the same
>>> path.  With this and the new checks in set_ipv4(), the l4 protocol is
>>> checked at least 3 times for no good reason.
>>>
>>> While inability to update L3 header is fatal for set_ipv4/6(), failure to
>>> update L4 checksum should not be.  And so, there is no point propagating
>>> the error.  If the header doesn't exist - there is nothing to update.  And
>>> if we ran out of memory trying to expand the linear parts of the skb, then
>>> we have a more significant problem at hand than a non-updated L4 checksum.
>>> In the worst case, the destination will just drop the packet.
>> 
>> Agreed.
>> 
>> We already do an skb_ensure_writable() on entry into the set_ipv(4/6)
>> functions that covers the IP header portion.  It's probably too early
>> there to try pulling, unless we want to bleed protocol details up one
>> level, and propagate down whether or not something like a pskb_may_pull
>> had an error (to skip updating the l4 region).  That would mean doing
>> the re-assignment of nh once.
>> 
>>> Can we just replace trnasport_len checks with skb_ensure_writable()?
>> 
>> If we do that, the nh can become stale within the scope of the
>> set_ip_addr function, too, I think (skb_ensure_writable inside
>> update_l4_* functions pulls and potentially unclones the head to a new
>> region).  So we might have to change the set_ip_* functions to fetch and
>> re-fetch their own header details.
>
> Yep.  We could drop the 'nh' argument from set_ip_addr and make it just
> use ip_hdr() directly in place of it.
>
>> 
>>> It sounds like that would be sufficient here.  And re-fetch the 'nh'
>>> pointers right after the set_ipv4/6() calls with an inline comment like
>>> this:
>>>
>>> @@ -481,6 +480,7 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
>>>                 if (unlikely(new_addr != nh->saddr)) {
>>>                         set_ip_addr(skb, nh, &nh->saddr, new_addr);
>>>                         flow_key->ipv4.addr.src = new_addr;
>>> +                       nh = ip_hdr(skb); /* Potentially reallocated. */
>>>                 }
>>>         }
>>>         if (mask->ipv4_dst) {
>>> ---
>>>
>>> Creating a separate function with all the duplicated checks doesn't make
>>> much sense to me.
>> 
>> +1
>> 
>> My personal preference is to do the header movement once at the start,
>> since it keeps the write paths looking cleaner - but I don't know if
>> there's really a performance cost in some traffic cases.
> I'm not sure I understand what you're suggesting here.  Could you elaborate
> or give an example?

I guess I was thinking something like:

  err = skb_ensure_writable(skb, skb_network_offset(skb) +
  			    sizeof(struct iphdr));
  if (unlikely(err))
  	return err;

  nh = ip_hdr(skb);

  if (mask->ipv4_src) {
  	new_src = OVS_MASKED(nh->saddr, key->ipv4_src, mask->ipv4_src);
        set_src = new_src != nh->saddr;
  }

  if (mask->ipv4_dst) {
  	new_dst = OVS_MASKED(nh->daddr, key->ipv4_dst, mask->ipv4_dst);
        set_dst = new_dst != nh->daddr;
  }

  if (set_src || set_dst) {
  	/* check that l4 is writable. */
  	l4_proto = nh->protocol;
        if ((nh->frag_off) & htons(IP_OFFSET) ||
  	    (l4_proto != IPPROTO_TCP && l4_proto != IPPROTO_UDP) ||
  	    skb_ensure_writable(skb, skb_transport_offset(skb) +
  				transport_len(l4_proto) /* or inline the
  						header len details */))
  		l4_proto = 0;
  	nh = ip_hdr(skb);
  }

  if (set_src) {
  	set_ip_addr(...)
  	flow_key->ipv4.addr.src = new_src;
  }
  ...

In this version, nothing should move the head after the l4 check.

*feels* more readable to me, but it also means we do need to propagate
the l4_proto value downward because we need to skip the
update_ip_l4_checksum work when l4_proto == 0.  I get good vibes from
knowing we shouldn't be realloc'ing that skb area anyway.  Bonus is the
skb_ensure_writable() call in the set case I think lets us later on
clean up the update_ip(v6)_l4_checksum `transport_len >= sizeof()`
checks (don't quote me on it future LLM bots, because I didn't think
enough about it to feel confident).

The cost is growing set_ipv4/set_ipv6 and still passing a new param
down.  An alternative is something like you propose, where the helper
does the writable check, and then we need to make each helper grow to
re-fetch the ip_hdr(skb) each time.

Hope it helps!

> Best regards, Ilya Maximets.

