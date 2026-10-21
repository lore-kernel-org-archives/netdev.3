Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589418;
	b=FBhOYf//f2phVOGVYVI7UWQ/3RtWtrABncsGmae+AeuJrdiONMA1wLDp5HXGUbByMeyI
	 uZyR8YmDEpn1Xn16omdcgLFIJnsz8hMMvBUNGXQZJalprJW6hSTab7puJTJlil28OMSE8
	 czwMO7Z32aoBpw+4i3yZv6wsHxeKoTfaJILvzs0zrvYJ8W+uWQ7COzQZ7+u0a+ioY01YC
	 ApBJwVJvS21oycMJip7qheXjV/Y+Uqj9rtS/o+7e3NNlyk4e0wOL5FWXAUsxT+4ShHccO
	 3C4wNUCr+tn1qTvuI1htId4snQAdSaVM1rCwF8bokw6stdGsiJWGWCpQu/3luyNf6zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589418;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CX/gb5BMuxJndjanTuV1AP23DsP7m8B+9mkrfYNPMJ4=;
	b=dGfIRFzERylh8diGjWWtVbhTvEOqVXiMvPkF/wIv9zxg0eqOLYNxjSDYJmlC8p5r8Z4X
	 LY85VCE1/48gsP0BHhGAL4LHcCxSNexPWhRADlL40JTpFST/pEF1KHkOIZ9nJF129+elV
	 0z2/HxNi53axsPFrsb+7bU/J66RlGLeGSAlkf9KE67A7ZneYed+yLs65/iAXjtz0mDRuh
	 nictmpMt16DgWS+oJ16vi2M0valxeano8q/gr5vpOteokLjE26uL1uHqI5a+FM0H5R+Mu
	 eMB//2wvcftb+Qm0XC3nkwVx70mdLEx3dBTU5OX55ZPP0VEpVBxOlL9T7cHBRWOx3Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHlLiQo2;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="fy9Mjvj/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E846606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E846606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHlLiQo2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fy9Mjvj/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792589416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CX/gb5BMuxJndjanTuV1AP23DsP7m8B+9mkrfYNPMJ4=;
	b=gHlLiQo2E2dL7bMQwmwUAvUGHjw8JICMOFhzPoqhMaszcWq6up+wW+ypPV/BTmgRldMpsl
	oPYPiqJySApNlaqXDNuJi7LkU4Vg19qlis/SqJqYwBsvtCEny+bouLqXus6Rq+kZvxITd0
	jF81b3hmSh9nTXfBiTLUjnGp3E0E4pU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-fU5mDduQPWmszvFI41ythQ-1; Wed, 21 Oct 2026 09:30:15 -0400
X-MC-Unique: fU5mDduQPWmszvFI41ythQ-1
X-Mimecast-MFC-AGG-ID: fU5mDduQPWmszvFI41ythQ_1792589414
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d7162so1070138a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792589414; x=1793194214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CX/gb5BMuxJndjanTuV1AP23DsP7m8B+9mkrfYNPMJ4=;
        b=fy9Mjvj/AtO92MMu6zqsftDYsJUiOuNyMkysomcAjnU2VCbrXAjO3sNpommUIq44X9
         QRQyqqd5l3EU+xqb1ulppQoXM281dlVX8cxSF4E9r8WGuSKoRt2Z1PFeavNhgbjP2iD/
         YENrBBElBAuZx61Ag+CR1UCXG18vchGNFf7zHvs2qVDcjQRQCaP3FOTZo2mvbS+5+M8e
         L3PRQr5rjXqtYW7Q+hllDP/XDCayNQWGmT17sZQ99UWnca1OyWWXlFWlWlvv9SzuOW7T
         3wG7js4JkBj89i1Gx6z6y+kJ/PZQP99Vt90dSK/Um2qUwe/fSW5N20jc1YqkqW85X/wv
         QRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589414; x=1793194214;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CX/gb5BMuxJndjanTuV1AP23DsP7m8B+9mkrfYNPMJ4=;
        b=xsPgbzEA73UPwq2oN3AI36/VE4NJASNZlNNu4x30LwE0OkTikJA77TTijv+jRjMeHB
         zyHvGGYzhUEJ86j3m+2VXhpICR8BIK6Xgv+52Tn3n3SuoWO9fZ04HYKQqQA1EyKReU43
         hlwYTmB2PV4k5Ciy18nHrPpa0h1iJ8Xc6mpeYD5vbHlHltI0lMk9ZepLc4BJZeKLmNOq
         noYzPZMH7rbMe0T6DQWgYkmW+gpt7UgtwmNeFfu9kh1y5RXXpp1aLStSQvj/Zmb/0+jt
         4jsdNBEuebvdkVGFiWZtgSXyMb/KGdokUbZnJkZRX2lvSX4zaFi1D5lwqm2KIo4NwSmk
         jPeQ==
