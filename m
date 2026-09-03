Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC894BA9E1
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445930; cv=none; b=GlXDM2XIyjg5rHdmv1l2POVc6sCpuQf7ZL1zoym6UxK8IDQBc9nHEeOR1AmILC2IMuS45UQh4G/h4HhwQFtEoNByroJpkqVUhRi9iGqFRhnBmR0tsBl94szhXsatMCL6G3BduUuYophdKs3cnH/6aGS6BoUjDZnzm5esT845uuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445930; c=relaxed/simple;
	bh=0MxeVaPX+VtYHYLIfWJuakpriIgNaFhZQH5yt5XofQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/E3cUgyIqXjA+HUxQbEFrUxRweochIgj6wuqptwC/eLxjaW7HhaLQkL3Ae7HNlkz8UMibuknidruM3uGc2zxYWo5sAHrTlY2Q85IDD/9cosoaMrlkVK1sN6YVb7BlXI9QPZ3felEz67EdtC+J7wXI8pQTgdJrtiiNkxaIwuf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=b/BQssZm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="b/BQssZm"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so4127172a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445919; x=1789050719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=b/BQssZmhX8g1PaRMUGhQ9pPEB+ry1qPwb78gDb2Vs3VegXpKqpfYatVOTK7Hfghsw
         dmPN9Y2p2FDsQvb5+T/ElH+B505ajHJqGLJgpYplZaIM9EhFKQXEk/ca8ZiXXwn0XQSl
         02hsp8yXEcr/jXEPc24g+S1o67vu8aHodw8mhlOChfJ/53wHpCpuPU122kLturCG1twy
         +X9qY0dAwEQkPk69zOgQXle3ef0wHBZiaM/YnOQCvj0eT7sgRWUaKXPyB/zCV/Lmvy9D
         nCokVAGpxmU+oyYTmQEw/q+tHokIGESEWIj2GZk+ZlMZG0VkJOF2GebblCo+u4Czm4Va
         lA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445919; x=1789050719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=ntoZjcsQV4J7rlop61KQHjKRBhB0SvrWvbPr3E9A0VoMMSb3iypMpPaJrEacfMDzB1
         t5XPK3YAk4lcUfoGREr6+iAOl2zqDr3dMlFQSNhShvqaogRlYGLaYGjMrLH2aO8L1GBb
         +5itedJQy0pBQkpIgO+Mkyc5/8ZDgkpZdQppjvRH0aor8KzEJfP6xVvtxUqONUQ13Jyh
         zcQo5pyTy7UQcRlsNlY4g9/hNmlb9rNA8HHFJ/Ccj2gCuZkhh2/kHqsZb73desnKXq5D
         cyLM1iXOOC6TxLDS5hDqxUgSjIfbDNOJbWVpAw2cFM+ex+aIKITr+gPj449ZuToEhCXN
         Mw7g==
X-Gm-Message-State: AFuF++mZ5JnpS9jyfnD3ZV724CZsW4f7/zCG7hcP1B4W9I/LuBoCJ3o7
	i6Qv+fWvCJ64CSj+Ax49haBlFRSX/k9wGUUEFHBYI9PjcHHnQpUDnchChQgDJheySLp3g+Q/A29
	tpMGT9FI=
X-Gm-Gg: AYBFou0QbR666tjrr/Upbew+xHwZSSyDPk9aaUxOYxUL3bBJU3r3NyEclbOgZ9KL8j8
	gJN26IOyDArh5N1kjMaxwPS134jG8rhrC6hj5/sAemIbRWlTZ/i8oxcKddP/VFSA3qxRiAw480a
	kwP2SKgDyBg+xFlaSqWZLuBETT7eXvDODB3yH89optaQuz8XXyMxRzP5Pu4y3g+GCzQdRLcm7Po
	HBqonkx/5i8QKVdh13hLETMZw9YgdiNJUyfP9w3cV3gnWNrsg3wPsxkepQPazjxuFw1XFySK45w
	2ST0K2MUlTSIkDeD0FkouXE4QbLW8x3hwu/fsj1OE4ZM2twDWKJkfR/Khm96r0GEiJltK61Y5au
	7x/+uViDCvJDK0kPnH43A9TizIzFc2lrM73KsLvbS5+0VPKtHlzSu9KtGEA+HKdfd1KBpbdZHMm
	L1gvgm7y2JYQPJZWM5vOnpx/au9cTHyUv8kyofdR46EdqCXd1O0LqBDKxHxIHPs5d+V0Or
X-Received: by 2002:a05:6402:440b:b0:6a5:d8eb:da01 with SMTP id 4fb4d7f45d1cf-6a6818d29e7mr10408738a12.0.1788445918887;
        Thu, 03 Sep 2026 07:31:58 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48448eea468sm15013634f8f.26.2026.09.03.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:58 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v2 1/9] net: bridge: vlan: drop legacy memory barriers
Date: Thu,  3 Sep 2026 17:31:30 +0300
Message-ID: <20260903143138.1574598-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These memory barriers are legacy code from the old vlan implementation
that is not needed anymore. They're also affecting the fast-path.
The pvid is changed under lock and is read with rcu only in the fast-path
there is no need for a barrier, nothing to commit prior to changing it nor
invalidate prior to reading.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 1 -
 net/bridge/br_vlan.c    | 2 --
 2 files changed, 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d337b1cfb980..5b2c22ad669e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1687,7 +1687,6 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
 	if (!vg)
 		return 0;
 
-	smp_rmb();
 	return vg->pvid;
 }
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1e0e436629ec..2ae6ffb23399 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -40,7 +40,6 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 	if (vg->pvid == v->vid)
 		return;
 
-	smp_wmb();
 	br_vlan_set_pvid_state(vg, v->state);
 	vg->pvid = v->vid;
 }
@@ -50,7 +49,6 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 	if (vg->pvid != vid)
 		return;
 
-	smp_wmb();
 	vg->pvid = 0;
 }
 
-- 
2.47.3

