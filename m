Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E33CAA49
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176914; cv=none; b=MbkcDpxqA+q0SIe+Eo5WSKdjDgLRe9JLaH3/bqPnu891opE7Aubkh/Y+3cm5/BwX6jEWComLkz1LASzsjwSg+nNb+rO6uGlZVdC9U2H1p/flS4t/5LWmx/v5t7Z6AuhMlm+X8xRqmNeff+Dmi7GS0I2x7t/kds59KyyqgiOewxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176914; c=relaxed/simple;
	bh=BnzYBUOnLSiIWSs8RNklNX8J/RRI7TV+qjSBhPXGbfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3B7KCdlibkkDgElMb+SNXDhBdncQ8qHmtZTWyoVE3roMp2YwlEM65cu8lj3RKMHX9qAYRIf5IEa/bVNNSU4b8XIF7ZHASws581dNxlKU25nW1TwjPczgS5uLGQQNrkkTeEZXNIguX39QIEhLP758SqlpgG4hcKCPFf7mi/4d7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDHghERq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDHghERq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so3293448a91.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781176913; x=1781781713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0p9/X+E7tl8Yx7noYo8cCpp7nCnHbvyUjv3ehBjdSfw=;
        b=DDHghERqIh+Jr6+lCwe5PsBN8eeFKNAz/Gnqt04Y19eHUnE5hL3c1wNH+MtE01vB3+
         Cv1PBOwv82j2Ii+KpqmpSjEyP79/Kr/xNgJeEOJB53ilMDgOC/s599ggvvHXJPQDgrM7
         ccrbWbccTf31XDxRFLsG9/t0nUpNICxg4OavdtcoX/IM4RkS6wv6ly/6xeT4rLJBzafK
         NKKZxLGhKXSpfWPOcr+Rkbzi24ZfUh74Bj2BOTzmSextDzrHtib3B3g99hxuiYmkNlK2
         k10VyNqKo5QRhtXsJGtot49jnuqam8Kj8AwqawIcphqj9wgpR+KMW/CVAkl3mAUsn/Iu
         PbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176913; x=1781781713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0p9/X+E7tl8Yx7noYo8cCpp7nCnHbvyUjv3ehBjdSfw=;
        b=GxeYXfuu0zZcP/QAAgzQPmGmnHLXYcExCsPuT4qUzpQN9r+xDmYg+3Xj7y9pqydHIw
         irvgbI0Ghfsl4MyavWHyBrR0PPB1UJOqkJFBh7Hl3mPHVAeApJmeMtHLuIkF/ZE3kBRi
         dwN0IIpzjT1qJqyzQTSVrpnITWOjo2bqFtypuDvtBPjbN0sujAoCteJKBIQu+4+KZnm7
         d65u/dxhUxo8QOjUKP9U+0kHLnW00oh5/L+vSYgVtjneZLaI9vAsdShxJk6P8WQwORW0
         mXqFT6s9+a4HzAKmfTB6aDv2ZmnfpgicSgv08WUK62uTOfn8SB2i0N24KMWJuRqb8D1R
         5RNA==
X-Gm-Message-State: AOJu0YzmTXIdUFZTqyewOAcsblfZt4KS/R3j46kGOZh3jwpjxzYqIqig
	kiy8V00UQOCb4361EGhuBWpkoPe7meLyGBpV+1zJdFkGyyEQLLU5rO5V
X-Gm-Gg: Acq92OHzhpNuIUSvvBjgdXDARCoke2T4XkxddVcwp8f/grsXtEUG578X54yJrNF1vzp
	UbroaWonfQnCbF//JGb3WUdfqNP+M56u11TvPGJYC1fdmoSwx9tpyHRcL1cL3w5z7qlkboExxJM
	sK2KfXjn1YU8NU2fGjvbsAL/DOIRTP4ox79FZtHkZDzAMNx49+KnsCAFeZS5cAdQnjBLeQpih5I
	oQV7l4+8uFfHzhcN2ycbOMR+mX9pEpNa03vvlS4RLbV4rdMK3vmtIbCBu35VInKpbT7vQq2GFbL
	eXbemCb/1hAWGtCtGXnt+QUht5asTHfq53uDMewRQ5DF75XkjDb7Q/rlQ6l/8LAgIahSO1kJPjP
	KnP1yDu8U0L0HUbMSa2kgPKs9WZhQ/A2CT1W7soQf1ahUwLLVZV31YIKHDZ62v6jmaLFbQlrLkm
	GSeGfGZ/IdLztNe5g0qQO/9BYkQ/3RZAYdyGqvv+ojtstnxnsAGij1
