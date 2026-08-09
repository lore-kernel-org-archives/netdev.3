Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F522126C
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259854; cv=none; b=sTYqIMIeuHVZFvGMkodIoaxBCTy0Zq18Rjj/j55AnCFLVtkqHcrTBTpMFRj0tQDtPJM28XLS6gXSx+DsELfFhwsP3R+yMsZyMjXrs+m3lS8qidyV0Z+r2PXAnc4xuSX+bytUbSdVY1XPDfKAbLlN6Ybl8YOW97NIytibqA7epqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259854; c=relaxed/simple;
	bh=6dTHxNbyOD5MW7TRBHb8S9Rxhd7yZvouJR/0ccdAayY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFUIt/KUzjsrjNW6o3qckyIjDUH00m+Vg/ewvQ1vtAohnQ0JdnLR4VrStGOsvRo8ZUJkcMqcrByKKRCw63ZRFwvleeRQMhMCIx6RwkyOVOtCa9m/VHkUYDYAYaILa9Ee4QZ9xGbN0+XdFq2Ev4r8/q2XG1siFtVU3VzxW+E/Yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW2oXwtk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW2oXwtk"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4813ea321cdso125903f8f.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786259850; x=1786864650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsqdGy9cdziieb2l8rv8bO0GNGyjq+sgBYNGvvA+Alc=;
        b=mW2oXwtk8whELQDVDvwS/9RIFk/jZ9JQaWOW259WszwXYXhaSW1/PQsE+c+AAv0AdT
         BH0Tu7E/6Dibo4TkV8oFb8YLcBHXROnGUTvYiUtFm2yxu1UktNLMBjPb1XUtsxAyirpU
         RifMjBTOxLj90lDKjDyta9ULZGWXz/Exn+Rh2s3fHzqtKZc9DemSTm3Q2ey6rP5ZXHVw
         0LcquEZnK4cJGkhL/CnjCr8jKYLHzy4GiYeQSONdbV1HsC1fFyXMyHVGsgg9H7sRLbMx
         TDmEeUgN7GTDj2MXS2aOQDAeFczP99TFFIDQ8AsvwYsogFO8Mxg6Aqyc4DR97nKz9Z1k
         58BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259850; x=1786864650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsqdGy9cdziieb2l8rv8bO0GNGyjq+sgBYNGvvA+Alc=;
        b=kI19z7MjyWsd0X3r2ijQbn6hrqaIBGT4b1/gesgZiWZi4UFjXueQ8faNMH4V8lBnHe
         W1tEKuEH77fxWejlOfHnU4wIBXIjOY+Lb+DPPkhvDWTo1xUoRQ+GUcu/4fOJT4CIe0HU
         4yvnWvwoLNBrRFltlqGg7Ta8ROslizu5dSKoD9AAASPyYW0CLg4YwIiYLFPTVCoCAAO6
         M5AtbU+JRhU2vSz6n9uyQ36wT6QXDCpug6KnovU5vLWx3SWM0SB8XhSnXcJZa+xpcxFa
         m7pi9C1rwcyIPZceglR8UCkXL6gm2hPtFlEvx65CF1TlRiGKa3vLZtq2NxPyAIapoJNu
         wxUg==
X-Forwarded-Encrypted: i=1; AHgh+Rpv4gD3C09RUGAVX2Qk0+aQ3WPVNusV/xuyKFlpnlO1z3VMu3XDl03hxT/QaxK20ySlordbkZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XLcAZ0ZUVvNU7G8INmZg7Mh/KhvKjgo7zKaSbdwlDYBEYwe8
	wDBnstDMA3WFNDGEku2LzVXkldU9vycArPlsKkRpyPzJHh3UCHwMfRbg
X-Gm-Gg: AR+sD13KBVo25j/j5+lfy+hws30E0C2ZT/too1rOiLeoG6OEYuoOtp1v8x9UhooZtz8
	EIDl7duLGHpxrLVVzLpR1ZJb5CWtLJ4Nm4gCbicbnZVQxI4y1nGN3mwnkeiOBRVVc7qcxn0//Tt
	iqJLrfzlk3dDX0oUPxU45WWyWtFW8WJoB/op2IQPoM50n/0HmgNLHjJaoKyTIqDR86TMhkbkimT
	WFYTUwiiV++Fk31/moT7AhwysOpkQXYrzsLZhthjTvP7NPff2auT2BYWOnf1ogsNqh2MXQmgrG6
	cKaPCBeKG9qE+v/5A5rYqUDcJe0JIKOlx8qJGSd0AnNF8zhVt8M58sCVW7X009TsXzlqan9zJAI
	+FPSjQ8exvdwS4bS6JCjg1mDrpdawovh00FDel66s79EbQfMD4O3eSZKkgg0zAbpEUoF3S87r2f
	hNHS0lFP8IT9YC83R/yyQv2zN66GbzH4JmfGF48rYhtB+Q6azRs1ID6TlZofz+cwNo59wyeJ5T4
	/3YTiQlfGiZ
X-Received: by 2002:a05:6000:41ed:b0:47f:9158:5924 with SMTP id ffacd0b85a97d-4813194f0aamr13886113f8f.9.1786259850102;
        Sun, 09 Aug 2026 00:17:30 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:326e:6633:827:b28e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220a6d9sm22998297f8f.34.2026.08.09.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:17:29 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] be2net: propagate bridge config query errors
Date: Sun,  9 Aug 2026 10:17:25 +0300
Message-ID: <20260809071725.944734-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

be_ndo_bridge_getlink() returns success when be_cmd_get_hsw_config()
fails, hiding the error from rtnetlink users.

Return the normalized command status instead.

Fixes: a77dcb8c8ff0 ("be2net: set and query VEB/VEPA mode of the PF interface")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index ed302f5ec476..49646e4eeaa9 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5028,7 +5028,7 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 					       adapter->if_handle, &hsw_mode,
 					       NULL);
 		if (status)
-			return 0;
+			return be_cmd_status(status);
 
 		if (hsw_mode == PORT_FWD_TYPE_PASSTHRU)
 			return 0;

base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
-- 
2.43.0

