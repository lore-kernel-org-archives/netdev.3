Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D02E571
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443171; cv=none; b=lIjI8J4h0Ocv0kjk6kKhksBd99+1msJKV9+RaSi8vAuoOSGNqtCLdOY55qP63sWEJfauodIS1tXiV+wSq5Bobk8R1x7m0J/c8Q74V7DDmjV6u4QhO3B/9OmcNdqQvylB14ht8wJ0DWR1fzwNp44KB8vPlfKk5u63NS3IarkysO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443171; c=relaxed/simple;
	bh=FqJ1AgiZQXNJo0mVWYNoU0Ocn6VN9xcLLc/23xtqP3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4tDSNtB1iSlpFTB1yIaf11s03CpWH69IHE2oS9wZKC7ZXOEEgW0O7Mcu2li+aUkcX8g5FciYYwQ3ec7SWRWcIqqimrQ3YezGqU9Af3int6yoxk+v4LtTCIt+kcukjr4kcPMphXdpuKKYbkdNy4VQNqAMOPDCNG8/7wLnMLmERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhALT4R6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nnn7zk24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhALT4R6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nnn7zk24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781443169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=seu0L57j55kcZzrAtmgRorCAGJ8Rn3JHLkN9mY2uKO4=;
	b=fhALT4R6cTADGYkDMUXkSBYp3L0DlCPnv39bQk7nx6vzmtBurrZb/NHqwO6csSuoXNccvL
	Di5p8slBnlfe4jWCXaiNdoYtdEavn8icDvpwomZALyjvgtEslbWIyArZRje5tplcSGsAxE
	WWanYgSQ1J9BQk2ZIzzt8kJsHLYie+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-p7Q5p0N_OK-fWQgGajO3zQ-1; Sun, 14 Jun 2026 09:19:27 -0400
X-MC-Unique: p7Q5p0N_OK-fWQgGajO3zQ-1
X-Mimecast-MFC-AGG-ID: p7Q5p0N_OK-fWQgGajO3zQ_1781443166
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef0af9517so2313908f8f.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781443166; x=1782047966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seu0L57j55kcZzrAtmgRorCAGJ8Rn3JHLkN9mY2uKO4=;
        b=Nnn7zk24QCIBeF7rXSvRDnXmKjLWP68it01bU7bLIL/ZPF133JXBFI/jZ72oyMpFaF
         xQ3l5hGuDtA2YbcmF5NGIHBXg/AxLwXC8/Hhwoi53tJ0JDwRRrm+jrUKVUYh8uGFh8BV
         7UsCgfT4iiPqSXfATi2BBQ9c3c94VVWQjIocDAaaN+aOiyN9Uf3DYusrY/x9Jvm1zmKg
         o+GH8NznpzfPlIml+SDBvRwMbw5wVar5mSoVh0lLesvs4/zYupfu/3hT3o2VA1yQ/WuV
         voEfDUNcufalrX4LMBmfs2OtzsDaKI7fQN5tWrPL2FAVStGw/qtnBKfEECxxjs2s59Zw
         26Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443166; x=1782047966;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seu0L57j55kcZzrAtmgRorCAGJ8Rn3JHLkN9mY2uKO4=;
        b=Xwk5skKyCiCmEt0aEA3eCh5VraHbzgSMW/STOLsQs3OewR6IqWxR5Jt9WEQ+wnUR5K
         bpimVP2UNz4uOizUCU1Zo0Mm7/6snVg/5GX+UK/lYSP2Dx4U5n6Z4pJF05HjW3t2A24j
         dBaITmXVHGEei9GnbX4chgfy+DcLaTCCIqchu399GRdAZpqcHTqRXSD76IZ/8c2b1Huo
         6PhlQT2/dsC86yOw4GhnI4MN4x5NbaSbXm8eAJKuonWiIT6I2IA/7f+fFSW161sVCxhy
         0JxJq/+5nvvDYS9LqhUNauDjeiQlSFewxQ5N5DzdV5qV7OSzqR0tQrS+RAAyfSph6luF
         gYXw==
