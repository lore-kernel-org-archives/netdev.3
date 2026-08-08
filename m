Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0352F8E81
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150643; cv=none; b=bsE8TjScW8FYKm+uuEYlg7pGr9rAIP+h9MBxzvBxfQFDhuRWx4w12hxPVvMD5y8eT42Ru2XGAo9ErZSr/hG2ieWUP4TG07USisoX7E52WmzW4QQux23UVYSHAHk8EL0tvZRhJ7XueiiJuAEfvDhToys3O9oXraALBoaQpeMLlfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150643; c=relaxed/simple;
	bh=B7TewygujZnaDoAvFCdYw3/qv+UCkSEJvMuQcq5Qjm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohSlBjCwBHkoPbvEbB/Yu1PI9AgHA3DCdyBb7rBF6si06t+t4+w2uoD31oaehZG29XZO4/iEI23uiIuwYNNgqm/4tsUriDyvelc3itPAaYxsCjlc9V813Ea6lvRvYaUGIy1rgkpxXjO3RU2Pb/nX0NKjChzntcSfUBVEUmmcoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auylG6Ts; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auylG6Ts"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e7109321dso56529a91.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150642; x=1786755442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gzb9FT9wUkGMcUEIoMcEc4INRD8xMXaz2c0lYN6UOZs=;
        b=auylG6Ts5PHtDVCNxO+NEniCxMYwPWfPjBTM2A7jVmRXGQOIEUW9BJ7b/c7ktYAOmP
         VS+kr6heR5f2bYeEsHlmCmjmi7jmrfEcYkFb2Ua8hhJeOBVQVxbaqa5x/Vxk1VJODSyW
         Q2u3+c0Di5bOJtYmvOLOzKxjCsb2neRweVZZec+vYou7+9jcP/CUMMQcqM/gvU4bciJM
         dpxmet/odXmct0ibSpgn8eixzEDMBTwiWHICAcu5qRjU8E7/XlLhLQj9ACCbt7t3oaxw
         gPO7IPp0EKmEkvX0fde3h4Db2h/MIJGt2gyAJLmwMZi5a0UJdmrlA5hrY2z+TFVvUTxZ
         7EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150642; x=1786755442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gzb9FT9wUkGMcUEIoMcEc4INRD8xMXaz2c0lYN6UOZs=;
        b=MYNydJ6r/C/i1s77rwzAmaYpOjW0RtoyzcKlDHHWnFknYLAXIkb3Lac258fe0L6KOS
         lYL2GiTwEUYzsLFdmMurEnhWjEBHCH3675DbxncUWq+kbmThBHTKfOj1kr5jKLiNG0zp
         dyWpvWCMdBlFkHVWAXy80bKqHqEitdVWzEIt9+eITFVRB3LY5oDsRRZGloP9rxzzU+wq
         grruBUMiDhi9mcE8HvYn63tRMQM3cg48bT0bnR5oXhfNR6sArfz7g3KJ8rOzElzECqpu
         h38b3vVOONXPGc0HL96C4ZdAvS27FyZxg4wKDjHI956Kf9H7dpg2PUkhON3yEiXpSh/T
         R11w==
X-Forwarded-Encrypted: i=1; AHgh+Rq08wtABXdVlORtBxVPgOV6IQNgxHKIR+RudsPgIGW/bwO6xURJU97/ZedB9w2GppEKd7pP9q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvBwfRiS5J1/6KFllLKg8Eg3SkuRbsPX0p1Xh39GC778Y/WY4
	8+TSVsRv/UQZ3GHWDyJenqS1SyjQkS9NhXdmdFyjC3tpcrZIZofJvheL
X-Gm-Gg: AR+sD10fT1td2Nj7eoUQcLogQ31GhpS07U/4o++cpD2rCRPMq1u/UZJ2skBA85inPxN
	/ULAwhGIPtfKAsIuHmo5fjpFhM84mwMLED63CRNxc+kUaaM8Wk03u0eWUN+WFXX1+iSFGcnOxhS
	9GRUa5ja0YS1A09g8CYRyA54MpPraPXT0S90P+Pud6Mccv2xYApzHSBU33maYPEWr6Rdbmtkg2j
	blNEJSNmDzKWZQOHxAxMvyJNlDnvjJXtNYhryuOyfnY40CVUxRSLvTNtoNBgSWHkS9+OQTwQwJS
	x3gkZkgR+8b/BGoAA2TIf3cujg6PhC5T9XVqyNk1Y1MrZ7QDoVDblG6YubOZS/f+Bv3C/qxZ3RY
	uiuzDmm7iRPVKZb700P20zMKCVQiQQXo4wbvZX3N4csuPkvBkKwWj/Hbx+em0YJEcATGkU1fA8v
	zoRikHwSXywhliInfkSbuBIC7mGy4STgROKvaprTHWf2lloyXef56LtAQa3pN3a5H+65ndK7nDn
	1+Zli5uJX1MvI4M5tiMMX3Yn+RYx19L9np2C0RjbpcR2/6yCvc=
X-Received: by 2002:a17:90b:4c45:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-392822b7b78mr3257943a91.8.1786150641757;
        Fri, 07 Aug 2026 17:57:21 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:d7e9:6449:7464:1dfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm4205182a91.2.2026.08.07.17.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:57:21 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 07/10] netlink: specs: rt-route: add route notifications
Date: Sat,  8 Aug 2026 09:56:39 +0900
Message-ID: <20260808005642.26901-8-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808005642.26901-1-sigefriedhyy@gmail.com>
References: <20260808005642.26901-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare the RTM_NEWROUTE and RTM_DELROUTE notifications and the route
multicast groups, so that generated clients can subscribe to route
changes. Both notifications reuse the getroute reply attributes.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-route.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 33195db96746..62b215614210 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -322,3 +322,22 @@ operations:
         request:
           value: 25
           attributes: *all-route-attrs
+    -
+      name: newroute-ntf
+      doc: Notification about a created route.
+      value: 24
+      notify: getroute
+    -
+      name: delroute-ntf
+      doc: Notification about a deleted route.
+      value: 25
+      notify: getroute
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-route
+      value: 7
+    -
+      name: rtnlgrp-ipv6-route
+      value: 11
-- 
2.43.0

