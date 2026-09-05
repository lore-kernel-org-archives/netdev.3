Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B931A6817
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788600467; cv=none; b=AUV3Tr85kIoJWaeHNavgbCBn2DJZ+Lqs9l9O9bko4UiuyOLFJkR8zFVuzslh4Q28JO2V34r6InUPdD9Vz4T79ubh1HwtLkvUerObq1YMTA5PRHBC+iE4M32b0BUIUxRplNHwRxvHIJ6JD2MvxYB2SvT7kHgjX87vn8m+5Hf5+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788600467; c=relaxed/simple;
	bh=TS2ZqAYkMKJx7jd+0qJxM03yHKpGscRqn7r8XoSyCHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbY7QZ1zJ2c100B5+dg2Yo9VhWfD3v8epnrGXT5gnBVyhT0RgPtYmNBQITAIP4RoMo8VnqwuQT9c/RU6zRRqq/k5tLXPD5s/ZWGdVr6MqB/Ue5SfW95sjDUGXYkPb9el0HcptK/RwTXEu49z9f2t4xwvBr06rA2wiNBCM1XOlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFLsJGdm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFLsJGdm"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-484362f5c4aso2260472f8f.3
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788600464; x=1789205264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZoAyHVgP3ONjx3aSVQg0JS5TpUwPOrXUrMPzdKMVHIM=;
        b=mFLsJGdmtdDdUKbg30wJEQOlZ58lPKx+u4biuQOpFIwRD0f4Gi6N4T6+NJJ3ynSxoI
         qsbvS6sJb/yGbN7PP9s+FYVKfFMNPKvZQRY638CJHcIgdtsysaMEKPTPVrb8+U8m7LO8
         TRaBmY3vpljdjdGAO8i/w3Hmu8fnIacmoe4BxHvQ305uJVhNFHCXQ/uW99iEAffhtkZZ
         0Oh6LeUhiimB/9Z8drZ1Ci4bHvB6Vaao3cy3VJ1eKoYWrMuXlNHmL2EWvrxNpADfWPDS
         +BmN+9be33x3e4lXQkCJpIAwX7DNIpqbdRbwdlxP7uLDB7V84HRnx3L4+D9+9jMWxgQm
         LNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788600464; x=1789205264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoAyHVgP3ONjx3aSVQg0JS5TpUwPOrXUrMPzdKMVHIM=;
        b=j/xN5de54wbF5/gcRleDGg0DjeijKG2Um8wfd8ECzE3StMYX/L0rskeVBWEsm3fvg1
         nb7Kd4X/Pg5rHJNkFkHFp8R333iGn6cPfMzCfQ03Qxjqrwbbv3TTbqLwx293YkDHah1d
         kSSHlevGpDHOpw2+sLGt5BWOr4mdHpRrhnXYhaLKlaCbag7n1mm+iCzky2QEskzjdjuF
         rMbrztjs0GgdNZD0AbQnyWTx9utK4+oipR9FVlta+UydKxJh3ncBVAtazjJte6ta35r9
         YQXNeQNCuFLvkstKPhuh+3ZtE6MPJ7v4TG1+sNaH0DR3J5S3Xo72f/q4QAqYdxNjBbZx
         pmPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm6zBfNNChylU5C0cTmCpT25ZlKP7QLI9bWLsmdxaLImPg5FXPT6CgtTgTPaRo91dWFeZwp7A=@vger.kernel.org
X-Gm-Message-State: AFuF++lmGxhbABHaSY0YF7q70gCMkbDz9hGmJhLezrOT5qhduc1Htidd
	Fnbyd4DCYmjuYsjV2TzT3jZ6Yz0aNvMx0wcYtzTQJEi67/4YdOcWbY1A
X-Gm-Gg: AYBFou28ai4KQispw++S/Df5GRRLEzKl9QzhsWUWyMNU4SdRZWFhXxIijc3YuxxIvNr
	AcMosIQEUK6UBa+HETGYoKS0wbGwQ4/UOneB8uU9mydJUxrC8l0A/OIkgpLizMDcQln/ohYXekG
	WWm1oe+FJYbq4rC/Krl9/GAjIIT5631UWCMbaHBn48lp8s3zF830xqSguz1LUsMCN9zddOkbjNl
	4TQDlQ+qWNoVkmJJtcEBh4LvHU7fCj/YKVweYzSKwH6kJ1YTAsf1saBWaCDZ5G2LoCDRXBCB7xv
	IfbSbIE6qDwz8tiDDnzrUveR4Jy/GfvO35RaUHf14mnCrYfMLrC5nfqnaeQpcACdC5P5F7MMxwd
	yp8NBlUw5jp1m90Y4/8uaBHqV86aMnXDFXwcMOeR51He9rXBAJBAB0K5Lt4MnktzTlXZw5qEf4D
	aeqzTAiycPveyEBKjuach/Eu2TNzL0Sfu4jZ7FMqRrCAyTRGXRkvLxgpFpBHxmXJB19wFXrxln/
	tjcRWSK7D0lZ3n3BUGZb3QZAqwQP9VKxxny4aa0Ytrq6n9CxDZrs+u+zLn26iq8odBnfeDfJANI
	J2wSN1P0B1CuaBkf45HDVdSW+n33WZEXrgnLwrb0Y+gSadLE+7J7mmRaWi+KMT2sN8w=
X-Received: by 2002:a05:6000:70b:b0:485:8be1:378d with SMTP id ffacd0b85a97d-4858be14b94mr18555992f8f.12.1788600464134;
        Sat, 05 Sep 2026 02:27:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm11782654f8f.26.2026.09.05.02.27.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:27:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alex Elder <elder@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: ipa: Drop the monitor_rx endpoint_id ABI entry
Date: Sat,  5 Sep 2026 11:27:19 +0200
Message-Id: <20260905092719.41497-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ABI file documents .../endpoint_id/monitor_rx, but
drivers/net/ipa/ipa_sysfs.c has only ever created modem_rx and modem_tx
in the endpoint_id group. No monitor endpoint attribute exists.

Drop the entry.

Fixes: d79e4164d0d5 ("net: ipa: add an endpoint device attribute group")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 .../ABI/testing/sysfs-devices-platform-soc-ipa     | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-soc-ipa b/Documentation/ABI/testing/sysfs-devices-platform-soc-ipa
index 364b1ba41242..3b3bae2369d4 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-soc-ipa
+++ b/Documentation/ABI/testing/sysfs-devices-platform-soc-ipa
@@ -75,20 +75,6 @@ Description:
 		the ID of the AP endpoint on which packets destined
 		for the embedded modem are sent.
 
-What:		.../XXXXXXX.ipa/endpoint_id/monitor_rx
-Date:		July 2022
-KernelVersion:	v5.19
-Contact:	Alex Elder <elder@kernel.org>
-Description:
-		The .../XXXXXXX.ipa/endpoint_id/monitor_rx file contains
-		the ID of the AP endpoint on which IPA "monitor" data is
-		received.  The monitor endpoint supplies replicas of
-		packets that enter the IPA hardware for processing.
-		Each replicated packet is preceded by a fixed-size "ODL"
-		header (see .../XXXXXXX.ipa/feature/monitor, above).
-		Large packets are truncated, to reduce the bandwidth
-		required to provide the monitor function.
-
 What:		.../XXXXXXX.ipa/modem/
 Date:		June 2021
 KernelVersion:	v5.14
-- 
2.53.0

