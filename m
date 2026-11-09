Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226541;
	b=bqb4GxiJKBMsWFdnWOP/y+IwEiXDhhnhFjbmDW1McqKipLjQv90z8DYlIdTUi0w63ruz
	 8pQvDVknFjShDOkPVB1luXlMp98FXUPwoXCApG5npB77BJqZ2EurBzrU1EfZ5XzuP6KF+
	 rk2m1XjOdr9UOWzHRXK1G0j90VsCEeAtW8z2z7dIg9jrdiidsjCkI5pej21fc926OcxDd
	 Q8bAbZ9KLJhxq44LhLmioh0zsl1dmHB5kYUUkr/X8XazoxaNV41Ht4pSMN3wJP4ziDj5k
	 hPtLDLgsuakKYU2lMaZvQOr4uDMQMy+swwwPoQzkqjwhd57+XeofWTLkG0QOjIrKzfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226541;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8jvHBme6zPqyADTvxOn21MVTvYy0GCMqqQxDtMJ34xs=;
	b=HZK6VV5YAiznPJmw5M+Cb7uyavS1RU0c46AE6OxWlOByv0Hhq35FLnj3FIXbQgGcxflg
	 dlf0mwnUwT58tzlgzxnUHUWlpxM0Yl7Dlp/93jBsbBKeVDUO5DxcfTrr+lWRVW4sw2EfR
	 cYtpNG3Sv35lGSI2VG1CFKpFSJerf4HurhyRptQ2VtL6GBZACxkrn7QGLQCPjw7/yE971
	 3mEWYpQsYQwy3jN8cdY+eEEQ6SYtF06//BpR8ucrv5FLXBfSEyCZTCB139W7wWZ9MgqHA
	 boMEIyXrb7X/pnYsMTx2sdMX5x2MwhZcnmSwKoV/jincWwyZtQosEC4pf4L3wSKlwTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZlAyCLV6;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B3606A322;
	Mon,  9 Nov 2026 12:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976B3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZlAyCLV6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8j
	vHBme6zPqyADTvxOn21MVTvYy0GCMqqQxDtMJ34xs=; b=ZlAyCLV6auT/Wi36Wz
	G3tHhsaxImlPQkGQFv+qnbdQb14mN8N3VlMkJmAl9ybGD+7BUyKnNVSTDiqShfvU
	pmFCGi8eMQBjNDIVSDlM302cxsSIe+PHMrJZgH/0UTuHLR8hqo4ir6cGj4V+dffu
	sZCDD3aE9cYLHv+gpoZlXa8IY=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXn1A4ufFqsGfQGg--.48849S2;
	Mon, 09 Nov 2026 20:14:49 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: release old template when replacing a chain
Date: Mon,  9 Nov 2026 12:14:48 +0000
Message-Id: <20261109121448.2589374-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wDXn1A4ufFqsGfQGg--.48849S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw18Xr1rZryrWr1UGw4DArb_yoWrury5pr
	ZYkw1ftF4UtF1xtFs2yF18W3WSgws3Gw1UCFn5Ww1jyanIgrn2yrWxK3y3uFy8CFZ5GrZ0
	qrW5Jan7Xr45CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrWrXUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0BqToWrxuTrlYQAA3k

Hello,

An action-held traffic-control chain can remain alive after
RTM_DELCHAIN because a goto-chain action still references it.
RTM_NEWCHAIN can reuse the chain. When a new template is supplied,
tc_chain_tmplt_add() creates a template and overwrites the existing
chain->tmplt_ops and chain->tmplt_priv without destroying the old
one.

The old struct fl_flow_tmplt allocation (1160 bytes) becomes
unreachable, along with its classifier module reference. Each repeated
chain recreation leaks one object from kmalloc-2k. The allocation uses
GFP_KERNEL without __GFP_ACCOUNT, and the tested objects remain after
the network namespace that created them is destroyed.

A local user with permission to create unprivileged user and network
namespaces can obtain CAP_NET_ADMIN inside the child network namespace
and trigger the leak without packet traffic or a race. The demonstrated
impact is unbounded host-global kernel memory consumption; no memory
corruption or privilege escalation is demonstrated.

Two fresh QEMU boots of the unpatched Linux 7.3 tree showed
kmalloc-2k active objects increasing from 60 to 192 after 128 cycles.
The no-action and held-chain/no-template controls remained at 60. A
UID 1000 user+network namespace run increased the count from 48 to 204;
the matching control increased it from 48 to 84.

With this patch, two fresh 128-cycle positive boots remained at 60,
and both controls remained at 60. The user-namespace positive and
control runs both showed the same 48-to-84 setup delta, with no
per-cycle increase. The positive PoC reports a failed leak threshold on
the patched kernel because it is written to expect the vulnerable
behavior; the zero delta is the expected fixed result.

The issue was found during an LLM-assisted source review and confirmed
with a userspace PoC in a disposable QEMU VM.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
Source version: Linux 7.3.0
Compiler:       gcc 11.4.0, GNU ld 2.38

The console output, kernel config, reproducer, namespace launcher, and
patched-kernel validation logs are available here:
Console output:
https://gist.githubusercontent.com/shaos26/3e31c231ca56bc53ef80b5c8aada2821/raw/7ff5d84b07e0b260952d2f8575ffb1936edcb099/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/3e31c231ca56bc53ef80b5c8aada2821/raw/aeed6e5360a23b7e36cc06272dc0069f8639c61f/kernel-config.txt
Reproducer:
https://gist.githubusercontent.com/shaos26/3e31c231ca56bc53ef80b5c8aada2821/raw/f73bf112b5d6bd7e6633963e3dee0c0083ffeef0/reproducer.sh
User namespace launcher:
https://gist.githubusercontent.com/shaos26/3e31c231ca56bc53ef80b5c8aada2821/raw/b30237aa0b52e39ebb9da06d790c3f8430b62903/userns_launcher.c
Patched validation:
https://gist.githubusercontent.com/shaos26/3e31c231ca56bc53ef80b5c8aada2821/raw/d769d8afbfa6293e3f7bff967a3408521972dcb5/patch-validation.txt

Run the reproducer as root, or with CAP_NET_ADMIN in a disposable
network namespace, on an unpatched kernel with BusyBox and iproute2:

    ./reproducer.sh positive 128
    ./reproducer.sh control-no-action 128
    ./reproducer.sh control-held-no-template 128

The user-namespace test used userns_launcher.c inside the test
initramfs. It drops to UID 1000 before creating the user and network
namespaces, then runs the same positive trigger.

The patch creates a replacement template first, leaving the old one
intact if creation fails. After successful creation it destroys the
old template and drops its module reference before installing the new
pointer pair.

Fixes: 9f407f1768d3 ("net: sched: introduce chain templates")
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/cls_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f2..56a706b3dbcab 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3128,6 +3128,8 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 		module_put(ops->owner);
 		return PTR_ERR(tmplt_priv);
 	}
+	/* An action-held chain can retain a template after RTM_DELCHAIN. */
+	tc_chain_tmplt_del(chain->tmplt_ops, chain->tmplt_priv);
 	chain->tmplt_ops = ops;
 	chain->tmplt_priv = tmplt_priv;
 	return 0;

