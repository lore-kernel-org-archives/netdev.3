Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BFC3D5236
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601191; cv=none; b=jz45ZFXloRUm1BhLdyRPWcB4XD4RK0CT0ELjcYOdUQXqs9CF1RIp5gt3kPV3t99fh5bKmoWxOWHFtny7eRMNJ21uyfnljwm83Vxd2frND3qDhIEgs27XB5FvD0p5Z6WYGGsZA4BNc9aq6pl7/luNzKROpHZHyDRqAdTW5Ho30fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601191; c=relaxed/simple;
	bh=2zQvRUscIgNiPZoEjC1Z5mtgLCeG0uKE2CLDirOMMRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=royML9POVbvGi2eIYh2SShfWUMdh6tG4+zqqeckcKU1o0jzdPpFIhmlsL62mBETaEvUko112do1gyYk2JdVJyKY3iv8AOLOxjPf4e1djMbUfuxR1bpi9LxCbXeHdZgXXo9u6i1b8wn2XESnw/lY84Evqk1JOiMtVyd2IRLmdhSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5uRxfuQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5uRxfuQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d8fd3b729dso16001355ad.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601189; x=1789205989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=263Ot5CK8k8W50+c/iZQZai2Z4LPXqFiKiK4/FLJICs=;
        b=Z5uRxfuQPO7vRR3AcaQhSTSINViylUkUzrar1hGkf40UvxNae79gyGUbaTUdtR2WRs
         hCkeoMYRG+rJqorEjyXgkxqIIvYWvIbnXOGs2z5UoyByFdfEFpu3HNkNe6UvaWh6fW24
         +usJubVDvODNRX+JmqCexzDZ02SD+fVQcBxkq/8okuiZYPJzARASw+M3Ir+nYZOhcVp/
         QxHwVdP0+dGSx1K5gXc2m3kxX2MrifJkbGsJG9VXYI31O6ZHMwEZ8xtebuLMz5VLyUQP
         TaLn6t9CeJh6rZ6mjjKVgMdNDoYDsKJ/iF691oDZVKykHRkQiOi3fxpwo+q09dviCn1y
         sqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601189; x=1789205989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=263Ot5CK8k8W50+c/iZQZai2Z4LPXqFiKiK4/FLJICs=;
        b=rcwVzhoI4yfhVK8Z9w3Klb9P4Yq+/eaIfNs4HyxwzEc+lACg4r9sr0Xp/zaELy5I1j
         10o3SI0Xo+KLdwkf+qcmo1dT7RbHKzA5Au60PxMLPNsY6AX5OS19IUSn9lNyAtARPt4o
         7pipnA5qIU2QdWAJ+uT7CgBgh0xbb9R/eOXLuWozQRxVNarKaZn0bFUSbZnSsoArp0sg
         u/HkxCO7XWEBhQEuy2KzOwz9NJeuWpX6KzfSkj7MLUGhqjyO+LRDj80lHm2HC0fnIOqZ
         bsxMhu19uPBn+mJSMMls5QBoKRrm13qinSHZSVGxRNy1tvUL7JKB1dvfjUZG67xa2NSV
         hhgw==
X-Forwarded-Encrypted: i=1; AKwUvBzeLaRyJzEg/D/nZTfSw96qh6eR79OkqXojcvbmG0GUFs0O2PwtrJZMRecIT7Es662YbnmsW2k=@vger.kernel.org
X-Gm-Message-State: AFuF++k6rw5XSBIGGIZPJFXfDV0VQppLah0D9OTna1cfwgHMxZSiC/xC
	QLlWYZTG6QEII3JcIb1BNn/dojHg8Ij2TP24R0Iq1oeF6EDoD0lVNJMb
X-Gm-Gg: AYBFou0yf93VwDwegySJGolQv+etyGJ4cRMxsNzDWG7VgDQRIuham+FCnTcmN8CxScl
	7lNrphskgYnePaxm1ourTBZE/yDzG6GDcxiJCRQUTpXQvSuYOiWlaNAythXiW+iuugiMILzES1p
	YzZQNzW4quZkSQn8QmFDJRYTJwxX9/9CAieTVzhuzFPxBAZ0K6gXwFIjwsrzk1FytUlbaa9OSOr
	0h3BsfZ5LW8RrrfSLAftfUhdyU/jk74DdbS5g4u+uVpwC0jpE01FX2wLjfvnsTUu+Q3yI9CezJ4
	0CkJs+KV7OPP3+NzG9egySmkBLE2QPlABdx7mV0G6NyWzOh8vmu1ao3sOM26tQvngQo7juyEVw6
	5TF4DyfLjrhw+TNdiFoJorozCxTlDbVU/4po+W/r5UjILxaEa84WxUOy+S1KGOLagOAdCwAtlZ9
	OuA5zeGwnSTFFeGE9V3VJUM2XnLt7Ipv9Wn1SQhjBje9egwDNFAHCC3Ca3ftVX4pkESdbavOhb6
	24rfaInhe/0fypC6FBnbGug06xq4tcZNnr0og==
X-Received: by 2002:a17:903:8c3:b0:2d6:fec3:bd57 with SMTP id d9443c01a7336-2db125c2f3cmr189302985ad.14.1788601189102;
        Sat, 05 Sep 2026 02:39:49 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:dbc1:ef89:4dd5:b812])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495a0c0sm20393745ad.17.2026.09.05.02.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:39:48 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Sat,  5 Sep 2026 18:39:31 +0900
Message-ID: <20260905093932.43726-3-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905093932.43726-1-sigefriedhyy@gmail.com>
References: <20260905093932.43726-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mention that ifa-family AF_PACKET dumps link-layer multicast addresses
and what the permanent flag means for them.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0ecbd24c890c..2a2310cb0df0 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -168,7 +168,12 @@ operations:
           attributes: *ifaddr-all
     -
       name: getmulticast
-      doc: Get / dump IPv4/IPv6 multicast addresses.
+      doc: |
+        Get / dump multicast addresses. ifa-family selects the address
+        family: AF_INET or AF_INET6 for the IP multicast groups joined on
+        a device, AF_PACKET for the link-layer multicast addresses in the
+        device filter. Link-layer entries added with SIOCADDMULTI are
+        reported with the permanent flag set.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
       do:
-- 
2.43.0

