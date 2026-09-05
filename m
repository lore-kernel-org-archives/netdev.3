Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9F248867
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643216; cv=none; b=iHq+22cNFl7yKrzHAU7DsIrSx0n0h28MA2pYMvfGeByVCTx4zpefw0Tg2NlAXL7giiwwC2X9sEkexFlKi5sLOYt8rQoMcjM/EZ4jPeW4g25oHcB2QseGIq5DpD5cez9zgkwv98kkj2QiocyktwMGSIdGPuDVaOc3gLLrg5FYQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643216; c=relaxed/simple;
	bh=+093/8nJcghhGC0+aQbMyB/IiX1dcEQCPmfynuD1PT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gR8aHUKqeISlhpgOQg/NdAhRCzQs9Jvcamiil7NZR7ycL/vUeX5/pQqL9Q2RSMNWiuB4yNfL3rnD9SDRmzZxRkF7t+slt8L1+X36RdXxKjdx8sHWwDkCbnEVzrqSXMHrLUQIzk+Nj7kGVeDa9dTGVAM8pmt2OdqnV0uBFcyVFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj8/X2fF; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj8/X2fF"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c2c0df0b45so892673e0c.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788643214; x=1789248014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7FSrd7fhnbDkTGOB44nrfKkV94WPiP6EXXWHoLjWLA=;
        b=Xj8/X2fFcebo2KtZXAV0JZLEygS4r3qRvEdEy6NIfLBaFDEYitP162XjAyXsp74rG8
         RtzBRrYRBJ1nIR/RvVGe2DdjagI6/SL/B/W2FQXy90a9DwsU5xO9Qjq6fRzeWHp4XrYJ
         T2Hch7vYhTqSb/PIFG7L0SKA7/9FmC/V5iaA/7fladLDnKyg0niU9cHkDDBOkYmLNNK4
         6L2mCodBfq1Sl4SHzfSKywn9kXjTRBKMB4VhaKh5PR1YWakMvn3/MwBF0lTvd1lqlEdC
         cbFAqy4nh/dzcg2QpJCcSY1qZpLX4HU50tgQ9sdT/++WpEP7VH2zA2izR5SqYufcCkLG
         DFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643214; x=1789248014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7FSrd7fhnbDkTGOB44nrfKkV94WPiP6EXXWHoLjWLA=;
        b=V+FRAmga9lx56TOn2OPe1P6AXz+/A4pecmBHBdZtcCksK5NqxZFgwGktofBgVGcuXj
         KexKtECuwrLh4+n0gncvI9YHHekqxrpu66n5xHhRkmhyDsrhzI2qKr4KsVd0eMeApr/v
         I8lku/l5ZTsGv2tB6yQKxBnZOvNnUJkfBn41+tR/iH8yHqBT1p3xxyqDDQ9xgXIEVKZP
         AWF70FDqzJGOLpLoGgMqHtokXkCok4cMFPViM2btdlykWVjsaQcfCQOY2EtfCTurkcf1
         wwAHeFkHksVKifzM7UmtqPVGFhVs5LTkqlhJs99DeLh7HZX4RluhEWg7Ov5bRKlNoVPo
         YWUA==
X-Forwarded-Encrypted: i=1; AKwUvBzYuZ6lOy1tpeF+Ww7HswH8UZA1+Z1hRLuzkrAVmD9w4jRMvgaimqEVs+3LNOLM0oBJRSgSjOM=@vger.kernel.org
X-Gm-Message-State: AFuF++npg8qfHHxT+q7em1ho49b5IGbWEKf8aw8ChquKGajWPqb7WRFw
	SpwyCKoalsjSVtdzdo0IXIIzSZkVVokicrG91mOFB0ed8qCMJItqCjomUc9crEDS25w=
X-Gm-Gg: AYBFou3c5ZqNlD90ER0kC6DXxM/VB2fTgDYTexrSC/LUCGAA1qnYWeGXqL8izGzjjZY
	LEWTFyiJP2w0eLsR8JyQwQcJeWqIp7iqrK1cueKd9CJcAOyMq5PC7dvRLnpeNrDL93wkxwg3SBu
	YpMMBsL7QHYPuG5cxXnxiVHKW/b/EsW+2ZVe3WBGWVKkrrE6kMB5U0+B4Yzf44dammLdIryqPTN
	S8XJJcJEZYrfnKuDmWKwE2w9Bn953WsA8qZhvLjgTx8WCOt8OekN9MAxdKYLf9dHjX7rICTI/KC
	+hC5Ju1+T2ZgZ49ddNeSEYABBgSpXl0sbSdpZKJ8Vt0FXBP4ygg1a57TvhjgCHNcXlTEmFkVSR1
	XZH5PqimzI4ThnVqyFa9zyuxterOOh60mg2x+0FsO01khoD0+QShlpf4WOzc69cIBWFv6QQbaBR
	aGLIVKTO1My+SEMAmQRdGOwF3X7/gPzqWHZUtJRhzXBW3GI75L8BYK
X-Received: by 2002:a05:6122:8b03:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5c7ed38607amr5766684e0c.0.1788643214275;
        Sat, 05 Sep 2026 14:20:14 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1097e5sm4901956e0c.2.2026.09.05.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 14:20:13 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 1/2] ieee802154: register a device type for the wpan netdev
Date: Sat,  5 Sep 2026 17:20:05 -0400
Message-ID: <20260905212007.304875-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cfg802154 netdev notifier never sets a device type, so wpan
interfaces lack a sysfs "type". Mirror cfg80211 by calling
SET_NETDEV_DEVTYPE() in a NETDEV_POST_INIT case with a new
wpan_dev_type.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/ieee802154/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index c0b8712018a1..c6213412d291 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -272,6 +272,10 @@ void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
 	kfree(rdev);
 }
 
+static const struct device_type wpan_dev_type = {
+	.name	= "wpan",
+};
+
 static void
 cfg802154_update_iface_num(struct cfg802154_registered_device *rdev,
 			   int iftype, int num)
@@ -296,7 +300,9 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 	/* TODO WARN_ON unspec type */
 
 	switch (state) {
-		/* TODO NETDEV_DEVTYPE */
+	case NETDEV_POST_INIT:
+		SET_NETDEV_DEVTYPE(dev, &wpan_dev_type);
+		break;
 	case NETDEV_REGISTER:
 		dev->netns_immutable = true;
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
-- 
2.51.0

