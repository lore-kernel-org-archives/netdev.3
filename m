Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C441B36C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798450; cv=none; b=oV8/gqfMVaSpV+GFl0tXDHA87mq9k1M4UvA4e47/M3QSoYvwG46alAF9dbXXvm3S47RPGYEgCL7Or9fFUrgTLpy5S8zNYYRlQXcp/t71A8cfstHCV6tCfDG/rDYuU24+c4AxDrNnKC98eOljva3TyAFsTnN3uKkfcgu5yn0RtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798450; c=relaxed/simple;
	bh=LfJCPXrkCvU4eIADzu4kkxml+HubEsRZjw6OEOvo9zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nK2G+XCZAdRfOa2s+iGqMOQ0505XtDHuiTL7yZH5KOAIFO4Gd3CE3EUORslbVhSslcsbChmppA8EC5DelaY/bQ5QZFmX2mCdK+1czBhS4tDrBm09kCjWD2b2oXSitMrinY8NMUV7t08A2Nl614mTxAPLK7UNB1kew9n4yVrh+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=j/AcdTZR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="j/AcdTZR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so2809215e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784798444; x=1785403244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1pcUHyEXTLP5ioaaGQiLm4UUcHFQIHxMWGMjnBYpmk=;
        b=j/AcdTZRK5BjXg2QeQMdGWZcbQ9qfofvPEtn2NqT4R1KdJXsvHwKf0PjL36oc1F4Y5
         mwGTXel8t1AIDq4mJ1QpmZZ8bOjwp2wFgbensgl9/yAVXEfXrMgIBc43lbpTkZhg1tvH
         003g9odPDiKOZz05JwSBUviYslftxqMYBvaXqZFjGc01hPDL1yFSkuvYoAnoZr+Jjd4B
         f2u2k5EMmjYdb8PyZuUK3RArzOkMr9bpsoc7CzklsRW2bmoXSaNlvwke9N2R4IrWXC8n
         eulZDNJakmR5d9sYH0EtryxNFf81xct8aVRQW0DGA4n5YP7fBgJKEV5k1L2x39PrcvRR
         Irww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798444; x=1785403244;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1pcUHyEXTLP5ioaaGQiLm4UUcHFQIHxMWGMjnBYpmk=;
        b=SQ5x/+5qPSmISGSpeBI3KvEgFq+diqIaT7Ml1XOdhlB2BfeXF7JnPmSkhJCcI3cHYb
         EJqg8DmZ8tE6ZKDDfR0TJH49kf1iyKdkXt/NoAwtcI8J2x1vONUA/dozYo17Bd4d6dbo
         zbH06dXPsZYXVU1/GXn7oweSn3KdNziy+AZySKwVTI9l1FJFIawr1aPej6tWzRyU+psg
         ac3LAYbn7/SlKFKENUZrj5rPfekJ11ldY9HK+pnOILhZpP5Tm2sj2PRzdrZvnZqiIKg2
         6UpZTjtzGqHgFep/UYx4P9JRFiD28Oz/3WqP79YZCNYFB5MkJFP3EiToodiaz/Mt1fzZ
         pUIA==
X-Forwarded-Encrypted: i=1; AHgh+RoULGbKTOCfqu/FtpGiB9fEGHmwrP1gmsCKlHb7tKmu19iaWfXTsJaWz7UleUsHim/A+HNtU38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DiuFzVmenkz5fATc4P/kD1YVCUdF4ri9/XJrlMSyAKxR+9Ex
	6l/pwVXdxLJZJ/sUcbpjCHvVxxbzT1qpYdKqyczMa4VZmtl8/ucmbn8vqFnUFixP9dA=
X-Gm-Gg: AR+sD11NyV6B8br1dsCTUF5wdgm8MMi0/HUYSNHcD4nDthNwEJcnA0L6aj8ro8TWOUD
	U7ZTbcvACdo8gXdvIOE2Eu1g9Qc3FoeLm5sYk9IrcEw3wWvCFMORBzeS2eTHX578LsbUsXozCkr
	c30eDg9GW9fD61Wbezy5aFXd5J1PrjMcjZ5c3RSPmkrszdIT/fCMixcaeWkGthVCgjSzECU7yrg
	96Aq4yUQ13hDjGEP1Xc1ED3hxYsaVvZAphUb9yk1lCxsozve/wn2TYnB1HOK+sbaOWV4TDLo8JN
	vyfAVjK0CKndMBJcg6jJeI6xsPf1vjuqBuWXmC6S3z7NmkeRZIdRRli7lgYCqYDRBbq0yzkj25x
	jWqeUAhsAN6aAP0Wjs0NWtXGYq1/KJsUYgyRbt852LLwh6QCbzeZMVyDQmP5KaLyOLmUO1uVpbr
	SXE3pwCchFVKJ65c3aidqRYfq+NjXLXYHl
X-Received: by 2002:a05:600c:6b6a:b0:495:3f0f:d515 with SMTP id 5b1f17b1804b1-49573cf4d25mr17400085e9.36.1784798442830;
        Thu, 23 Jul 2026 02:20:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm14557268f8f.6.2026.07.23.02.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:20:42 -0700 (PDT)
