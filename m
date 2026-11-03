Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715625;
	b=vHkoZpp1IkKd5QOXJGnJFgRMTQlbKWzGcMzHR3QO3BubndbpxO8A6vJvl6HAIEInKNO8
	 64oWg44c3s7ejUOPFN1K4FZlfjiMe3UhbEsAYLu+iK6PRofqylJ1jamz+PysV6jANK9yw
	 V6FUwkDMj3q5TIuSi4GurIbTP2ffPU8GJL/A1aKcInhVPf92VmLhFLbd5LjDgrht8tzn7
	 kgCQRFOAvkpPPJC5QM18WUNmZk11op7N8XeiOPTESCF+2QriuIZkIFEuT4nlFJQRtmGmQ
	 EiCsBdIH2x8sIZNEloPGYAGq1eSzBvXifpBOXADRODriKyrCgzY2lr2FWisCfBn0aZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tf9OEV/Ahr4YHVg7wN8vF8FRxaiZESEmUwzlBAU9ZvM=;
	b=wLDgjWvQdUCybrbWX2xxfrfrpAXFAcIRzWTCwMVDAjzijF54D1ksn1fT0tu16vsI4txk
	 KOh1gZIpHf753WBIao6T0Z68R3g2kvsN3K6HbLvIdfKCkRKdLAoSK+8NjQBFKrxnb4KMU
	 Xalp0ZEBoWJpuyiIaT6woIfPfi0i/ieq+I6+M2z86MzTePIovb64C+nS/528FVA90vtT9
	 /1+MmkWrBZGFn2qwq8RxUK565FJlR08M5yj/6dnDKwU7LqXhDz3fiZswlLTZDsFRDDKum
	 qPE0qlFBdLXYM5Bm1lMnAcn3nM8TOIrAHptHrblWEocUhqL/L5OMPIoiHEJUMM0i/+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4s8WHTc;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291D606A331
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2291D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4s8WHTc
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so38598a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793715624; x=1794320424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tf9OEV/Ahr4YHVg7wN8vF8FRxaiZESEmUwzlBAU9ZvM=;
        b=L4s8WHTcsgrYF10LK/9kkCf2UyzTTIq9bVtpbOM8uTSWFdw8kL0Z8v7rcpwijXLW+3
         i3Wl63F0h0ZREz2ahNXOKcheo0SDoeuMcpTJqyAPZCziSeA+uN++8el7m2ThBy7EYE7z
         lH3LdikJeFZiLqPIlQJ9OmAfCjOwUIJMmJcDmkHAMpqeNkhendrbIS/I3llbw8r9bacL
         TVyg6zQWm3+06ytVV3jXDAjQkBb1/P6YVaCksdBxmJ2zZcndAZW8JJu3wxST7C815o9r
         OJThB5NIO+DLax760KGNa/VN5JlIzr1ClZIGLtj169m045MWhf+vQPLapKbXJjuP6yFE
         kJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715624; x=1794320424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tf9OEV/Ahr4YHVg7wN8vF8FRxaiZESEmUwzlBAU9ZvM=;
        b=UM7uYUURhiW3B8IhqzUgaO0ACwHNGdnAR45eX15bELVsjIMmvHYYHjlHieKpUTFnhr
         6ZYW+wN5ABtiQFjfFMc2tAsBRp2UzUSpFnQzr41u64hgdMYstO8m2WEn1KWEsfh6ORd3
         VMT59c7wY44bec4dwe5/20Ok+hZ8twzVbClDXL6QGj4M9LnNp1Djm9ZbTYmpmjITU7kS
         V5astfK9qsx23zniaoj1wTgwLKf/LXquyIorPW9fBTlXIo1aNmZc2INqaS3cQO0BGqyk
         RoqL7zdGIC6bG8HqqZxVKWAe8RqcSBcURxaXuEYKePj1HCfqxAjwJl7l/WVq2cR5es/B
         mm6g==
