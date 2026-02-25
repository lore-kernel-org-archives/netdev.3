Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337D3242D8;
	Wed, 25 Feb 2026 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013519; cv=none; b=VoqrxirxMYwM6PgRqUy7WX2z+9yICBPdoWGMzvbQGXot4ZNnunz9OIFpHN54kZIJ1sK3izNMtYn58Oq4HtzpwcO12HidA/0cz7HRJYhDRh6Q5ug/Ye8A8XzZwhrjfP7ZleHFA6lims0g2tu5l0mny9J3s7pJkn6UODXE7sK/UoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013519; c=relaxed/simple;
	bh=xBH62Z1LMF0U5LLL/D1+BAGVaRAy1YDVP5FPbMvG+XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+zS2Qp9ZPreDRrWJgefSNBAfEpVeqi1PVwxULWTtrc+H640+yjvk/NtwoRTCsfljTSAn+sAlzq05C2yRC4GJP6X+VndSU83dpbF83t9jxXw8GXQr1oG2AReY/S3mhordbOPQqn/P7bTA1gETKuKENZ3sGt9/HK0kex5AeEO7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2F26F48796;
	Wed, 25 Feb 2026 10:58:28 +0100 (CET)
From: Gabriel Goller <g.goller@proxmox.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] docs: net: document neigh gc_interval sysctl
Date: Wed, 25 Feb 2026 10:58:10 +0100
Message-ID: <20260225095822.44050-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1772013491051

Add entry for the neigh/default/gc_interval sysctl. This sysctl is
unused since kernel v2.6.8.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 Documentation/networking/ip-sysctl.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index d1eeb5323af0..265158534cda 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -202,6 +202,13 @@ neigh/default/gc_thresh3 - INTEGER
 
 	Default: 1024
 
+neigh/default/gc_interval - INTEGER
+	Specifies how often the garbage collector for neighbor entries
+	should run. This value applies to the entire table, not
+	individual entries. Unused since kernel v2.6.8.
+
+	Default: 30 seconds
+
 neigh/default/gc_stale_time - INTEGER
 	Determines how long a neighbor entry can remain unused before it is
 	considered stale and eligible for garbage collection. Entries that have
-- 
2.47.3


