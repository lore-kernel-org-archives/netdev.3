Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932636074D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128811; cv=none; b=SazlctsvazFWntWC4w1OvGUsD2c+UfRekQ8Xk01+zU7Vsp5vQWQ/70FP7YIe1YG6F6hLqX62EP9OBrD/Dh3zuxHjcvn6Vlgsc9aIeAM6xyi4wKH3gIz7+dlngoR4RpnFSUymPb/a+BnnWZH96zlfnZ/ie1zx/sUvzOUcZNWhYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128811; c=relaxed/simple;
	bh=y5XzetB4YEUxDGYWaox1//ktFSCOhbUw8j0VGPuKSo4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jFEGNHu0YACNYsl8DdVqg8T5vj/xvbJpQurh41QDe/XTyB1rXRiSjUPHBrmbfaIh1+w2NxRo52kT88J+pmornW0L90T6bTKUkpku3meajRuDNAtx8Rf4GXKvCODqhHhYLzw/7zjFY9PjRZqVF8zHTAe0EkU2EzPwKsk/xXA8XHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmoOM9lE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmoOM9lE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so11413083a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773128808; x=1773733608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWYg+gxn/dmjCA3qJdokJ8/AsXnstVtMxLRaCKRYAgQ=;
        b=CmoOM9lE+untzzWgh5stx3+lDb+MAdGAWFGlW7vLKcrVQtRB7bgx0Z/h69S7f1iqHD
         1fRtZuD4lx83SompoMNGJXf4cs5yFAmtrfe18IT9KvSDTj1CtxiT2NG7US3hvQcartCj
         K0fjaU8b/+gdihS5eqDti8PYX5gj5PWpv0cUZsS1KNGub5KRAIg7MlUH4qtmFqlziVvA
         iIczFklh9pgw9IbSECMb3xan7opREiirflRrGJd4sdfuz9WgMA6OUbNzxOFXT3E8aHHk
         lcHLK5VRrrCemNhZx813fhvmVgsUyJaDEsvCJkMRbcLa1qIrtRRSxyVglVKxveeXi1cu
         jlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128808; x=1773733608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWYg+gxn/dmjCA3qJdokJ8/AsXnstVtMxLRaCKRYAgQ=;
        b=IYq9IF1eNt6tkeEwgMgb6NTiTXUTT/VuHt1mA87+EepJSAooBiQ9J8lgmI5x/wcNzW
         ILDXoZzNm6gPs5rBh7xWAQ/OTiG21nL2T1Zn1MfPpqnU+zyCyS+tHOF5dbeHsVP4mWAU
         ieC38BKJhM9l+VPDAhudxogF7hEzqm4Zxmv8aqO/SV017AAokdu5oR3wBYLJTn2ruWOs
         ZTjI9q2PhVG63+0ujD6EUjYc1pp+qcDnACR0dxAC0RrLB8YKcC9Ry8tTho9SDa5adbyX
         ganVvrslbFiYEEu88N3nv+zb5S3lEox8MUlWCDeq6vxycRX0TbzbRdoam9MWj18lD1B1
         jckg==
X-Gm-Message-State: AOJu0Yya4TGCAnfmDkAL3b2XuS+fQzfrgpUmrlXj9TOyZH+FKPH2m4f0
	Bw1PIxzztwmtYBOLZoqRTTjW7fLr0FHAeI+aEy9KYaA2WSa0xcOGaGJF
X-Gm-Gg: ATEYQzzhvnOakxQn1BDJaFK3absPqpehPSjRopSt8EZ/ZCW+uakrMXi/HVDQdtGO64B
	JCjrXT4YoeiqwsHgmzISY8G4s1iHG+Xg2Sa5rEaIuny3Zu7UaAYLVE7erlDj7BkHMGf0w7X8idU
	VmAQkeMW8jv++V5j+EdxgUBL9atmzvOxGwpZQ2Ju5bYIaLLuhOOuwYM+yi/VW51naAcKqxBSNL7
	/iB4mDppsfrDK9e9bVhfCP+EZWaFPtfYeAiXDJ+udcwN2Zj5P5rs/evaHRvq+227Sc/NPLI0z3k
	mYJ1mJLbPMSgL222GjVD/4Pw7Wvq8MzxZxfI5LG77cRn/asCrC/5xzAWQUvkirRE5BFh6BuhYg6
	MoJqhnak7b4KNx5yYRMkkiSmQOET7932vhO7J5E18b3tRaamuCDZaxHi+3O0pw3mUNRXZuA+1E8
	sEy15KVXRoovrl1uOKycy//dk2gTsdnLwYEr0NHFxUqTgyPgfAKx3QGx02BVugrR+8sxyKHl8wv
	Q7liNqko68zAe2LrzLF4QaAmbkoVoyuwNfuyANvaLOi3Xuk1cetrg==
X-Received: by 2002:a17:90b:1e4d:b0:359:8230:abcc with SMTP id 98e67ed59e1d1-359be275fdemr13516086a91.8.1773128807946;
        Tue, 10 Mar 2026 00:46:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7ef38csm7260607a91.2.2026.03.10.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:46:47 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/3] net: move
 netdev_compute_master_upper_features to ndo_set_features
Date: Tue, 10 Mar 2026 15:45:04 +0800
Message-Id: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrA2Mo3TRq4hIGv+0A20iSSyCe
 HeDy2/x3kEZSZHp2RyU8NesMVR0bUPuY8MbRpdqEpYH9x2b6P032mV28bduBWZw/LLeCliEarU
 meN3v40gBxQTshabzvABf+ipoawAAAA==
X-Change-ID: 20260310-offload_compute-4c0bafa2e022
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

Currently, master devices (bonding, bridge, team) manually call
netdev_compute_master_upper_features() scattered throughout their port
add/remove operations. This approach requires each driver to remember
to update features at the right times and leads to code duplication.

The series moves netdev_compute_master_upper_features() to callback
ndo_set_features so that the offload compute could automatically
invoked during feature updates when upper/lower device relationships
change. This centralizes the feature computation flow and removes the
burden from individual drivers.

---
Hangbin Liu (3):
      net: use ndo_set_features to set offload features for bonding/bridge/team
      failover: use ndo_set_features for failover offload compute
      net: no need to disable LRO specifically

 drivers/net/bonding/bond_main.c | 14 +++++----
 drivers/net/net_failover.c      | 67 +++++------------------------------------
 drivers/net/team/team_core.c    | 15 ++++-----
 include/net/net_failover.h      |  7 -----
 net/8021q/vlan.c                |  2 --
 net/bridge/br_device.c          |  7 +++++
 net/bridge/br_if.c              |  6 ----
 net/core/dev.c                  |  8 +++--
 net/hsr/hsr_slave.c             |  1 -
 9 files changed, 37 insertions(+), 90 deletions(-)
---
base-commit: 52ede1bce557c66309f41ac29dd190be23ca9129
change-id: 20260310-offload_compute-4c0bafa2e022

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>