Message-ID: <d27e9e6d-351f-45e6-914b-3189fb6d3fd7@blackwall.org>
Date: Thu, 23 Jul 2026 12:20:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6 neighbour
 suppression
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "dsahern@kernel.org" <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "ja@ssi.bg" <ja@ssi.bg>, Petr Machata <petrm@nvidia.com>,
 "fw@strlen.de" <fw@strlen.de>, "kuniyu@google.com" <kuniyu@google.com>,
 "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1784463131.git.danieller@nvidia.com>
 <ad48b1da-50bd-4b79-943a-0a3331191b7c@blackwall.org>
 <SJ2PR12MB9008CFB1549DE9F3B7AC23F0D8C02@SJ2PR12MB9008.namprd12.prod.outlook.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <SJ2PR12MB9008CFB1549DE9F3B7AC23F0D8C02@SJ2PR12MB9008.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2026 09:40, Danielle Ratson wrote:
>> -----Original Message-----
>> From: Nikolay Aleksandrov <razor@blackwall.org>
>> Sent: Monday, 20 July 2026 12:31
>> To: Danielle Ratson <danieller@nvidia.com>; netdev@vger.kernel.org
>> Cc: dsahern@kernel.org; Ido Schimmel <idosch@nvidia.com>;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; horms@kernel.org; ja@ssi.bg; Petr Machata
>> <petrm@nvidia.com>; fw@strlen.de; kuniyu@google.com;
>> bridge@lists.linux.dev; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6
>> neighbour suppression
>>
>> On 19/07/2026 16:34, Danielle Ratson wrote:
>>> The bridge implements IPv6 neighbour suppression by snooping Neighbour
>>> Solicitation and Neighbour Advertisement messages, but it previously
>>> only checked the ICMPv6 type and code before acting on them. This
>>> leaves it open to acting on malformed or spoofed packets that any RFC
>>> 4861 compliant node should reject, and the option parsing in
>>> br_nd_send() open-codes a loop that has historically been a source of bugs.
>>>
>>> This series hardens and cleans up that path:
>>>
>>> Add ndisc_check_ns_na(), a standalone NS/NA validator modeled after
>>> ipv6_mc_check_mld(), implementing the RFC 4861 section 7.1.1 / 7.1.2
>>> mandatory receive checks (hop limit, checksum, code, length, target
>>> and option validation). Wire the bridge into it so NS/NA messages are
>>> validated to the same standard MLD already enjoys.
>>>
>>> Replace the manual ND option parsing loop in br_nd_send() with
>>> ndisc_parse_options() and ndisc_opt_addr_data(), and linearize the skb
>>> once it has been validated as an NS/NA message so that this and any
>>> future ND message handling operate on a linear buffer. The first patch
>>> is a small preparatory cleanup that drops the now-unnecessary
>>> skb_header_pointer() fallback from br_is_nd_neigh_msg().
>>>
>>> No functional change is intended for well-formed packets.
>>>
>>> Patchset overview:
>>> Patch #1: drop the skb_header_pointer() fallback.
>>> Patches #2-#3: add ndisc_check_ns_na() and validate NS/NA with it.
>>> Patch #4: linearize once the ND message type is validated.
>>> Patch #5: parse options via ndisc_parse_options().
>>>
>>> Danielle Ratson (5):
>>>     bridge: Use direct pointer in br_is_nd_neigh_msg()
>>>     ipv6: ndisc: Add ndisc_check_ns_na() validation helper
>>>     bridge: Validate NS/NA messages using ndisc_check_ns_na()
>>>     bridge: Linearize skb once the ND message type is validated
>>>     bridge: Use ndisc_parse_options() to parse ND options in
>>> br_nd_send()
>>>
>>>    include/net/ndisc.h          |   2 +
>>>    net/bridge/br_arp_nd_proxy.c |  54 +++++-----
>>>    net/bridge/br_device.c       |   4 +-
>>>    net/bridge/br_input.c        |   4 +-
>>>    net/bridge/br_private.h      |   2 +-
>>>    net/ipv6/Makefile            |   2 +-
>>>    net/ipv6/ndisc.c             |   1 +
>>>    net/ipv6/ndisc_snoop.c       | 190
>> +++++++++++++++++++++++++++++++++++
>>>    8 files changed, 224 insertions(+), 35 deletions(-)
>>>    create mode 100644 net/ipv6/ndisc_snoop.c
>>>
>>
>> Nice set, but I'm curious - any reason not to use EXPORT_SYMBOL_GPL()
>> instead?
>>
> 
> I guess you are referring to ndisc_parse_options and ndisc_check_ns_na?
> The reason is basically that other sibling functions used EXPORT_SYMBOL() rather than EXPORT_SYMBOL_GPL() (ndisc_send_skb, ndisc_ns_create, and the ndisc_check_ns_na() equivalent in mld, ipv6_mc_check_mld()).
> However, ndisc_send_na() for example is newer and uses EXPORT_SYMBOL_GPL(). So it might make sense to use that in ndisc_parse_options(), if you prefer.
> 

Yep, I was referring to those newly exported symbols.
Personally I'd always go for the _GPL variant when possible, but it's not a
strong preference, more a personal one. I was just curious if there was some
particular reason not to be. :)

Thanks,
  Nik

>> Cheers,
>>    Nik