X-Received: by 2002:a17:90b:3f50:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-377a870982emr2730988a91.22.1781176912529;
        Thu, 11 Jun 2026 04:21:52 -0700 (PDT)
Received: from [192.168.89.2] ([27.232.220.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a19eesm2163098a91.1.2026.06.11.04.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 04:21:52 -0700 (PDT)
Message-ID: <3a89008a-e4ff-4249-80b5-e2caface5642@gmail.com>
Date: Thu, 11 Jun 2026 20:21:48 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 0/4] bonding: support LAG IPsec offload with
 replicated SAs
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
References: <20260520081004.2232091-1-hurryman2212@gmail.com>
 <20260610141843.GI327369@unreal>
 <a7f661e5-61ee-42d7-be9e-5569e0f16e28@gmail.com>
 <20260611100632.GL327369@unreal>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260611100632.GL327369@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/26 19:06, Leon Romanovsky wrote:
> On Thu, Jun 11, 2026 at 05:56:17PM +0900, Jihong Min wrote:
>> Hi,
>>
>> On 6/10/26 23:18, Leon Romanovsky wrote:
>>> On Wed, May 20, 2026 at 05:10:00PM +0900, Jihong Min wrote:
>>>> This RFC adds a bonding model for IPsec/XFRM hardware offload on
>>>> 802.3ad and balance-xor LAG devices when the transmit hash policy is
>>>> layer3+4. This is an intentional scope limit rather than a hard limit,
>>>> as this is the configuration I can test with my gear.
>>>>
>>>> The main idea is to leave the existing upstream single-lower-device XFRM
>>>> offload path for active-backup intentionally untouched, while adding a
>>>> replicated state model for LAG.
>>>>
>>>> For LAG bonds, the bonding driver installs the same XFRM state on every
>>>> eligible running slave and stores the per-slave hardware handles in
>>>> bonding-private state. Lower drivers that support this model can then
>>>> resolve the handle for the concrete lower netdev used by the datapath.
>>>>
>>>> LAG IPsec features are user controlled. Newly eligible LAG bonds start
>>>> with the ESP/XFRM features disabled, but advertise supported mutable
>>>> features when all running eligible slaves can support them. Users can
>>>> then opt in with ethtool. Feature enable is propagated to the lower
>>>> devices and rolled back if a lower device cannot enable the requested
>>>> features.
>>>>
>>>> The series also handles LAG membership and eligibility changes by adding
>>>> replicated SAs to newly usable slaves, removing the departing lower
>>>> instance on down/remove, and flushing bond-owned XFRM offload state when
>>>> the bond leaves the supported mode or hash-policy configuration.
>>>>
>>>> This series does not convert any physical NIC driver. A lower driver
>>>> must explicitly opt in to the replicated-upper-device model before it can
>>>> use these bond-owned states in its datapath.
>>>>
>>>> For example, a driver such as mlx5 would opt in by marking its
>>>> xfrmdev_ops and by resolving datapath handles through the helper:
>>>>
>>>>         static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
>>>>                 ...
>>>>                 .xdo_dev_state_lower_handle = NULL,
>>>>                 .flags = XFRMDEV_OPS_F_LOWER_HANDLE,
>>>>         };
>>>>
>>>>         handle = xfrm_dev_state_lower_handle(x, netdev);
>>>>         if (!handle)
>>>>                 goto drop;
>>>>
>>>>         sa_entry = (struct mlx5e_ipsec_sa_entry *)handle;
>>>
>>> I’m curious how you replicate and maintain the hardware state across these
>>> devices. How are you handling the anti-replay window?
>>>
>>> Thanks
>>>
>>
>> The short answer is that the RFC I sent was not complete enough in this
>> area.
> 
> The issue is that you are adding support for crypto offload where the
> anti-replay window is managed in software. You must ensure that all SAs can
> safely share and update this state.
> 
> Thanks

I agree.

Generic XFRM crypto/packet offload with bonding enabled is not
impossible, but crypto offload needs a different contract from packet
offload. If the sequence number and replay window are still owned by the
single software xfrm_state, and the lower devices only hold crypto
context, then replicated lower handles may be valid. But the RFC did not
prove or document that, and it used the same weak opt-in for both CRYPTO
and PACKET.

For a respin I should either leave XFRM_DEV_OFFLOAD_CRYPTO out of the
replicated LAG path at first, or add a separate capability/contract for
crypto offload which states that the software xfrm_state safely owns and
updates the shared sequence/replay state across all lower instances.
