Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AFF2F7EE0;
	Sun, 11 Oct 2026 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756120; cv=none; b=FU+GH/96V4lhMlaJdsQ2k+/g7YfG+uF5hsn/kjRO5ym5Pgn1XqXGquEMsGPxpp3KXr7QoNgWHpfOT2r4x52UitdZtUUFnGLk7/ifN9Y2/ODv/iipmMiDTUwRYP4XwcuPdCuT1NaZXQLsj1MKAYZHlyClruEeoEZqtT+RtBaISeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756120; c=relaxed/simple;
	bh=1fW0XKYtdagdZuFVD5Q5U2KR8FhzkEtOyk1ibS6hp1g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M8nrmbtnn1bVsYlmFhSWsadVBjDsvRWDPvGJ1vKbdSNWGs6TMR0KeirUQ9S/DjG248CtdVWLOYCX95gKAJEFqdZtia/47QRZgCiFxKjLQjw4qdtY67JrU/JGPRSLYZUpK6mivjdbbAZIZ1e0/rhAVfPVSFhXiauEPWsfzePr5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFXY2cuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFXY2cuj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6FCBC2BCF5;
	Sun, 11 Oct 2026 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791756120;
	bh=1fW0XKYtdagdZuFVD5Q5U2KR8FhzkEtOyk1ibS6hp1g=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=EFXY2cujf1OPa95w6QTbAur5NetU2BWeJpadFEwbjy+qlGU7SEgEvwyGOog1a6Ys8
	 Nj8WGOoYheVVH06AWIM6Qkaq4TH5cL46AiwNHLhmMqGmdyE9OhX08RR4V7OHmeVGLb
	 R6JVVAFIEehe9zYE5niorO0rWCluBKEsq/uyhcmwjmO4Q7JfsJQkNODd/dOZ3XOkg4
	 A3d95yF9U4T3ZXty2QtG+0vweKyRqJBoCv6DSk1FfCEKLDIyWN5qdnNxP0Ij8fZ0Ff
	 GoCpnItwNRCcS6GTG9cPgut+col+o9wTbGSbU1hWtt7S1UPw5DE49JG2uSKIcil9qd
	 Bb5UVDcGOW67Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5DDCA9EBD;
	Sun, 11 Oct 2026 22:01:59 +0000 (UTC)
From: Haseeb Malik via B4 Relay <devnull+haseebulhaq55.gmail.com@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Subject: [PATCH net-next] macsec: check for duplicate SCIs before
 registering the device
Date: Sun, 11 Oct 2026 21:57:11 +0000
Message-ID: <20261011-macsec-early-sci-check-2b1f06af193f@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791756119; l=2042;
 i=haseebulhaq55@gmail.com; s=default; h=from:subject:message-id;
 bh=3yrY3KSdmX2Lbj0TP8rJOIrBxb8TNoGAzNCgkYC5p74=;
 b=L5t3/FxbcRCZzHeu1Bp9cVnk4u93qX8LBwHeRupzFdJL6irVlyKzONIkG1rDbzH+NS7LSCIfl
 wByRJDDreD2A+fJATZUFNk1vaZng9LpqZUgYgZUPGwOwqDl7RLhyyWo
X-Developer-Key: i=haseebulhaq55@gmail.com; a=ed25519;
 pk=U/yCVc6cTsqDqxWLzvoONZ7DUA3EfRU+rfO9Xxo4p2w=
X-Endpoint-Received: by B4 Relay for haseebulhaq55@gmail.com/default with
 auth_id=1026
X-Original-From: Haseeb Malik <haseebulhaq55@gmail.com>
Reply-To: haseebulhaq55@gmail.com

From: Haseeb Malik <haseebulhaq55@gmail.com>

macsec_newlink() registers and links the device before rejecting a
duplicate SCI. Registration can emit link notifications for a device
whose creation ultimately fails with -EBUSY.

The SCI is already resolved before SecY initialization, so check for a
duplicate there and return -EBUSY directly. Remove the now-unused unlink
label while preserving cleanup for failures after registration.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/netdev/ar2KmwhtCMbOKLsG@krikkit/
Assisted-by: LLM
Signed-off-by: Haseeb Malik <haseebulhaq55@gmail.com>
---
Tested on arm64 in virtme with KASAN and lockdep: all 15 MACsec selftests
and 80 offload/cleanup cycles pass. Rejected-device link notifications
observed by the diagnostic drop from two to zero.

 drivers/net/macsec.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 409fd855235ba29125e39bfd80e1c5656aea784f..4e3020586b1e53c5a17f7e31c1f15b87f6443e17 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4264,6 +4264,9 @@ static int macsec_newlink(struct net_device *dev,
 	if (sci == MACSEC_UNDEF_SCI)
 		sci = dev_to_sci(dev, MACSEC_PORT_ES);
 
+	if (rx_handler && sci_exists(real_dev, sci))
+		return -EBUSY;
+
 	/* Registration can notify listeners before returning. */
 	macsec_init_secy(dev, sci, icv_len);
 	if (data) {
@@ -4284,11 +4287,6 @@ static int macsec_newlink(struct net_device *dev,
 	if (err < 0)
 		goto unregister;
 
-	if (rx_handler && sci_exists(real_dev, sci)) {
-		err = -EBUSY;
-		goto unlink;
-	}
-
 	/* If h/w offloading is available, propagate to the device */
 	if (macsec_is_offloaded(macsec)) {
 		const struct macsec_ops *ops;
@@ -4320,7 +4318,6 @@ static int macsec_newlink(struct net_device *dev,
 
 del_dev:
 	macsec_del_dev(macsec);
-unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
 unregister:
 	unregister_netdevice(dev);

base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0


