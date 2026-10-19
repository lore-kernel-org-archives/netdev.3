Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4B53C006
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418340; cv=none; b=CAQcsXTS755cG/3yylCRvv5v9PLaaoyJXmnLnZ4zQbg/7ZfRLSh8erL32iM6dkKFjgbVPQInmtXBuVpv7SMjtV+UHo5rZ4V5nzpWpr5pcGEl6Cv8bY7gOjqfemnMVwviUsa1FJG9Jo0qke9TFOoLZdjMl56oQGeC5SEvNLNBV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418340; c=relaxed/simple;
	bh=eeR+YZJBKyRXdaeJ6AIUv+gvz+HIWjXW6ahJQBsoQ64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbY7oEaiXcbtk0XcLPALiOWq6KCqvsewTWOEJbcwpMlkFctOqNsyNoo8EPRUUOJXnsB8Zfh2OG31U9XQtPjMzhY74h4683UGMBlmsnL/62dcoCmBjHf4xWYClFMRl/L0NJXtZwYad/OPoqU6Y+/LW0MaAvkID2UQy/rEwtRAw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGuSBvgM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kN9GuEZC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGuSBvgM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kN9GuEZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792418335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Binz/gpW0m2PKvpaHlvPvNhvy+OxvmaqCnxb7ANAvMw=;
	b=EGuSBvgMuWBs2ZZHiMuOhsEIuVczjXSi6NCpjdHRgAntjIbsb/B9pxq9fViuJ2KjyqbLVL
	vwGsVJYUdcGExQ+1NoxJoy8cJ8GcPFLlpHsZ87ZbeMdBNSUZOatDAkwFoCARs1PDOkpXKK
	8cnzCB4Siv1eTwAWqjUgIIl/UT1ALNs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-DZ3TnWVxNrCRqO959Ok2xw-1; Mon, 19 Oct 2026 13:58:54 +0000
X-MC-Unique: DZ3TnWVxNrCRqO959Ok2xw-1
X-Mimecast-MFC-AGG-ID: DZ3TnWVxNrCRqO959Ok2xw_1792418333
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1bfd5516bso21893585e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792418333; x=1793023133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Binz/gpW0m2PKvpaHlvPvNhvy+OxvmaqCnxb7ANAvMw=;
        b=kN9GuEZChgd7vO74EotFhELaX7F2w4uCVwFOIHlFxim4BrosloXydl8c+PvjpM88/t
         f0A+jnd/VQIDfUehhpNU/Yuvmo7zByDgFthN9IfATTMrjXc9sgtKEBxWIscWo0NVQzOR
         eSiQUG16B9rwYMA4XYccEURV5UaCPEdkepYmBgV6FOaDj2JOrVFK4/Sov8H/CyH4dL5X
         ZE+t0yLCilZgawVr9usci3GYfaM6JPGcpXMAEsTlbj9/6fyPhrVhgI8UAtMDFq2m3WFi
         aQehqBP0z61i8R6T4aqygqFKyPUNszl6Q6GpdpzLE+HbUbihWyX6ck/FyTWE67nC9o+h
         UCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418333; x=1793023133;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Binz/gpW0m2PKvpaHlvPvNhvy+OxvmaqCnxb7ANAvMw=;
        b=vy4JG5FdvlfR2XBhET04UNAd18Vvxxu9O4tYSdM38+hBxKtRK4aYApV/h1J1QVQeDz
         GYaE7aW7EacOhLujPpE5pu4uOoTGbn8qCiNbL0JAoF4pU9NpHxaO2JNEyFa4fQBYYBSf
         DdtBklUzZUoPYCAm9aoMI9B0Yh7puYPS0sAJ7VZCN05hdSeHeh9AwKkjZY5sl8iZXeKr
         56O8C81xSfOFK4wzb6ZfPw1FtKl8vtOLk9imMC/prTBcjH4m/tfNV/bVWrBEvwIp/esN
         UudSSqH/2avGODZ69osWbf33N7PXt6zn6LsjBklwI6PyrRs6IO4I+iKpJOGAY88RX50v
         +lJg==
