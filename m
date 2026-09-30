Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EA42885A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806158; cv=none; b=CEC/7MnyYDVrCwSsgRsD68VeQ+n4LdkHa2po4YlSGBUFBOhD2wUQq3PwLGVaPCuDZ2kQ6FA+l2emlCpX20Lz5mg/NY5DfU4NVjQPb7S1XQ7n1ga54B6QyxGDVdjD/bj37hKr+5PickRt0TqJfcnSmDu5HipPPlaNG2MW75URZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806158; c=relaxed/simple;
	bh=2Vc91vVa95l1BF9P5E+Hu4oArbEH6p9nMPl42D5ahBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QjgH9HhMaQ/0jFY8YlOXsAkGsG4Hid+/Qvq+UoVS3RIEY1CHD6VRM3TEvUhmMCS5ZBR2mDkxbsU4mNrQ1Ci0Y4tt2n2DC5viZSQN5cNzZdKP7cQxVtFe5zTq5kkiv4csYlAuX7Gf9O+QNJ6Vi9hKq5qDp8n2JVRtQ26cePInNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c40mGgxx; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c40mGgxx"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so36110925e9.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790806155; x=1791410955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmeV4rEVAtHMh/0SUOgOEDlH2GalZPirUpnG/q/WPZk=;
        b=c40mGgxxt+dnGTXQCAf/irMmTzOPa/1sg/nHfKa+Zv83Fa7h6YLH3nH3gbbHrzW/2I
         2dH3Ynw6sjfAS/vilR+Xq9dJPdCcNmQHfmEJ5taHEgPTuW2ranBTR1Rv35Ohg+dbtCHn
         bIeFzewEdbX/UKhrcKT6uG8k5Cp1PHJhFduAJ0Qth/vFA2QUAyHmGFmBfivszwCzng1N
         KtIzsSFNMqUbJvhh+6ynbMsAn89fIB5Jg77Mnz13jETQWKunnTLc+0zV9+l0cvJQk0OF
         jkCIpOlgYka9SXNyDMucFk4d48q94G5i4FX3/4/l0sZ0ZUJRZQmIk9eyliYfhFQHhNVd
         0VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790806155; x=1791410955;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmeV4rEVAtHMh/0SUOgOEDlH2GalZPirUpnG/q/WPZk=;
        b=B0xDwFXlzAPCVJQkGSFwqrHVnuf6iBXnUuwq+2lPrL1FNionJGy9NSqMO0L0dWToc9
         3yOzAZiwCTbnXrEWLAa6jOJCyyTemZPbpEEahm3elc66+iL1ROhMrcqsvi7PjvNXMtlM
         8Ej/9LRx2xnEwBdXKu38xAFTQzkENN8T/7I1c2OQC0vlvuhiSvXz10TJUYtr+VVG/5Lc
         mMS6XgDCtk/8lMV4ypKMqled7PLP400lvWP3jQaaGse13t4eiUDIPyWZl48k+wsMJ54E
         jKQ8z7d86agEkF3BHJA0X/Aj6SHJdX9h5q+e9P1tXCp8ApnGtIaLTX34jyyatp+F3BGh
         1Wig==
X-Forwarded-Encrypted: i=1; AKwUvBx9Wq+f4NlO/Nj0YGgvBDFSvs8l/HixkJQDm8Q3Zs3mt8+KyEse/Uvkx+aEfsz0M+REr/ztV2A=@vger.kernel.org
X-Gm-Message-State: AFuF++kdeXSnPUjh3RCbBDhG94/kgXPy361I1hHPsorX8xoTQB/nR+Q8
	25zt7m6Sh3TeG2ROtIyIKJjBpcKeS0mVghGAcEuLScEZ7Y8hHagUOG3y
X-Gm-Gg: AYBFou2xw8vt28LJEMPIhmmY0MPcnDmMuuCCT076CpJlQ7s8S2Rat4E9Sq4bwjTuhws
	mByqOmBFpXR1ll0kmfDN1lGkYIwS4pPEWSyx4J1Fl4Tf2Fp7C9W0oiTFkZ6nOJwb8fv/fRse8es
	89RYFVvd5ODiDTWn/zoOWvbadWes7KIcvSbzKEEPS4jAOGHeHgRh/akrKrfBdTzUdxsJnFyH83h
	QkEkvf/5I3I1Y75SGwnUu9XSuySxPig27xF2WvyxRef1erCSfFAJ+U8UZnW8NF4hDjXYdW5NAn2
	LFaLVZhV/g7D2J6x2ncf73zx8qvivnT9JS1kS8XFLTz0i+jge1AhjrtlGkroq9O8/ZljVc9nnV9
	7I0ZnnzOfyy14KvDBHjzBY++4EipwreZln0PpSHvRPAEN9VtSaMHumrpV0iowoimqyx/IWqZ6Oj
	pw65KXRCMLuljbTr2xNcq1PtIVcCMfKZtE94uWVDEOVVsxpAjCraNgAuvgx/xNOpMSVpEn1AS4M
	34VahA=
X-Received: by 2002:a05:600c:19cb:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a01c175025mr37282775e9.31.1790806154525;
        Wed, 30 Sep 2026 15:09:14 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f98f72fsm12679655e9.11.2026.09.30.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:09:13 -0700 (PDT)
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
Subject: [PATCH net] nfc: digital: fix read of resp->data[0] before length check in sens_req
Date: Thu,  1 Oct 2026 01:02:06 +0300
Message-ID: <20260930220857.721985-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

digital_tg_recv_sens_req() reads resp->data[0] into sens_req before
checking !resp->len, so a zero-length response causes a out-of-bounds
read before the guard that was meant to prevent it.

Fix by checking resp->len first and returning -EINVAL early, then
reading resp->data[0] only when the buffer is known non-empty.

Fixes: bf30a67c947e ("NFC: digital: Add tg_listen_md and tg_get_rf_tech driver hooks")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 net/nfc/digital_technology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index ae6487c10..b27d45e05 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -1097,10 +1097,15 @@ void digital_tg_recv_sens_req(struct nfc_digital_dev *ddev, void *arg,
 		goto exit;
 	}

+	if (!resp->len) {
+		rc = -EINVAL;
+		goto exit;
+	}
+
 	sens_req = resp->data[0];

-	if (!resp->len || (sens_req != DIGITAL_CMD_SENS_REQ &&
-	    sens_req != DIGITAL_CMD_ALL_REQ)) {
+	if (sens_req != DIGITAL_CMD_SENS_REQ &&
+	    sens_req != DIGITAL_CMD_ALL_REQ) {
 		rc = -EINVAL;
 		goto exit;
 	}
--
2.55.0

