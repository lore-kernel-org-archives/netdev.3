Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386856;
	b=kdHIhcQa9KOCyaIshRoD4/M215wuNKZ53rTNHf0+31njg0xxCq69flPLW7S9HSdmsafY
	 8TEXfsCcKGhYUZ2L1cBZYdJuyBQjxk6eyRpT6uELcngis7f8GOAtf4yaVT69ak36OFC1h
	 qYWisARtR6M7Y79TQEUCqH04ithIn3pHFojnZ/Rq0PwJaHAUoHf6Cf10P+gd5jzspPehp
	 1cLKXViX19F0ButSdNtXM75EgAR+BZMl/P1KIDWZKUJdzxhqY4nIBVkP8/Bxyrc+HfiID
	 FUTtn8nMEVUDA/6FwFjDk1shaY+H5hTCWVlc+tJ+hQdn2g46XYBkGfJgrDr/puBxQig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
	b=hKmu3ga8SUALp6HMF7jEAR/a1PP54yIOV6Xy9zLeu5CiVrgrLCvfP5Vfr2FQ+iqoj6X0
	 3VU174IlrpM3pnE7yJFsNhRXS5KTs7XrHQbWaj1g9AL290OLbqyLWIGEcdgJrHAFUzNew
	 1n5lRqy6c3aaJ7H43RhBBUzhNJELW2mkZH91KGUKtq4H+gXURj5eObzb3Huk5GtRzojN3
	 clpnKQpnixPSH0kGGanHWJykHAA6QjAgQFJqhP/CVmRaE00vGKkGmDWOT8ovBqUy9YRnh
	 Yb4FJkZq5RIKYAhvalt51qQPFL+n5050f9xAz3bXZF80+7wy6zLC+veeB2MO1nMyrxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vv2Hs2Kr;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47656606A324
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 19:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47656606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vv2Hs2Kr
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6d68de53053so515646eaf.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793386855; x=1793991655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
        b=Vv2Hs2KrFjB/loc09g6ZDMIoKgPelY786FvhRMM9uA+vQNMaNG+psgdLdAaCabhE0M
         67N0AOsBjfxA5a8mh6L30HG/LYLiVuCL9qJdxQH00EHJy4n0j/UbEeEwvb2QWh8hzk3D
         Abkauv0KK6tekxRoO0JPkSt8HuCr5JukTC1iZ2t8gh2X2nQoP1V7CVr6RSkZLzbSskFx
         suVCBUn7WWglGzh/U23lBHfpFIOqJeqcLQ8wOpi065TavixE7Tn8T3XYZfAx0NHX0fTp
         6wHiJMiiq7jPXTV7MB1Lg1ojCm4vQqSUq5batWlXHWGTYo7SHcmzwuFcA8jr8Gw+Co3l
         3rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386855; x=1793991655;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
        b=a4+2tNdl/+f8Rl5u0HBa69K7mFqrJhQRaWFzDbSWH27zGDSCT8oHX3BACHRj1RfNFR
         exrnWrDoIsJkoZHQF9E2HibCSNgCSJxnfpmi57aBhBV2yxI5TZ1VSYACrv4Bue6XZsr/
         kqh4dEhCFwk3PYkCG3iPhNtTAuv277Qr3llvpsWzIAc0AR8EXGE21ZbfaXZZ4QMnXqRM
         VywpzTy++TAD08+Vp8kLKwikvm18BW8FJoYoN9jqGSnnGzvF27wWk94GmOkcKOfJMjue
         lwD+Yeb3v6ihgUaqjkIjOToyF9SUYuh+JUYv7dbbPM1BtztZ8hqDABUs/RTjfKr9c3OZ
         9NBg==
X-Gm-Message-State: AFq9FYKHr2a3yi4tgXFgBlhXbpkdYTPmrD9EFD9378horBLvkrVa+MAK
	eXnjOk4O44HFo+ujRZJULcwjDZGhtL3dLGViLLSIHO5ckx66vlnACoN+
X-Gm-Gg: AYBFou2YNeY0t/lkq6grhMrEnLE9LqcEybqAG4HZmT6c0UbqU8miX/j+u6BxmkQDLKL
	FBEyxL5wvAwH5yFz2V5Roc1uqSYkmGYCaKUjcBJzn3+NT8PbhM5DR2+3n5pqTzU2E3g8QRQPtNq
	MRBy9Lr8zJhXU6tgap7RQz5MVAgB99kCQnUlzwgj/OLyO2a95GpiUni8pdfQ0FXEU4N4b+iwSy1
	OmH+jbnE6+O1mXaTRTkF28522dHxJhoNcSno42KZ3CEEjyDgi5Mwie9nQ3dbqSu0XEWAGFfmSwY
	SEiyQTJ26ayJ8yk/cK1N8L0+mTaQnVva25X3RR88RZJtZObPdIzS8c2tnQ2flEhfbM3TSAJEpDv
	qp9NjRjBUGosyGo7E2R06Sk8QwoEN9oR7mXvWzDtMfFJy6YZHSw0X00Q+itShBcBzTj275jo/4V
	e3dRqVOJGl/Xmc+jS94mRbBVhKM/ORGU97ZjhcOioIvY2BsYGHA1cJflXuAu9061rmaBXZz53iV
	5EUgUPJ99C2LQWmDGpBX4JVn63cr69mpLEBDoVgoDoEC5sIoFxYjNL+iXz+aoS6JhH+p/EhpJy2
	DaAbPC8k5NgG5yy303z5wCr2eILOcmfr0J5GIa1j1jL1oKJUSXS+CPnE26rGPJXYkRKqrGFbZQP
	4N9siegnMHUmRz7IF8w==
