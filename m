Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814073EDE76
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541955; cv=none; b=JiPSPv2YuCCgM5CgC0+K2sJttKmXecU+XAuf362ZKS4lrZPeNgofDFsfBnEEHeFMY8nKQWuDbcTkM+PH5jFAhhaoF6SwgKMnW57+vZat6LKV4hEc9Q2DCkai6k05nLCwAhm3QSRYfaYdZ4RKfWFtqCsYVJ1n72b/omOhtw8q6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541955; c=relaxed/simple;
	bh=9wq81MwoyRhLSycu0c16sOirgL767ksT7+VRYZLtU/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsijNUDhiebSpLC29Yy2mKQ7V2JDBAZt+X6Ih41RTcpw6jBnVGNp2A0RlUISuEXfyeWT4HioBJviuskJuHeA+Ll1OYP1T1NWQg5u1B43r6uyhkJvgwwV7bzMS4dpDZHDEP9tHeMBrAiul2GOmA0m+V+bxmRFhXBNUFTiUUKPpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=E2otPR2K; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="E2otPR2K"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so1901257a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789541951; x=1790146751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBbvtju1ayJ/ZgzK2DJpV4i9W4ld+ODJTWHqQe35pfU=;
        b=E2otPR2KeLOd9x8UszC816PaW8MqHXyBqQI+mydMP/BUFuFQd7fs7aWejaOtnVs7s7
         im79GQD59AlZj3JEDNTdjLEz+K9vz/33/aMJfZS5UOtRuAQrpCs2k3+3BJhZUE7wXF74
         u64Gt1rbrKm3bwpLtcpFwlqyjHPKfzQpOZ+d/7eKBKg1fzKEN1l6dm51ZOcG4wLgic6O
         fB1DU7CYV/VKXET8dxGRq7tGrHF8+JA5EMTVXRtE4ar+xjK1mXKk05iQgO6B82j4F+4Q
         ONxs6r969nGfJvuk6ceRQVQ7/e8yEQ3SpAUK5sV9vlJoBLfDC1DyS/VFsmwomGDBYc5m
         rRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541951; x=1790146751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBbvtju1ayJ/ZgzK2DJpV4i9W4ld+ODJTWHqQe35pfU=;
        b=Yxrbh4D2rYxMNv6JobkYdylNNqxkEllWVyexBBoEZ6ZwSpkMq89/fGVyqAwSamebgG
         QwQq63NjkXJ/aF4nhHSOIwMAHjXtVCvBcr87VbHgbjtHV+f0DGgdOV9bYrUXCaoyD5bg
         nNRBF4fCqAueGzpdLOjGzOAhiIyhwCwz/4EMGQtUGHLRz7BaFrGbuUx769uXA02ZYfLI
         FMGTIRdY99Ym2DgFM4lj3+tJZMnz3kfqDRoGewGCt6TDrO7gvoUkG2oyi+L7kjst/275
         dgz6i7XznPVV/YTrWYWC70rAFukvpr+CfLo7Cl914/8kYr1keotZZ0EQS9LxLmldGLxd
         0i0w==
X-Gm-Message-State: AFuF++nbCPyTbHwf2+09ztq+FkHnHK8iVsOTJEc0vaCfP2bZtTofzQR1
	gSr7Jct48Vpe6xQDoJPyGlW6O4tc3a/A84l/VD0ES9vP9YzQeHmU+23wHSrPfq+7D9hZhkTR2/d
	+/XHu4VJU5czZKPI0AgHl0gEBGnSGzapM3xpP3oz0G7iOaj+xrvg08Wfz3aVcWcQxNcuBNNtae3
	CKjRKM
X-Gm-Gg: AYBFou2hP1zGyExyvYgVi0KTwL5xTDZOai9TGuOMwxCdzD0f7tdebnw7chxSnQRV9gM
	uWWS91oG5nMTHCa7k4MuAwerB+iJJKW5oQOeQG4f1FDkk50oJywJvTJmg8vTdYi22cOePDwprBK
	WUvmtc3L6FIaoLMStaVU5ZWZHqombCuwHSCURP3QB6SGXcpDwRWRSX026Tg7T47yFmIK7mkLsWl
	l9hrzjEUhsnFct5BqUJ/0OBbJwXSfxrD05yewsao1fvsrwFngem7eQ4yU0+Ym2avWMxxAYENECf
	e9yGHBbpb0bBvUGNTPqLYgYqU5l3jd4GArA5uP0iIjIcc8Y7rTnZKsfF3isK2St4KzhhjNBX2Fj
	JIL+eUGzAo5bT2J+zQ+mdkkGaWgYyCLhLrx37fpdlIE2lU2OlhTNZMuMSHFxmXEIsicQUQAcTQb
	o8CjIulJR8CLnD7rg+Zb1SSqfSdSGaunRgRrOb6YkcZL4/tDa/6GmiS7Rmd2EIAsczLKCQzfo/W
	6fgdYAtWX6u
X-Received: by 2002:a05:6a20:918e:b0:3d3:b00a:7082 with SMTP id adf61e73a8af0-3dd5f7b25d9mr3693551637.28.1789541950844;
        Tue, 15 Sep 2026 23:59:10 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm5787959eec.14.2026.09.15.23.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:59:10 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2] openvswitch: raise internal port TSO limit
Date: Wed, 16 Sep 2026 14:58:44 +0800
Message-ID: <20260916065844.1380155-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the internal port TSO limit to GSO_MAX_SIZE (512 KB), as for
loopback and veth. This allows the admin/user to set a GSO limit up to
this value, to use BIG TCP for traffic routed through the internal port.

Only the capability limit changes: the IPv4 and IPv6 GSO and GRO limits
remain at 64 KiB until changed by the administrator.

Validation used a same-host test with a temporary OVS bridge, a veth pair,
and a network namespace:

  TCP client -> OVS internal -> OVS bridge -> veth -> TCP server

The veth endpoints were BIG TCP capable throughout the test, and only the
OVS internal port limits changed between 64 KiB and 524280 bytes. A single
iperf3 3.19 TCP flow, run separately over IPv4 and IPv6 with six
alternating runs per state (`-t 15 -O 5`, fixed CPU affinity and port
tuple), increased throughput by 18.1% for IPv4 and 34.7% for IPv6:

  protocol  BIG TCP off  BIG TCP on   CV off / on
  TCP/IPv4  65.567 Gbps  77.420 Gbps  1.12% / 0.37%
  TCP/IPv6  55.355 Gbps  74.568 Gbps  1.20% / 0.68%

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---

v2:
- add an empty line before netif_set_tso_max_size()
- rebase net-next/main
- cc all the maintainers
v1: https://lore.kernel.org/20260910131635.780802-1-wang.zhan@smartx.com/

---
 net/openvswitch/vport-internal_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 125d310871e93..77a16d5ebd543 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -117,6 +117,8 @@ static void do_setup(struct net_device *netdev)
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
 	netdev->hw_features = netdev->features;
 
+	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
+
 	eth_hw_addr_random(netdev);
 }
 

base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.47.3
