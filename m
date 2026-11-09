Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229919;
	b=lqb+iMVfkVGnLIztnx3B50eQuOOfa8Z2TUFZF08ClfMmopGmNu53rLHE6uJ0n0k0FQ9g
	 SBL1oX52ofVxqm2dKs2KYXfjUGyLB2tz0grlaCEJeiA14dhZsdQwrZn2AFU/aqpjpj6xF
	 jbExRuLVyuKu3LFhSBX3RYVsqCyWHJsM4tw9CBsM4GbGZ3iVfBiEtaB3SgoIcq9Jsea3a
	 Ik+5SLEgUNV2alYPDu0ZfTOZTesLRIzM6+DRrYedx88v7InEoQBNkfYzBMdAH+/sPgWUa
	 WkcaXdLTeD8KdSQSn+9dv7FnAfkhi9OKB7xtUYJft67PFizqN/AC+lofHbUJ+uzi5Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229919;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xUQTh5R5I+WlURQ6SeUarFuSZjb2uZEb7cX1vM74ZiM=;
	b=YBgP3VFpvibhKEmQwOYr8jSKpeP1/t8peTon02PgVaa6pWMll/dBLvPPUWWXfJa+yB89
	 yxvuKfNrnw2Xp4ytfYRyMRsjhj70ISVhLWfWKbm/4b4ky9Q3mdDz7QYERz+eGgZKJ9Vxp
	 IFOwF8bCXO+VbtfT4BgjPIcVrHhAjYb3ikD+BJwBYHOyL9QTFvXfiD+AuPSEExo92pSDb
	 rstHrpV6LhKk4FNxauH5bfNKwmEC/sTNecI4fyxOQFhk55OSKoMUY0UHMcpK27/X6yZv+
	 RFUcrCqKO7I8/zmpjhsBO8yiyNErGhngT4XDB7eMVxK76a22mFY+bC0RjxqcKn2JGHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=HMNrtqyt;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69188606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69188606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=HMNrtqyt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794229916; bh=TdovQf/rO4y/TB8cve9Fw3z6yAUplJ3Lk903iR1FZ4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=HMNrtqytJbmEym++51YEJ3gkbCnO02NrDV9LYaIhMp8F4yntb/Qmtv19nL1AZIrDg
	 auUKSzMqiQdSDTlsErIhs/Q+k/X1qcUtjIPxdvlN06HNmBA/WbTp3OGRT+h+6tdc9r
	 yH2MKLov5wCvGitNPFR3V9cVEYnvQKnzxx4ESff7u9k+k8pvfbgHaP6o4xDQMkLCCG
	 WO1uXtirAZEeyd9Lch3OfAjL2azdHSkvs7pmrlgNAjOCvN4FlcSAW83/MMzHM93BQo
	 gQBFoJsxdVd3LBTOrp9jdPX8d/LfFAvkhIZfAZ4moXyRVDHBYvyCaatmYT3x96wAXX
	 a+3jvBCrXnTew==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id B884D44C01EF;
	Mon,  9 Nov 2026 14:11:56 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2-next 0/2] flower: support a mask on enc_key_id
Date: Mon,  9 Nov 2026 14:11:46 +0100
Message-ID: <20261109131151.960789-1-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
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

tc support for the flower mask of the kernel series "tc flower: tunnel key
partitioning for RX queue steering". One rule handles a block of tunnel
keys:

  tc filter add dev eth0 ingress protocol ip flower skip_sw \
      ip_proto udp dst_port 2152 enc_key_id 0x40000000/0xc0000000 \
      action skbedit queue_mapping 1 skip_sw

Patch 1 follows the kernel header and can be dropped once the headers are
synced. Patch 2 adds the mask to parsing, printing and the man page.

Exact rules dump as before. An older kernel ignores the attribute. Exact
rules keep working there. A masked rule matches as if it had a full mask.

Tested under User-Mode Linux and on ConnectX-7 against the kernel series
and a kernel without it.

Alexandre Cassen (2):
  uapi: pkt_cls: add flower mask for enc_key_id
  flower: support a mask on enc_key_id

 include/uapi/linux/pkt_cls.h |  2 ++
 man/man8/tc-flower.8         | 15 +++++++++----
 tc/f_flower.c                | 41 +++++++++++++++++++-----------------
 tc/tc_util.c                 | 12 +++++++++++
 tc/tc_util.h                 |  2 ++
 5 files changed, 49 insertions(+), 23 deletions(-)

-- 
2.47.3

