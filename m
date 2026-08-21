Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E24137B1
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298478; cv=none; b=rawgDSg1VRoNbq4xkOiVb44Lcpch86C5XeeGyPtAWjuWzXF5KYQvAk/1o9DyheFNo6azI8k5ZyCuArXCqAM+uXWLjfrQQCCamf17W3PJNuOzcX4iVUb4FGqLdbUSM31zmQp/6/+Ww8uFqYjrl5E5+J+TSnEMza4m5d/6tdi/ckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298478; c=relaxed/simple;
	bh=i7Fuu63OZvUypZXMWVQQ3YYZDN7N9ceZyntd/s0yc04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AiNm+q0cgiRq8C4NkxMbIcHHkBL6u0flkY28W8Tnxlqr2pMvpx7q/YmHyR+Y49BavCCxpbx0muCts6wRXhe3btxq09xgRCA3IBsiIVqifoTNayVtDkQG+bFk1Jz7Agc9TwJ5Ts+HLNjH5SCKfBxXSHVPyZKAVEBerhlJVv1BrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXwOET57; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXwOET57"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso476418a91.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787298476; x=1787903276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBhaRc7nh866GMJkPSKS3GAujyNw76XspzJhqNmhp7I=;
        b=YXwOET57VG1GkYeCmWw33yO1qRHdyAiyFYFO91TQhqgPFLz344quoM0M3kWXWt7Bbh
         4/P/l61LfVGdUL890SAgH9m7rM+r88G3l/d37HZeCB3TL3hO+jbawgWFlP4aPnzWpoFG
         x6Gd5ixNIx77KctL3jHTskt3CyqV9ndE6VF1nZG5g93TLb+xvKH8+QIFeKy5CpjM9gDn
         1Vp3yllGdJ/FS+IGUqxV2tM9jv4+Rjh0XZs+OR4j6UQim2nO+mS/CpnClLJG3TEeaouY
         54LFXKDlQOo/CxsjhFx3Imctb3k58B12uxHPffkzGYq7z7/GXZAvGOGBV22QNArT5HWh
         w02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787298476; x=1787903276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBhaRc7nh866GMJkPSKS3GAujyNw76XspzJhqNmhp7I=;
        b=tGJ59GirflPfubHFvrs3kepOUxnTSo/+Wp67lbE+HDAJNzYs7PydySCUjHI8aeTuiG
         bVt3HMWIId42gNSHFgNvqSyo0p/h32NF1a8rIUkIz0YDyqBrr62IwHiOCGCU6lYU+f0Z
         uUGVOGz6qnJ7dKgdNHYAt1inVJpJ412Bm0SNtERVs7K48XvujQDULt0yiD/WfN2Q2g1q
         MDpebMu3axPnkJWbtWBNWH9wcvSWNpUXCm8GBY4zewDEGm2dNk8V6g9o1RjEpZ+iFA/p
         yS4GeBssoapznPjtHbCIHQMv3sQ+WQwx5hk/1sfvnb0OZXQPnifS3I2tp6phC1uVIWGp
         GI0Q==
X-Gm-Message-State: AFuF++kxwVjz234+sxeJQrG80p3kcI+iBbZOD7RFmVshMpOdTlOOvczi
	37wUneK0T84et25CjQQhHHKJQNXGGUPzOdwvgXtxVpPX+F175546Cnu2
X-Gm-Gg: AR+sD13YpW4fLCP5wX04BGf5h/bzk/QQUzWjlo2w6kHNqEY+AXYhMaozveHTdRac5m9
	oe+zUXFsa+jAfta5fNplKSgFfotLgCkK6oA1Js+bWi0vwsD0rOnh4LCJPgLbUg6YvWaVEKo/0Z8
	7LQ/HQW1+TRrNDv2rUtttx4tXAFc3ROPOPseAyQsy4ksLKPMSjH0EBeYbc0IqzZ45MC7EzTZ3hr
	lE1FIFFVESY338xNN4qQZXmNLFybxH+0eUGXzKoOU0sXQLMa0qjj1ySLFVXq0wkyoC9TulVPr85
	ktoCO37rH8rcq+2z7tPifmyf2s1MXg7637pdK+e83rLaoH4dJRbVfj4hg3+8n04Xa3dX+hQA+bE
	HrdB5ta31Jzw+FtHC9+xDcB350gnhiku1/p0oLWgEn+ZF54VpzzNdqeCAKJE5HLKoU/nZfFZLId
	y7+9JpqodQKdzZ8nxh/w4xs2bVp7P4lS56jWfmr07pwvehBAISY2tcjiLSKZT0EV6n6m+mLLyQV
	cirs6im1pjW0AivIZqAkC74wTcu6MHYK3Q4rgIaLOC+GeKz
X-Received: by 2002:a17:90b:580f:b0:380:f389:447b with SMTP id 98e67ed59e1d1-395c386d163mr8756770a91.11.1787298476281;
        Fri, 21 Aug 2026 00:47:56 -0700 (PDT)
Received: from [10.201.216.236] ([114.8.222.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm24180253eec.25.2026.08.21.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:47:55 -0700 (PDT)
From: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
Date: Fri, 21 Aug 2026 14:47:14 +0700
Subject: [PATCH 2/2] net: ynl: allow u8 sub-type for indexed array
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-work-v1-2-6a4ca4a92ee6@gmail.com>
References: <20260821-work-v1-0-6a4ca4a92ee6@gmail.com>
In-Reply-To: <20260821-work-v1-0-6a4ca4a92ee6@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787298463; l=1031;
 i=hilalrahmatullah11@gmail.com; s=20260821; h=from:subject:message-id;
 bh=i7Fuu63OZvUypZXMWVQQ3YYZDN7N9ceZyntd/s0yc04=;
 b=3S6QSEI1wo6JxH7z1JPTdV4kvJPCPrbdscMQweuq0hJexG++t1Br+X2jAJbBipiLo+p4Sna9O
 yoIWrne4vm0AkkshDt7Y1vPD+B0VQ8kzkyI10aSZJKZG/MVmxZqvH+X
X-Developer-Key: i=hilalrahmatullah11@gmail.com; a=ed25519;
 pk=FhZxP6t1UkIekCkbKSGBN5a03xhQyE9h3bzSUhWYo3w=

add u8 to the supported sub-type for indexed array,
it is needed for NL80211_STA_INFO_CHAIN_SIGNAL serialization.

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

