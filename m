Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86341DDFF
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241697; cv=none; b=iXB3S1FQkzJxjVSuSsG8ep5KsBSC0maGexol5tcLiMAd5tqHPr8qmsvQOtzRIbJBFUqLL/OrjRan4quU/ayZM9H08DztOCzdVbnKM4ubXJ/4jOFycXhzBNY5Haw/6du8TphlW6gk7HBBYF/NCzu7vdcdcMT+FXryZXUcFfxqY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241697; c=relaxed/simple;
	bh=EFiOMCmz0kquomDbFRaCIqOKHR+0cTGiBsZKDB9gpQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5YN4YLnj4Ocf/37sKaQaGgME22L1HD31cXlmn7anXimRwukd6ja+AuKHqTAaEEx49iUHcjQ8GsP4JGbihewSD07UhM9o1uLglEy67k5Dgd8RZ0cDfwbCfnGNFPXMVL18yzpOAUG6kzEj7iKe6E5+mmqBmgul9wEz1imztWmxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TurXa2zb; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TurXa2zb"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-351348eb579so619599eec.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791241695; x=1791846495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKfOMaGlV1wrIDpVywRMIIFaPysOcSIKEiVc//uuW0g=;
        b=TurXa2zbcMUh3JJhn8RbJntk8sA+0TGOpVzl376z/r0XNGXiG4l4YU8rEMlG1IXneC
         mO5fXmAWnKOXczZpQqrZo51rlzLQyXXcjjLN4Ey4tKgDVd9n5a3FK43CNhkTsUXuFpkN
         6G4v/xqkbxZq+w9jLHvxp35Z3+MmZnGAPiXLlUFU3Fj3YrCiKnMyEV96rVWpmCltTuQS
         w+agJ3CWrMI74QJ1JQcg7amGPDhF8whzMxElne9cWM8aAXyQDc9sJntWCOyslNhAUf+V
         l0jtyQkxKH+SK7wX3uKejlC/L8CSGm5yVRfGOY181w4hRGdCpOjyIIW/KxhusdLFUh43
         dx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791241695; x=1791846495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKfOMaGlV1wrIDpVywRMIIFaPysOcSIKEiVc//uuW0g=;
        b=ggrmevrnHGhaqA6O98o28wwBXXHzYNq+EEh2pPiLTfPSS9WVABxjxb4VYKwiFc0Ccs
         Q7mRZqd5i4Y6cSHakPYzYvmIKUA55HOqUqOA7vGpYl2EmXRy7DgE+yG87Li3TgzcMOZo
         VQz887pEeNhQbIgMzj7vtUzgNZIkfm6HTNobLA9/6l7jgEla5N/TX/axuIxR7lKR3l9j
         gV9uV2U1vQpPfOG30JJFWvRxvYqIRGJJjyjfxCk8NdLUhyT3wnat8K2wN0MRQNggWuZ9
         ejYiobT1ZzztoiMUCPOkSWkBMaxEHPGU/GnhferLk0LYwb9QQWMoA/dbU84Oke7+nwVV
         G7Uw==
X-Forwarded-Encrypted: i=1; AKwUvBz/UkhqKIf2C/ShSQmwg2l58LdGWVwP06IkK2+MXAQHxSRpktj5jWDzSlkWaherNgQCzR2Q8xU=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ5mPX+nzmmDcRfuef7+OWI5MvPRoDG1Y44HAQo7ErT/YLTPgG
	zXfOVEB404FUKYZ2aLcRjyn800Ocy+FPBiWNWwl1fsROUZqHxbs4yBUq
X-Gm-Gg: AYBFou0ta42r0Yv1wcBfsiJuIe/uqbpLz9RlRKOmrcSkOYeyzVpx66wJ4hgaRsIGWfM
	Ota2aAnt9CfPwJOYmHgFueuoAp3xi4UhX/HQM9nAA5G+5koUcUPnotVM66cbZ5Q96k4oqlrs2SB
	o2S3a3mWc2OdYD6t/wM1I7/osHfIU02OXQSTZl3sZZhbdmlAj4PAVKHq/vAoD3US7wPmkEwV4XB
	/SGIe9QCIws8cyK2qBitwuacKICQgTCcwRwPgioRbe4yQW15ktok69DKO2atJPoL/WO4/7rmowU
	jYfNapzgb12/lAzKkHZypEJavCNC1jrKAeWXPYJzjy2DeeG17ETFDJrhbMmq+KNcXScMFSJB1U9
	yOQ/KlpwXy782YzczEidJHFPb9/MovXUcl6ORX6FARDhU8rSIB4Qh5qp5JLCbhNRZyNnVo9DdUl
	UnFJza4iWYmj2EoJUpzuDrcWbrXpM4F51LsiDvQVjDdSAWQ77FOgispGlcOtDOYYE=
X-Received: by 2002:a05:693c:20d4:10b0:33e:61ab:8309 with SMTP id 5a478bee46e88-351452fb0dcmr1105737eec.23.1791241694720;
        Mon, 05 Oct 2026 16:08:14 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146a5b004sm1859493eec.18.2026.10.05.16.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 16:08:14 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 nf-next 0/3] ipvs: add per-service secure_tcp
Date: Mon,  5 Oct 2026 20:08:05 -0300
Message-ID: <20261005230808.148478-1-adrianox@gmail.com>
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
  2. honor it in the TCP state machine, resolving the stale FIXME, and
     document the new default/opt-in split
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

Changes in v5:
- Document secure_tcp as the netns-wide default and the new per-service
  IP_VS_SVC_F_SECURE_TCP opt-in.
- selftest: reword the changelog to "a bare SYN followed by a bare ACK".
- selftest: skip when the ip_vs or ip_vs_rr module is unavailable.
- selftest: check the probe exit status so that a probe which dies after
  the SYN cannot leave the secure-side SYN_RECV assertion passing.

Changes in v6:
- Rebase onto nf-next.

Adriano Cordova (3):
  ipvs: add flags for per-service secure TCP state table
  ipvs: tcp: enable per-connection secure_tcp in state machine
  selftests: netfilter: ipvs: add per-service secure_tcp test

 Documentation/networking/ipvs-sysctl.rst      |   4 +
 include/uapi/linux/ip_vs.h                    |   2 +
 net/netfilter/ipvs/ip_vs_conn.c               |   4 +
 net/netfilter/ipvs/ip_vs_core.c               |   3 +
 net/netfilter/ipvs/ip_vs_proto_tcp.c          |  16 +-
 .../testing/selftests/net/netfilter/Makefile  |   6 +
 .../selftests/net/netfilter/gen_tcp_probe.c   | 158 ++++++++
 .../net/netfilter/ipvs_secure_tcp.sh          | 169 +++++++++
 .../net/netfilter/ipvs_secure_tcp_mln.c       | 337 ++++++++++++++++++
 9 files changed, 692 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/net/netfilter/gen_tcp_probe.c
 create mode 100755 tools/testing/selftests/net/netfilter/ipvs_secure_tcp.sh
 create mode 100644 tools/testing/selftests/net/netfilter/ipvs_secure_tcp_mln.c


base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
-- 
2.51.0

