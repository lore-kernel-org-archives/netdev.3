Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16034B1AD
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789902569; cv=none; b=g0cDlUh/a9vftnnKdneJUq4wszrUf0d9l4G30jaU96/+esieVcZ2cJWsSaZ+tLA0/f+YCBVNmZkFkmXfk5k50RMGHoydTvfotuuiHN0BZukyEudz20rb+vrrd5st7Ox+iCRVBlpvR8HcGDOrIIrUw5VEhRotdjlSLWJCDHcmoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789902569; c=relaxed/simple;
	bh=4E9blRxoQ+Mbf6v+LjIyEQhWnu1g7D/3yBtZLpQUJSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8HrSr1xd4JL1xsFPOd/tsx2eRDNyKbw6EU42ytoI0pMQx2dyv5ey+bVqWbcmrUCPnPOzSN+SVjZ/Df1dxmFFCg2dt3IKNhBDpIQ9K3A/ksaNUwqqaGrhvpHSjLb0+6CJeg9FXc5jcoq7Mdv2F8g0gt6QoI0kRQbsf+z/9EhFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyM23TUK; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyM23TUK"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a33c9cso2871304b3a.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789902567; x=1790507367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Ye5pnKqTEfaV7Vck0LFhJMVfU4j6jzeEid83vd2NXk=;
        b=SyM23TUKdHy2Hy9iOtIt94FUewkhKpP8Kr9Z4l+2uwc1q81kuzFE4DMSh19FsxmZqv
         CQNsP9sYM41TYqgIWK6C438BZo9QR+O+/qx6rKOV9a1pOf4QWDsNXuUg0iFTN/uOz3RK
         C9dhnWbLyNdb+5fR4vaLLLi7SOpFv4cYB/BgxC7zkwOw9xCUjv65hGirTgph6LxaQOVS
         fBjcyjRFHyZ5NJ4uZB2669O3AC7GY2i+UrcE9sIYlo4dl4c7K+vOG1/DvK8JEJ6vLpod
         AYEfSkMCDS2XHrIsRHylULbOQ5Pc+Bcf+phgQhhkSJQ+0mTNzDcIWaXN3TG7PH9Kd3gV
         /gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789902567; x=1790507367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ye5pnKqTEfaV7Vck0LFhJMVfU4j6jzeEid83vd2NXk=;
        b=joVVefn/+jYQS9WVVi2YENvORAD6SQVu0x+O/L9ZC/nFO0mLMNPRUBfVrVz1KECg05
         pHsCKo++kWHHyQr/8m2RoEcP4OLdi6qiBiwef2mGjiooG6d7Vm4Zfb88c6xHE4sfU6vk
         jvOhZpd1C4oJe14KOjuzZB8z7lWqVbhFbQucKy0sgXV2UA73xN4fjMNZt5oEQCT1+5cs
         Y8SJ4kQT/MGgG+2m50b0mK4ahvgtoG//L2ukBWz4eBaPFpoL2EofuyN58oz8EeCNMu6U
         LSvA6zR/2YSjV/oXdNAxBNmKw1E2NVFiRLMUHosLksdyZHlf205kq9FzKDPlmYZwccGU
         Dq3A==
X-Gm-Message-State: AFuF++lMe0Lh1Lhwv/vsdmEX7WQc8yLZG6xkxqmrLmtsT2Z8IvrVcBB8
	LO11ow0wLpQLMrDLd69Mw4ENGuT6wB5sxqdrUb6/YkeQ7HO3rxqGfNvsx/3ZwusHTZI=
X-Gm-Gg: AYBFou2GJKYyMj9ivluQd8L/FxwO08mpERPVEHzfEc5Ii30W09H0Ge4oR6it53IBfy9
	AFTPSZ8mC18pA+MyeahWomepCZsY5B/WNFiJfVcc/0unsx4615+n4Bm1l6Q7EVuHsPggPqpYr3/
	ZJxBiyCaWOAJ2Jfvng9qJQ+/Q7qQyAFBg1sVnL4H8fTiQ3IvKhcOGa9CaSdnVraW4zgRWrSjEnp
	hwVep9UaMThJVRzB242y6qDnNuhvkhdOP7iNum3Dzl/195XDU+ubFMKBJy+5en0X5w8Na2b6eCg
	YO0kzImbFUlCu3bjnox0n3NQAGvpZjokdb00R2BMRYL1m4OEFWW1fPVvrXk01tJa//Peij7HdnG
	gBgcEjaMd3I/o69RUPZRiu05Slqin5t15ZMy3IR7rGf4Pu60LHA8SHVupK25iaUTKthTjg2lWB+
	P12YHzPk6etjf3XGiGIPFesCbCOqRiVpwk3+p2PNNA5xk6mMUKPqf10pnQUnsZJygyOk7zSoGJ4
	Gor
X-Received: by 2002:a05:6a00:4ac8:b0:874:708d:b63b with SMTP id d2e1a72fcca58-874dedfe00fmr11626090b3a.28.1789902567446;
        Sun, 20 Sep 2026 04:09:27 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9b0c55dsm1897536b3a.37.2026.09.20.04.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:09:27 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: netdev@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	bridge@lists.linux.dev
Subject: [PATCH net] net: bridge: mdb: restart port group walk after deletion
Date: Sun, 20 Sep 2026 19:08:43 +0800
Message-ID: <20260920110852.60293-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mdb_flush_pgs() keeps a pointer-to-pointer cursor while walking
mp->ports. br_multicast_del_pg() can re-enter the same MDB entry through
br_multicast_sg_del_exclude_ports() and unlink other port groups. If the
cursor points into one of those groups, the next iteration dereferences a
stale cursor and can leave mp->ports pointing at freed memory.

A following RTM_GETMDB exposes the dangling pointer:

  BUG: KASAN: slab-use-after-free in br_mdb_dump
  Read of size 8
    br_mdb_dump
    rtnl_mdb_dump
    rtnl_dumpit
    netlink_dump

Reset the cursor to mp->ports after every deletion. The deletion removes at
least the selected group, so the restarted walk always makes progress.

Fixes: a6acb535afb2 ("bridge: mdb: Add MDB bulk deletion support")
Cc: stable@vger.kernel.org
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A reproducer for this issue is available if requested.

 net/bridge/br_mdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index e0c7020b1..a01bd280c 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1523,6 +1523,8 @@ static void br_mdb_flush_pgs(struct net_bridge *br,
 		}
 
 		br_multicast_del_pg(mp, p, pp);
+		/* br_multicast_del_pg() can remove other groups from this list. */
+		pp = &mp->ports;
 	}
 }
 
-- 
2.43.7
