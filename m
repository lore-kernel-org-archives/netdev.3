Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACB3905F8
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944288; cv=none; b=TKf+ojcT1aoR6hyHZGBrKWvAFbVIVF1DaKKV+giRiA1acI2kINCKIZQgNN+kD6cPkfoLjMxx0GnlB2fn6e6fQFqlZJ6uTzp/GJk/2/JIs1w3kBABpGr+C/e2nZqxUS2/KNc3LsKRtaKImuppaUsKLxeFE5H8RDCOfb119J5nu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944288; c=relaxed/simple;
	bh=2dHcyxAQOJ9xO6CygIkhkHbB1BX2WgWjQjaeYsODbgk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZYWVhcPgnT2X2uOu7XIevieSfAvxlGQ9w4O9WEtTGORYJ76kvAfyJZJbeg1iuwNAdBb/sq9nASUwgITjumigeSYnudPqHpIpxpW0bSZ1jvt8Nk9bBEWmRPm6nysGfSgHtsPoqzsQmUHqmKKCbPPiW4PfqVKzegBnBIDU3nw+/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzaIkjdB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzaIkjdB"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so34452115ad.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790944287; x=1791549087; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o3SQNHG3a3lV1GLPGV/qZLqYmXawUuJRncUi3dhyVQk=;
        b=JzaIkjdB8vnnxNhB0K564opmSkdRCb6oi7fm/jCvRlgmzb5LcEFUFjY5z7EubaPKI/
         hN3y9wo0ITb1/RmJeQma/fL7kgvQP6/y3kd0Lb5puKsDQsPwJQKv4wHi0bwSiri4w35Q
         J2iR7y+6iBtYkv7p9TKJQX1+Axs12FnI+t7VbKW2/qKV7D8FmszTkaijZjdNEsNk32YO
         ZijU9bNGdEfunOSQ0myx2kcos/RFh4VRX8gciC2syEIqgYm1GgbBP9f8omGW2mBwAeSg
         adrlCypsW0JaR4aoMaNz1vqTEZU3W3IhsqoRSfR297qsGYSt9o86wso8k+BxnpBj8xAb
         XIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944287; x=1791549087;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o3SQNHG3a3lV1GLPGV/qZLqYmXawUuJRncUi3dhyVQk=;
        b=f6y4UQ7vuyNv7cNzkbFyituHbVQm0kfJRU3IPHNKB726U492WygfQggCITT4kQdfmc
         i8UWSAVhDeUnBUZjj9/pP8vYnFmeWKoMexEDx4dvD75BlBzQsfNpmQ2RFVsVe4UYI1rO
         l/3HriKHYiWXpIrpuulQRECWjcseBs8Ry2sVLH7qghTQ+PsBnmDURDFXZ/iMCYxbUX0s
         M7mS51ni6U3YC2KUbhGA/RkjV4P9uq7gSwB7n8yR8qSzmmD0aWHd0K6YRSpiqT/ZpW21
         lgRA2mFiOmDrdjcAsV0OvGdn1tgCEI0d6sWlTHW8ozwI1gqM8bYtSZlWEDfn4Evz94Zm
         AxSA==
X-Forwarded-Encrypted: i=1; AKwUvBwXRqL1qzPjEJZiYUhJ9ih/FxSUtMkgL9ohKT5llZW7bW/FB81hsQL/ssWtiZoI8WSQ5WTHBZ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYD93/8c94RJqrVW04IQFGNT5mZhILnOp8QPVwZ0YFvFwPJzLZ
	OJ73dPMS2MReL2tRQbzvmq0ucUB7C8wni5r/A8q1y+CgrOgdtReTYwRB9MZwPnF3
X-Gm-Gg: AYBFou03pHhGUtOowlQq+Lv23GCwdcxjPF9pq4L99+5TJx5XDPudlZljfvTsBmT7MHr
	G5TR5gjcRWsX1mUpD7J6afyR/Yd+R50K9F/Y2pTDeio6B6anzatC6xo4Y/T9foJSZD8GhlD6/g1
	PnZ0vd75g1jJ7YN6f419QHQiq8G2lDCv09r1VeuoWTuM1CxFpQUGlrDrmcFxSWPe/9Yo0hpThM4
	aPdwoP4wRLiXMg7jIstNrKc6tFlY8/Ojxzj0O0sDfJTjt+I29hJ1gLkiiOW5DPJhrLlnjuA0Ub3
	td4SfdjjU0I7TpMobXpGuKYW98mX/7vUoQUey56kiUag3705ade5ualO36w6ChTgRX69PK2QAy+
	dZFGYchyRawa1MagOP5KR3hqp5Qc1UHd5FkLhbZ5muOhPZq0/K5f2eLPQev6YfpZPwU6wZCVivr
	eztkjqEvhxc2eXBkgHGeT9ZKt+j2gJMvUZAaPpFNQ6Cct48xPGpBDwSKTyR3V09T4wMQAbyiQ0T
	jMvyUFZyjDZ/x8Y1tE=
