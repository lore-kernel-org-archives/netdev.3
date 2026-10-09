Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F313B42C6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565131; cv=none; b=Qy+17rCY0lx5zDSfUtFsMCcM0z9Kriv09dHyjlKQSx5tSM12cdMTdpj5XUHs/7d/n8G9L8iNFoK8ReZ3YK30UCj4kdHX+kPOV/iYrEMxJ2KUemMJ1Vk58VEW/BvBIYYcn2ulcbOjnpcIIco7+nu3fz7U2ex2MuAbBZ2vkZWC2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565131; c=relaxed/simple;
	bh=s+pgwaIhoAKB5TYzttX7X+vT+586hf5yM3Ll9Pqk8KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFgJ3VdxxS2MTQ4pOBKH+GFCOdKEPc3mN1jhQnMs0KRua9oKkLFTYOiRiX5qt2eLN6DWkON/ECsn+/YTwUZcLNQUDQp5+zBPDsCD3m//8R+nQElyNg3o6gLLykOtOrdg0dRMi90iEaadU2uIxLKws87rj8tDMKL2cSx7Jc23NiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRm2clI3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRm2clI3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-878b44611ffso3526717b3a.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565129; x=1792169929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQ7BCPJPZs0rbKUt5hEFk4a7TJVk9czU/DoC2Om2fvM=;
        b=jRm2clI3raqPk93iFnziHKzfOzkaKmPRezDJPHIcj13z3PkRvXruZArJz6Xyv+nUuv
         Fo7tb7Amy8lmPKZAtHybhu12xWylmvVn0gGYC2rIlfnP1RRYnhKaB0YurHXTw0n0JYgr
         K89VW3T7cTOlvCDD2VALusWnrqmbrv3wy4XzmGR+LmsNRei8n8eu//gIJwtscJ6KYJQX
         dZnU7FvJNX+6Yq2B73/+RV1H6yVmvZtdRSx+eAAMjMmU2P8YD8vV0qkJXOTJUQnhnsGc
         Db+J/4NXjnRLLrJCDNh+UNMNNPBksHrkDTKQcSt3/QIsRZdQAxBfP1Ne8M7e4o7a3V1Z
         lq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565129; x=1792169929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQ7BCPJPZs0rbKUt5hEFk4a7TJVk9czU/DoC2Om2fvM=;
        b=M1vFm19NmtSlPW1QTwwlzQ6CYfe1Gf6/vmLca824x+Qv6ZpajTcXidDWG3AXNx/nqA
         6Rrvl25+9ZuNN2L5D9tJN0vUS3kZo87mw6hcuNo+6nPFTokg+WNRx3sRXEwCOA6xlaBS
         Z1vw6Fs/NHterzaxkit2gVZAD7qrGsq7quYctu7dsaVWoZemLavSR4dhCFiF2cjfGMf6
         toovj0XasNVNZsbtxx1Y38/GSdX+LvdG/D730BWDDKKQOUp3LulJu/O4sSQawLbvNH9T
         yq4TrUBO89DVSJVdGGG2UOZ1k6OAWlYaqernjcUaZG+xP06Ye3Xw9USbIQCwwxnztTDS
         M7QA==
X-Gm-Message-State: AFuF++nto5Yc8cxZS/sE5ojv2WteBFZrCvONqpJEazr0jYMNfbt+N5k4
	yBbokCCC1WUItK/5Othy26uUlY1rg1Y8uh6a46vw7XiXxUAdHFs7gyGFzh3KcZeX
X-Gm-Gg: AYBFou1Fr43ZA5pjLEtO37HLxq2Z7JixNdJbauG5AqsKbihlca3Y5I1TXC9SHcb1PZY
	kzQw9hHp1fQG3gq6uEhJWfllJRk4bcj/Wc9RCD7EGJD4Bnj/DLzrcIdHVzPNEtWeesf5aWhjV3V
	9C59bV4x7xMp5NTQySljgVbzhe3Up7/NesXqlQosC0ozflk5pN0wkMhTaHjchmYW/aGJ8g1T6HF
	5vGwVNxS872/SKvZxKE0z6K4Zm3+MEzdmKxY48khWIPC5eGUJKi7FQIAbnWDzQNP8Ad0gQfKlf/
	ISF9gX+DF67UK7lykb8AzTWEdu6Aa5SDKrSWLpof9W1qfESPcPmFwPxW5PKq1NlECOf68noRdXR
	nBBgrXrst8JQSI4ByqtqyCh7nZz+rFQUcd9gHFhDJkI1jsAWnmLCfV3tm7TLZE/jCazFRQBZIkp
	nmyPHIs4QwmDPunvIHmeA7luvsT6mpcfIM2qKp3Z9PJoDJtFtjU6KwQsL71LsIyD+WyRhNXhAQX
	11+u2NtLOpFbut2uywXlpzuAQ==
X-Received: by 2002:a05:6a20:2451:b0:3dd:a196:69ec with SMTP id adf61e73a8af0-3e16bf36b7amr2257934637.71.1791565129145;
        Fri, 09 Oct 2026 09:58:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c37de994sm1494437b3a.26.2026.10.09.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:58:48 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/4] net: dsa: motorcomm: Use NSEC_PER_SEC
Date: Sat, 10 Oct 2026 00:58:20 +0800
Message-ID: <20261009165825.359259-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009165825.359259-1-mmyangfl@gmail.com>
References: <20261009165825.359259-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of magic numbers.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 433a428ed070..be3321df8868 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -25,14 +25,14 @@ static u32 rate2token(u64 rate, unsigned int slot_ns, int unit, int C)
 {
 	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
 
-	return div_u64(ldexpu64(slot_ns * rate, -e), 1000000000);
+	return div_u64(ldexpu64(slot_ns * rate, -e), NSEC_PER_SEC);
 }
 
 static u64 token2rate(u32 token, unsigned int slot_ns, int unit, int C)
 {
 	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
 
-	return div_u64(ldexpu64(mul_u32_u32(1000000000, token), e), slot_ns);
+	return div_u64(ldexpu64(mul_u32_u32(NSEC_PER_SEC, token), e), slot_ns);
 }
 
 /* burst = 2^C * token * 4^unit */
@@ -83,7 +83,7 @@ yt921x_marker_tfm(struct yt921x_marker *marker, u64 rate, u64 burst,
 	}
 
 	/* Check for matching burst */
-	burst_est = div_u64(slot_ns * rate, 1000000000);
+	burst_est = div_u64(slot_ns * rate, NSEC_PER_SEC);
 	burst_sug = burst_est;
 	if (flags & YT921X_MARKER_PKT_MODE)
 		burst_sug++;
-- 
2.53.0

