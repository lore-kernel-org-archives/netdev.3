Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001530;
	b=aQEtkibwX0vE+qVHFTFS8ob4eWe9KyqsjYvqyxOI5/jyp6+WGgc1DxOL90K1Vr1FUmm3
	 BI1yLPq4oXMvWHDv8m6EowGhGAglOtTEYRjxa7C8fWP84JMGnC11UbTBTuKX+3RS9VPHL
	 F2U6ev4h1TZdy3V8G59alg7CZpeGryf6Ke4olWMImGOyapPiPr6AzSnG4gW32W58wjkb8
	 MJFBh/V7hlcnr92WHnvDUedONNjOCGm19dkp8XmgAzO515XjmqqfGdO6Qrqws6K8PtRMu
	 rT21qms1k5b/0T+g9Nh+vxF9p0hozfs26Ll8TK3CqqBxNSBIoDnetW4GTIas+efFq2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Qy+l+P3/Ur6+HWnHNoQlQuqGZxsGTPMqagOFnx35yX4=;
	b=mzIvitm25eHayDdWNxWX1BPQFFBo/mOXXzKGQmeCaG5Fv63FR/40ukJVhnXfkHRc1KYb
	 wKOtHpZG/FSWrYXwVVFCvvBY86Xc8DTmgVAvsFLat7PKZ0iX8yhzQM53LdHK4/8xWidhM
	 3hQdltbwuRjW2h2B9Y+Cj6e/vCUtKdTI6tEvYQYrXwa4SejjvhQ0XYSM2p9qCmX2x0AfU
	 StxkGunToKTLEFUUnL1vy475M1YSkbp7gF4CvbaDSxlPcpC2LwWTHmCNqc1wf/V1sikBv
	 0ReAD6M+oqfeFOVLTToi9rx/5c3RDPUgknFMx5mHUPpvNnwKnbzOt3ZoZwLhaf1jpJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=JhBY4Kpu;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29EB606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F29EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=JhBY4Kpu
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so2624249f8f.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793001527; x=1793606327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qy+l+P3/Ur6+HWnHNoQlQuqGZxsGTPMqagOFnx35yX4=;
        b=JhBY4KpuTb8AB7KiwzftXNeqirFzEIxFpxEZIiFZzWEFmfZSU94eBuSFZdmf9CZd8y
         uddB/AFRX3Q67r5jexNNnB9kII4vlxzT0b4z8ZJdlPu8y9XP/DV9nItnKNymMYIpfeio
         LlOeMmZyD0/JjjclK0290FZsTxObBB4+M7bKM9QLZHLCi/SMCzZ/bfoH2qKPZW+OY7va
         HVDqA4INsP6zaexrA1AupraSc0OjBvSmM28yXQxOvZAUUTenVeOWgbaD4pm5gbJo6ACA
         ll5pEg8Y/2GL1MzDv7RCmoKkhWP8yQh1vG4hxiYpg6XV4FGqbHnWb6QRSpTq2oLboQ9Q
         NekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793001527; x=1793606327;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qy+l+P3/Ur6+HWnHNoQlQuqGZxsGTPMqagOFnx35yX4=;
        b=jxGtDgmWNoMpvZQ0BQ2zrXhG1/dl1Y7jnrwK6ZB6o+HEY9lmbcjg0OEbWtdUmgnD7t
         H9oLjL2YmF2c7gwqaOkWJS4SM49iESMLVFvqU1GjsIsiku8hsyk80zlgTwpuwyF5ZDWw
         qLzXIU96WnH8undomndz0nrj1Dr3EUlyudx+94285+frYHk/iixZjO9Vr6i8XrAPCW9x
         8jKS840ULdTdeiZ2bo4T/1h6ONH7U8HMN33czYR1+cOFWdqR630dWNl1v0NdFaqml3Bf
         Yt1OfsauxOyVZDrHg9KC5Z7sVKmkYT+AtPhiZphtU6F771Ih84kvYk23TVFsTPmjl69l
         AM/Q==
X-Gm-Message-State: AFq9FYIGYngf0w7cte1xpMxq85zDtHsMU80e+cM0a8+Nl6UhJ8AyRkwI
	2yhb3P6EWqvwwfX3yaWg9uK1CBUnV0MEdHVymFplrQ4NeKFZRrtXBr8hMZaKVrcI2dg=
