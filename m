Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B71A3160
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228549; cv=none; b=ibESZ7g2vpeIp3FjmOCDTwHJdc3/rkFhY/Kl1RAk0+L9dd6gY1HiVUWakYmGu46FZq4JdRWeaxn3QV2M7kJSZ9Yxu9G/ZDNF90/eLZKalMhjLVcgjIRjiZaxIiXMMfuikAr9n6IME3XeMj/+Cdav50UtulLSb0qI3RcOuEHiJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228549; c=relaxed/simple;
	bh=Q5WY4mGV/sXcYbuyAdtfoPTqexnD0MLKQKM7L2B5no4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n/BY1DYsVmEieohqJBG/xlKKQL1Us192YJUzgUC68Tleh9fQk0Y2jWVw/O6cNMYVW6UCj6Yrd9RIaAcdMQPHR4qsg5StPSRkRGONXiw+KHHaRFKqoDxjDiBKglzZBGKKNph51QzxXQeqwe+Wg+WsoJt9eO8RXqN7Hvijo6yU1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDjUNlnG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDjUNlnG"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso3541879a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788228542; x=1788833342; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q5l77EYxAj/p40Aq8/m79QpRqrk/O0v9B05toG/6DK4=;
        b=XDjUNlnGPj6elqaQ9fhpS1XtIs+GpQCXQ2MAAMZRTlsn/qikKpphtXFiMxqPiQBYZw
         sCsRo/+0zCD/os9hLKv+OqFAjsTqanyyu28tCz2sA4KWIMENBeZ+9S4OmTNL9Vw0ToyG
         PWM7ctG0RYqQa190Azv7TepgguGmbOVWQwSVS57THzJSg67MOoBqEwsFgMu2QoQRQsB0
         /3Qtjz6BSW5dP1K6XkNH9qFIziNECsli6g+hPg85s586g+sZHNNjFYi6viykgFP0rUhH
         tokur6r5fvSZodsQ9CV8lp4KO3UaMN2ZtgtWrQQSI2Vrw3j3bzsV861Yq8sI3jyzFEXw
         TrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228542; x=1788833342;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q5l77EYxAj/p40Aq8/m79QpRqrk/O0v9B05toG/6DK4=;
        b=ZBTomiqBaQtzr5JcLLJziqpi3vuc/qE+2A+SJ1I4R5Ct6nQwIpLl02lJvnSvBip8Ca
         p/CwvJks33/MecSTFbyU8P+Aoa4hyHcsr2IuJuA5jFvfFrClp+f6H4fpYcb92VidJhYJ
         pcGoto6q7FM6u4Jsbtu4oqOu3cH3e0W/HBk7lerL5fN68HCdf7L9RIYwS3Lwg19/vk/6
         iphN9vage6+5JJlxYKCUCotWXC/p3UQScUESvkO7xO83vpaA88Jv/JNmI1ksAQadS6GY
         esxXCMrxpbhDBGwsjp8OtmKnonSClvy6WYDq5eHATjEWJqznQo9jxn5lx2BkDNrd5fnN
         QEfw==
X-Forwarded-Encrypted: i=1; AKwUvBw6gxANdUaDHKityxe2LCSXv2iSYxC8YYXL39vbouyMjCzYkHTZMnESP1ZmxhVaIJzw5QzrOsM=@vger.kernel.org
X-Gm-Message-State: AFuF++k42ud52CpRWYOMXux4CxDzloyr4icK71ShIE8VzYbN4WvTah4l
	YB7Ds1HZ5HvlnJOQyylvmn9No3+TkfsieR2zfbk7iw9TWX8+Jb/WeGj+HDg66L3h
X-Gm-Gg: AYBFou32s5nmup2XZa83gTFqJTCHYBovuQFFoTmhO6rMZfKM1MkqvzTzq96jc42PKpC
	4QF5FpjZa/dMtxhyq92/equfyiLwRtrEn6cNsW4abuxJgy7d1KiunVSrR1eX3qx/Ys7mx4a2HIo
	2uq9a2Tg9yRKfEkcihgOdsG9VDAu/zkDvbQBj/71s8+2upR36GlThHTiCQMvcSLwPasLtQxoeeo
	BfXptpdSrCqjE0nuxfb3Gr0neBZbII5vTsD4lvFCujVys2UrrtNvJfNhEErDj6VS85bNmRkgNfI
	X1cCwcZGYMGwaVOQonppkWu5DCwmzj62dPO3MrZ8Yy0y1yDM+6z1AhRq4l9RZq1FVcQ0wmFElgG
	8oO2UyA0c5og7Yflcs04/KYe1tYH9ixvdOTYPPhD40/hJIB1UUMsHZr0s/clNMofZayFtdKbaTT
	GuWuIzEjMLdkNd1QIlzxwFyVwqMjDv+vpeYoHl9i46tKkBj3TiZW5I7mZOSoJlM1F6/SF7LOA=
