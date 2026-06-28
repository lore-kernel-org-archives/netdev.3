Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD919277C81
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683429; cv=none; b=XMZaGGzezstXL0ZsTfP2PctRBkRCJZ0McWvGLokLRoJxhOV/wM8VDkRL2HV4qQH7J1PGNtKVe55niWi+60N0oCR0r9745sZz57ALbMqjziKbas4lBwijfa6ZtNADFU7Yzdc90lmjyHNgkgb013yD9i4/6Q/TJ+deMuXlHn+gTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683429; c=relaxed/simple;
	bh=4qFHrJ8TjRhzwg9eX6E4uCk78ScEs4rJofH5o2OZmu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eh7/zTylh4Mf8LtAdfhgm2tz1CMEOCvZevilCnEXUFNLR9L1gNOcWOZxPDGDd73L4nd53UU13hyLDxylP3y6Id3+iVQFJt03lDxK0hH9gESLt2uXNObrIQoHBL9LF/iNJEQM0f4HNq1JUQczG+nv1JVgGpb3kkug4Jbg/qXzOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlmrVxOL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlmrVxOL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c95a0c0aa2so17798115ad.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782683426; x=1783288226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=BlmrVxOLuMWywpvxEAR7aOzqiogLp74+5JIaPgaEwcmYgoLPqdOnaDCRJOhbynQ0p0
         T8XUfsRe1WseWBB5V0zm8MpcVoU70WqAuzJ0Dcsrlod/aUXr/3ySL8OY2ECd00R3U+ZK
         CN8F94HYkVYkaFfravcdCP9hiQQU7FQQgnXrsrBeETJI86uZl9Tcrbd+ltj7S3oO+BWx
         +OGLOHMyCukZ3YtoARPQnT7lfc7PqctmxbjMbjueC2IzyWsqm5mi1y0GzX3d1nT52HUp
         ntWCjXIL86LT5obNzfQd2romE50TPWQUM13i8kRDPJfCMy4FEDsePt6stIRwSbUGQcga
         UjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683426; x=1783288226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=K6uBKVFh5SadX3x+Pz54fFyvjPZDpW/QusvkNDJHev5SCRgYRZs8b4nWa4CSRaX/g2
         +yoAE2nP95tTYSETEvNnlg/ZmRVs1ivOPCIdc+mtDsISK6aZvmg/TzoXxhxPauXDed1b
         K9Ok7oz7/byiZNo4OlwG5jvKPrHTvLo2Zwou3WFcSW3qIDSRV2defqr2eZZ+pA3w0UPq
         FV4hczzJcGWcdrsZI0YLCdQ6bfFRgNSIyiUWD1TvoeAdZVkXK/k6mTTs3CxSil54RTXW
         ZEmilpnikmDPONRnfrlbUegshRbsIInW4rxod/A18knB8u7CLSQYBL3X6pWGpep5a7Ln
         2/BQ==
X-Gm-Message-State: AOJu0YyhjBQ/aJuMhW0FbrGwhwR04pevInDhm5mVotsj6wuZUwqx+ocx
	W6Oqd6QVOZwjLz3cO28C0gV+8ANwpYVwrKRVw5Au7R+x/UtFZxzCRsTp
X-Gm-Gg: AfdE7cngStpXnSXliHXwDnL0czQxrwLzrQs/VQLduDmwIsf6R4Lv13reuclG7GvpJST
	RnLGSThO8A3omt18vY5A5qeORfpnYhwps6u9IK7Cz7AqGKIJTfnYe1mQkG3S8Z10wUVKZ0HR8sN
	Yf+h9rhzlDabXoJrybSSJHLTyK8mQA/o4lShUZWEM7V/Yoa0N50DtgYAFpziCWv8S6Ujcd579o7
	5gcUk0GzoOEuiRzs06pURe3cYR8FpyGXeAQftJOGr22Fouy+A5J+LcCWV8QL9Up3edlFstF0WG0
	QRBlsA07uqLA8dJaZpRXTBq9vq0ufDlCOSnDMd0NWyLANUoFQZ+ECH7pd5PqBy3PwVWoRqXZuJC
	E+ta5wXBRbOgvtpTEqDX7csAgcuMcUwhEK1fhm5/7Fy1THuJkzfMG+cm1z5cu74E2aBY4AdJMdb
	inAAQpVsaGvRVFvconzADnBWJpfEKgze5Lgricy4bMkvgdtZ8hATlDBO9WdPPj9w==
X-Received: by 2002:a17:903:1cc:b0:2ca:281:27fa with SMTP id d9443c01a7336-2ca02812986mr8901775ad.37.1782683426051;
        Sun, 28 Jun 2026 14:50:26 -0700 (PDT)
Received: from node ([149.40.62.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9e95e49efsm14044425ad.52.2026.06.28.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:50:25 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: david@ixit.cz
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net v2] nfc: nci: fix use of uninitialized memory in NFC-DEP general bytes
Date: Mon, 29 Jun 2026 02:49:29 +0500
Message-ID: <20260628214929.135152-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_store_general_bytes_nfc_dep() derives the length of the NFC-DEP
general bytes by subtracting the fixed general-bytes offset from the ATR
length:

  atr_res_len - NFC_ATR_RES_GT_OFFSET   (poll, offset 15)
  atr_req_len - NFC_ATR_REQ_GT_OFFSET   (listen, offset 14)

It never checks that the ATR is at least that long.  When a
RF_INTF_ACTIVATED_NTF reports an ATR shorter than the offset the
subtraction is negative; because min_t() casts its arguments to __u8 the
negative value becomes large and is then capped at
NFC_ATR_RES_GB_MAXSIZE / NFC_ATR_REQ_GB_MAXSIZE.  remote_gb_len is thus
set to up to 47/48 even though only atr_res_len/atr_req_len bytes of the
on-stack atr_res/atr_req buffer were copied from the packet, and the
following memcpy() reads the uninitialized remainder into
ndev->remote_gb.

Zero remote_gb_len and skip storing the general bytes when the ATR is
shorter than the general-bytes offset, so that a stale remote_gb_len
from a previous activation does not survive into the new session.

Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/nci/ntf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 802928ca4d51e..b72545daa2051 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -654,8 +654,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
 		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
-		    NFC_ATR_RES_GT_OFFSET)
+		    NFC_ATR_RES_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -669,8 +671,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
-		    NFC_ATR_REQ_GT_OFFSET)
+		    NFC_ATR_REQ_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.54.0

