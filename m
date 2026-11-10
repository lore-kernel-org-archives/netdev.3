Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301752;
	b=fzW5BLLu/bTcaICMncg6ivOk7dCmbk+2caiz3PFQOoj4jjiAuOPOo5zI+n52JDMZm+su
	 FKpeH7mqrfsEITTld+LQgi4zumoKPv5EBcwXhjOkFhuvhwW/ct4iUCeM/xTkHTj1XS9VA
	 iK9pTS51KXDJmbsN+Z2uyzK90Ha8Smz7lc42tB1IXdO6U1lDUR36Y621f4a+RvgMsuIGE
	 OaN5y7PzNc//QGCH0FnE07MNyCIw/7bf4rTmwdhkyJsA79CytU+lE9Q2wfmqcJcdvAiTT
	 hkp77mXV+aMlLPIQLK7sIr0njsFz067HYY5hvfszRBW1XXXJtmXX2VtZVLeljMiGzSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301752;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QkExN09GPNCRK1/4OD2uNzfHx3wdxf9rC1N19wXJ3Yk=;
	b=QuPM9ZUFVusBZY/tAF/sg+gHqMzvihW5KRLSJYm7K3UYSpEgoS5cJXk2SetAvYK7wAL5
	 /FRYDRgonTp+XPa7c8f921djx4cFMsa3LiczSlJgJ19Mh/SLMuZdeBWVQaY1u9oMt+SSw
	 noNVtLKf8bmM6NrMDELVhCmiyWEpR+HMfSldQPRJPK5oRn0XiruhNDt2pzgzHs94dqPsX
	 HhlGbJtT9XO6wParcE7+kxty2MjLeEcNAp8NKKG7BeciS5/eFMB55MDNj+mC+yCertque
	 O4m74tHpUVM9fxEeHIpaDxaLKT+YV20pT/GXYqa3K7DytzAJ2B6CNXDUtK4954okKHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="d/blhxDZ";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eopXaAHP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49C606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F49C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/blhxDZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eopXaAHP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794301751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QkExN09GPNCRK1/4OD2uNzfHx3wdxf9rC1N19wXJ3Yk=;
	b=d/blhxDZYDh8ZCaRul1CIqzUG7eA0t+1qtkbMR7Z0NZ5eCXT95fXN4wT5FoWewi92V34qu
	nQfPj1FqF9Ojuc+adfKWgpn3D5vKd34sR6oBLP/bee7956AzbnO5zWl9JVCibqlZ42Ia9e
	Gn+VbVdOTPm4AsiDVc1mCIJ40tAuiiI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-pvcrvfHUNzO_DJ0IEWFbfg-1; Tue, 10 Nov 2026 04:09:09 -0500
X-MC-Unique: pvcrvfHUNzO_DJ0IEWFbfg-1
X-Mimecast-MFC-AGG-ID: pvcrvfHUNzO_DJ0IEWFbfg_1794301748
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49166c8a60dso1370888f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794301748; x=1794906548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkExN09GPNCRK1/4OD2uNzfHx3wdxf9rC1N19wXJ3Yk=;
        b=eopXaAHPb+A+3+XUaR5PVZCDdczE9BjsEgFKqdaMcxTjE/gpFATLvYIhKrzOmKpq6+
         RMhF48LWTJvgEGo27OIKUfbgQ5hOIHodEWR5Yp0zzOPvAAG9ugpUCAnaHqKWWfiWMdG4
         GT+Z3lGTbW6VpaNysCSiEFns6dlgj0tTYYKO1jEOdci2EyrXgZ1B3bnwsUXy5ZjZgMSB
         cD845qR0SSnaAvVPR3x3Us0t0F7aTAD9/qogO3BfZhTNxgt/DGYTfKIxWCYb4fXOwKze
         jNUkVS4cba4RLV0BANbzk6kwUSttF/FOb/N5e3CGIWCqLucISsKeAn3QjDFzDgTZ+Wqq
         Hn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794301748; x=1794906548;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkExN09GPNCRK1/4OD2uNzfHx3wdxf9rC1N19wXJ3Yk=;
        b=GHNp82W7W9Jk3ed1Rsb8Gm/8MW269hhHCDMjcP6zZUT3kEZPztfLzXSCb9sd0NsUgr
         Yy0zGx7FOLPVOWERNWCvFMqPD/9FP9PNHOXco1c8ITSmKEe9lKbWc3g4VTqda51A14HY
         +Wbdqry173gyfD373N2bCkeS4IaYOccNwINDj5ZNnqCSp+h+tufy333X7+4eZeVifnap
         VRR4Vhx4E8dYQFOIpDz5G6PUOWawhkodIBD88D8w/Bf9dYeTHJdctw8PbuIM7Li8RS7u
         UPapbIZ/qH+982+iS0BskPUJNYptfTY12QZ8vbrJ8FLpAgGYYDVTOR9ZJnCwTbRvvxqn
         It1A==
