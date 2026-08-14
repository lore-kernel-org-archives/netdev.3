Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED63537FB
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717027; cv=none; b=IYdSY5SGDGjZSDGxGMyE5VhRA77bQ8N4n/oZREi651iptXNBbdC7BdaQ/+yJMBG7G9O7b3ICdn3yzgWApqAS9GX52Rz2DGPwfIhuR45/9Hvi+LCXvh/tWTzjrRD7OluA8V3i3nOWW5KVxMA0mnXriWhu0bHy3iyDH6kd8kzmJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717027; c=relaxed/simple;
	bh=+1pofQkSiSZNjqrELg6oiqQLO30fdl24DyzOPTIA+do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3Bnd+pARLKqaYkI3tn8LJgXVyKXZPtCXuxzrNf6iUikm5AdjRZitRBeoP+G+4Y9m6JQBp4xVpH2zRHW6hH2icPFVgKJyu/4G+nrvb/AvyQI0pFLne3S2Y3Ht+ZmUMDjH0EQ7Y4sk+gtT5jbZsvu6B35v9+9hbwlk5R7NYptFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ngUxSkXh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ngUxSkXh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so1979965e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786717014; x=1787321814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JW1WdEQv/IZL7koXdWZmPocV2txIARzi4HLvEvaMHqU=;
        b=ngUxSkXhrIDGFp7vs5+LnAs0pXwpb4qqKdPHdt0jNUvldlZVdwC8llp4HafI8p83OU
         1mUWC/vnd1+1k5hOozR6uJLutqVj23r25l6CoK66Jvl466ID+yPr6WlF/YFPL3k6xLKd
         aa4poN/OED9Lfy8/2aDPP80aDVl9Zx1wqX2Kkfo3KX7/LXsql788kYdWrxyFJlvyM/by
         Ets+WaRackghNFxAfJrTGlxq2WdwrmjYW9scPG0tnyToEldkWBUCvO4g504H+GdH6vpp
         2FV3itjHkQXzPIiiyPm9eQwRk6R40h0ZghAhoiXAxvKUcIvKN+tQfPfYor4HTHg/3TIh
         BTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717014; x=1787321814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JW1WdEQv/IZL7koXdWZmPocV2txIARzi4HLvEvaMHqU=;
        b=hYWxMinZcNOSxX0MJHt5fHb/YM3MEGEvGucVFmiLXVj+RzNojSrqhvzCI84GUTYO51
         52ifuA6I8BKW3CRuQM5P6FNnKZQExJiCblEeXhD9T0FdcZbl46J+RXPoo68Kd+cWxG2z
         8d6MIU+RRBQ1gFMAXZm8/VV5GrkS/QjG5dlg5h0E6uFgtwNM2ZixQeRwHi2q6bHB9SF5
         7ziMDXRpoonV4t44lEAonXtcshVKk4V7Pmz3kxwld59XESuiTPLoXIY5TJrleKaS+E43
         BnHdBDVAHpjV6crJ4gyZ2X5vR2fqQZY+b//JmWhrtKXGF0WF2CUNZw2E7bIrVdd7C3ZC
         CLug==
X-Gm-Message-State: AOJu0YyRElPWfbSsLrF/su/DtEYQfsO8uSIfKfuj5cQpfbSY6Cbmg+2Z
	qkP3Brkfz4t7XB9fDn26EUjwg0MAjdB5iFjL8exyFTYkG+Z/mUduCxVxy+tQ0Iz/6bZuzvlRpS7
	po/ZSha8=
X-Gm-Gg: AR+sD13TaEBd8b0vgCaBVIdLpKu/w/gPfTFtBUoTVG3QLVnvauZlizyEFkno/dlRm5V
	I+gZpYLhHoKf5mHCkJq77nyPGOuPiD/OfAgesNuHy0uOMg3arb964D/ovAlo3hTR/MIABrr+lj1
	BuGYJOgKzVE0H3ehEzULeVkV7usoZTR2yWGvcXs0nkcxzPTW+9RUyjqxQyImEJllRXgRGO/3LAM
	qVRPULwXNaRnUFNLtX9zY2V+neUtqZfAdfctIHhM+u7zHl+M1yESzyiLe1hw00SzMmn+oUiexaV
	4Aihg5t9BxwSv0nPCXvJ3Jo3ocGKWhabQnGrLQC6N4+xwOjVcFSU6isvTIHJ2j9KaXEV1EzwbfG
	2FAzq3Pag1Gs1CvO3RNr72GnV0VNXXaqcDLRb0lG23XtVhY8sFywxK6pC7SlouQpcXgxc30yUsg
	ErWJz+YvDdkA6WiqiaY3NBLZsnn5r7wu0PtOV38C7LpOjQ1MTP/sBrl2lvOC7enTOTXdMdf1Nyn
	hdIVnQNXmxYQFmbBvPmpg==
X-Received: by 2002:a05:600c:5392:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-4998795d6bemr97219905e9.11.1786717013727;
        Fri, 14 Aug 2026 07:16:53 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499899753ccsm36764805e9.0.2026.08.14.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:16:53 -0700 (PDT)
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
Subject: [PATCH net] net: bridge: vlan: fix inverted default vlan notification
Date: Fri, 14 Aug 2026 17:16:40 +0300
Message-ID: <20260814141640.64958-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A notification should be emitted only when the vlan delete was successful
and not otherwise. The proper check is if br/nbp_vlan_delete returned 0.

Fixes: f545923b4a6b ("net: bridge: vlan: notify on vlan add/delete/change flags")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Found this issue while preparing some vlan code cleanups.

 net/bridge/br_vlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 31c1b2cf75d9..1e0e436629ec 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1136,7 +1136,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
 		if (err)
 			goto out;
 
-		if (br_vlan_delete(br, old_pvid))
+		if (!br_vlan_delete(br, old_pvid))
 			br_vlan_notify(br, NULL, old_pvid, 0, RTM_DELVLAN);
 		br_vlan_notify(br, NULL, pvid, 0, RTM_NEWVLAN);
 		__set_bit(0, changed);
@@ -1158,7 +1158,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
 				   &vlchange, extack);
 		if (err)
 			goto err_port;
-		if (nbp_vlan_delete(p, old_pvid))
+		if (!nbp_vlan_delete(p, old_pvid))
 			br_vlan_notify(br, p, old_pvid, 0, RTM_DELVLAN);
 		br_vlan_notify(p->br, p, pvid, 0, RTM_NEWVLAN);
 		__set_bit(p->port_no, changed);
-- 
2.47.3

