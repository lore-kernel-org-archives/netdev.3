Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101398;
	b=yoHNxcL0yLUqduidQi2KglR3Czq2lDdch0Fqoc7AyMgFrFaiYzO1Fp18443QV+RFAZmx
	 au1XGGs0OubbDJGB2D2ir+OBuQGO9UCkK9jEDMuggbBg1I0tlswH4Mm7rToqUJcyqZHs+
	 SIcWzGkx2EjZbEiSFi3CXF31MsLGvZG9m8ezVjeIAowJZPfFR7K8/o+VFI+U2q4gwyQ8Z
	 13e50ezbCieq0fvSgqy0Oj9ixFzivrSv+lfEIxdtpV3h9En9/zzM7INQRC9c13ilThBMY
	 ZCNHpKNLrfKHwh4fJMhaL6IOvj/7FZvM6dYRhwRmgBTuvPCFxSBOqH1qB8HpcTUPJlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9WnrEUM1+jghNsVjHaGB6d6gihbTRiKHtTY04iEnYKc=;
	b=3L7CUgHJ/EEqQVS38D8YmFdtN2aG5etlAKyyiOej8yXxLAY814jiTl8ccvRqqanFuTLQ
	 9k2DU7h8TuKo1XJFYVQ54FFddLk7rloRSbPoN0ar0O2Dn92Tg7bbsLYdO6QofbAUDyQLm
	 Y7sWHACS9m1VFasEtfSFVaC/FO2WTvD77fSE7dqfcB1UTB+OBpcxZm7A85udrXHOX3w8a
	 Q2EZFv1eUMU0FK6O5Qx+Y3Kdr7Vn8+fID7ITykh3ySYVZumDuTGa9+WvRULG6Hy88gpQt
	 2mv2LFckTYerlmP7wUQjiO/aOa23Cz1mjUoYIlSHg3U8anfUA3ysW73/JBOv4gm2YQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ds7ZQkCL;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D87606A326
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 01:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D87606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ds7ZQkCL
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b203b0c139so70695b3a.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 17:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794101397; x=1794706197; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WnrEUM1+jghNsVjHaGB6d6gihbTRiKHtTY04iEnYKc=;
        b=Ds7ZQkCLlKYJHVuhaEvoQBTdTNPJSbw+HU7gb/ev8fzbeh97E7VJF6kS8LrKCPMntk
         oqBz1eCvZrqDdssL3pJrLrEZZtE2IJdZX3JMj4lyA3cqZw9onDeZ8KIxf9PEBoU+bPwm
         AyzXhbQKvlm7LTG3FcLURsHwkI2XM1gS9nwoTP0Qk2hT4wCQfK6q/27tL+Vma62QNd61
         jqfmdVXBbf1Q7zT0+bF6+jGiJHyR78cs1FgOI+sNyhsaVZzgWO4+H8TXUKHf+GqhpBda
         Yn9BRJ4EDcdJJI2bNbhiKz2vGxbxACvOmoGtkkJMbd14dzKOUjGxBIBHShlCEOVArSsH
         JZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101397; x=1794706197;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WnrEUM1+jghNsVjHaGB6d6gihbTRiKHtTY04iEnYKc=;
        b=lgSOEnG/hYfiBVrPYAyCEX4d9hW5UQY0YI0ZCbztY7MkgqVNcRPzteMjJ7hzQ81t9K
         ye+mInFfLjR9dmjKFukqFkjNflXCjmihXZzSlR8IfifXvGhVELo/S3NGSM2ooHifEDpW
         OIdB92gJijp7zWETwhDhVxq0NZc0rPJH05orXxjovSVJUx9XKzQ2birk8crG8vwA8TfR
         MrXD+MdYUvJ73pf1wjZ0zZs4XPiueHEqF0tZg/h741b+v3AzqDAB5H5KdU1KTdkyf5bT
         GjgqVuEmOXGOXSY4upHQ/8uNfafPfk3NWfw8OF6hWsDBShNcZ+v1ecyBmdImhPp4vPn/
         eTIg==
X-Forwarded-Encrypted: i=1; AL+hErE9NWbD0uxF5UJ64oHAzsL8Y3UESOOM2umycAX43J6l/K915S+iZiUJNIPF7RzKJe4G6mSTOp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WrLjE4u9LBtj01EcOjPTccKiYJHSbW/Eps7tat/C6kt2dGRZi
	5oOtJ2/RrIfkxSJEHqvFBk5CTNOGVnOuxJhTjjhZ+JIOi/H53OpGUfGYLJz6mUS5F9iph6r5R1N
	hJrL58fMm91G3lo76gbimZNuCPw==
X-Received: from pfmu5.prod.google.com ([2002:aa7:8385:0:b0:8b5:8e39:9545])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:339a:b0:8a0:1dab:fd50 with SMTP id d2e1a72fcca58-8b66c4017demr326577b3a.20.1794101397087;
 Sat, 07 Nov 2026 17:29:57 -0800 (PST)
Date: Sun,  8 Nov 2026 10:29:48 +0900
In-Reply-To: <20261108012949.3943642-1-yuyanghuang@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108012949.3943642-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108012949.3943642-2-yuyanghuang@google.com>
Subject: [PATCH iproute2-next 1/2] uapi: update if_addr.h
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add IFA_F_GLOBAL, added in net-next by the series "rtnetlink: dump
link-layer multicast addresses". The next patch uses it.

Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 include/uapi/linux/if_addr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_addr.h b/include/uapi/linux/if_addr.h
index 5a28b958..aa30ef50 100644
--- a/include/uapi/linux/if_addr.h
+++ b/include/uapi/linux/if_addr.h
@@ -57,6 +57,7 @@ enum {
 #define IFA_F_NOPREFIXROUTE	0x200
 #define IFA_F_MCAUTOJOIN	0x400
 #define IFA_F_STABLE_PRIVACY	0x800
+#define IFA_F_GLOBAL		0x1000
 
 struct ifa_cacheinfo {
 	__u32	ifa_prefered;
-- 
2.56.0.455.g6c5a503b38-goog

