Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46664C957B
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731829; cv=none; b=p5MsAPmOJ39hGfXk0ZbT1TaQoDxCACPfaEr9ZnwxnndxaMrJS1Zk1jUZ47tbMths2AkxFEhlmks4w5ZdZw5iRUhR/aw/45v8+DiyQfoCcduwKuqnD8pY32Q+teNJSKCSrOyzRldwPHk5P46koJxnBwzrVTUaL8bKvweA8FYkqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731829; c=relaxed/simple;
	bh=O0OEtypMq54rxogZfM3UcR62WCFrWh4lapIYJp+uHnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQBtPXGJuYK/eop0y59HsbmWADDfS4LjqcXyVT1Kc9K4wgm7At131FYqJ1DJkEyKmC5e8k5M/XbEmyY/u/N9sFE1Y6fuJuMmYPho11e71h/k0PpGX3+6q0BuokCEdeM41Ir2qkEPiaTEJbrK09gimyinM3mQL64cqLliBeVb8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOsiKaA+; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOsiKaA+"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c5so535748b3a.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731827; x=1790336627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1EVpGe5SDF/ZJpxR+ovxzDRHCXm4vVTGo/7vHZ+L1Y=;
        b=rOsiKaA+rBEZwd5JMDFanQ5FkGbbcfs3IMyJjjnqhlMEiH6K78An1iSF3PdDjLLLhx
         sAmRN2auaiLGm/TRBnVeNIUA8/dpVODzi7W1DVRlYp/sPrev9eojnWBiwWjmCcYxN3I7
         qWpyBbVIXWHSC/6WHbHMkyoIzQ4jV6BZCfg/CgGpXlBeqQWDg/ayt8VfonO57731qXKN
         NjXgT/qFxlvm9abfv5OYSx50QtzxiPpDB/jbZ0BvKwpAkH2G/Y0v42wnsMHcR8L1zBAw
         uJ4Hm8vkHRHNBs3EH56f0gQ6AD2zyi9o91qfHtcCqWL12bZp8fOXn6oPSx973zX31T1N
         pqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731827; x=1790336627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J1EVpGe5SDF/ZJpxR+ovxzDRHCXm4vVTGo/7vHZ+L1Y=;
        b=nqsUXpG50N8ne4Jz82U8YDcqGrMgoCHUw1edjdjbqtydVQw3HZCVPYSIBIfUwTgaz2
         higoiMRskMhw1X4mqm1MbDJsa00rVu8/hXasdDHD/zKIJPV39L6z5uuQzzxsfj7TgsLk
         AdM+kyMgPJZdx/ZNH4nIJ00Noq1kGvgcvZU/aempwgYWwk/ngjQv9mYFOXLqv+z3rIdE
         7Asei/3+UYSuPFVJvRFVyXlRt2Xkd7YnlGGs1SVIUser9SLwLB4AmgfSYFhmZDqCm52a
         EprYvVDY8LwPmU6pJbcK04IGyonG0nXWpQRXPf1c1eQ+vN2Bytqt/wzib9ismbyhlTg9
         3JrA==
X-Forwarded-Encrypted: i=1; AKwUvBz49Q4SKYcKv1J0cZEjfA74d3rtYRb8zGtgtO5jm7S9l0l93DpBce855gEPlplOGDO/nlichpg=@vger.kernel.org
X-Gm-Message-State: AFuF++k54kw8Nf+gvbU5SSycgNKB0eJBpRt7DHEEJHijQNBxi7Es1bk7
	iJBBBvvXoa8j0STeI9ZN5Xl3edvhv9YJgkLK4ym7oEGMFjh9VAqfSdtu+K5BjARqyW/Q4g==
X-Gm-Gg: AYBFou02YKSC9fHBmG9BmsCb69bni4GlO27v0NdTj9WxlJmbSa/oRb3qR+rfFZ7pjKO
	bpUfdGPuYYuLjGMFrvgj8kb/jFRbNzIj8bNMUhS8BR0o73W6/Xqw432Ra0JmY0nbbSpeZbcvbKy
	qaEF9MQGqTnt3V4a4SnQhGAtJ11aX0DLYmh58E7hKXKq6Dmt2S/7j/RSP/HIT3zHDnqY/AWID95
	eFOZSNhzgyEqdbd3Pom1N69Igs+vEG0C3+JBXjU0cVJye5zZAV+LsKDeawbn5l0l905qLzscIC5
	2xVLZK8CjrrMfwRJQqfuKt3PQj1SN62n24xUQB1ivm7UNn4mG6Ipv7KICTbTXi26tHTm/pZKj5H
	cklCqoml+88eU5+C7MIcBksQwMO8pxw4VjXfUIHk8xtcYlHUAikz/atvcFvva2RJE8UL86ttd0p
	QK/Wf0DmIq1+CDyd5BCHlnKNXK1/oQ0rnuooKyEahYLaA3xG4EJLv6wHJAgoNm7FUoILWHRiPly
	Ao6Oj8KdYk=
X-Received: by 2002:a05:6a20:3d07:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-3dd8c48ee7amr5158956637.25.1789731827040;
        Fri, 18 Sep 2026 04:43:47 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c284ac724sm4794739eec.2.2026.09.18.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:43:46 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] net: netdev-genl: add missing uns-admin-perm flag to BIND_TX operation
Date: Fri, 18 Sep 2026 19:43:29 +0800
Message-ID: <20260918114329.3659849-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918114329.3659849-1-ndaugoing@gmail.com>
References: <20260918114329.3659849-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NETDEV_CMD_BIND_RX operation correctly carries GENL_UNS_ADMIN_PERM
(uns-admin-perm in the YAML spec), requiring CAP_NET_ADMIN within the
caller's network namespace before a process may bind a DMA-BUF to a net
device's RX queues.

The companion NETDEV_CMD_BIND_TX operation for netmem TX support was
merged without any permission flag in both the YAML specification
(Documentation/netlink/specs/netdev.yaml) and the generated C code
(net/core/netdev-genl-gen.c).  As a result, any unprivileged local
process can invoke BIND_TX to bind an arbitrary DMA-BUF file descriptor
to the TX path of a netmem-TX-capable device, bypassing the access
control that protects the equivalent RX operation.

Fix by adding the uns-admin-perm flag to the bind-tx entry in the YAML
spec and the corresponding GENL_UNS_ADMIN_PERM flag to the generated
ops table, making BIND_TX consistent with BIND_RX.

Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 Documentation/netlink/specs/netdev.yaml | 1 +
 net/core/netdev-genl-gen.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 3e3f03bd5c29..3e38ffc39219 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -851,6 +851,7 @@ operations:
       name: bind-tx
       doc: Bind dmabuf to netdev for TX
       attribute-set: dmabuf
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index f83790341eae..e243fba64312 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -241,7 +241,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.doit		= netdev_nl_bind_tx_doit,
 		.policy		= netdev_bind_tx_nl_policy,
 		.maxattr	= NETDEV_A_DMABUF_FD,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NETDEV_CMD_QUEUE_CREATE,
-- 
2.53.0