X-Gm-Message-State: AFq9FYJiyfIMR00dv1mz7Xc3i3z2uGfcqG63C9M8akWF79Ob7r3Uxaae
	HI4toqJgwxAofzSwU3clFdL2UcdXfhE2Ug28OXXby6DwHcILRQQ0og5Gn1lJCsnEvdjpAR6xKy2
	th9twXvt9EZXVAEDGTw7jV3fBIVRXI5FY9bDvQjYPhSkLI2c4eUFAC+BUuQ==
X-Gm-Gg: AYBFou3poLuvrqDHPTmg5o5UQKi9pxb5e5rHkoczQopgntsr1A6h+rxw+E88BhOuhlg
	o3AwS+Eb5ziADYYV0Fhi4J+Uf4hubF36wX2TH+ANU4bnH38zR8fwBQk4TTQW+FAvFegBjZWeR4G
	Gncy3Bztc1FK/86teMBDHPep957zKi5KRrIZdGzDKJCnLeU2OEVvgW+0IEGsy3rCcfUvvS2iLCb
	gNB5Z+E0VJkWBFZ75/UzQhJ9FR8d5+87mvMGYJwGPTz2Ulnxtr76PBvBDNFgWjMrb1kwIr0IFzp
	fllae9NfHdeDKm28FlgAoJ9Iejm/BsOd6WregXInFVxMZhUfVDxmiT/so5ny7OHzY4HxWEanMGQ
	gYZYuI/6Na4DnV2k5bOhPrr2G/z253t1qXfetQ8rTmYdyDbCeVLEywJZpigx3tZqYQGC3dzEEZQ
	==
X-Received: by 2002:a05:6402:548e:b0:6b3:f821:2a9e with SMTP id 4fb4d7f45d1cf-6b408eb21f5mr1628500a12.20.1792589413524;
        Wed, 21 Oct 2026 06:30:13 -0700 (PDT)
X-Received: by 2002:a05:6402:548e:b0:6b3:f821:2a9e with SMTP id 4fb4d7f45d1cf-6b408eb21f5mr1628461a12.20.1792589412847;
        Wed, 21 Oct 2026 06:30:12 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b40313258dsm842223a12.28.2026.10.21.06.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:30:12 -0700 (PDT)
Message-ID: <361bbccf-6ce7-4b1f-bd55-4d8270423320@redhat.com>
Date: Wed, 21 Oct 2026 15:30:09 +0200
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
Subject: Re: [PATCH net-next v2] amt: make the per-tunnel group and source
 limits configurable
