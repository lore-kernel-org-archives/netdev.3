Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2C18C332
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791506006; cv=none; b=ETJDDza6M69mP1ma6wcm01Vo+bzSziS1eNhnThgXNtNZi4ByUHtVX+PqtFiGEA6c9mrLutHR989ecJXIpScM22dQP+0m20W5HhO3vBJYeU1xqkcuPUEhc2EA4h/Fzt4dOTHBXOfz3LD8P9y81PLX7zAAY+DBAZP6U/ZA5LsVJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791506006; c=relaxed/simple;
	bh=tLxly1l3ceBAGr4orqnETS8JLirkhyamdVYxgp8LSmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWm4dIOZEYB4TssCVTN+011/TfnKSZOnp1I3veGGkqBmxiOvpYLMPdhYS3ap3c4R8nF9FST8WlWMAz6gIAOpj0LKXT/0HtuMr/NNelju/FZpYxMNOxl1qPAIiXcwpv0L0v5FwmRSroQ6xZK7Fpo0/IAc3V7BcgEU9dEVnOrSTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VT+c4R2J; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VT+c4R2J"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2304018f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791506002; x=1792110802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrTjznnJCo2HMM1jospqmjPYi/FLEPfvic8fnZ+1zoQ=;
        b=VT+c4R2J5ikNYemtj3vMpS0ABFm1vjpku6r/D1p7PuSdKKHSeMfHFSTuvBKzoQWNZ4
         KwpfKyvs8V85TR7Y6c6yRtOuKjuzyCJ/4BHaS72US1b8++NXjWGGXdYXj24miTinwFhQ
         ytahK9+NlQ8mBHFNkgkjvMk+kQ2d3PBzZCPlysaCCBR8KI+ZmVDhDGCMEGuHX6ya8Rtx
         Z0/zJK9KYNlJxFV/n8KzJhz3wcUw0iFrniG96J86ra8hNtt3Q92SQJXZsbBsGPl4Z5Lh
         HTP1i0NyNdVSsA8tI3898oTq5K/iDlcOuqmFw6LxQPx8CvH1KjGBjWNdkvZokCQ+yxu0
         oYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791506002; x=1792110802;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xrTjznnJCo2HMM1jospqmjPYi/FLEPfvic8fnZ+1zoQ=;
        b=QmdDiTfhyUcFTnOkNC5GKR96Hc8pmaJ0N3T0wiLYRGn7+CI7v7ZNwwuxXk7Zb3BZf3
         2KbAcclEoNe+2R1fkz+52AamuPvp2B9goJ+PL5vhZP3MvfcA1zXFaaPuwn8Wiu9H0R55
         RjC+7wS6ZMODLqgzLiFd6nmj4Uq6chJmD6M4mNyc6edpjcaMXOuh5FCilokzo2cKtFoO
         wIwhXnSFji9rLjCPplb5uFy0p69dWxqZNVXvegyUxWWql5rHxAyPephSr6NExSbeqL2e
         rAjRFG0kpIf3YIQrnrcSZY7iS3FxQFzZnoTYitiIlixLIP/iwBi0955zC2a1LmpXuqW3
         +qtQ==
X-Gm-Message-State: AFq9FYJ5NUNDBK2tZODOy/Z8hjlwoiVc4Qgs7d24fl9bwWGVb9b51ef/
	0DCG2ZduBfxjk85XlBGGP4c2/QhKRMwZIINjPl+99NK5jHAKKm7ySvlozJLA00DFBile0vN9fLy
	lxcPLQKyuKF5JHRQ+fKWo1HQxX3BxsBHuN+m0oWU/R+gkpOF96oShY6l/LJ2/BhRQLzw=
X-Gm-Gg: AYBFou0WuY2pJFZvuiaDj6dL3FrDhE6nTbx4IQA7FQsvDjmljX8/c2jcAtCj3Ds4CuL
	+xQdU2Z6Hn3jM8EqUUJ8ZtkiiHRMk4YdEjfHAwzqSxMurdcdE4IRVpyWXcWF+1+2eDHqWOuV/O3
	51Vg/0w71696x5SeoXDRJofQVRFLPY9noMezaX3UR9nR1DL5ZoGDbtfKhrI3GP9mo60Wnz/KJjT
	xdO3p9PiPxqNX81O2B34hM6x5haIJWGymNP+DZR2eGeVCFx09jTXKbkigbypVf92XNX7gWA1Nw9
	3g/mb7XpZGM8TrHk9WXA2ur5pua29zylo6ntMYWftIAIgpeYf+lImrnd7xaH7JvrD6zpWTBrIL3
	CqtUqaaiGHWOPQ6PRlxx0Aft2/v2P4G5bSpKzvlQhu30T80O7dIfnZXpaGlpmLPkh9rBYItsZQE
	ZXnhIQQEqmPaTyi+LjilVJAvHISuiV+yoxmIDnAje9CwhSvwfXz3e7S0NReebSyeEiCSDaFG65Y
	WgOxFFPREDJf08Tlq6h5I3xJKKQiO43vw==
