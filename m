Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FC384CFA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499017; cv=none; b=UBOyJKDjoXPD5H5aphGvu6j2eZu2psLF2hHQJfAoedPACsWALB+8EObFBA5tTWu4/U3oy9LSW8I/lkrlGIFKJarx0QbfG4brTMUHDhntnPXYBK5QYS0LC6anbdn8jyHugM83cl7bEybTvuGcObudjCLcnoM76WC+E/gzWdIfKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499017; c=relaxed/simple;
	bh=G0FN6kA6Tea78nrlCADVDkW9gVxo/7otmN92WP8pM/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khQ9WyVmHCnz65upoOEpnB+DcI1Q9oKKswl+LBSxePYrqg1vUF3TViNZnvGUdn+wdNlUfiHQKqrdaIADbxfeXKEMdnHsnrJWEPiveNJgp6iiScgepXG8Ufa1/gIASDoIWBo9u8rBPXYd/3DFibXBZ4MUAbH2qjRSDvbQIsTZM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LqmmiaGD; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LqmmiaGD"
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so10829553a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780499013; x=1781103813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBCQDeRY4EmCQ0kla5Ex2x+xLWc/2PXpf9maOMSgAy4=;
        b=LqmmiaGDN8zoIeJzuiY/yBnIdYD9FNvalyrGM+VOMwdwUdv6s3NyD3ARj3pwGS6RoP
         kaXzmzXSkyzcTBGg5caEvV1uqGrqjNWLykuEKD5C+45d4eEI+tg3GMR+0+7KluEqwpHl
         j2WculLdfZE9knnu+xyeWJwPc8Lb9ibiFryJQ0eltNTJpQ+yyohjIfteFYrMMGXbZTtw
         3qfgkNQf6Sx3XpeDkaBTRNrvwnBzLRCQ5rStBesHiA7SMCZi74hSngTlVsSYDyV9e0rI
         3+ujqH5oUlJ/FjPLkML4Pkuy/C73edz6o19oV+54RKyQI9mUp/V2ZcnDajJtQERay1BN
         y8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499013; x=1781103813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBCQDeRY4EmCQ0kla5Ex2x+xLWc/2PXpf9maOMSgAy4=;
        b=CsqVQ+SnwHERJ+VRD7KzxRRmMOi0hYBBPfIGa2zYJgRwasUjUnK7IYlL8qFfLxqxNx
         J4Jas7WMrRSMAnZfNd1AURYww3kwutfZy9s2yb9R+xGGxSpU0FAcjios7kHMbT4UWHys
         Mq37w0roCyeKSSB6dL3bhaVFgb5aqrQD/BD49cVtY+TxC3b71gQe2BWED6+Ob0X6cuMO
         6bWDrRses2TW9ddEVsxymTBSg9pOJKaXkiInnEIcJnc+0QUuWjUpkJU0WCxqvzL1x5yI
         bWfzAbKMi+r6yi8bLbPOLW3lSszZR34Q2n1nIRL9rNB7DQLZVg6xi8R0trkY1jPzL7r9
         jp9Q==
X-Gm-Message-State: AOJu0Yz2kR52Q0YnLl1dY894cbEg7jAzmyC3wQsn1QFCy8S8ceTx0hlN
	eAbSE9WSStPk+GMkU3CbAqVyqP9TuLYIsjKoE73WRq3maJYM//iBKHkCaycvve58qf1oVtglIai
	5ExevjCEIOPVpgFMGzHFQiUtZkMpULXczxkna
X-Gm-Gg: Acq92OFUoYDDF+ZvEGuLuJI6ItZ3yGptt1uxurrVrqNPf8y58/BO4uvdpxREiwmlHYP
	H1yFJ6Nq2Gl4cAWyKArzDSjKj33FO3kjApXQiLY/SYzJd5q7nXlG5KLmx7EnsQ16V0TFD/72mne
	cWBVl8tiv2b3lND7qxjz72mDpwHP1Vq+v8SkRxjjoZfhbX9ld1n9sv929X5QBMH2OqDMvSugWVS
	ORUBdti8Zru7sd4F0D+Aow50Pyy1lrYh3S7+iXaEIzv6xd/hkRH+vCzZq7Q9w4+3KWi5bIhKxy6
	xcL6baiVFluH8Ac2xCfuJ1qg9D0B8nTgCnJn6GtEFaxA3k4U43I22SWg7dJVXYCtZhFxb/+jKE/
	z5koLVCd0VKRJXzJIwrn9MgCpjURKYo3EmyODC7VvnrlzAIayRwWYnTUmju4CbF4=
X-Received: by 2002:a05:6402:3481:b0:689:5dd6:23d8 with SMTP id 4fb4d7f45d1cf-68e70507e29mr2075597a12.10.1780499013154;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 4fb4d7f45d1cf-68e6451fb1asm120700a12.1.2026.06.03.08.03.33;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id EFF3014711;
	Wed,  3 Jun 2026 17:03:32 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	horms@kernel.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v8 2/6] netlink: specs: rt-link: missed broadcast-neigh
Date: Wed,  3 Jun 2026 17:03:27 +0200
Message-Id: <20260603150331.1919611-3-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260603150331.1919611-1-louis.scalbert@6wind.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missed broadcast-neigh.

Fixes: 3d98ee52659c ("net: bonding: add broadcast_neighbor netlink option")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 Documentation/netlink/specs/rt-link.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index f23aa5f229c5..484e0a97b653 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1351,6 +1351,9 @@ attribute-sets:
       -
         name: coupled-control
         type: u8
+      -
+        name: broadcast-neigh
+        type: u8
   -
     name: bond-ad-info-attrs
     name-prefix: ifla-bond-ad-info-
-- 
2.39.2

