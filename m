Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0C39659A
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464816; cv=none; b=LpbsZsAitZuwHwzEIiN/Myep6iJzTGhqwc92ddVx6Xii0yKXhpp7EZyk6+ra8ko/71lHIOINbC71SKPN8XIxWMdQg6oUSkhf96FNlXKsatNqFD71g8RhKy6avDV8A1O9lb6QkX2exfoxAXXsqGuh4bmUcWAP+ZjRiPmy/ZOS/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464816; c=relaxed/simple;
	bh=qwF8d4vNNFCnN9agV0+J5z2DL43blTty4pDpRo/c9PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMY6QqkJyzYgDVDHtKs3Ov2MY9sCueQGkrLDtIG1hj9F4LVFGRXifOO7ZBydnTzDnBcrpmdjqVIJGDNCLVF73rREZBBbhsNteSfEv9a1D9URK3D5DGOu9N1Y6ULa8Punc8TBfNZCbCP+K5NaMcNQG2i8V5Yuxdf+4QURbc12KX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mq31cAaf; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mq31cAaf"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3900e39d935so78867a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464815; x=1787069615;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B1mcyQU5zL02/TDzlYz/gT52O4+epVO/lG3nwQ2h8yM=;
        b=IybbaAHKfC8KWFybD4bYsqpKDNIu1Np2iXRLxpsNm/2g7HXW1ZqBh/A/bZ6dBGty5b
         9rdoaR1W4HNDBKea4MjG/vVmB5ef9X58HyMV4aM3BhxsEmLqbSvDeApebakrAhEmilvK
         ujqBBOsZpjEI/WPtp8025OFbK0WFsvzI0Iz+CtAOUh/m+4BvZq+zMGdh0/d4GNjjGpbc
         MLzn3r3bcoBqp6eBcN2lN12GDdznVBObnvYxO7BloZOM0mV/M4wF/3L/sTsstg5lNqmh
         AwxgNNTkFVortOTlKFss/PIBVzvzrjR5QbDGIH+nSc495O12Z0RxFqC9DZJuzDxxQAQP
         gyTA==
X-Forwarded-Encrypted: i=1; AHgh+RqaSNAeYo0cEDs5myiAOc1h4d9F594dM5iNwov4PJhC8KRtAYLYnVbsbw2SzarfLx1gKiQUHEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSE/zyMFWmbjXKe8SY2Vl9Dx7durdqGFTY6vKzZ0zZ/I1O+xf
	RzicC7tpGeqlvINQnIq1pu50EjzmsNF0bL8VFh77i6t5slkaF5oXU0H/jce4sC30VhpvLl17oDR
	RGT/VtK+5uCDOIvSxYwTyJpRWflvintZdkK2GPIBaLFvydMtlN7fNQ3lPX74jy1NFrr9JK6XA1n
	QlrSaNJHf8fWGTGmZHP20JgHqRc7waSv+OWEAyZ2xgtmx1aiyqaVoYM44sHXGQOuaI2vqovI2W8
	RbenMyfIQMQXY86
X-Gm-Gg: AR+sD11i0UANgEHCZhtM1/5zzyl8n+IyYkALqAcA0OYANPRhbH8ectLFgTU1n+VQvYt
	s1RIT/KEDAn+yO9yKkZSP9HUStxEwnO4HOtb5O7GrBF/qLMWqV5ctRDfJaBZq+wt4oFx2PzOXHS
	VWO01lzGWmIfr77Ny4moWrrtOIefnxFpBt/ga2BzEtBaFSIMP51b6aIsUC7rYsdOjfi/1+RwQIz
	oCkmmRAx1CCcLyVyp/ZLFR1B4DcdXsRpJrY3GSDSXAh1QgSB+DkzNdjiUSJ/rlfcZR4oPaSQBHC
	AdqNBB0y+sZr3TX9v42FgrA6OAtH+OQHYilGe5pcy9JwGCGrujSp8K3tZ0f4at6swHcLhgJfhjK
	5Q2wc+G9f0fH73k0b/J86wO2U0l5WMHceQFAX+tJMwmxmsLiPE44bZzVzgzCtJjk643GdaxVnoo
	Who2cjbSdlaZpQ5lE+JjZEgkXcK2yPoM0YqyYQIKbBBvM=
