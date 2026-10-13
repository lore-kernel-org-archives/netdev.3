Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED838F649
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881734; cv=none; b=LHrszUBi+BhSVAt1nASel0Z8MQ6fQEq6H/Pjn6i1E88lARNjajPrRCaThb0GLPg6J5ay5CQWQRYJ/wP+G8bBsKDwrMS6VkwhPk6um06PqfZkwZqAszRnLHqeN45sBnMe43VX0b1CNg+w0ffzllML7DuHmJLzxgRdQcBzWbW8Yug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881734; c=relaxed/simple;
	bh=m5iWzXQqbfeEnNBlQbatpfjqbyuy2gsKGGFKLi3YkFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPcQo0hSiJ6vJQxN6S53U2AYKdakoZ++UCBZ/si5QWv/esQIqSdWVAtAXnJQrDqDisxERtceYVWvxGWiDOC2Sf8Mosaj9NycOMjzgVtt93nJt/CtwL9pdC00a/BWoKNxqTeRpXjd0B4LhydpovaoThewjg44VWoaU6KESm7rJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVaHLYcJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qTEKtpBd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVaHLYcJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qTEKtpBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791881731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78mBmvtnY+q8jLXR2LeoMzPiBVGdVepDrU/0B9LThLg=;
	b=HVaHLYcJXnc9XJGmk/kMhtrJBjUTGO2Rbm0TuEN0WEOg3HefWPK7zM9YqR8dkR19oDU9n6
	QaGyCs8b7E+8Q5T160OAxs1liJi3YLss4cfRASvpVJX24Ps5ucojF+NjjADlXj7OPKxacA
	ua8aJUAxKa7NbEMwmwpz6ntwBV4laRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459--yTbfnqVPhaSdLBLJcOTvw-1; Tue, 13 Oct 2026 08:55:30 +0000
X-MC-Unique: -yTbfnqVPhaSdLBLJcOTvw-1
X-Mimecast-MFC-AGG-ID: -yTbfnqVPhaSdLBLJcOTvw_1791881729
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49febef74e3so36291345e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791881729; x=1792486529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78mBmvtnY+q8jLXR2LeoMzPiBVGdVepDrU/0B9LThLg=;
        b=qTEKtpBdnirlWqXiVsWXczbUleoUmPbFFqPRF5D2nfzqf85QlZDc/649GXpvkmE9kw
         ZNv7dXoGsFRwpxvav25jtpCx1LgQk9OZZfud+jbg3nFciEmULtm+ukdMVX0jHT0xolh+
         BTVZDzld5BNk3O8ryVHHbMy0LwFaHsXv1lOxinnkNKeMTBgbfUwVSG6oz3F0FnW40qs3
         1tBcuUq3SI74m8EnQDy1Jc7hwoF+JHWeOdE2sy7kWpwnocV16R/9TUAqpX2Rv5N9bUnO
         8a20zlCAZewC4EyQta6GZnqVtI/vo9b9UCiibD2ZkhbZbBWeF5GnkvMCuNsfqU+7dnbq
         2uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881729; x=1792486529;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78mBmvtnY+q8jLXR2LeoMzPiBVGdVepDrU/0B9LThLg=;
        b=axwPC1y2x7nA2P332Ju229t7bD90ftNd/lVoSt3RXVXIYs1oTApbUPFQui0zF8tmfi
         uXGSOh9Iki+gTIKLnvYi3oHJmGwpoQorFFcD+c4rgDYjPTme/ZEm0N7/4mAA/S6dBFIL
         I7No6RHh+jMuWWJSRV/wJEiCRRlv5m7i3bBbY+d6c+eYC+wSMRdTBUrp+iSaHh/kPMx1
         2dIgy5KzNGgISnESw02g82ar/Q3ZzJ5O184TTj9CTzJRNpktV0qa/G3COvj2MV/1TeZX
         IFlk7E5YYGQ/4ABTPoulGB3JDm53e72I/lqw4zDvEIqWBiEoeJLs/LFN8nAR2tb4a37S
         DXpw==
