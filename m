Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C07432BE4
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428163; cv=none; b=PXkFxH+bIAjdV7HtzEU9K3fqFpPnX/bjcER0ZZknBJR0LgAqLHjJXnW0DiXXTrtQ+t0+k76EwC86IufeDcmW564cUym/0oVeAlVqgkS5Dws4/TAFKN5AxLHzYnVWHUMBSeWNzmIy42PLnvKax8FIPLVuwzyhrnFAD5pEDmqtwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428163; c=relaxed/simple;
	bh=oPVsqXoZyPeTg36URmaN5Iw3DnLJlzjYxHnkAlYg7Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gjiw+bVD7vCKuYGieAJ4D2+pVLeIuUCMQzuF207725+3b9NtNIlQwww5bUNvML8pHIbp+uB2TdQ65gcxCPBDP2o1+cICz1ES/NRcXwovfXzU0RUEulLTgHuktnDadSBhUBwlkk9Pq/DnKnL9UQrqAndTGf6pOxaY+PVl514dfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLkOi2Mp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgAhsGox; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLkOi2Mp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgAhsGox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788428160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIVrwf02TP+O59kLnBOVNF6PWYsBEmmPNbrz+e5p2HQ=;
	b=PLkOi2MplsqDOUDIt7pNf4JE3Pofp6e6YbLbn5ZhCqJO/lBWX/crAx4TZmmQCDbxA6xsqq
	/nHovelAvRBjwmlTUEA6aDfUVlgL3GydKQcxyAQUwSOcrrl1X++DxVZOdGb5StE8qJkbci
	POcEtiw5rymYys3Pyp5v9BFGt8/LJ2Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-o5H6i-sJOiKitT59Nxepnw-1; Thu, 03 Sep 2026 05:35:59 -0400
X-MC-Unique: o5H6i-sJOiKitT59Nxepnw-1
X-Mimecast-MFC-AGG-ID: o5H6i-sJOiKitT59Nxepnw_1788428158
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495529a93f9so20015395e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788428158; x=1789032958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UIVrwf02TP+O59kLnBOVNF6PWYsBEmmPNbrz+e5p2HQ=;
        b=hgAhsGoxKmxmL0DZ/XDJeOFCA7BGVxLu8PasuoWft+zNfwfAkd3Gqg3RUXgHklV97v
         zeLZbDrXP57HoJ7MON4I89MGw/5I7bPzfGmR4ZMmkJcFGRw0vm62kIL7k4QF03Z6NS3D
         gM8yFK/X8U8NNzYgJWk4oOeehnsatu8z1y/jlVGmAJXL3mXgJ7FyBCvencL0vEwVfsmS
         awPYRIdJWJ6Ses4T5E+RbdgVdzgY4CBpyAt0dJtM8OmbEawpePJZsOOCufsiu2f8kl1L
         YKhmHZF7N0j7hy3t+O6vJu1N/Mec3laRonAFDUvI3x0A/wI6UYkFQemSxZq4G+U3FJ1m
         Torg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428158; x=1789032958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIVrwf02TP+O59kLnBOVNF6PWYsBEmmPNbrz+e5p2HQ=;
        b=LwO3sRfLY3WLaRYzo8ABxEEOiT4XonA9y/H8cGwoqod+8cUd45tvAK1ga8wMvGODHD
         Ylyapqr/jv9EGcj3SxXMqhhEH4beNFeOpD7nt1SoAGkizp6XNi3xUEIxlenMs8gSyWjw
         jsdZKOx3wKn/9zkG8Dhm5f3J9h+Z+kOKWon5f5h1moMU/I6wch9WohGp6ZdlhgTX7Q9y
         CzlnhAMjG65gWy3VSdqVuPztW26Ci08J57BlWyxZsu5wAKBjyRd+TDQNsULtSxYVE2Du
         Po+jU46dk+zZGsUJKfil+aXUTw2oiNQNxqcAIuuVjdVdb+cPfhdqsZnUqlQJTgrdE13n
         CbMw==
