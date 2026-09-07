Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93A40B0EC
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763926; cv=none; b=Toh+vI2tGA3RJxGUYV+ZLT8YhsXeSqZjA/pXhhiT/c31KTQsqvH2juEHEcdpsythZhdBGEKBA/loXpctAtFaJmAuUC8TekGLCFU57J/t5BS7I0bae0dk/QlurP3vNdJ+Wa3oBZN/y9kbHARnzRhx3nJb8p7Jp8q7C0IVwbhQ0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763926; c=relaxed/simple;
	bh=Z9XniWzjJlKB0mButU1sj2cWuQBEqd9MHwaueowg4yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzXxDZ3jWDcFXCOhIgkV14KRVrQKP89b/mDuRRI/nXfWMEtAddT6X1jiomR71PbeBVa1hvqNnV1qr84LH3stOPwYdSKr9N+yfabHSh8/Cw6d+0ZG/8129wJvcdAkcr0oDWMlwM7ivCSYFqlKj4rzTvkIB/9sO/ksZBV/BJjO1XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvVs2M3X; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvVs2M3X"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-862815e2683so1692371b3a.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763923; x=1789368723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJnRbzrCd1m2NleK0en88gJsG/d6sqX5zOAxr1Lx8cg=;
        b=EvVs2M3XukLrbCr5xtIpyrjGa6IbzpZnN+AbmSu2sUxwqt+rbe9Okr7WCXzrsJiVbu
         ZQasksmIDywaU+x1vCbcZ4/tPzESEIpZOI1eV2u5jrDmnHAlP0EBCb9jrscfNNyZkETT
         /VIbtwrzr0Mb/eT0v6jl5P6yAYrWVx9P9TwZr7HM9eaxF+f710V2FneEPIVRLjAAYnw1
         Pi3Iwfd0BmL+xMRetuo/lRD0Q2RMi23coENAy5zIaGwUiGPO04eILkT2smevlAoe1FZg
         9wN5LoM3zx7SOl0e0aC4ltR7SZ4eA6UNhVaFaQ7gs2lypbO61DNWjWHzvhIseNI6LEII
         LagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763923; x=1789368723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJnRbzrCd1m2NleK0en88gJsG/d6sqX5zOAxr1Lx8cg=;
        b=RcVQ+UQCkDDHHWLovpuQHfKoXUPk1nqySAU3ovOvU4S0fD7GyLsQVEgme3+7MGTqVS
         qSKpMrwTEi2CandsG2Bxp6ImrvPVYKVA9NHc2wsTRNV9nBDnx5FKNoT1CbJYHZPyVx3T
         S2Ylwe4hsoSFGcJgpKfRTq/GcfOyxmOgbpSBWI+azrwOUEMj0SZxG10E02CurzF2eKsL
         0K3ARmncB2fiNa/BGTzsfKLyGx+9fMldHq5/EDj9ZvMThPVivqOjCRAh2rvsnwQ4V2IP
         NwiloGmTmttuPppl7gjM+ZqnO1wVUzGS8Tj3/1NWzP71r2QfBim+WbVjXTQcoS3YBKVo
         42FQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcKWd4vd6p+11abOlnUNpFU3W/SSWZJcfzDaTV5qBzgWzkD4r0JxPVk/+4DyX6o2/pop6sxcY=@vger.kernel.org
X-Gm-Message-State: AFuF++kh2X5BmBslp3gioDkmsx31vkeTzU8YB41dDD5y64nuAyqldwQd
	ySW+TUFDhmmapLPH/Ocjf5jS36hmMxStqDQ6X1Fom2dBi4t1oKaW3L3G
X-Gm-Gg: AYBFou1dLGQNitK/hU1YLAFLhcTnxEGVkUSMohwTc2H433nkjivdThaaSk4TrgESkCT
	3kzcxlLPaIYqqhI5EFxf/gv0tnE69Wt9Q5Nl4pgJ3Md8sw4I8AiVfIiEwZ16kYEI94fvugEy/J4
	LiABhj+Stvp++ADaSxvkv+2j536fUUcfdbrLwGVUImaSCZVV50MAYyQFis2+Vz7DrSED3tDcI7L
	SdHVtvysxdb5Gq+ZI2RFcopfYlzbAycoXFBEnaB4kHZCZi+tTGCQbf87PkqZoJX6FJqCegWt7PW
	pPO86pn4cdLOK3ppRseOhGrT2yE7XT6QM2ujf/GXDTQ0FkHKpQ/p+dAu1g/S8yfg7kbEuvKhnEC
	2+ldL/nWoiltRsM+xB8jiM9Hd+0nixBF7oCNVjMk1UPG4qI5RJXwWA2gyleHDpgfQcJ6SCLIat3
	+42KE5vjfeLCjNAPUh5Omy0VRncObM1r/HY317tdB9QN2ulKENLESAYxrL6oLdukwDNVAuKHvyt
	fYCspfFcw8ifcQ=
