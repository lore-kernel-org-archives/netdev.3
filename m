Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516683AC0D9
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512090; cv=none; b=IRplES2an2CU712O8MOSUaamPdjKfVe1AuJwLLg9kq0oLKhDf1Z7XkilPoBXGLObdV9Xn8hpP+Q9wHDCuIpG1wmguYB4OMZY7zzAUwgO6HdcmlsRtTbuDrN58ouIqa87pmJHV8tkrTHa1QlrXEACzKeJV7bL61u5RIfbo34/hCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512090; c=relaxed/simple;
	bh=HXRJLUmYpVXaPYu3xm4e2KWCtmr+oTkErwLQssltxUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mv1PjGxjYTf+GWIa+rDoSquVwvA5vj7MjZMhu7WIf3XVxGrH0ip7iuKbkYLfgZDcvD3RVsICWmzkPHR/SgDrU2HNX8RtUlkMTVFMNUPLxZBSRcBzwSl456PlXbJujX5Xnx6NrSBSHWUFx4ZuSdkqw/AT4qblRnM+r0F3+5F0OE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxVTWmOC; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxVTWmOC"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7bd056863so114437e0c.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789512088; x=1790116888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7tWlVXda5b86jyOaJH/zkj7mUpxWfUU7DwT43zc3LkY=;
        b=nxVTWmOCCz8OV2PvOIr9MJfGemyXJ78EeQ0UkcsyKhfv0ZxtNqSS8gpABlmqIqCRsh
         cvGGDuXrCxUc3dYq5VRef8KQ83WLsuZkRL9fmEZ5gf+GONgFKY8up5OzSjzvd8u4OmPk
         9P6rWuod1RGoY6qJCdf7DQIxUGLYC7uQ7/Ldq7jSk0YS2aGjpexUx7aVryNdBpDosukC
         62ecAF8JZtZJzDNVyVEloJBk3fNeqXrsyT9I0HmD96vSvGNRmlFdrNznCI5XmzcY15sa
         ljNGi7pTmemBhdLy66samHVtnJu4DySFGRAZi4DVBLLqB6eyh3NhNqnfGFT+amYx0Den
         Kvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512088; x=1790116888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tWlVXda5b86jyOaJH/zkj7mUpxWfUU7DwT43zc3LkY=;
        b=Aw7ZoaRia7efTB6w4RLS/5G1I8uLioaItKX36RtsB3jtDa9gY61C7fZ/at0CqEbDGa
         LLeHAtTGsi9gBU+eBcB3AYnzd6wiOmJVNyymQe5UoN1oOA/ro4+pvuWRHd5OoMbExkxD
         kCL5p1EkaWeFrdRpzlHu+PJ3t1UzJP0UXNT6PP2uLQRGeYzi+WFUErNUqx39LUi2eVoy
         FE1O1zozZPqyNm2xdQmpARGo/zqdtOKswj+AGBHMdq20j4962H69LaZO+uhc65qekOiZ
         VEbiLZe76hTXPtEmqRsu+IeFTp+kL7U+M7JNUnjG/vh4IxhKAb1JJ025NPgSKHDWl07+
         kGFg==
X-Forwarded-Encrypted: i=1; AKwUvBz6YRLuCFGqM6blhS0XVquCJIjtwoG0ocP04a8rJ9oAqffwhgZmLhj4OqcsRAGYZc8oSuxN4js=@vger.kernel.org
X-Gm-Message-State: AFuF++nzbF8+PuhhkldMFbWcsd5e8TcZe6Z/rTwLhHRRosHU1zL8NWL0
	6laYm06ucwh7bsizZ0jzybQVI4uiTH2oe252UaKUhqcr9gFV7kC+Wt42
X-Gm-Gg: AYBFou1bdmquHCTpvf7LeYI58/s4YkYr60rArJqNLe2VmSOFoZy7PSoeYQiofnCig7i
	gvlwCcTuSnSFRqrlpZFF/t1PN8jKAjC/ubaM/n978AwqbvzVsS8I7H8oaX3DkX25vhLCcBFAS5W
	psbVfe86RnQzbXfgAhPdlI2tz8pqXtkKEwplPa69HmYsk/LPVon7jrFRfPej3NGows1Eq96T7fi
	muBvJKjPId9Z+Mkfe65y/TeCmroe/VKHsU+f6VdRK/C1WwVNh7shEyIRkkkRn9lu293m+7e6ilS
	ovAAZ6drojLDc9j5em523f7bZtoAWCg8CMdw7fKwlB5ADpeuK86PpPJ6TwJD/pRluzvI9BNIw+4
	ojJwgfBWHKFEEgkfDAoFnw34tyblhC1PrzanRWiOmPIm+SUOIU0sNTZOCXBy+WXjZHdKdwCetnF
	ykNQyQzxOY1Dze8D0L3EZqMmtTEtD7DjsCdD3K0OehZ1RGASPHfJYj971bllHUFZ0=
X-Received: by 2002:a05:6122:8b10:b0:5c7:f1ba:aa12 with SMTP id 71dfb90a1353d-5c99aea978cmr111500e0c.4.1789512088068;
        Tue, 15 Sep 2026 15:41:28 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9988e5f27sm974975e0c.1.2026.09.15.15.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:41:27 -0700 (PDT)
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
Subject: [PATCH v2 0/4] ipvs: add per-service secure_tcp
Date: Tue, 15 Sep 2026 19:41:00 -0300
Message-ID: <20260915224104.639985-1-adrianox@gmail.com>
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

  1. uapi: define the per-service secure_tcp flags
  2. stamp the flag in ip_vs_bind_dest() (cache-bypass has no dest)
  3. honor it in the TCP state machine, resolving the stale FIXME
  4. kselftest contrasting a secure vs. a plain service

Changes in v2:
- Let IP_VS_SVC_F_SECURE_TCP be 0x0100, leaving 0x0040/0x0080 for the
  scheduler flags. Let IP_VS_CONN_F_SECURE_TCP be (1 << 17) and no longer
  in IP_VS_CONN_F_BACKUP_MASK.
- Set flag in ip_vs_bind_dest() instead of at every ip_vs_conn_new()
  call site.
- selftest: send probes with TTL=1 instead of an nft drop, and fix
  Sashiko comments.

Not sure about patch 4... could be dropped or absorbed into ipvs.sh

Adriano Cordova (4):
  ipvs: add flags for per-service secure TCP state table
  ipvs: stamp per-service secure_tcp on connections
  ipvs: tcp: enable per-connection secure_tcp in state machine
  selftests: netfilter: ipvs: add per-service secure_tcp test

 include/uapi/linux/ip_vs.h                    |   2 +
 net/netfilter/ipvs/ip_vs_conn.c               |   4 +
 net/netfilter/ipvs/ip_vs_core.c               |   3 +
 net/netfilter/ipvs/ip_vs_proto_tcp.c          |  16 +-
 .../testing/selftests/net/netfilter/Makefile  |   6 +
 .../selftests/net/netfilter/gen_tcp_probe.c   | 141 ++++++++
 .../net/netfilter/ipvs_secure_tcp.sh          | 153 +++++++++
 .../net/netfilter/ipvs_secure_tcp_mln.c       | 323 ++++++++++++++++++
 8 files changed, 641 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/net/netfilter/gen_tcp_probe.c
 create mode 100755 tools/testing/selftests/net/netfilter/ipvs_secure_tcp.sh
 create mode 100644 tools/testing/selftests/net/netfilter/ipvs_secure_tcp_mln.c

-- 
2.51.0

