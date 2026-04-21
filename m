Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE04344D83;
	Tue, 21 Apr 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799886; cv=none; b=lGnxhQJFZTT6dETybEuxhrTMixCx+mk48az8c5/g+LJDNgrMuac6uYeLkNLFZdiwhbNm0cQVLfwxNlpafeVM0UwGgrNecUXyQyPUBmM2/kMDd2nNsP3Omk9p80DWpcT2vgBk0aBdz1BJf+a/UvFrBXM2+WtuNk4wC1RxXbnjmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799886; c=relaxed/simple;
	bh=Ptl98l17QJ6YaplXJhaUKrJSZYHU5KIImbb8cZCeMww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n8KaZL05D1A4qnyDqo63dlGrteTkK99EIjLs1+gYXU/amrBg5q1LsJjhkJFTQGJmL4haIcD3sgPRTxkiQMCApf/7Yw7yj7Bzdz8p2NbqvEMcIUYB329geeQajg/Sji1jzmDgrcxOynQ7OzPr6cDScfrcqI2kvEhCpMsYAsEE9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dLwq5RJk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dLwq5RJk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jTgK8TLmtnbZPuNMBj/XMS5PD66v/f6DUikJMoGvhNQ=; b=dLwq5RJkEAEttMA432keFnVg6M
	OSvLOPl83EH82jr3FIhFsIE/EoztPc8H7lhmFGTA7ZMxu5jVEPj56+NZ51POFlKqmlJI+l8sC09r0
	dJ7pSIYRAaur7Vi+xqcEziaxwgPGf4kVbAEvPwywy1/z1Jd8CaS64tmeCNSYVx2KwYOY=;
