Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372046;
	b=aTskOJD1LUac8LGjDQjFz1FMaOEmak+eRGFPMVWV/2YlvLV12YGVuo5o3yJwgbFmzlLX
	 kda53lvQPxwdnL41kJ1JJYDk/URrIhawgtWe/zlZr8IdxapfChovtUYb0CMF3Rc630UAu
	 dzra4gmQGMXm4H+2Z6Zxwpv6M3VxzbSvleTssI0YhbQeZ23y9CctMpwos5jrXvbvAc8iD
	 N57+f1sPjVHoZzci8LzFtiHiGtMj3mVfb7dIaiDUsnQi6ei4vRDjGhPsUu2jrRqkRX0+1
	 urAdxlf6ZaFQAFwZga5D9eNmDVlXXSq5vRwbYMU59K0h+q0CyU2ssb6Y8ZE6tiunlOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372046;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=l7b3Rt9KsyD20sEFrYceYL9FwdiAGUDQLXUQjCHhxRk=;
	b=atpwjQNoYIowFPhtTSXtFmDO3okuY92hGT3/UWer731jtqfDayI9gYmvuyJje1TyQ2sx
	 B+idRgjYgyiL6EAI1ibd1bYBSgTCSuDrF5YC6F2+odLdHN4usWdzAVpheKkADKT8mAaoT
	 BFL/TW9QIPLMEhNakbRzEW444Gxcd1U1jg9CAEfOaIcj7sTHZLVD6R7km4jb1Hiy7hTNG
	 w1U/mjPnNpxeA07iUGBkBYlNYCkPg5yE6cIfl0NpGBCsmxZkEvjwNka5iWQ9WXtIeBtJh
	 iPyTpSK0Z86sr4qTF9iszkGUqU04TToFXFV2Fkfs5KFTa1/KkG3FP35QroMvfso3Gmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="IIukBo/N";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XidFy1Nv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD652606A33B
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD652606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IIukBo/N;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XidFy1Nv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793372044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l7b3Rt9KsyD20sEFrYceYL9FwdiAGUDQLXUQjCHhxRk=;
	b=IIukBo/NYVFgPG7q1xEaz7qJnrOJKrzCDPNtAhlUEimUQeppVDVToNhhqkf/7n7vhvdnrz
	POV5uvndBFcqacy2K6BBxmqFX9gsddv0D69bbeeaaVrHZBdikLmb29xAkKK5NKphwLwjtd
	Rjs5egRNYD498+bY9ViwLVdSvUXYuMA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-gfklll57NNKZAMR8wvk3vQ-1; Fri, 30 Oct 2026 10:54:03 -0400
X-MC-Unique: gfklll57NNKZAMR8wvk3vQ-1
X-Mimecast-MFC-AGG-ID: gfklll57NNKZAMR8wvk3vQ_1793372042
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so669755f8f.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793372042; x=1793976842; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l7b3Rt9KsyD20sEFrYceYL9FwdiAGUDQLXUQjCHhxRk=;
        b=XidFy1NvYI8DSJjQiL7Oq0U2zAs4jTJH2bpl+BoebZ33QPabeiuRK4OS3Glxmat6iA
         NTOEyg0rE/3aBGcyr88rk9HAQ6CulH/ZQEicnm8FElgEAsz3DFhDNRXIF7PvbkBy6jJ4
         6+HA0IKhWVIGkgZhRj1B8Lh0zUbTLVgs+TtuFt55t4HT2w9JqImo8j57Eg2/OKyHFyQI
         zaqPF3qOQNM3lO+nW6DQQeYZtZyZ8bCf1Al6f4vEjdn5gIps/IlA+2ub7MBIPLDui8xW
         vL4+eI0RSs+ZbNT3cFp1Yfk1uiu0iaxBY8K0+wNjp4WeFzbGHZx5GFOkP4Ut0c0evfjF
         50wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793372042; x=1793976842;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l7b3Rt9KsyD20sEFrYceYL9FwdiAGUDQLXUQjCHhxRk=;
        b=aQ3GxqK7jkaDJgqA4n16cvAdrSj+CwX0C+zFlrsTsbyNbJC8mNU8ntYts8+BecnG5Y
         6EJ1kA8078ZhWxKFiv2T/lQ+s6zI8qrn0A+3UiDCuEg6fGnBHefW9lEUdyEiRnAM+hH2
         +vAfjVTpL9I6R89DvHuoJXbI79IT2PbTyHNijAim0Heg9qXXKCbSbhMSqLjXKM9dLZml
         yKKxhCtNDTCJA9XU7ees6HlFzr/0AD4wFWwv+aAGEh7A0tBcohRlo7hm+qKCvFRXgvyH
         lAsfw+vNxJpADYoHvWme+Uhvzrf5oFO3pwDbhFW/3hPOWii+wMNmHeQiOpbORIQh+cSK
         xJXg==