X-Forwarded-Encrypted: i=1; AFNElJ/AQ5g/vQZ8vOdLKhbEwfM8fdWuWIL5Ue117kdfKgrawR/jOJP3LWleB9vsg/uan0q9e9/bz2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKB5YmRXA7u8CkPmcCZwr8l/TgesVm4HcNvgKDkMEtQG6afsa
	IhOY+bY+zIaf+OOk06KF3Dyi7xfKOrnIhnDZnOdp80QaUYQb1BXD5Wvs/2l/BmKZp/HOuWAplpG
	S1zb42RDemf6ogCR3wdEtM5qd1CmoTGfWXeZqHE7jHLLGXcV9/dwRPIqXuw==
X-Gm-Gg: Acq92OHvWOL22H9p0GmrMBNkEe8teMKnP/UcjwHIaGRYzulWk5iJp43pqXhjS1+i7Jw
	XrgNgXIvlGyoEYbZQVTVtKbF56wtibmNr8LKhs8sV1uVwYasLZO0ssyhw2Y2p+jK1ojawYlfan0
	hCa+VllH7SlhKOxF2jnURS7cFmXuuFozcjgddHtLyAFmvWABREHTQJdf9hKGZ9/k4Eybl09j9SL
	SdQ920n0rwZ3C4mk+dPO0DJdklc9uSlXa/fr1tZlUalrwuH/9CZiNgHUOUbpIkd2Umpn8EoB9Eq
	fmc+q16jtoEGWO05vpNzbFY/2wqh2StnY2bUrR+FI3mkxgyjidhdirKDLZrXXcE1dzSsWCIYx1H
	/ucZ1F6VdOZPfNgTeJPYkhypB4x4ESt7Qp8T1hEXVYbJ6MVBns4tcxoQ=
X-Received: by 2002:a5d:64c6:0:b0:45d:77f4:1ac2 with SMTP id ffacd0b85a97d-4606da0508bmr14623219f8f.0.1781443166275;
        Sun, 14 Jun 2026 06:19:26 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:45d:77f4:1ac2 with SMTP id ffacd0b85a97d-4606da0508bmr14623172f8f.0.1781443165842;
        Sun, 14 Jun 2026 06:19:25 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3dcsm23933729f8f.13.2026.06.14.06.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 06:19:25 -0700 (PDT)
Message-ID: <617cfbfe-0b42-4ce8-a283-5c99da26bb10@redhat.com>
Date: Sun, 14 Jun 2026 15:19:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 08/11] udp: Set length in UDP header to 0 for
 big GSO packets
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-9-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260611192955.604661-9-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 9:29 PM, Alice Mikityanska wrote:
> diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
> index dcff7fb16ff6..32525a051a6f 100644
> --- a/net/ipv6/ip6_udp_tunnel.c
> +++ b/net/ipv6/ip6_udp_tunnel.c
> @@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
>  	uh->dest = dst_port;
>  	uh->source = src_port;
>  
> -	udp_set_len_short(uh, skb->len);
> +	udp_set_len(uh, skb->len);

Both Sashikos noted the above breaks GSO csum, as the following
udp_set_csum() will use skb->len to compute the csum partial.

I think it would be useful to consolidate udp_set_len() and
udp_set_csum() in a single helper - say udp_set_csum_len():

void udp_set_csum_len(bool nocheck, struct sk_buff *skb,
		      __be32 saddr, __be32 daddr, int len)
{
	struct udphdr *uh = udp_hdr(skb);

	
	uh->len = htons(len);
	if (nocheck) {
		uh->check = 0;
	} else if (skb_is_gso(skb)) {
		uh->len = len < GRO_LEGACY_MAX_SIZE ? htons(len) : 0;
		uh->check = ~udp_v4_check(len, saddr, daddr, 0);
	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
		uh->check = 0;
		uh->check = udp_v4_check(len, saddr, daddr,
	// ...

so that csum and len are always consistent, the 'set' logic is symmetric
with udp_get_len(), and no duplicate checks are needed.

/P

