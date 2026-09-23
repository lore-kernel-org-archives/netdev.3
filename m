Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF653B5ED
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180632; cv=none; b=Z3leYmOvU/EoGxqyIVA6RJJxGf+l1ahFfpS5WlDbH4bCLh3E8hl+huEU4knIJ6ft/gaBzN4+udgFboUVt96LhO8qjVVfiOStGWOJUuurnTct13OzTpipIKRB5A2vlmu7UsQ6KWHYcL39pEJD3xc8MtV2PAt4O4geTa4bqSQRwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180632; c=relaxed/simple;
	bh=8Lm+BvsXXaReExWPNz5hI/lMvmALmH/eMlo5uY0HHb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOIQS4ThmNlLOP6ZrHzHUr3tpCR+/aEyYp4L+AzVqxvjuhmlaMP5P/5JEH91h0FDA8Hp05A5vcECQFzlFC7rq5SXv221z/CLtRYyT/9pvP9cYTx+SY3qW45U/Rf7dsRhc1FuZLWWeWpWCd65X1f4jeZOF1tuY0zRccyJT4dwc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5BJDp5u; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5BJDp5u"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33e456e7869so27470eec.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180630; x=1790785430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMb7v1195lnYorqAAf/ft6okD8NVdHVnkQGFUlaPne0=;
        b=n5BJDp5uzQDFYH0OksN83dVD9ljrNOFCGp/h+isXDc14VBYbGwGCwQ/OZTSAc+p5Y3
         y8EBleZkiQnaUT6EXye1KD7TmBp0pquFLiB5XybiIuq2h4A2VeANuSMNJ5ui4XzssBd0
         T6TouiygqeaPhFsmbNi5jVd5rp8WQMU0jJLWMzP/8VlE8gzSvS6fBQisOd2rttezhHQ3
         5tPmm74XE08tLkuXdyavzWh2Q/9AI5oZc5KA2Iqa2AnBBnsM782mbVkWLPY3hg8h51a7
         QFSbfg43JmWo2iEV6ySeZd3Ng4tq1+Q697O11AyPz/mCKwkEmiNzRrlR/WwrklWophJ5
         zHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180630; x=1790785430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMb7v1195lnYorqAAf/ft6okD8NVdHVnkQGFUlaPne0=;
        b=VkyNUIOdV/gvJDdYfSc8rHHW/PgNViEy878U6smxZIrjA+yDfaywwOML1KiTyHg/2Y
         PJnVWOEzrIZpcAe03InnaK1IpP9AYK6jcvg518Hp6VTXMARqfy2LDq30urXYgtMPdsZl
         SwRwmCR+Fv69U2ZlcV9yTvYXc8JqqzRisCgfVO2KBYgecYH6cQEyOqe4CXMldUcjLAZa
         O6KeYAWG3nB9w1q6RxfxdwJvmUQKmgXuJRyaS/3L/1+HU7MgzPw0Z1XpHX93kuqyNXRD
         COL6poYwj9XzuXAm7rVk1shhNPySsgZKDizKFodTNK+JSa/XBBJ9FrC6CdvVOfhYxh3u
         QgNg==
X-Gm-Message-State: AFuF++lAeCg9ZK6QA6mnMmf/jQ9rraN/7aJeQQbuqMlqWnlJjSUiudhA
	3mjjF/+DFlg6tR/ZQUsiG0IeTke2jcrrT1yZWYs0IKLN4DiS+H8tWB5M
X-Gm-Gg: AYBFou3pMY0JYhjzp3mgKmn1goVq1TiIieBTbNyzS2ZIu78pHSsPNZeZsD+hg4ZrKwv
	KQuletrrnOsoitnK3UveT61qjATVK7pfyJFRztpH36T3BNEWeJ99yiU6TSWFM7PY/zaKzeBpRq2
	GYqq9eMVqWkto2K9oN0PD9mtgwpebKaHX5jrLzkAzS/O7wTYXF5MhvZ6c/BN65TKok+oFlrD8/m
	GVdcoAtnZAXgrBJBw1U1SMfhpf4oXmxJPQG0XPL9YOyw1N+zLmZP7tpnUU3s+cLM2mTZNW7vVXg
	edg49iPPU8W2jarCA3nWkVKsv9nhkxBczev3wd976xYM/51WY1CeSCH8Nx3FxpDsA/c14k5SX/m
	WjN4D15DUGe46rtoenONUYtXEeQssn2EiIHO99egclurGAF/7TFOaVeRGcNHWQUOk4SN3hG1Q9G
	g1AufvInz6f6CmqiY+4WXKZGADzYe6tkO9GIAVOMFcWGOxBG6M8HhApnPGdv21uhk/8/0VZuayR
	g==
X-Received: by 2002:a05:7301:702:b0:32e:f6a4:ca8e with SMTP id 5a478bee46e88-33e5c8aea48mr2964673eec.11.1790180629421;
        Wed, 23 Sep 2026 09:23:49 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96f47d52sm8022700eec.28.2026.09.23.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:23:49 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] net: stmmac: guard FCS stripping against runt frames
Date: Wed, 23 Sep 2026 13:23:39 -0300
Message-ID: <20260923162339.1375698-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac_rx_zc() and stmmac_rx() strip the 4-byte FCS from the last
buffer when ACS (Automatic Checksum Stripping) is disabled:

    buf1_len -= ETH_FCS_LEN;
    len -= ETH_FCS_LEN;

Neither path checks that the buffer actually contains at least
ETH_FCS_LEN bytes. A runt frame delivered by the hardware with a
buf1_len or buf2_len smaller than 4 underflows the unsigned
subtraction, producing a very large value. In the XDP zero-copy path
this wraps data_end backwards:

    buf->xdp->data_end = buf->xdp->data + buf1_len;

giving the XDP/BPF program an enormous data region that extends into
adjacent kernel memory.

Add the missing lower-bound checks so that undersized frames are
silently passed through without stripping.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fb5f80..4526669 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5636,7 +5636,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		len += buf1_len;
 
 		/* ACS is disabled; strip manually. */
-		if (likely(!(status & rx_not_ls))) {
+		if (likely(!(status & rx_not_ls)) &&
+		    likely(buf1_len >= ETH_FCS_LEN)) {
 			buf1_len -= ETH_FCS_LEN;
 			len -= ETH_FCS_LEN;
 		}
@@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* ACS is disabled; strip manually. */
 		if (likely(!(status & rx_not_ls))) {
-			if (buf2_len) {
+			if (buf2_len >= ETH_FCS_LEN) {
 				buf2_len -= ETH_FCS_LEN;
 				len -= ETH_FCS_LEN;
-			} else if (buf1_len) {
+			} else if (buf1_len >= ETH_FCS_LEN) {
 				buf1_len -= ETH_FCS_LEN;
 				len -= ETH_FCS_LEN;
 			}
-- 
2.43.0
