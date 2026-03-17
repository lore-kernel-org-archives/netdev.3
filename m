Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30718872A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791351; cv=none; b=W76J79uYraramMQqY7goqDq4QMWtTVJo+slXTHjagBhlSFNxzeXcuSZtXowzZVjKSQiEmf5DWkZzzCwO7Hy7475w4LNSzv++EVvGns1xvXdnnZoRauD3OvaCopQVseGEhv1p7Z6q4YJgocg4x+wkmz6E6ydS3SsYHDCgpOud85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791351; c=relaxed/simple;
	bh=iCfLStrJ5xU284gWT1jqtFYszhwO+cBqLM0F0D4bPPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iusnwIPsyWuxcGdy2Q+gKOI3Dsmi2th0ms3WI9Ae+q/DcFlnJZ6FZJvUAXyxBjrEAtGkJ/DtcnMp+EFqhy4OjlDhslV+m/YO8KdywO0+rj3WPzdIhCRsTp+dy4qVKt4u7mT6NRuQ/41IbGNLjsHxwsBSDH1Pbu48ccuhs+dFCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVUkoI9j; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVUkoI9j"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso890207f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791348; x=1774396148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OksVYoK/qo2obFncaGvvPyNkyaBlPz61UvAGQYizmo=;
        b=JVUkoI9jsmPGnwxrXaCVzIQ+vqIeFu5u7ni+byw7CP4EEt90c9hVJ81s3lRoYbTFmD
         Jo8NVRkx34WtOStMrJOkb5YaSRyk18owi8nZl9YoulrEGIVrfhNKWUrDmNJgbUAnbzzN
         Kf6QtDvdSc/J3lq+B8LDFiv23FdHRWA4QVIFB0wXW/QOKej45XMxmpXodiz9NUhRyjxK
         2q13Ib7obxi70kWTwk6/kSPu2Sb6eSobW8wr3UZ7Eu+ZUvrL7BipXBU1mlz6ZWFVLR89
         h2h433cyqars7PSp7rK1AV/9AHj39igZtK8dj3EGtcj/UMaErmupZVn9BgWFp3/lMw5z
         6OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791348; x=1774396148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OksVYoK/qo2obFncaGvvPyNkyaBlPz61UvAGQYizmo=;
        b=fh031iSSnV6RXR5Tip5Ej1C3WobrwFjJcqIn8r7Y8Cxx2KlNJKzI19dojv8GO9cotW
         GkcwZ4JYdobtnV+0hAQArhNbqEfPg/MzCvmxfD/y00iCOSDtahhxSv1g+xyeVOEnlg6n
         oEgIrR5/dCvFzAIOKoX6co6VwdPz4oGae0y6ZSM4X/AmJljIG0nf2BeMKjv/tMYPShL5
         C3SqbYi98SeGysgB6E0P2B4nWGvCnB4Lb1MsLtyVTHRogR0GnRbDz+Vx2wghgkTv5tXe
         9qeiBF9DFsjswvPzvVEHNhxZOer95/qC0/FvLFG7FG2bOlB6xAeBI1MtY3yetFCjrYVR
         0wzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgLCvNpsdYZCLSPN2Hq058TJsBllp2QMhs9f7Lh50Ca8NWp/wsguPteUR/R+nV3Ki95LoWGB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWgtzwfqE0Spbb4NZsxK31lkDoQ97quTBCUDZ4M0eSvuw3QCT
	pV6vsrqDlDT4wmRN/o8pHfzBGPNSHzy/KcLer9vrMfdbHkAdt2np+HVgcrZCND8SqlbGxw==