X-Forwarded-Encrypted: i=1; AKwUvBwPkHXDzSAJfbn/qm8Opt0dkN/SWDV6ppm8cNwQaniwhvW3p/tDCxII/O5O/hrlKrDI+KDdFfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3Ox4etnVDSgCcraoPpqFq1C54+QsjMp9TYUNpao+XWBVQrXaS
	YIpw1z/JRzaqVbVG53aXT011751EFla64xbEnRGDdSMy75FbCyiHLwcwsVRKvpNf4iHBZuMq5JN
	XDtvserNO9p6HDKOqiQHa4KuuNsqSCNB4CnTfFBrGUDRl25LkzTE0USRovQ==
X-Gm-Gg: AYBFou1R3tYK2nGMMh0YABLZsXl/rxglM87f2XYEMSJe0z2fNYM11KNXDXZvtTaPk1Y
	nrgm8aODyrU4fhoShW420j+3xl/Qks4tZkZ+YdYNDHyMYH6lcTKCwEBGXXwAZ/GmkxQyvZueFOY
	odwFxQW63zFoSiZWDc6cOH2IpFGIwKdJYYyz9je6huBuufuKnSfdsU/sRmyV8TSyebIb263DXEy
	FrvnskD1bGOTGX+9d7ZAyiIxqLT7LvckITKDPKHv+Pq8lZeliYFAOX60gY522Mz4YhGQ8hZPcy/
	7FMl1tBGt/Hs0Hoon0XRxrDCT1UDi/muM1hnqGaqQ+5hHirPYiPRBm2BciNvSnb1QM0Lri0fyN6
	r1WtNDVF5OJqvZHUN7zjMgXEYhlZ4NsnRuhtF4BVDHBCPtmpQTUCqkBW4UqbT0AN5uznFgvZG8A
	==
X-Received: by 2002:a05:600c:1392:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1d75aa87cmr183283395e9.2.1792418333254;
        Mon, 19 Oct 2026 06:58:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1392:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1d75aa87cmr183282645e9.2.1792418332509;
        Mon, 19 Oct 2026 06:58:52 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce325107sm232471225e9.3.2026.10.19.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:58:51 -0700 (PDT)
Message-ID: <6ecdd152-36ea-4ddc-8c41-d74f7fadd497@redhat.com>
Date: Mon, 19 Oct 2026 15:58:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev-bot+sashiko@kernel.org
Cc: jiri@resnulli.us, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, yaojiale02@163.com
References: <20261013083523.4728-1-socketcan@hartkopp.net>
 <179196707247.434549.3372737964220312421@kernel.org>
 <bf99c42f-92eb-4e4f-aba4-1aeda5b84f65@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bf99c42f-92eb-4e4f-aba4-1aeda5b84f65@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/26 13:49, Oliver Hartkopp wrote:
> On 14.10.26 10:37, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] The new denylist in team_port_add()
>>    (drivers/net/team/team_core.c:1228-1236) only rejects ARPHRD_CAN,…
>>
>> Pre-existing issues:
>> - [High] This problem wasn't introduced by this patch, but the bonding
>>    driver, which the commit message cites as the precedent being…
>>
>> -- 
>>
>> team: reject CAN and IEEE 802.15.4 devices in team_port_add
>>
>> This patch makes team_port_add() reject ports of type ARPHRD_CAN,
>> ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR. Team never sets up the
>> private mid-layer data these L2 types expect, so enslaving one leads to a
>> NULL pointer dereference. The check mirrors the CAN check bonding has had
>> since commit 8ba68464e478.
>>
>> Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
>>
>>> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>>> index ca75f08e3c593..5f1708c2a3445 100644
>>> --- a/drivers/net/team/team_core.c
>>> +++ b/drivers/net/team/team_core.c
>>> @@ -1225,6 +1225,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>>>           return -EINVAL;
>>>       }
>>> +    if (port_dev->type == ARPHRD_CAN ||
>>> +        port_dev->type == ARPHRD_IEEE802154 ||
>>> +        port_dev->type == ARPHRD_IEEE802154_MONITOR) {
>>
>> [Severity: High]
>> Does this list cover the whole class of devices the commit message
>> describes? ARPHRD_6LOWPAN devices still seem to get through
>> team_port_add(). Examples are lowpan0 on top of wpan0, or a Bluetooth bt0.
> 
> I'll send a v4 covering ARPHRD_6LOWPAN too.
If this message is not too late, please additionally include the
relevant stack trace in the commit message.

Thanks,

Paolo

