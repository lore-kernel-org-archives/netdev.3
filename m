Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680522;
	b=hhi8wOrn/QRgOsAFCFlKy4I1gVdEMAkmyu/hc3S9X7r1/nJQJNvwFuu0RhK0Qm+mCrsI
	 AHRKpLDLOyLtjwnmoZzFhSuwbE0fjfMLCuHnwwPvPNCTzi3JL5QBjw/OW5HO/03n4knwR
	 Upjrnl06SdK/Vbqa+/dyBVofOcDIhqD+ztW8+y+sF5Aami7LfyVgmqOaDxmZT7GyKo0Wz
	 o2tfc/d2Oj5kqfU0L0T4HPFAiMfJuUhQ8D9JcFTtnOJ1GHHWWujoEwEh57+l08SAPihvP
	 GQsM+Hx+mRzs2wNTwb80v0sCrKXOkUKGB2ppwtT8dJc4gjZMKQtR1vmVgJrHXjMKxPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680522;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=iliA7o8xLw3ABHh/DiDgbgcFqyXSbme0Bi2vn45Ht6U=;
	b=xfQorPL67qzFqwfRgmms3Osgp63FCCSH4U3+mQWBRig0DfWTUbFuAaX6j1InBqJvkg2r
	 0Zp7frIgRziPrsAnEdYoHyFPeSX2o2OXYqFh/dAASjQoV0Nj5yaWCS9tAkdzx2knUOEyB
	 tyfX+1RQC5EeTOA+NZyb2hY+t9mkk27bVxOzX4R9HZIhNY8SQpeEm5TxSb68n0eCkZ8sf
	 wrXZokud5diBEdvnyNdSHaqVsy1ZRNymxrUjcAljI0pO6KZQFdMoVdPO32Jx+3WBVswSE
	 uWG6tb/UXEQOjmBZN8JpSHtbAZyxeuGaZgaigXVDglQCMmP8YXkByk3nDSptqylt4ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="QAcx/jEb";
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8F60A4ACC;
	Thu, 22 Oct 2026 14:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE8F60A4ACC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QAcx/jEb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=il
	iA7o8xLw3ABHh/DiDgbgcFqyXSbme0Bi2vn45Ht6U=; b=QAcx/jEb4TvU2toM08
	GJDt9zmwxFynf48SulfiuGnYP2aapjiaZ6Fq7zSUwgeZ78C8LWJbmWP8enzj08RQ
	aaZhTxplXeZ5fsYCfEBumqZm7QEHbu7vdrB75IvvrujNBH0FBXo4HgTH8gJFjhTq
	hxM6fdagKHG7/ozNDAC2B/x8w=
Received: from shaos.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHOX4iItpq1Zq0BQ--.45216S2;
	Thu, 22 Oct 2026 22:48:02 +0800 (CST)
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
Subject: [BUG] net/sched: failed fq change can still update packet limits
Date: Thu, 22 Oct 2026 14:48:02 +0000
Message-Id: <20261022144802.65536-1-shawnq1@163.com>
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
X-CM-TRANSID:PygvCgAHOX4iItpq1Zq0BQ--.45216S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15Gr4UXFW8GF18Wry7trb_yoW8Ar4fp3
	yvvFW5t3WDGF15Ga1kKFWku3W3WrZ3AFs8GFn8Gw1UZFn8Kr1UCr1Ik3y7AF9xCrykGa48
	ZF4vgan7WF4ruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo7KsUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwLh72raIiLLdQAA3N

Hello,

An RTM_NEWQDISC request for an existing fq qdisc sets valid PLIMIT=5555 and FLOW_PLIMIT=6666 together with an invalid BUCKETS_LOG=100. The operation returns -EINVAL after fq_change() has already committed both limits.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/990ab5ed350cb27e983ddd0848c760f9/raw/1668f34550b5cb0135f7fb73eae5a6b52e0751fd/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/990ab5ed350cb27e983ddd0848c760f9/raw/35a9dbfe64eb6405e86bb0c268e36a4d7238568a/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/990ab5ed350cb27e983ddd0848c760f9/raw/81a61b72ddf5329959cab7c32597b66cf3630e5d/poc.c

Build the tested kernel with the attached configuration, compile poc.c statically and run it in a disposable guest/network namespace with CAP_NET_ADMIN. The program submits the invalid mixed request and reads the live fq options back.

Impact and prerequisites:
A caller with CAP_NET_ADMIN in the qdisc network namespace sees the request fail while two qdisc options change. The same valid limits can be applied by a successful request, so this is misleading error semantics/configuration drift, not a security-boundary crossing.

Validation: Two fresh QEMU runs reproduced plimit 10000->5555 and flow_plimit 100->6666 despite -EINVAL. Invalid-only and patched-kernel controls retained the original values.

Thanks,

shaos

