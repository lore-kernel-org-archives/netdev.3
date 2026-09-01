Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461734248C6
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276860; cv=none; b=o8dAzKN1Cs7saAfYtLORrhmAmkZrKbtzPoCTMvuso5Px0pZPr61P+6TL2xa/LJ8ktnVIT3rwQAl71lq3OCh934tvC2B9hgxZYNLwRTg3jDPyw8wy0GmfJeccJKlKAgR4rVaylIwrS8WeKAoUEB3Msl49O64Fo23r9G88sEd/dXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276860; c=relaxed/simple;
	bh=iKD8ulE/7j+UTASizItruNbYincTMOqWILEWStCXBq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsK/9JoMkJdAKX790UwBwQt/hLF1KClnQE9hnr+ODoKZ/mlFDBcJavajXwc1wSGsXAfwW1I/Tf1i3kS7vNpcAcvBT47iHDbd+Rki1/QUsYMyzTWMg8mUUW3smsIkYfWUvdmiT9kUdQhgA/tZMkd7Fkto9w5b1/Z8DEiFBvy4teY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=qqMjHbWa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="qqMjHbWa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d9db539a54so3536435ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788276858; x=1788881658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tXnScza6YsSOijKy2kCYJ4+3czNea5Mz9Jc+EvPjn4U=;
        b=qqMjHbWaSN/JwOsM1TrtG409Y9rK7KlGz8wudN60+jbOef/FTEUJRUePrQF1REROdQ
         0tStiUPDUkrkNinhPo7DYnOArZRT7xleNxrYbvzp2eppIlczslElBrGDrk9UKjB1ry50
         3pzesgWzijXF1McdrUwmn0aun7Nr+VhYgs1Bk2JgOPWKr41ikROMU7mFnLqavniVKblN
         hrtmEXQZ9JK81JaJcWGfZGAIwSiggUMB5h6p4JqOinc9alM66A0yDCbO5eJd6+QJr/cK
         iWL1HdU9OsiWDqhIFxPFvIpBT6PHqSx9Ky6BZD0NiPmbBwuojr8voBvyxq2jlKcQ7oRH
         5d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276858; x=1788881658;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tXnScza6YsSOijKy2kCYJ4+3czNea5Mz9Jc+EvPjn4U=;
        b=pJiW8lrxxELrlZ/TSG9oGWzRhqtq2rwjuwFI56SBQXeVSc0wJT0QwhYACNtIibiJLv
         TSOnvwIfWvn869xdxLOdcfoSuGCmtfuPM47j3Yld7x8Srso2yGZ/KsHc4tQiDF8xJ+1p
         SKgCLQtCuQ6CiXKXOPM+nx7as5JQ8BZEtNS5tsF6ztMaziZx4/+bYuaqMQOKsGvT/g1t
         YBVUKVQF6BFp3yiOEPGOf09QazML/hl1R3Ky4wpfmND8b+PRRbynDbbpQZWubmQcxVMX
         1SEfEiFQKXbW6PYcF8j+twArfC61EaktV1RTyPNQyJu8gPuwDNebAedM6Ke0BNrdkxUo
         p6XA==
X-Forwarded-Encrypted: i=1; AKwUvByWcI9A/VPQjLQo9KdqpWnVb0ItU8ZOQ3iPGaP98/mfEpWE78mk4gJQmGcEvx6ExgZeoplfj6A=@vger.kernel.org
X-Gm-Message-State: AFuF++mHl7HJz8rZqTA/8R1d74cI0sOAtA3uWjD19Wtj6qit12G5QFLh
	gVzeo+N9RljEUbXfvUBVAjeFTMj8QflnUcx5iA5gO5b9kpd7ld41D/7e3yj3M6BNmX4=
