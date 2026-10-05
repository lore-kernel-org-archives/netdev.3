Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2946D55A
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196157; cv=none; b=YQ1ig0h0/2CgUA/tsDL8JPqYOa1f7s51osBlNiCWNTPAj/1njlFC+wKq2lsD7AMT+BvTdM3MfGpTb5b9XprrTtgoDCluyx333uEUDzI/+QzhOHVQAOGfYrZsYSrRVQdSyTW0z8WVj2czlSxRzsaWQ8J9sfDF7wkhCj80KsFucAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196157; c=relaxed/simple;
	bh=ZqrknraJrh16BFHTcAGNuZS9Sw54k4nkDA1XB6fk0zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFkXNq2IBuApBVmkrGD+pzEopyrsVAu8x/zq88qvQYHkdYJdv2VaAnaQpWUOGdYxo5EYLuaLmgyOSZ9zw05UdgdIVKMatn32ZDv997beI7W007+lg7aMQQXZ237q2vT8mwhAQOMQQpyucWK/orHK6efoijhIsQq9SA9aFNTFCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg/kbd74; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg/kbd74"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04be84so1457733c88.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791196155; x=1791800955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oukphk47V539pkBOqAi5PYDeCD+s84orlhv2/lpFlbo=;
        b=Tg/kbd74OOFe+JDDjtZRAlgMCPFXidtXL9Tip5hZADRrdEKFwaoVSre6PH1Z8tpmw4
         oHTlTPbIZfupVYblejjhUVbL+rW6xnj9rX4NJn/vWW2UQNUGbO2Ljac5oKCYuqjs1iM1
         YN3kcBzQQu2x/cJPjQOp9OWgGvIaOrgACSFaZ/dli6sl/MrTkFz0Adqnc0ciaEih0iHN
         TtiYj0ePwI7Fqwhx9ug54omWQKxGeO20jd8x12g/lHVAXUNtkNyynbv8nai4glhw+P2B
         devAqZPB98IquheBEdDRmnYKjH1mxiVSH3cy6rirdj7mVC/LGZSJ9DYO181GCQLDcTHP
         WDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791196155; x=1791800955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oukphk47V539pkBOqAi5PYDeCD+s84orlhv2/lpFlbo=;
        b=TCpTHwL/QXC7P2fnDpDMCECycMJOtQTIfDfqI3IDHEB1D1Jr6mNQySYO0e1uyqtYHP
         y4WdbucPIVCCYoxyLG8bCJksMzm0LaWmN3rBM/eodAQw/7ImJWK08WB/B475lLdIXkov
         MmddBloeHb1xbOQSmaLOdz2OF48JQdUpKCWdTlTDBoOLsWyoF6rrDFtzfTC+epwAz8Qd
         blHfEh14/jglVe9MniIQBvPhMznoXbX+qcajWWEua5tBWDTMdyoyrsJbkZN6nJ404UGv
         GASesjr0XQxdYsrDRggME0IgCYmfRg/m132fvE8mCpITjEVUf3ikdkpnZeSIl51IWvcK
         o6QQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7OzRFBVEx2JINk2hc1oxYT6ZFYSRHn2fGazNJ88l55mOYMZnL6457s30CHI4KtgMVdOve42M=@vger.kernel.org
X-Gm-Message-State: AFuF++mzE38V2CHWvg4ZzxzMhXln3GuKDkgYi6pRvD3cjPMKz/EGWYSW
	Xi8fIUmJhdb5jMMuWDTH3PtwSbAw60VePMrAOPXewJHJ4atbu4eEZRww
