Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBE3B42E6
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552662; cv=none; b=LGIhIGQYQJFuZqAYWVAORO2FuljW4nA8eHJP2EB3HV0QyVuzuM8Fcg7xTwP6V9FCMiDC0gmLVQixHo3GWp8cwZMxCpfQXH+lwxQg58BURLj5Mp88F7aahlRRVydyW4DVTR4mJ8zleKkia/BercjSDY/7KKrk6SF3D5Ns+4PSNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552662; c=relaxed/simple;
	bh=vagjNGdyl9oInZTCnF6670xCfjcQJLjN2tge5WycSOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSJfTBFijYsmvMNlniw3qb5NPtrZpQm+xHlk0hjGb3vNy9B1PADl0IDq2arhYcDAxsxIUfa0dpT8npx6kGq54rXqMqD4fBBIV4uETsXIPHqCiktAWCEVMvGWpBuwvWaQEaVNDEx5pCRiQg+js8If5udvCoVFvqaF/EVHtBkiIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScSv8gFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScSv8gFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C808D1F00A3D;
	Mon, 15 Jun 2026 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552661;
	bh=JWSoMeIzBgrAKi8MVH4TkcJoLoP6HwP9YPHAZ+d3OCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ScSv8gFo1Dv3k/3fjOP9JR6mit+KDBOcPZFvt09ZKb8NbwX7zDgvXiPUeTmHrXlOc
	 JB6BsAASGOL8t+LHLwWlIBDqj6zo5UEOHgPZhGJgLL94fqS0B/cZWSr1odxAIPLmCt
	 As2yo5vsupLmHZ6CS3YJw77wcRSqtuXOll02uJslwtpYx9+AAe60d8wcBFIeRKaGuJ
	 Rgt+FwO7v1v+0bufHQHb2ShINahlCC894g5iS+NSoRlmrZUnCsXK8r7fKetofRrpxT
	 6/YCNoXi4djznnShavPqYKeGdjIg8tz6OVBlsTBH1r9I+TX9tuEN37ZxAkHKb3Yipx
	 pHesUrchK3wTw==
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
Subject: [PATCH net-next v2 3/9] atm: remove dead SONET PHY ioctls
Date: Mon, 15 Jun 2026 12:44:10 -0700
Message-ID: <20260615194416.752559-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
References: <20260615194416.752559-1-kuba@kernel.org>
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