X-Received: by 2002:a17:90b:2b4c:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39907b651d4mr7328792a91.6.1788228541781;
        Mon, 31 Aug 2026 19:09:01 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d463798sm2569822a91.6.2026.08.31.19.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:09:00 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC iproute2-next v2 0/2] seg6: add support for the SRv6
 End.MAP behavior under seg6mobile encap
Date: Tue, 01 Sep 2026 11:08:58 +0900
Message-Id: <20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALozlmoC/22OwQqDMBBEf0X23C0xYrQ9FQr9gF6LB6OrbjFGE
 hWL+O9Ve+1xhpl5s4Anx+ThGizgaGLPttuEPAVQNHlXE3K5aZBCKhHLCD3VCo3V3BJSV6LJe1R
 VHCuhK61Sgq3ZO6p4PlZf8Hzcd497Z8eBJHY0D5D9Un7UbyqGHbBnGvaDdZ/jzBQe7YObhOIvd
 wpR4CURMomrqEyFvtUm5/ZcWAPZuq5f4OLBUN4AAAA=
X-Change-ID: 20260523-seg6-mobile-end-map-6f5560bfb68e
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=Q5WY4mGV/sXcYbuyAdtfoPTqexnD0MLKQKM7L2B5no4=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqljO6QepTWVxk4WuJO1kvWH6XhtznwlTEq8K0e
 TMLaP2WFRmJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCapYzugAKCRAq19F1Kl0b
 Te2fD/9NtDX2S5kQig0doMkXfmySYHecPw1vlTxY62udyUiztXiUXz1SoM4iXDGmRlcFnS5ZBSw
 6CACh9ycRuABd3iBQ5gYvcGLOLOmbsQUep1l+HJnww6ix2R7y6E9BiJX4YEcUzPatYe0DAz67KA
 6sQW5wHvFdf/F0o88IOtaryQfFFuSymGspgM3TlB12WaHPszQi4mtJQPLD06q0tkCfVjc7N0kJ7
 VKFF4JOElwUbEg/fdf5k1XOPJ15JUNePPaie4O+YPMCp8OPaqZocv8UVLBqSb7K+0LwyGw94/Ut
 fuh9vDgoKjZBOgRt8fSzx8Rv3HC5yYVDGC7WkDNt9ObSNxI3LiwppPG8zQUSCJLh0nk0k4K3O7j
 xsWsMzOy6ngNPvjWH1yleUgc4CEW3iu8GXIcOnEoEIEJYftKfA0jm0OQsc3DNJgq7CKz+fdP5U7
 lTk6aVby7BVU5Jo0h+qgaGO8rdSRFoFIqkK4MBr0azyfXGiVVUdLt/GHBVtwei+HX+l45RdSj26
 +VQ296fTU0+NeTJao3OI/mBilp/Z8SN9NWSEJNkvTDu6/kgYnFOXCamPUqyKWJPjYLRDtF8S6m0
 hlPfWpW6psVO5+jx/5lmlK6WA4LZ5E8PcsftfxGjymIjEbD5XilyOqjm390Eg8nqDSAoOJt/suj
 fxkz92TC6LmMgZg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

This series adds support for the "seg6mobile" lightweight tunnel, the
iproute2 counterpart of the SRv6 Mobile User Plane (RFC 9433) kernel
RFC series [1], starting with the End.MAP behavior.

Patch 1 imports the new UAPI headers as a standalone patch so it can
be dropped once the matching kernel header lands.  The selftest in
the kernel series needs the "seg6mobile" keyword to run.

[1] https://lore.kernel.org/netdev/20260901-seg6-mobile-end-map-v2-0-1629bfc166eb@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v2:
- Sync the UAPI header with the kernel v2 series (comment wording
  only).
- Document seg6mobile in the man page the way seg6local is: the
  "count" attribute in the synopsis, an ENCAP_SEG6MOBILE grammar
  entry, and End.MAP wording aligned with RFC 9433.
- Align the counters helper comment with the seg6local one.
- Rename the nh6 attribute and keyword to mapped_sid to match the
  RFC 9433 "mapped SID" wording and avoid clashing with the
  SEG6_LOCAL_NH6 nexthop semantics.
- Add Assisted-by tags.
- Link to v1: https://patch.msgid.link/20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com

---
Yuya Kusakabe (2):
      uapi: sync lwtunnel.h and add seg6_mobile.h
      seg6: add support for the End.MAP behavior under seg6mobile encap

 include/uapi/linux/lwtunnel.h    |   1 +
 include/uapi/linux/seg6_mobile.h |  61 ++++++++++++++
 ip/iproute.c                     |   6 +-
 ip/iproute_lwtunnel.c            | 173 +++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in           |  34 +++++++-
 5 files changed, 272 insertions(+), 3 deletions(-)
---
base-commit: fce739fa4f2ec83206d8d9435aa94ce22f09cdb1
change-id: 20260523-seg6-mobile-end-map-6f5560bfb68e

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

