Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3023C4E9
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381443; cv=none; b=u236BzGA3HLzitRFb6gjfactnf2+sU38L4SrC2+1P1wLRvrOgZT3KiN0NIVMw71s+2wOY+hsKf9APGIQw2Il4Ttb4n/w8D1xsB8rkT7nw0hKaZ+O1AdM9+ojWDNBR9JmIwlx0Vk+jYGuqfqAs00v7DaD4c1aTLfnieTtky3rvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381443; c=relaxed/simple;
	bh=f5uNJJxbwomHw5/JeMdbEj6ao22dY7Lg4HSjqvuM+2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=or3rdS85E+yBk9zSS638ykYeeAnaoYFSqkMS4GNWoo/YLIHtBgtr9KxqGcv2FsKq+aV9Hz0sTZq3FmgBpdLHnk76AOQaJUVSoGM0iHMWSaYDz+0ptCU/txtj7altJo1NMEwyEjV6dyH1hiCk3x1xaSDn3R94Wxfv5siCvT2nt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmtHIb9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmtHIb9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80D01F000E9;
	Sat, 13 Jun 2026 20:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381442;
	bh=0nXdav6hD6nqNJl58yVXgHGf52t4Zt1a7l+gXWTOqHM=;
	h=From:To:Cc:Subject:Date;
	b=mmtHIb9AQyQAWtvjkerVWEV+MZ1ZUaoX5cOMPnValUuF8BBJvMGHhcgnrcJ6+2W9R
	 p6Hx3iZ8VLqQZYgeO0Pt3DNub1Qul0a1dYO4rUwmPG+AU593tIg1Tx3XrNHiELNjzE
	 3tIl30Sb483dVF5x9fXEvzjPcK1Kk7yfATPvatLA0WQCmaS4yOmoGDK4EBPOD0diXO
	 19ymoqFVowRcIPx1pPM4s9Ez1s2X4FmQmh9bYeePUcV94ctBcwQzauwTTdYVXQAf5X
	 EsBKWpGk9fEymduVsJfgzzkUDgaMXgULnzy7DQqq4JYTu7hpERl+NUmgAHvqDiIBQ/
	 oT4uHxpqNprhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/9] atm: remove more dead code
Date: Sat, 13 Jun 2026 13:10:23 -0700
Message-ID: <20260613201032.77274-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
ATM device drivers") removed a good chunk of old ATM drivers.
Our goal going forward is to limit the ATM support to PPPoATM
used in ADSL deployments.

A recent burst of AI generated fixes for net/atm/signaling.c and
net/atm/svc.c made me look closer at the remaining code. PPPoATM runs
over permanent virtual circuits (PF_ATMPVC) with a statically
configured VPI/VCI. We can drop switched virtual circuits (SVCs)
and user-space signaling (atmsigd) support. While digging around
I noticed a few more obviously dead pieces of code.

Annoyingly, I have applied one "fix" to QoS config which will
now make net conflict with this series :/

Jakub Kicinski (9):
  atm: remove AAL3/4 transport support
  atm: remove the unused send_oam / push_oam callbacks
  atm: remove dead SONET PHY ioctls
  atm: remove the local ATM (NSAP) address registry
  atm: remove SVC socket support and the signaling daemon interface
  atm: remove the unused change_qos device operation
  atm: remove the unused pre_send and send_bh device operations
  atm: remove unused ATM PHY operations
  atm: remove orphaned uAPI for deleted drivers, protocols and SVCs

 net/atm/Makefile                  |   2 +-
 include/linux/atm_tcp.h           |  24 --
 include/linux/atmdev.h            |  70 +--
 include/uapi/linux/atm_eni.h      |  24 --
 include/uapi/linux/atm_he.h       |  21 -
 include/uapi/linux/atm_idt77105.h |  29 --
 include/uapi/linux/atm_nicstar.h  |  54 ---
 include/uapi/linux/atm_tcp.h      |  62 ---
 include/uapi/linux/atm_zatm.h     |  47 --
 include/uapi/linux/atmarp.h       |  42 --
 include/uapi/linux/atmclip.h      |  22 -
 include/uapi/linux/atmdev.h       |  18 -
 include/uapi/linux/atmlec.h       |  92 ----
 include/uapi/linux/atmmpc.h       | 127 ------
 include/uapi/linux/atmsvc.h       |  56 ---
 net/atm/addr.h                    |  21 -
 net/atm/common.h                  |   5 -
 net/atm/protocols.h               |   1 -
 net/atm/signaling.h               |  31 --
 drivers/atm/solos-pci.c           |   4 -
 net/atm/addr.c                    | 162 -------
 net/atm/atm_sysfs.c               |  25 --
 net/atm/br2684.c                  |   3 +-
 net/atm/common.c                  |  73 +---
 net/atm/ioctl.c                   |  58 ---
 net/atm/pppoatm.c                 |   3 +-
 net/atm/proc.c                    |  56 ---
 net/atm/raw.c                     |  21 +-
 net/atm/resources.c               |  54 ---
 net/atm/signaling.c               | 297 -------------
 net/atm/svc.c                     | 695 ------------------------------
 31 files changed, 14 insertions(+), 2185 deletions(-)
 delete mode 100644 include/linux/atm_tcp.h
 delete mode 100644 include/uapi/linux/atm_eni.h
 delete mode 100644 include/uapi/linux/atm_he.h
 delete mode 100644 include/uapi/linux/atm_idt77105.h
 delete mode 100644 include/uapi/linux/atm_nicstar.h
 delete mode 100644 include/uapi/linux/atm_tcp.h
 delete mode 100644 include/uapi/linux/atm_zatm.h
 delete mode 100644 include/uapi/linux/atmarp.h
 delete mode 100644 include/uapi/linux/atmclip.h
 delete mode 100644 include/uapi/linux/atmlec.h
 delete mode 100644 include/uapi/linux/atmmpc.h
 delete mode 100644 include/uapi/linux/atmsvc.h
 delete mode 100644 net/atm/addr.h
 delete mode 100644 net/atm/signaling.h
 delete mode 100644 net/atm/addr.c
 delete mode 100644 net/atm/signaling.c
 delete mode 100644 net/atm/svc.c

-- 
2.54.0

