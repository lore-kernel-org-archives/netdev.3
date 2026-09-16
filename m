Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A134F30D7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555660; cv=none; b=I4LlW+94jVFdr+lF7HpyJh7TGjFZFQ9euuUfRU+I6B7xAqON2mILLJ9A1ybqp4y48GRMAM7T+X06oZbnt2jxZVBGSNem8iYovtv6+nQWbtrPvoFxlEFGM/SvT/pUOm/VJVaDL0X/CN/qicZ5QUdz65+0lSl7JesLGxEKt36wRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555660; c=relaxed/simple;
	bh=xO4Ye3Kb+aF8jHJKhwl9thFS88soQTJGHMhLWCyetJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUSl0jKdU1CtaIqYXiIPK6Hdq4lOgVo0zPluU3RzYtDT/vS5ymhiJWhkssJpCJbpl7D5fv7mKPpaVLGx2MkgKs2XTYXreGP2FWsEbyj1s8V/PmEc9S5/FeaILjUEhQNLeXTYNmdQrbLUanKSCXtvIT5v2YApQNxoYy4yavgQ6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbLQ46LV; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbLQ46LV"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c254f6c7a56so117376766b.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789555637; x=1790160437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=klNfxXZAaPvJqVeXEVX91F2Fi7Jln9bXFs4g5uD90L4=;
        b=DbLQ46LVq2SLt4mZvudUAP5RZJpd6SpIGO9SBIGeNDU0CLkKwp2ilNyUv1cZx0Y0go
         X095d4WWt589pnOmgtOAVSAcE7zQPYPkfGT76+plfEnqjtHOKJWJXEZJmhogBxEwBtu+
         xMcduVO9zfEzJo+st6+eS9tMgnvqUASyKO1LBw+fHoC5ypeIQwCT27PWx1LPODmgqrAr
         CLt/DtjpXIqIhYkl2g58Oa4sOqQAJ7mQs1AfOEQABSV3yYjzH0rKCKB8fqMTNZj4/8eB
         0wJ9LKoC1C0GSVUPYDHPskFeOUIIl85L1Zs9ZZF1HGYn2IiSc22wK/TaAU/yStP0f155
         oKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789555637; x=1790160437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=klNfxXZAaPvJqVeXEVX91F2Fi7Jln9bXFs4g5uD90L4=;
        b=KMmxLygQWGx49YQnKYcmdw7hOO34KJ5+0EAQhe7EoE81ByjKd4wkzUBKiTbS3ou92q
         VuEM/bNnwuitH8taY3QXWcEupBapCDvgPfuH4Wcy/aIvt3V8+gLOOrmsnE8Hdlzs7UaK
         Y/el2A59eSPETWBeiLApOWrrUWT2DaCU5NZYCYQSZyHx75H8K1IHxaE61h67wn57+dsS
         eFyzMDDDE1FvPMHv+uj85QO7clmvgdMtgir+k6be8r4HAtp17ShA7qeK3BFu1uhICQhy
         twrc9I32GgfwvlyhXrl6ty8dY+VMbXR0hLtLr8kX11CgJCrUQtCy7Z/hGYQCza3Ixud1
         iZtw==
X-Forwarded-Encrypted: i=1; AKwUvBx99IXgiYYe10v514yyRUf562+yr2y1hEBdhIFFk5/DTBEAx0O+zVGgIW8Ycuqsc4D1FCCdHaU=@vger.kernel.org
X-Gm-Message-State: AFuF++mSFZ2b2CBM63CTa17mFqS2CCiDxKgp4mf3udrQDWtHgit8C4QR
	il4jUmMh4+EAY5ruGSFD6mRFQMc8ke9rgwJyqSjKYa6+LZxaMjPaxg2uyHxOet9xDyc=
X-Gm-Gg: AYBFou0o7+hj8Xsu46qgGJ8sQCOr9YECI9jz/JP2ZC7JQsuAOb46+9WF2fCEWTVlrDO
	3Q/UIsSYloHIdnxZdoAPFsll0qSSTVdhMMTy2Up/eN8TUQrsLt1X7t2QynJCu4UsjAL/XB4er9+
	ZdGixAMypWUfHuovpuzmBFa1x6avNXyYFFuowl2j9OLcIe3TmqvR49iEfJLpitfRYhU1jozf6X7
	0OHX6w851XAYIMJcxCOL164WV+jdN/4ZKCCrZuFfpC/gj6zgRhDu43asY2vBOPGKgx4rmepRm69
	q+WrRp+pLil07VKiq1ghpOK0Fl5V4j8NjRHibWUUeuy622zn/8Q4NmzrSPNMQ5KNXvvVo2plvzM
	594Lxhc4V987e+f6w6e1USqExBVCcWOLRDldTmCmB6IEKFm+KgpWrL+N9vGwqKdmZ/N+XQhiAH7
	YKoZEfwONqkfDeJ+XyHxQSW73HlQlpiyn7+zGLqc86cEn0xWGcl3ZM3jFeaBOdyZ3e3DuuY73pP
	0YzVrLc7aMQrrqaTPypZ1KGvmF2I7hPLiNSTuU8RuV4vWn7Lp9Jdd8R
X-Received: by 2002:a17:906:eec6:b0:c25:8c74:71ea with SMTP id a640c23a62f3a-c29e51dbf30mr152044466b.4.1789555636358;
        Wed, 16 Sep 2026 03:47:16 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100c:994b:30b9:46d9:46de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0851ebsm108520266b.4.2026.09.16.03.47.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 03:47:15 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bsoares.it@gmail.com>
Subject: [PATCH net v3 0/2] net/mlx5: Bridge, fix remaining switchdev ownership gaps on merged eswitch
Date: Wed, 16 Sep 2026 11:46:52 +0100
Message-ID: <20260916104654.31901-1-bsoares.it@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 of "net/mlx5: Bridge, don't fail switchdev events of sibling
eswitch ports" (5f324c5d1b12), addressing review comments on v1/v2:

 - Patch 1 fixes the switchdev port-object/attribute notifier filter
   (the original fix), and now also covers the LAG bond lower-device
   walk used by attribute changes on a bonded uplink
   (mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get()), which had the
   same ownership gap: it returned the first structurally-eligible
   rep found while walking the bond's lower devices, without checking
   it's tracked by the calling instance's br_offloads. Since lower
   devices are appended in enslavement order, on a merged-eswitch HCA
   with a bond spanning reps of more than one eswitch instance, this
   could cause a bridge attribute change (ageing time, vlan filtering/
   protocol, mcast) to silently no-op on the correct instance. These
   two were squashed into one commit per review.
 - Patch 2 addresses the reviewer's comment asking whether the peer
   unlink path also needed changes: mlx5_esw_bridge_vport_peer_unlink()
   lacked the merged_eswitch capability guard that peer_link() already
   has, and mlx5_esw_bridge_vport_unlink() itself returned -EINVAL
   rather than treating an already-absent/untracked port as a no-op,
   which is reachable on a duplicate NETDEV_CHANGEUPPER unlink.

Tested Patch 1 on a ConnectX-7 NIC (MT2910) on my single NIC system.
Patch 2 requires a multiple eswitch instance setup, so I wasn't able
to exercise its code paths.

Note: v1/v2 were sent From/Signed-off-by bersoare@isovalent.com; v3
is sent from my personal address (bsoares.it@gmail.com) instead, for
unrelated mail delivery reasons. Same author, same person.

Bernardo Soares (2):
  net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
  net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer
    ports

 .../mellanox/mlx5/core/en/rep/bridge.c        | 45 +++++++++++++++----
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 15 +++++--
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 +
 3 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.43.0

