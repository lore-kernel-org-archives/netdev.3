Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EE28751B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134980; cv=none; b=Vj224Zz+MSxLtMf3zTP+Mxnx7Wj2J2jVjOFhAHSeJtSeMk5BTyHkaqFrnwk5pBft4JFH8nfHyG3qMlx35pi+mz2YGHjqG+CE3hLvdiBrRwiLy9n4ussN5dDtrKwZ35hxQK8J0Tek+58tQHtxqUI61ZlhekBuJRKy1ErBfhbiemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134980; c=relaxed/simple;
	bh=SnKSzDltBgYBALCDwQxCA2ft7JBfIGZ6PlA2dDY4KdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9aojuJ/+IiMLpnVIuNLO8XKFluKzGdSCjpL/JKbMJruawWeJvFffpAvWTBS/Xhs3YwxMLiR4M1qUieHLKR5f4VLYzQUyZAu8cmE1ErTOh5b9Ib0/74FxHLqAck419ASz1Bbd6W748/CyQDIQZoNbsVSzZ5sglTnT4yyvOdMNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vj/6cc1l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAiazY5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj/6cc1l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAiazY5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775134972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyYBDxZ8zUQ5bRs4MjkmDO7qkbqdhTlj7yo33WH03so=;
	b=Vj/6cc1lrcg2EWrIWaOBMTlZk9qtAJkUe0K/e9/b2L2vVrkZFWQCqKWgIuLA/X0PVQMUO1
	2zihVGFCKOMkTgZoAcyw+rabc3WZX81TjGiHuUMcDBjFMu8GYPXdux2iJes+Ra0/4c18vM
	Ey1v18l2TSXXJZDk7aX/usKyXWUcpSI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-LKkYpoixPryInVICNxCozA-1; Thu, 02 Apr 2026 09:02:51 -0400
X-MC-Unique: LKkYpoixPryInVICNxCozA-1
X-Mimecast-MFC-AGG-ID: LKkYpoixPryInVICNxCozA_1775134970
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48544725bdeso10515945e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775134969; x=1775739769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyYBDxZ8zUQ5bRs4MjkmDO7qkbqdhTlj7yo33WH03so=;
        b=XAiazY5VoB6IGK0LAc+DIypwnmaBuFNFbu/hjD/KxKKuCXjR34TFhdQxOsjxARR67/
         TJs2QB6SPeis7zkGxAM0WNXWk0seujW1Aj+ih6I2TujCLWaFDzJYUbr9GP93kMPDB08x
         YNmJDh3L+zsS/DBqpwlPvmRWnEFnpd9pRJ4JGmd+yEPNAuSqtOn7kB9OarFlucDSpN/m
         4/Afr9SPgTyQmp3KkiZATU4CsIqkeB1V/es355100Hl1bBgS7LDPPr0PVpxcrUFZhz+i
         /l4Wd7E/dualfoemJZZfVgmOHKJbJdaJRBY3KTqkboJ0GEEP9TVYUbiDpLhKt17OMTyB
         naAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134969; x=1775739769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyYBDxZ8zUQ5bRs4MjkmDO7qkbqdhTlj7yo33WH03so=;
        b=E2lwW0R2aa5rmQ8eSqUWcDUxB4pj4//QTtha5B2/DETa5A0IesT56klV9X0CaBhMXv
         qf5QfVxOQ//H+kPsdBWLMAzBqE7F0mqFxhYj6Nw1etbCj/SrlHg+UM95CE3T5qQthntQ
         w7ZdyZRPsviwM0d43yA+fuDCfzOl5HX9Ih+Z895A4PzekYdjveIYRqVmLTuf+F7QC4xt
         532Gm7Fd2e3A98JkB/qkAKo3vliYv7juZyaD0qm1Mx9AKsfoaRU58UAfXGhhBbyh7olc
         tG0Mr59rlEvOE9J/Ag3T/UNu/701s0rAwyTo/12JQOIag3pavBt1O6L2CLUSyngadAt0
         v6tA==
X-Gm-Message-State: AOJu0YxYnwohou1G75ZgwXhBz2v8RhtIDDdyMyFenUzs0vjeg92q+35C
	MM8d6BzPXhmH39MsfDF6+soHNmiawFUlqNwW8EwruF5esqZX7TLMj28r3c5DHaOLTKSZalIoNqI
	HpKyl7/U3raNYw4pwyiRto0q8qIc8NKbfGRA+CnyhPUzAUPElAfYPYe1fLsO/jLKbUA==
X-Gm-Gg: ATEYQzz9NW+Nar+UuyFZzQExBf905pWCcX2bLsO0KaPRV5kPeapcKD3+bC65qWznVGc
	pNQfy3EA9v7fHh8OGmDOCsY4mtQWT9MEhZWCw88cpCoMPtW9oSwypmz6bKezZpwpa1lBhCnyn/t
	6orGPzEIfWVPYYuulve+JrFxUndNh3wtUWltNAelK53zwS1yhtB0UOnj1epWUSWUBoBp/1fVH7r
	cXGACkqZkPJuGGFPIKuzjnIM4tUYU0Yoe5AK3eOA7yZJLWhBh6q1UrAoBB6fkkW9ebrAZ81Xbxg
	wK++VDV++yKAAK1Id65yHpkFDPeXN1oxKI0iX3HDWt1OgLnI6xmc65p4K/bhSDOvdNUGhoR8PpL
	QICofEfdf47mX09H58Gs/0GhlohH5ZMoSAvLQiNEQPv94u3uV5OATkd4ywg==
X-Received: by 2002:a05:600c:c08a:b0:487:cd8:4c9 with SMTP id 5b1f17b1804b1-4888b79fbdcmr45575735e9.27.1775134968325;
        Thu, 02 Apr 2026 06:02:48 -0700 (PDT)
X-Received: by 2002:a05:600c:c08a:b0:487:cd8:4c9 with SMTP id 5b1f17b1804b1-4888b79fbdcmr45575195e9.27.1775134967771;
        Thu, 02 Apr 2026 06:02:47 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a567bfasm150299115e9.0.2026.04.02.06.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:02:46 -0700 (PDT)
Message-ID: <9c101981-4a85-48c3-ad0c-c16a362929eb@redhat.com>
Date: Thu, 2 Apr 2026 15:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/13] net: renesas: rswitch: add register
 definitions for vlan support
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260331-rswitch_add_vlans-v3-0-c37f41b1c556@renesas.com>
 <20260331-rswitch_add_vlans-v3-4-c37f41b1c556@renesas.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260331-rswitch_add_vlans-v3-4-c37f41b1c556@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 12:03 PM, Michael Dege wrote:
@@ -847,6 +903,98 @@ enum rswitch_gwca_mode {
>  #define FWMACAGC_MACAGOG	BIT(28)
>  #define FWMACAGC_MACDESOG	BIT(29)
>  
> +//FWMACTL0

Please always use /* */ for comments

/P

