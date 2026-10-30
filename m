Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385665;
	b=gdudyvIDR0OkkvKGwavyI/9CzNg05hQ9QAmPM3J918iv06dfIW/22XIKI9JJgEXXVej8
	 FjgUeDZrGkUjtcWIfBJXlCjbg2bM7/3/sUSdDAfDldS39AggFW0BFklUOYSGH6G9/uhY9
	 BivQ6Gwcs9W0BywBUT2A+N0c4hBUc99IodV9yCLkdvW4WJYQbeSZHcTS9FZzsYzZKDv1P
	 3LGjHWr15MBhMkWNdcjsctgl8n6/VWTtxQ8dOY17OVoIrxG8gB9sqYT2npjGwxffFYeRd
	 m2tzyRbGBSFXBmhjSAqTKPNZfBGvWYAeWBaNHoqKuP0gHSrN9TRj0dyus6mWnxLMwbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385665;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=1stjC5MEEUdB6YnfDLgu3Q4Fyuo3+ZySytnP5vX+LhM=;
	b=4pqQzhDfE2TGjXsMxOgwAwvG+/hRvaEwiUEoRkrlVudfIFO16YNS+KvUqEA3RJxK6R8o
	 7qx+KaNp25sc6q2vtq20ruWsCOssaZdD9bW+VAEwceFsOfibxxJQNimGcjsp+oVVkvDFO
	 DOBd5Vhi/blfNtKclyfI+uYA5MDt+jMRXRkQKbpdraEWPYE+pHwRkeh8yfkGJshYZG9/f
	 va8bhCdNPRPkdkf8UAeThNXtQ8aS8aVVEqyZtXjQQsF30No+5onke8SsINV1VsgcyzW3G
	 jpQStnqkkxnWoYTm4Zf1Yxqd+4yOxiN4OZRTGyyRPpPyUWQ3u6UeooJ9Tg/VRrfEbTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UxvFFxHb;
	arc=none smtp.remote-ip=209.85.214.228
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A3606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 18:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0A3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UxvFFxHb
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2ea759cc9b6so5459915ad.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385664; x=1793990464;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1stjC5MEEUdB6YnfDLgu3Q4Fyuo3+ZySytnP5vX+LhM=;
        b=F70+vG2fUiuiv/Z+n0nAY+5z/T2PvR/VmprfIau7AAUW3x3MpGFMpFsyJzhkb1Idb3
         fOKEy+GmEU0nr0bqa+0ZI80u3EfQ0YXxRWvWmXjLEuKQEs2lCUrn7pKCjo9jXlKKW+BG
         IR7y5HmAOyjOOuDnniC7it1zcFFtTcr6Yn6cI2e3q+15eeKlf5yE6BhqoXnSazE7n76n
         g7LsmBk5XwmsXOY622sNwe9MVUsP/u7zC6Q3hGytfOqtv+F22GqLW8ByjXMcmmSoASSW
         D5X9tbjYM/OBSSc74ycXdG9vCeTHnEBsvl2exALQCBniS0Ou/RdTpRi7OvesdDxBKN5M
         y9RA==
X-Gm-Message-State: AFq9FYJJdBbVao9sFzz3w8WoOq6qHawP8iVdnJqDruTjCGznq9mk110Z
	b6migO3U7RBCSr+0GuxEZKSEtkf81mtFI3klKQi4mYjb9r39vfri7ekD/fhMxN/ymKvA6UcLsAy
	X/+bQFhkpDxT/B8THE5yjNK+lTz8i6xhwh1lOvGRB60mZTpHUxyecQdYXlJ8n8xlM35QdrXB3oC
	jOhT8mlemNa/E9RMT44l26bJf5Rog99OuCplnu/QpxwEtZk5YOG7ipo9TMMHqb4jF5e0hV35qR4
	3Z3JSgxiWWgYLYP
