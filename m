Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98573D903C
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883239; cv=none; b=QB6oGH24PiI5pzjFB4ckB/kf5Xxo8H5Hhee5eLffegSTI4/AlKxY697puBTV2lsfp9tsPOBNZVqce4G8xk3Cpwk6fDi6P4g3H5Js/JZ5HSxJ1D+VsfpntMsFlovlS5Cs0DTiZDF28z+ahAUSUWrFn+jRDopgtOKVyyZw0cUddho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883239; c=relaxed/simple;
	bh=BThqNuIh906h9qHrYk6/9BqMfsUhq4NnZ96OsQcgZ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tq50sIIVaubAPwdlRZXF66/CFvCc25KPlTptYIg5LtSv4fviF3Ra7zsUt8U+IeAf2SztXveqNCQzrrItN2JLYJ88bdnYgcO3OfPXqY0bVaO7w5N2x+RXdjb75uElvvWWrW0uhrNHRa9j3FMsmZoia2l+OolIezZqU9Ym6+xQ2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeKU85HA; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeKU85HA"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-785692e5a3aso1188506137.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789883236; x=1790488036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZfKoYpft37d2jckJ24DjN8dBqnOEVyvyRjvBGZRWAc=;
        b=oeKU85HAXnLDXURhs7Guxp4c7sMHGeX5aQ2i0bmRPl95I6hf9OfWvAvBtHUZ7gVdzy
         okpQqga/E+8dgbIdCiocm/Q3nmNqC+bfSs5AZ/aw8gzl0lr6E6InA3qrFPP/6qLTUUvf
         aPZArnTLohuzUprHmJosAGtav3NT5lLqRd8jfOKgAn4xI5a4BO5Q4Y8BTcoYaWmD6dgB
         ZHf6IBBwfVaEDlJkPrb6tLy67oJLyC0v2Gr9y0Rk9ahpCryOWuvH8HTSZwL8xvRUcQEY
         zhWaYse//ZNd7O6KOdI7Dr04j45wIKvd6AM+wgD/N0FXUxir/AM1m0uSROL19iWYgkxv
         fdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789883236; x=1790488036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZfKoYpft37d2jckJ24DjN8dBqnOEVyvyRjvBGZRWAc=;
        b=LGIDNeoRrTN8SmgkFpOfX2SYwQRJ9lQJ9QHNw338zCmv5D1S++sDZea9YmaqJPiCT5
         QER1UA5e3CkOMeFIyfwirEjYc309eXiJjMJa8QINJt8lClrIDieyKizuM3Qv4Ii6OqhI
         uEdZBL5Z/rH1cP9AR39FVeYPjoK+tw70hZT8xfXt8ipJsiNgBiKUXjxTy6PJN4lad6xy
         MtkztW8IUhKef/m3FHFQJD5TQhH0IdMaGaF3k9KQZpiQiqqgOlsgV/MgyCPFND0thusI
         8qGi8GK+235JVkVa+qa8ZhNVhWcSXnmHmmZ+KMEg57fa3JYi6GZiqzdumaW/JvTXxV0E
         kXxg==
X-Forwarded-Encrypted: i=1; AKwUvBxDrh+BgSAjMa0irGx+c0QF5muZ4jAUQRwzk20mMMrhMbyirHOpLGQhVf25Wxkr9ZZzkfSaqQg=@vger.kernel.org
X-Gm-Message-State: AFuF++lewrVbhIUFu37LjjUZ8nRpQngM/Myl7FJAklWNNHNXNT6VjsQV
	bHAzwSE3Va0/K81SVG5tIZ8ayZ1BGrCcmtVtkF3vFsDsKivMMTPe9mKjoJQKNONo
