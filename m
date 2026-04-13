Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCC238C3B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070870; cv=none; b=AmI1CfoVHWkrdSnFcrbFrK3ddHatTWtIQnNSJDm9HRNU9+44c/H+HuZULLqnB8dek8LimrgLySS76dX95ybZAHbwGbbC2WFE5uiouuJtDq8L8Tv0Oi5LBzgPetePQ7cSYwlUi6H2m8/X9E8Nlp8P8mBFt4wMfCndfAMjG457Gms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070870; c=relaxed/simple;
	bh=H3wjpyVBf0LnbYw6e4AyjTR7SDoBlaWMgxTIXA488tM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpXWYl8yZSMxc5I/u4aJVkTyMxgyTnyyJcQdoyQfKVSaRAPkERMzyGujzoEdp9h6Q2PVHR/BPAKF6Fyq22ixwNpijUWXEXm8/I8MLWMPAbqGR9vKZb7hJw2+ks7b+d+WTxYEqEQPWbdNyQBwH9Sa8QR+NoQVGCmLhYQvph1AAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG6E+B00; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG6E+B00"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b4583f0a1aso5964815ad.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070868; x=1776675668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E735hNPylWe+HKqfvVBJBLQM6RKjN3VOCvnHORms67U=;
        b=MG6E+B0074k1NQLHgZCxs10HKUQD+/0nvLgUKqMo3wkjnSR4zNU+zB+/fjclnT6IGt
         XCd/7HfZUssC8o7j1TS3jJXYtLdCAqvIePF4CdvqKwLAW9IsgNSkHFUpb9rDWMjplB7M
         /fDVmm4MMNepAPOQ4ntNXqa/nbN1pTTjHqfVAR2rDil6MXHqvyRBNAGgkSV6iukiGgMU
         ECuNTBO4qD2Ezzo/THHskMkCpct9TvCrnIGJg6B8mJ+UdUJ2QJBuRBjACuFdBvvhe+Uj
         7jcVpa6bL9WKjxgagLinDpRSLKpEq+c/G3Zw/dB6Qirjmc3oU+u4ZJVOyqFuT7yXKo4c
         WJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070868; x=1776675668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E735hNPylWe+HKqfvVBJBLQM6RKjN3VOCvnHORms67U=;
        b=Sf/IFjO4aaxwa8VQ/fsAN3tpQ/S8HC7MsF3fPjVl1LiYSP1GQ9NPzvzf0cj3FseaCG
         0U/0ACvk5XkkJ16bALevE6HxV7JjggLsPhhwMTCoTclHKvEyH7PfqXEXcy0xntduL1MV
         HjptrvU7qQxBLrBIGtmqFDGtTHVQzpylVlJa6ZhOK2rJOTVQcpVUlekZ9BBEO6kzD3Ni
         mbnxRFbJkJchyg6otJg2o+iddY1LztmxZUQY3egElyK5bRJa8OIdiEduBRS310I6Xjic
         oL1adPRmzsC0SGBptiveqevHvfocU+xrI/fgqYcbT79WPT16qvt6UYf3egq0YPgEHzVY
         1Oqg==
X-Gm-Message-State: AOJu0YwyQD3aZ4MIhQgtKeGT6s1GyR99qSOIoIr4jNg4ywWe08OTQI90
	YQT5asBeGYSBOAmc6Awde+NSACWXx3rbI4rFpKETFdzOyxV6uXmdZG/IR/e4mA==
X-Gm-Gg: AeBDieusa86kFEq/T0w+AU4egV7UafFhzAcxW6f5LnKpGNu5tSUiVidOj+yK2mlFSyu
	ZdTnXu4zMqTCdhFo96Sc48NM93hSP3G7YuokoOSS2/3UhAJ26DmYXxRgMy2WcydN+dEb5uuHB4L
	tAbjvRDMrxSp1lacWZxHlz/YRmKDGHqhbgF08jcn2bX3+2imcuI0h0LeinfRhhYvES3vIO2RgJF
	OM4tjOmRsdjQWXq4HfOX+XnoY8PLS+ncI5/IrI+NqYtBQakBuJxD1hVQ46y6AEMqtHiLDehV3Ev
	n3a2PLCi+mmDghtblahAEMRpdfZL6ESVK++J4CX2DpCYYkX38BQZ+QlR9uqC0n50TsxtM/qpRKl
	joVrCe5e3/rbacHkf4zoyiiY1xxqarbYq9YNgmkpPixVUDNj+Xeb+qT8L6Sr7PggprDopOeRRZW
	oCiXbW+7BaCMhZs1Td1Zz0QGtUUedAfZlXLk+qASse1DVccUOj9F4KkZ/XmDMLIg78
X-Received: by 2002:a17:903:2b05:b0:2b0:7225:d2c0 with SMTP id d9443c01a7336-2b2d5a4e995mr117629545ad.30.1776070867822;
        Mon, 13 Apr 2026 02:01:07 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db008esm103055705ad.16.2026.04.13.02.01.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 02:01:07 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] nfc: nci: Add skb length validation in nci_core_init_rsp_packet
Date: Mon, 13 Apr 2026 17:01:02 +0800
Message-Id: <20260413090102.77980-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_core_init_rsp_packet_v1() and nci_core_init_rsp_packet_v2() cast
skb->data to response structures and dereference fields without first
checking that skb->len is large enough. A malicious or malformed NFCC
can send a short response packet, causing an out-of-bounds read.

Add minimum length checks at the start of both functions. For v1, check
that at least sizeof(nci_core_init_rsp_1) bytes are available before
accessing rsp_1 fields, and validate the dynamic offset before accessing
rsp_2. For v2, check that at least sizeof(nci_core_init_rsp_nci_ver2)
bytes are available.

Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/nfc/nci/rsp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..01972c806b45 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -1,3 +1,14 @@
+	if (skb->len < sizeof(*rsp)) {
+		pr_err("short NCI_CORE_INIT_RSP v2 packet\n");
+		return NCI_STATUS_SYNTAX_ERROR;
+	}
+	if (skb->len < 6 + rsp_1->num_supported_rf_interfaces +
+			sizeof(*rsp_2)) {
+		pr_err("short NCI_CORE_INIT_RSP v1 packet\n");
+		return NCI_STATUS_SYNTAX_ERROR;
+	}
+	if (skb->len < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  *  The NFC Controller Interface is the communication protocol between an
-- 
2.39.3 (Apple Git-145)

