Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271730;
	b=zlzk5KROajDGL1++UGdaj3oDoRSByv662yNcAA2BhuLJd5XSaLjJcXW6v1SIhlUxR/DB
	 IQ5ETwri7oQpcxaYCH8ppH4IxQTkLSItRpaLZCqNzZcM5QluUoqa6JLyrr0YTpkGHSA2Z
	 Irr6F6i3k8ohvcVPYYunM8nZLRFFr8RDWOtl6po3NL2ID7f3Yd5CDZK5dBbOJQGy4QPk7
	 k1zk7toULaad3HkOEsdWsh9v/l2+gBuQqxtdmvtJ+91YpSBMrjDDg3P49v/CxigbMyKUt
	 l0fYmFiaSSxIgx+4S74z9bEb4VyS8zuCTN0Zh3kCxX5OuHf3EgxLZKFtpEDpfCs8j4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271730;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WHVr3aVbLTDCcJArGFRiRX2P+5VgXRC1Kf7Hz45sNgw=;
	b=cO69EPG5ZROUHV9rBe3YzVGCtCY9Wec7wo3vClzEZa6gBxwplMXaAPXZty8TenSMUwIZ
	 FeCLPx58G0zg5QRZdMOkotKyW0BeQfR7fWK/ixGXFt6OJ8Um5mQvvzdSznHa1+SToSxI9
	 oNdDL6Vvc0YQWccPVBYIG8sQFGj56kCh7rJYBxfokepTTnlk0z07A1FkmODjqtJKGcoRH
	 j9hlaAc9lHKwF/yzBQyvBHf8gJiIBbdNCcJlkGieg4hAdIPIxst6sMzwVOjQdI7RPi2BO
	 Qa80HZ/EDvHADkB5C+C+7wZOC1Ed5LraJji4sbnKEqTjEcrfMo+d40vp2zbteXa/t7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6BCQE15;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OCl13eg4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA51606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA51606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6BCQE15;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OCl13eg4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793271729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHVr3aVbLTDCcJArGFRiRX2P+5VgXRC1Kf7Hz45sNgw=;
	b=i6BCQE15LyAbdc6mwswTOgBlYrxN8mG/6lRzf/jspUnOXkoB6UtsRC7YLG5um+AwZ1tzIq
	C3R4FiDynmy4iw3T4cgHN364ZDdBOIMF1X1l+MaaEc6K639Eb2byEmlkgj9xXK2T5SleBP
	qKaaXiPy2zt9ED/gYZaH3YIa6mF9Mt4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-HanDzu6UPnOXAP5HuyoFlw-1; Thu, 29 Oct 2026 07:02:06 -0400
X-MC-Unique: HanDzu6UPnOXAP5HuyoFlw-1
X-Mimecast-MFC-AGG-ID: HanDzu6UPnOXAP5HuyoFlw_1793271725
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so17153535e9.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793271725; x=1793876525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHVr3aVbLTDCcJArGFRiRX2P+5VgXRC1Kf7Hz45sNgw=;
        b=OCl13eg49BrIjvEQshFGOHshoEDCPrPyvp3QbBhq+toNFIqG9HeK/dq1Q3OQksr35o
         k93Hy9W3xEwGIqkYGKToluOEPjY0T1tPUNVJe/WvMRs+IVa8OtHl2oJPs2jBk9UaY+ny
         mesgakEM1dc3LOOaSdnqQABs/Mr0LU87PVfNqRHzBzgIynb0GLf1gFQGHqVRgmrt+6ab
         71al4djb/xxwzE/JVJntW0JSC1Z4o8wo5LE69ZcveBJK3EUPJ3Kj0SBIVwes7ZoUqpOD
         UHE27HJ8qIhQLTdwSugusHF1jV3B3s6IEMwb+msHf6eXpx+c3gXmOVxqa3Y3VyWQEG7t
         xGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271725; x=1793876525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WHVr3aVbLTDCcJArGFRiRX2P+5VgXRC1Kf7Hz45sNgw=;
        b=HHzAB+nc/SKCJRnuoWlVuZRpZeXssfWQqMgI69g7b/Cd6WPVvax63tOEinTXTV2DrG
         th6bIimPNk4xaDXDBV6BgET9YhISBE9+6FtXbaHXXIPUnOhBffavcgB3+PT1/Dy4Jkb1
         99cN2GxMfRCoWshUvIzVakhy6Rk0p+8o1AGsLA22EebuVFlD2rQQkLdKXShBs4Y+wsL/
         GakRQVOs0npnEvKwcdTvkSnrk74lcXeDF/3jt5wVJgKgx2YYb/ESFdD0C1DXM6Set6Dc
         m0Y+4w1LS2OomQDYtrzgPGqPX1HzcDjO46oYpWNbrxjXE+tnZi5dE4ClbhpjF2Lyj1lf
         RGMg==
