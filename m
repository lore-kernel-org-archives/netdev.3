Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493085;
	b=LOhMRdUMoFAAQIcwwWs0qxERPXpvgFfYFkJzSS+kqqSgM9IL+Zfs6u/ahRxHfY/hc6HG
	 K6xl7Z/SSj4aSOyk0ke+kjLvfRzcr6kx2Uh2CWOJvMAJYy9FlInfgYY3adGrp3ccZi2R9
	 ogBydJVMU177a0qik+2/TOim6clAzVLxeysqkw+v022BezFXAIMJy5UvegtpqsH3leFYO
	 Lu9ylZVdTpTLde13W8th/p9fMEcQgMSbd+mHLCusjKD+oJ03BsDIFYx8s2gtNQzhfXHjX
	 91IQiIkID80ML0zAyu8N3b6ZrjzbE0WH1Z8frBFRliyw0Hqw8E+MD/lICUWXi9Lhyog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493085;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+cC4nsrOTFSxSCn8c6obquDxVJGEQXIvfwUUskfU1eI=;
	b=W8hiDqKtdCXTGxj6qA0pX8ktORzND5/3Zo/pfaSgkNqJoWic5vzGvqhQNGyS7nhcsUVI
	 +k45kh/MmhgAt1/DRvMNMcIkvtzdTjcRsQFuUFCI6IDgclPkEk3rSZ1uNq1vildrbONZZ
	 kU8CFrMzwEsVYI59fOzrqDfPj5Utb3L3bqfd04OK8UG8/jZZ05rF8Nn0ShpYMEWiXpozn
	 ABCGmHawC/2AjM4NcLdeMpQpERseiwgu3Ps/fsueKlCTTbIygS0AIYTfaC5W87RZPczKs
	 HaAAT/cXdSSu0sNShDVepERP8ibnbYdyi4g3RVDD0OL4ljrjL42auk6iq5wu2+SdxUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f3XaEPOT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sUhsbgMV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E7606A89D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A23E7606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f3XaEPOT;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sUhsbgMV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cC4nsrOTFSxSCn8c6obquDxVJGEQXIvfwUUskfU1eI=;
	b=f3XaEPOTgQcjTIUIrgZxBTrxdHfS2doRVbUPk33x0+vWJVIBQrJYIfCWTt5gIFvVoNbzug
	0T+uaRFkkpMwYSKBw13ZaLPJRssYMBHDm8g15Wd9aMkR/g4BIl1JELIkfhZjWClDocjQlA
	UZzzK8XkgJrnXooFxltwk6Oz775zCRQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-XPboT3cfN7uPiQlTf1XAvA-1; Thu, 12 Nov 2026 09:18:02 -0500
X-MC-Unique: XPboT3cfN7uPiQlTf1XAvA-1
X-Mimecast-MFC-AGG-ID: XPboT3cfN7uPiQlTf1XAvA_1794493081
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40aa03ded8so483428266b.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794493081; x=1795097881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cC4nsrOTFSxSCn8c6obquDxVJGEQXIvfwUUskfU1eI=;
        b=sUhsbgMVcSmbbcwi0XmLOdCEw0iLBBg/ZK8HUYyk7OGGQN5NcFKS9fIDLCKRApxXSl
         vb2gt1HNvmE1Bn1dRE1bwN7upbqgDnf12kLBDFn+mj6D4K/zSz2PmioWqQ0eQVU9xacK
         o4mViNKH/ENmH4ZJnGHk355PBoF8gGPRj0SJYdq5cnwfJBxhR8nl9m3Va9hIW7A/7U2G
         xi4xsu9fyk+ZzijN8ota2QJdIa+U6xswpwB5nmYUWMVMVhexXlEzRZTVNW8Loc+vQUM4
         Ke73Qts2GWRzarcjQEhkNoObAi3h6xidaELFa+y5loDTE3oRXRb/OOLXblYO/9FShT0/
         O3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493081; x=1795097881;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cC4nsrOTFSxSCn8c6obquDxVJGEQXIvfwUUskfU1eI=;
        b=Ix9o8V/Z5KLm4u6N1TYVJKB3AL1MOO4vXDEIlJN9jEtn8AcixqIpL7ODQdmuG8lyXe
         F/ZzqkccdyWv98vYepDV0jq10XzZKkxpd5cW/oMmWBWZF6Y4XEoJqRAop4iKCcWivF9C
         eTqj+/gx8ZxcpLUHoHoAqYPX2BuWhLWV+8TjXXDuL/R5Fkm2C2hwctETGGoMKW0973u/
         dj+Q11U2WNhIvvejLg19qnqA61If8kgsCEZj4o1w0ph7eMB78pkF39AxDSpwfPLQn0Of
         SLYa59GWrTgJbBXccWeXx7DiqTEfXegV5oI8Y2plguCLmarzdt040vYcof9ohrShKvw4
         x0wQ==
