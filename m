Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43A3A9605;
	Mon, 28 Sep 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622488; cv=none; b=XuIPRIQ/3eJwZQhAiyw4se2rh4ten8PmkkAK6XLgqtH62qiWOiLJDJRA+MSr8W6dACP04X5vAyhbvwAfeAjLbMHRg54YdVvP1lLJylEwG0yve8buHTTsuGHDjFIbWDaOLhpT+yrg7G0/i2pLfc8l/vcvHGsKYyDCx8cm2Uf/DrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622488; c=relaxed/simple;
	bh=n1L0t9YaNbEb3fLZ5EzYnIZaqNJEtxNOE+CQtQx/3Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPM/+4m/kXC5fBqXQwMUNFyYAFTA8XqVFUVhlsJqWKnGOxn1A/Eanm4mRR931Al5v3xsTpnmV9DfCCXh3+zkvTVqUNjkGgcM3YLMG+CffhG9Ew5HA2MWVBvbOYsrd2Oat0Ms4sGQPjhFLZmObjbuLPXIZY9wYG3Uape3zPIzsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwu5S6WW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwu5S6WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69401F000FF;
	Mon, 28 Sep 2026 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790622487;
	bh=B+Gr6o68jYNXKTjU7HFcPEY3iLy6xBGj6TmsxZtZTlM=;
	h=From:To:Cc:Subject:Date;
	b=Mwu5S6WWtg+g6OrlwFK/D8KGxXM3w+wC/o5WrrhMWxS2gCepIaFbcilvZPmxc5/96
	 5BvGfnSDfZZl865KTDCX23vB/sH7Z1cgDjl05Vpw0pikWx5bq73oeZFTWFRrfPQtRY
	 xjjDGOU0N9zfOhnywgb2xXEvEVHarKuwni9Nsoa0U2m2xA4UgXDmVzPJwIQe9W3Q87
	 bKrkQe4Rv0eQY0Qaixajj8Tr2qNeV0XAR9ETCPWLYcFqjG04HKPdlqYFaQM99T4XqW
	 wqdPsPqNPBemhYfQ9UJci1vY5U+TumPOWNSjcEANjwmjdbyO7PGiSqQxh6EpjOokEx
	 mkuHaxwv/OILg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	deller@gmx.de,
	razor@blackwall.org,
	idosch@nvidia.com,
	aconole@redhat.com,
	ardb@kernel.org,
	tim.bird@sony.com,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] net: move the type 2 sockets out of tree
Date: Mon, 28 Sep 2026 12:07:57 -0700
Message-ID: <20260928190800.2521749-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLC2 sockets are admin-only already. We have been getting a trickle
of LLM-driven fixes for these, even tho we don't know of any active
user. The code is so bad the LLM fixes just turn into a never ending
stream of revisions and follow ups as fixing one condition reveals
5 more bugs. Let's move this code out of tree.

The series itself is LLM generated, the LLM was also nice enough
to generates some tests and validate that the OOT module actually
works.

Jakub Kicinski (3):
  llc: move the type 2 sockets out of tree
  llc: strip the leftovers of the llc2 removal
  net: drop unused LLC-related includes

 net/llc/Kconfig                             |    7 -
 net/llc/Makefile                            |   10 +-
 include/linux/llc.h                         |    5 -
 include/net/llc.h                           |  108 +-
 include/net/llc_c_ac.h                      |  180 -
 include/net/llc_c_ev.h                      |  217 -
 include/net/llc_c_st.h                      |   46 -
 include/net/llc_conn.h                      |  114 -
 include/net/llc_if.h                        |   63 -
 include/net/llc_pdu.h                       |  379 +-
 include/net/llc_s_ac.h                      |   35 -
 include/net/llc_s_ev.h                      |   61 -
 include/net/llc_s_st.h                      |   32 -
 include/net/llc_sap.h                       |   26 -
 net/802/garp.c                              |    4 +-
 net/802/psnap.c                             |    2 +-
 net/bridge/br.c                             |    2 -
 net/bridge/br_stp_bpdu.c                    |    3 +-
 net/llc/af_llc.c                            | 1304 -----
 net/llc/llc_c_ac.c                          | 1448 ------
 net/llc/llc_c_ev.c                          |  742 ---
 net/llc/llc_c_st.c                          | 4940 -------------------
 net/llc/llc_conn.c                          | 1025 ----
 net/llc/llc_core.c                          |   28 +-
 net/llc/llc_if.c                            |  151 -
 net/llc/llc_input.c                         |  128 +-
 net/llc/llc_output.c                        |    3 +-
 net/llc/llc_pdu.c                           |  366 --
 net/llc/llc_proc.c                          |  245 -
 net/llc/llc_s_ac.c                          |  220 -
 net/llc/llc_s_ev.c                          |  109 -
 net/llc/llc_s_st.c                          |  177 -
 net/llc/llc_sap.c                           |  437 --
 net/llc/llc_station.c                       |  120 -
 net/llc/sysctl_net_llc.c                    |   71 -
 net/openvswitch/flow.c                      |    1 -
 net/openvswitch/flow_netlink.c              |    2 -
 net/openvswitch/flow_table.c                |    2 -
 net/openvswitch/vport-netdev.c              |    1 -
 arch/loongarch/configs/loongson32_defconfig |    1 -
 arch/loongarch/configs/loongson64_defconfig |    1 -
 arch/mips/configs/gpr_defconfig             |    1 -
 arch/mips/configs/mtx1_defconfig            |    1 -
 arch/mips/configs/rb532_defconfig           |    1 -
 arch/parisc/configs/generic-32bit_defconfig |    1 -
 45 files changed, 33 insertions(+), 12787 deletions(-)
 delete mode 100644 include/net/llc_c_ac.h
 delete mode 100644 include/net/llc_c_ev.h
 delete mode 100644 include/net/llc_c_st.h
 delete mode 100644 include/net/llc_conn.h
 delete mode 100644 include/net/llc_if.h
 delete mode 100644 include/net/llc_s_ac.h
 delete mode 100644 include/net/llc_s_ev.h
 delete mode 100644 include/net/llc_s_st.h
 delete mode 100644 include/net/llc_sap.h
 delete mode 100644 net/llc/af_llc.c
 delete mode 100644 net/llc/llc_c_ac.c
 delete mode 100644 net/llc/llc_c_ev.c
 delete mode 100644 net/llc/llc_c_st.c
 delete mode 100644 net/llc/llc_conn.c
 delete mode 100644 net/llc/llc_if.c
 delete mode 100644 net/llc/llc_pdu.c
 delete mode 100644 net/llc/llc_proc.c
 delete mode 100644 net/llc/llc_s_ac.c
 delete mode 100644 net/llc/llc_s_ev.c
 delete mode 100644 net/llc/llc_s_st.c
 delete mode 100644 net/llc/llc_sap.c
 delete mode 100644 net/llc/llc_station.c
 delete mode 100644 net/llc/sysctl_net_llc.c

-- 
2.55.0

