Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3744908BB
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573720; cv=none; b=nvsuGNg3j81UbOCEJW++ck3imfewDjJoqZVgcXz9llcc0fmCwEnm6ghCw6X0zU1b+5BUvfVC0xF6WErK9MwMThi2rwKcPUu8IVtDIq52jr5x/rrZ3yZ4bd2B/Tkeb+FfNJ0dYEoIrPDufhn6TYjNS+pGzVdoChE8s8HCupjEegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573720; c=relaxed/simple;
	bh=Sa7xxm2zMFE5SCgr+ViEzsriC03dhZ03gk/boqFiJsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZPSfWJz/RHYPEitCeftyav+KMFAvn6X+DEYdXGh7u7vkjKQo6eVyZmhZPconAF9BG4rTftbC5ZMnBwlQemPYu/t84nSg47H6/M67uwfsFF7i2uQl0LrclIQod3fPijWlgzG0Kdty1RbceW7TY3psyJsbhHp3EFIZQjtnHLmjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QqiR3lFO; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QqiR3lFO"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1484114a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573716; x=1787178516;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o/1LA5vbZhhfpSS34u0uCvZQNNpsX5aZp2MwaACf6dY=;
        b=E49heHIh7dcqoQ6dSLv+hSHZl80waN1tSjXAz2aWySXMSN/X0LtGiOJDWhV3qURsjC
         Vm3TKdwutKrxTSQhw0zim/eCRmBwoxJzo7GHztPHYTAGQwvJYNXAVtMjTkQ2p7lLQb/m
         INZNlCW7UuqHhtRuXAbuTvb5qztO2s4ieZOELKin39Ws0ZagPT/Y4LyZfnbmX07OjBvC
         FIjuZlXygAQT6UmW/0suUxMLUeDxbvsuDPHeicvHs+Gr3Ej9yWfYUhr69fPSWPP99vnr
         m7m+obBopnmGpdLcGpsjKlnIUkXUm6jUM3yzK8J0spUJl9YQhV6ud2uccJWTFJQVWzJe
         PcHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrm0MdBKeAVVsgROs86NgXfzzfXemTWw8jyBXMDEc5VVR6K3MBMJTi+6odfc0UkT8EQWVfbHtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9BilmuZqVoyFq85UnsgutCiFm8A4D1tsk/CEKL4jr3azNZgE
	68ORL5RnSGPAZOdYBDoMG1lQgn1t6fCnNxTS5bB5/lIqN3BS/D1IvUlQ8sVEhS0QgU3txrJkpb+
	Ql79w3Uj8QlPhuaPPA2I/wex7forVSLLVZ7ZVxtR49v9c5OIVu2bCHnSyBHmV+VktmREUbjFojb
	DXUcWlBfk9OaSsyoY66dutLAxUy5kZ/Smc1j9UzC6bsWzRlLlIgaEvDk7az4W2r7+X7uvAKRx7j
	Thra/TH7nLZm/6z
X-Gm-Gg: AR+sD13250Vd8xHNaRW/2C6KgxhbTXVYns/69QxbFIGgAvDqw3s/ram54SmKZwXEWZM
	8l/mesnDgARNQiOSBYGilmqBOp5AVt2fIEgDcI7w3uPn04u8ncJOUpvBBE4YYDSmbhoAVM/L49K
	qmAT9aah9QC6IcNUcuD3aiKYkHJswkf4bZCE3/hIlaj+Ev3R4haH9y5InKjeiYpeXChDc/Byu9Q
	izAPwLcA/7capOQV+z38pp/dN/6BVw9VKiWmFA8Le6HNnn+WjNeEcqPeb3CmweKPSiAyFROwRJS
	73D066hs+Np/oUd2by7b+khGY5ah5jbmuh1a3A4GrRcDenBvqbitiBoe31oG0V48dRlo36xLOOu
	16G/+O4+Zlid3zoFfJKXTZWxor1Sg5UquZK1oeu/Z88q4Zb40JXnejGLCpyz7fzxkh5SJgmbMiH
	qbQnCocUP/GQIMOJMQemnjotQMBB0Q3lvvylXVIH80
