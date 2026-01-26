Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF02BE053;
	Mon, 26 Jan 2026 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769399706; cv=none; b=gDsB3WnwOprCHK/42+i3pYOK4Y4eKT3JFiLE0V71rt8S6EfcDxuDmCXjJCv5PI50laLzTKxl0ahVeDwspCCHdzNGfh0/U/Xu17/nulPdni83bV3oOuwASq+0/q9ej8hX4N4TUrJMkgRxPMnH9DX7fbYY4jRtnN5t7nKNUHczbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769399706; c=relaxed/simple;
	bh=W82IWFtRj/1y4/x97gu7L3baDC7hNLAQ+ExjN7zODV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVzzgg59Q7m4vNH9XMgXj4h6Z1Z+SbopGKMI8TMQ2hiM+LZPdTnQFXi1gXNo4IiL+7/IrIH/CEhuUFNfow237Yv5wRS4QcMXhgvt6jLUqIcpeKaAl+slcCTVfWsDeqbSf92tHzxlqvTKLWeZyml8CFSXmV3vjM+jZ9x7GO1fEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6HiJM6+B; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6HiJM6+B; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6HiJM6+B";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6HiJM6+B"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UjhN52wNerqins45l5x2iyX7fBnvxt1Lrq+i7szdvDM=;
	b=6HiJM6+BUZ2Fm/JFW7fJ3RxGlNWNI0aY4hVrUlr3l8f3Q22Ls0B5jadEdjIYZeqm6poAWZwJX
	eV2VDCCntzh/2cU/E/Dkio9V5D4r8k9cFBcd9YNvsq7JlAoVgtqh9auzwKnIHZYMjROuuUkp+al
	WHZOm30mnnnqyKnD8eul8Sw=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dzvmn3y8xz1BFpT;
	Mon, 26 Jan 2026 11:54:33 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UjhN52wNerqins45l5x2iyX7fBnvxt1Lrq+i7szdvDM=;
	b=6HiJM6+BUZ2Fm/JFW7fJ3RxGlNWNI0aY4hVrUlr3l8f3Q22Ls0B5jadEdjIYZeqm6poAWZwJX
	eV2VDCCntzh/2cU/E/Dkio9V5D4r8k9cFBcd9YNvsq7JlAoVgtqh9auzwKnIHZYMjROuuUkp+al
	WHZOm30mnnnqyKnD8eul8Sw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dzvjD2LPbzLlSg;
	Mon, 26 Jan 2026 11:51:28 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F17840565;
	Mon, 26 Jan 2026 11:54:54 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Jan
 2026 11:54:53 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH v4 net 2/2] selftests: vlan: add test for turn on hw offload with reorder_hdr off
Date: Mon, 26 Jan 2026 12:04:26 +0800
Message-ID: <20260126040426.2570396-3-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260126040426.2570396-1-chenzhen126@huawei.com>
References: <20260126040426.2570396-1-chenzhen126@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500008.china.huawei.com (7.202.194.93)

If vlan dev was created with reorder_hdr off and hw offload both
off but up with hw offload on, it will trigger a skb_panic bug in
vlan_dev_hard_header().

Add a test to automatically catch re-occurrence of the issue.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chen Zhen <chenzhen126@huawei.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/vlan_hw_offload.sh  | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100755 tools/testing/selftests/net/vlan_hw_offload.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 45c4ea381bc3..3c9797d8dff7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -114,6 +114,7 @@ TEST_PROGS := \
 	veth.sh \
 	vlan_bridge_binding.sh \
 	vlan_hw_filter.sh \
+	vlan_hw_offload.sh \
 	vrf-xfrm-tests.sh \
 	vrf_route_leaking.sh \
 	vrf_strict_mode_test.sh \
diff --git a/tools/testing/selftests/net/vlan_hw_offload.sh b/tools/testing/selftests/net/vlan_hw_offload.sh
new file mode 100755
index 000000000000..ac7140539d95
--- /dev/null
+++ b/tools/testing/selftests/net/vlan_hw_offload.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2329
+
+setup() {
+	ip link add veth0 type veth peer name veth1
+	ip link set veth0 up
+	ip link set veth1 up
+}
+
+cleanup() {
+	ip link delete veth0 2>/dev/null
+}
+
+# turn on hw offload and set up vlan dev with reorder_hdr off
+test_vlan_hw_offload_toggle_crash() {
+	ethtool -K veth0 tx-vlan-hw-insert off
+	ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
+	ethtool -K veth0 tx-vlan-hw-insert on
+
+	# set up vlan dev and it will trigger ndisc
+	ip link set veth0.10 up
+	ip -6 route show dev veth0.10
+}
+
+trap cleanup EXIT
+
+setup
+test_vlan_hw_offload_toggle_crash
+
+exit 0
-- 
2.33.0

