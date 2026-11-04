Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822659;
	b=jo/C4xB77lIE1gs9iff6a1NUzKR0eU69yn5JbvzrkiKUUejGFcCNi4sZVCsBpp4gSfVQ
	 k1dMs9HxEzLe30It6Sh7mGmGigGQojsyHCc60KmaXcnVfO+YYrqk4IGokggCSMPC/s6UH
	 PSuc0pMqFJgp6zgGWZmiuMW7jemAL05vf6ogV2KhpLjy6JM05xjWdQv3dtP6pA686yuwX
	 //pyQ/WnBb6+om7PtbVk8r2Ry5lRiwEnyrtckUSsx93w/7EiwPptKKVxgj8GjpiBGwuk1
	 Btp9HJxsNDx6Cd6mSjgrUDQwrXFK247teHkYkngrZID73oj6eG2tCh2ento56XlsuRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=r9/eIU+FnAWdLR0w69M05r/29MzcUR3vux4EI6BM8TQ=;
	b=SVCTyXFe7Aq4xVQbxwANDkius6wmeURQKRhzDX4uhtfEomI4uFArog4pYZfP78kxBC1f
	 fSTTWfP6qj68hOvU+0c5zD77VSwCDjqhgS3RxSXrFErfu2os+sjSA6vkXcAPRJZOfgJTT
	 g+9I1iRQP3TiQe3LfLOtTnGKnByZt/X+vERy65uCcvM6Tdnh/mHJJJPVS/bPdeoTt2C0B
	 UnWMIFrcXBJ1oh4vvovzNV/WNo5A+JApgun5avu+F3z7qZBGGXhXfkwpn5pCkzOgRMyLC
	 ad0JT3St2uQzX9cg+fAMPZHd/s+OOLdE6xCI9lsv6IiwyniGjebiF38W8YSejUw+0BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ITkVV/lq";
	arc=none smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293B606E839
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3293B606E839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ITkVV/lq
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab3dd9681fso11716291fa.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822657; x=1794427457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9/eIU+FnAWdLR0w69M05r/29MzcUR3vux4EI6BM8TQ=;
        b=ITkVV/lqV3pmRjprq/RI736OUujqbhkGPmsQfyiQLZrfwsRY/8ho0oOyTqoTndSHXz
         qf/PkwR5GDPJgRmLi5Ap15hdlxt7OVssd6+O/HtTvkghiLb4iFWNv9JxCZPHWCNfA+BB
         n+4fgtOJK/xQoaR61Eb0LhldN3+2NLnDLj3d39VPL8yq8D1sDPT6zQ84Y4yG5x9a50c+
         GDBsx83ygq/olVCl0znBqVnhKr0P4K/4nx+AklKHfEspCebf9M4K1g6Je6a5hU8G5ZGA
         43f2Ou0F+Yi2qY8Np5LHn/C3S+NTxB1V37k/p8khAyDUv5cNvV+hNGRcue6fdb7uJBER
         iSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822657; x=1794427457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9/eIU+FnAWdLR0w69M05r/29MzcUR3vux4EI6BM8TQ=;
        b=KvpUALxRq34Xu3FvvqiAqBt31Cfli2iObXXtBrjsSo9zEifjVwc5e3tDnHw7pMhhF+
         jW0M1CU3iACrF1HluHGT0Rsmik1gn1QXXiCkF+bV9HEYZuSUxHGcoTS9jXQcC31dYAGy
         K713UjAFpYLUuRllH7v5y8i2mpihml7Pp1+SYWt0KEwhF4exZRSIS115eHyGdmZKoMr4
         OZArBSCTM8Ikfmjy4upHM7vOOCKWlu3zdpk6L8MWn0PHjDt2yQ5nsbRN0c+arcTAfsMf
         Km/1H/GXrp9ThnC5roH5BKzJ2RRh2nBQoge0AXQfm7OH3OobcQSZUzXpiziWn2sOuOxQ
         xGwg==
X-Gm-Message-State: APuU4Z8kWNUDbTebwlZga8/O9xWFYss88BiFofniGBKIkWtMIvvNk1w/
	vRWzO2ScYDsSW+LTxmd74oTSt2h3sUFMLYkQSfA9bS2fIyhk+3pmx8BED4lC3PJUFLvqsQ==
X-Gm-Gg: AYBFou0kUHFhk8j1JmtAeWpIPqjVFsWO7T31v5rI4X0GUSfdVToK6HupK8d/6ZtwC6Y
	V6pO6M3GaJ8OZ6GJ+D4iFSA8Ga3XfTxgCw4Jl5NM8t4ffzoK6mk8iVLngikU9DcZwfWh5u3QDFk
	F7eEUXCwT8LXdcgDbiYq1yirXOFiSORzojoRt4l28LmbV9qdS+s2rIvepeVgdrMK7sBqZynehj9
	RzdXLFLlWUKVcib8S41bV796YJLXhl3SUmJJA7o9oC6gqY6QXEWMNx9mYq0QW1CIbczfZlk7OL2
	s89mMQUdi3BlIQTFMC4L3P2yN+q28rm5hP/8F5CbtQcgvQlYw8poQXtzRyQBekYqZVLnPv8dOxG
	HXHZos22OniPy6Te0+eH05FsKpvUpeArUitKmfZ+1WX/p2cnqvrnHODvk4j2oSlB40Z1jRL2aHQ
	xZXhI5+gNwbVPzg2GZBRDRnbdP6OE3fXWFRBNBMqDz/PP6Jcss9wDI1NWSRHn0RdoAVR+EKQ6A1
	lBeeZes1AjYbLYjLuttT+aNQpIEOX1fn7jl6fz0p35Dy1KzHLLUrbIjkgFLoQlth7DTyCttr7v2
	kHDdEk2QO5Dt/s9C5bdxI8Bk6DtsSQ==
X-Received: by 2002:a05:651c:150f:b0:3ab:3af4:c2d8 with SMTP id 38308e7fff4ca-3acb7ac0035mr41427011fa.28.1793822657073;
        Wed, 04 Nov 2026 12:04:17 -0800 (PST)
Received: from gentoo ([95.55.209.127])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acdc6e9b60sm5848021fa.35.2026.11.04.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:04:16 -0800 (PST)
From: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	weiwan@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yaroslav Dudkov <aroslavdudkov622@gmail.com>
Subject: [PATCH net v2 0/2] ipv6: ignore link state in gateway check
Date: Wed,  4 Nov 2026 19:56:53 +0000
Message-ID: <20261104195655.1406837-1-aroslavdudkov622@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 gateway validation can reject routes in non-main tables when
ignore_routes_with_linkdown is enabled and the nexthop device has
no carrier, even though these routes should be added.

Fix this by ignoring link state during gateway validation and add a
regression selftest covering IPv4 and IPv6 route installation.

Changes in v2:
- Fix variable ordering.
- Add a regression selftest.

v1: https://lore.kernel.org/netdev/20261028152634.3355852-1-aroslavdudkov622@gmail.com/

Yaroslav Dudkov (2):
  ipv6: ignore link state in gateway check
  selftests: fib_tests: Add carrier gateway test

 net/ipv6/route.c                         |  2 +-
 tools/testing/selftests/net/fib_tests.sh | 40 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.54.0

