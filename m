Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680520;
	b=b/E+37EfYkBHJkVh+aikQ11JePKieSBvorzCFZiGt8sFVhtek6S402iVuqVPSgKwR7Tt
	 2U7vRG1ElUbkPmo1CkVn6569DVYTj7u22mVqU2WIde7ewP+sSkqppZKNyUZ+CHP+Kv9hs
	 9j2Q2VWbTc340iSpUOL5FVVf5kqQM2W7EuR05TdDbNTLOzHx3kXzHnQFmeUjL6fAX5JkL
	 pIJFECbJzFQ225Ln2U1sUq4Ym2swOeM8LDg2BtSbNTXtdW94ADTqnUeW44Pj0xNb2Cltg
	 EyxRoGNuig3oRw0azn8LL9E5fz+5csKqdDtBoB/s4DMP8LYFVMhbUfl/LhnZpn2O2kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680520;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Cf99JJBQHA8reXbSZeA4i7nmGdCSdeC8pjhp03xP1tM=;
	b=c6CS3h/GHx0saxsRNVBZO5nbNcMt6AEotuvBrCgn/GuEfbV3G6od0E9XA2C/2qmtw0xY
	 mDVmARQykxuqU9qcu5tIZSU698v8p6E5iJ1FaoWGCDQ6PDaV1EMPNcjoaGPHq1+s/hFu0
	 xECM9+bBe2atTb1hANjDrsRwGB7ELGAr6aDRU7eF70B2hmI7WgrWSApqbmAJAHgYkqiA+
	 lB8G4CWlPe8tXmwGu54KE94BvQKhN8yKH9YQvGOJqx7f9DWIa/QQaFiT+DufU4Mc0LRYv
	 tslTHp50jumaPEbSG0P5BzBK3Yuml12NdvEuN4u6dFoRn2tkYNtkdI1P+CRVOdMLpYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=i5q9b8eS;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474EF60A3831;
	Thu, 22 Oct 2026 14:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474EF60A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=i5q9b8eS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Cf
	99JJBQHA8reXbSZeA4i7nmGdCSdeC8pjhp03xP1tM=; b=i5q9b8eS/78aa99uuB
	CULXrRmoRDKJQPh2oE1vH2IjkMyPMChbgb3iJOZXAunxA2c80rKmvOe44EXEQNDG
	3C96MXyY7CDnXgHy3vTOSAN4Uoc/2GpG/iX08xc6QTP9y8YKF3gJ38t/WVpvc7Cn
	NMoYseZ/9aSPrHlGiCApe/E+0=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn31ceItpqHPYSCA--.13546S2;
	Thu, 22 Oct 2026 22:47:59 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net/sched: DualPI2 memory accounting underflows after TBF peek
Date: Thu, 22 Oct 2026 14:47:58 +0000
Message-Id: <20261022144758.65248-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn31ceItpqHPYSCA--.13546S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1fKFW3AryUJF1UWFyUKFg_yoW8ZF13pF
	9ay3yakw1YgFs5JF4vkFWxXwnYg395C3y5Gas5Xr18ua1rGw18ArWxKayYvF1xZr4kXa4r
	ZFZF9a40vr4jkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07josjbUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0B-g7mraIh-dOgAA3r

Hello,

A TBF parent peeks a DualPI2 child packet, causing DualPI2 to subtract its truesize while parking it in gso_skb. Reducing the DualPI2 memory limit drains the parked skb and subtracts its truesize again, wrapping the u32 memory_used counter.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/6f3e3d3667401ad3325959e321928400/raw/c50aae5c021dee0b3ab97e76d260da585d1fde98/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/6f3e3d3667401ad3325959e321928400/raw/6b13332e308ed8ce37b28ea2d7c8fb50265a8b88/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/6f3e3d3667401ad3325959e321928400/raw/937e24e9b0dcfcd847a80e74ad2707f6b4781030/poc.c
auxiliary reproducer (init):
https://gist.githubusercontent.com/shaos26/6f3e3d3667401ad3325959e321928400/raw/17fb0deae08ba739b9e044cfd6c93be24eff2e6e/init

Build the tested kernel with the attached configuration and CONFIG_NET_SCH_DUALPI2 and CONFIG_NET_SCH_TBF enabled. Run poc.c as a static /init in the attached minimal initramfs inside disposable QEMU; the test creates a user/network namespace and reports the counter through rtnetlink.

Impact and prerequisites:
After the rejected/in-progress accounting state wraps, packets continue to fail with ENOBUFS even after restoring the original memory limit; replacing the qdisc is required. The test is reachable by a caller with CAP_NET_ADMIN in a user-created network namespace and is a namespace-local availability issue.

Validation: Two exact-revision fresh boots reproduced the same counter wrap and persistent enqueue failures; no-drain and close accounting controls passed.

Thanks,

shaos