X-Gm-Gg: ATEYQzzzsxufBlux4mGd7P4XqmbFXy5oGTujFDu/XGU1TeszPrNR1a3eP7ipcnfXSWK
	6IszjGKruOj0oQ71u3R4Gq6WZSEG5v/8TQ86gjsPw58h36AbG7jk4k/tcLiNCEMXPWvED22zjWr
	z2Mh6kFOFVjHYj0zA86k9yNNlBtK6SsJ2OF7adCjAI5KUkrpiGxPP3RU3i+Z1kL+1SMhgMrQorR
	fLk4HaK72+zOxNL0tKR+oc3CwnQwNAx7kT6CRmVjZA/qX2s0AJdhXo8n5vBWIp4L40iwqGkqifW
	KrIpfU94cwTlwLRZ525XOeoPwXZGNfFzVGSnHu168jUceR5ilhigxmqmvLSFgBBBtb8a1gfmClu
	LtuW8tZI4xYmIY/Oauue27dr9g1xnWxZoi8S+/r1PK+Re5hLTxD2waHx2asvDpJbvbTo8CnkMY8
	MzzFHmKSjjv1cZud3oNU/C
X-Received: by 2002:a05:6000:144a:b0:43b:5097:6f60 with SMTP id ffacd0b85a97d-43b527c5490mr1734002f8f.32.1773791348062;
        Tue, 17 Mar 2026 16:49:08 -0700 (PDT)
Received: from azaki-desk1.. ([41.234.201.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a3d78sm3279810f8f.34.2026.03.17.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:49:07 -0700 (PDT)
From: Ahmed Zaki <anzaki@gmail.com>
To: netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	fw@strlen.de
Cc: coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf-next 0/2] Update netdev stats with offloaded flows
Date: Tue, 17 Mar 2026 17:48:49 -0600
Message-ID: <20260317234851.234466-1-anzaki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's allow SNMP-based tools to accurately report the Tx/Rx stats
on devices implementing hardware flow offloads. Without this, its is very
confusing since these devices are reporting very-low stats compared to
others that do not do hardware-offloading.

First patch is prep work, change the prototype of dev_sw_netstats_rx_add()
to pass "packets" instead of the implied "1". Second patch updates the
netdev stats.

Ahmed Zaki (2):
  net: treewide: pass number of pkts to dev_sw_netstats_rx_add()
  netfilter: flowtable: update netdev stats with HW_OFFLOAD flows

 drivers/infiniband/hw/hfi1/driver.c           |  2 +-
 drivers/net/amt.c                             |  6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c |  2 +-
 drivers/net/ethernet/litex/litex_liteeth.c    |  2 +-
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 .../net/ethernet/realtek/rtase/rtase_main.c   |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  6 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  4 +-
 drivers/net/gtp.c                             |  2 +-
 drivers/net/macsec.c                          |  2 +-
 drivers/net/netkit.c                          |  2 +-
 drivers/net/ppp/ppp_generic.c                 |  2 +-
 drivers/net/tun.c                             |  8 +--
 drivers/net/usb/qmi_wwan.c                    |  2 +-
 drivers/net/wireguard/receive.c               |  2 +-
 .../quantenna/qtnfmac/pcie/pearl_pcie.c       |  2 +-
 .../quantenna/qtnfmac/pcie/topaz_pcie.c       |  2 +-
 include/linux/netdevice.h                     |  6 +-
 net/bridge/br_input.c                         |  2 +-
 net/core/filter.c                             |  2 +-
 net/dsa/tag.c                                 |  2 +-
 net/ipv4/ip_tunnel.c                          |  2 +-
 net/ipv4/ip_vti.c                             |  2 +-
 net/ipv6/ip6_tunnel.c                         |  2 +-
 net/ipv6/ip6_vti.c                            |  2 +-
 net/ipv6/sit.c                                |  2 +-
 net/mac80211/rx.c                             |  8 +--
 net/netfilter/nf_flow_table_offload.c         | 59 +++++++++++++++++--
 net/openvswitch/vport-internal_dev.c          |  2 +-
 net/xfrm/xfrm_interface_core.c                |  2 +-
 30 files changed, 96 insertions(+), 47 deletions(-)

-- 
2.43.0

