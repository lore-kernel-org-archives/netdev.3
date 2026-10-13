Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA53AB498
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860149; cv=none; b=j7JOkMZlbUqV0CRKDAPsGtNU6erg3tGBi1EMHXMlh9b5Tu9sHUCn9H0m95gKM/ttehIvL0AaLi6oJ0Lul5pIt7sJ73ef/Jf85rR4Lw6UvAMnxaK+kVrpqibL59tcWsL8iO3I4EFMuj8FaZrwm+ozHLH9ZYPv5xMjKSkHadZqHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860149; c=relaxed/simple;
	bh=XWT+evDyeLy1CvG7qT+s2Eh+cCd6BaPGI+i6dJwrKE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sZehl9zTaVnyPpdEBT8L8GgaBIEn3SYayFo/r6ZEBOOG6jxptV/BSJtj9CslXkNhCyoZ6810gjB+8JuzBb29plZ2fAx2pAxLvX3tLw1va1DPGG63YiljX03bI9CTICuGEPz1JBLut0wls8IloN74SR+nNSKlU5u4iDVZuDGYp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy+WwoXp; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy+WwoXp"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so1068922eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791860147; x=1792464947; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+I02+8xmB4l0yP/lItNCeO/Dv9gNUrktx08qk23Etg=;
        b=Iy+WwoXpXAC/uzfsauF9qxYWE07+4/I3NEhJdPYwFZ0mivcp8GjIb3l8h6Pf0s32i9
         dC9KXGEcOAte8cZdhvcS4DVDaCc8Bqh3Ah7BTM3reWZVa6lHvCb5vpjffHYBKKDxs37m
         Y96ktS2Rbw6ZH0Qnn17POQAomvq8TUM77ipFkCuoIkxtONJBs0J82BtsWtMoEd88G5Zt
         gtB1pa2xiL9Fh33CCfIIwQs0+spMkFK+DHxI+PuD8uSEXZwIf5HGSWc9BqmXD94d+he5
         0typtZ83ZhN4J0TrEZIt3NLofBMDCb5izmM/+SZMLa8zfw5r3HAS66HJlsiaTqBKtT0k
         pVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860147; x=1792464947;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G+I02+8xmB4l0yP/lItNCeO/Dv9gNUrktx08qk23Etg=;
        b=RkBOwY8ikQaKi7yRfnIPxS8ntSdlIX0FDpcAIMh//x1oeCfM/cSrSmVaxPiKCYmmLy
         eW/2y+CUD11jU7zWwYK5aOT+og0Dcd3SfrBPj9ZP39beFbwIB+6TmQX40quWX16T3LtZ
         YlhR5T2b0PlDNRYvIWapSkcajE2kum7a4haQ8ifCUBG9CK+6diIjHQVxxCZlp/W2R1Py
         ybtBxpmvwr5XKzt/dWEotwqQmsCpUdAoTZkpEWQ7EJlfh3C5Squq0/q6XESvcu3rvYd4
         ZMdXiFBoCjKO0K5ZQE2dX1X1svMnAlpkuJ9TmztfrqGZJ5eCWUJBqdJYl1ZeeJIYn4Nd
         vqCw==
X-Forwarded-Encrypted: i=1; AKwUvBzuPH6buqZuebpUR+AUviiel7h2tBxcrcojCXbgsPMRj07DL2PAQa7LrkoN/FZ9vJzXksgURts=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF2KiC2loOsX2TUIpnG2a+wl6DAAYySjUx+bWFveBbBqEQ++Kd
	CJETQGMmJo90UcK8dw1YO3HckzJl8GWWa1hMVKb4eGon7TILBFALzCD3
X-Gm-Gg: AYBFou1edECODT0OrDy1Mvu6qFqjYyd7WJWzadQmldiB5VHg0rdBGPJjM/uuPYHgoAT
	w4bqAiC/CF5FPWTZsArHNo8ClpXIeg1fyJBbv2mYVjiMGUH3Kj2Rc7Ig9dXw34oYOmVAaGsNWy4
	FHhVZnQHLzaA+9AlwJjKnQFh5WJ9xJnJ5N/wpvYk+9WkCE2pR0xpEInBgVPkiucxCHh40gsrwOV
	EyNk2zR0p+BAoZEXf3UnXM3+Z7xeMAXjSkX9rU1rqDSyGpgyxsLW7znqHFotCqoi8/2Ni6kioVB
	DoNZnKgue7VDpx5wG3q8wI7BDNmGP0lI4HLpLuNrcPPQMH6yli0fctlqDRW5LG/YLgY8m4ap0P5
	yeoQyoxnShuEPhMJfvaOSx6bTZMXVlwpU+L8GwAvPhjtr9ZtlaOIBmx9UtdjPe5QyS2Y0ihmLA2
	+8/0O6uTaL8wt3b8PjVHwI2c2pk5I/P/30C2lM0b77mAJmJQ5xEz+QEkAa83UvnY+IVKL/FgpEr
	RJKl/0t/Xue
