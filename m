Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C83BF69D
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270745; cv=none; b=YgAr0cN8AG76exI2J/dosXMDd+F5WyvorGFfhLXgaUu4uxxpMyRgDPRcFB0DKCB35GRn5ixctQjotb5g8/SIeZRvRYHhM8PR3Ef12ImD5/1K7xZZ+RMwK24gBmgJGVdz7UAji5yEJdkI+6aCtz4/FZuzOeX+cBkAvQN2ozYYZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270745; c=relaxed/simple;
	bh=xEM4PWSdufJQRFlVx8hDi0jZLJQtFRoDWHIzLk+sx3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMuYCADwalHP1xXEzgw0la98GtlVrOMHcTMHz5WnIA5Sv/Z/WXcR0WWTJi9d5l4z1k6bdEPxWGjz+a7W1g5JI1i+q06VqdmXPck5fTCeYX8XY2Tf7YADjGXGar49ifMDzMbHZyQ0/45W8ilk23A6tGyWOr6q+c24Adpd7oDoRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2gmXDsM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2gmXDsM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so7349192b3a.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784270726; x=1784875526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGWzAqMnXIx+QjNO6QbhWdHJZEGF73MjjXZSZbQ8KHE=;
        b=O2gmXDsMmWZEygqF3pPjKqCS0emvhEZL82wd0/W2DY8LuQjRJiSAxmsGXzlP6ebnGL
         DkqGCcx54sWYJjw7JKeb74htcfhoeVpGUnmDPHnDq0vvPTelUdadeCt5DlHr2Hde/4me
         Qffp3nONpOpiOhPn+qca6zTfV5PQI+EMGwgWS7TB9qdWdqU7bJcpJ1C7FGil4ozxTFUK
         MHeyBslnVAzXK06JVKrx17tdDE8dn6B3u4gUrEjYOxPUEvLsp89j0ZkJ0+wMPahwH7yh
         lWaLhFZQJ3AEIMBopWgt9Vohq4F5SwH8QtcGaHRdntPxTONllvRlVTYtE5tYCteF+TpB
         zPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784270726; x=1784875526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGWzAqMnXIx+QjNO6QbhWdHJZEGF73MjjXZSZbQ8KHE=;
        b=RsO+BttG9G1CgksWpUdYWf8ISHn5MBtt3LshG1ZILbBNMP//xDnskIa/cRGOFZDYrA
         z3Jre3HcJ+Dp2KZ9UOgnIrs/a+nU+eieKW/ZgSWSyTR1dOJhJADIPv6ovC9y6wPjEPzP
         jgpffzFffOFvePgtcSGCU0T4ZknnMYK+uS0LRW0BXP1xPPmBLLLqbek1TD3oxhf/V8KC
         mlrqm+VKhYEEohmNUd6msAy4l1phLWuRNR77MBQCj0OC2FgScoHZcS45YnDDUVwlFbpi
         rh7vCGdqjZFUgM/ShCWXWs8tRYlMc4uNWccuAk6RwrzY6TadAVu5XzkAAEkOppYXC1It
         pXFg==
X-Gm-Message-State: AOJu0YxR2nQo23jV6nUEYeNBjPE15BauLdlfHYmwSf8Gq1kyP91eKteP
	VAhjv4ULO/m88NEhdSnG3G7ED193+0mDhvGvSTaVXgunMT8HrDoSZ+Hy
X-Gm-Gg: AfdE7cnfOPXnvEsM+NFMNf8oSd/A5Go0eVzUPSm+OrrC+XodJB4ZckI2qtBt4aBoZQB
	Se07Cl9JO1M7AeTZSktWl46fZ/5TVORIAyQkpc4F7FvLT6cUWOxEILL4MOWHl7YMdL0hpU4Lqs4
	MW4NqAO4xkMXhM46prOz+6rgQYPRkHIPLl6p/pXp9qs2PA2b54HcVRCy5oIbNLu8CV9uIIxK331
	lt1ipK4XlMmmzdBHyR/SnLA9HrHmZwFjKACe6ezTxIVzf05JrtC5xSx5DibWfmZOLRlbfJ1TFYA
	VjJH2i3qdRKvp1ZhJ3nxx9aoiAMDVJGydjRRX3DWBSD4bN5Dpg30ohk5rcjZeerXQx9vdtTnu2S
	tU9lSi0YdIoqIlmTPtTnXC8G9T+Ei8fsX9yr1lDhQmpaSMMfcbQ+mPyPER3b9FY8i6SDZKwayH2
	4XqZS3VqnYB8pcoopDH5VzzRY1Sg==