X-Received: by 2002:a17:90b:52c6:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-3931e29a980mr1460055a91.20.1786573716146;
        Wed, 12 Aug 2026 15:28:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3931efb831esm195507a91.0.2026.08.12.15.28.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 15:28:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e9a2b95b5so269790485a.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786573715; x=1787178515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/1LA5vbZhhfpSS34u0uCvZQNNpsX5aZp2MwaACf6dY=;
        b=QqiR3lFO8I9oaOAjd2ovUh49BRDFPUcoBjW7wpDCvJ/66jdVVhegiWEB6iVUN+FTlJ
         VzZPE7Fl3CO7Oc1CfrfsTpyPMs5K0t5baooRhlZBBfMSGy4Os42fTCgOlLojfhvsHby9
         PPKs8J+tE2fxSF5S1GR1IztsslZw8SKvMuJYg=
X-Forwarded-Encrypted: i=1; AHgh+Rrfap4JfqbmNbYgiIyu26miP4iQC2nfwPi6rfN4GzpU6aIvDNzKCZdvMuETZsGMttrM3XZmsfw=@vger.kernel.org
X-Received: by 2002:a05:620a:4806:b0:916:10f6:780f with SMTP id af79cd13be357-936bfa0fb80mr154929785a.27.1786573714701;
        Wed, 12 Aug 2026 15:28:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4806:b0:916:10f6:780f with SMTP id af79cd13be357-936bfa0fb80mr154925085a.27.1786573714199;
        Wed, 12 Aug 2026 15:28:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c23a420fsm5971585a.43.2026.08.12.15.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 15:28:33 -0700 (PDT)
Message-ID: <be04045f-6b56-4474-9d05-c40a2c845dcb@broadcom.com>
Date: Wed, 12 Aug 2026 15:28:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Vladimir Oltean <olteanv@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805072641.402-1-strst.gs@gmail.com>
 <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260812205047.ojq2yyjtmoe5gjot@skbuf>
 <20260812220627.r6gesugv2q3s6x2o@skbuf>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260812220627.r6gesugv2q3s6x2o@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/12/26 15:06, Vladimir Oltean wrote:
> On Wed, Aug 12, 2026 at 11:50:47PM +0300, Vladimir Oltean wrote:
>> 1. This looks implementable with some complexity isolated within the b53
>>     driver:
>>     - on any .port_fdb_add(), .port_fdb_del(), .port_mdb_add(), .port_mdb_del(),
>>       compare the VID of the entry with the dev->vlan_enabled state.
>>       - if VID != 0 and dev->vlan_enabled, or if VID == 0 and !dev->vlan_enabled,
>>         commit the operation directly to the ARL, as is currently done
>>       - if VID == 0 and !dev->vlan_enabled, or if VID != 0 and dev->vlan_enabled,
>>         operate on a software list, allocating, deleting or modifying a
>>         local representation of the ARL entry
>>     - on vlan_filtering toggles from 0 to 1 or from 1 to 0, acquire
>>       dev->arl_mutex and flush out all static and dynamic ARL entries
>>       across the entire switch, commit the static ones from the software
>>       list and clear the software list
>>     - dev->vlan_enabled will probably need to be merged with
>>       dev->vlan_filtering, since the vlan_enabled=1 vlan_filtering=0 case
>>       is broken
> 
> Actually this algorithm is too simplistic as I specified it. In this sequence:
> 
> ip link add br0 type bridge vlan_filtering 0 && ip link set swp0 master br0
> bridge fdb add swp0 00:01:02:03:04:05 master static
> ip link set br0 type bridge vlan_filtering 1
> ip link set br0 type bridge vlan_filtering 0 # the 00:01:02:03:04:05 address would be lost here
> 
> Furthermore, the ARL is limited in size (1024, 2048 or 4096 entries),
> and we could mistakenly end up queuing more than we can commit.
> 
> I'm not yet sure what are reasonable amendments that would keep the
> complexity in check. Currently the most obvious would be to do a one-time
> allocation of dev->num_arl_bins * dev->num_arl_buckets, to always keep
> all entries in software, and only the active ones in hardware. But I
> need to think about this some more, as I'm aware OpenWrt typically
> doesn't operate with huge memory budgets.
> 
> I'm not sure that avoiding local copies is possible, because the ARL
> entries don't come from a single source - we have bridge FDB, bridge
> MDB, ndo_dflt_fdb_add(), dev->uc, dev->mc, dev->dev_addr, sometimes
> replicated per VLAN, etc. They all only converge at driver level.
> 

Would not we just be better off with enforcing vlan_filtering=1 for any 
bridge that is created? Unlike Marvell switches, the Roboswitch has no 
notion of egress as tag unmodified unfortunately.
-- 
Florian

