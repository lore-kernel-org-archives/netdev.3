Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.238.174.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337623;
	b=wst1fqkq3XhCh5V/rDeww3V4Dk3yf8743r4ir9Yehll2k9IJ3zMFY9LD0m0k1FKccrQC
	 cQcGC/qO0gnzrIs+lrYOZI12JSsRT01GtTZh4fTFv8GW8jFO3J0tV8It0iWKJTX1HF14J
	 Hb7JZPBdiQi5+4beJ9gT2GtaVxZ5xBFShm5pPOxMLvq/t0lFCYbtFw4r53ZZQgeoT9ZUo
	 QgJiPJZlY3gCBg7XGtl+3litJHdJLdNv3CaaeTZ7vKP9QhQqPg+EgZiRxHBS4+8oncDAS
	 d93073eTgbN9YDcA+YTCocionWSDDzEgPKT3yvptzYnahTKFbfu4fSlmlLn3yCNjsCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337623;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:
	 Content-Type;
	bh=vimO4kOcCdtVgDL7SqCrpC6sr0unIIQNr1/pz7rBYSE=;
	b=mBFXQfSh+KO7VCyX6gqDsQOqZLSW2H6fyRr2dbqSL5WrWQjD6/2d6l2Byliy4/faQWlE
	 qQk7UBN+wcpIn5/OEUm2PI3xNKs8qgeX8sz9yvNtQ4wnjKTc6AUEHSMLuYkxKiTNq3vbS
	 YW9OJS2qXbi9bn3aX0sCcgeGACUuHFgVuRHtFfjTNc8N72Vq1iEvvLp6D+xnF7EAYVvWl
	 Q1YZc99tIcUnX/3C+Dl/aUgdBVxbM0PGBnxrRa4WyJAicWIq2vTaBDOAkmkQvQ8EsGzUp
	 KOLeaisnw/EDHzCdJo6wgpgQYbhOTX28ZAS9nN/Sx1J2AIBrdjK8rX5wfJduWsfi2NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ssi.bg;
	spf=pass smtp.mailfrom=ssi.bg;
	dkim=pass header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=MEpXQVsx;
	arc=none smtp.remote-ip=193.238.174.39
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA821606A31A;
	Fri, 30 Oct 2026 05:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA821606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=MEpXQVsx
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 39F7421F69;
	Fri, 30 Oct 2026 07:20:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=vimO4kOcCdtVgDL7SqCrpC6sr0unIIQNr1/pz7rBYSE=; b=MEpXQVsxlF2L
	uMCYLaTDqs0jSBKYEJvlXcSI4Y9jW6sL010kHggjgAPQSO/QuvAh9w9QvemC5Dqz
	NOuUKLpp/VUX1CiNz1Jl06qV6/aoJ7xC/AaHbpqzVFlP4uViPCzdo5rynXRG6k9P
	KjXTYMYdqXtNj8xyR9F1JUlTME2MpKonRo3ldszCujQQsGv+5JEBK/TthqwvYMcC
	Hq+xpOu4jb0QaPOvdvlrcAsz9JcYIjVFOWfx2Be/kFncJldimAOqrrnMQjpp+e3v
	ff+dvkGtyh51q/bsO9DN35fX06QDqaIMZlbFiYNwDGeVM9BcIo4b8eQACzkGybV0
	QazvFaNHszJ8vK1Lud2mPZL48Wwieuf5Zv4ixdqORKrYGNAkUvVq3z7yFcYC1/sX
	cI0Ji/LXhsHv3UGntwQNztt7ckqthfrDoqMFA8y4CMFvJjzuB1Tum29ckGwfrgcu
	+bIZvqZgjpVE4ZuH3glaREuzh14HziGNtQWoWgIoBBLegWqQikFkPZhmH26SxUEv
	0pclqGA8aWZAEfXjk5STmbqA5IMVVCoQyfPs+nL6bgxTcB/QblP4KjZLFDGzsvdb
	VOX1ijTaQ1qyRIdZBbccqKZ6AtootHLj1K6ohrpzv3gsPFWAd9PxfCbpWjlWkQv6
	e8prZMg7S7gTcpmFVAV0k8WAFlLN9lw=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 30 Oct 2026 07:20:12 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 2D569620CA;
	Fri, 30 Oct 2026 07:20:11 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 69U5K5C9008270;
	Fri, 30 Oct 2026 07:20:05 +0200
Date: Fri, 30 Oct 2026 07:20:05 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Star Chang <starchang@google.com>
cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, johannes@sipsolutions.net,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        wangroger@google.com
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
In-Reply-To: <20261029090241.4070613-1-starchang@google.com>
Message-ID: <553d89ed-8691-45b6-ac98-0faf00b859cd@ssi.bg>
References: <20261026150539.1357037-1-starchang@google.com> <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg> <20261028061644.2997812-1-starchang@google.com> <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
 <20261029090241.4070613-1-starchang@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Thu, 29 Oct 2026, Star Chang wrote:

> Hi Julian,
> 
> Thank you for the prompt feedback!
> 
> On the ARP side:
> Glad to hear that dropping non-GARP ARP Replies (ar_op == ARPOP_REPLY && sip != tip) in L2 BMC sounds like the right direction.
> 
> Regarding the points you raised:
> 1. For GARP: Leaving it to DROP_GRATUITOUS_ARP to decide makes total sense. Legitimate GARP (sip == tip) will bypass our drop check and fall through to the existing IN_DEV_DROP_GRATUITOUS_ARP logic in arp_process().

	May be DROP_UNICAST_IN_L2_MULTICAST should drop also
the GARP packets. Why should the GARP packets to be more
privileged than the other broadcast requests?

	I see your v5 and it looks like you do not take the
path to stop the broadcast requests from updating the cache.

> 2. For RFC 3927 (169.254.0.0/16): I completely agree with your concern that exempting it opens another door. Given that Hole-196 attacks typically target the subnet gateway rather than link-local addresses, keeping it simple without an exemption seems safer.

	As this is a broadcast reply, we should be concerned
if the same IP is locally configured. But what if we send
broadcast request and receive broadcast reply for such address?
I don't know if there is some support for such broadcasts.

	As result, IMHO the handling should be:

- broadcast request: do not update cache, send replies as usually.
GARP requests (ARP Announcement) should not update the cache.

- broadcast replies:
	- reply for 169.254.0.0/16: one day these should be
validated and then allowed, now dropped
	- otherwise, drop, do not update cache

- the ARP traffic on the WLAN will increase because we will not
update the cache from remote requests, only from remote unicast
replies which are in response to our broadcast requests

> Regarding your comment on the IP part ("But not sure for the IP part..."):
> Could you please elaborate on your concerns with the IP changes?

	From my notes about DHCPv4, I see broadcasts only for:

- DISCOVER: client_mac->brd, 0.0.0.0:68 -> 255.255.255.255:67
- REQUEST: UNUSED IP, client_mac->brd, 0.0.0.0:68 -> 255.255.255.255:67

	But things now may differ.
> 
> The motivation for exempting UDP port 68 was that in our lab testing, we noticed certain DHCP servers responding with unicast IP addresses over L2 broadcast, which caused legitimate lease packets to be dropped by drop_unicast_in_l2_multicast.
> 
> We would be very glad to adjust, simplify, or rethink the IP logic based on your advice.
> 
> Thanks again for your time and guidance!
> 
> Best regards,
> Star Chang

Regards

--
Julian Anastasov <ja@ssi.bg>