X-Forwarded-Encrypted: i=1; AKwUvBwNLzl6dsiSV1x7aifEddvZmBdOpE9k5T66q1fBY1U+6QCL5/+YlUvt3NkoZvTLuh6hCHAqL3Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiPYsi+B8lgCZ9LlpDnupxVlba2wk2+1UlTC8Npt+53UTG3OFO
	MBc3lnG16ZkzUU8lxL3lAKszKi1Fuqv2QLXnGcGQf18Pz5I9INkbP6mh5lXvzk3qKss4OXwro/H
	UHQxSam+XYO3zTWhJyrd4ZHhX9+Qz5U0Yi1k/T53orBEQ9qJ9JtqvHcQYJg==
X-Gm-Gg: AYBFou2ciH/PoXiEYpAVq9slLnvGEqsoyQi0WdfpoKNMlot7CazZYYuptNrIcG+GEIa
	b1Uk4LhfD9Vi3mcmES2KoP44buoqPTBxRrz7DbXvd9hIJPQ53sZfjxoOF3H4qjBGGwesy1+KUjv
	jKKVoZxLH8VavIs1EBQVrvB+kYuoiznEk22atrQeX0tGOss8gnfzG79AReYoNIaWDE2CXOLvo4H
	LYYAJcqCo0NR2sGJF9hr7cU3chHRd460nstYoEON9BRtIXywbUSYUiGMCs7M+vGjcxErDggvtPf
	Pnf7ri0SxuaOCxboRcRjIBNQcZqhR+mxI2tGTKxpQ7i7UThjxp7kkfLhB/+LmFaOpWpMFysSj4C
	26jkNr8JM6Hr+jTE+PzoEzhxIZ2hwSzBHiNTcdC7guwOBL+a+/ojq6SpXdaRVl6jO0gn9EvsRcQ
	dNv+g=
X-Received: by 2002:a05:600c:c16a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4ac18c74638mr54262205e9.27.1793372041986;
        Fri, 30 Oct 2026 07:54:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c16a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4ac18c74638mr54261755e9.27.1793372041582;
        Fri, 30 Oct 2026 07:54:01 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09fadb75sm38598755e9.3.2026.10.30.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:54:00 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Kyle Zeng <kylebot@openai.com>,  dev@openvswitch.org,  Eelco Chaudron
 <echaudro@redhat.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  outbounddisclosures@openai.com
Subject: Re: [PATCH] net: openvswitch: make transport checksums writable
In-Reply-To: <be4ec40b-ed32-41e3-b564-2acfc63f651f@ovn.org> (Ilya Maximets's
	message of "Fri, 30 Oct 2026 12:28:04 +0100")
References: <20261030042304.74291-1-kylebot@openai.com>
	<be4ec40b-ed32-41e3-b564-2acfc63f651f@ovn.org>
Date: Fri, 30 Oct 2026 10:53:58 -0400
Message-ID: <f7ta4nvjl2x.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
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

