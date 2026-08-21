Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D54137B1
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298470; cv=none; b=j3dIceqye6YJ8erFfRSypNo/BrqOQ2oL5L3OCLF+4hLO+sSwdWG8Xk3Yg51MEnBYDl6/Ui3qYqs5Lw3I8c1XZJkN9QPTlXCTCcUambD/sFKZm25Co8cMd4GAQHuPNn2qeIjfTuAJyXlWGP2WRsrDu4e/2jQZyAMgp9pfz1uJWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298470; c=relaxed/simple;
	bh=c63XIPFZg2k8AzPqDLv9Mq4FSp0uF9Bnszc7KOcMrzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RyB0bp30noaHlXXnP7NvXU+dx1zCcHU7eCiZ8qh6E/aFxrvfa9BG5GDuQQt/zl29q2Pl9JVUrjA2UXi0QMy0saFF4WqZAmwkxFsTcqj/4Io5Qo19lnsUXlY/ekIIb1lB0P0cq8GlnP5fqbutj8oQBm6r/XbFx3V2Wjdv9T/hzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1G8ay/N; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1G8ay/N"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb7926836eso534600a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787298467; x=1787903267; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cBaiLIN3vjEgnCQ9MB6pLKAqs8Er5KeaIA+Bk9rviyM=;
        b=B1G8ay/N09MVbXEfkMRVsD5tZcx8OT5IqcQK5Qcd8HpmvSBzsA4OEt9iRfzRyb8Kup
         mZT7hBy04SJThInTMOcMfvmrvE13eBn6zisKBzTehtdXErrISZRwlyYAIiqNCo1ex1Ch
         6TtaJuiyHlgxPQjBqZwoP1Zu7eG86aGCwtAusOuwi4NxazWDN9kC1BvfXoWREq6BBzXH
         h/x3zHAqYxBLGlrxvdQjtV/OYf0oPa7lekePUWDZfNOFEj6ev/aN9COf+7XAiwR061/Y
         ZZN7zQaXPhvNFlO4AoXKumzL5bwxfF0HuBhcpDqrGjrNIaPMJtks47hUA4p+YCM/rkIv
         iiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787298467; x=1787903267;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cBaiLIN3vjEgnCQ9MB6pLKAqs8Er5KeaIA+Bk9rviyM=;
        b=Zwb2146bEp6h8JDr459eidIn4SzUCT5q3kzVUCY6ipRPCllbiRh94nllgQRKUIyPgm
         dQZ9cHb6mJ+RMHgrUgAiozssaIhcigZi7FbZPfsATbU8DHDasoVSj7iENJBdGKxnqprH
         cznnyIXAoPO011OnoYawc7YLICU42M4G2xUrBrZ+yeSHOEAWi47AX6HJRD6Mc/p2vNqo
         fNcrdRt2HaU+FUwPjanbkHg5fuIy390MDVCblH/eSZM5taWHJQDNev1d46zbYF++MlS1
         vkRG0DnfzdmbkiV0HXRkj3WZ/jv8xihrvG7duJ+qnu4hYlZ4JT/JhwYZ+4I6ImxM2bmy
         QkYw==
X-Gm-Message-State: AOJu0Yzum7KUyjxX3G3upADJg/wumZ6ENPDloJzIW17IrtQHPdnR9OgG
	Oqsh/xoCsPWa4RNnuIGl0Tadt7koy0w+fEGAPrLByovgO4EA1Jh+X/01fwL69TTHGsc=
X-Gm-Gg: AR+sD11WhkLy2LIg5JgjC7eZQQw0HMzWTWYi8KK4ebu9pY8/Zm+bYYJrcXLmBCTYijP
	VA+aAxDuz8FxKUATY1P+Rt3nzhLwrXqnm55qbm1sCjvsXcy2agtIfxolU5uZS/biOdsmGRLggIM
	7eLzwZ+0T4s21rWRpfa6SBsuZvHGUtX7QMg1kwlh40yJNTWwE49sjw0NYN6w8SqB6THSCJ3AxAP
	URtExCPijIstUoGQV9Kvawdhfkyk3hPYwPD8PDk7JANpdRASHcFekD2YAyO1ZN6BARNiAGaPM97
	We3epyJhf3OEmeGaDNpcJSYd3Z319Z51hGM4Lnk9wR1X8FEKlkpmr0u7ApI5SB2fCRKnoyGLkjY
	gK15oaGasezpEq1rUsbjRA0zrDGgzqbXWN0ikjJGCA4GAtNO/ds/DtYksJFhIcd+A04Amcw83v7
	Q/b3p3Tt9QSan3HZ+jvp2pchd+bLrihoV/b1sZnHV3p3MMSRmzcm/bGoyf7tnAbt/8zxzzPQ+qM
	15u1fXyAC4oqZvtgrmzLCUvKS/QwME5QVhRiw==
X-Received: by 2002:a05:6a20:7295:b0:3c4:42d9:58e3 with SMTP id adf61e73a8af0-3cd30086966mr8091259637.13.1787298467507;
        Fri, 21 Aug 2026 00:47:47 -0700 (PDT)
Received: from [10.201.216.236] ([114.8.222.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm24180253eec.25.2026.08.21.00.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:47:47 -0700 (PDT)
From: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
Subject: [PATCH 0/2] wifi: nl80211: Document sta-info nested attribute
Date: Fri, 21 Aug 2026 14:47:12 +0700
Message-Id: <20260821-work-v1-0-6a4ca4a92ee6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyND3fL8omzdJMsUI1NzYxPD5ERzJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAGCVCChoAAAA
X-Change-ID: 20260821-work-b9d257341ca7
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787298463; l=980;
 i=hilalrahmatullah11@gmail.com; s=20260821; h=from:subject:message-id;
 bh=c63XIPFZg2k8AzPqDLv9Mq4FSp0uF9Bnszc7KOcMrzs=;
 b=OuMYW5mdr0Legme/sLH8786nwyb6NyetqNro3thVPi5J+Kd49hLqQxxnNZbOEFcjJqZv0Trsu
 JzqS9cN9gzRCj5FXTRcpUlr3rmiij2LkrtB4AvDv+kT3Ynvl9BVq3co
X-Developer-Key: i=hilalrahmatullah11@gmail.com; a=ed25519;
 pk=FhZxP6t1UkIekCkbKSGBN5a03xhQyE9h3bzSUhWYo3w=

There are many undocumented attribute in nl80211 specification
documentation, this patch series aims to document 
NL80211_ATTR_STA_INFO nested attribute from the previous
binary type.

This patch merges/supersedes 2 related patches.
Link: https://lore.kernel.org/netdev/20260820110904.28645-1-hilalrahmatullah11@gmail.com
Link: https://lore.kernel.org/netdev/20260820072141.15779-1-hilalrahmatullah11@gmail.com

Signed-off-by: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
---
Hilal Rahmatullah (2):
      wifi: nl80211: add sta-info nested attribute
      net: ynl: allow u8 sub-type for indexed array

 Documentation/netlink/specs/nl80211.yaml | 368 ++++++++++++++++++++++++++++++-
 tools/net/ynl/pyynl/ynl_gen_c.py         |   2 +-
 2 files changed, 368 insertions(+), 2 deletions(-)
---
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
change-id: 20260821-work-b9d257341ca7

Best regards,
--  
Hilal Rahmatullah <hilalrahmatullah11@gmail.com>