X-Gm-Gg: AYBFou2ZSaYxnA5Aq1M2OsqNp2sO8DiR8GsyQMHHB2iCpHPXuLSbTyYfy9At7uwdNF9
	KQQ3mgSpYZQsh5eMsfeNsaJH5dibb985LfYvABo2vYlRTWef/31IbmQWWEvzp0CXO9p9UskSNPH
	uvIZF/sJH7m2IKvtAojIPZJg/ZrDV3H0S6CT2kzUj9WkvrZEgrFYJB0fBbbV2RUHExSMKwvhsgy
	6xi19+rXP9bQTZ9BFv/4LyravVg8qbnnM5pKI0WNG/p0oUTLScogboajXbi3cqaFVmQCx2MgZwf
	9QsmBpxyWc42OJ2ecVh28q++bGijNvqHPLQ9LbvbHzVVSyMdMDesMWV/Ow/y6knQwDIKNPXygvY
	73rC+8DtVRhf7KGD7vNP93qsFaQmbV4V8Ju8XRalN9GNhDWIZh3Lr0TAdhp7ogGQ56n4kHKOBFb
	AI4iKcbiDh+KnzYWsHh0JJuWfPmJgs/1P+oYfL89wpEq7dcnLxkWZWc2zaDvyIcLbmUWiocddvI
	w==
X-Received: by 2002:a05:6102:f85:b0:7a1:4799:33eb with SMTP id ada2fe7eead31-7a55a72b2ecmr3447638137.5.1789883236496;
        Sat, 19 Sep 2026 22:47:16 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6aa41dac0sm4521732137.2.2026.09.19.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 22:47:15 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 nf-next 0/3] ipvs: add per-service secure_tcp
Date: Sun, 20 Sep 2026 02:47:05 -0300
Message-ID: <20260920054708.988867-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPVS currently exposes secure_tcp as a per-netns sysctl. It switches the
TCP state machine to the hardened tcp_states_dos table.

These patches make it per-service: a virtual service can set
IP_VS_SVC_F_SECURE_TCP which is passed into IP_VS_CONN_F_SECURE_TCP at
connection creation. set_tcp_state() then selects tcp_states_dos for those
connections with IP_VS_CONN_F_SECURE_TCP set and keeps pd->tcp_state_table
(the netns default, including the nomem floor) otherwise.

  1. uapi: define the per-service secure_tcp flags and stamp the flag in
     ip_vs_bind_dest() (cache-bypass has no dest)
  2. honor it in the TCP state machine, resolving the stale FIXME
  3. kselftest contrasting a secure vs. a plain service

Changes in v2:
- Let IP_VS_SVC_F_SECURE_TCP be 0x0100, leaving 0x0040/0x0080 for the
  scheduler flags. Let IP_VS_CONN_F_SECURE_TCP be (1 << 17) and no longer
  in IP_VS_CONN_F_BACKUP_MASK.
- Set flag in ip_vs_bind_dest() instead of at every ip_vs_conn_new()
  call site.
- selftest: send probes with TTL=1 instead of an nft drop, and fix
  Sashiko comments.

Changes in v3:
- Merge patch 1/4 and 2/4
- Re-send patches (v2 dropped patches 3/4 and 4/4)

Changes in v4:
- selftest: check the return values of setsockopt(IP_HDRINCL), sendto()
  and mnl_socket_bind(), and fail do_add() when IPVS does not reply.
- selftest: fix the remaining Sashiko comments: check inet_pton(),
  initialize fam and the parsed addresses, and verify the flags attribute
  length before copying it.

Adriano Cordova (3):
  ipvs: add flags for per-service secure TCP state table
  ipvs: tcp: enable per-connection secure_tcp in state machine
  selftests: netfilter: ipvs: add per-service secure_tcp test

 include/uapi/linux/ip_vs.h                    |   2 +
 net/netfilter/ipvs/ip_vs_conn.c               |   4 +
 net/netfilter/ipvs/ip_vs_core.c               |   3 +
 net/netfilter/ipvs/ip_vs_proto_tcp.c          |  16 +-
 .../testing/selftests/net/netfilter/Makefile  |   6 +
 .../selftests/net/netfilter/gen_tcp_probe.c   | 158 ++++++++
 .../net/netfilter/ipvs_secure_tcp.sh          | 153 ++++++++
 .../net/netfilter/ipvs_secure_tcp_mln.c       | 337 ++++++++++++++++++
 8 files changed, 672 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/net/netfilter/gen_tcp_probe.c
 create mode 100755 tools/testing/selftests/net/netfilter/ipvs_secure_tcp.sh
 create mode 100644 tools/testing/selftests/net/netfilter/ipvs_secure_tcp_mln.c


base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.51.0

