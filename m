Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72C34EF1F
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567440; cv=none; b=uFoz7gOvMy2N/xCXoqQ6KqLhlCTZIFpr1Wh4yjD6y4BdxNtZK5cTE5tK8BO7JSbTECbD7YDYfsO74ILYOG1XHDBCSEg6G00+Xb82rDXfh9rFSTbYDbT1uMm9EPSu9IoKj1JDGJVMrUaLVbhTJQVKMgLbVk1LJAgBAM2XZnl1NaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567440; c=relaxed/simple;
	bh=J6l//22lfe6VaitbfG5t+W+LsoGh3SZrvhf291APJJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EP4WmdxVSdze8pni5DIremsw2NkWXmwCdAwjPQa3kDDCSkVeYH3KrM3Y+b8NyWbWSpKUoOYatRyjWlzMm/FPOzx5waazo03KlAo1g870OvSws1TOAA5VWM/74uYM374fh62Pok0UknvVLUHaEN6d9YaJhxi3ApLczgt1xaHiywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/WxoIMm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/WxoIMm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caed617615so22840205ad.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567438; x=1786172238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eX0Ogtu+yr7SwyEN2U3st9d3s1j8WEIsbSfxpUKZtik=;
        b=g/WxoIMmnPT3LgszSVvVkz+8bIbTI2mO7V58oWKbh3Q3ziyhSU5uVYDLXlaX2Po0Fs
         YcM5o5K0IB/4q6L0ayPt5MWAtiXJxp7J9/Qr9MZEpq/WZEIh0ZtNdqh7ODfiYCFi7Fsl
         t3JBNqtqww7UZzRYQF5orMPHQGbLCgg245dLR+UNcvnu3kr7K8lfrqxXkW9SZAdXqTMg
         VSy6N9rG79osR2a7EtcTvcX7eEE8+W6CnrRtOMGj/0Xek2PfBCaJFboF0BRdzaqYyyj5
         /tp0Rf0KCn+J+yq6RD0b0e8Mp5FQaFOR5z3c7EEEl9jpMEeN3UWYHF9FKaJdwOCBVTTN
         5z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567438; x=1786172238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX0Ogtu+yr7SwyEN2U3st9d3s1j8WEIsbSfxpUKZtik=;
        b=C/N1gOBXb2CcssJZTlo5G4Iolf+NvkbZtMdsZDE9B+P/WflRFYmYy4C9Qh+lxgOSo2
         nlkNhRIvyii471kGbx6vLbkCcUWPHQ07DeBj/dvwG7/OMQ7UIhgUPTnioVIQ71saFrI9
         TCdLbKlgkEUMNF2NeB9QilgLlqWP5/ycogJ2PVuocwDWxYGS+4v+t2ay/yFg0kEFSfdF
         ER7/+SUAhgtSJeMhzsBQZ9ih7FpZvsE9Uo1vkdktbGaEqr6VwV3b+79iVzua3iqsfk4d
         SlQVvlKuAixBS4qTYySA8l5om6dtVMG9ZR9VgBTr6vAcc3Wke45mO/pg7VpW1TpL6xMe
         WFlw==
X-Forwarded-Encrypted: i=1; AHgh+Rpp9NyuYt7OOVEqiys5JqukoWfRusFPc/eH3wuswlnnf+adxkYspn5qdoFcvEzee5bF1M6/Qf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTC+B+YyPwsmQJmkbqilxXd3Pb/vEna0LxNbu/PtEDiV44bC6Q
	56hN/6m3C9WCTMLQW1a1ml5vKNii6YZ2UkLRGwj2mjNGdJXtKAaKKdFXCSOwU42p1UuPHQ==
X-Gm-Gg: AR+sD12to/3ipafBkBgiI+x82j9rgkDvSe5dMLvztviJ3OKx/w+874oUyZEXdcwH7RC
	+EacKwE5QyVixlhABWOCMStAvpn/RnvlytGPhijoGcJWeiks77e3GzTkdWaLOUlJ9qUxeYRtfXO
	n6P/qb+8RITbxyyyKmxVS9W7XurC1glyD0PATQCAeeJz3FjHp/JawkRx9Qg7gWj6GaWdnlyMEtc
	f4+9/SMXvnRNhTUOIv7YxG7ZN06jEk6UEbYf2slbhTDyBKkGxdrPt7+QGUIM/5RL3UwIf9vgpb9
	HNYmeiJe9SwcMwgVZPfREHbkL/CABHmvo5ObOGVjyADNhgY1MuVhrQ19VfdEsO7QwAJhIlMdeoS
	R2avMmhqGri5GKrAWa3CVadhXk1758qBAgcuLJjFP3BLIHmubkfEynt1bP/XG/XH8WsPG3jyjVW
	NJWkRTMBybDcRfrcEPeXEU0BCYbSUw71no37rCaxidr5WvryxXVRYXksfKgrkfF3QWxWyJcxehK
	+JJj0ARp7Hz/UfIE9sxhvxrmxo=
X-Received: by 2002:a17:902:c40b:b0:2cc:f7c6:8353 with SMTP id d9443c01a7336-2d052437b14mr24479315ad.41.1785567438061;
        Fri, 31 Jul 2026 23:57:18 -0700 (PDT)
Received: from localhost.localdomain ([152.59.182.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm19494177eec.4.2026.07.31.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:57:17 -0700 (PDT)
From: Krishan Singh <krishanmohan298@gmail.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishan Singh <krishanmohan298@gmail.com>
Subject: [PATCH] net: sfp: fix hwmon_name leak on hwmon registration failure
Date: Sat,  1 Aug 2026 12:27:03 +0530
Message-Id: <20260801065703.43896-1-krishanmohan298@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hwmon_device_register_with_info() fails in sfp_hwmon_probe(),
the string allocated by hwmon_sanitize_name() is not freed, leaking
memory on repeated hotplug/probe attempts.

Also, sfp_hwmon_remove() only freed hwmon_name inside the
IS_ERR_OR_NULL(hwmon_dev) block, so a partial-init failure could
leave the name allocation behind.

Fix by freeing hwmon_name and clearing both pointers on registration
failure, and by freeing hwmon_name unconditionally in remove while
still only unregistering hwmon_dev when it is valid.

Fixes: 3f118c449c8e ("net: sfp: use hwmon_sanitize_name()")
Signed-off-by: Krishan Singh <krishanmohan298@gmail.com>
---
 drivers/net/phy/sfp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f52020673..f605fb399 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1895,9 +1895,13 @@ static void sfp_hwmon_probe(struct work_struct *work)
 							 sfp->hwmon_name, sfp,
 							 &sfp_hwmon_chip_info,
 							 NULL);
-	if (IS_ERR(sfp->hwmon_dev))
+	if (IS_ERR(sfp->hwmon_dev)) {
 		dev_err(sfp->dev, "failed to register hwmon device: %ld\n",
 			PTR_ERR(sfp->hwmon_dev));
+		kfree(sfp->hwmon_name);
+		sfp->hwmon_name = NULL;
+		sfp->hwmon_dev  = NULL;
+	 }
 }
 
 static int sfp_hwmon_insert(struct sfp *sfp)
-- 
2.34.1