X-Forwarded-Encrypted: i=1; AKwUvByRssYWXNTov25GnVCPOIgKCFjhe7kjeIa133ymaotkSxtvPqds0gJb4KHHUF5yNwO6uE30kVU=@vger.kernel.org
X-Gm-Message-State: AFuF++ny1RTMmj1jIDjL/bEuDOVeTzerTJKOza/0o35LdYXPrRWJLv/g
	KXZAZdMnMZJcpbQSa1HS9L+MX6Ux/CJbHfm7l6qcKWchGawsSEmgrP61L6n3cB7XvdmqWExuHYz
	y+qXtJ94lVUylwliUSUe9gmGYpxaQdJbFe9wOLWQoCxLCrIGOVz32ab97zw==
X-Gm-Gg: AYBFou1O09NBJUituMkgI1HKTK7ZM0uPLHpolsLyeW28FrRx13PN38Ohcw9uaqEO4QC
	6mweisd+K1Hc/vED9HYbWifwZrNL7rguyUupsk5vbWmXVXpCINCenKRdjNEj1abUnvCq5wFnXx0
	X5QnDI1xdyHHPM/h5bEmxX2Rn6C36II1GT060oHIo2IvMLlDSBX5V9d/cFfSDuTCVAC7lWv8Sdb
	NF00cGjrXBZI/NjPkWCfEUTuF8saaiOHe/Mto93Of9RskeUhT/REoXD4GvGiJMAJv6tU1oC2xnD
	Sn8A1tLwU2tngpKmbZZvJbTgcWT9NVy2utzIps0L0Mhto+hWXAwv6w6pySnvWZOZmwLTIXDSgUo
	FqMDa2wY9tRdSHrO8UHbLL7DoZ1jFet/pr52GlzaB89x8ZFbjPVRa5MMgp98RLDDZtPntXf8tRw
	==
X-Received: by 2002:a05:600c:4693:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49ce5817d63mr163904705e9.9.1788428158012;
        Thu, 03 Sep 2026 02:35:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4693:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49ce5817d63mr163904005e9.9.1788428157541;
        Thu, 03 Sep 2026 02:35:57 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce55259ecsm81914915e9.2.2026.09.03.02.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:35:56 -0700 (PDT)
Message-ID: <8f1c4df1-726e-4bcb-addc-b1fcf329013f@redhat.com>
Date: Thu, 3 Sep 2026 11:35:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
 colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
 raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>
 <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
 <b8b6db7b-353d-4d6a-b0b6-3b5e1be22008@redhat.com>
 <apbpWrfu3VQu+CUz@devvm20253.cco0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <apbpWrfu3VQu+CUz@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

sorry for the latency here.

On 9/1/26 5:03 PM, Joe Damato wrote:
> On Tue, Sep 01, 2026 at 02:10:04PM +0200, Paolo Abeni wrote:
>> On 9/1/26 1:57 PM, Joe Damato wrote:
>>> On Tue, Sep 01, 2026 at 10:16:54AM +0200, Paolo Abeni wrote:
>>>> On 8/28/26 9:08 PM, Joe Damato wrote:
>>>>>   - Moved bp->max_tpa_roundup_size init out of the early return path and
>>>>>     documented that TPA is unsupported there, as suggested by Michael.
>>>>
>>>> Clashiko quite convincingly elaborates that the above is not enough:
>>>>
>>>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
>>>>
>>>> Could you please have a look?
>> [...]
>>> 3.) "The new assignment sits after the max_tpa_v2 == 0 early return, so on a P5+
>>> device whose firmware reports max_aggs_supported == 0, does
>>> bp->max_tpa_roundup_size stay 0 while BNXT_FLAG_TPA is set? ..."
>>>
>>> Michael commented in the v3 that this is a false positive, hence why I changed
>>> the code from what it was in the v3 to this.
>>
>> This is the comment I referred to.
>>
>> AFAICS the problem is that the driver sets
>>
>> 	bp->dev->hw_features |= NETIF_F_LRO;
>>
>> regardless of the supported capabilities, and that seams to disagree
>> with Michael.
> 
> OK, after re-reading this here's what I see: NETIF_F_LRO gets added with no
> capability check and bnxt_fix_features() won't strip it afterwards. I think
> the fix there is to add a BNXT_SUPPORTS_TPA() test, as a Fixes for
> f0aa6a37a3db ("eth: bnxt: always recalculate features after XDP clearing, fix
> null-deref").
> 
> I can send a separate patch for that, but it is unrelated to this patch which
> fixes a crash on boot for Thor2 devices.

With my limited knowledge of this driver, I thought the report being
more strictly related to this patch, and the fix for them should land
together.

I'm fine with v5 approach.

/P

