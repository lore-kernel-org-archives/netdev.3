Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037443B47F9
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437735; cv=none; b=aNK9w8gOSsDKW4ijRe22A9CLIJa6WSGi1anIRzDlD9lPyFG6c6hFgtkeD5PZAWK3nLmXZVh8o4F2ZVESU19/JhWAq+kivUhIg1cNBklzBEvE+xwEXQ4F3fL9Cr6b3I5RgDwYMrtgqissF+eNMq9RAQsqpIWnpXL8+FxaA9rEpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437735; c=relaxed/simple;
	bh=9kGKsaAo2kA1qFBiYQUe0iHybsQYYEdGYH5qAdbCdxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSkRnFWnt0KP7G/Rat9P5IR1FE3GN0fc1eobEWi2f81TNqQl3bJsPNHK+X1gA3iB2W4SknoKGyTxaOrWyxt3K9bU3AakbEMHpoD8Ly64yyERHXjuCRharZif58RwpF0uMsHgQ/m3oahsBhFKy7zYZFiH4xhNjU8v3d+SWnyCKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=of5Lc1Ql; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="of5Lc1Ql"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafddso229339685a.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437733; x=1790042533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iceODlE59LZgcWKBaJw9C8XVX53Oy1oOaAJoPg+TsVs=;
        b=of5Lc1QlLGjUJK7dlfdaXYlqe0tq4gNbFR11T6KbaP9N7mE6//XCLhX+oxOqUxc7G+
         gPnEFPzedj+FbuxG52Rn052qSRY8SL98XpXEj1+gbK/H6koS92VXS/Q/Dut3B+hVC5JQ
         kAe3sFd1PjcTeeL+KTBRsnAAiG435HJ2Tv7PNJYkQWOTBCni4Qk57tPiHW5PcpHJjgJM
         cs3Ex9aozZCz7bweWgPb/Yqykox5WbCG/9ILERMUCAK9JCKiWMGLpjd958/fBiRw1LCB
         mEkM3JribBsfta0WpxwSQOHMt6yV90eqnMGbGUUMVXRYOIy0VzNcuuyXNIHmFvvLQ7yw
         J/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437733; x=1790042533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iceODlE59LZgcWKBaJw9C8XVX53Oy1oOaAJoPg+TsVs=;
        b=U8xNdZnPr/ODq3tdl5z30IAT3rOHC6yP217qrvBqKZh/q3+9X4iOnhl1vUMdeSbTLk
         moFDbn/l/+S7HtzH1BWcxc8PbpXUUnSpjl3htyuwwfOUqpwEU09p0gCb53EPYXm04+xI
         A808TLYets28e998boEstBbcuKaz94F7+1vWVbYSKQcw+9bn6vsAM5vmevaiUis4CV33
         MSn76Iz7cYK2OuW0YYFakU3L8bwc7x0/rRP0DbBcnjCDwbn/juWHrWmTSju7OO5/cS1c
         0F8OIjSjqVbdaMgIkcUEd1bv+JVRhkH+FtD4gYp63z12hVnRT87++GxzujgC0jg9Tw1Z
         6LDw==
X-Forwarded-Encrypted: i=1; AKwUvByZNmY4s3Vi1aFyyIYZf2vnEvFYFzLjon5v3sf1ioQpCg7/XV8Hctq6yBDSQyfotylCCFc4DFA=@vger.kernel.org
X-Gm-Message-State: AFuF++ne5f+8RK6K6IMwfxsy4tDYSykcJGrqOWXWditJ9dYr5QY9Nhgw
	v8Ifmf5N/vk/Rlv1SG16MAsfdQjS9+EJYMLt8Gj8opoAP7KPYq3mQTc7Nszue9RL0w==
X-Gm-Gg: AYBFou1Zh/9iGGr5lqpqd8Q2KpdTuelOC7IJhM4ouhCyFK5Yt8dKh+S09NXEuEXvhgR
	qKECnc8Uf59hAc4ejSKUutTZmPxylPP7VVySDXnejzAHvU+VYn6wv7M/Ew3DRvd9bfbowV+dd1l
	+qXbH4qkfae/SGdJZINjA+m7TAfaAF/aF8xjW5hhYRrj51Eu4d38Ie20QqX8lAI9IaJa9/CBWBm
	jwaNk0eSjXv1eCoWy3mtnYVleotS9EJtFQjgXECqExEfGT7z0h770s1ZEp+c65R2/46SJiGvZz0
	K1giKfvjwx81aBF20iJY9XWUBnGhTysHQ0Af0dcBXRGKSKvxQhwss3/xLKDr2nLSoA8BdzB3qrY
	CUlQ72rLTXUQgeE5ODlOQEiNU05zy5BNUSLXI0fms4x/PTBqFhIyxoPBrNeLD5C4g3AW0QxVy/Y
	cWtqpxJjBOWykVihkKY4UdyoH5DyiY4eI7Em+pcoJx3ID/lgMKWdtv7hkfxEAHIZMk2FmAln66v
	MD6rSTNHrZeLLazm3vrPM61EfLjU/V3/Is4G/FWUzxDAGZXSgg6WUb7121WbJPxRNMlNdTXqmsw
	L03VP0ivhKuTcxnPErNxYE2D/z4716DszMJPL56WytJ34Djv4fs/NDZXSL+HAS7B856nTHEQ2P3
	a4JiI
X-Received: by 2002:a05:620a:4620:b0:93a:1101:a21c with SMTP id af79cd13be357-93a299f084bmr785854485a.25.1789437732441;
        Mon, 14 Sep 2026 19:02:12 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f19f94a1sm1022872285a.42.2026.09.14.19.02.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 19:02:10 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ion Badulescu <ionut@badula.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: starfire: Disable PCI device on probe failures
Date: Mon, 14 Sep 2026 22:01:50 -0400
Message-ID: <20260915020150.87982-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfire_init_one() enables the PCI device but leaves it enabled on
subsequent probe failures. Route all failures after successful enablement
through pci_disable_device(), preserving the existing error codes and
resource unwind order.

This issue is already present in the initial Git import; its pre-Git
introduction is unknown.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/adaptec/starfire.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index f1109d9..f7bd765 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -638,6 +638,7 @@ static int starfire_init_one(struct pci_dev *pdev,
 	void __iomem *base;
 	int drv_flags, io_size;
 	int boguscnt;
+	int err = -ENODEV;
 
 	if (pci_enable_device (pdev))
 		return -EIO;
@@ -646,12 +647,14 @@ static int starfire_init_one(struct pci_dev *pdev,
 	io_size = pci_resource_len(pdev, 0);
 	if (!ioaddr || ((pci_resource_flags(pdev, 0) & IORESOURCE_MEM) == 0)) {
 		dev_err(d, "no PCI MEM resources, aborting\n");
-		return -ENODEV;
+		goto err_out_disable;
 	}
 
 	dev = alloc_etherdev(sizeof(*np));
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		err = -ENOMEM;
+		goto err_out_disable;
+	}
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -818,7 +821,9 @@ err_out_free_res:
 	pci_release_regions (pdev);
 err_out_free_netdev:
 	free_netdev(dev);
-	return -ENODEV;
+err_out_disable:
+	pci_disable_device(pdev);
+	return err;
 }
 
 
