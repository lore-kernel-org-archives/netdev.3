Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA1277007
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046209; cv=none; b=RuJHhzHvS4Ril4gWZpHoq7RTBMYls4mH48L36GTv69H7Q1vFR4F4iFa6aW7yTo9+BUabnOy4rohFIZEgxqrgcGnge67czErtv651gjQBVyETTjXykxsh5h5lI70jM3VE7ONRDYPsLKnVvY4FNIdKNkEJqbzI2U6JR8V+gXE03tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046209; c=relaxed/simple;
	bh=8dmLrkQSWjA+HdupLby7BDUY4fiO9EbW+QiRuNNZgwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpJEoGz/NvZeN+xQFIACV2Ssck71lU+XixUKhVAAtFfyt9fH8K+Dr5zHnrBkBg2ErRQN+grO1O+rGpVljkduPMdG7eLIAXYkp6xdJlgpeKVbHzLTlo4k/ajbs2qz032ugx/PIqpHajKgZ1sg7LPVMZyk6qot50YcUWTERFx4KGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=Vl6a/AVt; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="Vl6a/AVt"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6bc7a8b4802so3524245eaf.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789046205; x=1789651005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LAdayHOSBIRer9xQaXG45W8dr4Q42+UMBwG85mUIvCU=;
        b=Vl6a/AVt0+rQGdULNEHLlbnSq7VLWvs4dHYzKBGxvVY9N5Mfoy0JGAkASjt1vWFm6U
         CcB8ckRVBsHEZfOmbU1A8hQp4+aZOXwM2hp5ubva62UW2wWT/k1r9kW5UlXc+QSst8Tn
         PzL3WGuMzwzgj+yUmipH1Feq8PRfbSeMELmNweUP8c6Ug7n7F9LCAMTuOAZYSCnhgGcK
         cuV9eImuUxuX5+YXBEzY1pRFhlEFl5EDfWi1wJmxJ3Ab6zltu5BeBLt2yyFw1FkpYlPX
         mAjMIZqI+mCO7SLUbO3ItgYgWoMvZagTRvBSxnovOs6izRXaTg7FPd9CHK+jjuXe9Me/
         s58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789046205; x=1789651005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LAdayHOSBIRer9xQaXG45W8dr4Q42+UMBwG85mUIvCU=;
        b=Ec/OIzM3SlG6BO1mrz5dSd8xBEqyz9adiVbIFfjlD+HixLq0wYDc0nfd6LKkxJKuTj
         XtLFKio9A1WamTF6SrROFpL73Qb0h7dqSPtFsoepZJOIo2Sd5pxINqoM46JtSdOpxZWm
         0LdlQAnWDjT7DbawNDRuFL0a5rxgLNKq7B6TCTxBuvB953wVFBq/OoA+LUCL7W+3+IPM
         80RdybsxxBFTyzcBJfvD7zGDIC5doU40K0NoCL8tmJDw43iP7k2CotclH3p67+n5IW+6
         8N1BqHh4fEptXrenBPru15KTlcErI/C5upAaBhzmdVrF2K51fzobYZbrOBCiZkrR9+O9
         txuQ==
X-Gm-Message-State: AFuF++k4bz9fW0u2r9Rsd17S+IWVi+EpW6XJAIn4ZTdvM4W8Q3Mb+lki
	bXuIWdvUtb2cQEQonkVjTQ8NraD3hz9ITKsuWk9gUcqV91y5iu8ikvfvV3kWvTLWQpS5FsXfYMv
	mhypIfzog/jQfjiogXUncHoQO8oS+3cfMzIJV7WW1mafa8GnXw29m6aSJr5ZD7a/MT5qYa3NWHw
	rugw==
X-Gm-Gg: AYBFou1KqYYNH4+bljAp1zIoTwXxXUm933Aqn+6Yae2nyZxsPKbcxZGhmw4IXC5wA3I
	NwcRJfI9QpfQ/0Dv4o6CsSVdKBOK5ThMboPgbRVomsVlg1wkCzT2hilmpjufye1JE9wNINlaljI
	cpkVM+TLMG4agcWvxl+7kxgg8yGlyRxlxFBMMTGue5ZD1czKY+y+9eVBKypilBLIjUCNAeFLuD3
	MsmfvZUZQVwxf+cyVIxd5snlRMvdbNanXMskbiXa2K7ohBPpdvFAtoR7O1B0WVQdLxKcqLbTtYP
	i9+vZZNk0z4JNbTg1KXvEVoF0qG9LR7zfduRkDO6al1s92XrYNKEYUC0QV3AD7tfBJTeqboMSYp
	AEln3RsPqRov2tJdW2i7x3sl3yaFi6rRtKIez+6472zKWTNIFIuENMHHiW84QseJu6lo39JxVoM
	kGCykF96iiad3dPZviqYAr5tTQySJ3RjLS2RyqK/ZC5vmePzK2crWDNbExTsakYCc6r1BrdMPYk
	GkuocIVMdnv
X-Received: by 2002:a05:6820:4b8c:b0:6b7:83c5:fdf3 with SMTP id 006d021491bc7-6b783c603bfmr21974918eaf.52.1789046205098;
        Thu, 10 Sep 2026 06:16:45 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b9f68e4sm58032616eec.24.2026.09.10.06.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:16:44 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next] openvswitch: raise internal port TSO limit
Date: Thu, 10 Sep 2026 21:16:35 +0800
Message-ID: <20260910131635.780802-1-wang.zhan@smartx.com>
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
 net/openvswitch/vport-internal_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 125d310871e93..73f5184afba42 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -116,6 +116,7 @@ static void do_setup(struct net_device *netdev)
 	netdev->hw_enc_features = netdev->features;
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
 	netdev->hw_features = netdev->features;
+	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 
 	eth_hw_addr_random(netdev);
 }

base-commit: 211f2a875f6f447745d80d5762d6d614503ac84a
-- 
2.47.3

