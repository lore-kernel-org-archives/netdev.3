Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329752;
	b=LW/VzATLCG5DeGanVv4lM2et00Jx1TxS/su8UdBasTFJqQdHR6uvlwvi1kbBvJTh4Jv4
	 XU8OgPDX+m+7aV0VkENowycdX0+aXqTgGdzPRrDKlf3LWK979/YR0jUMAHl1JQYzX9Hik
	 dlKo4j00rwMAgrusZ6i+7HcbKj2TdBxWufwFx4X9lVOyFDgvZyVczdM5f8d3bA+Z/vAyx
	 B6J1E2HyS8NRF1cOABDV07Tp7dHSVfK/EmBxvuv7S229VoYfnqeGUhbWf11GJXc2gz6+k
	 HbKtTsbEiScOxyYL0BadgdGxxcB4gVFqlhQjLyJ8lHMtvppq3bmrUTVdKfL0sQuHzgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tDnWZ4ABNWPJbkfKsRxF/6fNBcQEBRk+YT4rKIr4YxU=;
	b=JKM+M5+WwAXIf/6vw53OUAKmZRTzniJGXe1cos3ilJH45QvbX74VK1KhH0qc6V2ZKLJX
	 X3QAqa5R7wBIeTpcE6Jj0Mw8AsQr/RbJENck60qv5b2ZxvOHZ1KErwyZ8QK+ogCT2Owf4
	 DppE9myh8F35wGuxTvYbedIJpoDF9VgoeHyCP6Abci1eilcz/OLKzQd0zIaQbEu+sis66
	 ARHGqxAUqBvx7WIj1zbowjRXTMcfjSOAumeF13xo8fu9HQ4pXmp5B6nleRLVftYCLxPb7
	 1X/+f+9i7biRFE7i39L+RtRUZuJ7suSaRmFeWDyJQa8WIINCBPo+SZW89i1bCZmj88g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S16+pu4A;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A9606A9C2
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 392A9606A9C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S16+pu4A
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f2f262b19so1697035eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329751; x=1794934551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDnWZ4ABNWPJbkfKsRxF/6fNBcQEBRk+YT4rKIr4YxU=;
        b=S16+pu4AdrQA0qy0j4dQ5wCYJaxiIkY7ze5qV1t96CUFP/0Wv4jaGFtLtwMAcKcUHK
         lDVCVWpCRrExMn0pApu92yzLX/ItYnw9BZCi5FIWkXD+Sv/fMyJVPtNxinWv+cTM0EpA
         iirBaNlAMjCwFkfJ6GraRa4PAWCdT6dKdGSrNJZXAWZTDS1SifNpdEIrZoV4MVwygZHU
         go1BK0B6G+lNOlPZhAQ8TCrvXZTn+NWyTCTR6FlbK0qXCFZNwPJk7Js5irymIDtS8pO5
         b5dJOqOMBAp6vwgld9Jd3M+ickMoUHZ79A9DqhVzC6bi75xcsr8ZjrEA37D+rsU7XzT8
         m8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329751; x=1794934551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDnWZ4ABNWPJbkfKsRxF/6fNBcQEBRk+YT4rKIr4YxU=;
        b=YWLJfrgW18NSdugu40xD5ygOrxzyYn/5kxGT2Xplm4Kb1qdYc0oOMmhh6cy9u/wr95
         1eh56DyrkSjdpf2b1ZttKm2USdUYKiK83Hu1Q9gWYYerYVOzpIr8ZNCmTZwfHERmaZPB
         bjT12ZW9OsTL3JT1mSxhmChT+03SV0CBwl3nn0ik6feX6ysCygogx79ijIKnsLzCyutl
         46IAB+lNWb4QaNHWObTH5nNT+q67PAp6lXskBLsos7rIbnPmtngGF23+kdIkXFKwoZmm
         KCbqRZwCT5k//IVkdzUQf/KiD1aVnTJfd7u3nobhoekYM0/R74xwUXnttFheA5UHSDG5
         3MYA==
