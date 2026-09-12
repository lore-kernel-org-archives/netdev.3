Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A30327204
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221039; cv=none; b=HsVLObi14NgaN3PsCG4uj/r7u8t7GmW21lLMvEZ4KK2QnkpwV5LXIXyiO+cUM4W36pgAgf9hICIhhcpXovMt92JOo98SJSygQQWt0QzoIr0Hw6yMf1/4q02pBFs+hdEUwPJNicx6r3PufDg0ks/Dt23QGd+lBuyTFyX6GFIQxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221039; c=relaxed/simple;
	bh=+1wQZPTinDQ05m6tnd+jN0uZ71x8nm6FHFC7WAcjCJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoBahWmmYfd4MVUqzd9pzmvin9RIDnzJ8+vbSkZ25r96KnbhMp9sUKdsGsyvpdtwS6eSHirM7N0horQya4D45SyuKrhnr4C6TA9tEt07mS/Y0K3xgxekkVmN1I9xbNlOaAXjc5G1hcj3lVRkMh9YE+5q4QSlaq3KLWCr1z6NYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsVBvRjn; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsVBvRjn"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b7be8dbabfso379806e87.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789221036; x=1789825836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
        b=CsVBvRjnM70hWtB/xyQb5SQepTFUj4ccJDLHpwa7Ai4plLa06pNMxc3WAId1bKlrrE
         F7ftNV0BkFaA/soNsDqeI0a5yW53MEVn1oMc1PHIXSVZfdPzkzMo/MoT4GmdyS0KkG5S
         TWgZPgTmFCuZ4h8EUwa4D4/r/80Nz0JclxePgVIPuLyXUZjbxUh77Cf859bx880E5Zgf
         15FTMKi3+uhkhsPguaXMtdCqVxa4UF/zrTawPnTUeIjxpUMnZ9C1z18xgSQqcQa1m9mP
         g/ML40Uft4cs2QSjSceKGvRj2FlFgKBeayMoG+4n6rM/BrwR03GrRG+UR+id8SGWUaSx
         IIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789221036; x=1789825836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
        b=GY6VqA1dZZi6dCwj7eosb4OJOYvOS94+gtxfnAZb7JEEIxysTD2CmeyqaK7MfXBGsr
         xXAVGO3tAyDeOQ9UR7Ozdc+MNH7zdPmYWgbgJy7MPOMfzEL125/TYn1EAVO0pW4K+ftZ
         8zO9+JjWoHOlGkwmlZh+OwHAwk9waRyHjaFJD3OlEGWMqUoSff9V40OWym9O1ArS3VlO
         OxquZziZFHi/wzVZ4hRuu53E5ITOW2GXDWQMF0lWxm4LW57xA18fNMW/Tnq3RxcDdjAc
         kYHtnPd/RoSAyJt4oF0CsQy0nICMUZc/+4DxzXlQ5aWYWWFJ4G4alIOCRrAwSBtz5YNH
         x8Bw==
X-Gm-Message-State: AFuF++lXlMpH4udJiHjOoAm3gxiFt9tThwcY4Z8ovxl0qh5GvPDdxw+Y
	NaggI2+5Jx7qZ8NyZqhtqzgQaldXZLoqgQgVJdUB8XIPTVwQklgfiYN3RSfgOhj0zgc=
X-Gm-Gg: AYBFou1UJDPr4AuvRSwiFtV30Hm+0rdt6C6M1tTs6hWxtY0qePyOkMruAj1oReC56ha
	wQwMLJRgWcINVELsbJ3vaySzK2O68QB+iwJxSQA6BgePLG9KLQwJddIMOK0pxxUPB7muhqipufk
	6zJgNHW7pUb4/pqCjgvKZPGEyUtSngiodlkU+al/hmMhslHFv2MyerUOBASR6dzvH1gqceqULVj
	OJvNB+8+/vSYe9Q3gWJkYxj9LBOhK6OVsBdXNNFIFdwLIrcb1UUfz09EAfUQ2IX7Mhpca2qikSW
	czC/RQl5Vj00ESPZd8sC5c7zqtb6y5uCdwnpI7uK97Dajcm5ACZnWQK7Gw/xE8TI0eyIwVMImAR
	RKVg5z/VNpOU/qAZ/wZ4pNB9uv110fdtA2FoE+9BeRe3yHxIOeWQ6ICiCqrCyo6/r8yMTulBQ7G
	obiX6dE0qAZOOJB2Rvh4ylFwzcfy21BvOnU+7fqHSHmjNFf4FleHLHlLZhLGMDJznb/LazUT6GG
	kMsvPtezI8XjrddGuKFSN+AkBzdc+/ACIhoC9JXXLlgJlLlqaItZ/5dqOdn93X8HtBH
X-Received: by 2002:a05:6512:3e24:b0:5b2:e947:b3de with SMTP id 2adb3069b0e04-5b8a8ebe72emr404733e87.7.1789221035331;
        Sat, 12 Sep 2026 06:50:35 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:50:34 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v2 0/2] bridge: report an oversized IFLA_AF_SPEC nest instead of truncating
Date: Sat, 12 Sep 2026 16:50:20 +0300
Message-ID: <20260912135022.1701-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 clamped the VLAN lists to keep the nest under the u16 nla_len.
Nikolay asked for an explicit error for both RTM_GETLINK and
notifications, with the extack set by the bridge itself. So patch 1
plumbs extack through ndo_bridge_getlink() and patch 2 returns -E2BIG
and points userspace at RTM_GETVLAN.

v1: https://lore.kernel.org/netdev/20260906224246.21719-1-iprintercanon@gmail.com/


Artem Lytkin (2):
  rtnetlink: pass extack to ndo_bridge_getlink()
  net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest

 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  4 ++--
 drivers/net/ethernet/emulex/benet/be_main.c    |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c      |  6 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 drivers/s390/net/qeth_l2_main.c                |  4 ++--
 include/linux/netdevice.h                      |  5 +++--
 include/linux/rtnetlink.h                      |  3 ++-
 net/bridge/br_netlink.c                        | 16 ++++++++++++----
 net/bridge/br_private.h                        |  2 +-
 net/core/rtnetlink.c                           | 18 +++++++++++-------
 13 files changed, 50 insertions(+), 31 deletions(-)


base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
-- 
2.43.0