X-Forwarded-Encrypted: i=1; AL+hErFolQhaLbUc13x4ng4nKUz8YepvWP2pUqtnMfzkuhLIQTz7CCJD+HGVabhWSJNe83GLsCjueew=@vger.kernel.org
X-Gm-Message-State: APuU4Z969w/SAThLJ2O2Zl013xknXd9r593ELeqKjz2fS7r1ihvuZRyF
	+xTKnVgi2GZXnV4kK/b05uNMNJ84sFcyZQfX+wTDB8YAcuITcfoQzsJTcRBZktoyAD/5I4P9q7P
	GHUiK0dzGaK16dU1lmqEGP5+/svQiJlHNEF/jhYaFbJlVkxjuUDreKUCBtg==
X-Gm-Gg: AYBFou2aGGwcGtBTk65TmNWlv22DG8hWdKf2TAdMR2EHbZspbID2hqzqHwPJVo8R8Mi
	NNQvbSSd54HP/3Om69e8LYiV3/rVqCq86ywvh2kdK19ih4rYimwXHrmfnyCux3HTkd0NIQMUcxX
	isTdxN0tZlVUHmA7fuRC+wr1YAkn5iNMmd2SO7gIHRLySiSkDLEG0mPQ2R2VQ8AbEAB2bav1hX1
	gspX1K7emRs/O6I/0tb7kYLVzlkHlcC9V7w1o4T4Qr8TAIb7FUoR7rPvRm/KDp6m6wB1G/CkCOg
	qToZ+2uGUT0WCiESYwXJ7szh8KC+g5tP7eAcCZw1iYUNhIdKmiPKdrMXyWZxhXLF0CRjGFUkCHb
	KTMH/KbOMgClL8t21eKOo/ANdZalVsSXwnggAUPbx+kqqAqwh3fFo9z1Fh8idLu8PjxpLh1HarW
	mkPIl36oPWy+qDZY/2B3Y3shk0sijOvQ2Kk3VqUn9kBiCq
X-Received: by 2002:a17:907:9289:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c5066cf5ef5mr495863566b.40.1794493081064;
        Thu, 12 Nov 2026 06:18:01 -0800 (PST)
X-Received: by 2002:a17:907:9289:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c5066cf5ef5mr495856766b.40.1794493080479;
        Thu, 12 Nov 2026 06:18:00 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498363e0019sm17964078f8f.38.2026.11.12.06.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:17:59 -0800 (PST)
Message-ID: <f5625dab-a1e7-4aa5-acf0-446cbe2a2d42@redhat.com>
Date: Thu, 12 Nov 2026 15:17:58 +0100
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
Subject: Re: [PATCH net] igmp: use the joined device when leaving a multicast
 group
To: Ido Schimmel <idosch@nvidia.com>,
 Junyoung Jang <graypanda.inzag@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
 <20261112085131.GA2948232@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261112085131.GA2948232@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 09:51, Ido Schimmel wrote:
> On Mon, Nov 09, 2026 at 09:53:11PM +0900, Junyoung Jang wrote:
>> ip_mc_leave_group() resolves in_dev from the leave request before
>> matching the request against the socket's multicast membership list.
>> This lookup can return NULL even while the interface recorded in the
>> matched membership (iml->multi.imr_ifindex) is still alive:
>>
>> 1. An application joins a group using a local IPv4 address, that
>>     secondary address is later removed while the interface stays up,
>>     and the application leaves using the same 8-byte ip_mreq.
>> 2. An unprivileged user joins a group with a 12-byte ip_mreqn
>>     specifying a valid imr_ifindex and a nonlocal imr_address, then
>>     leaves with an 8-byte ip_mreq containing that nonlocal address
>>     and no ifindex.
>>
>> Because imr_address is nonzero, the early -ENODEV check is bypassed.
>> The loop then removes and frees the socket's ip_mc_socklist entry
>> (iml) and returns 0, but skips ip_mc_dec_group() because in_dev is
>> NULL. Closing the socket cannot release the group via
>> ip_mc_drop_socket() because the socket membership entry has already
>> been unlinked. This leaks the interface's struct ip_mc_list reference
>> and multicast MAC filter beyond the socket's lifetime, allowing an
>> unprivileged user to repeatedly leak multicast group entries on a
>> live interface.
>>
>> Fix this by looking up in_dev from the matched membership's saved
>> imr_ifindex under RTNL, matching ip_mc_drop_socket(). If the interface
>> was genuinely removed, inetdev_by_index() still returns NULL and the
>> existing hot-unplug cleanup behavior is preserved.
>>
>> Fixes: 4eba7bb1d72d ("ipv4: igmp: Allow removing groups from a removed interface")
>> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> IMO, the commit message is close to being unreadable. Simpler (don't
> respin):
> 
> "
> When a socket joins a multicast group, the ifindex of the device is
> stored in the socket's membership entry. When leaving,
> ip_mc_leave_group() resolves the device again from the request. If the
> request only specifies an interface address and that address is not
> assigned to any device, no device is found. The membership is still
> matched by address and removed from the socket, but the group is not
> released on the device it was joined on.
> 
> The group is then leaked on the device until the device is unregistered.
> An unprivileged user can trigger this by joining with an ifindex and a
> non-local address and leaving with the address only. It can also happen
> when a socket joins and leaves with the address only and the address is
> removed in between.
> 
> Fix by resolving the device from the ifindex stored in the membership,
> like ip_mc_drop_socket() does.
> "

Many thanks Ido! I agree with what you wrote. I'll update the commit message
while applying the patch.

/P

