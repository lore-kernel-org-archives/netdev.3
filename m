Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B13218BA
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601918; cv=none; b=ALA/8zGFsQEyQKNq8mWZvwjS57SMrsGotgM7lrtHss6y9BPCFCG4EKkHrvZDFAGe3qhZ/SJTwmqfNjCla76tBZrL39iQ+m61TuaUlPr9366LgZhHq8jt6XJcO8nvCqyzt6BpUPxGVhHQAIgggwdlJFF65XXTMW4c/2RD97c9ggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601918; c=relaxed/simple;
	bh=w2K8xt4zqhcE2EqGn4AK2C03mTpm3iio5Rl14IWc5/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GoRRXulvciCVcXemEUvtsBqnitQUmxD5Q0tSD8oWldhHQi8ti47kkK7nuS4vsukW/HxVVc1V6cWx3nkxdCjf+LiIaPCby7x/ttr6106J6aYXj+F1PbnWGmv40SF+7wKKLcTITQYbw3bjRnfY+XJtbHCqR5D/ZWE5xf4mvOEESYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2H+bDs8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2H+bDs8"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484374f54d0so1108785f8f.3
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601913; x=1789206713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EIWO0mubRMzOhdGxKyeqO8ZgTz9Vq0CCl/AF3S1B9uY=;
        b=C2H+bDs8XvwqwSFgHX2ZDUgVJbGxEGo+8ggeet9BanCE2VcwrRs0/GX8bTbJiRC8U8
         O359ZRFzki/DiX0IM+WXFkoIs7+hQveQIa0NatsUMyfs/RnEMqvWzgqX9Tq3CyhBkSbt
         cQyC949yR4XTYvjkvdPFLJN82tjI7QPu7DkBeqgBYsUDsE7IlwiClTU2WaxXQTyDCalb
         0g0NJMdHFoeHp9fuCsZMo3AUUlIPChhPzgSiM7RSA1iWs6PeyEzSPpOZSSXS543FYXrP
         20c7XnQAOqO+9Y3223P1e5qN0nsUq0EkfXJQrUvFv5c5h1ZrAmVxZCM6BMhFZRmA2WWN
         7Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601913; x=1789206713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIWO0mubRMzOhdGxKyeqO8ZgTz9Vq0CCl/AF3S1B9uY=;
        b=dO1ik896QcApTa4P7RQ/dx1NarSzTZwcXAtRRNRPzX88/jN4AuSl+mhwgZd1azQAa7
         +GcHrRAiH4EIKDGpUnhlwwSkq5TovnEUnTLNGSO0wt3lUP+iXIFQe0LIfwUmkxSyy4Sq
         iZZ35SPwRkwPkRiY+NgFkP69Um1uGHI8N/lS3lQQ6/WqSAxqcXrefGeCT5dHY1FIkLNy
         ocstox0l18gtrue59zBTNIG1/NA3B3ZR2XFtv/j+EXjlq/gVsAQcVkcdwsybZ0pT/0en
         WNZ6pzwAUxcpKfmWVwPtTj2l54Iz22PxdR21z0/cDKTsjwaATmEi7kkEQ0VotXimG2ge
         96Og==
X-Forwarded-Encrypted: i=1; AKwUvBwBphrH5vh4ts5I+f7PTPRRl/bTifkGCLDt1/Qq48m8hkeR/4F4vbr0TCozB69YqrSv4zU+nH8=@vger.kernel.org
X-Gm-Message-State: AFuF++kS9ZKJfwss9XrH7vpPM63z0BSWx18ITtoQoWNitC++Zl5lyJmQ
	8iC1DfYmqu9/K7TjxGvXzPLqCv0ISLWjy7GbM9PzjYCzMZP0j9XOQzpL
X-Gm-Gg: AYBFou2UkDE05hZq40KbiC/Nuj+LgtUzrdafWGI2XCeAZwn8AilHV/mDv8x1CuhbsC+
	SNGtgaYU5QN5Z9iwGK3m80uyW1LxR4x5iGSErUrPrU6bBIkX5uWk310/9uMd1OnFb9N2C1LwTkJ
	iNXalNI9RMmMZAswxsmqbLqWH2y069tz0RA6y5I/FA1vyKBmdu/zuDMle4kH9ZipW8u6X5FIytE
	qgqii5Jt0Y62xNkxKW6tY1tDz5B4gYa9c4oDLO87vXiNuAkbOkTpcAfG7QcYHr3zScI/vG8qtt3
	6AITHl5/ci2FquOHxndvpgGj3MYhyMwEng42mexkWl8llJh505HWy/ujrcVypJF7a54jBjQu7gR
	4wmz6l8Yf3WWJPcS34DG/m20GkE4fm73Tfq79kuLI6NkLWLrE8Xw/9cdbso3DyVD6aerSkx2a/Z
	yeqLKID6eUDrOmjUdYbBnkXbYdIelZ2q24AdK1Zwr7rUBdNvhdMFpsVv64CMeqvCdDLxkG+1UQ7
	Ap1tGsFDCaSc22jpKiWlH0vGQVtS1Z1NlXMAFyPH1Wr37LmMDvgYPh7sN5vbwYAcY8BmRpd/n0T
	hWwN9uSSGcY5WCsxRbeA9iswhS3Yl2FCrfDNqTpIRN9qDm60HXnGT8a+NNe3MatpDpk=
X-Received: by 2002:adf:e00f:0:10b0:484:47a4:ae60 with SMTP id ffacd0b85a97d-48587046862mr17461476f8f.3.1788601913431;
        Sat, 05 Sep 2026 02:51:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm12717226f8f.21.2026.09.05.02.51.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:51:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next] docs: mctp: Fix the struct mctp_sk_key name
Date: Sat,  5 Sep 2026 11:51:50 +0200
Message-Id: <20260905095150.42180-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct sk_key does not exist; the type is struct mctp_sk_key.

Use it.

Fixes: f4d41c59135d ("doc/mctp: Add a little detail about kernel internals")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/networking/mctp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/mctp.rst b/Documentation/networking/mctp.rst
index 3bff00c11702..1b4bffa1ed74 100644
--- a/Documentation/networking/mctp.rst
+++ b/Documentation/networking/mctp.rst
@@ -296,7 +296,7 @@ There are a few possible packet flows in the MCTP stack:
 	: route lookup
 	-> rt->output() (== mctp_route_input)
 	   : sk_key lookup
-	   : stores skb in struct sk_key->reasm_head
+	   : stores skb in struct mctp_sk_key->reasm_head
 
 	mctp_pkttype_receive()
 	: route lookup
-- 
2.53.0

