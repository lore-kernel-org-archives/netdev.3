Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBF43E9FF
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834081; cv=none; b=PJ3rVWjFdUd9KlVS+IsUh9tyNk+A3suMtjJ5oIIIQRu/jir5eu7c0GBk1eBUWQ/KfrnctwuEifQEZ5OEj+89S5YdEYm73s1ZuFlWWcjG48WgTkdmCnqXi+3QPkL44oaEDCkS9EiEaBmhOJjY7RiPOfsgmdAVSgN7vZnUxW2NKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834081; c=relaxed/simple;
	bh=cKn0rvdC49BIcqAimFO1T40WDQRqjLgqEK6HkR4ZC2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzq4UJxa62ve0cIKKha9RitsgjtXjI09a3sW8TrbQudcVCPOTyG/pkpAmTC1rzFejkTZJwCN+2ACw5kp6rayMQDrfHg2GeeAvSniE/z3IXlyY4fjBGVUlN92lHYCOduQzIXrvJukmlivCglG9YWZ4+k+YEwGKdZRwZyHwFYLRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de2h0YNR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de2h0YNR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a32ff53fcso404373b3a.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785834080; x=1786438880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALanzQpzebmmM5lW2CkhaK/fD5aNgZLXF16Jkbg/hKA=;
        b=de2h0YNRZgML5tODJM0Kz8NSQ/lV8Y8LLq5SmeIlC8NPdPgZXSo/3BE/u70FKeaglU
         3/8FlooGX6pujskVZVJ2wDmapHp0Ggu99ms/Foxj0a6bTKhM8BTDWcMrydcpax0xY1mz
         TcoYV14OLbP6VMuGmEB5IjDc1c16Tip5SGGOPvBnP+CN6hiTdlB0r5SQKvWR958f7wo6
         h2mEWgpU900dLT2e/snG2LZ/WQhUtQSMmhIxxiAz9aV/VEhRJunr2OiEDwC4q1fPLKz5
         izNFZS2l0VFZcUIGO9gzBVmWaLulE/ep7wI2ISiP/zTu8rHDnV0sJwXQcafuUNbkQVe/
         qS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834080; x=1786438880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALanzQpzebmmM5lW2CkhaK/fD5aNgZLXF16Jkbg/hKA=;
        b=tGiXlfSVn0wysbJwCMyWgN2xto4rmpW4Jy3/KI7YerHjKHinGJxlUIFTtiXone/css
         DLmaPsWWeCdJ9iARTK5QjTeTTXcKNR+MapMFPkTW8ZZa5rOVFzjdewqBB7PN9q16VfOS
         6d+YU844+kMPgnikvjF4Sys9dldttOZwLnICrWYWM/aDG/i71Jbox24rYFTz754cFLXj
         aAMND6IeJ0WzOKTVxggen9+LXh0mKfH+749rEhg6UJTrKyWlHQ21A0f771JPKe7eXYBT
         8tcwR4N4W5qMyfRz+Ocyu6OOFyqlhvCblxue8d+66Qe/YUfLYrnhbq/2lfQT5Gfnd4vQ
         TShA==
X-Gm-Message-State: AOJu0YwngAVqhx5yoVPRqJk7n6akV1WDdxVS2XTI/2W0iyYrtVEIMsxi
	BqnyB8PzSQPjQDpe25QxxYeE+pomfW0WJtSOHEuvk/gOdnCMVjPSgCGzPdS4pfdA
X-Gm-Gg: AR+sD100hqq9KvxxwEXTteFrts00LCUMotYSg7Hy0s1waynANnUNBZKpdIs0gGFlonA
	bd6vohauRw+pYK0tLywdCRT6Y0vbpMRBI3LjYStcAGxTp9t+7Y5bCyAVg+mtvZiTk4l3tYkMzNm
	5uIKxZlNtLYtpYUVgeXGM0bIb/dSwZbxuGo8qPGo8RKK0HoxuiNElLrd6bt1rUGU1fpphfYUICr
	TboNyxWWfJrY9Aah+wGUtx/1/jjOO3ZTVLA8Ky4RDDmtU3MO3pDD5TwL4dfsD8p+zub1XdIBJK8
	YSjzuradvryHOS272idIJRjWoxbAl2vPdVaycSEDcr7PZacYrx5DcXsw6c5HaeInI1nqeT76/2T
	9HX16R9ZppWMYij22V2xz+fekkpVFASyHEu4kylOp+sbl1Oklt7rUqE2gco5Nbqckf1M6xloniv
	7lIWaeLLSwSTvBBSGjR6gfht9n2x6P6F+8vzNWD53JbrQUAW5z/kqnEJN3bTq29A4apZ/QadFXn
	AfRKiDoH50UvOhV762AspLzyG2LKZVU/HhtUGCbWweSQnm2VZk=
X-Received: by 2002:a05:6a00:3d44:b0:848:3dbd:5cb0 with SMTP id d2e1a72fcca58-84ee48bb3e6mr16511860b3a.2.1785834079603;
        Tue, 04 Aug 2026 02:01:19 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45afsm4813032b3a.41.2026.08.04.02.01.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:01:19 -0700 (PDT)
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
Date: Tue,  4 Aug 2026 17:00:14 +0800
Message-ID: <20260804090016.33353-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804090016.33353-1-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260804090016.33353-1-q.h.hack.winter@gmail.com>
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