X-Received: by 2002:a05:6000:29d5:b0:48b:11d7:f3cf with SMTP id ffacd0b85a97d-48dbad4b747mr218125f8f.54.1791506002158;
        Thu, 08 Oct 2026 17:33:22 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:23e:b027:3a6e:6d79? ([2001:67c:2fbc:1:23e:b027:3a6e:6d79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c3a13sm898871f8f.25.2026.10.08.17.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 17:33:20 -0700 (PDT)
Message-ID: <375bc468-fb28-4620-a5c8-0f7ba9e693d6@openvpn.net>
Date: Fri, 9 Oct 2026 02:33:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB
 changes
To: Ralf Lici <ralf@mandelbit.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <0c6f073c-12c7-4843-846e-69c48c290107@kernel.org>
 <20260929150454.466148-1-ralf@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <20260929150454.466148-1-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/09/2026 17:04, Ralf Lici wrote:
> On Tue, 29 Sep 2026 08:09:46 -0600, David Ahern <dsahern@kernel.org> wrote:
>> On 9/28/26 3:56 AM, Ralf Lici wrote:
>>> Hi David,
>>>
>>> Just following up on this. Does my previous example clarify why storing
>>> an old dst with a new cookie defeats reuse-time validation?
>>>
>>> If so, would you prefer that I pursue the kernel-wide lookup-provenance
>>> approach described in the RFC, or keep the fix self-contained in ovpn?
>>> The same late-cookie-sampling pattern is used by several drivers and
>>> callers in the networking core, so I think fixing it generically is the
>>> better architectural choice.
>>>
>>> If changing the generic interfaces is not acceptable, I can rework the
>>> patch as an ovpn-local fix, although that would duplicate IPv6 routing
>>> details in the driver and leave the equivalent pattern elsewhere
>>> unchanged.
>>>
>>
>> dst's are cached in lots of places. Why does ovpn need internal routing
>> details that the other places do not?
>>
>>
> 

Hi David,

ovpn maintainer here: I wanted to back this patch.

You're right that a cached dst can go stale later and that reuse-time
validation handles that. This case is different, because it breaks
reuse-time validation.

dst_cache_set_ip6() samples the cookie itself:

         dst_cache_per_cpu_dst_set(idst, dst,
                                   rt6_get_cookie(dst_rt6_info(dst)));

rt6_get_cookie() only returns a route-tied value when rt->sernum is
non-zero, which happens in ip6_rt_pcpu_alloc() and only for nexthop
routes. Everything else reads the current node generation:

         *cookie = READ_ONCE(fn->fn_sernum);

So if the FIB changes between ip6_dst_lookup_flow() returning D0 and
dst_cache_set_ip6() reading the cookie, we cache D0 with cookie C1. At
reuse dst_check() compares C1 against the node's current C1, they match,
and the stale route is used until the next FIB change.

Which invariant stops that cookie read from seeing a generation newer
than the one the lookup used? If there is one, we'll drop both the patch
and the RFC.

Regarding the layering, I agree. rt_genid_ipv6() does not belong in a 
driver.
That's exactly what the RFC [1] was for, but it's had no feedback so 
far, hence I suggested Ralf to pursue this other path.
The late sampling lives in dst_cache_set_ip6(), not in ovpn.

Happy to confine the IPv6 bits to a helper, or to revive the RFC if
you'd like review it.

Please also note that the workaround we're looking at is already 
implemented by other drivers, which they all could drop if we'd be able 
to provide an IPv6-generic solution.


Please let us know!


[1] 
https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/

Thanks,
         Antonio


> Because, as explained in this thread and in the RFC, there is enough
> evidence that the current IPv6 dst-caching pattern is racy. If other
> kernel users are expected to live with that race, I cannot force a
> generic fix, but I do not think that is a good reason to require ovpn to
> do the same.
> 
> If you believe the sequence I described is safe, please explain which
> invariant makes it so.
> 

-- 
Antonio Quartulli
OpenVPN Inc.

