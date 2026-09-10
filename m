Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E63AD510
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084479; cv=none; b=QW9DoDateQakXj6TB2XqktOMO6+r8t5B0EqmeLbm7siHY5qOhRBj453ukFhjPY9zoDN8TbZNRk2XVGekxfi1q+2HYBys2arEk1AnrkfOaAYXAApOgBd0J0Sk0TGfYbItfeelacOZxwk7smBCZaqSLnvtRlU7EdZR/m4CJSiiKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084479; c=relaxed/simple;
	bh=xtwXIZOGEy5UPVOOx7FUe2g9BLc+qYFqk68bmhTQ99M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7mtp0BRx5QtUIeN82DeF7hujC8Ft1fhYtPCynpjCLW/8Bgz+TEF5JJa4bH07eHgZsEfcPKOkN//WJ+/e7KYC3IRA5BRhgA1rLrudYyUHcevuNun5ost95E+RZ8P8UMoNx0gYMzLEFwpGrn/PIZfPhbmBaKAUaQ20nPahh7CTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQvwkXwN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQvwkXwN"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52ff0b7c98aso4833071cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084477; x=1789689277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6Jijc6okwul17I+K9OvRXUy0M5JwDpgrdpc+hLNXWA=;
        b=FQvwkXwNsIqteS+yvvXaKi0hGm5Mqa9IylVV+EQu1/0z20/7B6PIIVSVKbMkpj/WzD
         lGrEHRAPfUoacDPgF08Ou10KOEN2+cO2BKx5gRt2HVD7pwyidXBxrhqv9/Cw8gHjUPvm
         DYoj4QxEU63TsyP3LTnulEXxa+Z1IAtzADzDOw/pCYNirM2JTkbD9114fEIGKSRkVYzA
         zCO4kvFnloFTmLSXZrlWUa249wb1HWjhWfn4q7sZlLkMFDdphkXATqqJpLLeTVtiT5ei
         znpHKIhoob0lZRqh0Qp90okSWacnUUhAB7GvAaUnfuimzDuovabSZouF8EEYtQwXAb6U
         NWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084477; x=1789689277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6Jijc6okwul17I+K9OvRXUy0M5JwDpgrdpc+hLNXWA=;
        b=k+UbN9btZGOm4RPxr6wAi0NddxjQsn8lISnonGCy1wuicDsNfQOMbttWvyv8T1HhKH
         CCk+zCozEhrziiYCkoObVsXcDPC7hE8zQL9RHdTdUlDh0/FUVaml2itnyjlxMKqJwbxn
         YtfzVD6pVygQFWTtjfGM5hHRq/5jbkWSrW+uCT7+WdMrzRyt5JjHnm+h5IT2lTNoOfqu
         R1l3I1vHThBIJA6RQLEgKL7NOjUCZsFDCtF31G2VpAPoS91d32/asgwPIr0jDA/NxS4+
         MC0C+s7/eEzFE3owrn+BC7n4kKGoc4ZhudXQfPaULOFy02FjhTGKzW+Ak+8+Bwx6Y8+c
         Ofiw==
X-Forwarded-Encrypted: i=1; AKwUvBxLwcqgFyRxDK7+ngO0ur5oQSxb52+eKmXP3RLXqoi04f8r0woSALexsJmufQnF0+YfMnk1fP8=@vger.kernel.org
X-Gm-Message-State: AFuF++nSXvau5j2otq4w2m1Mv08k+vpZmtf0j2tombifntZTySuVqWvX
	GvJjE8YRpLL/6xmBjf6hVGYqQes2HMjCF90tOQ7b3laMF66ghy7RlQk=
X-Gm-Gg: AYBFou0rkTpmZZP6z6HAAF7aW2p+L/UDLhOizxkR2bu0USo79QZWmdqafCopuRBUBxk
	DHeuRjbI0XyFQpBv0ysBw6L8AfK3/Fecdqu4d1KmNBdyMA/S5bZ2vZ8M2haHuOTbXBuSDQYfAS2
	0bgcDOKlstr2wLFsHvngIB04gT8NJDhF3G/tAq4IqsmlLkJzC3u/7n6lmE8yURYWlZAoUBriUIQ
	P/88vElwsJj35Y+c/028JNIr0N9x5uYI03/6A8mb+Lx0AWto/HEMrU86fYpQbKSzBx7lqb8uhUw
	pN0opkaXYgsQyc3PkKZRkYa6d+xqMj+08gcC7N9BVQznayPDeHfKLZQHNLPPPJ5PMmbN0aaekmW
	hpO8VCUorC3cI9ANFeHkWEAvc6Hv/uhiZcnmpL8xy41lpEbtrIQHnfstrf5pqtmxHQaSrNtp+Dh
	IyYmtnPlZDnKxMZx1STvthZMQ489M/Y8SnK9dM0mtSPSI/4bx8ExphZXLTlHLfrxvUqJiGFA/L9
	EyRHrFc+ZTLklzBKvhMN0XlOi4M2y8+HN4w5E68sfetXjdNV+SV5kxfNXlzPa7SRKF6qdVAH+2v
	KboKmIpQklArCRNRGoWoG+L1dMNn10gm7NQ=
X-Received: by 2002:a05:622a:1389:b0:530:b2e4:d5a2 with SMTP id d75a77b69052e-530c87a548amr28704191cf.61.1789084476627;
        Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/4] net: wan: fsl_ucc_hdlc: allocate suspend backup before quiescing
Date: Thu, 10 Sep 2026 19:54:28 -0400
Message-ID: <e83f6d9871c4110959ca234f618b3878d5c4f648.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uhdlc_suspend() detaches the netdev and disables NAPI before allocating
the parameter RAM backup. If that allocation fails, suspend returns
-ENOMEM with the interface still running but NAPI disabled. The PM core
does not call resume after a failed suspend, so a later close attempts to
disable NAPI again and can wait indefinitely.

Allocate the backup before changing the runtime state. An allocation
failure then leaves the interface attached and NAPI enabled.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 82796452e54a2..596f4ef053636 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -888,6 +888,10 @@ static int uhdlc_suspend(struct device *dev)
 	if (!netif_running(priv->ndev))
 		return 0;
 
+	priv->ucc_pram_bak = kmalloc_obj(*priv->ucc_pram_bak);
+	if (!priv->ucc_pram_bak)
+		return -ENOMEM;
+
 	netif_device_detach(priv->ndev);
 	napi_disable(&priv->napi);
 
@@ -897,10 +901,6 @@ static int uhdlc_suspend(struct device *dev)
 	priv->gumr = ioread32be(&uf_regs->gumr);
 	priv->guemr = ioread8(&uf_regs->guemr);
 
-	priv->ucc_pram_bak = kmalloc_obj(*priv->ucc_pram_bak);
-	if (!priv->ucc_pram_bak)
-		return -ENOMEM;
-
 	/* backup HDLC parameter */
 	memcpy_fromio(priv->ucc_pram_bak, priv->ucc_pram,
 		      sizeof(struct ucc_hdlc_param));
-- 
2.47.1
