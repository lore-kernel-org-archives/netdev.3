Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DB3921D0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381445; cv=none; b=Eme3Y18eYp+97knz045gjMV/w2zTGa2IFkioKDZG4Qw/E4fiHlgtZgTcPFmO7OpGcDB7Fk1l8yq4iFp3eZoj7TBbXzrNMG66s7CP4wGf7yNGzfCn74SmJjEbgslnxg1Dl5ZfZwuPg/E9w8RmCoUw+r6SQfQftQJbGuvVY3qum9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381445; c=relaxed/simple;
	bh=vagjNGdyl9oInZTCnF6670xCfjcQJLjN2tge5WycSOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPiGwSGQpl6sMYQDYjtmL3h+4XU9IOCn/EhyrtaKbi5LgihXUF4R8QZGWa4wrTX4sOXJqj82APsgiyPupmC3hHSliAB956q5YAi69y+VlroILfnXfNbC82ek7XinSexJWK4PojlqcTU7gAocC4bSPwr4h5hsXvci4G582E3sh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4CkPV/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4CkPV/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43061F00A3E;
	Sat, 13 Jun 2026 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381444;
	bh=JWSoMeIzBgrAKi8MVH4TkcJoLoP6HwP9YPHAZ+d3OCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4CkPV/8b3PjNhHZWNgfEeDLJjRgagKhOUJPKxAiWRC+elBa6M9Jz9aIuGv8DpbH1
	 ny5LLTYUKbrcXW9Whz8ra56+UYuHS7wq9vD9oSu9C00ja7EWZjGJirK1xsAphZGAPa
	 Pg8kRmtmndhEa34Jd+/LdlZLCcC0R3q+sA88m/VnBPLKrhoz5t7YcGnZ/2Sqfb/0ht
	 sxjBu39Kd/Cw3bl/ghiQ5AFi3ohVlh5TQrFlDdvQeUKAV0iaInyyRea36FzcCjXNPf
	 VkU8L3jn5EXLfGdw8GeCT21/HckHKmDpZueGiGuHgA6p6AsCk6niFx07+fmm9AyEot
	 /3NHr8Pqt/VOQ==
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
Subject: [PATCH net-next 3/9] atm: remove dead SONET PHY ioctls
Date: Sat, 13 Jun 2026 13:10:26 -0700
Message-ID: <20260613201032.77274-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SONET_* ioctls are SONET/SDH PHY controls that atm_dev_ioctl() and
the compat path only ever forwarded to the driver's ->ioctl() handler.
The PHY drivers that implemented them (the S/UNI library and the framers
on the removed PCI/SBUS adapters) are gone, and neither surviving driver
services them: solos-pci has no ->ioctl, and usbatm handles only
ATM_QUERYLOOP. They now uniformly return an error regardless.

Drop the SONET compat passthrough and the SONET cases in atm_dev_ioctl(),
along with the now-unused linux/sonet.h includes. The SONET_* uAPI
definitions are untouched.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/atm/ioctl.c     | 13 -------------
 net/atm/resources.c |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 0f3f9ad8301f..4f2d185bf2f0 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -13,7 +13,6 @@
 #include <linux/atmdev.h>
 #include <linux/atmarp.h>	/* manifest constants */
 #include <linux/capability.h>
-#include <linux/sonet.h>	/* for ioctls */
 #include <linux/atmsvc.h>
 #include <linux/mutex.h>
 #include <asm/ioctls.h>
@@ -290,18 +289,6 @@ static int do_atm_ioctl(struct socket *sock, unsigned int cmd32,
 	int i;
 	unsigned int cmd = 0;
 
-	switch (cmd32) {
-	case SONET_GETSTAT:
-	case SONET_GETSTATZ:
-	case SONET_GETDIAG:
-	case SONET_SETDIAG:
-	case SONET_CLRDIAG:
-	case SONET_SETFRAMING:
-	case SONET_GETFRAMING:
-	case SONET_GETFRSENSE:
-		return do_atmif_sioc(sock, cmd32, arg);
-	}
-
 	for (i = 0; i < NR_ATM_IOCTL; i++) {
 		if (cmd32 == atm_ioctl_map[i].cmd32) {
 			cmd = atm_ioctl_map[i].cmd;
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 939452a610c0..7aac25e917b4 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -13,7 +13,6 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/atmdev.h>
-#include <linux/sonet.h>
 #include <linux/kernel.h> /* for barrier */
 #include <linux/module.h>
 #include <linux/bitops.h>
@@ -361,10 +360,6 @@ int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 		}
 		fallthrough;
 	case ATM_SETCIRANGE:
-	case SONET_GETSTATZ:
-	case SONET_SETDIAG:
-	case SONET_CLRDIAG:
-	case SONET_SETFRAMING:
 		if (!capable(CAP_NET_ADMIN)) {
 			error = -EPERM;
 			goto done;
-- 
2.54.0

