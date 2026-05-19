Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126B3D813E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175827; cv=none; b=lUyniSybJQJ3mAlNcCgrkboxRssrza18ahudiN2keDhmMDSIcTZ9OzdV5l5oqpbucDE2lHn/g83m9GMrc+6G4ev6jZLXn9FloL1oErR5YPBN05YDiuTdujmRMlZDhICrATv87JnfBwChYXCLwoYsAQlN+Jvpz8XUvvqWX5mfvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175827; c=relaxed/simple;
	bh=E5tbrL6gDSZ/C+kamk4PKO0Wqa9UDvCknl/PJPOeSAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGj6WqUEH7Vhw4WSE2Lkuj+Vhw7g1NW+4vh31X2MHvK1lHEnOWPyPCYGJmLW5YawIT3t8tB7M6VWadrFpwmq8s67SMXeVAuyxjFwiOrXh+ibbF/pB173qzL+dPlSxzfHKVz2YuCqjaOOIsrFUwvOmwgsaC8gKxVsM3HLVsf7ONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0mEfy97; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0mEfy97"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-444826c16ffso2745483f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779175824; x=1779780624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=c0mEfy97zwfhA0j7z42mj6tQX/pTQqWKLjiwLxcd8nkUI7qZjubdJ54X1h5riyVpm6
         GVXpWrTLfaTE6BZj0l7X2PPFiAOcm6ta7M7feP+78Ua0JVIXdScGWXW2W1d3FIEVauVX
         TLv5TdkLE9WTsu/fjfEGswmGSW9YcYTM2pI+nvi63aXIzWoSgAW7CoN/iqklflwX+2GB
         5/hEKtounYZxJbIq3hof8hjhugEI5JnYSelJ1ZG9yy97OuurDX4f+I9VbotZ8npd/0cy
         f2oyH4pYZU1NsbV6fJrXL9ewA5FfWNtRXrNqXJVf9UPHp8zKXcnlWPZzUUUs6hGO4s3B
         2REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175824; x=1779780624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=KOlj7cKtccUDergIPsNJyHw+N7ZOkRt3lHib2Q7Zy9WHlLjH4KEk0S7OetpVEun0Qm
         9M5LSgRZJWQ396zPiaagZwktBHHdUuYY/vTQSMWy1Cgga9TX5zh3r3LAJjLUX51UxidO
         wnDDZOtSXQy9WSauqkiDrDpSKgsG76mVTNE1iGUiNz/NBaQ2o/BF+LnikqJaiDJX2UNg
         Ya4NQR+uLDbgDy2TWNuH1TI2TCuawlgjMo/ct4jiWmUcDdq9q0H7tPmN9nUjz8sjLGlP
         P4aE5SsbeKmQL7pYoCWZDIGuC6ALIaBVDsvS03cNbdoUPitHJFzhJ5OYYzsBoxzmEn/F
         CAVA==
X-Gm-Message-State: AOJu0YybJImdukuM83PPfySYKdLxa+9P8Un8iOKyN9Pq7LpBBvRZF5jc
	DEhXYvdDKirVFdRY3DXK9jLBNxKek1ooVyJqC/mMVMtC+Tchq5IGya1S
X-Gm-Gg: Acq92OH9VgHi6/aPEUVJG8Z8oVD0PBA73bltoOhcWVn8xtX8NXXjV/147M9cMc+Nz8d
	HeMT/f3gOI13RqPl5UXbaKJnXWS5u9hGU1tB0OE+CJMP5pFzE5EndSkJ0khUNLzotz0Sxjx4isy
	dd+UHltYQVr7Ohh6P4iB0MjWIZ7+cvTt/pTOdtqeXSW4Q8x3X+xVmDEyRbaRKyNztRPsB3HK/xG
	861Z0XTjAOgyzLNa297TSO6mDDsyeO+563Hj6jun7eBj8aVoXsBeoBnOgfJ1NdjDlNKxowIG8kb
	/qjQG0CzPJFS2wfn8XD99aWZbC+lyMIfYJ71t7nhoSOpFjZq2T8DaWrjyDlwSSvQ3ZHGfQQnmpR
	wQTj9WOw+6UwJTp+hcV5UA9P0n3+9ix3dqLYWxG6mxVp55M0ae6rPhvy75UlOJbvaPiDBYxigs7
	4x9XIaVOUmH+a4/ZRK28TskXd9e94BugBurCk4fiZcOumAox8kRCm/IlxtMhS/BXne+JPnd80FA
	lw0tTqFMg4Vk0MKAlZ8MMU=
X-Received: by 2002:a05:6000:2503:b0:43d:6a0c:9571 with SMTP id ffacd0b85a97d-45e5c36bafdmr29954236f8f.11.1779175823595;
        Tue, 19 May 2026 00:30:23 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm41776680f8f.2.2026.05.19.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:30:23 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kees@kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 03:30:03 -0400
Message-ID: <20260519073003.34206-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Add a minimum length check before the header pointer is assigned. A
well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
len(1) + fcs(1) = sizeof(struct rfcomm_hdr) + 1 bytes. This single
guard prevents both the header out-of-bounds read and the skb->len
integer underflow.

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..6b300237c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	/* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
+	if (skb->len < sizeof(*hdr) + 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
+	hdr = (void *) skb->data;
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
-	/* Trim FCS */
+	/* Trim FCS - safe: skb->len >= sizeof(*hdr) + 1 >= 1 */
 	skb->len--; skb->tail--;
 	fcs = *(u8 *)skb_tail_pointer(skb);
 
-- 
2.54.0

