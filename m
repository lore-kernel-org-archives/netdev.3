Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2D3822BB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867666; cv=none; b=hLAUFIuEGLpvRcuVVxDafGgWGN2oE4TwKR9Xm6b8+CdOngoz2tzxgqGpH139aB4lez3BGphEq1KVEBm0suuLG1YKK6jgQb6tokuydMQJxzgOCB8Uq6B56D9d4l/+TuxihFJ3VH5nDthaRBMdmSbqm19Jk3MiQv8/9W1DTc6uuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867666; c=relaxed/simple;
	bh=WWIR30hIWW19T7qrJDosGEVYAkY+1cLTLiDnzS/wuQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olSjJGyfnwDvlOtzb0QDECeK/Q7+gWkbYTTWM8YwU8gTyZb4YhX3wWQFwYoygQfDXuky9zQloRDznRj8+KyE9OYa4vaertd5ar9I17R2a1tNcVjj0q/iSG9gi5IkdWdKrHzyrSurZ9STIxghqDwU2g5SznSMsMMSlmOA+KXb5YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso335235e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867663; x=1786472463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qF/Zz53HizOpq6EgmE0sqdHtrYs1Go4WfBnkRhlxiAo=;
        b=gYFR670yHwH7amRbGkY/A6MwKVmCXejtS125e9zcZ0MvNQushgtAgm7Ufs4niGljVp
         PzmK+qF528qvjGAjgSX+5xP4NPmWknb71cYzP4EmcoxkEBQ1qgEYFleFqJjKBYzK1Ftv
         4o29zzKrPmGF6/Q6IPt5HdBNcfeML3T34YCkixK1a8WsBs/4hchBFIAltRpb9Di9wlLN
         PL8e9QysNyBW8nevwwSkN/4iG9r0WAqd6jO1sQec7hvrof8J2f3PBdgmP8gpDn0cKuLY
         wq2uWp8x9m00vsxMXUpkZvVdlk1AAhp6+AZXlf6AEAXnVIqEzXXB2FqhGizaFSD4xE82
         7E7A==
X-Gm-Message-State: AOJu0YzLwRVddo1Q8KA6TrbvizxK8EIOzoZ36rEs9ai05qZHkFy/6qVu
	ChaKFc3uOZAH+F3xJX6XxNlWE86bXbAe6itF+RSNB3SJr284L1vNhYia8USjJ54MeKA=
X-Gm-Gg: AR+sD12c7RPrTSW+KEMCcg8b1/N0yZ886Qikv72iFClVyscy6EQpz0jWcAkSoHE4AuP
	x22rI3IwBKrp0Dwh4/FQpYpeVd5PZKQ6RkZuhr7+HL0gdMxvnapQP8EgMylOB2sXpe5jZ88o3Hh
	kVLykfxEreFeXKQkWN3m0sjimD8WNTylFWXTRU/EPPFaKO8vHSTNC8OMKtmXCckrCcdea5/gnLB
	EJFnPdzYZ1wf9Byg3PSRuPf0OCu1zYgrK5u4+wN7BXYDUYc7R9IsUirEYDQ5CjyrKvcr9oNslG8
	RNUgsfm5Dcf/8foMV5VwvMtSErwZdnQHqktp5Fuy8AIHld+Nl3qEqbN8YEVFEFoY3u3TGRn/6sj
	HAoaaSK2hqpJjSgoXA11EtILu7twSCxzkEHurqcMTDXUgJiGPm5VwqDZLWGWFmS1pEMtKI5bc2z
	5/3nJSVSnAajsNJcHL7xWBTUPfz1BIBn/tzwm6Z6lSgGQenURymLrVw9gPSr4PqP8baAz3QEK+b
	op/RnqH7A9vIe/O95BnaGaZOjYLXKDNmL1h+p17
X-Received: by 2002:a05:600c:1d0a:b0:495:78af:78e5 with SMTP id 5b1f17b1804b1-4994e70de03mr3821405e9.1.1785867662779;
        Tue, 04 Aug 2026 11:21:02 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf5c1sm4946925e9.2.2026.08.04.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:21:02 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 0/6] openvswitch: remove support for legacy tunnel ports
