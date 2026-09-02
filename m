Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEFC3EA949
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382969; cv=none; b=UTw+R/kV7jSupkpyYy3K2WxPh2bIFVCEcmaiMwtUHdAI8xmRPcwdWjQ765uiY15hvNVhU2I/UFOITQM1lNbV2w4Xk/7jMB91oAdqKHmXU5S3sZcALGwgY6FHpWwC3o6z8NIDXHM8tZ22DjV5TN7FlYC5oB6UXUzqZCO245diwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382969; c=relaxed/simple;
	bh=07ACrW5zkIgUmTwhlib3E6Ezj8EphHq2ybDKAfGthPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMYKYaTAfQ4X7C47NGuP9KfqwGgMrMPocfa0RGpnKJ16CMv8WZOftfmOUQ84HBJ5OtVHvggvRXv7x1QB+bSvTbnvQzrKqAZ56b3XOciyUChf2Na/SfxYIAlxpZn9juVJNTSNbMvwVnXoLrKhmpl7eSqEA75pqMG4Y0UNpECAZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX7YX9Ux; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX7YX9Ux"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so1711382a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788382962; x=1788987762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zMLlM2fX1xLcX/WTGlvxUY5Z2fLG31XCRQQllFSHGs=;
        b=LX7YX9UxGKYOlkuVD7wejO+u1yMkc1RuIjLmvpyYvkEX7WJj0yEupyzlndJj5FZ0lv
         8WV+AjG4xB++rNFMHkP6NpH0b8xJ8wjZd8Fw/zplxJpgIaskOzxbjviJS564w3zfckzM
         ceRUmMJCkHOYOx8D9gEEtYsN3iybu+dmmtyggfCVSUowK//4H51XhEGTzfLlBLu7rnLy
         Nef86vSxl13iUNqaetQJokT0Pw/uKOn11G0xnK6Y9kMoXha2jw0sIS1490pqOvpow3TN
         52k4SMpd2EBHhU1deV1bGbkmaYkNo/WWMQXk5neZ/eJIf2feWqsvki+H3U1WADA1p2nx
         Dkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788382962; x=1788987762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zMLlM2fX1xLcX/WTGlvxUY5Z2fLG31XCRQQllFSHGs=;
        b=cbbKgsDGQLx+qpRXUP7YSa1UtqFgSM94UFoYCWYCOaxtyi7PnRtX99ck1oLmz9vsvJ
         p1Bc/uwmFuyhVTJln6lYhJV/EGlPPfw8Z8r0Qxua25gPoOi23vnI7nUQBJ54OSCvzQ12
         BvcN5CYufn96Z7ygKTo1qxuHjLkSlH+5+ztnSVC67YrJAubN8lVaNEcqjDJw4C1M2r3+
         jIMnQw/PdvUIpFdoFYvbkJk7eKcDOWBSeIor/P4xYXRBJnimBsDMW2msI6UBxx1OSsOD
         PrBEqS5qIHzTq4F6gV8CqIFdRbUHCn7Ylmi0UDes50u3QJ5O0zjdIEIHSsiT3IFYmkkR
         HFTg==
X-Gm-Message-State: AFuF++lH6ug88i8xuHrQiNbENwSURG4c+nBdlQZGUATkQ7bimmWppEhT
	JKlPQXrqYunPu2MPZI6jdchuNDMdtQC6rSJx4VVAr1xpnScJnOXt7MHoenHxfg==
X-Gm-Gg: AYBFou3krpIDiDgscwIzNxT7MlZRmzlAcGmDOk5JKp2yGuYGaY0p/yYTChvzfyw+ZKJ
	eTXq8dnEhQDkQKa/kOPTV4/avUeaEH0HKko4Lys7FedXUEbhy84/lV/vX4lnoJfT8sQeMIN+qKK
	GbvLww1cWTt5ll6TokGdVJraKUxH7tHTIXYTDSGLmQ6MK5fOjNLQt2DN/S+Q42CC+2KXQzRcDHy
	N9BpKxKzDwePlqUBUSO+hXmgwbyG7LEcCuKrVGrSY4opDgiA65Mk31GZFWkUHCvYjfjx6oNf4OJ
	iS8klyedNLkk6zuWe8c1U2NKpARd8p2db0mnTxV7Rljt/I9/i27CfMAxr0IdKwEY9F+R4GXrTTQ
	mUlfOlNkU978SOuOquiH7lKVd0GfR/MbPUN34BAY5a44rhZzs2lOk3pcVcQyZG0AwXI/qKIJUXb
	u9aQCc4WXyNr9pWXBaoEEj6Dk1IKWyU6LOLR2fHHs07EjeBemTTBruyjpzL4xdJXpAg5D8iEUUa
	CXfyX33OKlRYL381DeniRnMRdFq8txT57pdX4DsfJS/FaUOajCtQTcZvr2IhlaJpk0/VarHJxcO
	pL47U2PnqX6EuEoBXFnf92YKmx2aGNDZC9YR3g==
X-Received: by 2002:a17:90b:2d83:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-39aee049464mr12342955a91.15.1788382961730;
        Wed, 02 Sep 2026 14:02:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083f04d1sm1141515a91.8.2026.09.02.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:02:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Esben Haabendal <esben@geanix.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: ll_temac: Return actual error from of_get_mac_address()
Date: Wed,  2 Sep 2026 14:02:38 -0700
Message-ID: <20260902210238.283494-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When of_get_mac_address() fails, return the actual error code (rc)
instead of the hardcoded -ENODEV. This preserves the original error
information, which may be more specific (e.g., -EINVAL, -EPROBE_DEFER)
and helps callers handle the failure appropriately.

Use dev_err_probe() to avoid printing an extra error message in case of
-EPROBE_DEFER.

Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 711ed9c2631b..7a4890e45eb1 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1579,10 +1579,8 @@ static int temac_probe(struct platform_device *pdev)
 	if (temac_np) {
 		/* Retrieve the MAC address */
 		rc = of_get_mac_address(temac_np, addr);
-		if (rc) {
-			dev_err(&pdev->dev, "could not find MAC address\n");
-			return -ENODEV;
-		}
+		if (rc)
+			return dev_err(&pdev->dev, rc, "could not find MAC address\n");
 		temac_init_mac_address(ndev, addr);
 	} else if (pdata) {
 		temac_init_mac_address(ndev, pdata->mac_addr);
-- 
2.55.0