X-Gm-Gg: AYBFou1B5mnlICtRp2WnkoJ5n8qRKCzi5lTsen6s9hFDg+7LHX+0SoR+4P1x6G5c9oe
	Xoso0LGkJFsztZlCEvAM2QGKC4SQoxxHU4dSfqzDCbFQsAVUoM3jg9pmk03aegIxUJ948AXERF7
	NDvmrTaxRGf0o6IMV1ZAMo76RmB3bYJ2vO/oQBmW8NHxpePOSJ1IxQzB6xL/sGDiH38wdJyEO3z
	JpEvmfZncXKVqCi1X91OTnHeEr/wrX0Ibn9tzHOE0C8gzcSFXzZogZdmi77POtLsWBLpMJrazhR
	fgAEZr6mfUNQMKtYszzdbD1eVOBDov2If6hBx423heNF/ZPsfzn/BVbpl+4tBwT/C+3M6tnoy4g
	oJz/KdtyiLQNdNf0LCEivU8POHWkREASrpIANULmRkE7hrsF9hACqyU4bcDBV8rJimMgZ6xvgSP
	3c+LgHJUs6g2mMnH4J6+51B155qVdJi0tTQbqdzNo0Naix2X2ogDY1os6S+bZRDxef30cIrjypl
	2PBOhkwwv6Q30O/39yNvM0m/WKJIGpX5HoEIYwlIa/E0B0QSE0F4reuA1xbG/5Do5sGKwg/OjtR
	Ix8mTFhU0VXzCLg4NgUcKFhS/0F5G10=
X-Received: by 2002:a05:6000:3102:b0:48e:1ceb:e8a4 with SMTP id ffacd0b85a97d-48e3ed32b8fmr12097363f8f.17.1793001527070;
        Mon, 26 Oct 2026 00:58:47 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7easm15095984f8f.52.2026.10.26.00.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 00:58:46 -0700 (PDT)
Message-ID: <af8e4351-d8ac-43c7-939f-810adf35c760@blackwall.org>
Date: Mon, 26 Oct 2026 09:58:45 +0200
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
Subject: Re: [PATCH net 1/2] vxlan: keep reserved_bits across changelink
Content-Language: en-US, bg
To: Hannes Laimer <h.laimer@proxmox.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261023-b4-vxlan-changelink-gbp-v1-0-f0d13951c09b@proxmox.com>
 <20261023-b4-vxlan-changelink-gbp-v1-1-f0d13951c09b@proxmox.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261023-b4-vxlan-changelink-gbp-v1-1-f0d13951c09b@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 14:14, Hannes Laimer wrote:
> vxlan_nl2conf() derives reserved_bits from the extension attributes
> set in the netlink message if IFLA_VXLAN_RESERVED_BITS is absent. A
> changelink having it set is rejected, so this means that every
> changelink will reset all extension bits and reserve them again.
> vxlan_nl2flag() rejects setting a flag on an attribute that is
> create-only on changelink. So also setting an extension attribute will
> fail before it can un-reserve its fields.
> 
> The extension's header bits being reserved again then makes
> vxlan_rcv() drop frames that have them set in their header as invalid.
> The device still reports the extension as enabled, because only the
> reserved_bits are rebuilt and the flags are just copied.
> 
> A simple reproducer is
> 
>      ip link add vxgbp type vxlan id 1 dstport 4789 local 10.0.0.1 gbp
>      ip link set dev vxgbp type vxlan ageing 300
> 
> After setting the unrelated ageing, incoming packets with the GBP bit
> set in the header start getting dropped.
> 
> Keeping the reserved_bits on changelink is safe because anything a
> changelink accepts leaves the header bits enabled extensions use
> unchanged.
> 
> Ran into this when adding support for the GBP flag in ifupdown2, see
> link below. The device kept dropping packets after some time, it
> turned out it always started after a changelink.
> 
> Tested this by changing ageing by hand on a vxlan device that was
> created by ifupdown2 with the gbp flag, and checking the reserved bits
> using
> 
>      ip -d link show vxgbp | grep -o 'reserved_bits 0x[0-9a-f]*'
> 
> Without the fix I got 0xf7ffffff000000ff after the changelink, and
> with the fix it stayed 0x77000000000000ff. The following patch
> contains a selftest that fails without the fix and passes with it.
> 
> Fixes: e4f8647767cf ("vxlan: Track reserved bits explicitly as part of the configuration")
> Link: https://lore.proxmox.com/pve-devel/20260828134708.692354-1-h.laimer@proxmox.com/
> Signed-off-by: Hannes Laimer <h.laimer@proxmox.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 278d41f58d89..223539099778 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -4488,7 +4488,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>   		}
>   
>   		conf->reserved_bits = reserved_bits;
> -	} else {
> +	} else if (!changelink) {
>   		/* For backwards compatibility, only allow reserved fields to be
>   		 * used by VXLAN extensions if explicitly requested.
>   		 */
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

