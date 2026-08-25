Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB73242B8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635449; cv=none; b=DQ9Qo7aXa0P4i8PUO3i1itJ3HUuBT3Y4YOxYvhl6Wo6w636AHEWJoumL8Q5ZoM+t8Ro8DFTvm87uy6DtQBaW0D0/+HGmnmHjmVIFoRuSod6PsaKPzGAfgK5LGRSGKLybmRIgM3Hwv7+HDSrIHz1nB+o+9imiqxFwvD9q9j7U17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635449; c=relaxed/simple;
	bh=vFMdJUTX48W+PQPCib0IiR4x6GCAZloV0OXbgVN5BYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlmAQTeGB1DLvZ/jGKj/HOYgOgmG+4gQoVz6cfw8YUmjfOxQdZM9IOIwxAlZzIXOXWCWXduJGrtqEmyW94/2S6XtMoR6m9ToJWAq3XqyDVoJwVZI/Ix80KFp1RTQ/o2O4pcNKqsbCzKjp1IjPc0iTwAbeIoszg/Q+mYw9Jlqy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjCLG8I+; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjCLG8I+"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ea0b7d137so38638167b3.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 22:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787635447; x=1788240247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2mJP8TqsrYYGzuYn0yP6OFVeMmAR8CqjeqnEz91itww=;
        b=NjCLG8I+7hDGy+ln72orAnOk5l8BvvG6D7hFiawvNZlA59lwjx+B40APc1ceLxQewS
         wPqaQg3Jwbqx5ynnqW54OHD22PcJvKMXs4IPIJf5u0H7qocBTsLy0PbVh9f8Nmm0p1NL
         ww7VOZDeFfcFnXBqLAEm0XcaNBOei2jH38e3Gm87H2sucZAsXayarRRY+Vl/8dU9FD8+
         7HExjCVJ66gHGdIE7E9zhNPNhVNeXNLiv0ocnLp79Y/WPQHwUBb1GmhwCQtuvG16OZZL
         2tcmJqmwdxSP/VNPszslAtGytxBoqmQkfLpmUBIkwazGJtJ9rDaRRVFYVFXqEd2nNtoW
         6h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787635447; x=1788240247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2mJP8TqsrYYGzuYn0yP6OFVeMmAR8CqjeqnEz91itww=;
        b=sUmqk1EP0m6WcMJoYrDBAJaMclP9edPIQQ2M7JrXybnnJGWQFQ8tBmSUQIcbSTOmGa
         p8+fPWUAb8i+O49kLEqRSYbWbsvNVGuUPEOkn6S21I7lpSxigWET5kwlrxztZwa85R+c
         kFji0BKaOcpgdJbC1g4w7oqDkGzyQniMw1eM6M6PGtarEfF24ZRv8x4fbUvjs5HGd2lb
         zntAT7NyKAG8RCVma1M+lFyHa2PfPeR5/ECsZKOnTCCayMIj16ZSQsYbxhhRJBSNZRYp
         sd7ug85HF+qs/uKm6/SYrjfNl6NvkyGtpAGFLrl/6I6gTqCcH2UeA/hWhVP+QWjByzhi
         O/9g==
X-Forwarded-Encrypted: i=1; AHgh+RosXW8036qI7GKxoAad7NDJuXAHLS4bbojGJnGuBYghCe+QeJ9CoEK/I9kuzZfg9vAFf7Zs1/c=@vger.kernel.org
X-Gm-Message-State: AFuF++maCCKeHMRHRp6Th3jm3Tnx0IKCeqoKb4wnDET9m2sc5ldf+aD4
	fd80MLVeGiacG41GLPjo6bEECK0X2/pazx7PBHzJUOwKNlUMuid250s7
X-Gm-Gg: AR+sD125dKqjC4WetrMIWsyw47xiSo/ymdNfofvgwkewy9eji4WZPX0DE5lhmqKirLH
	L2s7VHGMtOeA21LtIopsWfZMBBoWVFoA6gd6l3yW5LvNmRVwkFhPaSICHNXKvHnFTvt08xgHOHl
	B06E30SIUjsYZHCnJX4miEgHsNPK/qA6gtugtsf3ou8/09Ujd5dmlUkHqKdqMTyONN+dOllG6LR
	vGxxNgeZ1g6eA7VdtqZ+nodWh7HHBJ8olY8i6ly2Zz97BJvq9Rk21nIxYwBz1GcA6dOvtyJPWqq
	9Ro8ddIdHX8cQ1xpy+sN9IpNxwC3NWr5d7NFZtPaZ/0IIpJ0Tneb26O6VwgKDigcms/bXMJ8stg
	hjVNDxbzOmvMvPqB8esJi9vOaeZZ8WfrRFcyvcur09oKtafPZbY9XiPwEsHBhMiQC+27fha/fJ8
	qMpU5HAMz3izmbQJACYM9UpUkb8pcB1cdaLys77Plpc8tDNnma4w713uyhHKSo5+FH4Kg=
X-Received: by 2002:a05:690c:398:b0:815:bc6a:2e48 with SMTP id 00721157ae682-84c97c883fcmr102058037b3.14.1787635446827;
        Mon, 24 Aug 2026 22:24:06 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-851e1419e0bsm21767747b3.26.2026.08.24.22.24.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 22:24:06 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: pablo@netfilter.org,
	laforge@gnumonks.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2 0/2] gtp: fix sk_created race conditions
Date: Tue, 25 Aug 2026 01:24:02 -0400
Message-ID: <20260825052404.45665-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two races exist around the sk_created flag in the GTP driver: an
initialization ordering issue where sk_created is published before the
socket pointers are assigned, and a teardown lifetime issue where
concurrent readers can still use the sockets after they are freed. They
are split into separate patches because they require fundamentally
different fixes -- memory barriers for ordering vs synchronize_net() and
RTNL for lifetime.

Changes since v1 [1]:
- Use smp_store_release()/smp_load_acquire() for proper memory ordering
  as suggested by Simon Horman.
- Add patch 2/2 to fix teardown races in gtp_encap_disable(): reorder
  to clear sk_created first, add synchronize_net() for softirq paths,
  and hold RTNL in gtp_genl_send_echo_req() for the process-context
  path that synchronize_net() cannot protect.

Patch 1/2 fixes the initialization ordering race.
Patch 2/2 fixes the teardown lifetime races (softirq + genl).

[1] https://lore.kernel.org/netdev/20260816035205.57966-1-blbllhy@gmail.com/

Cen Zhang (Microsoft) (2):
  gtp: fix sk_created publication race in gtp_create_sockets()
  gtp: fix use-after-free during GTP device teardown

 drivers/net/gtp.c | 70 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)


base-commit: b70b7b71561f2be1183b6046964d950c2b203bfc
-- 
2.55.0
