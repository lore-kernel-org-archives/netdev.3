Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F540B11C
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121238; cv=none; b=EGOacawO5QyMbq5HTk+/81v/baajT+IMDcQMYM73eyhsblDPxvBhFnVbIkmxtR0D2e+FgD2Lv+dj2dbNvxqKRaDuDrcAnbhodoiAoQka5zXjoPUWST56P74zmkngYRasEtleahPbpQIbVMGjS8QUUjEoDQq6vkrlGKe5s6Cu7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121238; c=relaxed/simple;
	bh=VuV385v8230IBrnVcdExfiHXu4mBvcC2qQ7ccGIdEHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVKbIZU4Hj1C/32t53Jmc+/Gr+EmVEXVVFQluM9BIsWDlahsUYlwrjcSDtBaniCgoCKzdSmO8lcyxryLYQsSufXcfloNEoViBG8NSFqISpUlBLbFH0VlCbG9BRe5t6rnW6kOf0LYn8pGlqrNEoIU05A5WEy+7hn78kTijyEP6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OHRGwiGc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OHRGwiGc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso11109685e9.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789121232; x=1789726032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bhi10DkAqstXDlZQSWSn3PYXAmacwyGL6+DmF7xthLg=;
        b=OHRGwiGcls1uWcQ85NHnETVacncb0pOoHFMC0VPi6MxX+i+dT0+AcBWCKPPhsAfTXM
         pDlwC+xIPGwR5f5oSwMjOAnMixwxCkbG/tJB2PwUWZD/6rRnKvIl97kR6WAFeo1V+NEO
         j08kmQAXjVRBh8Ef2FNsPB1oAvFzKni9jmke26uWSJDFEABO6+pMEjyy41LVKNrCZDDp
         FSmmLczh71h9ENBC/r+2a7cs8BggqcX0rJx2qaZfyGeyKcoax0qfDmvroRDc0gUkxMFB
         +SZSigbx9v8LAigjZSnC2HqL7C9obboVnXFXrzkIFzJ7Xxh1nDjCndU7KzVQtKyYkWob
         J8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121232; x=1789726032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bhi10DkAqstXDlZQSWSn3PYXAmacwyGL6+DmF7xthLg=;
        b=Nwh6mGsSbkqfuv4miYmoT3kZ85YdNWez4y2ht22P+IwtILv6FgLhbdODzDf2wHbZ3N
         cF+A8hOiT3MbFXb4I8S7HRAfb+v/hI+eczdr9bNmSxMWW7m9Xe2eMuyEZSI0mZgl/LZL
         GX+M6qaKKbZURdzzVz9zNHkfIeZhsIXZW0Gz01Pm/HZOHZTbXdPoaULTsr8VcrGH71ca
         N932MhAYsvhatV7xczMJPDrcFQT8uok673pz8LqpbnQV0KdI6R/3nFDQOpp4NZBGyxBx
         XalFoEW10T6E9mJLGIUScx1UOBB66M3IBIUgedIEwB3r246ePmtpyM4lVFmIuzCvfUZ0
         di2w==
X-Gm-Message-State: AFuF++muxtEO5YocfnvweAaUHV9Wlp7Rmr9RmxtrnnYFAViE6/lr/WSF
	X2zhB+oA9p5j8ahLEEbU8ejcy6UXIOkhhhDu5fuLQ53T+blJm6qhn4I0u/+OZR/ZFIOkOir9ULl
	SYwo3gXw=
X-Gm-Gg: AYBFou1rbNFkXeD4jSP4n4J20HOydIldvs6dk7qVK8pIoL9oFI13dcLp148qCHa9uMn
	xUmf18cODcbZf+USizMS6sBHsEN1FdWYmBocPaLFjzUm3rsGOuubXrnAmZVRKDcsroaz/FplnuR
	U+c2dpwvAhvmDgMWP165/1YgDoIfJEKsIppogccfo05OGDcNmZ7GoY1Fg1V34Vr+BpkZ2KzZ+Nu
	/qUnZ8l2MDt6/qmJfgLoAICZ4sCjzebUx53DxaB+3dwSmLX4MoO7RPKLw+fgJoIw5s/svwElnvY
	uPsj0GoE1PD6My+W86XZltb6GeIrkqsidCOxyQQGsVlxEmzZiaw5Rv80jiAM3oz+9jm4KQWnic3
	o7YD44AM08aD0dlXdEpWVAUjjNtji1JCxWXkIxzNdslJOaeLS8vXQw8HQkQLjW4axzr7nJBofUd
	GKtAipoypG83aZb3dDlhOCIlY0ypCS4KpdRb7fOpYcjjOLKgsN8ve3zfIYwYGZqO2W+xxdzpCJy
	P6UbopGYyib2kUS8qP5uQ==
X-Received: by 2002:a05:600c:860b:b0:49c:fa21:1c87 with SMTP id 5b1f17b1804b1-49e619d1bddmr33286315e9.28.1789121231896;
        Fri, 11 Sep 2026 03:07:11 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49e636f7fa2sm42385185e9.15.2026.09.11.03.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:07:11 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@mellanox.com,
	vladimir.oltean@nxp.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 2/2] net: bridge: vlan: avoid NULL dereference on flush errors
Date: Fri, 11 Sep 2026 13:06:45 +0300
Message-ID: <20260911100645.1360386-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911100645.1360386-1-razor@blackwall.org>
References: <20260911100645.1360386-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vlan_flush() is used for both port and bridge VLAN groups. The error
path unconditionally dereferences the port argument even though
br_vlan_flush() calls it with a NULL port. Any error (e.g. switchdev) while
deleting a bridge VLAN can result in a NULL pointer dereference.
Use a bridge-specific error message when called for the bridge device.

Fixes: 5454f5c28eca ("net: bridge: vlan: check for errors from __vlan_del in __vlan_flush")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1748ea1fc202..3aa0e1fedeb2 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -467,10 +467,15 @@ static void __vlan_flush(const struct net_bridge *br,
 		vid = vlan->vid;
 		err = __vlan_del(vlan, true);
 		if (err) {
-			br_err(br,
-			       "port %u(%s) failed to delete vlan %d: %pe\n",
-			       (unsigned int) p->port_no, p->dev->name,
-			       vid, ERR_PTR(err));
+			if (p)
+				br_err(br,
+				       "port %u(%s) failed to delete vlan %d: %pe\n",
+				       (unsigned int)p->port_no, p->dev->name,
+				       vid, ERR_PTR(err));
+			else
+				br_err(br,
+				       "failed to delete bridge vlan %d: %pe\n",
+				       vid, ERR_PTR(err));
 		}
 	}
 
-- 
2.47.3