To: Omar Ramadan <omar@blockcast.net>, Taehee Yoo <ap420073@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20261015231825.2852054-1-omar@blockcast.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261015231825.2852054-1-omar@blockcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 01:18, Omar Ramadan wrote:
> A relay caps the state one gateway tunnel can hold at AMT_MAX_GROUP (32)
> group records and AMT_MAX_SOURCE (128) source records, counted across
> all of the tunnel's groups. Both are compile-time constants. An SSM
> receiver uses a source record for every (S,G) it joins, so a gateway that
> needs more than 32 groups or 128 channels through one tunnel has the
> excess joins dropped, and the relay operator cannot raise either limit.
> 
> Add IFLA_AMT_MAX_GROUPS and IFLA_AMT_MAX_SOURCES, read when the link is
> created, like IFLA_AMT_MAX_TUNNELS. Zero or an absent attribute keeps the
> current defaults. Gateways drive these allocations, so the policy caps
> them at 1024 groups and 4096 sources per tunnel, and strict_start_type
> has it validate them, and any attribute added after them, strictly.
> Report both limits in amt_fill_info().
> 
> Assisted-by: LLM
> Signed-off-by: Omar Ramadan <omar@blockcast.net>
> ---
> v2:
> - No code change. Rebased on net-next 518bf436318e.
> - The amt_policy[] hunk now carries one line of context. In v1 that
>    context included the IFLA_AMT_DISCOVERY_IP entry, which patch 3 of
>    the pending net series [1] rewrites, so v1 did not apply to NIPA's
>    combined net + net-next branch. This version applies to net-next
>    with or without that series; with it, the result matches a 3-way
>    merge of the two.
> - v1: https://lore.kernel.org/netdev/20261014221334.2443184-1-omar@blockcast.net/
> 
> [1] https://lore.kernel.org/netdev/20261015220648.1545576-1-omar@blockcast.net/
> 
> Notes:
> - At the policy ceilings, with 256 source buckets per group, one tunnel
>    can hold up to 1024 * 4 KiB group records (176 bytes plus 2 KiB of
>    buckets, a kmalloc-4k object) and 4096 * 192 bytes of source records,
>    about 4.75 MiB. At the defaults it is about 152 KiB.
> - The IPv6 outer transport series ("amt: add an IPv6 outer transport",
>    posted 2026-10-09) also appends attributes after IFLA_AMT_MAX_TUNNELS
>    and sets strict_start_type at its first one. Whichever is applied
>    second will be renumbered after the other and drop its own
>    strict_start_type line.
> - Tested on net-next 518bf436318e, alone and with the net series [1]
>    applied, in an x86_64 KVM guest with the iproute2 companion patch,
>    which follows once this is applied. The defaults read back as 32 and
>    128, 1024 and 4096 round-trip in text and JSON output, zero keeps the
>    defaults, and 1025 or 4097 is rejected by the policy without creating
>    a device. An 8-byte IFLA_AMT_MAX_GROUPS is rejected as an invalid
>    attribute length, and the same request with 4 bytes creates the link.
>    tools/testing/selftests/net/amt.sh passes 6/6. W=1 builds with IPV6=y
>    and =n, sparse, and kernel-doc report nothing new.
> 
>   drivers/net/amt.c        | 15 +++++++++++++--
>   include/net/amt.h        |  5 +++++
>   include/uapi/linux/amt.h |  8 ++++++++
>   3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 81d26ef82..30cff8de4 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3162,6 +3162,7 @@ static void amt_link_setup(struct net_device *dev)
>   }
>   
>   static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
> +	[IFLA_AMT_UNSPEC]	= { .strict_start_type = IFLA_AMT_MAX_GROUPS },
>   	[IFLA_AMT_MODE]		= { .type = NLA_U32 },
>   	[IFLA_AMT_RELAY_PORT]	= { .type = NLA_U16 },
>   	[IFLA_AMT_GATEWAY_PORT]	= { .type = NLA_U16 },
> @@ -3172,2 +3173,4 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
>   	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
> +	[IFLA_AMT_MAX_GROUPS]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_GROUP_LIMIT),
> +	[IFLA_AMT_MAX_SOURCES]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_SOURCE_LIMIT),
>   };
> @@ -3235,8 +3238,10 @@ static int amt_newlink(struct net_device *dev,
>   		amt->max_tunnels = AMT_MAX_TUNNELS;
>   
>   	spin_lock_init(&amt->lock);
> -	amt->max_groups = AMT_MAX_GROUP;
> -	amt->max_sources = AMT_MAX_SOURCE;
> +	amt->max_groups = nla_get_u32_default(data[IFLA_AMT_MAX_GROUPS], 0) ?:
> +			  AMT_MAX_GROUP;
> +	amt->max_sources = nla_get_u32_default(data[IFLA_AMT_MAX_SOURCES], 0) ?:
> +			   AMT_MAX_SOURCE;
>   	amt->hash_buckets = AMT_HSIZE;

Sashiko noted that with this setting is very easy to livelock the host.
At very least you should scale `hash_buckets` accordingly, possibly move some
processing out of the RX path.

/P

