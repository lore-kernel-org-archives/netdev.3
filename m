Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27783B71CD;
	Mon, 15 Jun 2026 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562580; cv=none; b=aB76bYya7LzOWE4KZnCz455g8t9h/77iCSKaeBXD5cKcbDcHaTEwZyhv9ul5lHIRmsF7t97+6PMA/iHyaQ1pLuTw9kqtyyYVcwm1OAgk0b0SUqRAG5Dc8E86VD1hr22UpawJP/VP2I/4lZWfeVDe0p73gHL7gOYsejw6X7aP0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562580; c=relaxed/simple;
	bh=xjxmNjXcUMlhc/D7hgaOfAdUFh2+r6FSs83MmHaOjzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TV9PDxS1en+N/BDmBss+R97nkp2HY2YNbzkkODCkNdmFynikor+OVi20DKeOMKFaswUsaAFGO+OTqFeExNZ1+nn/oUO7d0tVL665Tvir5akPsQ2k1MYYJEiyXjNgdOXCjX17ui51fT/lnXd/Yflgbr0JM9kbMilpL4d1no3XbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+SMgU71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+SMgU71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD22D1F000E9;
	Mon, 15 Jun 2026 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781562579;
	bh=jlQPGxguRWI9qpH8iTo7hAEJVXsf499qSnGcNlAN4u4=;
	h=From:To:Cc:Subject:Date;
	b=n+SMgU71YsGGMv6moPGk4CQZF8N2L8grY3o1ZPaYpPXUyvwZ0VTr9qxnXviqgdWRP
	 gNJDjpfVWAKQwvqzKBPVHqdynuXXf01jNTycOmituSFzxVvL/GGXEmFBUi1aboeyq4
	 HX8Cd3SkqEzCqCtWfgLqu5LwuLOS+pVfn9t6S0kzSQlh+9H1IEWuMH78I8AVKR8qXD
	 rIsDHILdPs8R+Y1sjcAh7QUz0m1Cnxg7pYbAEjX4HB59l3nUU/sgbUuEV6+Tu74Kkf
	 0heByX00Kl5cC8OCGETsi+QB5HLC+7Ti8ZRrl8wHJaHlmh7e4iS0BqvmaKtxnhQaC0
	 Qzysy9WcmjHlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	geert@linux-m68k.org,
	chleroy@kernel.org,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	maddy@linux.ibm.com,
	linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Date: Mon, 15 Jun 2026 15:29:33 -0700
Message-ID: <20260615222935.947233-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tiny series moves appletalk out of tree, to:

  https://github.com/linux-netdev/mod-orphan

Core maintainainers are unable to keep up with the rate of security
bug reports and fixes. Nobody seems to care about appletalk enough
to review the patches.

As Eric pointed out Mac OS dropped AppleTalk over a decade ago.

Jakub Kicinski (2):
  appletalk: stop storing per-interface state in struct net_device
  appletalk: move the protocol out of tree

 MAINTAINERS                                   |    5 +-
 Documentation/admin-guide/sysctl/net.rst      |   46 +-
 .../networking/net_cachelines/net_device.rst  |    1 -
 net/Kconfig                                   |    1 -
 net/appletalk/Kconfig                         |   30 -
 net/802/Makefile                              |    1 -
 net/Makefile                                  |    1 -
 net/appletalk/Makefile                        |   10 -
 include/linux/atalk.h                         |  186 --
 include/linux/netdevice.h                     |    4 -
 net/appletalk/aarp.c                          | 1041 ---------
 net/appletalk/atalk_proc.c                    |  242 --
 net/appletalk/ddp.c                           | 2017 -----------------
 net/appletalk/sysctl_net_atalk.c              |   58 -
 arch/arm/configs/ixp4xx_defconfig             |    1 -
 arch/m68k/configs/amiga_defconfig             |    1 -
 arch/m68k/configs/apollo_defconfig            |    1 -
 arch/m68k/configs/atari_defconfig             |    1 -
 arch/m68k/configs/bvme6000_defconfig          |    1 -
 arch/m68k/configs/hp300_defconfig             |    1 -
 arch/m68k/configs/mac_defconfig               |    1 -
 arch/m68k/configs/multi_defconfig             |    1 -
 arch/m68k/configs/mvme147_defconfig           |    1 -
 arch/m68k/configs/mvme16x_defconfig           |    1 -
 arch/m68k/configs/q40_defconfig               |    1 -
 arch/m68k/configs/sun3_defconfig              |    1 -
 arch/m68k/configs/sun3x_defconfig             |    1 -
 arch/mips/configs/gpr_defconfig               |    1 -
 arch/mips/configs/malta_defconfig             |    1 -
 arch/mips/configs/malta_kvm_defconfig         |    1 -
 arch/mips/configs/malta_qemu_32r6_defconfig   |    1 -
 arch/mips/configs/maltaaprp_defconfig         |    1 -
 arch/mips/configs/maltasmvp_defconfig         |    1 -
 arch/mips/configs/maltasmvp_eva_defconfig     |    1 -
 arch/mips/configs/maltaup_defconfig           |    1 -
 arch/mips/configs/maltaup_xpa_defconfig       |    1 -
 arch/mips/configs/mtx1_defconfig              |    1 -
 arch/powerpc/configs/ppc6xx_defconfig         |    1 -
 arch/sh/configs/landisk_defconfig             |    1 -
 39 files changed, 3 insertions(+), 3665 deletions(-)
 delete mode 100644 net/appletalk/Kconfig
 delete mode 100644 net/appletalk/Makefile
 delete mode 100644 include/linux/atalk.h
 delete mode 100644 net/appletalk/aarp.c
 delete mode 100644 net/appletalk/atalk_proc.c
 delete mode 100644 net/appletalk/ddp.c
 delete mode 100644 net/appletalk/sysctl_net_atalk.c

-- 
2.54.0