X-Received: by 2002:a17:903:2450:b0:2e2:e0f8:e57c with SMTP id d9443c01a7336-2e49b694c1amr23574395ad.70.1790944281882;
        Fri, 02 Oct 2026 05:31:21 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f705f37sm6938125ad.64.2026.10.02.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:31:21 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC net-next v5 0/2] seg6: add support for the SRv6 End.MAP
 behavior
Date: Fri, 02 Oct 2026 21:31:16 +0900
Message-Id: <20261002-seg6-mobile-end-map-v5-0-30eec37563a8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABWkv2oC/23OS07DMBAG4KtUXmPk8duskJA4AFvEwnamqavGq
 eIQFVW5O4lZEFVZzuv7504KDgkLeTncyYBTKqnPS6GeDiSefG6RpmapCWdcM8UFLdhq2vUhXZB
 ibmjnr9RFjFyCAwuGLJfXAY/pVtVP8vH+tvYyjjTjbSRffwvlO5wxjqu9jk+pjP3wU/+YoB7WS
 ANsN3ICyqhzARlvtAUpXtvOp8tz7LuaMPF/wzHYN/higOYuHCNojeHREBsDzL4h1j+sY14zH7U
 3j4bcGFztG3IxpDJGiMissnprzPP8C+RxdZ+lAQAA
X-Change-ID: 20260523-seg6-mobile-end-map-9cec24191817
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Justin Iurman <justin.iurman@gmail.com>, 
 Florian Westphal <fw@strlen.de>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4558;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=2dHcyxAQOJ9xO6CygIkhkHbB1BX2WgWjQjaeYsODbgk=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqv6QWLLbYZrlA0WI8oybkkcyt0SE5tYFxupbom
 uL3rdxXtN2JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCar+kFgAKCRAq19F1Kl0b
 TWMtEADUChN0GjwEu/DH6mdCv32bNkhIKNCtmJX81cqlzRsIwuplv3GX+UE4TH/c+JF/LDA9GyB
 PCOJXZsrkUoI8dtzUaQUIBdzIbU227RWIw58g+0HCsrNJ9RUbfGK5nK91azGa2nRGS9bzYeJmKS
 mz/YHxZ7iONRQtivf0xsFnZ/o5qc1mqLw9GBOyiDdBU5snc12dHzIJF4bZSof0WzhgKzZb/aG85
 3Xxs8V2EcZq7lamz8q+ppAfrJFDnjjHbiZJHx2cEOqK+bRM4rmbHFSFLaxYS1qZUBZx3OxMjMVA
 +9NeaEXMVIbZotqTM8wln8/eZy7xtimKfw5zjH3sXr3BM8B9E4w6a1NCg6bDkIuqFwpjkBAYbdw
 iUsEAOqqciCqCzQOwl81DTdrAWxGeqEf1qrfJRk9Xpt5Up5w41Ltkbf7MBofdDWWQcv2GtJOO+M
 20Pj3WuNJjXWJGn7u6sZA18WvfGyh7/nQjvVshFf+ExWtcScYtzLzdRQJ9zSWJ13B36to7Z2UMZ
 7JEXLKNQt/4u99Lta57bRdoSy5Y68dwsA+XjwUdOlPsdSVf5JzAmwi78BjNuyfPNNtPksXWiefZ
 mGOJCSWX1S3OHNcIR/BfEHnFl3MUzh8pK2GYBKn56lHWaRG8zenYTOqrWZ2X8yWfOqcXNYu9yQ9
 hIN3YeprHm3tPIA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

End.MAP is the simplest of the SRv6 Mobile User Plane (RFC 9433)
behaviors: it replaces the IPv6 destination address with the
configured mapped SID and forwards via the IPv6 FIB without consuming
the SRH.  This series is the first per-behavior rebuild of the SRv6
Mobile User Plane v2 submission [1], split one series per behavior
following upstream review.

