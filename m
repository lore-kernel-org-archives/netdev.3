Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F7378812
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702553; cv=none; b=GB/FY13pDZi3z1TRvw3dWbvZBbo1rqwa7U8Wjf5QZNKt/9RiHeUgsmoj14ghuzp69fScCzBjtE0xBU9n5rK5ShgCP6NqClf/1pLLBOE86Q25uMwrTx+vp47WktgdO+uhUMgAW3PCOsw1387tK/mgfR0il6US1LNxRcrRP4XY9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702553; c=relaxed/simple;
	bh=tC/vnqhpyr5u7JUYEaBg+0egv5ZlzByVSdGqiOYaWxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG955UrTWEoyb2VNJ8eTPkgY7nbg4LmtP8cPcAYEnfrMjkeM4PF7XIc/AHq5vcbOuJufgLJ9lJkEIptSgLfKkpMBoDt9aEYHB59b/sHDbiGXWr2DWWHaRU4bougjEHFBdP8BsFpnR1RZhhLX322eXGI9GmY3DQnaKjruHlAljzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy4ehbLO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy4ehbLO"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-827390e8a3cso5122398b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772702551; x=1773307351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a80maZyNKc4ouURWN2d+H67wXFOguPB/alLVdRyxTyY=;
        b=Zy4ehbLOt9aRxR/+5mEG3nsdMnZSGHTJIqIs3ZzHASnTFrS/ZNkz7xTJgY1JkJiLeY
         HUSdggTRoDW5Ll2K7zWAy5WezSX6Ork/TVgnHx716qRlt58e+Imv5FxSwqkQr1eRSgLo
         vubTf1eX3/HwMzLcNGoMrUoJEf09XGksOxogoySXNSD5+RqArnE6EHNa2urM32AEwMVW
         bx/0AnLDQJYhGWdV3zPxA/PkeuDZGbkV0o6wh9p4CRgdVCB+8tA4dRh2T0VStg2xS9dR
         69xF5RkGwV8K2d1LFcR9q54oQVa+DfQkzU9QI4yO7V9mitUJXgYjpLGN132XD/VWGATx
         ioFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702551; x=1773307351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a80maZyNKc4ouURWN2d+H67wXFOguPB/alLVdRyxTyY=;
        b=ulIFbeCmuwabGk9lC5NC0JDFyTDQgAkFsh6t8jBs1Yg+8eDXWIfXdRumwHw6nBEJEV
         qbvvz1kcaNKzncpZPMrmP4ucLvi0SpPSPPvba793Cl7PV0KdkYTZHs9Kb8+M3WsZpgGA
         kmnuYXtY/9c+F5bruXibE5hpxPUAytEPnm3Q34zBpJj3i8LkOUVRW3/oBCvdH9z8TBiP
         sPp9AK8CbhF6xHMygngHW6HQ/AgD8j2P8KTZsBlzt/suuZ6J53AhXBNgqYPS7eU1VyLb
         CQc/tWUxb4f+yD7yrO9ucDKNCHmhCmKGaxFtVfvZNwCJJ2MR//w6HD0WJTkxzRmJYXm8
         qFqA==
X-Forwarded-Encrypted: i=1; AJvYcCXCM9nBJkeVmn+8HXT64gXJqhV7MSWFdISXf/dLD/CjmQYNSDR2p3LcC/n4Ctv4h13nvsSZ01M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OWsRPuaYtHsafdY2IejLS7gPWGZbkqKHx1lwk0557dmzlkkd
	biQdfysARQbEIoFfNivaZX3eR1PUec0S5nLrVk1hhApLqSc32MGee9O2
X-Gm-Gg: ATEYQzxgL0G4KrdQ29KZpZfd6+7iI5ZAL9Gpf5AHcmCqZlUH8sJYl/fP7eQfKf8V3mO
	TdEGl7hfRmDsDy1T121wgaTv7xykQFrR2U6hUuZjF4zyV2epxOuFwisYc7wff3vUlXJOI05rDfi
	9Gq5SrJK8ojdbDwRhWmx+BaFxrtrkfp8s/3BWxdS3EEBBeE9A1hFboB+no7D04/rd/6V4cB+g+Y
	FLAMvFosavY3wbyR8+A44DnFR4Oyl+kfvIZetYbZ+tAHqSzmRVn5ND4eQKxFQmzDoz8eoADgYEj
	/HyGGXJ1z2Td/Mw4a0Mil6K1XmaceROZhLPHqi8qv8lBHSwWsc0Bu0dLtlvAey7UAL56wLU1L7n
	/viYa5WkUcZUNK7HBfjA650JC+cwaCMYH19tF7cUapdoTTGp6UtVH5djIJU1zhcvFYoE+WzkfkP
	UEkVKpdg/2OqDl1bcMGcsLThf4Y+zE4NLjkdFrdRejHuUcHeaaiq/8VUy02qBIJ7jWGk5iMTw=
X-Received: by 2002:a05:6a00:1390:b0:829:79bd:e6d7 with SMTP id d2e1a72fcca58-8298583cda4mr1509612b3a.16.1772702551060;
        Thu, 05 Mar 2026 01:22:31 -0800 (PST)
Received: from ubuntu24-04.. (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff34fesm19718200b3a.42.2026.03.05.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:22:30 -0800 (PST)
From: sawara04.o@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 1/2] net/smc: fix indentation in smcr_buf_type section
Date: Thu,  5 Mar 2026 18:22:23 +0900
Message-ID: <20260305092226.27379-2-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305092226.27379-1-sawara04.o@gmail.com>
References: <20260305092226.27379-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

smcr_buf_type section used inconsistent indentation compared
with the rest of this document.

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 Documentation/networking/smc-sysctl.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 904a910f198e..17b8314c0e5e 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -23,17 +23,17 @@ autocorking_size - INTEGER
 	Default: 64K
 
 smcr_buf_type - INTEGER
-        Controls which type of sndbufs and RMBs to use in later newly created
-        SMC-R link group. Only for SMC-R.
+	Controls which type of sndbufs and RMBs to use in later newly created
+	SMC-R link group. Only for SMC-R.
 
-        Default: 0 (physically contiguous sndbufs and RMBs)
+	Default: 0 (physically contiguous sndbufs and RMBs)
 
-        Possible values:
+	Possible values:
 
-        - 0 - Use physically contiguous buffers
-        - 1 - Use virtually contiguous buffers
-        - 2 - Mixed use of the two types. Try physically contiguous buffers first.
-          If not available, use virtually contiguous buffers then.
+	- 0 - Use physically contiguous buffers
+	- 1 - Use virtually contiguous buffers
+	- 2 - Mixed use of the two types. Try physically contiguous buffers first.
+	  If not available, use virtually contiguous buffers then.
 
 smcr_testlink_time - INTEGER
 	How frequently SMC-R link sends out TEST_LINK LLC messages to confirm
-- 
2.43.0

