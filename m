Received: from mail-pj2-f36.google.com (mail-pj2-f36.google.com [74.125.227.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1E4AF9D4
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597965; cv=none; b=PhMyUURYD5vuJKnyHVf4SwyC9h8kpkJy6eo+2JfrTqJofOfIkkyvgGHJlUuZZknv9Ovk4hzN9O8kI9nXXPkSbJ0Kqp4a01DK4BBHP/y+hwrUmU/hy1MTRKKI9oqNWsUjeUzxeP17knxn+BXxbeHLE3PLb7Im+aN10W3kihCbmNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597965; c=relaxed/simple;
	bh=OePzPtD0R+PtZosUTEoiidRuyc28dNYQ/5qwGG0tzZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBpYyHjkH8Iw0yo62oFZ96g+wqlPf+2iqagzz3whb/lzADqrIfO+QRBp5J90/FjXu7lJJ1+9a00WRMeJ8haWoLjIkpmnAYOJRyt4BHdNeo/9RC3uyx5j8NoJByT1EuagAhRQwrX7zzPyyR0/gKa8k3Z153WDVXCmlvNivIEGFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvchWbNz; arc=none smtp.client-ip=74.125.227.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvchWbNz"
Received: by mail-pj2-f36.google.com with SMTP id d9443c01a7336-2d8fdc579daso2050395ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789597951; x=1790202751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OA4YpSmKtbbMI8cZnUw7O9PGIOCz+Cb/vxkUZS7nVLI=;
        b=FvchWbNzMrcnrtnnW9kuR2hbgrEDvGGRMdgzPv/zSam/SwSwIm2PAsXF/lnIw7tcNs
         hwRl8YLCUZDD3GZmr83bHNaO/vlc0uR5rChB1QY+cmklR9RR19QVXl8oX6j05QfJGWvN
         YzaaMvnnlcbMrUedfP/oup4lbdnibyMjdITq1ya3s+QLR8vc+xg8OX9jvwxzH8/nypw+
         XDjeh96Xqn3LxvATguD/doYT1lR4M9wH7EtEBPnY7Em/3PzO7WKt8CLHEER4C0DyaL3y
         kLizY9QRLReQHLV1Re6yy2EfkkkGwMMzGkUWY2xist+O8Qhy+xi0ptxFDAek+iHY1Tpi
         CBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597951; x=1790202751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OA4YpSmKtbbMI8cZnUw7O9PGIOCz+Cb/vxkUZS7nVLI=;
        b=cZHDiqtE8rxVUiig2fJ5lyKXtk63J27+XXL86N11IJjY/44BxMYgk32mbJJpkL+D5d
         9B2hr9FJxPDhs+96/czLs1AxqfzifeDFl2PC/V+Op9Uhnt8233HjhnfsGWXxjIYxOieL
         jlgdI5zdKIlPwhvNpeV93YJUyxvGryUQYSzxhFuxSKidHZwRFP61PfEiPKOKoYS9rryy
         YrXR/YMv2lKdqp2a/Ccg7tjZy7Pm+XUNXBinUmrevMedXPhbZzK2Tz86ZfR5dTs9Oeaa
         SZZBs5EwsuGe2M4Dndqtl5sdEFDw79armtf2Tfp3vzRiUME/p36bfDcnE5X95xIxPc1J
         wdnA==
X-Gm-Message-State: AFuF++kFazIGrvFJWFwdhALLPStYyVw7WHPJx+G3RSknfWFDqWUXf+Qy
	Cd0jKvfc+vuvkXj+djTu6uHQrCxMoBTFwIR422WyTqtMtCiodvGmr2VsU3d5EQ==
X-Gm-Gg: AYBFou3GLbA6/Iqbm/Ea6n4CIoazPTdalpZ0qLhpAOVPlIJaXK+h/N0FIlOmoo7vVYy
	hBRq3FaRaqFe0w3irIzmQjygyncrz10m+uoR/0bmjm63thlI3YRA5sY8sHNYx4JxeTYgpcNPKGg
	tzM1dvOW/S3g27BETaXPEAjJZ72cCMIrdQztH43sijtW013VOphcbqUeAyWySCr04jfUjYkSWON
	lzxH+azae9PkN5pp8oMrszOFVw/2IyX+2NzgtEbWr+XAwnREF/gDfGZuLM5eerpzY5RwOPiInx6
	ipigqaNwLb852GoKgVoOAPnpv5SJfnLyVFsooctKg+0bykb3V/2hpdBcaTLrWOGgqgt20JsGRXU
	8Senofuc4JXpIOnlwPGvcwZo4xovbpMpHIuxX8hTzhsuCwNSlGohgPFSDfcK5WCqiRFX/95/YT6
	NaIjKccUo/n1ufoPCTArwkHRF4VWkdM74D6y4fkCi0VYg7oRQZCnjtGe3UwTMPRF3n3zi6CxGVu
	zU9/Kbliho6MnBuYmO3dzfnnd/ov9NRwn/lPJrIvFBSFSPwPkJE/9y4NHIi3PrIojZCwepB1Vy1
	dQesDarvMF3aKOYjfc2/oD2WtLfZ+GL2J4mbdkHIcf0d7MPt
X-Received: by 2002:a17:902:d2c8:b0:2dd:278c:5eb with SMTP id d9443c01a7336-2dd8e3f5a13mr89519665ad.14.1789597950982;
        Wed, 16 Sep 2026 15:32:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a182sm10744788eec.8.2026.09.16.15.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:32:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: fec_mpc52xx: remove dead resource size check
Date: Wed, 16 Sep 2026 15:32:28 -0700
Message-ID: <20260916223228.271815-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check bails out if the FEC register resource is smaller than
sizeof(struct mpc52xx_fec), but every in-tree device tree describes
the FEC node as a 0x400 byte region, which is exactly the size of the
struct, so the condition can never be true.

The error message also points at mpc52xx_devices.c, which was removed
in 2008 by commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and
include/asm-ppc").

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: instead of fixing format, remove the dead check.
 drivers/net/ethernet/freescale/fec_mpc52xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index 90379c26f300..dcf378a02835 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -834,13 +834,6 @@ static int mpc52xx_fec_probe(struct platform_device *op)
 		pr_err("Error while parsing device node resource\n");
 		goto err_netdev;
 	}
-	if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
-		pr_err("invalid resource size (%lx < %x), check mpc52xx_devices.c\n",
-		       (unsigned long)resource_size(&mem),
-		       sizeof(struct mpc52xx_fec));
-		rv = -EINVAL;
-		goto err_netdev;
-	}
 
 	if (!request_mem_region(mem.start, sizeof(struct mpc52xx_fec),
 				DRIVER_NAME)) {
-- 
2.55.0

