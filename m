Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680525;
	b=Fu/O4FHPo8PYDCVdUwHAW6CI6UMggWMfGdEM1lCQgQncRUu6Hcek7GTI/3x49XE77ruZ
	 AmBT6h0RQ3JBSJA7XkUEpzXfoLKTzyY/k2I84uSnillPc0zv0Nhj94pv7MzSgr+A9aR2L
	 kq3Ol7Ba+qRO0OR9HPILiLVW9RH3TmLRC1CfxvRBGlKN2kt4FLDWw+16a8QQu3ONttBzW
	 mL4/owGCvyPIitF4bNNkbFOw9P2k8uBtKNdpHG214P35LTXOZCsCYXIxljA60+M1IwDpj
	 F2rCGuTcsMIAbx8I2X3IG/1eabkuOsnDaqCZe63NjCPJ7N3KrDXXh0V9rkybLR39Cnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680525;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=q0UUKJNedWOp93M4Fe4rzELLr6YIIS1dOssZ4nDapOA=;
	b=AjTTVqRorOc7vyUZyVsotRFazCUZfNOdDA8ZrOteBiB6BtbtejmvCs/kXG5am7PdKQRv
	 FL1lrSWkCtoGPxvTTxRueZzMX7c9y3Wh1ZTYYobtvY0CFVFGl698dLyzB+h9Xm/9fZq6g
	 kDRr//DJiOvOk4ZIM5KTahrur8ulqF8T848+lSQHfkqSO4in146TqnpLWJTHGivz2PdVT
	 ATbU6PlAZuOqBzFcpLqlze/4Uaql/+sN2XwkTrdkkfaKsbSvhbCruGLiLWYBmCsmnC5MK
	 BBmE6T6Yr1KS9CUtdIlFBRxGsnpuuOkw7MgHfE3SW8TiJGqTVuC687tVJghcVBR+DbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ua9fqT6F;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7260A4AE1;
	Thu, 22 Oct 2026 14:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C7260A4AE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ua9fqT6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=q0
	UUKJNedWOp93M4Fe4rzELLr6YIIS1dOssZ4nDapOA=; b=Ua9fqT6FAze/40J4ZN
	l6E0b1m9ziL1AHfdqSteYTmHxDquqw/NrAb2BJaYoLm8/U4e/BL5GoBVrz1adVBQ
	Ypd/SEU3Xt6D6ATo99Pt0T+DC7eqR/Q1MjNmhSIZmcJYTND/eRmjuT4m4yXn9b4s
	qqqUAUzShJQlbL/y8Wc7k2nmA=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3Xy8rItpqJG2SCA--.61716S2;
	Thu, 22 Oct 2026 22:48:12 +0800 (CST)
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
Subject: [BUG] net/sched: GRED VQ shrink can orphan queued packets and wrap backlog
Date: Thu, 22 Oct 2026 14:48:11 +0000
Message-Id: <20261022144811.66149-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3Xy8rItpqJG2SCA--.61716S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr47tr1rWFy7CryxKFykKrg_yoW8uF1Dpr
	yvy34aqa18KFs8Jryq9rW8Ww1jgws8Cr4UJ3yUJFWfCrs8Wwn0yrWIk3y3AFZ5XF1kGF9Y
	y34ku3Z7Xws0gaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07josjbUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0Azk8mraIizeGAAA3y

Hello,

Queue packets on GRED virtual queue 5, shrink the table from eight VQs to one, re-expand it and recreate VQ 5. The queued skbs retain the DP number but the old per-VQ accounting object has been freed; dequeue subtracts from the new zeroed u32 backlog.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/160abad19ad184cfbb6ef6c9be204b80/raw/82b323a9f5e2dce8b71893aeb0bf841eb019e691/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/160abad19ad184cfbb6ef6c9be204b80/raw/ac2ef52ac9d01812eef68d5a10de2fb3e5e8be4c/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/160abad19ad184cfbb6ef6c9be204b80/raw/e3f8a8dbb72be235d802784cb4265435f82de27d/poc-init
auxiliary reproducer (sender.c):
https://gist.githubusercontent.com/shaos26/160abad19ad184cfbb6ef6c9be204b80/raw/7028d32b386af449ac9097ae336dfa2d520b3e51/sender.c
auxiliary reproducer (run-qemu.sh):
https://gist.githubusercontent.com/shaos26/160abad19ad184cfbb6ef6c9be204b80/raw/abe3ba54cf34d873da1378b66ed0a1e3524e70b0/run-qemu.sh

Build the tested kernel with the attached test configuration and boot a disposable QEMU guest with a minimal BusyBox initramfs. poc-init configures TBF/GRED and the VQ resize sequence; sender.c generates the AF_PACKET traffic. The run-qemu.sh wrapper in this bundle records a complete run.

Impact and prerequisites:
The new VQ reports backlog 2^32-3000 and rejects subsequent packets assigned to it. This requires CAP_NET_ADMIN and CAP_NET_RAW in the network namespace and affects the configured qdisc; it is not a privilege escalation.

Validation: Two fresh-boot positives produced VQ 5 backlog 4294964296b and additional drops; a no-resize control drained to zero and transmitted the probe.

Thanks,

shaos