X-Gm-Gg: AYBFou2fsd0VrVjGuiM5vCmAkOEjVTOkYWR3NLjMUapPs9s2woObDUxvrFLKCr7UBfh
	AjtwvlwclQBsIpUXiDFKzkYRHCy2Cap2nHVq5ZlovBQf0otTLDeqjyvBrRO2bqMtTSTsV1USw18
	Swk+K5ZJEDEVpO8g6TN3CsUnkWWoEpVC0ArG7UEusjgBv1ydY+CBMfxEVUUn0EkqkMfByCrUKmx
	neTkfQ6D5AEB34CJ0m0LwRsa9PwD7VWVVyRhJA21qOm1NCyOpLeylZvtBFwMBFfq6xm42GZcdJ1
	d0v2Ohrk5xa4FoDRt2jrSnSYXfBJRbIT5rytSPkqj9epzbebRTexxqbARLMPljR9/pug/SueO2S
	OnagbHHXoW9q5/NiAcsTMAMfXkRYP3hLuRtWId2WDFtdo1GJKN9ZQveYvQGy3Isd1uPukdARKxR
	st03YRVhEE9OBfTKP1pYqBIk48aVbiZKG4pLQrr4xgoq0DLLhljanXlHb4VvPJHEvl5GR3WDlce
	PJDo/hEHk1jqTTmijrGtjo=
X-Received: by 2002:a05:701b:21c5:b0:151:2068:e81f with SMTP id a92af1059eb24-1512068e899mr11215456c88.27.1791196153405;
        Mon, 05 Oct 2026 03:29:13 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.132.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272a45a8sm13399093eec.22.2026.10.05.03.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:29:11 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ian Ray <ian.ray@gehealthcare.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+ebbbf06f152da8ea4716@syzkaller.appspotmail.com
Subject: [PATCH] nfc: nci: drain rx_wq before cmd_wq on unregister
Date: Mon,  5 Oct 2026 15:58:48 +0530
Message-ID: <20261005102849.486-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_unregister_device() destroys cmd_wq first and rx_wq second. Any
rx_work still running at that point can handle a response and queue
cmd_work from nci_rsp_packet(), which is refused because cmd_wq is
already draining:

  workqueue: cannot queue nci_cmd_work on wq nfc2_nci_cmd_wq
  WARNING: kernel/workqueue.c:2352 at __queue_work+0xdb7/0x1370 kernel/workqueue.c:2351, CPU#3: kworker/u32:0/12
  Workqueue: nfc2_nci_rx_wq nci_rx_work
  Call Trace:
   queue_work_on+0x180/0x1e0 kernel/workqueue.c:2501
   queue_work include/linux/workqueue.h:700 [inline]
   nci_rsp_packet+0x297/0x3420 net/nfc/nci/rsp.c:463
   nci_rx_work+0x29c/0x430 net/nfc/nci/core.c:1579
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396

nci_close_device() does not stop rx_work from running again
afterwards: when the device was never brought up it does not flush
rx_wq at all, and the driver can still deliver frames through
nci_recv_frame() until it has stopped calling it.

Destroy the queues in dependency order instead. rx_work queues
cmd_work and tx_work, so rx_wq goes first. The cmd and data timers
queue cmd_work and rx_work, and cmd_work and tx_work re-arm them, so
shut both timers down before any of the queues go away; after
timer_shutdown_sync() the re-arming is a no-op.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reported-by: syzbot+ebbbf06f152da8ea4716@syzkaller.appspotmail.com
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
Built with W=1 only. syzbot has no reproducer for this report, so the
fix has not been runtime-tested

 net/nfc/nci/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 73e3a96470ac..aa417f863f96 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1329,8 +1329,13 @@ void nci_unregister_device(struct nci_dev *ndev)
 
 	nci_close_device(ndev);
 
-	destroy_workqueue(ndev->cmd_wq);
+	/* cmd_work and tx_work re-arm these, and they queue cmd/rx work */
+	timer_shutdown_sync(&ndev->cmd_timer);
+	timer_shutdown_sync(&ndev->data_timer);
+
+	/* rx_work queues cmd_work and tx_work, so drain rx_wq first */
 	destroy_workqueue(ndev->rx_wq);
+	destroy_workqueue(ndev->cmd_wq);
 	destroy_workqueue(ndev->tx_wq);
 
 	list_for_each_entry_safe(conn_info, n, &ndev->conn_info_list, list) {
-- 
2.55.0.windows.5

