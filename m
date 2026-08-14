Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD9476064
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714865; cv=none; b=UGauIQIMOIdMjdaD4OGAV0jyoEscVS4CANiPGU6ORt4JT1VCAww3d0fmHslW60O1tfxwz+Di4Lsj1QzGZ1U3iW7cHx/iVAEYW3JO2lpzYS5kLmU0dO/hou+FgVyr7TsrtZUQXbFHhrRXJbYNuBTeiAfusrMRtKmsbzU1PT7HWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714865; c=relaxed/simple;
	bh=ZCtbq8/4454INlMgyOXmWQio4JxckUhjzIjAlzKMO7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6xlK8T5R5i6FgJEszstaqygbtzNcAD7mO1ywym7E7VR96MIppZrLszK/UpBFR/RJKtkkxvCJoAQ6bdGq0JYDqV9r7p3UuQ4Wx0Tx8e4DcesoV0fSTMD9C23XfRkmefoT0q9qpRgNifbjeQUWb7DfUlapUzCRCH1lM668br7Hhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPF5sU2t; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPF5sU2t"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccf2360620so10361675ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714860; x=1787319660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zipcP6cMMo2au5RIIwFC0kV7yCXjZzf04W+orfthdMs=;
        b=IPF5sU2t+w+zGBXl4fBjW1eQIaPlw1mE7+ayIL8d6oiCv22lIW3VxjNARsUVPUmx0T
         HE6qdpEE5R42KV06+NtzSZvgg01Wn/dCHl+uJbff7RN3nn1KLCJHm7OX+mR3i81Un4s5
         LH9HBXQcbU4XSyz+VHAb9ooI29pZVpmfN/hYAz4/AunQGT6A/heqpyvG1C3qpCWNSPJb
         cEVDeiQd+P09PRDVfBeQFTq7ISKgt9LLrH+nuoN6e/xfBC+d4tIrK66VloiwaCN95zeN
         6HYIu/MNax+DSYdToreIKAD7YfAJgKrtauyUFSrtCxzmZkh1GFPy3/STM7F2fq4PwL9c
         LJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714860; x=1787319660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zipcP6cMMo2au5RIIwFC0kV7yCXjZzf04W+orfthdMs=;
        b=JNnomY37djMNdIWOIerABB/aqjyQ5jF67WbY6ISICfz22I1JVuI0YVGNXd7QOnv6+P
         ODsxDDiLP068pKkAQn76F0diWW4k9mCOnAyIgzYCRlBLrwGE+VB5wuv/2i9h5T2k+i6h
         G70jkihKlGbeF3FVr6y0TWd8h1ndjZF/B66a8NZiM1mKak2eX/Z6kieC78aC1NFK2qCg
         7yY+qhMo5gwk4CIyCyGUC4upsshbIRneLL8bSuE9vNfAC7AzKnardVdfdsdUGbjTqBy9
         HsjD71egFezQXl2F5kgchqi/B1/e+RIvIONDxfgbuD6H3/TMGbU3lepaHHzQqGzhYOnY
         reOA==
X-Forwarded-Encrypted: i=1; AHgh+Roy3tyTUVUYTdW3XvyJNOKamO+7unyHSwcR9kRwvqJ/3/lYDrzrahSDyJiDplvFq3T6/O6/8vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGcNIZhI/x1KTQyBB9eOKZHa5rIQvUdIHtE7+P71ueeTH74Cr
	f0iu0iCxJ30jh6wvna/JlSXphzzPkakKqMahzvUAvlff7acjQbZb1ehY
X-Gm-Gg: AR+sD12aoCXdNfqLREaV24VnsIUDYkixmS4jCe3qbDcqHHFmrC4Dz82dJ3HquVewfhC
	5GR09b6O7dsjx2ZEuDrQE64dsx6XG43UZBajg2O6Ipl88NhCfIKczxQRliorNKwM0zLVUIinypi
	kh/SiOOSNMWo6AJTCWkXnr4Vz9LRHHFg3Ktp6vMo2prmZoHei2DZwSFcGb+kbS0irt55ejjzwvk
	5zY3myroX/0XIXz8ERYAsM4WZlmIkQwJlny+eYYU9psAz2CbjxHE2cZ2AqKbhS/mVDSKlz3U2LH
	GZX5tmt/OwdawcByl/cJG78VLY+z9nS9t+KhwH/AdJoRgKMnL8K/ZENdyddVAjajGZrcVdQBpO7
	2/lOrCfslXlupDVhKpOi/MtrjG9FB0+A4XgtZBKerZDp0CfCd8UiQ4A3H8k9pgCDBNlfMjj42Eg
	4Xpj1JYQtrPPUGokZrFO16GNebutiJzCH+NcN9FWltVNiHNJqYufBp3tJzE5UwOtQUvUgQfFAU1
	khmIj6Y
X-Received: by 2002:a17:902:e547:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2d3b0dc57d3mr63121865ad.20.1786714860112;
        Fri, 14 Aug 2026 06:41:00 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebc3de2sm9822995ad.70.2026.08.14.06.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:59 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] net: bridge: Reject descending VLAN tunnel ranges
Date: Fri, 14 Aug 2026 21:40:53 +0800
Message-ID: <20260814134053.1387275-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A pair of descending VLAN and tunnel IDs can pass the tunnel range span
check. The VLAN subtraction produces a negative int, which is converted
to unsigned when compared with the u32 tunnel ID subtraction. It can
therefore equal the wrapped tunnel ID delta.

The range loop then performs no iterations. Since the batched
notification handling added a post-loop error check, this leaves err
uninitialized and makes the request's return value unpredictable.

Reject descending VLAN ranges before comparing the spans. Valid
ascending and single-entry ranges remain unchanged, while malformed
descending ranges consistently return -EINVAL.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 94339443686b ("net: bridge: notify on vlan tunnel changes done via the old api")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 net/bridge/br_netlink_tunnel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 71a12da30004c..05f560eeb789c 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -301,7 +301,8 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 
 		if (!(tinfo_last->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN))
 			return -EINVAL;
-		if ((tinfo_curr->vid - tinfo_last->vid) !=
+		if (tinfo_curr->vid < tinfo_last->vid ||
+		    (tinfo_curr->vid - tinfo_last->vid) !=
 		    (tinfo_curr->tunid - tinfo_last->tunid))
 			return -EINVAL;
 		t = tinfo_last->tunid;
-- 
2.51.0
