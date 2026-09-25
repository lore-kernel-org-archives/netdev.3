Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com [74.125.229.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FD4279FE
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359106; cv=none; b=Xooa1PDbJjydP/CPpcv+T28d8YF4M/+TA/vIAoZczKsG99usCr/vjG2Dm6c0B7submLFioWutYYU24JTLY5eoUeLOkV6nL0TgEZdo8MHThporX3ne46qk7DDDer3lWdnrNyuk7YVTHEZSjwingCVPCOJn/eWeqnwtBvWdBQCbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359106; c=relaxed/simple;
	bh=iOZHQT4IOAIyVGF4UgMZZiMxiLFANObxfB3HkuQmwoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9gQm68XXuaYFAJKU9/Nix1HVW+rPb8vZHUxLVc4NbgpTEjpCW0fBG3AT9SNVC+BjOWONDoxoB/WQaLDX4xXw1rVljXoJE/ddHqBX+t+7kIAVFexHb6wsrVDI4lgX5E3M2Lp3p2RGFHPPWE+B0mLKSDva7CTTQSUmpbTyF1cSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZWgfEoT; arc=none smtp.client-ip=74.125.229.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZWgfEoT"
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so1033633c88.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790359100; x=1790963900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJ/NQTl1WNpwK1sUwU0K8HlG1PwVQbHpKjHbUF6bYOc=;
        b=QZWgfEoT09Bisc5Fojz1pSZtBoSM4htRvJTQG8kGERI2MyI6EYlL6g0f7PunI+C4Fg
         MvyGgKYHzFegfvBCZxqXLoD12trHzahGYgylpfbHoiWeqwj78G8Uh2ZuISlkIuPUZzvD
         OUcH3X1feRGhGEwZQZ10uU+c2TBfGG77zPN/WS9iR7hCiRsvVkyrXbLB/tkgUSlSzXyS
         faVyYXZpgsVlK5bADQsOb3ezq6fs76Z6XhKiAGVNpSFY3xmNJw44kgXqDtp9scHQFN5p
         cPFTyyNQ120AJrbFf1Rv9aTqXwoUjW822i6kWcHVXzn3wQ3/P3xwqOzb5DGMKxhGv7H7
         E6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359100; x=1790963900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJ/NQTl1WNpwK1sUwU0K8HlG1PwVQbHpKjHbUF6bYOc=;
        b=Zgpj/2LZvKMc9PKOHKFYi0bFwTs5s45Htbx0/kKi/ulhCZ9Rh6cMFS2FOSc0XiqajK
         IL6OePQCzBqNZPEpaTS0BIsazGpuGr9A/FlGhz10wOtwWgahTgRgjE3apwmIMNtfiHEn
         kdI0y+LJB2Yl1FqAYSDYR3y8SnRZxHhvsHwbxNIgLmw8UJwuDMigPdMmklxInLyj3DCx
         3/bRoEPx5aLxI3rDfRoOgtCH5OOsAD25h/nXnwNOo1ZjNqyji9cPwGv8qkLIs31v4toc
         /lv7janTg6y57b/cKRVodf1/v3BScIQTcztEdyqric62Cbyq7rWhlrsyByjUt39ZwRXc
         rpAQ==
X-Forwarded-Encrypted: i=1; AKwUvByf7hmXI+jALk2YBHx9X591LHTxEKYflOH2kp4xEHa+nZm9/zBd5GZgLYT/31p9+vutSs4z+7A=@vger.kernel.org
X-Gm-Message-State: AFuF++n/cwCQygdavqrCVaLus5BrORF1ih5wsWQyKh7REgrxMrTLDQRV
	oYrnabNfiR5sbQ/EGbSPcrVogRq1U+gP5oE4wUF8jiU2Ot2l1I5q6li/
X-Gm-Gg: AYBFou1F8CqiefcLMQD3BpR5lu/A7B2sppX91/AbFmgeIQnOmyH9QEHaaEW/Zf8v8ev
	SzNe0Y1Pk5+K+2CAL6rpKcVKXofAiQTmEWu9HMXyyCurzVg38IfcG7g/aojd13XpjiMUMBvzs3r
	JXoTzurn8+m4swE9gEUbiye+q485MiZ5sDXcIHLyops9F/8W92pv/SQlBbY0ASL3WlX+mFvb4yB
	MKvgZWufiNRAwnyCJsBMQtlub/UWLXygot0KHKgq9rY3iHd3TRxC0gCavQKBmmjgyoOQcBvspX2
	j4QsXqUC/OVtF8TIuNt60Jd2Ftt6zCfGAQVZFNFtskqf1IWf9PI9H54YLqX+rWAigq4wRVk2SFj
	penptW99PhmqwSlGDdHPql6gQr0RFJxze4rHqAaW7xGVw67RI+UWg+KlHILREAF3ccKq0e2htBz
	mFmGYXXZ3AORcLRloIgCU+tWOa1D3NOgBsxqEg254AOV/xGlmDLN5vfBKTKZ0ICgBYL+a5qmbXM
	A==
X-Received: by 2002:a05:7022:2525:b0:144:f096:4dda with SMTP id a92af1059eb24-146d096d302mr1238633c88.43.1790359098946;
        Fri, 25 Sep 2026 10:58:18 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145727589sm7005744eec.23.2026.09.25.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:58:18 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: david@ixit.cz
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] nfc: nxp-nci: fix IRQ use-after-free in i2c remove
Date: Fri, 25 Sep 2026 14:58:00 -0300
Message-ID: <20260925175800.3694044-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_nci_i2c_remove() calls nxp_nci_remove() before free_irq().
nxp_nci_remove() unregisters the NCI device and frees ndev via
nci_free_device().  The IRQ handler nxp_nci_i2c_irq_thread_fn()
dereferences phy->ndev and calls nci_get_drvdata() on it; if the
interrupt fires between the nxp_nci_remove() and free_irq() calls the
handler operates on freed memory.

Swap the order: disable the interrupt first with free_irq(), then tear
down the device.

Fixes: 6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/nfc/nxp-nci/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -346,8 +346,8 @@ static void nxp_nci_i2c_remove(struct i2c_client *client)
 {
 	struct nxp_nci_i2c_phy *phy = i2c_get_clientdata(client);

-	nxp_nci_remove(phy->ndev);
 	free_irq(client->irq, phy);
+	nxp_nci_remove(phy->ndev);
 }

 static const struct i2c_device_id nxp_nci_i2c_id_table[] = {
