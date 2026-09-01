Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A74756D4;
	Tue,  1 Sep 2026 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268933; cv=pass; b=qBUN8Z8ffcUsURl4n1rMSsWGmzdpvsEDwI83nhvNp9ZhSFo6dCf4WZOfsn2npGDdU8texo2Ppd1B/evR7XQ3B71Mk/6CikSxkRZapn6xNFGefEebG4elb9pasUmXo5d4bgjKRCpRDg4lIY8xzR9bZU/HKNSXsfvvcox0pj2MNlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268933; c=relaxed/simple;
	bh=rxPegwfWsbhaXnaOfXAiSIbv8UqPN8bqJ9GM2VU5AGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFllT6RE0qwSuNbcPImY+T3hVM2f5SlhTpIctZKvSM4BidJgLkT2GufIISk4D4TtZiR+8poxb8Mutm6Txt43r7ZBI28u7ooSIAwQvBN2wN69aKFaTprX7Uao+lO0zonccfPKUwRK0BDsCGnfTEm8f2RiE97KXla//hUerMjzapU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=IwsTI6JM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IwsTI6JM"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ630586dz49QPY;
	Tue, 01 Sep 2026 16:22:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8dnLpIuawa/T5WKzmKQT35hCSn6pD7KsZ9UF2NkcKc=;
	b=IwsTI6JMHbpC5lca9qH4KN3Q4gbZhwcXEolhHVNy2Zst00xH+QEheODmdjP8eLnGqgnbTP
	pA/D5B+83ftSYYfeqXU3hCiwdtCncCE4ns2cnTvtJW9sQZeumVyz7zLP9fRROnOqFqcIZT
	/MbHHhTpL3w72uMBIl+u+K6WT06bdG3tVxgfnNjZkLoPq+2Ghj298By0v1vsMMpQ5WF+bb
	v3wl4zr8C4yGKAxSNOMO3/51dFyPbDKu5DshKAxzVDgoqn5HcudMJg1oMexwSpDw8uqJSB
	jRcWB82xpfKRVWMv4Sb8eRplTxo1qMFzQilN3IBCyPjvv20Ij/f+kzBJH1DDpQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268924;
	b=p0OqZ6mKstN6Pc6ycLMqQnre8mvHLj+YEhdw9y7tXOaG2fxHFg8a2qaLfT7/yWSAN7XxmN
	h/Qr99Qjn4tV7klCzKBKSxMvlV3X/dZM0ovlA/Y1S/cA46YBk80ZRe23TL+qIFEGvt3S6Y
	cd4BHZytD1RnX4y2fh8ys+BpnEcdVhj6l0i5qmdmslzGLubRUG4DBY1YG04D33izHEzKvG
	nb3VyamOFjDCG248eFmM7zRBbRf6LEGM56pbrI3fvMPZtqx0MU50uQjOOfpOm55LliQkKu
	2OJTgGMGV5wNP4NSPJ4aC28Ce7QH0bRnG4CsCvpXrHGEY9Vp3JWGQ1RDmNLIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8dnLpIuawa/T5WKzmKQT35hCSn6pD7KsZ9UF2NkcKc=;
	b=WN7tBA5/prja7Bo4RDEJyZCsNSruqbMwlHCAu4vE3CmE8E8hmW/NZXN0a8IGWapTUX3AAB
	eghX1Gr1Z6964uhCa3OorP0IVB7NOS07FwbG/hC/LzcXE5/GrTZqH/ijq1Et0Sf7M3HqPi
	hFwDC0ajHhfm6W84Y4+5I4cdT3bTLvUdVCbK83bI/NXzdcPzUuUab/GJqYS8jgoM94X5bN
	a7TkjL6zTXi/rnWq6f78su2qTxYpmhYVnPT2NPOeAI5jF254O32EsHdIoiLIglrIczHzP5
	JTQxIqqeNrGk79kSsWd8551TochjnhRrTN5frDUbb1oCoOv/GoGRp5S5PoIxfQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 12/15] net: qrtr: mhi: Report endpoint id in sysfs
Date: Tue,  1 Sep 2026 16:19:31 +0300
Message-Id: <20260901131934.225991-13-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

Add a read-only 'endpoint' sysfs entry that contains the qrtr endpoint
identifier assigned to this mhi device.  Can be used to direct / receive
qrtr traffic only from a particular MHI device.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/mhi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index 3990da1a65dc4..630ce0da060e5 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -106,6 +106,16 @@ static int qcom_mhi_qrtr_queue_dl_buffers(struct mhi_device *mhi_dev)
 	return 0;
 }
 
+static ssize_t endpoint_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct qrtr_mhi_dev *qdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", qdev->ep.id);
+}
+
+static DEVICE_ATTR_RO(endpoint);
+
 static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 			       const struct mhi_device_id *id)
 {
@@ -135,6 +145,9 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 	if (rc)
 		goto err_unregister;
 
+	if (device_create_file(&mhi_dev->dev, &dev_attr_endpoint) < 0)
+		dev_err(qdev->dev, "Failed to create endpoint attribute\n");
+
 	dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
 
 	return 0;
@@ -151,6 +164,7 @@ static void qcom_mhi_qrtr_remove(struct mhi_device *mhi_dev)
 {
 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
 
+	device_remove_file(&mhi_dev->dev, &dev_attr_endpoint);
 	qrtr_endpoint_unregister(&qdev->ep);
 	mhi_unprepare_from_transfer(mhi_dev);
 	dev_set_drvdata(&mhi_dev->dev, NULL);
-- 
2.34.1