Date: Tue,  4 Aug 2026 20:20:34 +0200
Message-ID: <20260804182049.2289754-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs-vswitchd doesn't use OVS_VPORT_TYPE_GRE/VXLAN/GENEVE with the
Linux kernel module since adding support for standard tunnel devices
with COLLECT_METADATA back in 2017.  The code to use them was only
activated as a fallback for old kernels, so not used in practice.  And
it is now fully removed in the upcoming OVS 4.0 release.

Modern way to use tunnels with OVS is to create standard tunnel ports
with RTM_NEWLINK + COLLECT_METADATA and add them as OVS_VPORT_TYPE_NETDEV.

Device reference management and the netlink options parsing for these
legacy port types is complicated and was a CVE magnet in the previous
release cycles.  Existence of these modules also makes locking analysis
for geneve module and other core tunnel devices unnecessarily more
complicated, especially in light of migration to per-netns locking:
  https://lore.kernel.org/r/CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com

Since there are no actual users for these port types for a very long
time, let's just remove the support entirely.  There is no practical
reason to run OVS from 2017 on a recent kernel.

While it's technically a uAPI change in some sense, from the user's
perspective this removal looks indistinguishable from the kernel built
with CONFIG_OPENVSWITCH_GENEVE/VXLAN/GRE disabled.  And it seems like
removal of unused drivers/modules is not a rare event these days.


There are 3 parts to this set:

1. The first patch does the tunnel port removal, which is the primary
   goal here.

2. Patches 2 and 3 remove extra infrastructure that is no longer in
   use by anything inside the openvswitch module.

3. Patches 4-6 remove functions from gre/vxlan/geneve modules that
   were added for openvswitch in the past to support the tunnel types.
   openvswitch is the only in-tree consumer of these functions.


Version 1:
 - Rebased.
 - Removed the tunnel modules from the new OVS selftest config.
 - Addressed RFC review from Sashiko:
   * Made ovs_netdev_link() static.
   * Restored -EOPNOTSUPP if OVS_VPORT_ATTR_OPTIONS was provided.
   * Removed retry in ovs_vport_cmd_new() as not needed anymore.

RFC:
 - https://lore.kernel.org/r/20260513183559.2141010-1-i.maximets@ovn.org

Ilya Maximets (6):
  openvswitch: remove support for legacy tunnel types
  openvswitch: vport: remove infrastructure for vport options
  openvswitch: vport: remove infrastructure for separate modules
  net: geneve: remove unused geneve_dev_create_fb
  net: gre: remove unused gretap_fb_dev_create
  net: vxlan: remove unused vxlan_dev_create

 drivers/net/geneve.c                          |  49 -----
 drivers/net/vxlan/vxlan_core.c                |  42 +----
 include/net/geneve.h                          |   5 -
 include/net/gre.h                             |   2 -
 include/net/vxlan.h                           |   3 -
 include/uapi/linux/openvswitch.h              |  31 +++-
 net/ipv4/ip_gre.c                             |  47 -----
 net/openvswitch/Kconfig                       |  35 ----
 net/openvswitch/Makefile                      |   4 -
 net/openvswitch/datapath.c                    |  28 +--
 net/openvswitch/vport-geneve.c                | 143 ---------------
 net/openvswitch/vport-gre.c                   | 106 -----------
 net/openvswitch/vport-netdev.c                |  29 +--
 net/openvswitch/vport-netdev.h                |   2 -
 net/openvswitch/vport-vxlan.c                 | 172 ------------------
 net/openvswitch/vport.c                       |  79 +-------
 net/openvswitch/vport.h                       |  23 +--
 tools/testing/selftests/net/config            |   3 -
 .../testing/selftests/net/openvswitch/config  |   3 -
 .../selftests/net/openvswitch/openvswitch.sh  |  38 ----
 .../selftests/net/openvswitch/ovs-dpctl.py    |  93 +++-------
 21 files changed, 63 insertions(+), 874 deletions(-)
 delete mode 100644 net/openvswitch/vport-geneve.c
 delete mode 100644 net/openvswitch/vport-gre.c
 delete mode 100644 net/openvswitch/vport-vxlan.c

-- 
2.55.0

