Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86147532B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808601; cv=none; b=fnxxZch9jy0sS7HkIcX9Bs74DiFnzWJo+FhM4jyAelLScCkEHFC2PYyiMxLV/u3eqokNTm6Uuutotw7NO/ABJBQnMi1j0qf2ebjbtwBcgWBkZAfYrZ7gzjZmnJfVBlzEgkKB4185QS8KZTyAxoMtpM2W7j8xyNnimcrJRjdXzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808601; c=relaxed/simple;
	bh=j0LEvXObH71hDZRY5WG5+a5o+/RerOV7SsoqXWSbysk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aODTVM5RjtErWnwDR7AG2ACr6UTD2vrg7CtHYNv9RfL90rZybV/XBMn315nBGHpGmvntImwUKNrWd/ZQvg+AmvL8Nbfk776JCes29JCJGIQ4S5TODcKpO5aOzJBeUIY31R+Zz0/JTp6KyDwaXcZoBffrcv/5lU9TOYVkl3yxumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLgTa7ep; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLgTa7ep"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so32898755e9.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790808597; x=1791413397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEXFn4CcqNXZi8Xfb1/9aMVRytKizyJNcxUrexiVgfE=;
        b=cLgTa7epjb6cSTbAthL7Ts7lWnO69zW40AfOvkUANNziOFStot20ukiEpb5rdyxdAG
         OkuysLpJHS82sAqYTo7duZgmngZiZlKJxvrcE7Oznwf9fo5us57jlCmULmTujLjsXeFR
         uCOijRNI0b3zA/lnGRi1lXD3U/WEVFkrwc+kbdjd8tX/2hdL6wo+njdjthOAdiK2u6An
         JcXbjegnEQnI2i3fbjiszf5qKQjXndj6bu6nqCRWSQ43BRG6lciOf8QK6ntRT/JjvOc6
         W4H/VrgEo5clf5jkRFSy8puABVjNFkAWRecXGQIhWgNUaoc+imf3kD5qj18vOwdiGU3t
         yVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790808597; x=1791413397;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CEXFn4CcqNXZi8Xfb1/9aMVRytKizyJNcxUrexiVgfE=;
        b=qD7kn63Me12+GXEwjFuoxsyNdAr8QMpaPb5yjb43mUrFS+vVL04idZLIlIA47nWpm+
         z5a7O5gW6CZ9HmgxC9LU/HJyMnmOUtt1izhXxcgmUEie6/CyNjup3WyWwlb66cdm0rYh
         +9fK1BoM4GVfsBHfuP6r2XLPTGKorhfKKaaOvobrDSnthk5uaPsxmkAhcjPAvT/PqTY2
         Z7w8b5q8NL2COuk+ZobCcg6VPu3jeVJmZ4QgkpjVrzbkd+CvPKGtkfSwJOh1XQxXQhWR
         vb/Ll/SaLT4alsRnPtqOHx6fAZzh/XWpKvEAP5PGvRNTVZ8Ypsz2mnJ5OF9mzpgOneW/
         F5Bg==
X-Forwarded-Encrypted: i=1; AKwUvBzxMo2x81pcfoYRioIHPNcYDl1JBr7rGNmBFYfKGmRzGStnSqxKjJpGLnDg+COfiGmM7L39eFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nVDTJZSsaJ7hB6yruYlP8lbB62Du1Wlxwb7CXaMiZVIWNlriFQ
	bIPzdWE1XrEbcAzdHgyNKMkJRPVtX5a4b7GqjY16uA8bw9QA42OqvgyS
X-Gm-Gg: AYBFou1EBYmQOrtackRsvTej0+dFl1A9orRA3OT0s9syF93j1/Kz0gZ/zx4TrWeOVRK
	WmwA6s362pZLW8JcckTdBJRYisxLpndDsvTgIzVi2a5E3qOrjE3W+LVb1nT5e7c7h5FisihzW8F
	A7qa+UG4QWfV3mXOjHmBWnqR/uleVR64+Ycippiv2ii2H8ufAPtuysb9KyzDtE26uSpY2U8TSDU
	+91stfPC5eHqR+VHXWX/A4h6EZwYYNbaL0iIvLqC2x/XhGtZXOxBtUn2D8KCh9Elbr9Q6McGuyy
	z2dmlWqJ5m8lRHX2Tbz0ZKBANbjMY8fW+Alxu8yX37SPpRT4jXdYrDH0P6INfYpkxAhlSsp4/zs
	Cf9lV5gxLy+4CJ2mqdv3uKR7np/FUwrmVAbo6e11epn8TQvwbaPUgv21zKLwl4+nNAaTZOTuKYc
	UsGv4mwjWtOfys7fKARa72iTbMyCVBaGo2eFK81jckBb+2Aa5x5MKxBWbTppEhXSm7bKlv
X-Received: by 2002:a05:600d:4448:10b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-4a01b11bedcmr35960895e9.21.1790808597033;
        Wed, 30 Sep 2026 15:49:57 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99a332sm31602845e9.12.2026.09.30.15.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:49:56 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net] nfc: nci: fix out-of-bounds read in nci_core_reset_rsp_packet()
Date: Thu,  1 Oct 2026 01:47:06 +0300
Message-ID: <20260930224940.725976-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nci_core_reset_rsp_packet() guards with skb->len != 1 before reading
rsp->nci_ver (offset 1) and rsp->config_status (offset 2), but this
admits a 2-byte payload where config_status lies one byte past skb->len.

Fix by replacing the != 1 guard with an explicit >= 3 check before
accessing those fields. The 1-byte (NCI 1.x status-only) case is
handled first with an early return so nci_req_complete() is always
called regardless of payload length. nci_valid_size() in the caller
guarantees skb->len >= 1, so a zero-length payload never reaches this
handler.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 net/nfc/nci/rsp.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5ac..e52956bf3 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -32,16 +32,22 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,

 	pr_debug("status 0x%x\n", rsp->status);

-	/* Handle NCI 1.x ver */
-	if (skb->len != 1) {
-		if (rsp->status == NCI_STATUS_OK) {
-			ndev->nci_ver = rsp->nci_ver;
-			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
-				 rsp->nci_ver, rsp->config_status);
-		}
-
+	/* NCI 2.x reset response carries nci_ver and config_status;
+	 * a 1-byte response is the NCI 1.x status-only form.
+	 * Require at least 3 bytes before reading those fields.
+	 */
+	if (skb->len == 1) {
 		nci_req_complete(ndev, rsp->status);
+		return;
 	}
+
+	if (skb->len >= 3 && rsp->status == NCI_STATUS_OK) {
+		ndev->nci_ver = rsp->nci_ver;
+		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
+			 rsp->nci_ver, rsp->config_status);
+	}
+
+	nci_req_complete(ndev, rsp->status);
 }

 static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
--
2.55.0

