Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1046DFF4
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934677; cv=none; b=mEaa7bjEpH/MC77sRm56hiOSS2JdyC8C5WNnmr3XqSASNeY+7pUJNK3IV4rJo3tswWXJ7eLLBLMKQpTir55apKvnTVMxa4nByJ9N996XYvbQXDgfkEv4JZr+rxsGisIoCx1gV4w9YkgVO08uGjtg61q6IG11vSbnvUy0o0cftFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934677; c=relaxed/simple;
	bh=cKn0rvdC49BIcqAimFO1T40WDQRqjLgqEK6HkR4ZC2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dW8hxVOP1/aeUMRp/i/HollDV33t9Agonnai8Xsjmd81ehfM62IXyQBp2ok0LJWOlxMi8AjuVU9Llc9I9+GwziESMFuzT4ILJf8zGD3quyTXW9bKiqBBjFHn1U2fuIyAW+kqobyX6TuX/pFzIjM7Bl9rRJSEnai24d3yyiTpmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8EjLPa1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8EjLPa1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cecdc24b1cso1459865ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934675; x=1786539475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALanzQpzebmmM5lW2CkhaK/fD5aNgZLXF16Jkbg/hKA=;
        b=D8EjLPa12Caudz5U0Zcjb/flPVecOlyL+K/E8WSu5csiD3YojXKRZw4285DgY8BLzX
         oz9ngnNfyAIvKzYcAXxq0r1f4HduhJiPlGFx0K1YzIpZCnh6mul0FnUZvoAOYq30BAH0
         OqPOAvyADL5yg7tigZmgc2tAgfa85GyxYhfI1xrr3VWEiVG3qWN4VqRhTtn1cZbvZlEZ
         g0yOkoL3+9aqZxV3ORhA+Y2lrGesHEN72/ve7MGjElRpBVW6SephyB2ASPmxVQcL6OWu
         sw7Of3UeOSnFkgsTq6jtaQBZF1ehwZEgv5ROAdYvfJBWaww0/Oy7rnilKa6lHQqrMHbQ
         o20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934675; x=1786539475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALanzQpzebmmM5lW2CkhaK/fD5aNgZLXF16Jkbg/hKA=;
        b=JFJW9xbePA3mfgV3wMQXyHx0KiuPfC8TmNSzaUDaPV4Mfn6s7UNkWrStPu91p8ZQwH
         vhqDkxoOmRIWmNAMmd2jO1fh3O7Yz03dgyPZXdQHjhwl0u6Bq4G0j/qAylVwgVjflIkB
         NFO4U42LiVQ72XaFld9E0ypaO1o3Y74lcCbGTFtcjf5l2P0RorviahrE/ZQorJcU3Vuq
         FWJ2tzFVHl8yYrncg0d4ozl97bdA1vxomvzR0gmg5SZGofQD4lRibwd/Rbk8fO1ZG2gh
         KzrC9nqiWL/rN4q2ck2NSv70kdF+rLc6D4xgL4uIl0Yj7YN9PmhzwrBcSu8EQ+7u1mHG
         Y42Q==
X-Gm-Message-State: AOJu0YwV4KgO6DtWTnaf48moDCgD3O+/yjjrZKE/tsdlB8m+lLlyJqho
	GSC1IfMHZHV3MPdjRdQ3w+2ibC8Y1TQSfExyvC/IAng6J09pmZ/VUniLN+2AQx74rlM=
X-Gm-Gg: AR+sD12VkBdQSvVIVk8BqxCF4OsqjuJ7MqIB2dB/WDO3J3Nzf35wVJ0DkGvRE7YdIp7
	VOIWVASx00i51XrBQGfa5iUenUov/D+wxkMGYyPUZu/8zAfoGMGswrWcD7HGD2pBrLB1v86Sryq
	MauqGS9tNeJ48g4D4yTD34ULeB8YFgX8MI+kQauH0v8nE46CQSrHlVXSH4iR60xEIJgwiviPDLU
	wEZ/RpxwyzadkMvh8/3r+9/9qDSjbVZK594ahXNisCZ9uSuJpPOmFpjCMgThSWtxPnBGOKJ/iqr
	KH1C4ID5NSDCJRmqww7S0IGW3sXvT2S4lnrm7NDYR+1cGYUUWIvSh0Cqai+F6oLqCd45562dMni
	pzx7NOMmFxApTZ4xBfexvx407iKoyglWkxgQR0JpU+VxIMoP93RbiGq3eOInLUdKmBoUZzhdvjw
	UX4Sc5mBTmWlAvQeEXl8WtAnyJhYzMJY0M0NP5s8PWV3feuK+joSIo5gLwbSfp3/mZP2JlfvXzk
	MOYJ6/qZakT/kSaISyIhg2ij2+B3mxKEsMgzH1u4zWRKz53mQY=
X-Received: by 2002:a17:903:468b:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2d0ca761dffmr56546565ad.1.1785934675269;
        Wed, 05 Aug 2026 05:57:55 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f8fb4bsm16514625ad.5.2026.08.05.05.57.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 05:57:55 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 1/3] net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
Date: Wed,  5 Aug 2026 20:57:27 +0800
Message-ID: <20260805125729.19220-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
References: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

dev_validate_header() reads dev->hard_header_len directly when
zero-padding short link layer headers for CAP_SYS_RAWIO holders:

    if (capable(CAP_SYS_RAWIO)) {
        memset(ll_header + len, 0, dev->hard_header_len - len);
        return true;
    }

Packet send paths call dev_validate_header() on skbs whose headroom was
allocated from an earlier hard_header_len read. If the device is
reconfigured so that dev->hard_header_len increases before validation,
the memset writes past the reserved buffer, an out-of-bounds write.

This out-of-bounds write is masked in some SOCK_RAW paths today because
the same concurrent increase can first make skb_push() exceed the
reserved headroom and trigger skb_under_panic(). Remove the zero-padding
branch before making those hard_header_len reads consistent, so the
snapshot fixes do not turn a loud panic into a silent overwrite.

This path is only reached for variable length L2 protocols, where
len < hard_header_len but len >= min_header_len. No remaining in-tree
variable length L2 protocol implements header_ops->validate, and the
CAP_SYS_RAWIO bypass that zero-pads and accepts short headers has no
real value beyond allowing testing of intentionally malformed input.

Drop the CAP_SYS_RAWIO branch. The remaining reads of
dev->hard_header_len in dev_validate_header() are comparisons only and
have no memory safety impact.

Suggested-by: Willem de Bruijn <willemb@google.com>
Fixes: 2793a23aacbd ("net: validate variable length ll headers")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
 include/linux/netdevice.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..9a770eb823ce 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3531,11 +3531,6 @@ static inline bool dev_validate_header(const struct net_device *dev,
 	if (len < dev->min_header_len)
 		return false;
 
-	if (capable(CAP_SYS_RAWIO)) {
-		memset(ll_header + len, 0, dev->hard_header_len - len);
-		return true;
-	}
-
 	if (dev->header_ops && dev->header_ops->validate)
 		return dev->header_ops->validate(ll_header, len);
 
-- 
2.50.1 (Apple Git-155)

