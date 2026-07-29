Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FF3859C2
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355591; cv=none; b=lsxJnDYm3R2sTuq6hNnMMLvMYbSQb3Qc0gCiv7p1AKogFP/besJ0WTnzMRRHNm5V+ELlwtXcpbNL0XDLYsbbdxSbb5rIW6XTqtyZnZb5T6m4pDOMTaRCOf4VGlcVSWoB0/IhuWGkbtPOipkqIo581YhsrF+7ren5zl77sBAa9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355591; c=relaxed/simple;
	bh=dG45OnmD43NxMtoQR9SZXt+eqy31w3JEb+bs4VM6Xpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3KPiQn3V2JHV0YRd2u1Qd85WGbYXJ3KdIserpymY0vdtKUQyJU/IuPNMJkR4/NYF772PMDRNB14X3DZfN7vez74ACFU7Bit/s2IrF9YKBOGlVEuQLQOLHsI5bvVjZBf2UciFk4M6eYykbe21n1dtVv0ytuSPmGICFgKO13cf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=bHxOFvT1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="bHxOFvT1"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1349819a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785355589; x=1785960389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iHGtLp07o0VGOaOz8CCi0gETDAT40jWuHhoiywSeGuk=;
        b=bHxOFvT1N1FA3y1hVdgI9TvinF9Zjm20aFn1DsIoDxzhbLfGiq2q/Vc90bubTFkE0r
         Vtqp79fYk4hKzL8HyI/LWl6Gn+YbnOcXlznxWtbYaXqCa0NYXofHzhrn/Sb61SK3IQVu
         nq3cNtUqAnQOBefn7QnIprmcPTCugiq1ZoofoUCjZOURuN+wUS3FlRHVPS1jYMAmeXKz
         T1NXMYUaknUlKrucB5Q3KewAZWw4JMMWXr9jk9d548cLptgrJDFqWSWnQUSDD8k9Pl0s
         4z85fHX/tjgrguRnKEhZ0jQrcG0aDfqsh5g37tUyQgCPJdoDN5r86zIsmnCAMYk0QpiN
         jxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785355589; x=1785960389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHGtLp07o0VGOaOz8CCi0gETDAT40jWuHhoiywSeGuk=;
        b=AnY8/ycueFe01cV7inrT1cUPlCxOwnPIUq2eWKH83F49u9xKgwCsDwXyBNvcNlPCyj
         BV/paIWVDbt/VI+yUnXd2YPt73REonRQwiRQGWRPl8K62EDP3Zo4v+7TZUjyJ8ozvv7W
         JCqgG2oHs6THppaT3OSKDRT19M1+4bo0/kFOXMZM3LEZPnggwxtpneUucJOLK3N+NtCa
         XK5EzopktOh5mVlDaQZnyJhnkNY3D9yWoh3+seMPDvxVeSDW39/jRUM1Wt9SiqKb/mUW
         3xFfSF2/nE30fYtTkhgq8INOhURdWQ/Win6mZDmWJlCOtyHpVoxkit6XAIP5nNaQqxX+
         P62w==
X-Forwarded-Encrypted: i=1; AHgh+RpdoUJwxW1dLwDWCykFy470485jI6I5O0KZMa5GO2Lwjz3uD1MmUiK/n5WgSnpnyh5dD5T3Lww=@vger.kernel.org
X-Gm-Message-State: AOJu0YynIrubUpVwL+J2QWz8Ge9pprnsiQzvnXzXg5gy691D3giDW6md
	2fOG0U9sKm9DG2c2v8FZ1KYI2MzOxWVhrGrxBDkRCW7o1fi9FLZkVhLU6U/A63NxEA==
