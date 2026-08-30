Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C43B47FF
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099826; cv=none; b=FRmsu9nEltCpZp5oXoQj8+CHUjJLIprSRB5xGWrzL9yHHTv9gsUECz7ihkr6FZwr7AieGTrtKkN/j8vgyMVRZ1MNH7K5Gl/ZDBtYndq4Tq60hb2hGqZJtKMArYwuGrV4igBSbHlak0Jq2Qs+YrXECwRj8Axp247C5RD7smU+dEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099826; c=relaxed/simple;
	bh=HVgrVRMO7hdj4ZofAhaHvZH9GKzE4HhfjdNOoA7T6/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iextyyGGjRuVa1x3UCGckJmyit4aOkB/dUgdLxLe0Xo3nyMYiNUARCoHcEiF9VGDnMFqHutwYESzXml8PXWSfD1AkdzRy7vLDdCHq4CtOaUHTzkdU/ePvaNx+3Bh8nqOYyMs3AUk+cTf9o79pYLvU915J1BXGO4RP+BeHpwf9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+JMPBBs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+JMPBBs"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso28167715e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788099817; x=1788704617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yj3FqpfMv9JvpBfseNgoXI8EpSo95CrF0zbP2aqZ22g=;
        b=S+JMPBBsLqW2Cqsi6nB75abVAZ5weqGOfups8fqNyuSfMvAfSOeGz9g4GDw9z3jpgS
         z7x3KWgLCoCqYsaR4TPQB0LlSnvtO+q232dbRmY9gKX9JZLzV1z1Z3/X3Al/ynVhsh2i
         WlMo4NAquQZ87+Bm3HxHoAYZCEJbaF7WwAaa952QKqRGoz55ryY7IJl8vnvxhPTwALOA
         +iKWVBHvHhtG0l4BAk1f48VU0QEu4NqZHjELryEGBiF9d4GYhwpvTNadO+R9+SPZK3DQ
         cJVnkPSC3dCFEiRp41MqDIcZYBSuepx9sIKxwyKS2h2vuIvyXRRzR0SV1GsJaQMJqyGB
         nrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788099817; x=1788704617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yj3FqpfMv9JvpBfseNgoXI8EpSo95CrF0zbP2aqZ22g=;
        b=jZgNjShcd2W7JxacA2qt0gSPbFHm27CBO4M4ljoMn/MPaGf2hoZKn56tuYotYav40A
         dHi1kAXCZ9Mb4672XzfrF0y7g6a/Ua75kmaaGguEphNrLrLl/wTLHgcb9vyIXno9hkWb
         2OAPzPusdeulNPTQ+pG1ebmu2LkhbV6smwRfOq72jPWb4i9dOPKH9X7VnbT674vJu5OK
         QyzLop5PhroEvUGNddOVleIVrBELyrB2NiHRx7Tp4pIHKiBSwzYrvK19cm3VeSynwl/2
         K4rEBVxYm7/3IueHzQvWRSreo7ksWhi3+TY4mFZPutGcYhOCBTiGGSHts55JKKWo432q
         dJQg==
X-Forwarded-Encrypted: i=1; AHgh+RpdmJFySYRKfDhUbSoc14zgPdaUYslYCfpMDHAFe9IVX5sj6PehHp9ytDrLumHPwLluacivziE=@vger.kernel.org
X-Gm-Message-State: AFuF++l6IfrVf2ySwzxuLXQjpqWktGiA+TWywhX6UIlR4mT+WrksN0ul
	VtNLbUe7efsyDTzESeIpfxgyKjvwYs3Hzj3feM9r0UkAWWi3VF11zhA=
X-Gm-Gg: AR+sD13JgHVqG27WKajBp57GbiFLkcKbR6kQJmc1HA5RaPojxZEZkB2w4LWuAv6cBe4
	VhsUUODzSHTm/ArLZ2KeAGmnRSFuuiy6YUchJqA+SF/awSnbUU+9kb5SoCUUt6MTFbnVr/9HIVw
	7l3YSGL6FHxMUMmJivJqVNkSSy0Up7tBlr7jvQ/ojRRIihhu5MKKvGgqVj8ZpQvIPY8xqRcnpBX
	0OTx40q8PTeseC5ZkloIF+cNlPhFyCTVXs/wpju2H2Roa+Q41LaU+OwXdH2vNwUXBqs2uvuEnLf
	hSvW89/8gmhkJKuU4c0Ah/hU1F2y7qWHnm36BZ77AcTFfQX7uYMd8Z+2HUbFYK6GDFUy5xkVtQB
	coeN1X2EfDs8ElOn9ceyQe/NaVFYXnIeT5jIGg0RgYubqdfL/bh9thHqnHUny0VKwNZnK7fOzmN
	yy2RnN7SxIzklK00wrDhuatzCSYCAYlA==
X-Received: by 2002:a05:600c:858e:b0:49c:d331:98bf with SMTP id 5b1f17b1804b1-49cd331993dmr52035595e9.8.1788099816574;
        Sun, 30 Aug 2026 07:23:36 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2072csm14255480f8f.23.2026.08.30.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 07:23:35 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] net: devmem: add missing permission check for bind-tx
Date: Sun, 30 Aug 2026 14:23:33 +0000
Message-ID: <20260830142333.1741155-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The bind-tx netlink command (NETDEV_CMD_BIND_TX) was introduced in commit
8802087d20c0 ("net: devmem: TCP tx netlink api") without any permission
flags in the netlink spec. As a result, the generated genl code does not
enforce any capability check, allowing unprivileged users to bind
DMA-BUFs to network devices that support TX netmem.

In contrast, the bind-rx command (NETDEV_CMD_BIND_RX) correctly requires
GENL_UNS_ADMIN_PERM (CAP_NET_ADMIN in the namespace's owning user
namespace). Both operations perform the same class of privileged DMA-BUF
binding, and bind-tx should require the same level of authorization.

Add the uns-admin-perm flag to the bind-tx command in the netlink spec
and update the generated C code to enforce CAP_NET_ADMIN.

Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 Documentation/netlink/specs/netdev.yaml | 1 +
 net/core/netdev-genl-gen.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 5f143da7458cf..6c374aca3d276 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -832,6 +832,7 @@ operations:
       name: bind-tx
       doc: Bind dmabuf to netdev for TX
       attribute-set: dmabuf
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index d18c89b5a6c75..07d87445eb22a 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -234,7 +234,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.doit		= netdev_nl_bind_tx_doit,
 		.policy		= netdev_bind_tx_nl_policy,
 		.maxattr	= NETDEV_A_DMABUF_FD,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NETDEV_CMD_QUEUE_CREATE,
-- 
2.47.3

