Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925B3AC0CC
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787574; cv=none; b=idOpuL5LfKRulX+2gsFpkAVD1OSmcB/AmzpivPdhi43yTqSJyYALzL78V/j0FhCj3VfaSlrS3S7WF6hAiENYZVyzXYoFJy4YXaHqmz0uQNm2HIXfVDqp9+++64EKwCwOceuFL5+oiYqQPgiawjB/TrsoqDyr4l6JSu+64r/m6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787574; c=relaxed/simple;
	bh=yIsTclutRAUcQDJ1z2fx19eGQmCProIOCrZK1URJW4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJt9k5OMDq7P9ZL7+JmDaxi9ptbljfQ7vYsKygTAtOBrG1I5aCcjAbgsDYyNIPKmDMtiV3aR2SGial/u69Ye+8FCiq8fkwFKL8Nf5sEyJN66mWDSwFoa8xsAjN9Y4g1Y8IP5kGHdYYf4Hz8Il7VRrBf0jr9TdyY79F3BZI4dUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdmarSB0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdmarSB0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37c6cd1ac98so776876a91.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781787573; x=1782392373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvlYYaTQFdpc8xS2DhS0Qq3G5MuVOkm1bSjyAI/p1NE=;
        b=cdmarSB0XHnHpnKSw++A1SLbfX5GXNKnXvMpfqPEdWVWEi8zHcXHwHVoW/2bW4heAv
         TGLPyadGiXEhElICJ8sv4RnJE3UP/iVqiLN9uw17peK3iqWYtzgu76Rr/UBJKyTkfv9o
         CLATCM3L0EM31e3TfxYtqZ5Px0WLqDW495X/BHIS5r5jTByjttG2k/AVm+9oAOVERmRq
         8gLpbwq4AmaPQmPbJh2hik7banKyyIfmJeSGMk9adBPpHiN/XRvCuN+tVwCepGMCrU1J
         vra/AdGAp54hUfHfhipiUpcQCenaPXUFSdgkUC9NaYphYMhbvNf3Ji2dJjYkVVVdSH6l
         408w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787573; x=1782392373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvlYYaTQFdpc8xS2DhS0Qq3G5MuVOkm1bSjyAI/p1NE=;
        b=G4UDTpkL9Nro4GMhDOrdd66kpgZHK8Lh6/h0jP1RW7b962FO8gqSIcFsQJmU9IhgE/
         TkN6mIBV3MWWUJEY0Ow8prxh4QsrXXFKFGNoE8B6RpxcSchlmoo40TpS9m+hC2occf8b
         0QuyldFmuuRcwf+2ysfP2mr0o1mtSRz7G0MnT8AoL4biKZ+FVIn6rbRriAYJSUt2i3/r
         kSL8KmVxEeTlvclUusd8+ZzPPQ3gMBVyOULaobAeH2KaP8gqT8mxQrOWyxzjOdeaG9X7
         G/DHn+NoK7bv1V+cAnCwu8o+E/woVWxPGTPpEnNQm7Ltk8HwZdCr6Vww6r+l7XpWSpZ1
         jDWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E2iggBhVtTAQDrkKD6aP5jZk0W0jMXUmS4yPbEupi+EVQcFYvDFWuSBXGSaQRuuVkYwVEkT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJp16qZiUFHflGeyE3ak5dv+xhoZme/hV1u2q8lwOpzgFBNrH
	/5q4dLUcfmJMa/RN9xseJlI7zAoI7MT/xUhF3PPIXhqOnakNLleH3eZ2dxGd8PtjQ0s=
X-Gm-Gg: AfdE7cm68tsBCDUTsxfVmfcWNohuP1qu1cj8MgmS4uxACrOF5mqeA2aOCgdDkrjF0rM
	CTVAnV4cYp3eIxoQWxzcIu9rX34iKlzsF6evvpzUxISuujh00AxJ4CHNVrBpg45EvQllt/gZKqu
	AlZXg92KIxLSJzE/XmcUjJ5FYZ9jCycrl48uzuLYE8ixb4N7qu8zTYLX+UBHoMWz7Q6rWrCzvYC
	5yT8q4yfIeuD7MW5uUX6ABSKDpRonheKwDcJlQ2KsTj2e2OazKin8XbFJqhpkpZfRfFs1SeOM/3
	AnLC6FHe3F1GfpPXtehKedXMliWVWim4ZPEwxeT10X+VuAJmqRUdjhqU4b1R3KlrGFcuBza3eFM
	Fz+t10Jau8xX0droSPrINoXqL5E+CF34n4x8silSJWbwG+qcr+1fa6QZ7OjyF9DQ9FgxQJwS2Qf
	tOSQAODio5Pq1iNzs5+N9UgwZelQ==
X-Received: by 2002:a17:902:ecca:b0:2bf:356f:4e0c with SMTP id d9443c01a7336-2c6bbf8ca0fmr96767445ad.1.1781787572984;
        Thu, 18 Jun 2026 05:59:32 -0700 (PDT)
Received: from c79home.localdomain ([2409:8a55:35d3:46d0:20c:29ff:fe83:eeda])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8c1f9sm202857735ad.59.2026.06.18.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:59:32 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH nf] netfilter: ip6t_ah: validate AH header length
Date: Thu, 18 Jun 2026 20:58:48 +0800
Message-Id: <20260618125848.93550-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6t_ah checks that the fixed AH header is present, then uses hdrlen to
derive the advertised AH header length for matching.

Return false if the skb does not contain the advertised AH header length.
This avoids matching AH headers whose advertised length is not present in
the skb.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

I noticed ip6t_hbh and ip6t_rt already do this advertised-length check
for their IPv6 extension headers, so this keeps ip6t_ah in line with
those matches.

---
 net/ipv6/netfilter/ip6t_ah.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/netfilter/ip6t_ah.c b/net/ipv6/netfilter/ip6t_ah.c
index 70da2f2ce064..a40240125a1b 100644
--- a/net/ipv6/netfilter/ip6t_ah.c
+++ b/net/ipv6/netfilter/ip6t_ah.c
@@ -56,6 +56,10 @@ static bool ah_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	}
 
 	hdrlen = ipv6_authlen(ah);
+	if (skb->len - ptr < hdrlen) {
+		/* Packet smaller than its length field */
+		return false;
+	}
 
 	pr_debug("IPv6 AH LEN %u %u ", hdrlen, ah->hdrlen);
 	pr_debug("RES %04X ", ah->reserved);
-- 
2.34.1

