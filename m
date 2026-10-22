Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680506;
	b=fktJmkFQjXcVrLpV/3Dd1KxOA96wkhBwUosnHR17cc6u5SNyOmTKTVlQGoiyYgI3sAqg
	 Dsujbn7oX6PPRzQuXiAAPukTvTP0En1c+dFvO4afZ52ZqZiRkw3Qx7TtpSH7CK4p4uuB8
	 yM3B7jC3rP4APTEDYDXm8reF1tArig1/hfWfexfS3oGKmL+fkQMXjXfO7k6+AjwKQ90Bj
	 ySbf9KJYQS10HzxMOI3Btj6ZthgyQhrnucSE7PTNAerUqnnFk43nbMY+3seQGvR4Nwf1d
	 NrJP72++oebe9LeOXV0R/AN7xqJSau/wxawqYrkWymDL9oKYGmTqDY7O+LmFCJ9rLYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680506;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=fMe5vGbjlqstvJN2Ysj6tX7IwLJJrZLn3UmsYfquXgI=;
	b=yApEPhGd0ymURYKYLumGVQw8wBfdNMgKSBMLRQNN7sAowd/9zQC/lUKlT6hU2BkpU8LF
	 +OfChoJueTRCFMAdzqo+M3e0UMTSaXyVqaEq2NvqAikGly8hEt7OvBPXeOxvUiYrKBxbM
	 e/kiBY+jOy1Hg1RSson54Qpsc6KfPMgbwOTeivWS6vLzpVs9fpV9IfY0MXPF7JDSUR+Dh
	 E6ZR+mMJoG3eHPwNJSnDPM3EnjHakkn7kIvtU7pktgxMpMWBmyrFej9oCNzm2h7VmzS2T
	 KRqt4ikQUMFZVXkEVZwoRw8OINZcEz6yt01HxfKt9xOXkVH9NilT8D9r0oaX5DSfh3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ox0C94J4;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CA606A32D;
	Thu, 22 Oct 2026 14:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 242CA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ox0C94J4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fM
	e5vGbjlqstvJN2Ysj6tX7IwLJJrZLn3UmsYfquXgI=; b=Ox0C94J45ELoXyzkPN
	a+xXGq7lIF1AEHGK8ZegI2FxHy0jFYIKOALEUl0aUdKV4BRkMmzwZDuTRSWei/Yt
	puxP7NrB+gDxpYi4BP6DVbakDgAr4h5s1G3DL70tmWyvPTHpHLxaE5jBWj4OCsKA
	IHw+2JZOfkECbkUEVbrL4emRU=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v9MYItpqDA3wBg--.30951S2;
	Thu, 22 Oct 2026 22:47:53 +0800 (CST)
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
Subject: [BUG] net/sched: cls_u32 accepts skip_sw without hardware offload
Date: Thu, 22 Oct 2026 14:47:52 +0000
Message-Id: <20261022144752.64744-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3v9MYItpqDA3wBg--.30951S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry7uw17tF1xZw1fWrWkCrg_yoW8Kr1xpa
	9YkFWYva1qvan5J3WvkFWUXa1jg3y3Ja1UX3WDJF48Crsxuw12yrWfKa45Ca13Zrykua4S
	yr1Fg3Z7Xws8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joYL9UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8hnf7WraIhk2IAAA3E

Hello,

A software-only cls_u32 key-node filter is added with skip_sw and action drop. u32_change() passes the internal request flags instead of the parsed userflags to the key-node offload helper, so the filter is accepted, marked skip_sw not_in_hw, and skipped by software classification.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/52214e44c4d45823a935cbd396412102/raw/aa356e9f13d5e6d7c721e69b35db0dbde2b97a38/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/52214e44c4d45823a935cbd396412102/raw/08cfe6b272327f21ad917ee22a487862bd57e280/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/52214e44c4d45823a935cbd396412102/raw/8087f854d32060878b4c9a50c4a80d357bd5c5ae/poc-init.sh
auxiliary reproducer (run-qemu.sh):
https://gist.githubusercontent.com/shaos26/52214e44c4d45823a935cbd396412102/raw/369242a1cc359378a8e841cb4373d447fc372ef2/run-qemu.sh
auxiliary reproducer (rebuild-initramfs.sh):
https://gist.githubusercontent.com/shaos26/52214e44c4d45823a935cbd396412102/raw/dfd743e0125beaef6d76fc1d7ed9ee2de67b6471/rebuild-initramfs.sh

Build the tested kernel with the attached configuration, then recreate the supplied minimal initramfs or use a test system with iproute2 tc. poc-init.sh runs the ordinary drop control, the skip_sw positive and a hash-node close control; run-qemu.sh is the archived guest launcher.

Impact and prerequisites:
A filter the administrator intended to require hardware offload is silently inactive, and matching traffic passes. The user must already hold CAP_NET_ADMIN in the namespace; this is a configuration/policy correctness bug, not a demonstrated boundary bypass against a different principal.

Validation: Two fresh exact-revision boots showed the skip_sw filter accepted and ping succeeding while the ordinary drop control blocked it. A two-line patched control rejected the filter with EOPNOTSUPP.

Thanks,

shaos