X-Received: by 2002:a05:6820:8582:10b0:6d7:3933:461d with SMTP id 006d021491bc7-714f29a29a7mr1457363eaf.51.1793386855141;
        Fri, 30 Oct 2026 12:00:55 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316:4bf6:e4d9:c6ae:de64? ([2600:6c5c:6b00:316:4bf6:e4d9:c6ae:de64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3190fe6sm2430468eaf.14.2026.10.30.12.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 12:00:54 -0700 (PDT)
Message-ID: <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
Date: Fri, 30 Oct 2026 15:00:51 -0400
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
From: Matt Vollrath <tactii@gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Alexander H Duyck <alexander.duyck@gmail.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andre Brait <andrebrait@gmail.com>,
 stable@vger.kernel.org
References: <20261028170239.28606-1-tactii@gmail.com>
 <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 12:47, Alexander H Duyck wrote:
> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
>> When an skb arrives at the driver and the header length exceeds the u8
>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
>> are sent to the card. If TSO is enabled, some header lengths will cause
>> the card to hang.
>>
>> This was reproduced on an I218-V with an unprivileged Python script.
> 
> Can you elaborate on what the script did to trigger this? I am
> wondering if it can even get there with a valid frame supported by the
> interface since most of these e1000e parts don't support tunnels and
> such.

I will send you the script OOB. To be clear, this is a security fix,
not a correctness fix for rarely used paths. The rules say I have to
post the fix publicly because an LLM found it in a
function-by-function scan.

> Also did it have separate cases for the CSUM vs the GSO? I would
> suspect this is more a CSUM issue than a GSO issue.

I have only reproduced hardware hang when TSO is enabled on the nic.
Otherwise it likely just mangles the packet, but I have not confirmed
that.

>> Fix it by disabling GSO and checksum offload when the header length (and
>> checksum offset) would exceed the field widths. Compensate for a
>> software-inserted VLAN tag.
>>
>> Because of a quirk in the ordering of ndo_features_check, the skb's
>> transport_header field may be stale. If the skb carries
>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
>> no reliable interface, so don't offload it.
>>
>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> 
> I am pretty sure this Fixes tag is bogus. This is the introduction of
> the e1000e driver which was in 2007. The ndo_features_check didn't
> exist until 2014 sometime after that if I am not mistaken.

My understanding is the Fixes tag should point at the commit where the
bug was introduced. A comment on the Cc: stable tag indicates how far
back the fix can backport. I didn't bother because this patch should
apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.

> Much of the complexity that enabled frames to build up massive headers
> wasn't until much later when the network tunnels and OVS started being
> added.

The repro script should work back to 4.10.

>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 6f85dab5c55c5..370776657d100 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
>>   	return 1;
>>   }
>>   
>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
>> +					      struct net_device *netdev,
>> +					      netdev_features_t features)
>> +{
>> +	/* Do not offload packets whose header lengths exceed the u8 fields
>> +	 * in the descriptor.
>> +	 */
>> +	unsigned int hdr_len = 0;
>> +
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>> +		const struct tcphdr *th = (const void *)skb_checksum_start(skb);
>> +
>> +		hdr_len = skb_checksum_start_offset(skb);
>> +		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
>> +			hdr_len += __tcp_hdrlen(th);
>> +		else
>> +			hdr_len += skb->csum_offset;
>> +	} else if (skb_is_gso(skb)) {
>> +		/* Work around untrustworthy header offsets in this case. */
>> +		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> +	}
> 
> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> the frame must not be TCP/UDP GSO since for those normally the checksum
> and offsets should be populated. Have you identified cases where we are
> seeing TCP/UDP GSO w/o the checksum being set up?

It looks like this particular case is never reached by normal traffic.
It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
hostile or niche setup.

When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields are
used for csum instead, or left zeroed.

The transport_header field is unreliable when a packet is being routed,
so you would need to parse the packet from the top to find where the
transport header ends.

Rather than walk all the headers for hdr_len, it seemed prudent to just
categorically deny offload for these exceptional cases. I could be
convinced otherwise.

>  From what I can tell it looks like the only valid cases for it not to
> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> anyway.

FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e

>> +
>> +	if (skb_vlan_tag_present(skb) &&
>> +	    !vlan_hw_offload_capable(features, skb->vlan_proto))
>> +		hdr_len += VLAN_HLEN;
>> +
>> +	if (hdr_len > U8_MAX)
>> +		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> +
>> +	return features;
>> +}
>> +
>>   static const struct net_device_ops e1000e_netdev_ops = {
>>   	.ndo_open		= e1000e_open,
>>   	.ndo_stop		= e1000e_close,
>> @@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
>>   #endif
>>   	.ndo_set_features	= e1000_set_features,
>>   	.ndo_fix_features	= e1000_fix_features,
>> -	.ndo_features_check	= passthru_features_check,
>> +	.ndo_features_check	= e1000_features_check,
>>   	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
>>   	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
>>   };
>>
>> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5