X-Gm-Gg: AYBFou2Fkz+Z9Pw9QQCYmw4npscYpxylix6+UuDT7wpVGr4Drm/PfkfiI5LNfEFAyxY
	WcjqYyxrqgos3s8MVpmh7I3IwgfVLOyHvmQfpMLIfOKdCYIMeUmxVlRYIgOn+tUVAVaP9jHLBjT
	299jVJWpoptE9d19V+YUw+ctPyrtN2O0A8c/pQG35Fi3XkXID2oER2FhlMol/Y6oYU1IR8zQUbn
	+sRyiI1bFoNhObPx8NLpK6o4ZDmbdEhYGPyy32x4cxusDFNB166Bkl9IkNNWfEMSFSTYEh/wmtE
	XCcd1u7aKiMmiHvGflj7z0ZlG+0gTs6/oRNM/y0BpAWMd0r5wex9UFtBmTSMSam9VKn+Z5jvRgL
	1oa9rv82qyHnmqjJAo4qN8HLjQ4eI8su1O1qHw4nmeonsaEqg84MWM+ll2OR0u93CG8oWIH5ZEK
	UEOlgQkS4Y7zkhqCWVPQms3AdcRsdnV8Uwz6OYbFmJ
X-Received: by 2002:a17:90b:4487:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3ae897ec740mr2702094a91.67.1793385663775;
        Fri, 30 Oct 2026 11:41:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e80415bsm4512664a91.3.2026.10.30.11.41.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:41:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ce7a85f04so200084185a.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793385662; x=1793990462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1stjC5MEEUdB6YnfDLgu3Q4Fyuo3+ZySytnP5vX+LhM=;
        b=UxvFFxHbCjcY38N5V7v91Vd281Sv9EwgqC5pk4lZm5b3+YhnwoCsMIgrZzkNbLhRKN
         eZTRmkhMwSeNz2egZjnPxLBKkaDWmIgXowBlmqnY6PI7bCS1ul/KEL/l6JsLvcwIuGrk
         w3sKSh3Ou3qa2MKgIteM8okzEduUhBjm03Z+c=
X-Received: by 2002:a05:622a:1f90:b0:535:a5fb:645b with SMTP id d75a77b69052e-542b83f7705mr44267691cf.70.1793385662177;
        Fri, 30 Oct 2026 11:41:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1f90:b0:535:a5fb:645b with SMTP id d75a77b69052e-542b83f7705mr44267321cf.70.1793385661494;
        Fri, 30 Oct 2026 11:41:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54312a571fbsm19590271cf.23.2026.10.30.11.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:41:00 -0700 (PDT)
