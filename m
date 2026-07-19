Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CB2F3C37
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499335; cv=none; b=ilhZsnKBq5ZEzO4Khli05tRnFUS5CtYUxqhb4UQN2KPZcfhHDyrCTmgbEFK+KSJbzFdVbcoRi75DLdinJE751OlZ8KytiDrpql7JgTpgu73nqgcxQm7doDnrDFASe7YRLNr0tvkvVKGMR0YLDEK5NSWAG32rktU3FhOMPoJ45XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499335; c=relaxed/simple;
	bh=phqWj/Y9V2U1q3g+xUxQmFCZQ+uhizVr+3ljUR4LdUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSElKm22ainXX8DI5brERvJPl0Qtvip3hS69YWvBQnLWaCkHlc3rHMCAHpGVU3IK86GC7e1shez6YTvhjIJh+Qkh0Izg0eIPiAXQLkeeMAqQzNhvv25FRM33ZmIBLRJkEVaULuYvgg2MDKVm6FLXK7SF1cRV+nGCOGrp+QDK57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=iQtrT/0k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="iQtrT/0k"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso66245645ad.2
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784499334; x=1785104134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rBbMwui+/L0pgrSCs8qYX8BN/DRimeZ19odA05vUJ9o=;
        b=iQtrT/0kRWGXXzisfc131QpJKoAa4lVVmxVGW4ANgdNreHOHbuG17v1lPZ12rQvw5F
         llW7nImRLEfG0XhE73Fqu/K8+tTMYkg9v8fF9zVaexLafkCV2WzRhTtRhgk+rJ9lH2Ym
         DuZXEyuWJEWlLKYvPZsGeyztfUl62F5eshkFKHmAPxvIE2yioAG6+NXr8ZHgYHvC8BdH
         MO1MiSJDyN8u0ywxYtnsNW9w0i3NIS0Ck8KaeKaQZSei3zX9fgAYTFOpuU+PzcBcGlKf
         EV0n7UU80iWqOpIp0Vo69eoUai3DzpyR1u+r3IqM9eVbuASrcMLmiVC1MhD/H8KArPFi
         7MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499334; x=1785104134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBbMwui+/L0pgrSCs8qYX8BN/DRimeZ19odA05vUJ9o=;
        b=rF21j1hbFFhjktcHuA9HbzACwFDyhxX0Tec9brVfh7S66HGySyeZ3KWKnYu9a1I/j4
         4hCru9V8WM2pUdbeoVhV/GSjSEZQPXOBKw44aZ1E6c2sLt1+lxK/ImItIWT3aUmrSd6u
         vKykeB81BeV5kYFRIrRO7CxDv8b/y6nU901nnGsIwrWlLfKJPP6tEeGqYbwcYa36uxdO
         PXlpke4NwdW6AoO7fdXhMYmtfNhUTPcdCofDsP1jn9Voh1lr+HrOAPbaBaEe7NLssD2h
         1LrJ7W2Ue/4dqXjLmjhHVoFkwQz8x+CjioXxOcTDsU0DKqAIx53W+hxA9ktagX0olyNo
         v5eg==
X-Forwarded-Encrypted: i=1; AHgh+Ro02azjMO4SfnFD0ygFDjv3j7Rg41s+qViT/wEWs6DuS0nGqSGSpBu2/mDV5MxY26EMUsV22Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEp8Unwsftmvk38b6lwoecB7LfoclZlfAg7Pwr982c42PTjkVR
	tLx2IKbS9/1rm17pK02i/kWm3eJFUgGr61/B8yF3mEPvBQfdHylpngwdefD40L+3Ug==
X-Gm-Gg: AfdE7ck1sY/TLqUZTzXfQiEeJMVDsV1MckeIsG3yPGbJ9KYJ2d4IyORqqC/xDErTIzk
	UBHxYoA+2KLPj2hUbWTF0v8RD4k8MO/hnfiHJJV7vWzRKByI2Wq6/brk+8KW2U1Bepp2T/Gja/j
	LFSColka8mx7XSYometi74+Bt23XxBlFo+w6B6wFfJZHqE01ADzi48B8feuRSr7iQvf0NSucO2M
	hEvnzExZeQKN5xMLT/vwLh4S2e06Nu5uE3riXQwkNLPmiCHetFEQCy0xy1A+Mzi88VLig+IRYPw
	BTceBFrjKkdBUb3ZY6YXg+54JiVYGO3l49aIBVIFWeZMkOyqXbyk8EnoOcpse4MXm5vl5VWtmms
	bEgV664arYtF8zFRO9I/hO6nnmRJOuxeksSoMWnjov9VlnrKK6ZKdQKqwcSXNDCFy/sjKKfmtLp
	fMSOHdS1Y=
X-Received: by 2002:a05:6a20:c783:b0:3c3:90de:60e9 with SMTP id adf61e73a8af0-3c3adaa078amr12650690637.62.1784499333666;
        Sun, 19 Jul 2026 15:15:33 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cd6e6esm24438644c88.13.2026.07.19.15.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:15:25 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH nf] netfilter: nft_payload: fix mask build for partial field offload
Date: Sun, 19 Jul 2026 22:15:23 +0000
Message-ID: <20260719221523.1336739-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nft_payload_offload_mask() builds the offload match mask for a payload
expression that covers only part of a header field.  For a partial IPv6
address match (field_len = 16, priv_len = 1) that shift is 1 << 120, which
is undefined on the 32-bit int operand.  It also trims only one word, so
the remaining words stay 0xffffffff (and when priv_len is a multiple of 4
the trim is skipped entirely), leaving the mask covering more bytes than
the rule matches.

  UBSAN: shift-out-of-bounds in net/netfilter/nft_payload.c:278:20
  shift exponent 120 is too large for 32-bit type 'int'
  ...

The match is byte-granular and struct nft_data is zero-initialised, so the
correct mask is simply the first priv_len bytes set to 0xff. Set those
bytes directly and drop the word/shift trimming; this removes the undefined
shift and no longer over-masks the trailing bytes.

Fixes: a5d45bc0dc50 ("netfilter: nftables_offload: build mask based from the matching bytes")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/netfilter/nft_payload.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 391539a1ceaa..8a4472fd77d9 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -259,9 +259,7 @@ static int nft_payload_dump(struct sk_buff *skb,
 static bool nft_payload_offload_mask(struct nft_offload_reg *reg,
 				     u32 priv_len, u32 field_len)
 {
-	unsigned int remainder, delta, k;
 	struct nft_data mask = {};
-	__be32 remainder_mask;
 
 	if (priv_len == field_len) {
 		memset(&reg->mask, 0xff, priv_len);
@@ -270,15 +268,7 @@ static bool nft_payload_offload_mask(struct nft_offload_reg *reg,
 		return false;
 	}
 
-	memset(&mask, 0xff, field_len);
-	remainder = priv_len % sizeof(u32);
-	if (remainder) {
-		k = priv_len / sizeof(u32);
-		delta = field_len - priv_len;
-		remainder_mask = htonl(~((1 << (delta * BITS_PER_BYTE)) - 1));
-		mask.data[k] = (__force u32)remainder_mask;
-	}
-
+	memset(&mask, 0xff, priv_len);
 	memcpy(&reg->mask, &mask, field_len);
 
 	return true;
-- 
2.43.0

