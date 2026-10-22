Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680529;
	b=pUU+dVovBzaHYspx0sQeuUyu0pmH0uU0qFgbKZFwkBBPH09BklPhJW+EcKqT8C0M/BZm
	 MpHt+/n52tbUQHUuttr4HZozpHznNv84KeK1YsZo36TIsQYf6JB1OcoWKwAtVz9gJd10P
	 XV0ml/qjwd67FVQw8p98Mngb+ucLPBRxfByzm4Wfy4qtUoevyKdFKr/os8wAJv4FJd/Df
	 Buw0tSKuCD0bDjYE6qCjwyAPq63uhQSbRluCmjiVsK+ceyggm8AcK9XsHPlDNXoKQHsHV
	 I/8UFMgf/nKK09IUal+c/FQTT0IhwDcJKbvrPpV4cTmXzgSQwjYuhzGIOR5Wo8UvTcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680529;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=3dOWtX0NIx0sS2B27/lwH65QVYi9q2r7lY5xir4iHAE=;
	b=Rn3KdtTv2j13rlLh15YBMo+N3O8LZRmmAVw2gM0F4sJa6GEX1ue8viELvE3sfP6K42Sb
	 gbSVTxFDeYb+OBRdqKp7IbTIpIvnKliXlYnhUuvTaD7CFFvl0TyyfTk/EtiRQcyT7TTy2
	 yHLHrKlewuJwCfhiQWjFaFC71hFimowb9isO1A+hQcLS5efiIF4o/2NZqyr/9D1AupOzW
	 MQhg3c4xfKWoN7QklAdy6abzQfMoK8PO9W0f7NHSlfVR/dYzyU2xfGuIEJfee/ewqOdf7
	 qBxHNBp5Gci+VFIN40KdPIwdckcW170S6S24aPIdemrOpElFOtHd4Tn1fNmXT3GrbFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IKhR5QGi;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017D60A4AF9;
	Thu, 22 Oct 2026 14:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F017D60A4AF9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IKhR5QGi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3d
	OWtX0NIx0sS2B27/lwH65QVYi9q2r7lY5xir4iHAE=; b=IKhR5QGiiidTlHI88+
	FQCALtjP5AEKKdban+YyqamFesmDz4z3l/m3cSDYqsKvLZ6Q6XVD3XMwa5VLPv6k
	EIpmcA/BQVqlFHuXSx4ZbfSprxZ/J1CT4vGsRNzXujzw2ddJjVqOsNTYvHVymfpT
	7536AHCgfG8qVH2IJTMqiVDCs=
Received: from shaos.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnwJAuItpqUuipBQ--.50025S2;
	Thu, 22 Oct 2026 22:48:15 +0800 (CST)
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
Subject: [BUG] net/sched: failed mqprio create resets the live device TC map
Date: Thu, 22 Oct 2026 14:48:14 +0000
Message-Id: <20261022144814.66366-1-shawnq1@163.com>
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
X-CM-TRANSID:QCgvCgAnwJAuItpqUuipBQ--.50025S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1kXFyrtF45AF4xKw1kuFg_yoW8AF48pr
	ZYqa13ta18KFs8Ka1kKFZ7Xw1093s7KF43GryrJr48CFs8Cw1jyr4ak3y5Za4Ikr1kGayF
	q3yF93W8WF4kGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07josjbUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8Q-k8mraIi9KuwAA3k

Hello,

Install a live root mqprio qdisc with two traffic classes, then issue a create/replace request with an invalid priority-to-TC map. The new qdisc init fails, but qdisc_create() calls mqprio_destroy(), which resets the device TC configuration even though the failed object never installed it.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/07ecebed4bcd911e280189e1c8ba7300/raw/3bb0bde411b29192b5bb1f2a1929b91b1b05b393/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/07ecebed4bcd911e280189e1c8ba7300/raw/6ea0e3da68f1e239d565c64f7906d0f9c73bf784/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/07ecebed4bcd911e280189e1c8ba7300/raw/170fc7a14bce50315912a64f0f2fa1e82a47b002/poc.c

Build the tested kernel with the attached configuration, compile poc.c statically and run it in a disposable QEMU guest/network namespace with CAP_NET_ADMIN. It creates a live mqprio qdisc, sends the failing replacement and dumps the surviving root qdisc.

Impact and prerequisites:
The existing root qdisc remains attached but its num_tc and queue mappings are cleared. This is a deterministic configuration-loss bug reachable by CAP_NET_ADMIN in the target namespace; no privilege escalation is demonstrated.

Validation: Two fresh QEMU positives changed num_tc from 2 to 0 after -EINVAL. Invalid fq_codel-create and patched/ordinary controls retained the live configuration.

Thanks,

shaos

