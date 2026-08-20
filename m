Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF51418A29
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224159; cv=none; b=NhoZFR0s8VXCy2gIwbrmdKzbdOKd+fqzDyg8LBneWwhRgeHVH8oTdAMFw7j8AaZTguFc59pujOh0htNdfVdekJ3sXQ69IxeHWn0oYAxkY2b68RYhKc6cfy39mQmH4krBa2mczTrTrpMAZSekD27dwY+9ed3D0LFx/mXjbGW0/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224159; c=relaxed/simple;
	bh=LA8yqowpZUsUfQt4k2g0I03QZsjL4Og2srOQeXB8F1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2zQx4fhUErNCK7HsmCsFZVsbLu/2oE5KHp7mEOHJfg+1QhcrEeeUWjiZzd3TyI4xPmWKyyzdy4FxWi4ZhM65Jo3T8gOS/md1S5lz3pZShZcyu89vKPzx58lHxlAITefVVr3DcUZY/+NuO+Ty/ihm5FNqqDwyb0oEZt/PIugfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh1KyX3l; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh1KyX3l"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1632649a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224157; x=1787828957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ul2+j+jl1K054KiY/EamngKwvfvsSBpfO+/j5tdgxnU=;
        b=gh1KyX3lDOThkDaMWyTcD0UPbL89D/4yJt0DrzNHZnNCvJcFYfq41YWlWYr26XP5ND
         17qhEGysx3qUhPh2/G9QOjrIJ/aDM44qVfEBZx5QDhtZC4536oFQRYQjf+hwDMIzpubs
         7d9CLM1+voQEIHnhm+dhyX7s8A0ubgeHKoGDrdvNqDdMosHpVzHSri4thW1bnelDJ23d
         RNM11QegiqPdFCwlRkYBafzC5fFVjuEXFh1u6R+AV2G0mmwXOC9gs7SpbJROgqocowxr
         +QCwF1wzOSmLao705MHizcf9FVLLTkh/xt8Krn76GWJ+qJyS3hiQWP6JRDz/2Lhev1GF
         NRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224157; x=1787828957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ul2+j+jl1K054KiY/EamngKwvfvsSBpfO+/j5tdgxnU=;
        b=sZXR6fNSUvdLty/0rANi4g2ALe00K6fDqcbAfVlNXc+odtNniBQEJl7PYN+ag73wOA
         wnGMyZW9I8x+vhSB8o6lqs/6hPb+KevNcWdwT6Vm+rqFnQITLCP9c9bgMXI/JHnRTDc2
         lQ5w8QQB1RC26gPQMzcgndBbzotBUYQZmCcDrsm1MU1RyKkZGwujc95epNa556GIEF4D
         Y+tRE7JWdHuwDYp1/h57GQQsbvEAigPB8fnxMzGn9940U07xJr1C0WBZyHZ30UFPUHm3
         yaUkcWH/sKVwG14jh/KwNEKiif05lHGkMcahA7EnaTcVeVPSANju/GBYJ3p5YZ5nrW/L
         WwBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPPvjVAf/hddqapNpEo9AR32nXQDRCW0Zb4N1W1u2AC3wXHss6c38tB10eO6gS3iD5o9JQBWg=@vger.kernel.org
X-Gm-Message-State: AFuF++mbmfKOJynntyAmWTjU/heAfczsxjegOsXUZWIT3PzzVMSLmU4U
	ayZTxt79GfcnIeFNQsdQETD+9/8T7WEQE3SI9BWRnNFrzNI5WhU7+qJF
X-Gm-Gg: AR+sD12gUJQM3QJcbVHAhxDGJfEcmD3Wntbp1aDiyeXf+KUw0HnL1UZmWaUopOzXoU+
	eH0flTsbtPrQubr435W5jR8e1GD82jTM2x2VkQd97qqsK0prlKhqlJhHk0rcv5jKJ4rzrH3HRGh
	6ZrYgnf4MN8fKqC2t+gp2wezzQUTOrOJeuHLaY8941ziivi20oUpvd+kRQU4lRlghj7ds66Lhkg
	zRj+Eaa3+phiWckGwA5bS5XBOqy6iBSSbuunKIuUOnmctfXtAqEHQNuEXk+I5k7N9KOkhDtOCYL
	MHcIimRDdX9AtukE2/d41cbRu+j/TRaGq2pNlMBkzOaFe1G3tS+i+JJTAvTJG0U2p0G9STLkSba
	Ttljfij6qX/tHdKS5kR6KSupwhNpQ0/1xnkIi8/XLxtdXjugQ1pTKiT6CHMCoXURRz30k3L7BAr
	GNAlNX1OQTyRuRNbGBIfZTV6KXjQSbVUaJrNilLBeEUt/53cpGHIoGt6IKIgS9eP9ntycPHgmkw
	zMCbKcDJZ9ixefOv/Jtc4o=
X-Received: by 2002:a17:90b:4e8f:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39580a80a58mr21564387a91.1.1787224156756;
        Thu, 20 Aug 2026 04:09:16 -0700 (PDT)
Received: from Ellen ([114.8.219.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395ada701adsm631251a91.2.2026.08.20.04.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:09:15 -0700 (PDT)
From: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
Subject: [PATCH net] net: ynl: allow u8 sub-type for indexed array
Date: Thu, 20 Aug 2026 18:09:03 +0700
Message-ID: <20260820110904.28645-1-hilalrahmatullah11@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add u8 as supported subtype for indexed array, this is required
for attribute NL80211_STA_INFO_CHAIN_SIGNAL serialization.

Signed-off-by: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index cdc3646f2642..7373a48d5516 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1158,7 +1158,7 @@ class AttrSet(SpecAttrSet):
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
-            if elem["sub-type"] in ['binary', 'nest', 'u32']:
+            if elem["sub-type"] in ['binary', 'nest', 'u32', 'u8']:
                 t = TypeIndexedArray(self.family, self, elem, value)
             else:
                 raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
-- 
2.53.0

