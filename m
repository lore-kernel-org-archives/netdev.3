Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E53B47C9;
	Wed,  2 Sep 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334370; cv=none; b=A5sd3aABvrlp9xfWTnNatIbJC8czEVxBnvF7vY5r7y2IOhBa+wDVw15gaRVEnAX9Yb4SAP9gheHvOFa3TT/555LoERFdLrUBcEEAOF0VMlSXdSlFY5OfpschJJ3L2Wq0mUzKdMXWjsQovyYeSM6UJUf5vt3SE/cl4vducJrGHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334370; c=relaxed/simple;
	bh=XzFWLvFoI2ufzAcmQVoJMF+62AkLlVv9jC+b2sPA3zg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZU/PupBh/BzGv+GTS+vbNuDNgS9l5am3vpliFadX7TEy+aAJROUXH0xg5eoGS3daPWo3to6q737792kqnwlvokfIaa9PSEiElwKPtnHDO/9CVtiDO6NCY4U5uZi05+Sje1g2+3rgsbcOVzKW+pwH9j2va5HnUEPXlnkSO2VxnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CH5mFo3i; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CH5mFo3i"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aEH27e4qJoaulruKpHqDw9BQiArVxK3xpf41NroGbMk=;
	b=CH5mFo3iUG6HGdKN9+wm+eOgkD65W7CFTRVv7XQ9qpZACfTLPy87FclLKB+HpSQyKrcc+Tros
	rMm+SGmN1T+U+gIddlh590bI8i6qjVHE3bLwTr4qbv/epBHSjcHJ6whoJmln62xE3r015K9uode
	Z371qYvqjXQoDfOKpr3GV64=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hZZ0x1bsPz1K96b;
	Wed,  2 Sep 2026 15:21:53 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 58AE440586;
	Wed,  2 Sep 2026 15:32:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Sep
 2026 15:32:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <nb@tipi-net.de>,
	<kuniyu@google.com>, <sdf@fomichev.me>, <liuhangbin@gmail.com>,
	<da-x@monatomic.org>, <jeff@garzik.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3 0/2] 8021q: publish vlan_devices_arrays entries with acquire/release
Date: Wed, 2 Sep 2026 15:33:32 +0800
Message-ID: <20260902073334.397685-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Hi all,

This series fixes a speculative lockless data race in the 8021q
VLAN receive fast-path, and publish vlan_devices_arrays entries
with acquire/release for better performance.

Changes in v3:
- Fix C=1 sparse warning as Jakub pointed out.
- Split out from following patch set as Kuniyuki suggested.

Link: https://lore.kernel.org/all/20260901024234.135119-1-ruanjinjie@huawei.com/

Jinjie Ruan (2):
  8021q: Fix data race when publishing vlan net_device pointers
  8021q: publish vlan_devices_arrays entries with acquire/release

 net/8021q/vlan.c |  8 +++-----
 net/8021q/vlan.h | 20 +++++++++-----------
 2 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.34.1

