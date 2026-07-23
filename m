Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0041A90B
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825598; cv=none; b=ER12keTMRWotKT8E6rMomuFHuSQCcgGT3FykVp3Hu7XgeNcNkwVjKRVBSmxJU4TaMy4HHip9Gb63VSypkCFjacZx/LUye7pxO6viAnTma7u0lIJ96maeV6iyOxCcms7UE0XgkckxhljTALSnOqYaRoeCDBgkmw9QgMZyRRaFPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825598; c=relaxed/simple;
	bh=+mDKO1rx0runoo7oNOwRjWDzhZlf5nu84Yus3Ia7IA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig7RqbkDrU6xPFAJOIGhIH3pIJGjQzDABSjvBxWbAUrNWtO6c5MK4xIke4TS9/jUkbpc6jjy/EGHnpVxkHnpq3WMmMAyhyKFTAbtj/tRZkUBACmMl7BK6Zac2+ZkX/xT6ar9iEe1j450L/2aomF/AuKyBqJV6yCXXcrCZqH/4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYxOMGW+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYxOMGW+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc97653887so10977935ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825597; x=1785430397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YeAlIdZbh+V3dTOyvaFAooLwnZ0f3U57iLEtHBzssEU=;
        b=cYxOMGW+GnFc1kGblYERAoonBL2S9rnXPy1i9jCPeHTBMdUW3l/6Abm+NY7tAbRP23
         SzKCaXQ7QhhVmZm7uKITlNAke0Kl22UTqEITi9WrJ9saKfOXt6l4TRY1cCffA1qToZn8
         XV5bm5gwQfazmDghA8e7GS28myd2kmy2Nv9M+I1gsrq2v/j2x4FN93BhJEkkDL1MFsxs
         n8xgrSXgYJUdLWx76J6xZTgxEXQyKnV1Lm1F1XBuqWEg40HCJbBAwpsBMNQFVzn58BVL
         9gFJpNXfuJQ1aYb5bf88mWhlqpmHi4uN+rdRiQzX1fMNzXOy7OimTcIYld5sHghYeIiL
         hwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825597; x=1785430397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YeAlIdZbh+V3dTOyvaFAooLwnZ0f3U57iLEtHBzssEU=;
        b=MwdF9sj4TSVqJGOPVTItSZjiPeyuEQXE5cWZrBcwjj+p1/CkaxJTFF7z6NVvXln6aX
         VJhYGr0YvEJ+/xzRpiFeprkppibgZeGPRkZcmuXDjClCWvGH6Ud7icWbitEjvs2vz8HO
         V2I+GRMOoGBZXTbPYez7XuSmGmxZeYr5VIrcyIu4lVd7z/ASOOzVKwUDsLRa7cidU8QA
         dAsdaAP0bOcDzAJGXEh4Dd3LeqbusTHg6y4MuGz1vGSlfZpyHP05emK0gRXofn/aK/QN
         bxYavD3aFsGjKA2Po0IZ8whet1azSCojq1Q0e1Bz/TLYZILbOoG6f65rHZjtWlDc5/75
         DizQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpcns3yruaG5KFzPfr8OSqK7ey5KrJVIssPyYoN61EyDCeLrIB/KFG6W6IFCK/9NsnS2IAvfsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozfRUnOErmDstoLsqV4qdEJevNJoSbZ+65a4KSPZCFiLj48yk
	v4cCQ+XmllLkGx40cr81ofWTgp0Ppo3/ct2PVyiGimUsZ2HYIMvr8/kr
X-Gm-Gg: AR+sD130/rE2nR9LjKQGMCUr6TDC2G0WLR0lGzx40TE64HwC7siWbT7r6YhODpKb4P1
	1Wb2yrI4zizLq7aNDFuOx1M2TqXJatz/Y/RRv4vXcVl5141gnmhR0Xu0bVMWJW4YDoRtXR4n0Av
	D6x/zFCOeVwL55ByS65AKGSOr5nys0Y5b/AbkWdRBdzQyDG2XO9BRWPqtofA0ahNcdx0vsdi9FK
	11I7I79kui9DlzEUD8l5HgJ70J/yolU9dAiog0zfMrnXtusxzWtkTluIW+j//TzXUhEF42Vlghd
	FYtACyFk9+3wz9DMdNNIseW2eQWlbt+n1x5c3me5bzAhLzahJZQG260lEIQ8GDOzR9ZsfnSxkCC
	VP5InlhmRuYlW2MqWwT+pQ3ZCSSTngRQl7xVeRekC59gKKMIQQAS//xUvJKc2Ma1yB6kk/0UXOm
	XgpJdhCivOA9Fa7iQRTe0=
X-Received: by 2002:a17:902:da85:b0:2cf:b066:7de2 with SMTP id d9443c01a7336-2cfb0667f61mr24881135ad.22.1784825596527;
        Thu, 23 Jul 2026 09:53:16 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5e9bsm36926435ad.50.2026.07.23.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:53:16 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	linus.luessing@c0d3.blue,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: bridge: stop fast-leave after deleting a port group
Date: Fri, 24 Jul 2026 00:52:48 +0800
Message-ID: <1cf0898872ef7c72d5f4c0304414a192c6dac591.1784707712.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784707712.git.zhilinz@nebusec.ai>
References: <cover.1784707712.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

br_multicast_leave_group() iterates mp->ports with pp = &p->next in
its fast-leave path. After br_multicast_del_pg() removes p,
continuing the loop advances pp through the deleted entry.

If multicast-to-unicast was enabled, the bridge can hold multiple port
groups for the same port and group with different source MAC
addresses. Once multicast-to-unicast is disabled,
br_port_group_equal() matches those entries by port only. A fast leave
can then delete one entry and continue from its stale next pointer,
leaving mp->ports pointing at a deleted port group.

Fast leave only needs to remove one matching port group. Break after
br_multicast_del_pg() so the loop stops before dereferencing the
removed entry.

Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/bridge/br_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6b3ac473fd22..00aa9b2879d6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3687,6 +3687,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 
 			p->flags |= MDB_PG_FLAGS_FAST_LEAVE;
 			br_multicast_del_pg(mp, p, pp);
+			break;
 		}
 		goto out;
 	}
-- 
2.43.0