X-Received: by 2002:a05:7300:cf8e:b0:35a:7020:c08a with SMTP id 5a478bee46e88-35a7020c1a4mr6837443eec.19.1791860147092;
        Mon, 12 Oct 2026 19:55:47 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:3:8056:897e:dae3:8e2e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm50889219eec.9.2026.10.12.19.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:55:45 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Subject: [PATCH RESEND v2 0/3] usb: Use %pe to print error pointers
Date: Tue, 13 Oct 2026 08:25:36 +0530
Message-Id: <20261013-usb-ptr_err_patchset-v2-0-f83351b3fc3d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKidzWoC/3XNvQrCMBQF4FeRzEaS2Dapk4NdHXQUKW160wbsD
 0kMSum7G4Kgg47nHu53ZmTBaLBot5qRAa+tHocQ2HqFZFcNLWDdhIwYYRnhVOC7rfHkTAnGlFP
 lZGfBYS7ThqYJrwE4Cq+TAaUfkb2gU3Eujgd0DfdOWzeaZ1zzNLZvOP8Ne4oJFqniikGiQNX7t
 q/0bSPHPoKefRBB6B+EBYRmuQCWC0lh+40sy/ICqbdDxgUBAAA=
To: Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Duncan Sands <duncan.sands@free.fr>, 
 Chas Williams <3chas3@gmail.com>, Minas Harutyunyan <hminas@synopsys.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 Subasri S <subasris1210@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791860140; l=1843;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=XWT+evDyeLy1CvG7qT+s2Eh+cCd6BaPGI+i6dJwrKE0=;
 b=MhN1j7+LP8ppCCOHXnmgYWPKdz5mt77RZ7osZR4EN6zzSE9SJMTr1kD+E6OTFGbXdSbofOb+q
 WiSxEwFtLiADqfdVqQXgrT9ibTp9FO9LlutWOlhGP1xqlWhXy308EXI
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

Replace PTR_ERR() in format strings with 
%pe format specifier across the USB subsystem. %pe prints 
symbolic error names (e.g., -ENOMEM) instead of 
raw numbers (e.g., -12), making error logs more readable. 
These patches fix coccinelle reported warning: "Consider 
using %pe to print PTR_ERR()" in usb subsystem.

The patches are grouped by subsystem:
  1/3 - chipidea
  2/3 - miscellaneous USB drivers
  3/3 - typec

All patches are compile-tested on x86_64. Please let me know if 
any more testing is needed for any patch. 

Signed-off-by: Subasri S <subasris1210@gmail.com>
---
Changes in v2:
- Remove "This patch" phrasing from the commit message body.
- Trim redundant Coccinelle warning outputs in the commit log to keep only one.
- Clean up multi-line dev_err() statements into single lines.
- Link to v1: https://lore.kernel.org/r/20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com

---
Subasri S (3):
      usb: chipidea: Use %pe to print error pointers
      usb: misc: Use %pe to print error pointers
      usb: typec: Use %pe to print error pointers

 drivers/usb/atm/usbatm.c               |  4 ++--
 drivers/usb/chipidea/ci_hdrc_imx.c     | 12 ++++++------
 drivers/usb/chipidea/core.c            |  4 ++--
 drivers/usb/core/hub.c                 |  3 +--
 drivers/usb/dwc2/pci.c                 |  3 +--
 drivers/usb/gadget/function/u_serial.c |  4 ++--
 drivers/usb/misc/usb3503.c             |  3 +--
 drivers/usb/typec/mux/pi3usb30532.c    |  6 ++----
 drivers/usb/typec/tcpm/tcpm.c          |  2 +-
 drivers/usb/typec/wusb3801.c           |  4 ++--
 10 files changed, 20 insertions(+), 25 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260718-usb-ptr_err_patchset-7c5d1547bee7

Best regards,
-- 
Subasri S <subasris1210@gmail.com>

