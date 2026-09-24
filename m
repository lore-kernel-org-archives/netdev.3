Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A73AEF51
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244042; cv=none; b=liPLM+F18lgyaD68pZ0iTN3UzUU7IyvemWRhglcfnxyKMTUPyEqGzjFXSjoLPO/6vn50IhQVmwGrkD873zqf12EZUgKF1SA86A4qHJEx3hm4BTOSlfu0Z/EiotiouwzB4FWMDiJzWOVN8fnGbB3AKudoBMwAFPv/I5Ud6wDoMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244042; c=relaxed/simple;
	bh=nwaYkLbsXfKCJjGkeRjXJQ6s3GI3fNcy0etbBPov7F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pt7VH8RHx2g1Zv5JYhw8+WyKJTByLZSjXkQ6wxCx1vT311aFyrja2EUGV+PJitk4x5dmit+rJk9naBw44qhZRdpQWdNcdkr7TOlXx1Fg4XaCLdOqqECEynM300FZ0MyzmiuNoceK+sV+8dPCpe25fWoxMUmhj06fqjfCl7wK2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnV06heG; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnV06heG"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a4fbc5586so274306166b.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244029; x=1790848829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
        b=nnV06heG/ot2k7wc4CyHxJ9gviveiXqs9gQ/UUcL4UdxKHteC2ZMTmLuCeyW+M1Vkw
         5S+uVnCykbcKSUB+z26n6+gyh6w/cbnAYcAS+Qu1Tj0IHIlMZfzBbsGP/KZbim97QLBR
         ts7kxzl1hOJF8fqOP3q8mTpJ76qhIUUPWir754aSU5q22a/ozyAtFWhbiU0SDnhc44I3
         NMVqcJjQH59KKVGiKKf0IhAm4eu1HSk774hnvWKhE0S2mSAUxprBiypADVZ661BpD6xb
         UKyqH8tXRmpFh29iailXQbcUExrCpNxe83iXyN7gitmHtIRXUfw98gnx+dBYo3XkiCVP
         FoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244029; x=1790848829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
        b=G443lnxeRaevGXFyil0yDWVYvk+qr/bvjvaRb3D0iNNBQqRKQpMe+gY/leTt8/WJhC
         sb9qVaCOuNFD7JrzrM8u1Q7kcWn0gIFBlTbN+Nlz3Wlc8wJcsdlsGZ5P8zMyEeeVTD2h
         kDi6cw/Ko1KRq5aQ5Iq4wpqzmjsrz7eqamxOVPbX1Ihlu97NGlOHn86Cbv2K9CTo6Fl4
         hcJ/vmwpjUckYblNe0gJMrhdOyYQ4J7zJXC8Bg81NaWA4BEC/0WU3HSTsO6qRc684uxk
         CIx7InzwvyvOiCcwCMK6ZQiXkjVaCqpY5PKQyPmh3AiXe/szOh32Aw2EacX1X1CEF/tc
         DIZA==
X-Forwarded-Encrypted: i=1; AKwUvBxnErbujjygrN3qdlJMkmwZQ595eZ2+CFqOgdM36X0dnlBjECcKlJLfqS6KKzFww0C2rWKGuiM=@vger.kernel.org
X-Gm-Message-State: AFuF++mOSyuF1ybNSowhqTU4nhyOBaLhLBXJ0bTp+sMtvJFg6huhkdFd
	ZFZskxG5banG/k76csF5TfQr8bbBhCWr/Yyp64LUiBtq9lXHtX3G5aff
X-Gm-Gg: AYBFou1zhDvMqjm97fgWsGEscTEUKpAYXAUxFnjLAZfk5YXRJoTBSoaRtUaljKrPiIs
	D8WEtiIuf6fG/UcyRPf0+O/IIu9nCGuca0EXqiOVg5GDfRJP6jbngfPgSRbHcLC8zgcK5xOhfRT
	sjp8jJVJhFYLMt6ldHDRvwkckAIBT/9Ew5TLKYKlnoOOAALo2xCd89J0jbqu4N6cC36kKjxo+9c
	wlNTSW/i6MB9DrQzkok0a44aO2nTTDSLqQ34fRELF9eY7Bkr37haD5qLW1/Q/A/1MGrozURkLmA
	E4M7DOLEaAhs3Ip8RD9zdZ9spqxKEeVBfdD7V8Y7udKgBMI6TbPMy5Yxsm3pokL8aItH/I7xuPJ
	td99Cf0fnqfAbJDWCiNH1pCkXqiN3oPMFgU/kio9/RFzRiWtqQ3eEEPwAeYA+NmVnrxWs8ENqOo
	QOrkpVwdY5Im78VOjVp0cmVAogE8dx3hpqe5bgxSRln9KrfKEwzpqTI8umVJkwGVZjGzoc8bedE
	+zr7p1lHkAB4AkX
X-Received: by 2002:a17:907:9407:b0:c29:f0ec:1c15 with SMTP id a640c23a62f3a-c2ac20ab89cmr165652766b.6.1790244029398;
        Thu, 24 Sep 2026 03:00:29 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6682d3sm260123766b.40.2026.09.24.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:00:28 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v4] net: e1000: fix warning in iounmap on probe failure
Date: Thu, 24 Sep 2026 12:59:55 +0300
Message-ID: <20260924095955.3471-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When e1000_probe() fails, the shared error handling ladder attempts to
iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
not a CE4100, this pointer remains uninitialized (NULL). On architectures
like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
which is fatal under panic_on_warn.

Fix this by conditionally unmapping the CE4100 MDIO base only if the
mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().
The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
be valid for all error paths reaching the err_sw_init label.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v4:
  - Actually include the code changes (v3 was sent un-staged by mistake)
v3:
  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here
  - Added missing Cc: stable tag and Closes tag
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..d7e279b739b8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-- 
2.47.3

