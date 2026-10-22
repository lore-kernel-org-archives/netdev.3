Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680502;
	b=WshhdZMW+uR7X/nM89UkX2UtBBBKbOGmcJx3pQGGIKc/tDcH5MXDo3jt4n8dtmCwHVg7
	 maP/E8PTw6+N6oQCdkXTvVhN3ZSO9a+gcHgb0uJrg1GQK0oxbqyOtlZwr8wcMZqGjMsA0
	 9Sq7q4s5xO55sBxaJ6gMnAd3kmeBiYV7shGvnA31FG6k6NVBNG6uDInTb42HXFm9xIP/K
	 7+Pas+IW6z4mIZWJfb4Y4rWXbsVB+Bva0RtNRuJzMmbjytnJuTBm3DO1ztAZfVQQrTWSW
	 sDWjKvhct1CnSkn75FUcOKO1FTNWctin/G7QA19tCXyjABFxjIakef6jn4E8mh0d6xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680502;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=JIZAZ3c9LS1qnten8xy0SvIuFnFh5L4naIL9e+hozVQ=;
	b=a1ApZsiLFKfRv+eI3nPIsZHiExRPpk7r3U3OWVT07CkDzbaN+1WEC4f8wENpfp6usASf
	 LRiMRrYPG5m6ES8SAi809NT6xG/4IrS4339CM3tluEqiFe8Fr3S3hC17J4n7rxbd6iWcX
	 7j4A+CQ5MtZRNbtHNE4PWuNpQFjRk4s/pDK3hpoAD0/edjLGUz2ZlR0oic4Zqu6a3qqIi
	 /Wsa3BtGg9aNiNoDLnJRFWBzcRZjJJNRb6iuItfgEs0bDBzrDPPltnMQtTizoU0h57amp
	 Z/5K4Lb7jK0vU0kQXWSnyisccG3EEVeZ05fWussHRw3ShoiQNF0UZTTiJSAiJ5oAhrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lU5rHfNN;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FD606A320;
	Thu, 22 Oct 2026 14:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 650FD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lU5rHfNN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JI
	ZAZ3c9LS1qnten8xy0SvIuFnFh5L4naIL9e+hozVQ=; b=lU5rHfNNguWBgrWZSy
	RzyZB3atWdAlF2oRwBZEd3jSEJjNVnrKFMd6GCDHIg576GD0gTo9kdTz1FlyMIJY
	GOWdu9TwdArApZ8E0Bo+ph8c9k8D6qEO57jUOIk6JlMljTKJ43FfR640p+ldhqkq
	iHK15P9CZjvq8/A57R3YUvQa4=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXP14FItpqmG_qBg--.11453S2;
	Thu, 22 Oct 2026 22:47:33 +0800 (CST)
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
Subject: [BUG] net/sched: act_gate cycle time can wrap hrtimer expiry to zero
Date: Thu, 22 Oct 2026 14:47:32 +0000
Message-Id: <20261022144732.61188-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wDXP14FItpqmG_qBg--.11453S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryxXrWkuF17XF48GFWkCrg_yoW8AF18pF
	WvvFWYy3Wqkw1DWFn3KFWxX3WIgwn7Jr45JFn8Jay8Zan0kwn2kF4Sy34YvFn3Zr95CFWF
	vanYga97XFWUuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5rcfUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwXa6GraIgXJlQAA3z

Hello,

An RTM_NEWACTION request installs act_gate with base_time=1, cycle_time=UINT64_MAX and one valid entry. The unchecked cycle arithmetic wraps the absolute timer deadline to zero; the hrtimer callback keeps restarting immediately and the add request never returns.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/5393c0a25cccdd0b182a72de6d245c78/raw/3498a27c8537da1604402fd68c433e47de80f0dd/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/5393c0a25cccdd0b182a72de6d245c78/raw/e1458ab0ee43d1aa31991c1e3435cf9fee7635f4/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/5393c0a25cccdd0b182a72de6d245c78/raw/9cf01ec7c86d32377ec34a6fb0e6b4b214a5e931/poc.c

Build the tested kernel with the attached configuration and boot it in a disposable QEMU VM with softlockup reporting enabled. Compile poc.c statically and run as a process with initial-namespace CAP_NET_ADMIN. Do not run on a production system because the positive intentionally stalls a CPU.

Impact and prerequisites:
The watchdog reports a soft lockup and can panic the machine when softlockup_panic is enabled. This reproduction requires CAP_NET_ADMIN in the initial user namespace; it is a privileged denial of service, not an unprivileged escalation.

Validation: Two fresh positive boots reproduced the lockup. Near-maximum-cycle and patched-validation controls completed normally.

Thanks,

shaos

