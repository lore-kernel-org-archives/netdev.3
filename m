Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BD231830
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773606847; cv=none; b=ORNqxrSvsNytU8eum4Bc5jmODD2iA9L55fdwkSXv/WRFCPqZoyMnlL9pfOHf0PU2ln9aBLAZtLOUUEMcmOdnmhIeEWTvUb/PZ4AQB4ujsmxJvzPfhbj1WaEdDzfqWiYm9J2CnnNAQo8xm3thA93T4q0vJHuoiAk02ZtC//7G2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773606847; c=relaxed/simple;
	bh=x4XBVU9NFJfJ98e7T4O3wN4hyNxkuoou/kNYOhtbu9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qACaXeENVy1CFP5IMU9Ttajj4UknhnTYZNZwf4u6g6wiLWkDXIruNyk6H8K9MsJYhNvPM7AWZjf9ZkQSnpKb0BPkI9xtC6Ln0lpusATkinv8Bz9uPKAukaPVB9ImNX/9ylswo23S/X7+W+NFw2mPbA1v5/5g/igW11WGZ89wegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFHZez9X; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFHZez9X"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dea72099eso3914540e87.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773606844; x=1774211644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fas1ofkBzdL1TrT2Z69laHicj7pCtwPGHSuUlDLcpxc=;
        b=IFHZez9XNjVM6pDP43GypOwbOHsU9Dc1M2quI4TgMnSKjaYXoIapnD3VQ1h2diafge
         /ZkSd78WOOD3NgGfJd1FM50fX7CsVWjbJGC4H27aDtQb/nBTsCdtzNMpIt2tXyWqxuVl
         Ph/QtLrbrhVvy7Ag6QOTnOJVzaNOino+jZk+0mZ4p6QVMxePwiZrV6eT3KE7jlaX57kT
         7GqU8XMRuqHXKi5+2Z48F4LI5BxaFtSVM5JqcBUyVe/+H69xjuHpJIy5OrK9CtqdOMRO
         BUYsD1YyyYRlu9DioOMUiCwX87XrhsEWhwAs0Qp+xZoqNCXH++DNyF9kWfYTvGIR/b+U
         MnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773606844; x=1774211644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fas1ofkBzdL1TrT2Z69laHicj7pCtwPGHSuUlDLcpxc=;
        b=dF2ASvM0XyjEb1xF0LPIYvq/HncqmEmkcPd0XlojIcD9Fdm5LVDbD5MaQ1R0iDh68E
         fuYP9wzC4nW3f705ZbOmpjOnyat5KN2mDnwnRBJDA2KXc1oxsa9M39IcFTxiNhHGBYte
         RlRu7O6bcvITOeAZDivjGMpPp1myMwbEzcWhUQ2OR+CKGCu6zg5jKobej2EKIjR/WzeK
         H8Yjc8wuJdyfaVUdm4+qp/H+mALZ+awVAVB+B+GkyhSa6IIvILKfVIekWNle5c+1ppPd
         nG6A3RQaHCK/zK5aCTTfNm00piscSXWx3NuaYJsk6S5V2CrAWJeBsHAWOrrvfkZbGhMz
         h9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWX7pW3C+lI5YDfLzSeF9SKK3meq4sX9zFeIgIRNpzwNdghDG6ZgcTTCbixvegAcsEze4UER3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxKHo6sSL+OHWczvtOa/3HPVS3tA05vVxYfulOc4cgbM+GiTJ
	tImRUzmkiVdiNooTcEgKIdnzfQxMcjCyblsG0zvsYI7OtXSpw7xKzZaZ
X-Gm-Gg: ATEYQzzyfF0N8ES3i4ex4E+YOUrUbPB07SJTAiZP4izOuOfkO3OLRgIs1uI6cyoDAm2
	L72+uShHZIkUrhj3NSe+AzA5FmbGL7TBA+dEd9eOsNnMDlc/hhEAlyu9v9z0OTjab2KEhSeHIPC
	NwEjmj6JtRwAXroaHPau1Qk+y/k8Ss63G3Ok4O0Z5tKXSUPlPmQwBj9JN40SWE92N0+uf0sOZF7
	CMundnJgPJu/OmQAJzi2AIDt09he1CA9mktJvlhgH+2qrUIQDZ2ZVBNOGsLpfYeVnqdjZA8noT4
	iZh6QWVGauIxZgzWDZoUwvqb23nD5zjPr5QFzyrGDjDZVgKFlPsSlas1Tcoy6xjCzK3nTJwlWvy
	9+DszMO9/yZcVRdEF9aBujdum9bcdMaxL5MKkLjtyk5MoYpEvTMtOQ79HmSjC3G3P5Mm4v+HzEg
	NfWheX0RlWBS/3QHkCD2AY7fJLOUzZZq/ECg07MRxIBI/UsfEZr+m4RtFM1m9jcov8+DX+VtW1r
	g==
X-Received: by 2002:a05:6512:154b:10b0:5a1:2f9e:ec8f with SMTP id 2adb3069b0e04-5a1627039ecmr2505232e87.10.1773606843664;
        Sun, 15 Mar 2026 13:34:03 -0700 (PDT)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e18fsm2916297e87.22.2026.03.15.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:34:03 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com,
	allenbh@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH] net: ntb_netdev: add SPDX-License-Identifier tag
Date: Sun, 15 Mar 2026 21:33:45 +0100
Message-ID: <20260315203345.13657-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing SPDX-License-Identifier tag to reflect the dual
GPL-2.0-only/BSD-3-Clause license of this file.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/ntb_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..3890074b26c9 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 /*
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  *   redistributing this file, you may do so under either license.
-- 
2.43.0

