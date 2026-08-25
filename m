Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E730BB8A;
	Tue, 25 Aug 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638599; cv=none; b=Vxq/PK4IPiyQ4Gd36ctTY2VTkKPX0yJvlZO7THZRemp+DNt5px079yjhdxFGUbwDT9XC6pPOb1IE5agUZvltwa1eah5jt8qw/sklQcmGqQ42Gz+GePfAcnSlAU2KBqhnAwGgzaMvElSIKm7NPJEjEyu14UisMlJto8wIydNyZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638599; c=relaxed/simple;
	bh=4EJis+KqYVqsKy+M4k35yK5euUhRM8xuSDSoWqjT6cU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARB3QLZQb+ioqQ6aysiaUTUYPSw0ENqSZlxQtU4BarUAUwohWyqDKNsEJ04uQkEj0SQrik9AOExrZq8iVIOp2ATRkDAE73vGmHUY+7h/6jR0y+JshIevNeezI4d+CPX0n4vWg88voZPmrebw88XpQPIbAS3VOWSzUBy0l7iwxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4488758|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.09851-0.00159882-0.899891;FP=7309375702676577681|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iwcg8yS_1787638580;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iwcg8yS_1787638580 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 25 Aug 2026 14:16:28 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com
Subject: [PATCH v3 net-next 0/2] net: dsa: yt922x: Add support for Motorcomm YT922x
Date: Tue, 25 Aug 2026 14:16:08 +0800
Message-Id: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT922x is a series of ethernet switches including:

 - YT9224: 4 * 2.5G UTPs and 2 serdes interface

This patch just add basic func for a working DSA switch.

v3:
1. Post the driver as a patchset.
2. Remove unnecessary macros.
3. Add mib_working to indicate whether the MIB has been initialized.
4. Fix any errors found

v2: https://lore.kernel.org/all/20260820080542.2017118-1-kyle.switch@motor-comm.com
1. Seperate tag_yt922x into an individual file.
2. Fix the issues from the previous version. 
3. Optimize the code style to keep it consistent with the existing code style.

v1: https://lore.kernel.org/all/20260813104137.55550-1-kyle.switch@motor-comm.com
1. Add basic functional interfaces for the YT922X DSA driver.
2. Although the DSA driver supports both YT922X and YT921X simultaneously,
   the original file names are still maintained for now; 
   the file naming may be optimized in the future.
3. Currently, the dsa_switch_ops structure is employed as the operational interface. 
   In future phases, as functionality expands, the architecture will be refactored 
   to introduce yt922x_dsa_ops, where chip-specific operations will be distinguished 
   between YT922X and YT921X, following a design pattern commonly adopted by other
   existing multi-series DSA drivers.
4. A new thread(patch series) is created. Although a previous version was submitted, 
   the changes are substantial, so the old version is not relevant for reference.

Kyle Switch (2):
  net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
  net: dsa: Add support for Motorcomm YT922x

 drivers/net/dsa/Kconfig  |   7 +-
 drivers/net/dsa/Makefile |   2 +-
 drivers/net/dsa/yt921x.c | 821 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h | 104 +++++
 include/net/dsa.h        |   2 +
 net/dsa/Kconfig          |   6 +
 net/dsa/Makefile         |   1 +
 net/dsa/tag_yt922x.c     | 111 ++++++
 8 files changed, 1035 insertions(+), 19 deletions(-)
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