X-Forwarded-Encrypted: i=1; AL+hErF9XoDBflxHnFC6VNTQMleYi8MGxNuYbwPimfIZD46bQK6RD7V1FsI7/w43yTav4wG1Ky6nfO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+VS1+dGkm4CwWNH3i9nfoinVBLm1sVIVAd9MyogExRBH8I9tS
	xHOVx+UjIQdgQbJCW/az4ly+By0DDRoJTBCZmd7TDbZECSacw/m9HVeWfowMo37M13WXQNKrZ+8
	zlX+K6fnzrVUnKBtODZutImNoUc7VC7yTw0wUvjvT8jkhqMkGeJK+kaK2+A==
X-Gm-Gg: AYBFou2ndNh2/QZUnka+DCbSnufaFxyQSmm9hT/2Vyne3XnnNO4nl4xelUa+OWtnBvc
	hNXjxEFFwVRdQgSNPUSPDxPPgYF3opS5NqVZ6T1kNpauZD1yL5HdQ7e/DLet5gMYeyXseGECsPQ
	Ivbj4ciq4ajKvyFGme0YoCtVbylkNuSQUUNH/0FUefuRGRZOenymIdh8RMQ8/8uKPv7gITJOE2f
	XDK8LiruZC814iB7/zi154DjSgYlGM11B8yI4PyW62qPJ4Dbp/WWBhgKZWL7iKJzDvOQ4ngeJIl
	wUj7he5Zm0rCxH5F25aqBVeM5RNsrklrA3YDZBzxgyY1bXciMoSNC6w+xn00L9gr2Gfe3qial5C
	Wwc+P+sHQLLGsN309bbccIfHHp2sb9yp0BY/R3YhYz2OTfo8vSE+SLd9HZhUoZraQDYgGk8y46o
	GGf3EYgzHvVw0o4aAVfnf9SuBWpFb9jP2e7UB5bnKEc16/
X-Received: by 2002:a05:600c:3b92:b0:4a2:180b:3153 with SMTP id 5b1f17b1804b1-4ba0233e8b0mr37840735e9.14.1794301748030;
        Tue, 10 Nov 2026 01:09:08 -0800 (PST)
X-Received: by 2002:a05:600c:3b92:b0:4a2:180b:3153 with SMTP id 5b1f17b1804b1-4ba0233e8b0mr37840145e9.14.1794301747662;
        Tue, 10 Nov 2026 01:09:07 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01feee1asm64708965e9.12.2026.11.10.01.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:09:07 -0800 (PST)
Message-ID: <533f97dc-f63a-45d1-b678-3962f5de316c@redhat.com>
Date: Tue, 10 Nov 2026 10:09:06 +0100
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
Subject: Re: [PATCH net-next v2] ipv6: Add NETCONFA_FORCE_FORWARDING to
 netconf messages
To: Ido Schimmel <idosch@nvidia.com>, Gabriel Goller <g.goller@proxmox.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com>
 <20261109090505.GA1495012@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261109090505.GA1495012@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/26 10:05, Ido Schimmel wrote:
> On Wed, Nov 04, 2026 at 10:46:10AM +0100, Gabriel Goller wrote:
>> Since force_forwarding was added, changing the sysctl sends an
>> RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
>> inet6_netconf_fill_devconf() never emits the attribute. Listeners only
>> receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
>> replies and dumps omit it as well.
>>
>> Also send a notification when disabling all.forwarding resets
>> force_forwarding on an interface, which previously happened silently.
>>
>> Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
> 
> Fixes tag on net-next is only valid when the blamed commit is only in
> net-next, but maybe Paolo / Jakub will agree to strip it, so wait with
> v3.

I agreed the tag should be stripped here, but just for completeness general
guidance above is slightly changed again. Due to the incoming fixes influx
we are redirecting actual, low prio, fixes from net to net-next, retaining
the fixes tag.

>> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> There's a report from Sashiko [1] about a pre-existing issue:
> all.force_forwarding not being cleared when all.forwarding is cleared.
> 
> # ip link add name dummy1 type dummy
> # sysctl -wq net.ipv6.conf.all.forwarding=1
> # sysctl -wq net.ipv6.conf.all.force_forwarding=1
> # sysctl -wq net.ipv6.conf.all.forwarding=0
> # sysctl net.ipv6.conf.dummy1.force_forwarding
> net.ipv6.conf.dummy1.force_forwarding = 0
> # sysctl net.ipv6.conf.all.force_forwarding
> net.ipv6.conf.all.force_forwarding = 1
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com

Thanks, I agree that is separate topic, again IMHO suitable for net-next.

/P

