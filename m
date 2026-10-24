Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=61.247.196.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792865066;
	b=xrIfom/w06LDLaYScpt8AzXDI62ScG/+8mpg4UFq+MVoVUAQgZymAbWy9oDKZitfLKzY
	 lkgwPKezU0aS32amoNP3HICdBXKgPzlbC/Zcm8gzm8m1lqv02J+VA3iJHiuzyN+JozAkM
	 e3yCTH5dGDDHHgBO0yC9XTwd8gDOm/wW2aUnBG0eifLPeZsXGXxyZtkmgRDxPaNZyG9Ju
	 lcCybCo4bnkKtsETodLcJ/yw7tECuHmf7TkBzd0E05HH8uv3B5foLI7QKPgK2Faiv23rc
	 AgfC/pRlSu2xl1ci8Mo0e6LsgJY+N4SF1evhxrHoieMtpKQoOtvuNNtSOSSupgi4C0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792865066;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6Yt91aM3J/GXU3w8IvgaUYZpRjjeg9TYDTr4NbuzEgU=;
	b=pRheuz936zdofbBKBkjrWvZdT5KsJopOajCTAorAYhk0Qgz0lN4PF2fx3Gz2OGBg9kak
	 WNPJ/d0N0AIqoAAz0KIqjReDDA/vRPLuikX6SV19sn6ggOt4i3vCbYoFhAagCmBE3uiZ2
	 qwUQ3J70as8kvIE0gVAijqSKbajowXRpuzXf80A7BfSBa277SYMrNW9lc/8mfiZgMDPyY
	 QhYIxYYGX+dzZWRCe5PmpuEuQwVCdozpJOHPImkeIbBrEfihV3TZlPNj6XcVnN/ecJ3OG
	 5AEJ+EnerA68cKInTcp3XeHFjg5NwknIGeHZCQPfc4QCz2mJTUPiUZB089hfSER/jRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=naver.com;
	spf=pass smtp.mailfrom=naver.com;
	dkim=pass header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=XHvXZhRj;
	arc=none smtp.remote-ip=61.247.196.152
Received: from mvsmtppost09.nm.naver.com (mvsmtppost09.nm.naver.com [61.247.196.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E703606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 18:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E703606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=XHvXZhRj
Received: from cvsendbo008.nm ([10.112.24.37])
  by mvsmtppost09.nm.naver.com with ESMTP id mNyClA1NRcqB1oZGdMMIwA
  for <netdev@vger.kernel.org>;
  Sat, 24 Oct 2026 18:04:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1792865057; bh=/8/K7D/IBzyjOkGeYMUmyaSHOLRmctpHvDsb8sAVmMo=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=XHvXZhRjxe87NSa8/loLrNBN1KbCLr7LSaORqCGaJ8zqIeOrJPYFuLMlIkOxmHaTJ
	 Ah2yiR5h+hjqbDlaAqz8OgvgMvnLGlfbPghL6MyChLv8GYuWJn6aGaBS65rSCDkExP
	 vozU7VW8GLvsxF8DucVnGUiBBfnpyBXGD7+27OT8lzd0H21d//4DKWeasKtxB8GFs0
	 /6YlXQFgNP7GLaVesu2SS3yDeCUxdmMdwpt892uKECcao41FG8/0/KxLCJLHr1QOrl
	 nPNJ/aRXVcfS5vmMxghH87gIXksRVKIFK0OKm+0p1vol5CuIa3heySnHZUDEZNQ33o
	 sZyLNCiPZOGCw==
X-Session-ID: UQJepegCQTmv6mqF-p3e8w
X-Works-Send-Opt: vf+5b4RCjHmZjAJYKouwjAuwKAvwKqgZFopYjAJYKg==
X-Works-Smtp-Source: QqYqaAUlFqJZ+HmrFxMZ+6E=
Received: from localhost.localdomain ([183.100.208.186])
  by cvnsmtp001.nm.naver.com with ESMTP id UQJepegCQTmv6mqF-p3e8w
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 24 Oct 2026 18:04:16 -0000
From: Haon KIM <akrn112@naver.com>
To: dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Haon KIM <akrn112@naver.com>
Subject: [PATCH] net: l3mdev: Set OIF flag only when an L3 master exists
Date: Sun, 25 Oct 2026 02:57:46 +0900
Message-Id: <20261024175746.2341-1-akrn112@naver.com>
X-Mailer: git-send-email 2.37.0.windows.1
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

l3mdev_master_ifindex_rcu() may return 0 when the device is not
associated with an L3 master. In that case, l3mdev_update_flow()
currently sets FLOWI_FLAG_L3MDEV_OIF even though flowi_l3mdev
remains 0.

Set FLOWI_FLAG_L3MDEV_OIF only when a non-zero L3 master ifindex
is returned, keeping the flag consistent with flowi_l3mdev.

Signed-off-by: Haon KIM <akrn112@naver.com>
---
 net/l3mdev/l3mdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
index 5432a5f2dfc8..92b48d6a4301 100644
--- a/net/l3mdev/l3mdev.c
+++ b/net/l3mdev/l3mdev.c
@@ -279,7 +279,8 @@ void l3mdev_update_flow(struct net *net, struct flowi *fl)
 		if (dev) {
 			if (!fl->flowi_l3mdev) {
 				fl->flowi_l3mdev = l3mdev_master_ifindex_rcu(dev);
-				fl->flowi_flags |= FLOWI_FLAG_L3MDEV_OIF;
+				if (fl->flowi_l3mdev)
+					fl->flowi_flags |= FLOWI_FLAG_L3MDEV_OIF;
 			}
 
 			/* oif set to L3mdev directs lookup to its table;
-- 
2.37.0