Message-ID: <c5060273-81ab-492f-9b9d-2ac1785d3146@broadcom.com>
Date: Fri, 30 Oct 2026 11:40:57 -0700
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
Subject: Re: [PATCH net 4/5] net: dsa: b53: reject conflicting mirror
 destinations
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org
References: <20261027202230.3539646-5-florian.fainelli@broadcom.com>
 <179334873083.3134.3549069956742693590@kernel.org>
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
In-Reply-To: <179334873083.3134.3549069956742693590@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/30/26 01:25, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 3 (1) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Only one capture-control read is checked; the other register
>    reads in the mirror helpers still ignore errors.
> - [Medium] The new check in b53_mirror_add()
>    (drivers/net/dsa/b53/b53_common.c:2553-2558) treats MIRROR_EN and…
> - [Medium] b53_mirror_add() ignores the results of both hardware writes
>    and always returns 0: the source-mask write `b53_write16(dev,…
> - [Low] The commit message justifies the b53_mirror_del() hunk with
>    "Clear the capture-port field when the final source is removed so a…
> 
> Pre-existing issues:
> - [Medium] b53_mirror_add() does not reject a second mirror rule for the
>    same source port and direction.
> 
> --
> 
> net: dsa: b53: reject conflicting mirror destinations
> 
> This commit makes b53_mirror_add() read B53_MIR_CAP_CTL before it touches
> the source masks. If mirroring is already enabled toward a different
> capture port, the new rule is rejected with -EOPNOTSUPP and an extack
> message. b53_mirror_del() now clears the whole CAP_PORT_MASK field along
> with MIRROR_EN once both source masks are empty.
> 
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 0871a10d8cbc7..b8a7b380bac87 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -2543,7 +2543,19 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>>   		   struct netlink_ext_ack *extack)
>>   {
>>   	struct b53_device *dev = ds->priv;
>> -	u16 reg, loc;
>> +	u16 reg, loc, cap_ctl;
>> +	int ret;
>> +
>> +	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &cap_ctl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if ((cap_ctl & MIRROR_EN) &&
>> +	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Only one mirroring destination is supported");
>> +		return -EOPNOTSUPP;
>> +	}
> 
> [Severity: Medium]
> This check uses only MIRROR_EN and CAP_PORT_MASK in B53_MIR_CAP_CTL. Can
> that register hold stale state that this kernel never programmed?

Yes, in theory. Not all supported switches are reset during setup. I 
will explicitly clear capture control and both source-control registers 
during b53 and bcm_sf2 setup, checking each write.


> 
> B53_MIR_CAP_CTL, B53_IG_MIR_CTL and B53_EG_MIR_CTL are only accessed in
> b53_mirror_add() and b53_mirror_del(). Neither b53_setup()->b53_reset_switch()
> nor the bcm_sf2 setup paths initialize them.
> 
> b53_switch_reset() only does a soft reset for is539x() and
> BCM58XX/BCM583XX, plus a reset GPIO when one is wired:
> 
>      b53_switch_reset_gpio(dev);
> 
>      if (is539x(dev)) {
>          b53_write8(dev, B53_CTRL_PAGE, B53_SOFTRESET, 0x83);
>          ...
> 
> On chips like BCM53115/53125/53128, BCM5325/5365, BCM63xx or BCM5301x
> without a reset GPIO, mirror state left by a bootloader or a previous
> kernel survives. kexec is one example: dsa_switch_shutdown() never calls
> port_mirror_del, so the old kernel's tc mirror rules stay in hardware.
> 
> If MIRROR_EN is left set, every rule to a different port fails with "Only
> one mirroring destination is supported", even though no mirror rule is
> installed.
> 
> Adding and then deleting a rule to the stale destination may not clear
> it either. b53_mirror_del() clears only BIT(port), and it clears MIRROR_EN
> only when both source masks are empty. Leftover source bits for other
> ports keep MIRROR_EN set.
> 
> Before this patch the destination was simply overwritten. Should the
> mirror registers be reset during setup, or should the driver track
> installed rules in software?
> 
> [ ... ]
> 
>> @@ -2554,11 +2566,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>>   	reg |= BIT(port);
> 
> [Severity: Medium]
> This is a pre-existing issue and wasn't introduced by this patch.
> b53_mirror_add() accepts a second rule for the same source port and
> direction. What happens to the remaining rule when one of the duplicates
> is deleted?

Agreed. This predates the patch. I will include the existing "net: dsa:
b53: reference count shared mirror source bits" fix from my local 
b53-fixes. This preserves support for multiple rules sharing one source 
and destination. The destination check remains ahead of reference 
increments, and the first reference is recorded only after both hardware 
writes succeed.

> 
> dsa_user_add_cls_matchall_mirred() passes every matchall mirror rule to
> the driver without a duplicate check. Each tc prio gets its own matchall
> tcf_proto, so two rules A and A' (port 1 ingress to port 2) can share one
> hardware bit.
> 
> Deleting A clears BIT(1) in B53_IG_MIR_CTL. If no other source remains, it
> also clears MIRROR_EN and CAP_PORT_MASK. A' is still reported as offloaded
> but does nothing in hardware.
> 
> A later rule C (port 1 ingress to port 4) then passes the new check, and
> A' traffic goes to port 4.
> 
> mt753x_port_mirror_add() and qca8k_port_mirror_add() reject duplicates
> using software masks:
> 
>      if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
>          return -EEXIST;
> 
> The new check assumes MIRROR_EN reflects the live rule set. Would b53 need
> similar tracking?
> 
>>   	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
>>   
>> -	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
>> -	reg &= ~CAP_PORT_MASK;
>> -	reg |= mirror->to_local_port;
>> -	reg |= MIRROR_EN;
>> -	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
>> +	cap_ctl &= ~CAP_PORT_MASK;
>> +	cap_ctl |= mirror->to_local_port;
>> +	cap_ctl |= MIRROR_EN;
>> +	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
>>   
>>   	return 0;
> 
> [Severity: Medium]
> Both b53_write16() results here are ignored, and 0 is always returned.
> Can a failed write leave the hardware out of sync with what DSA has
> recorded?

Agreed, also pre-existing. I will propagate both write errors and 
program the capture destination before enabling the new source. This 
avoids adding a source before a potentially failing destination write.

I will also base destination conflicts on the two source masks, rather
than MIRROR_EN alone. An unsuccessful final capture-control clear then
does not block a new destination when no sources remain; conversely,
remaining source bits prevent changing the destination even if MIRROR_EN
is clear.

> 
> b53_mdio_write16() can fail before the target register is written, either
> from mdiobus_write_nested() or with -EIO from b53_mdio_op(). SPI and SRAB
> writes can fail too.
> 
> Suppose the source-mask write succeeds but the B53_MIR_CAP_CTL write
> fails. MIRROR_EN stays clear, but dsa_user_add_cls_matchall_mirred() still
> adds the rule to mall_tc_list because 0 was returned. A later rule to
> another destination passes the new check and redirects the leftover
> source. That is the redirect this patch is meant to prevent.
> 
> The final B53_MIR_CAP_CTL write in b53_mirror_del() is also unchecked. If
> it fails, MIRROR_EN and the old capture port stay set with no sources, and
> the new check rejects every other destination.
> 
> Should these writes be checked, with the source bit rolled back if the
> capture-control write fails?
> 
>>   }
> 
> [ ... ]
> 
>> @@ -2595,10 +2606,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
>>   
>>   	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
> 
> [Severity: Medium]
> The commit message says the patch will "propagate a failed
> capture-control read rather than making the decision from uninitialized
> data". This capture-control read is still unchecked, though. Is that
> intended?
> 
> The b53 backends leave *val unchanged on error. b53_mdio_read16() returns
> before assigning it:
> 
>      ret = b53_mdio_op(dev, page, reg, REG_MII_ADDR_READ);
>      if (ret)
>          return ret;
> 
> b53_spi_read16() only assigns on success.
> 
> reg is reused here. If this read fails, reg still holds the other
> direction's B53_IG_MIR_CTL or B53_EG_MIR_CTL word, and that word is written
> to B53_MIR_CAP_CTL unconditionally. The source bits land in CAP_PORT_MASK,
> and the MIRROR_FILTER bits land in BLK_NOT_MIR/MIRROR_EN.
> 
> That usually clears MIRROR_EN while rules remain. A later rule to a
> different destination then passes the new check in b53_mirror_add() and
> silently redirects the remaining sources.
> 
> b53_mirror_add() has the same problem, and there reg is uninitialized:
> 
>      b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
>      reg |= BIT(port);
>      b53_write16(dev, B53_MGMT_PAGE, loc, reg);
> 
> If that read fails, stack garbage ORed with BIT(port) goes into the
> source-mask register. That can mirror arbitrary ports or set
> DIV_EN/MIRROR_FILTER. MIRROR_EN is then set and 0 is returned.
> 
> Later deletes only clear BIT(port). The stray bits keep MIRROR_EN set, so
> the new check rejects every other destination.
> 
> The earlier reads in b53_mirror_del() that set loc_disable and
> other_loc_disable are unchecked as well. Should all of these reads be
> checked?

Yes. The statement about propagating a failed capture-control read 
referred to the newly added read, but the other unchecked reads are real 
bugs. I will check all reads and writes in both helpers. Since 
port_mirror_del returns void, deletion errors can only be logged; a bus 
failure can still leave a source enabled, but subsequent adds will 
respect that source's
destination.

> 
>>   	/* Both no longer have ports, let's disable mirroring */
>> -	if (loc_disable && other_loc_disable) {
>> -		reg &= ~MIRROR_EN;
>> -		reg &= ~mirror->to_local_port;
>> -	}
>> +	if (loc_disable && other_loc_disable)
>> +		reg &= ~(MIRROR_EN | CAP_PORT_MASK);
> 
> [Severity: Low]
> This isn't a bug, but the commit message says:
> 
>      Clear the capture-port field when the final source is removed so a later
>      rule can select a new destination.
> 
> Is this hunk needed for that? The new check in b53_mirror_add() only
> applies when MIRROR_EN is set, and b53_mirror_add() always rewrites the
> field:
> 
>      cap_ctl &= ~CAP_PORT_MASK;
>      cap_ctl |= mirror->to_local_port;
> 
> The old reg &= ~mirror->to_local_port already cleared the field whenever
> it held to_local_port. Could the commit message call this a cleanup
> rather than a requirement?
> 

Agreed. Clearing CAP_PORT_MASK is cleanup of the inactive configuration;
it is not required to allow a subsequent destination change. I will
correct the description.

pw-bot: cr
-- 
Florian
