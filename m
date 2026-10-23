Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749432;
	b=2T92oCeV5IuT1CcTF/TW4Zz2puw/7rQYtfDxfLJTaD2KX5XkNickhz1Ud1MElYM2tLYi
	 aiPAzxmmRvLEvfEAQQOTNcfaFbbJTVxnCfeH2Q9r+t0PEWtcapNR4OA1T0pMNsqZ6HYY9
	 cv9zf4obqZya4zesAPIcBpiiyfkWEYncpG+4EFLmnVRd31TZTE80DYS0e6fKAUQmU/7GB
	 uZarZ940oVwJxfu2wIDKZex47oYYPzg+I5jGMGgyT9YEUXldz053s0sWAAdtt9Mpt2u9W
	 ug4HtAtoSbnWiJDHyWss+ICJD3K7gaxsxAqKqWoCbxa4Dr+4eLoSvYooFidvRSFg73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5zYKXoFoRrW/rjS0dALsJeII0OIOKVqHguJNCNYo2aI=;
	b=uApAzdmrUMf8wsFumlkOsky07tbg9Cn4ggCUGZUmvLiFb/k/ASIpDDiDqAF97Bl+Ofmc
	 rpMPtZa6NV4s8UjBObYyttGd1WdTldmMuvW+hi/8rXg8kBV9LVzOiFWko3zS+ZHz/W5rZ
	 Hp9L5s15pRj0P40oO6nOkMPUuRKw01pPNh5jrbugSPO7ttiMzlCrrO8n1Phdjm0uChbmz
	 mzitQatn4wa+hzAYJjnf+F3uBkW0oT+C0DWSN4K2zn02yPjJ0WvDRSYHQfPxKXwKdHPVI
	 oOE95/Cs3U78KIkOb5N6tWt1x2uA/dHRTuFQmB66gavQMPDxfjr052uTl75HNqFB2tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=lPUKPWt6;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9C606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE9C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=lPUKPWt6
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4be28b82so545794f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1792749430; x=1793354230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zYKXoFoRrW/rjS0dALsJeII0OIOKVqHguJNCNYo2aI=;
        b=lPUKPWt6Hycmbn6IYRhAtJBMMMtFtAg/QHyTDYFareIA8qANZBrOnuKO2bsyCcqKz7
         oL8bBFvkG2pzR6UHOK+06X1Jmc+eQZHAN7xBZ7oxRiY1YDz8I6iBZElzHNpqMo7SzBOn
         y/pjgu4kvTWCLlty4gU7xrkC8OberYR6zMo/xyFl2vIntUlRQ1cZe2rn7BnJd9QGe7eu
         Xorjiy6tTIA32RMvxo5zit8lBYdKS+2WXjfHkpmOOcxnAItWJlnF3dOBp+EcMlTlgbIb
         D1PRW5TFNhg/6OWYNCrEFxkelp/LmO8i9RlhzWtP5YDBu3PgzaMwZIge/afmkAxr1S5x
         Pt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749430; x=1793354230;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zYKXoFoRrW/rjS0dALsJeII0OIOKVqHguJNCNYo2aI=;
        b=nbbJqv73dz04qQku8yfk/zwxFe9iiom4dAQ8ZP0Phf2WHmgYtP0uxzJamaFTPtYs3n
         QtdjeGWq+vF1m9/pEEH0s8Zrf96en+2GZuDLSx2XcWuXZ6QDixn81qLmPy/jAYzfi7Or
         b8QSanqarrZ1I54VKqhfJOK0eWWlcqV5jae2GYLbfCx8i+7/yojbmAqNxTeeSv3q8N4E
         LjJFNHo2S2upsuFApbjFoRPY5dMH6pYzsUTB0ZF9PIDNa5Sk4/tKbZGoanPmG32k4ucT
         XvI64x141p76ghJLR3cTVSIeajFt+uHHUL5nfFzSOgqwSAiNbuxkwKfYX3p05IXM91kf
         Q2Fw==
X-Forwarded-Encrypted: i=1; AKwUvByHxWiApqWdiHzXLSER3BHfrjvBvF4k4k+OAMEyMddurZB4UEmC7OpNr2oNVm4JXv9kqUEgAS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg/Ha/dtx/Sf02Gkpc4aXDAcb1ODs+K0Q7EyUOjjifgwyA+nx1
	9aVa7yKmNmNZl4wC4unagc8BnNLrdP5GWgTdk9zQTDgSJeXzIhNxOslTQzzS96gkURQyUmPJsZM
	zyREe