X-Forwarded-Encrypted: i=1; AKwUvBzbVPi+3XGxNRvxn5j2qRWaT1ag7tsXksDauCfjREvjWi3n8QnCdGbO0JTPb+n65RXfRr3DhrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEARAILzSJqkOFS9MMuwkOnytumYphseFttu8XavvCrE1400BP
	RxSJflqOou9FVGXYsDU0Y6kwaUNAYHTwjOSFdC30c88Onj2dpK63Dzoeggk1JLLHLjwF486PJzk
	8sjMxA5Rdf/25yzt27JG0UP2uu52kln8yFqJjM+x0dGz2smOuAYMGkGOk99UmU2up9A==
X-Gm-Gg: AYBFou0Mzf7ZqzNwuiV8u1afmePraw8Ey1zXP8wMSamkG9JCcxrS8cadDXiaLfGuykS
	N/xdHUbWNIp5hUrkaxO+JOTp5RCoNy+PZMMPwtKZzhnM1owiQJ0ugulPEjkfYeBpMghnpanuRZx
	S2ZmDCfHocFVjO5iehvpf0HltpGI281DPBBAjUBYFDjBALRSXsBlHMmkSU9NdzLExixCiOZAeh3
	tqai/8Z7LLa/04gkv88A0wrVs7mF6/53Pai49qPsQN8FETk7eXHB0GL2uGHXz7X1MNoqyucYUsq
	MA4ZIKfTWHi5XsvXP9LB4UHRMCYT1m/dVgxkufJ6ztMOZk//MrpYeGv9J2tLaJT1ZE1zORN5UcQ
	2ybgJBi1c+yy0B+G4ROVKBEXOBadyx8Tf+se7O5mPjKissIzdOqXT8nwkhsONs0bwMKJJ2e0z62
	5o6PIOZMJ5Nr0fTRhf9A395lH/hy1rI9Rt1U64tmEgTgnYmyE=
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a966a56974mr111805985e9.18.1793271725304;
        Thu, 29 Oct 2026 04:02:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a966a56974mr111805435e9.18.1793271724757;
        Thu, 29 Oct 2026 04:02:04 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92de010bcsm99803065e9.0.2026.10.29.04.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:02:04 -0700 (PDT)
Message-ID: <c57f4474-93fc-4f7f-b016-dbaf7875f113@redhat.com>
Date: Thu, 29 Oct 2026 12:02:01 +0100
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
Subject: Re: [PATCH net v4] net: airoha: keep PPE offload when NPU refuses
 flow stats
To: Chad Monroe <chad@monroe.io>, Andrew Lunn <andrew@lunn.ch>
Cc: SAYANTAN NANDY <sayantann11@gmail.com>, netdev@vger.kernel.org,
 lorenzo@kernel.org
References: <20261021100423.9159-1-sayantann11@gmail.com>
 <05adf618-f608-4c8e-a862-4c1d0779567c@lunn.ch>
 <J3XqO9fJOEvpsUH9m_DyrV8wgQzdtZdfhE8KZHv9ejvVty51zjizvG-0nmYn8ZhTGRJnLq0OcEbX7l3DvpqFp8dFEYuWYVpV5ZRKnGXmGKc=@monroe.io>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <J3XqO9fJOEvpsUH9m_DyrV8wgQzdtZdfhE8KZHv9ejvVty51zjizvG-0nmYn8ZhTGRJnLq0OcEbX7l3DvpqFp8dFEYuWYVpV5ZRKnGXmGKc=@monroe.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 16:25, Chad Monroe wrote:
> On Wednesday, October 21st, 2026 at 5:49 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
>> On Wed, Oct 21, 2026 at 03:34:23PM +0530, SAYANTAN NANDY wrote:
>>> From: Chad Monroe <chad@monroe.io>
>>>
>>> With flow stats enabled, PPE offload setup requests flow statistics
>>> from the NPU. If the running NPU firmware does not support flow
>>> counters, the request fails and the current setup path aborts PPE
>>> offload.
>>
>> Since this never worked, it is not a regression fix.
>>
>> Why not keep it KISS and report the firmware is too old and suggest
>> the firmware is updated?
>>
>> Can the driver do the firmware upgrade?
>>
>>      Andrew
>>
> 
> Hi Andrew,
> 
> The NPU firmware bin is downloaded at each boot and is present in
> linux-firmware so no issue with keeping it up to date.
> 
> The main reason for this change is to behave better when flags mismatch.
> Previously, loading a driver compiled with flow stats support enabled
> would silently fail to offload if the firmware didn't have support.
> 
> I did not like this blind failure so figured it would be better to
> check what the firmware supports. If flow stats support is not present
> in the firmware at least we can still do offloading.
> 
> The main question is whether Airoha will release variants of firmware
> with flow stats support disabled in the future, or if this flag will
> always remain enabled. If it's just an issue of old firmware (all new
> version will support it) then report + failure is sufficient.
I think the simpler approach would be better. If Airoha would release
such a firmware, _that_ would be a regression on their side.

/P

