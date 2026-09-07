Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42437A834
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756437; cv=none; b=kLTeMYBQyf+/esKyW/XskLrMHEEPjCJp29pI2IlO/wMtfasisYlqJ9aj7sNle/Ix8Bv+3/oSwL0xme7boL8rIffDRgQ67VT4t3+R4sM0WDDsGa7NdH833NqTziLlhiYtVYMG0MDmovPq04nybNVe6i785O7FlBPo0KlZ7noT1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756437; c=relaxed/simple;
	bh=5Z0cdknBFIlhM01g731hrLfDIHFwyL/2mrLrM0spXtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXL65p+C3ehnb0DV4kYAo2e0LoW3t+uupb2nNXkKcbWFlKNCz39E41D5y0l7ADPs1uUl+H+03IGMsmVBEgzaCPzevcDi+25g4uLBRruecCaeXeWLnZDGrkIteaoPZt+fiHwDEBCMkNQ3MXOClsZrWVapMOr2qM569kfYw0/aoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2A29dnD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2A29dnD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d91ff7d9acso25949075ad.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756436; x=1789361236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=375o4BJGgHmxnVw1lMhhu/qJ8TmCINoNbWz0ZmrSte4=;
        b=k2A29dnDqZVywXg2Ct6zrSS+cCPbC9n6xMI/8Edq3gp0XyUEMx0T7YndQRroLpcsQH
         YLN/CsvSo706RvhJAX+mWZiPJpNlGd+66RVzMVh8ZPo7Xjqf85mePJNROjr1Kp5erfr5
         wAwbEOB87VEXwujqe2aq64ypN4m6qrBAsQTWbtnOHB5sBUqTAFzZXad35x/3v7A9sAZh
         SQmfj/vl2eIdH3X0cAsamVqHdotZcMZlXdpl9veVKQynHlY9+qtCBCUAKfBGswSXAV0Z
         ORa92EJwtYvnWBhDxbhs3FLOd3oTVFp7Cgxm30+q4JJBSICZTwzNspbVl69Fij2kzYmj
         aZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756436; x=1789361236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=375o4BJGgHmxnVw1lMhhu/qJ8TmCINoNbWz0ZmrSte4=;
        b=YHcLV0zwklDYwp65f/TOh06sr13ecfEUKxlmbGuEt9nJw9aD6tStH4e2Zu8krIk85Y
         VqVDnn0kZkEruYWqZKuCyfFONC0gUwkm7euQAbul5IPeWJBWKBWX5j7QOcuEzVirLf+S
         mOg45ly/Yl1XQG+Z0e4OO8g+TUX1b60rVIWe+70gyBDKj5cSUcAAtBmiu0GqGOtAaWiH
         SOnwAHj5l+ymszimyWYkK7JL+N62IkGUeyFM/MJkMfQGbklCepbKSIkGnd1p10HcTYpI
         xj4BRbfPgFd5OJOYlCCe6ZCaACGA/5DBdR41GRddg/sLMzPoPGIH6VPXAe0e3JlDz+x+
         v9AA==
X-Gm-Message-State: AFuF++mZOuylX3dhZQq5Eh5SdDMDf1QEz5Wd2MStqYPE0oHafg62hwfi
	ToqspgnG86+ozsElf1e4cQT7CmDRscqCDEs6tc2fxNVWtCFu+365h9Uk
X-Gm-Gg: AYBFou35oZU/pFFJsbv2ANPaTRH6ZE6VFxwWNaVYaS0RpcbPsJXJZdq4w2c7PwNEvrF
	VFKvKXcIJLoOmh2FT1aPBAk783fDA8cF5eOKLu/P7XYFpxlKws/wKc/RspSiZ8X9km6FqCfk8hw
	icpYZ1UMkCl4AqR7TiRPRUr+d/nfS4JQCxq2DT77sQcRGgevVd2hAyoB5Z3ehyKEpK5ipl2WV2A
	jppLzxKCL8AGSjxf3G/8CuzpLTEFQjYRJq3xMFqG+VItxpKtaKZA+fxcUDr1lAblEeawEJWMtE+
	I5E7gBftZ67HYkUkbg3kYYPGDvAABBzsY6O841mDnXfAQceSfIhP9YX8gZ/qbQweWSGRmyMywD5
	y2AA/y5gcgCfDxALVW15GGAz+FyA3LS5GZt425chv9BfPY8IXD2MJeEU4Kb3oVYSp6lCv8CpQeR
	KwofoOj5T7UbDPO34bVZ50Vp2uzvH8LRL22VA4geJMggK88dJYr6ctqQxtNZkzb0WS9cDPkhouj
	f7ygo3eeAejzdJzV0GenqCD
X-Received: by 2002:a17:90b:4d87:b0:380:540:d499 with SMTP id 98e67ed59e1d1-39b26100bfdmr28314536a91.6.1788756435888;
        Sun, 06 Sep 2026 21:47:15 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm37844565eec.16.2026.09.06.21.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:47:15 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 6/6] net: usb: fix repeated words in log messages
Date: Mon,  7 Sep 2026 10:16:35 +0530
Message-ID: <20260907044635.7141-7-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044635.7141-1-hemanth.selam@gmail.com>
References: <20260907044635.7141-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the words written twice, reported by checkpatch.pl as a possible
repeated word.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/usb/asix_common.c | 2 +-
 drivers/net/usb/sr9800.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 4f03f4e57655..e63a849a1043 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -413,7 +413,7 @@ int asix_write_medium_mode(struct usbnet *dev, u16 mode, int in_pm)
 	ret = asix_write_cmd(dev, AX_CMD_WRITE_MEDIUM_MODE,
 			     mode, 0, 0, NULL, in_pm);
 	if (ret < 0)
-		netdev_err(dev->net, "Failed to write Medium Mode mode to 0x%04x: %02x\n",
+		netdev_err(dev->net, "Failed to write Medium Mode to 0x%04x: %02x\n",
 			   mode, ret);
 
 	return ret;
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 6fd33a5b2279..cce0392d0232 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -271,7 +271,7 @@ static int sr_write_medium_mode(struct usbnet *dev, u16 mode)
 	ret = sr_write_cmd(dev, SR_CMD_WRITE_MEDIUM_MODE, mode, 0, 0, NULL);
 	if (ret < 0)
 		netdev_err(dev->net,
-			   "Failed to write Medium Mode mode to 0x%04x:%02x\n",
+			   "Failed to write Medium Mode to 0x%04x:%02x\n",
 			   mode, ret);
 	return ret;
 }