X-Gm-Gg: AR+sD13Wo2XmknC/q7RUwyVioPQPBD4RLj3oee1L+CONpDD/QCPWYFB5zZZLuwiirjZ
	2TDjn69LLqjuhPSz6sbP0jg9nc36u8POgupHs6sfG5/qOfOTknVtb+nnotBtErmUXYFJ5vxIcQx
	Us4cp9JeZsqloF8eVqM5XcwxxaWZ2vpISphnAD5rgCQXPGK4Y2hwhXOu560BZDzpFOhVxFlPDXK
	0K3ztEUZTCoG/SMrMgV4oa+jwMhvdPH13l0+RdbCN4ssLlnPYFNQlzrjw74QxgmTa5HSu3XYnhn
	RVE9Am6yPg60sW+0YtvjAvo7wNtT6MPbsTogCIR5CXseiF4P2Zknxiq0WQrPujdeZf8M9gz2UWU
	wV+W/UfHqk91+fuDttktA1Ci1yMEumcNka/zWbCnfjAgGZLBvDXyPInnPlQGymSoZVTOWEaibtY
	rFzPHsDpFV9CqO2/LfDNB1FvTPfk2uatDMje+gASxVjfkWJdCFMsu5q2ApHu7Wv/4hXQ==
X-Received: by 2002:a17:90b:5483:b0:38e:b400:a854 with SMTP id 98e67ed59e1d1-38f9939d1c0mr229731a91.37.1785355588811;
        Wed, 29 Jul 2026 13:06:28 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72745b1bsm11802209c88.14.2026.07.29.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:06:28 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Thomas Karlsson <thomas.karlsson@paneda.se>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	doruk@0sec.ai
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net v2] macvlan: require init-userns CAP_NET_ADMIN to raise bc_queue_len
Date: Wed, 29 Jul 2026 20:06:21 +0000
Message-ID: <20260729200621.2521588-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IFLA_MACVLAN_BC_QUEUE_LEN accepts any u32 and becomes
port->bc_queue_len_used, the only bound on port->bc_queue. rtnetlink checks
CAP_NET_ADMIN against the target netns only, so a user who unshares a
user+net namespace, creates a veth and puts a macvlan on it can set the
backlog to 0xffffffff and flood broadcast frames until the host dies:

  Out of memory: Killed process 141 (su) UID:0
  Kernel panic - not syncing: System is deadlocked on memory
  Call Trace:
   vpanic (kernel/panic.c:650)
   panic (kernel/panic.c:787)
   out_of_memory (mm/oom_kill.c:1166)
   __alloc_frozen_pages_noprof (mm/page_alloc.c:4914)
   alloc_pages_mpol (mm/mempolicy.c:2490)
   folio_alloc_noprof (mm/mempolicy.c:2591)
   filemap_fault (mm/filemap.c:3565)

A fixed upper bound does not work. Deployments carrying 600-800 real-time
audio streams run bc_queue_len=100000, and no constant serves both cases:
the queue counts skbs, not bytes, and the frame size is attacker-chosen too
(up to ETH_MAX_MTU on a veth the caller creates).

Gate the elevated range on CAP_NET_ADMIN in the initial user namespace
instead. A backlog of that size is a host-wide tuning decision, and an
unprivileged owner of a namespace it created itself should not be able to
make it; privileged configurations keep working unchanged..

Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
Reported-by: AutonomousCodeSecurity@microsoft.com
Link: https://lore.kernel.org/r/20260706212556.3199234-1-xmei5@asu.edu
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/macvlan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836b..fc95654abca8 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1335,6 +1335,15 @@ static int macvlan_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
+	if (data[IFLA_MACVLAN_BC_QUEUE_LEN] &&
+	    nla_get_u32(data[IFLA_MACVLAN_BC_QUEUE_LEN]) >
+			MACVLAN_DEFAULT_BC_QUEUE_LEN &&
+	    !capable(CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_MACVLAN_BC_QUEUE_LEN],
+				    "bc_queue_len above the default requires CAP_NET_ADMIN in the initial user namespace");
+		return -EPERM;
+	}
+
 	if (data[IFLA_MACVLAN_FLAGS] &&
 	    nla_get_u16(data[IFLA_MACVLAN_FLAGS]) & ~(MACVLAN_FLAG_NOPROMISC |
 						      MACVLAN_FLAG_NODST))
-- 
2.43.0