Received: from c-66-41-74-139.hsd1.mn.comcast.net ([66.41.74.139] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFGoX-00GwVc-3r; Tue, 21 Apr 2026 21:31:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Date: Tue, 21 Apr 2026 14:31:03 -0500
Message-Id: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfQ52kC/x2NQQrDMAwEvxJ0rsB2Tez2K6WH1FFSQesUOYhAy
 N8rwrKHOczuDo2EqcG920FIufFSDfylg/Ie6kzIozEEF3oXg0dN6CyVVuu24iisJCj0XXT4oHq
 MqeRcbjm9rhFs5yc08XZ+PMA8eB7HHyBd9gx4AAAA
X-Change-ID: 20260421-v7-0-0-net-next-driver-removal-v1-47c88c987b34
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4485; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Ptl98l17QJ6YaplXJhaUKrJSZYHU5KIImbb8cZCeMww=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBp59CAKz1zRv30HrGZn2le3kV4FpdYHYM47uvX8
 580aRtEaYOJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCaefQgAAKCRDmvw3LpmlM
 hLwyEACxOUKQA1470+jwEO8C1e3xBlg/KrwXwoJBcnoKfgnnVPoHsjJ4sIM2UNh0sPePtX175ef
 TpWQ06Yq5hs3w5N/73bGgcNwh/dvm0htbHPYjD930dyZByZdRCKoJG1fIiqS5+MpsGNU5CyC26Q
 DSu/eYFIdEzpVl+UKSkpL4nLWwPdttCVZBMzSmUnuTO1jFoZPMJfK/TMgzwhxpJj6zsLoCisUTE
 OO6sfPT/3DjplvrLLBxEyf/Dr/lrcvIIQoj4k9RG7oEUo2saOAQAyGa10VBVJK9b3DDM4J+cuNj
 GSU2RFDfkx9o7kiDcDSMmgcZ91326Gr7LZJHGwyB19+FEySeNZuQO9YcfA4NNpfOUmf2EHpkPX5
 t/DTaY73UQhHgvdHnSOne1kz41ShXZOrogDHid0OikWEFLsL5Hkzlmi51yhZ1Al3J9DfhmfjpgD
 ly2yZchMuE91TqdjKPezmoB2pPnvcMLTclVmfrIjl0y/QmJB6qHq1kQsqxrDRBDgA64gLItX7Vr
 ro6aFY0DfMCsiSy1K1LbFnJ7u3j5OClRiA8bbwqxbQAnzgqnPYssoTg1DxEPaeZYA33Tju067k4
 RucnnM/TOl2z2EqFiU3TKjrfqu4RCmDHTzEcl4IbrAZlAbYwGjxJcAhjMnlzmBSxZPWoD01L+9D
 f2MZlpGLVx3snEQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

These old drivers have not been much of a Maintenance burden until
recently. Now there are more newbies using AI and fuzzers finding
issues, resulting in more work for Maintainers. Fixing these old
drivers make little sense, if it is not clear they have users.

These are all ISA and PCMCIA Ethernet devices, mostly from the last
century, a couple from 2001 or 2002. It seems unlikely they are still
used. However, remove them one patch at a time so they can be brought
back if somebody still has the hardware, runs modern kernels and wants
to take up the roll of driver Maintainer.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Andrew Lunn (18):
      drivers: net: 3com: 3c509: Remove this driver
      drivers: net: 3com: 3c515: Remove this driver
      drivers: net: 3com: 3c574: Remove this driver
      drivers: net: 3com: 3c589: Remove this driver
      drivers: net: 3com: 3c59x: Remove this driver
      drivers: net: amd: Remove hplance and mvme147
      drivers: net: amd: lance: Remove this driver
      drivers: net: amd: nmclan: Remove this driver
      drivers: net: smsc: smc9194: Remove this driver
      drivers: net: smsc: smc91c92: Remove this driver
      drivers: net: cirrus: cs89x0: Remove this driver
      drivers: net: cirrus: mac89x0: Remove this driver
      drivers: net: fujitsu: fmvj18x: Remove this driver
      drivers: net: xircom: xirc2ps: Remove this driver
      drivers: net: 8390: AX88190: Remove this driver
      drivers: net: 8390: pcnet: Remove this driver
      drivers: net: 8390: ultra: Remove this driver
      drivers: net: 8390: wd80x3: Remove this driver

 .../device_drivers/ethernet/3com/vortex.rst        |  459 ---
 MAINTAINERS                                        |    7 -
 drivers/net/ethernet/3com/3c509.c                  | 1448 ---------
 drivers/net/ethernet/3com/3c515.c                  | 1566 ---------
 drivers/net/ethernet/3com/3c574_cs.c               | 1164 -------
 drivers/net/ethernet/3com/3c589_cs.c               |  974 ------
 drivers/net/ethernet/3com/3c59x.c                  | 3357 --------------------
 drivers/net/ethernet/3com/Kconfig                  |   66 -
 drivers/net/ethernet/3com/Makefile                 |    5 -
 drivers/net/ethernet/8390/Kconfig                  |   52 -
 drivers/net/ethernet/8390/Makefile                 |    4 -
 drivers/net/ethernet/8390/axnet_cs.c               | 1707 ----------
 drivers/net/ethernet/8390/pcnet_cs.c               | 1717 ----------
 drivers/net/ethernet/8390/smc-ultra.c              |  630 ----
 drivers/net/ethernet/8390/wd.c                     |  575 ----
 drivers/net/ethernet/Kconfig                       |    2 -
 drivers/net/ethernet/amd/7990.c                    |  671 ----
 drivers/net/ethernet/amd/7990.h                    |  251 --
 drivers/net/ethernet/amd/Kconfig                   |   39 -
 drivers/net/ethernet/amd/Makefile                  |    4 -
 drivers/net/ethernet/amd/hplance.c                 |  238 --
 drivers/net/ethernet/amd/hplance.h                 |   27 -
 drivers/net/ethernet/amd/lance.c                   | 1317 --------
 drivers/net/ethernet/amd/mvme147.c                 |  198 --
 drivers/net/ethernet/amd/nmclan_cs.c               | 1508 ---------
 drivers/net/ethernet/cirrus/Kconfig                |   40 -
 drivers/net/ethernet/cirrus/Makefile               |    2 -
 drivers/net/ethernet/cirrus/cs89x0.c               | 1915 -----------
 drivers/net/ethernet/cirrus/cs89x0.h               |  461 ---
 drivers/net/ethernet/cirrus/mac89x0.c              |  577 ----
 drivers/net/ethernet/fujitsu/Kconfig               |   30 -
 drivers/net/ethernet/fujitsu/Makefile              |    6 -
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c          | 1176 -------
 drivers/net/ethernet/smsc/Kconfig                  |   27 -
 drivers/net/ethernet/smsc/Makefile                 |    2 -
 drivers/net/ethernet/smsc/smc9194.c                | 1535 ---------
 drivers/net/ethernet/smsc/smc91c92_cs.c            | 2059 ------------
 drivers/net/ethernet/xircom/Kconfig                |   30 -
 drivers/net/ethernet/xircom/Makefile               |    6 -
 drivers/net/ethernet/xircom/xirc2ps_cs.c           | 1794 -----------
 40 files changed, 27646 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260421-v7-0-0-net-next-driver-removal-v1-47c88c987b34

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>

