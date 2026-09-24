Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD779266B72
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226937; cv=none; b=jJO94OViV+OjhXznq3cch4aoqDk06DV+nRN4WBqI2Sgku+abhLPqrvh6CwesyCHrt2ckTi21NoufiqqIt+sxwELJ8g8CzRufYcGYdhDMujUuX/gxbLDyAYqd+JrYZyIrBiXfAqW73llVPi0P1uLilDt2Ko1DDysYcjBMmjIU+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226937; c=relaxed/simple;
	bh=ooeLktLlgv5ipoC6vY3L+P+LoVJc8wd6r9b4126KwO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjKe3MlE4wXOy6/hvVXkyT2DghNhu+YCZLUFi9uv/SLN0U7/488quYC3TTo+5C8eyXG93BIqN+WueL6g1YoWISVhuGWtT4P6Xzfz6usBsJ8EAgj+M8pzTAskBzJ9ou7Z8n6haO8NkLT1IDpnO1Cs0vubuOaPPvpqxJ+UaE8K92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IncmumBJ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IncmumBJ"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2dd88a115ebso10151195ad.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790226935; x=1790831735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8MJJXLu5JWmqzN8gvpfOKuAAfjxmxpsaGArkxyS3jzc=;
        b=IncmumBJ/KE6UQdXm0PdYXyqnZnyqa3kCUs0/nqfmQTPvdCKuABsMef9kaT45bHQtu
         Rmc+lDCBjo4f44/fnVnHLp4lHb7hOW8mgXgny3CwGqdoePgW0tFsu74pYSyPSWwGqZz/
         Ph3iAsR/kIaiHqQYiPt+cQ5XXiVGYMaTnvGvDcl4mCu02z9LrOGZsRq9sqIQIonn0e7T
         apsVVnPIYrhImCPw1Pb0leiAwKAWj8Fi2CJS2ZnrDqDjnuqmv9cjDV3HuQGdOF+rLQ58
         bRbRd7Rf3gaRq+IKt6cHb6VgKadqdhCSdbAqmG2wMz5jSGTJbi+0rtyRHMJEXlDw4bee
         kXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790226935; x=1790831735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MJJXLu5JWmqzN8gvpfOKuAAfjxmxpsaGArkxyS3jzc=;
        b=1Fk3v/yBu838eILxQItslvU6TgtqUBEV2MVWayymCaH/aM/JrAgIwyZ7U2aIn3Hv8x
         CLKjeofXkXh9uooJ84PgknpBQpqj3kGOWuvMHjTiQQ0p05ZcnYcW536qrGAiT92fCfYf
         GErIPRuO7LWC56NSC/npcAvJ3CbKkdDFriNg2Y+MrnhCZI5IKMMMlWwmL9G2IKP7n3nK
         ysd19Q1V99P/qyfcQgi6zMFqH92Vq9eBjYQZuv12nSf/0+s3uta7rhLMpsO72TE/WFvf
         S0uyP5hIZexhoC5DAgAaSr6CiI4L1pmNc9CwkAvz+F4+xAD3MLV8uOiD/Jf49wyBKRGf
         jcYQ==
X-Gm-Message-State: AFuF++l9dcOtItRTRz5apzJlMLrKQQmLRwWYC8TquQsO3aM4M2zOVx8J
	GxFvZY6rEs0fcKn8mdxZKLXjZ7ZLkZlB4DGeLr56HOE6VB7ZchU7Epj0s2HJzQnPGYFoujXxa5D
	D2YVWeMRI
X-Gm-Gg: AYBFou29Hdzr114zN/gXZQp/QJji/TrwsClW2j/E2uwf8OL8g7cfTvdA760+Cfn9Z0u
	/1Eb1WZOcMz5ovQWgP76aatdGXklKfLB2UqT0D1hk48n2n+I9C0AVa+3WIqqcZTiNbWKhLv/Ayq
	YsUX09djT1do9BaOdzRwsXEMTKJarp/uUjipDc2V11s44vxvrvNiYV6zSK0yaqfYcJAh8Js10MK
	sgFYJzJ+tuSfay1QCQk4Z4//lRNeq8kZ0PxIc2Q9+p+1iOXVHm5cAHUZ7hQbW9GYfVTEGrtmtpX
	sFiH7IZfNKqveQj6rqLvLfd790lUlOcOb7kGWqLObkj5mAayY0Luldux90BWwAQsyn4IZq2bnNU
	32BiCPpETyI4/6cGohwM+txZFlZMF9PPXq83xf2fUqRVrFEWI1Z7PSy1XDYj6N0uBV7N+Kvpi7D
	9fVqcvztQQczKv5hXHlRcn3neMb/MzZNNGRFOMylKd3AUh3zU6iYzJUyBh7M6fIHmDrle4KcDyj
	cE0lSgOgm6/klFi4nPp/gBwO4rzYg==
X-Received: by 2002:a17:903:1447:b0:2dd:c053:ec6d with SMTP id d9443c01a7336-2df7e11d07fmr11774385ad.32.1790226933498;
        Wed, 23 Sep 2026 22:15:33 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b48sm20062485ad.23.2026.09.23.22.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:15:31 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	willemb@google.com,
	kees@kernel.org,
	richardbgobert@gmail.com,
	zihanx@nebusec.ai
Subject: [PATCH net v6 0/1] net: gso: limit recursive IP-in-IP segmentation
Date: Thu, 24 Sep 2026 05:15:20 +0000
Message-ID: <20260924051521.32568-1-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

This reroll uses IP_TUNNEL_RECURSION_LIMIT directly for the shared
IPv4/IPv6 GSO recursion check and adds the requested Closes tag.

The v5 cover letter has the bug details, PoC, and validation evidence:
https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/

The v6 code was rebuilt and the PoC was rerun on x86_64. The BPF/veth
path sent 65536 bytes; tracefs observed six inet_gso_segment() entries,
with the sixth returning -EINVAL. The UID 65534 namespace-only path
completed with depth 180, gso_size 1400, and sendmsg() returning 3676.
No stack-guard, BUG, Oops, or panic was observed. IPv6 was build-enabled
but was not separately exercised at runtime.

Best regards,
Zihan Xi

Zihan Xi (1):
  net: gso: limit recursive IP-in-IP segmentation

 include/net/gso.h      | 8 ++++++++
 net/core/gso.c         | 1 +
 net/ipv4/af_inet.c     | 3 +++
 net/ipv6/ip6_offload.c | 4 ++++
 4 files changed, 16 insertions(+)

-- 
2.25.1