X-Gm-Gg: AYBFou2+rk0o05eGC+1n/+KEw5wAkZqccV2VwjRD/h6aapNjW3mq5uhAvoSYsibw6T+
	P5fn/NdUoBFpn6Y+PLQACq4kJwkABBDLVeQRD3BKdw3UZ96+VYYkkpa9aXVQ0uR0ilChL3XP+LK
	NdLhggv18O40ljBi7c3iOJJG/SIdEfNCP9E2tbTXpkev7oaO9pA/dQOtX7H6u0dQbTSUt1fbhp+
	jlDVSaWUQtrVWXSNoGvaqfCCb4rwXmBg1OU9iCIOKnobVAQPDbf/weU+5/6ABI/mSy6VSRHAq6p
	SphJ+dncnUg2Zj1nHBmegAY8lqhqQKUSCHPxI28oqU2u9XJK6x7QkC/HwZLMTryHj0KpY+SZ2bX
	aAtn8oa0mqUGto9d9p7EF56gH2hSorjA8uG6ZnxFXf3tD9gTGqJoa1ojf/cNowqqIC1bb8vBZyL
	pkODBnwr+64d+oUotTdGAn0N4UGOnA3tHXgk2EqOzeqQ==
X-Received: by 2002:a17:903:1b30:b0:2d8:d4d3:da4e with SMTP id d9443c01a7336-2d94a90efd6mr156260925ad.18.1788276858223;
        Tue, 01 Sep 2026 08:34:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd39e9cfsm974055ad.34.2026.09.01.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:34:17 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:34:16 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org, noren@nvidia.com
Subject: Re: [PATCH net-next 2/3] selftests: drv-net: split gro.py into one
 test per coalescing mode
Message-ID: <apbweF6mzkEXLPbu@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org, noren@nvidia.com
References: <20260831163734.1121891-1-kuba@kernel.org>
 <20260831163734.1121891-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831163734.1121891-3-kuba@kernel.org>

On Mon, Aug 31, 2026 at 09:37:33AM -0700, Jakub Kicinski wrote:
> gro.py runs its full set of cases three times over - against SW GRO,
> HW GRO and LRO. It's our test with the longest runtime. The 318 cases
> take 12m30s on mlx5 with a debug kernel.
> 
> Bumping the timeout for all tests feels wrong when we can so easily
> split the GRO test by execution mode. Shorter runtime also helps retry
> just the failing portion / mode (we retry failing tests to try to
> detect flakes vs real failures).
> 
> Move the main logic to gro_lib.py and add one program per mode -
> gro_sw.py, gro_hw.py and gro_lro.py, 102 cases each. Move PPPoE to
> a dedicated test. It has been tacked onto the tests in an ugly way,
> and it only runs against SW GRO anyway.
> 
> Note that unfortunately this will case a rename of all test cases.
> The mode moves from the case name to the test name
> 
>   gro.py test.sw_ipv4_data_same
> 
> becomes
> 
>   gro_sw.py test.ipv4_data_same
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> We also saw 20min runs on gve, but those may have been errors.
> The GVE runner is very flaky and even when it runs it doesn't seem
> to execute the gro test. Perhaps because the test times out?
> ---
>  tools/testing/selftests/drivers/net/Makefile  |  9 ++-
>  tools/testing/selftests/drivers/net/gro_hw.py | 14 ++++
>  .../drivers/net/{gro.py => gro_lib.py}        | 68 +++++++++----------
>  .../testing/selftests/drivers/net/gro_lro.py  | 15 ++++
>  tools/testing/selftests/drivers/net/gro_sw.py | 14 ++++
>  .../selftests/drivers/net/pppoe_gro.py        | 46 +++++++++++++
>  .../selftests/net/lib/ksft_setup_loopback.sh  |  2 +-
>  7 files changed, 129 insertions(+), 39 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/gro_hw.py
>  rename tools/testing/selftests/drivers/net/{gro.py => gro_lib.py} (92%)
>  mode change 100755 => 100644
>  create mode 100755 tools/testing/selftests/drivers/net/gro_lro.py
>  create mode 100755 tools/testing/selftests/drivers/net/gro_sw.py
>  create mode 100755 tools/testing/selftests/drivers/net/pppoe_gro.py
> 

Reviewed-by: Joe Damato <joe@dama.to>