X-Forwarded-Encrypted: i=1; AL+hErHd+wIH0b9hF1rxuf6Arr6TTPrFjrQpxH8JeWSFqxG8LJrTcy0IgUEgddjPandkP9i2AILnYpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kSJ2QbtA9a7PWcN7hW8TYHu/b7rHCRi/E4jMaXvi9EHh3rknY
	NcuC08jvf27wKbO+kZAjTTzypQSfjpL8U8AfIskc4VSvjafJYKzKIkYKdVBAHE3V/RU=
X-Gm-Gg: AYBFou2wGflUqsC4YJpKb3RyoDjP1p7uz+5HNu2QzUIeVBcXB+IeEW+CFZ+2AaKG0sh
	dF4AuEclXj7vEoTDNE+P8pDNCLDx7gxPtOcaJ00fRpCPZRVoF98g1T+vjXoqNWvPUcwsjmmedH7
	Xrv0P34ALuNMmgEtUdKhqGRvW9WuTDgnZboYZ3TCzV6v7bILXbxDq+qY1sjQd4yJF2P2luNnzZw
	5V4xux6gsHnahuQEAAtWN01TPN1fV6/VK21jWoz3+LJL+ZFFBCpe0DO0NKs4fw/CoJsINmYSnKS
	d8z/dr3EvogQ8Zwq2xh2sRfby2bwX47r0XKjKWX92diR48nPGXz8LpoXSDT/1B5Q9j2uaCjq3pv
	fLxniuhcEYQqbvJJ4j+D6hp92hLq9UWbbfaQ8kRBsrPSS0a4qfpdA2vUVcaGKumbwlYrSNIJYHd
	ViefKOU91u0L/cUgZ8EXFNrmf4+PtLhmIwTFaFzAMp8hPoPxOrsrfQ1/gM7I9AKAd7mw9a4LwnF
	tZN2T5yQHepUvJVFHOq53+QMRGeh6Ik8Jq5zrZNYLR1BiOrgLZ1WAQH1Ub0qQ6ZqyHrOTQ+SvHN
	t1+xDMLkk3Jt31l3+iy6odU=
X-Received: by 2002:a05:7301:488e:b0:371:7ecc:b82a with SMTP id 5a478bee46e88-3751f659215mr4113911eec.21.1794329751153;
        Tue, 10 Nov 2026 08:55:51 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:60::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm9545342eec.14.2026.11.10.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:55:50 -0800 (PST)
Date: Tue, 10 Nov 2026 08:55:45 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH net-next] net: opt loopback into instance locking
Message-ID: <avNMi3x6YPOgrO-n@devvm16445.scu0.facebook.com>
References: <20261109173902.1225585-1-kuba@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109173902.1225585-1-kuba@kernel.org>

On 11/09, Jakub Kicinski wrote:
> netdev netlink iterates over devices when dumping queues/NAPIs/qstats
> etc. and takes rtnl_lock or instance lock depending on the underlying
> device. Currently even if all the "real" devices in the system are ops
> locked we still have to take rtnl_lock for lo (only to find out
> that it doesn't even have queues or NAPIs to report).
> Opt loopback into having control path under the ops lock.
> 
> This is a pretty obvious thing to do, I've held back this
> patch because we used to only apply ops locking on physical devices.
> netkit queue leasing made a precedent for (far more complex)
> SW devices enabling ops locking. Now adding it to lo should
> not create much new bug surface.
> 
> I considered an alternative of adding a "predicate" to the iteration
> primitive so that we can skip the devices which obviously don't
> support given API (eg qstat) without any locking. But it's more
> LoC and real_num_.x_queues is not currently WRITE_ONCE()ed so
> it doesn't work too well for queues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3:
>  - pre-req commit b6f74dff6d26 ("net: use two lockdep classes for
>    the netdev instance lock") was merged
>  - no change

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