X-Gm-Message-State: APuU4Z/HRDg1NGyaYoHUxzKQXk5jhZrmnK4LiPuttELo5udsOyZx7wyx
	QsEYCjCuuqCVP7++vwj+nqSMTJ2gZeP5xBFkU7G6a0fPQEtPXIvXBz9wWVBoLQ1wMDE=
X-Gm-Gg: AYBFou0RKIJ0RwXsAxnVzh/WsmOBgEaCMg6y3c6i6ePEeV+u2HTAN7ftlHECoC8UOhY
	d4ORvz539uJwThcb9/zQxiySKxn19vxtnj1CGq0dEo5VxooOnwu12EPsDS4Een94ihDyJq4uIfq
	biY7ulk1RozMtOOa6mhrYkQ5tYakCU3ydGCX/+AjfVlCPkOHcxBW/J/E/Dj1qufYNicxS7w/DAj
	YkBdBh+4hfzLXY7ws/cBnqE9y07ItWgZH2C6ltcGn10UjJOTnBWSgJZYgBJaWRzSHrMVL9/2fdp
	O2Q+z/5LAvLulSo6Te4DguhPcThQSj7f0MZg2MwWEqz/MnV1Z3kBji757M3IjwbJAuXEu49Wah3
	o5yCYXd+lgqjx3CIyYy0jS8ikRRYuXAlg1E4k8FZLduKTju+XiiKEwUjUCgqNhZky1NYJ2qhaP5
	RTkixzZdZumRwvift3EvsUWxpJmQV3hAuQIUumFRigt99vAg2UDuSHzmBor2IdeHdmMXsKuCmcc
	Tku8M+PrpZCDRy1VzLe2wnLSthW9VaJPzjCDVLWcXJRRF4dYawMRJ+SaLKlE44lzumvFc6iTiPq
	OjhvOG5/FqEHfuou0GP36+3oR7335/bpkp6uJSZNzw==
X-Received: by 2002:a17:90b:17ca:b0:3ad:818f:3db4 with SMTP id 98e67ed59e1d1-3ae8988225amr19140175a91.6.1793715624197;
        Tue, 03 Nov 2026 06:20:24 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm4536310a91.11.2026.11.03.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:20:23 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	horms@kernel.org,
	khc@pm.waw.pl,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH net-next v3 0/2] hdlc_cisco/hdlc_fr: shut down protocol timers on ->detach
Date: Tue,  3 Nov 2026 22:20:13 +0800
Message-Id: <20261103142015.1588144-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both cisco and fr arm a self-re-arming timer in ->start() but never shut
it down on the protocol-detach path: detach_hdlc_protocol() calls only
->detach() (never ->stop()) and then kfree()s hdlc->state, so
unregistering an up device leaves the timer armed on freed memory.  This
is the same defect class as CVE-2026-63803 ("hdlc_ppp: sync per-proto
timers before freeing hdlc state").

Each patch shuts the respective timer down with timer_shutdown_sync() and
moves timer_setup() to the attach ioctl (attach_hdlc_protocol() uses
kmalloc(), so the timer must be initialized exactly once at attach time).
Both bugs were found by static analysis and confirmed with a KASAN
reproducer (slab-use-after-free in the timer softirq after rmmod of an up
device).

---
v3: process-only repost, no code change; fix mail setup (previous relay
    rewrote Message-IDs, breaking threading and preventing the series
    from being assembled by the CI bots); add lore links below.
v2: https://lore.kernel.org/netdev/tencent_BA6DA4F17D2035F5DEEEA21B9578E2234307@qq.com/
  - retarget to net-next and drop Cc: stable per maintainer guidance;
    carry Simon's Reviewed-by; no code change.
v1: https://lore.kernel.org/netdev/tencent_83B7D10D4DBCC6118AB6F6B83A509FFA5C06@qq.com/

Chengyu Liu (2):
  hdlc_cisco: shut down the keepalive timer on ->detach
  hdlc_fr: shut down the LMI timer in fr_destroy()

 drivers/net/wan/hdlc_cisco.c | 10 +++++++++-
 drivers/net/wan/hdlc_fr.c    |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1