X-Gm-Gg: AYBFou1gyy0lt+4CTR1b1WNP1E7cyn5mBsTQZpOWWBSvbTMdEaQfMQVd63euM9j/SyN
	Ge4rvPnLn3jxQBLxQdrN2waNAVIsb4YUgLF+d0t0A0juOOVdxxulHSCG3lyZVae/WzLZb4+kJFd
	0zylx0tsKeGCSp8Ey/VNWm+k2eWsfvSaWyN2yC6OH7ql9sDRbDbHX1rTVkwjDrFbAST8fJZ0lPj
	q3rDLR1o2DK9DIaoK8h8TenfNA0VO7YZCyiMjNn2hsVb2mQRlnq2gNLgOk7rcbuvwmmK7BAzrBv
	K0wO7KQoGQzP0GExERlMbRQsk4sqwZ8FJzhkTc+qtvHaXYF465erlr2KwzpnCNZdBoQi4eeAMQc
	cpHv/5F4eiihxfrMzOPJ5hhTabWwdGIP/RtA9M13dXTR3JdXTObaPV4HvUo0G+zJwFVvy4Gur2j
	si04WGwnxt9cPrzcTqt69E5S5lZGeuxnrz6PoUNEbv2VHyMdqVBIqFrU95DJU4+a6Df2hlW54PP
	mL6MDWbPaUtB735RCF1URlOyskfwazLt/0oSejIfKwJXy6Nllyc2c9TUMEF0Cm1HjJd9G99Qrqq
	XPX9uYCViQ==
X-Received: by 2002:a5d:4c4a:0:b0:487:27f9:842 with SMTP id ffacd0b85a97d-48e385b0220mr2207570f8f.55.1792749430068;
        Fri, 23 Oct 2026 02:57:10 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3804872csm3994786f8f.34.2026.10.23.02.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 02:57:09 -0700 (PDT)
Message-ID: <cbcff85c-49f5-4920-94ee-53dc10c9ad96@blackwall.org>
Date: Fri, 23 Oct 2026 12:57:08 +0300
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
Subject: Re: [PATCH net] net: bridge: do not bypass port state for MST without
 VLAN filtering
To: Tobias Waldekranz <tobias@waldekranz.com>,
 Cheng Yongkang <teel4res@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <179268538303.70821.3493915601694605045@gmail.com>
 <877bj8iz0p.fsf@waldekranz.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <877bj8iz0p.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 11:47, Tobias Waldekranz wrote:
> 
> Hi Cheng,
> 
> On tor, okt 22, 2026 at 08:26, Cheng Yongkang <teel4res@gmail.com> wrote:
>> br_mst_is_enabled() is true when the bridge MST option is set and the
>> port has a VLAN group, and nbp_vlan_init() installs a VLAN group on
>> every port even when VLAN filtering is disabled.  While it is true,
>> ingress treats the port as forwarding and egress skips the
>> BR_STATE_FORWARDING check, so that the per-VLAN MST state is enforced
>> instead.  That state is only checked when VLAN filtering is enabled,
>> though: br_allowed_ingress() returns early otherwise, and
>> br_allowed_egress() only checks frames that were VLAN-filtered on
>> ingress.
>>
>> With MST enabled and VLAN filtering disabled, no port state is enforced
>> at all, and a port in BR_STATE_BLOCKING or BR_STATE_DISABLED still
>> forwards traffic, defeating STP and MRP loop protection.  MST can be
>> enabled in this configuration, since br_mst_set_enabled() only requires
>> that no port has a VLAN, for example with default_pvid 0.  In that setup
>> a BLOCKING port kept forwarding broadcast frames while MST was enabled,
>> and stopped when MST was disabled.
>>
>> Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
>> state bypass") stopped this bypass during port deletion by also
>> requiring the port VLAN group; the bypass itself remained.
>>
>> Also require VLAN filtering in br_mst_is_enabled(), so the normal port
>> state checks apply until VLAN filtering is enabled.
>>
>> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
>> Assisted-by: LLM
>> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
>> ---
>>   net/bridge/br_private.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index ff746f036f54..85065304597e 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -1953,6 +1953,7 @@ static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
>>   	/* check the port's vlan group to avoid racing with port deletion */
>>   	return static_branch_unlikely(&br_mst_used) &&
>>   	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
>> +	       br_opt_get(p->br, BROPT_VLAN_ENABLED) &&
>>   	       rcu_access_pointer(p->vlgrp);
>>   }
>>   
>>
>> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
>> -- 
>> 2.34.1
> 
> I suppose the other way to fix this issue would be to require VLAN
> filtering being enabled in order to enable MST filtering.
> 
>  From a user perspective, that seems natural since you need to associate
> packets with VLANs (i.e., have VLAN filtering enabled) in order to make
> any use of MST filtering.
> 
>  From the bridge's perspective it might be less desirable since it would
> mean that the two options would become entangled - the bridge would have
> to refuse VLAN filtering disablement while MST is enabled.

Indeed, that can break users because of new option ordering.
I'm sorry but this is a no-go.

Cheers,
  Nik