X-Received: by 2002:a05:6a21:7748:b0:3da:6bdd:2c74 with SMTP id adf61e73a8af0-3da6bdd6cfcmr13705124637.10.1788763923318;
        Sun, 06 Sep 2026 23:52:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm28825941eec.21.2026.09.06.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:52:02 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] powerpc: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:21:51 +0530
Message-ID: <20260907065153.33578-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  powerpc: fix typos in comments
  powerpc: fix repeated words in comments

 arch/powerpc/include/asm/book3s/64/mmu-hash.h          |  8 ++++----
 arch/powerpc/include/asm/book3s/64/radix.h             |  2 +-
 arch/powerpc/include/asm/fsl_hcalls.h                  |  2 +-
 arch/powerpc/include/asm/io.h                          |  2 +-
 arch/powerpc/include/asm/machdep.h                     |  2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h           |  2 +-
 arch/powerpc/include/asm/pmac_feature.h                |  2 +-
 arch/powerpc/include/asm/prom.h                        |  2 +-
 arch/powerpc/include/asm/sfp-machine.h                 |  2 +-
 arch/powerpc/include/asm/smu.h                         | 10 +++++-----
 arch/powerpc/include/asm/task_size_64.h                |  2 +-
 arch/powerpc/include/asm/uaccess.h                     |  2 +-
 arch/powerpc/include/uapi/asm/bootx.h                  |  2 +-
 arch/powerpc/kernel/eeh.c                              |  4 ++--
 arch/powerpc/kernel/eeh_event.c                        |  2 +-
 arch/powerpc/kernel/exceptions-64e.S                   |  2 +-
 arch/powerpc/kernel/exceptions-64s.S                   |  4 ++--
 arch/powerpc/kernel/fadump.c                           |  2 +-
 arch/powerpc/kernel/irq_64.c                           |  2 +-
 arch/powerpc/kernel/paca.c                             |  4 ++--
 arch/powerpc/kernel/pci_dn.c                           |  2 +-
 arch/powerpc/kernel/prom.c                             |  4 ++--
 arch/powerpc/kernel/setup_64.c                         |  2 +-
 arch/powerpc/kernel/signal_64.c                        |  2 +-
 arch/powerpc/kernel/smp.c                              |  2 +-
 arch/powerpc/kernel/switch.S                           |  2 +-
 arch/powerpc/kexec/core_64.c                           |  2 +-
 arch/powerpc/kvm/book3s_pr.c                           |  2 +-
 arch/powerpc/kvm/book3s_xive.c                         |  8 ++++----
 arch/powerpc/kvm/bookehv_interrupts.S                  |  2 +-
 arch/powerpc/lib/copyuser_power7.S                     |  4 ++--
 arch/powerpc/lib/memcpy_power7.S                       |  4 ++--
 arch/powerpc/lib/rheap.c                               |  2 +-
 arch/powerpc/mm/book3s64/hash_native.c                 |  6 +++---
 arch/powerpc/mm/book3s64/hugetlbpage.c                 |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c                   |  4 ++--
 arch/powerpc/mm/book3s64/slb.c                         |  4 ++--
 arch/powerpc/mm/nohash/tlb.c                           |  2 +-
 arch/powerpc/perf/imc-pmu.c                            |  2 +-
 arch/powerpc/platforms/powermac/low_i2c.c              |  2 +-
 arch/powerpc/platforms/powermac/pci.c                  |  2 +-
 arch/powerpc/platforms/powermac/sleep.S                |  2 +-
 arch/powerpc/platforms/powernv/opal-memory-errors.c    |  2 +-
 arch/powerpc/platforms/powernv/opal.c                  |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c              |  2 +-
 arch/powerpc/platforms/powernv/vas.h                   |  2 +-
 arch/powerpc/platforms/ps3/platform.h                  |  4 ++--
 arch/powerpc/platforms/pseries/firmware.c              |  4 ++--
 arch/powerpc/platforms/pseries/papr_scm.c              |  4 ++--
 arch/powerpc/sysdev/xics/xics-common.c                 |  2 +-
 arch/powerpc/xmon/ppc-opc.c                            |  4 ++--
 arch/powerpc/xmon/ppc.h                                |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.h                     |  4 ++--
 drivers/tty/hvc/hvc_opal.c                             |  2 +-
 .../testing/selftests/powerpc/tm/tm-signal-msr-resv.c  |  2 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c            |  2 +-
 56 files changed, 81 insertions(+), 81 deletions(-)