X-Received: by 2002:a05:6a00:1492:b0:848:2f73:8ffb with SMTP id d2e1a72fcca58-84c29528564mr1412058b3a.68.1784270726474;
        Thu, 16 Jul 2026 23:45:26 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8855fsm430531b3a.12.2026.07.16.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:45:26 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Date: Fri, 17 Jul 2026 06:45:17 +0000
Subject: [PATCH net-next v2 2/3] vxlan: honor per-nexthop fdb destination
 port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-vxlan-fdb-port-v2-2-f4862e8fe867@gmail.com>
References: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com>
In-Reply-To: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784270724; l=2196;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=xEM4PWSdufJQRFlVx8hDi0jZLJQtFRoDWHIzLk+sx3Y=;
 b=YhfQRticdo6ewbVHM1o14OsXcOGRoOkDyWL1lmyZ6SYsB5zZVIHJLM9i5b5iwgu0Rz/Nvgv9D
 EiG7Vf5UwMjA+3l2IAKLgjaslE7mE51uTANXD1z14w+fmFc/Lb5y3iL
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

When an fdb entry points at a nexthop group, vxlan_fdb_nh_path_select()
resolves the selected leg's remote IP but leaves the UDP destination port
at the device default (vxlan->cfg.dst_port).

Extend nexthop_path_fdb_result() to also return the selected nexthop's
NHA_FDB_PORT (0 when unset) and have vxlan_fdb_nh_path_select() store it
in rdst->remote_port.  vxlan_xmit_one() already prefers rdst->remote_port
when non-zero and falls back to the device port otherwise, so nexthops
without a port are unaffected.

This lets one fdb nexthop group load-balance a flow across legs that
share an underlay IP but differ in UDP destination port.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
 include/net/nexthop.h | 5 ++++-
 include/net/vxlan.h   | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 9c8227996..7fb612a73 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -576,7 +576,8 @@ struct fib_nh_common *nexthop_fdb_nhc(struct nexthop *nh)
 }
 
 static inline struct fib_nh_common *nexthop_path_fdb_result(struct nexthop *nh,
-							    int hash)
+						    int hash,
+						    __be16 *fdb_port)
 {
 	struct nh_info *nhi;
 	struct nexthop *nhp;
@@ -585,6 +586,8 @@ static inline struct fib_nh_common *nexthop_path_fdb_result(struct nexthop *nh,
 	if (unlikely(!nhp))
 		return NULL;
 	nhi = rcu_dereference(nhp->nh_info);
+	if (fdb_port)
+		*fdb_port = nhi->fdb_port;
 	return &nhi->fib_nhc;
 }
 #endif
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index dfba89695..de41b3746 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -567,8 +567,9 @@ static inline bool vxlan_fdb_nh_path_select(struct nexthop *nh,
 					    struct vxlan_rdst *rdst)
 {
 	struct fib_nh_common *nhc;
+	__be16 fdb_port = 0;
 
-	nhc = nexthop_path_fdb_result(nh, hash >> 1);
+	nhc = nexthop_path_fdb_result(nh, hash >> 1, &fdb_port);
 	if (unlikely(!nhc))
 		return false;
 
@@ -583,6 +584,8 @@ static inline bool vxlan_fdb_nh_path_select(struct nexthop *nh,
 		break;
 	}
 
+	rdst->remote_port = fdb_port;
+
 	return true;
 }
 

-- 
2.43.0