> On 10/30/26 5:23 AM, Kyle Zeng wrote:
>> An IP address rewrite can execute even if the transport-header pull in
>> key_extract_l3l4() failed. In that case the transport key is cleared,
>> but the IP protocol and transport offset remain available. The address
>> rewrite helpers check the total skb length before updating the transport
>> checksum. This does not guarantee that the checksum is in the linear
>> head, or that it is writable.
>> 
>> A non-linear IPv6 packet with a long, valid extension-header chain can
>> therefore cause an out-of-bounds checksum read/modify/write when the
>> GFP_ATOMIC head expansion fails. KASAN reports the access in
>> inet_proto_csum_replace16(). The IPv4 TCP/UDP and IPv6 TCP/UDP/ICMPv6
>> address rewrite paths all have the same missing check.
>
> While sending patches, make sure you Cc all maintainers.  And you need
> to specify the target tree, which is 'net' in this case.
>
>> 
>> Make the applicable transport header writable before changing an
>> address, and propagate failure through the existing action error path.
>> Reload cached network-header and address pointers after the operation,
>> since it can move the skb head. Preserve the existing behavior for
>> unchanged addresses, truncated transport headers, non-first fragments,
>> and IPv6 destination rewrites that do not affect the pseudo-header.
>> 
>> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
>> Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
>> Signed-off-by: Kyle Zeng <kylebot@openai.com>
>> ---
>> I have a reproducer for this issue and can share via DM
>> 
>>  net/openvswitch/actions.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>> 
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 12e339cbf791..36c2a1963222 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -319,6 +319,35 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
>>  	return 0;
>>  }
>>  
>> +static int ensure_l4_checksum_writable(struct sk_buff *skb, u8 l4_proto)
>> +{
>> +	unsigned int offset, len;
>> +
>> +	switch (l4_proto) {
>> +	case IPPROTO_TCP:
>> +		len = sizeof(struct tcphdr);
>> +		break;
>> +	case IPPROTO_UDP:
>> +		len = sizeof(struct udphdr);
>> +		break;
>> +	case IPPROTO_ICMPV6:
>> +		len = sizeof(struct icmp6hdr);
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	offset = skb_transport_offset(skb);
>> +	if (unlikely(offset > skb->len))
>> +		return -EINVAL;
>> +
>> +	/* Truncated transport headers have no checksum to update. */
>> +	if (unlikely(skb->len - offset < len))
>> +		return 0;
>
> All the checks above are already executed at different places on the same
> path.  With this and the new checks in set_ipv4(), the l4 protocol is
> checked at least 3 times for no good reason.
>
> While inability to update L3 header is fatal for set_ipv4/6(), failure to
> update L4 checksum should not be.  And so, there is no point propagating
> the error.  If the header doesn't exist - there is nothing to update.  And
> if we ran out of memory trying to expand the linear parts of the skb, then
> we have a more significant problem at hand than a non-updated L4 checksum.
> In the worst case, the destination will just drop the packet.

Agreed.

We already do an skb_ensure_writable() on entry into the set_ipv(4/6)
functions that covers the IP header portion.  It's probably too early
there to try pulling, unless we want to bleed protocol details up one
level, and propagate down whether or not something like a pskb_may_pull
had an error (to skip updating the l4 region).  That would mean doing
the re-assignment of nh once.

> Can we just replace trnasport_len checks with skb_ensure_writable()?

If we do that, the nh can become stale within the scope of the
set_ip_addr function, too, I think (skb_ensure_writable inside
update_l4_* functions pulls and potentially unclones the head to a new
region).  So we might have to change the set_ip_* functions to fetch and
re-fetch their own header details.

> It sounds like that would be sufficient here.  And re-fetch the 'nh'
> pointers right after the set_ipv4/6() calls with an inline comment like
> this:
>
> @@ -481,6 +480,7 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
>                 if (unlikely(new_addr != nh->saddr)) {
>                         set_ip_addr(skb, nh, &nh->saddr, new_addr);
>                         flow_key->ipv4.addr.src = new_addr;
> +                       nh = ip_hdr(skb); /* Potentially reallocated. */
>                 }
>         }
>         if (mask->ipv4_dst) {
> ---
>
> Creating a separate function with all the duplicated checks doesn't make
> much sense to me.

+1

My personal preference is to do the header movement once at the start,
since it keeps the write paths looking cleaner - but I don't know if
there's really a performance cost in some traffic cases.

WDYT?

> Best regards, Ilya Maximets.