Because End.MAP is the first behavior to land, this series also
introduces the SRv6 Mobile User Plane lwtunnel framework that the
subsequent per-behavior series plug into:

  * a new LWTUNNEL_ENCAP_SEG6_MOBILE encap type with a
    CONFIG_IPV6_SEG6_MOBILE build option,
  * net/ipv6/seg6_mobile.c, which hosts the action dispatch table,
  * include/uapi/linux/seg6_mobile.h, a dedicated SEG6_MOBILE_*
    attribute namespace, so that attributes whose semantics differ
    between the mobility behaviors and the RFC 8986 behaviors do
    not overload the SEG6_LOCAL_* table.

This is an RFC because one open question remains: whether End.MAP
should live under the new encap type, as here, or as a seg6local
action.  I picked the former for the separate attribute namespace
described above.  Following the v2 discussion, netfilter hook
integration, VRF support and SRv6-specific drop reasons are left out
of this initial series and will be revisited separately.

A matching iproute2 series adding the "seg6mobile" encap keyword
follows shortly after this posting, since the selftest needs it to
run.

[1] https://lore.kernel.org/netdev/20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v5:
- Rebase on net-next and pass the SRH to seg6_hmac_validate_skb(),
  following commit f9cb4d296d81 ("seg6: fix HMAC validation when an
  extension header precedes the SRH")
- Drop with kfree_skb_reason(), reporting SKB_DROP_REASON_NOMEM when
  the skb cannot be made writable
- Forward packets whose Routing Header is not an SRH and has Segments
  Left 0 (RFC 8200), and packets whose header chain ends
  in No Next Header, instead of dropping them; extend the selftest
  to cover both
- Link to v4: https://lore.kernel.org/r/20260925-seg6-mobile-end-map-v4-0-457733c08586@gmail.com

Changes in v4:
- Fix the checkpatch line-length reports
- Link to v3: https://lore.kernel.org/r/20260917-seg6-mobile-end-map-v3-0-9890a60ac6a7@gmail.com

Changes in v3:
- Silence the shellcheck SC2154 reports for the namespace variables
  setup_ns assigns
- Fix the checkpatch alignment and __func__ reports in the selftest
  helper
- Link to v2: https://lore.kernel.org/r/20260901-seg6-mobile-end-map-v2-0-1629bfc166eb@gmail.com

Changes in v2:
- End.MAP: patch the L4 checksum also for an SRH with no segments
  left and for first fragments; selftest cases added for both.
- Use nla_parse_nested() for the nested attributes.
- Rework the selftest helper and cases; wait for counters instead of
  sampling them; add CONFIG_IPV6_SEG6_MOBILE to the selftests config.
- Rename the SEG6_MOBILE_NH6 attribute and the nh6 keyword to
  SEG6_MOBILE_MAPPED_SID/mapped_sid to match the RFC 9433 "mapped
  SID" wording and avoid clashing with the SEG6_LOCAL_NH6 nexthop
  semantics.
- Trim the Kconfig help; add Assisted-by tags.
- Link to v1: https://lore.kernel.org/r/20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com

---
Yuya Kusakabe (2):
      seg6: add support for the SRv6 End.MAP behavior
      selftests: seg6: add selftest for End.MAP behavior

 include/net/seg6.h                               |   8 +
 include/uapi/linux/lwtunnel.h                    |   1 +
 include/uapi/linux/seg6_mobile.h                 |  61 ++
 net/core/lwtunnel.c                              |   2 +
 net/ipv6/Kconfig                                 |  10 +
 net/ipv6/Makefile                                |   1 +
 net/ipv6/seg6.c                                  |   7 +
 net/ipv6/seg6_mobile.c                           | 723 +++++++++++++++++++++++
 tools/testing/selftests/net/.gitignore           |   1 +
 tools/testing/selftests/net/Makefile             |   2 +
 tools/testing/selftests/net/config               |   1 +
 tools/testing/selftests/net/srv6_end_map_test.sh | 456 ++++++++++++++
 tools/testing/selftests/net/srv6_mobile_send.c   | 283 +++++++++
 13 files changed, 1556 insertions(+)
---
base-commit: eb0c18404c8943356f4aa164e5db9067b79ea93c
change-id: 20260523-seg6-mobile-end-map-9cec24191817

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