X-Received: by 2002:a17:90b:2751:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-392ec557b4bmr5713884a91.13.1786464814503;
        Tue, 11 Aug 2026 09:13:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392f94f18a4sm9993a91.10.2026.08.11.09.13.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:13:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so53570a91.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786464812; x=1787069612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1mcyQU5zL02/TDzlYz/gT52O4+epVO/lG3nwQ2h8yM=;
        b=Mq31cAafMUBnZFnv4wbterSzU02ZyNPg21emVYS5cLevxD3uGXPFWEG5B6bMkannwA
         hdhoudfBkCavwCr3KUjkR7yuLZk3qOVtSNrH51aSmAThkoyZZXQJncJk6zyz7RWUgGew
         E0vJZa197zghRc4XuDKlzVMClzQ9/hNB/bheM=
X-Forwarded-Encrypted: i=1; AHgh+RrFk3x4+0UbsVQoACy4BZ1ya3uD/+iKdYrnkGXmZDARFuYdFXcfAw26IkY1k7tlwVKKAMRbsFs=@vger.kernel.org
X-Received: by 2002:a17:90b:520a:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-392ec2e8461mr5585324a91.4.1786464812299;
        Tue, 11 Aug 2026 09:13:32 -0700 (PDT)
X-Received: by 2002:a17:90b:520a:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-392ec2e8461mr5585170a91.4.1786464811546;
        Tue, 11 Aug 2026 09:13:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628ef6csm1003882eec.16.2026.08.11.09.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:13:30 -0700 (PDT)
Message-ID: <b5bfe3c3-317a-47a8-9cdf-8b9535b6348c@broadcom.com>
Date: Tue, 11 Aug 2026 09:13:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Jonas Gorski <jonas.gorski@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805072641.402-1-strst.gs@gmail.com>
 <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260806102327.wrig23oltjzogyi7@skbuf>
 <CAOiHx=kqmZSM2Vzusc_bcpJfTjJC=jYPgU3wnz_xX+_nnuiNtw@mail.gmail.com>
 <20260810120442.255nahzmurjhi5jn@skbuf>
 <CAOiHx==noeBoE97kgrUm_-HkRNBpEuUVs49r5uFTiUSxWVdL_w@mail.gmail.com>
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
In-Reply-To: <CAOiHx==noeBoE97kgrUm_-HkRNBpEuUVs49r5uFTiUSxWVdL_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/11/26 01:06, Jonas Gorski wrote:
> On Mon, Aug 10, 2026 at 2:04 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>>
>> On Thu, Aug 06, 2026 at 01:09:03PM +0200, Jonas Gorski wrote:
>>>> static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
>>>> {
>>>>          u8 reg;
>>>>
>>>>          if (op > ARLTBL_RW)
>>>>                  return -EINVAL;
>>>>
>>>>          b53_read8(dev, B53_ARLIO_PAGE, B53_ARLTBL_RW_CTRL, &reg);
>>>>          reg |= ARLTBL_START_DONE;
>>>>          if (op)
>>>>                  reg |= ARLTBL_RW;
>>>>          else
>>>>                  reg &= ~ARLTBL_RW;
>>>>          if (dev->vlan_enabled)
>>>>                  reg &= ~ARLTBL_IVL_SVL_SELECT;
>>>>          else
>>>>                  reg |= ARLTBL_IVL_SVL_SELECT;
>>>
>>> This ARLTBL_IVL_SVL_SELECT bit is only implemented for a small subset
>>> of switches (bcm5302x / bcm58* and bcm53134). Additionally, according
>>> to the register description, this also requires enabling "per port
>>> IVL/SVL" mode, which is not enable by b53. The description of that
>>> also says that the VIDs used in SVL ports must not be used in IVL
>>> ports. No idea what the consequences are if they do.
>>
>> What does enabling per port IVL/SVL mode do?
> 
> I don't have access to a datasheet or a device to test, Florian will
> need to answer that completely.

Not a whole lot of details in the datasheet, but essentially what is 
being provided is:

IVL: a given MAC address can only appear in one VLAN
SVL: a given MAC address can appear on different ports as long as the 
ports are not in the same VLAN.

> 
> I can only guess from the register descriptions, which imply that
> enabling SVL for port makes any ARL lookups SVL based, i.e. VID is
> ignored/forced to 0. Presumably this essentially only applies to for
> frames received on that port for lookup / learning.
> 
> There is a global option for configuring IVL or SVL, but this option
> is only valid when VLAN-aware is enabled in the switch. Without it,
> learning is always SVL.
> 
> I do not know how the per port IVL/SVL actually register works, and
> whether you can enable IVL in VLAN-unaware mode (I would guess not).

IVL/SVL applies to 802.1Q (VLAN enabled) mode, double tagging mode and 
individual double tagging mode, so yes this depends on VLAN being 
enabled globally.

> 
> Note that there is no differentiation in ARL entries themselves
> whether they are IVL or SVL entries, only the table index calculation
> changes.
> 
> Best regards,
> Jonas


-- 
Florian
