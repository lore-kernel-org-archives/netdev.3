Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E523368B6
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176760; cv=none; b=Z/hLcOOpuVBgrlKchBGLdEGqls8NSjGgNM5iTb+r9QdbjNIyKMhhl49adp9a9Iga0F1de3c+yWW9HNzRmoPr25imOyPufHRoq5jqgiS4A+ppbRBRTOaC6ghic2WBJ/ic6qdFv/EnVcVEVUjGb8myn2H99mnEIfpC70sshN69nJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176760; c=relaxed/simple;
	bh=iO5IsBdVcKSJKd6NiDoXmZ5UkiJqIiE+p+VNxy8J4R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PENoZmCREJ23LxDhU6GYKDsNuT0AvqWGnD9BX0p04NuE8mZID0AAuS5bQjbOxA2hezrpY7NuOF95bBUl3gb8LKNL7oz2l2u7q3XYVl4pJZwYL9Dc0hP+7ovIPii7RvDdAurhyfhEJKUuypjai0Qe2OaR0ih1zB3E2qHRXhivkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd8xc5/c; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd8xc5/c"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c7c25d9f6fso1374591e0c.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789176758; x=1789781558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvfD/NIMhAY/sAhVFEMBC5cGXIs+97HZdpNLEZY0qTk=;
        b=Xd8xc5/cMoVy5cXn0lyTLg6FbvW3KammyCP2h7zw7rH+6Hsa8boFJtHmzWAdJusOqH
         qj6Ry3VEYCYFcA8Udv6Rs1JqimYGLf51n0yxG/iLgN/iMooU0E7MkhJbgZEmn5Bcbmhl
         hH9r18LjCq6W+9UIKzweaDqO4U8MwnrzKaDRnAXxIFxTIcfEJfWZbwOaqUK8xsFkeHdD
         GTPZTDvF48q/8jac7e5g07s3357wSdRLcLki3ymQZgd5NPxr8C5XoQSfKVwIlIcrIWex
         FzHTam4HB/7jLBF+HKmiulHhyHIQu5WYgaNrKcLUTGAurk6XR0QMVDU6G1D1JpytEBaP
         iF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176758; x=1789781558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvfD/NIMhAY/sAhVFEMBC5cGXIs+97HZdpNLEZY0qTk=;
        b=ov5d7/XjBifSRo+qRRuprg68D1qVSZ08+2AbbnINfd8ZhbDzhAEaQ+TpEWxTOTgqjo
         LzIwIVGPKcs3rl8FVlOw3lo9F9tjtKABjdKok8949a30C7JJTMVW+FQY4yoyxlDLuoiP
         R/QqirMpGncig5p/UYK4xOtA11EXOfEgXftf1giRdV/4XYJn756jioIkGPkPiQ1e0B4q
         c/oGf/rx0w6q3c7ESZKDWZlA3WePAxMpFuUEqfh7umaNhimMpLx4O5J0aH34K/B3mQdq
         EitRHwGs1rtAbOvjKq4eK7WenWL+TVJn5IQ/o6hblMjI71/z6jb+1b6CRYcpY2rqyLlS
         Qgtg==
X-Forwarded-Encrypted: i=1; AKwUvBxnGTHzgqBUHcXBOmFp/bwqbjz3zfsVpnLPmFAxzfe4usEOS+gdAHhIwAtbRn663vwdSia8dQI=@vger.kernel.org
X-Gm-Message-State: AFuF++lSuqpmhfj53fqDUl/QadwbkGv7Kd2Yq6U7xPkxtGrBTfy6Vv2X
	PnJ32x2XzCdmbfAQPOWOeYIw7evfZfEEk9O9aW0DkY1+hYurjA3sbKgZ
X-Gm-Gg: AYBFou0LvjvAwDRXpCKXekdGkk+ABycp08WYxrZopaFdxrxeG+3uCQXgRp8qoPCFBd3
	M5Wj51PNaMaAxfYIaV9iT6IQTyXVyQ4p7aDM/A/guS0M0iof+OSgs0T2bAp0HK8iKrE/xYvI2LD
	PWH+i5mkQdwN8OF9eLQNgPAsQtc5vR55p1zAoSi41Tz0gRPtecH5i7TI7Xo+EPek9DVYB176EMF
	oPO1T3PTSVDbze2b9XtC5HeMAnli7Dlco4tCC2wG9jA8YdPWmg9usDgXO168F98VIX5jBKLH8jN
	7gkAtT8xGuCYlhNWB6rE/SmeY/9+z8BenFezdb24OLOEYaYkKsVt/8LiaTPPO8y9SiqQfXiFDkU
	jlB1zdFEP7rrDwr3piqlm0ScdFlruceZVo4fGrswlnAAEIpLjSwVNam79DvoVPzManGX3mYPHHg
	MEYJKNzb0uKch5uY3kNcTCyiI+cz/7s9XXn8w1Ud5OnPYDX/5bipOt8CHEc6/0lg+8tWqvgxQtg
	wg=
X-Received: by 2002:a05:6122:1c8e:b0:5c7:9445:f468 with SMTP id 71dfb90a1353d-5c8462bff30mr10202112e0c.6.1789176757830;
        Fri, 11 Sep 2026 18:32:37 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm4738262e0c.15.2026.09.11.18.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:32:37 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 0/4] ipvs: add per-service secure_tcp
Date: Fri, 11 Sep 2026 22:32:12 -0300
Message-ID: <20260912013216.588300-1-adrianox@gmail.com>
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

The flag is part of BACKUP_MASK, so it is preserved on sync to backups.

  1. uapi: define the per-service secure_tcp flags
  2. carry the flag on every connection-creation path (scheduler,
     persistence, RS-initiated, cache-bypass) and on FTP data channels
  3. honor it in the TCP state machine, resolving the stale FIXME
  4. kselftest contrasting a secure vs. a plain service.

Not sure about patch 4... could be dropped or absorbed into ipvs.sh

Adriano Cordova (4):
  ipvs: add flags for per-service secure TCP state table
  ipvs: stamp per-service secure_tcp on new connections
  ipvs: tcp: enable per-connection secure_tcp in state machine
  selftests: netfilter: ipvs: add per-service secure_tcp test

 include/uapi/linux/ip_vs.h                    |   5 +-
 net/netfilter/ipvs/ip_vs_core.c               |  23 +-
 net/netfilter/ipvs/ip_vs_ftp.c                |   8 +-
 net/netfilter/ipvs/ip_vs_proto_tcp.c          |  16 +-
 .../testing/selftests/net/netfilter/Makefile  |   6 +
 .../selftests/net/netfilter/gen_tcp_probe.c   | 127 +++++++
 .../net/netfilter/ipvs_secure_tcp.sh          | 158 +++++++++
 .../net/netfilter/ipvs_secure_tcp_mln.c       | 310 ++++++++++++++++++
 8 files changed, 638 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/net/netfilter/gen_tcp_probe.c
 create mode 100755 tools/testing/selftests/net/netfilter/ipvs_secure_tcp.sh
 create mode 100644 tools/testing/selftests/net/netfilter/ipvs_secure_tcp_mln.c

-- 
2.51.0