X-Forwarded-Encrypted: i=1; AKwUvBxPJ/hXBU03lONU9Qrd3dZ7H2GHfUsX8eH4Y6pYw2TwTkMhSJPg97qhqd01rpZg+8AbshwZ8BU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1TOdEq1CmlaIx3KRyRsPJiIWPTcpFwM11LxdEc62UC2fiBUKM
	L/L5LPebqmzwUmeqI5egp5G9JYCfUwxC56QVySjnWuUh9PADzDd77i+QSCtb9ZipWIet8oEKAai
	fM867L12ytxRywZZvsoR/ru8vN0bRfVTcNAkbdON/GCKc76CKtXPe/vuHbA==
X-Gm-Gg: AYBFou2LfvRnAoixK8+qxm/gFiR1BR8yNzKbpSYmFFy5b1zRii0eexLIdo4aZWrw4DM
	weATrtbDdl23MzpBuyxb7P92TubwLMmIXHA4lYmtB/j6F9EGYV7x5Xo8H4vBfnGftczd9lKuuI1
	haa7Wca3P+JrBBBbg7/MCV9cGJxgx52i4/3M/GELKpklso/qwt7hlNl5ab2KodZ7ZdCAuJmrIYn
	UNCbQOPIfl8sSonN3D0yyTe3fxvXgkETLoj3ZBmv7QwZ7gQGP3FU7KIkyj8nHip9ucsKKP0LvlV
	Ij9ZjCmQtzHM/PhIKB0hcGbqAaA/Pajb4xfJhLCA8MCDQj6MQzu7dPOANnTRkjKvW8fHTI/b5mK
	o597CESEpJgElz40M+Gc6AtRnAP7M1wjaqCN3jE4JHA8B7f1kkX4K8jsGRqVEznsPukwwwAGNfQ
	==
X-Received: by 2002:a05:600c:1d0a:b0:4a1:7f96:9b42 with SMTP id 5b1f17b1804b1-4a18e4a94f3mr217181805e9.15.1791881729380;
        Tue, 13 Oct 2026 01:55:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0a:b0:4a1:7f96:9b42 with SMTP id 5b1f17b1804b1-4a18e4a94f3mr217181095e9.15.1791881728540;
        Tue, 13 Oct 2026 01:55:28 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf214a1sm398685695e9.7.2026.10.13.01.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:55:28 -0700 (PDT)
Message-ID: <6317234b-1158-412b-85ff-7fa6210b7930@redhat.com>
Date: Tue, 13 Oct 2026 10:55:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] ptp: vclock: preserve time across failed
 physical clock samples
To: James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Yangbo Lu <yangbo.lu@nxp.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af@gmail.com>
 <20261005-ptp-vclock-sampling-v2-2-8ed12d4d10af@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261005-ptp-vclock-sampling-v2-2-8ed12d4d10af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 20:45, James Hilliard wrote:
> The cyclecounter read callback cannot report errors. Passing an
> unsuccessful PHC read through it consumes an invalid sample, and a zero
> sample followed by the real counter can add an extra 32-bit wrap to
> virtual time. This was identified by code inspection of reset-time PHC
> access and the virtual clock callers.
> 
> Read the parent clock before updating or initializing the virtual
> counter, propagate failures from clock operations, and leave its state
> unchanged on failure. Initialize it before publishing a new virtual
> clock.
> 
> Simply skipping failed reads is insufficient: the next successful read
> can arrive after the 32-bit counter has wrapped, while timestamp
> conversion has an even shorter half-wrap window. Use the full physical
> nanosecond sample with a wide frequency-adjustment multiply and retain
> fractional nanoseconds. This also allows delayed packet timestamps to be
> converted without truncating their distance from the last sample.
> Serialize extended and cross-timestamp sampling with adjustments and
> advance the anchor on each successful clock read.
> 
> The initial sample can also fail partway through a sysfs request to create
> multiple virtual clocks. Unregister any clocks created by that request
> and clear their index entries, preserving the previously installed clocks
> and count. Otherwise the failed request leaves registered children that
> are not included in n_vclocks. This cleanup also handles existing
> allocation and registration failure paths.
> 
> Fixes: 5d43f951b1ac ("ptp: add ptp virtual clock driver framework")
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

This addresses multiple issues, should instead be split accordingly.

Also sashiko remarks hints at possible regression wrt the new wrap schema.

/P

