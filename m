Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618902;
	b=G2jzZ0Md13TCWVoxaK9NWwEdWzSYg8lvr7NDmN38evbkHFHffflksdPTBWJu2Y639BZb
	 wPa/Tt61L+anvAzxSO60JxrriepUObLbYSCpIEK3gX5L7uVaRJ+GFugFw9MWYp8cus25r
	 fwRN7HizQO+OUx6WJ1jZ3QDTcIZlcZH0/KmBL6NPLpMrNJn11STVKJnsiZrUHKD0QIxR3
	 3vjZJo7weog4jo/tPx0E2Dqp+1DSx+OEvbu65+bIm6CAWPyviNq0uOkOZ/LUdrZuV4zVe
	 SisLGcOqmYP05ayl4rI9c1cn3F240ySVbIZKVTid92nXvRh6UJP6d/s+KFSG9aT48aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9IaU7E11XexPelfZtk6vTetrl6Nh5YFdFoxHGj01jR8=;
	b=rqutHUW4MSxhQogjQhcSD4azCUVWQu7mU8thq3hlvby4428EAghws3QVcgJyyozifxvR
	 QrJrh+R9IyTMVgVya3vdZoO/4lFjzCd2oWUUrchRFQ0ikkerLEFRmRn44UvlEtxjeqjMS
	 4EgG9f/WYRk2IfeOF4HePj2xyK2tgs7qkrdKf+61kCWFQgWxlopoyxDKnh5jjhmbKIH/7
	 jMPUMoMjgOMSyy3o66vZmqWd0rctIckzO2401JYgM7B7xEjXaVJEZmU3bqLloWe9O1RVB
	 fAjZm+cM64S2x5SpCPQ8rv59wcj//YWkz8FbnJmaWmr2EmNYv4LpT7YqjklR5ucbR8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZCgOQEb;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF43606A32F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF43606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZCgOQEb
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso18868195e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618900; x=1794223700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9IaU7E11XexPelfZtk6vTetrl6Nh5YFdFoxHGj01jR8=;
        b=bZCgOQEbKdTB7Mq/1mVJibyJv5VYt9bsdDpVaATR/g9NEFzYmp6J+g+vXxRB2THxvY
         OV8kGKwlV657qRQoy+L0rNZkxusWf7KnJXSYkyhfxGbbwVMxlQY+YKV2xbDlsqG8RVPk
         Y8RZ6eMRexd5EjciyWP5zLOp+DMEHjOYEwm9FqqaaIhuUX2wKAhzvrSn2XgE1Dz9d8k/
         5PXeLOinAczQPPoOz1zRUVAwai4yCFQWAuVngTFw6tPIUhfmmQUTMgTTRfnrrqcBqHXN
         g3lUYrlWO7jk6qPZs+cIpAsTpKZ7O1O7ohhEqjJTvbPh91iQ1OS8unewUErqpyIw3ro5
         0FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618900; x=1794223700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IaU7E11XexPelfZtk6vTetrl6Nh5YFdFoxHGj01jR8=;
        b=zOQWEjwV3ZEo+eMNXYMfPRazCmz2lpD77A+H603vASPSsx7v780+OMR5sD2v2ASsjt
         2hWozkMUIwA7GJu8foDw9bsJxb2G/1R67sAzSmH+gbk8zMFu3FBUp8yhsnA+HEeOvzdY
         /m82OrGZhBvVoW3GgR/AfrQDLlrqMtnEjHwO5pjqiCzRZuRJrgepYyynPm+3+AFAs362
         ng9JFlZbivN/8jK6xTS6FWbUjp1K8r09aPg4MZZpv06pEXYSItxNreytaru5KM72ZwVy
         jwhs/Dbrqk+3+vrOz9vm1h6AroashYOMCS2IclMq837qEz3lDnD+wNHoueGX7/ImCW0B
         VXgQ==
X-Gm-Message-State: AFq9FYIqzUA5cibn2nfw1XyxvkzGUyPuSExBIasqoyCkx++8Pa1+u11e
	cqY1lQhGspGKQAzxN2T9J/lXnta1r3RT/lEH9rE417ITOnxgLmIAj0HvmwD0yRC7
X-Gm-Gg: AYBFou0C0Z88xIZ8a7LhenjfiM/bTS0PMa+RLtVNEAsryG5AS19A7jMGb1ZszbQly1j
	+ZDz4Md3PEyntqN35kkHbzO0WCohyK1pUnFfwV3zmFqnez1J5haEfQZcz7kGfeD75M8eCw95P98
	K4kvm3/JWUtz2dFZ79Nko24rZFJjP07vV+9O6imtheG60yXLrg6wASnWZXnafQouaAO0jYxc2jv
	nvSAb2d+7wW9i76rwuWZPzj23Is6y7HqFWnyILaGgIkgA3PhtThmttZz+IRDH2S9RV3P6TXyK50
	Fjdsz1bcrDu3lK4kadcYPom/5meu9BooY34r8upWIiAUagDsDzIMb6EixVumchCL5o0/1CIZkvT
	//jVKd16TFk+cZKB50i1R8cAFmrW4iw3PH/npuvaFhqq4HnIxrfph5lP991GwHeOoRQaEQ80Aey
	uS8cxzqNUDoXdEfjJxsBADqWUzDCIQWnRvDJhJtDjoGEWDkDWnKbaipSixyloXa07aRNRFNfCmE
	USqBhkBqb80jHrJL0fD9H/N++Athi1e/vSY1OTR5D+3SZCwwZscp+U+PWwX4I6Lx4Z58GO3tTD1
	Vq3K2N7bCHzmQHQnE85F+kRKHpc6NmLUFuGsA/yobWRo5s19968NIsX8oXangKJ0uLXsXDK2F/P
	vb32R3GHtfkweKnEgJj16xZ7TaxJbyLruXF7HxYrf6L0tfGvqqN7asw77aXDR+EGBqOy4tiRUG3
	rphN8wAH7fuxHcgaif7tWNdzlB+91l0oGIefnnSEM7zSAIrvtWwf7UzuJfpBqq5uD4wz/QxDTtM
	zE=
X-Received: by 2002:a05:600c:8b04:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4ac17a3683bmr230033685e9.18.1793618900268;
        Mon, 02 Nov 2026 03:28:20 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f91d-46ab-c9c7-94fc.ipv6.o2.cz. [2a00:1028:8388:a84e:f91d:46ab:c9c7:94fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm311382215e9.12.2026.11.02.03.28.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 03:28:19 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: mvneta: fix the TX queue arbitration and the mqprio teardown
Date: Mon,  2 Nov 2026 12:28:13 +0100
Message-ID: <20261102112816.12322-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The NETA TX arbiter is left at its reset default, which serves the TX
queues in fixed priority. Under load a busy queue starves the others.
OpenWrt has worked around this since 2017 by sending all TX traffic
of its 32-bit boards through queue 0 [1].

Patch 3 serves the queues in weighted round robin. While testing it
with the mqprio offload, two older bugs showed up. Deleting the qdisc
never reaches the driver, and turning the shaper off leaves the
per-queue rate limits in place. Patches 1 and 2 fix them.

The series was tested on a Turris Omnia (Armada 385). The other NETA
variants were not tested, but the driver already programs registers of
the same block (MVNETA_TX_MTU and the token sizes) on all of them.

Replacing an offloaded mqprio qdisc under a new handle still loses the
new configuration, because the old qdisc is torn down after the new
one is set up. Software mqprio behaves the same way, so this series
leaves it alone.

[1] https://github.com/openwrt/openwrt/blob/a5e96c837ead549820867bb83c1ad471e39f5ace/target/linux/mvebu/patches-6.18/700-mvneta-tx-queue-workaround.patch

Josef Schlehofer (3):
  net: mvneta: lift the per-queue TX rate limits
  net: mvneta: fix the removal of the mqprio offload
  net: mvneta: serve the TX queues in weighted round robin

 drivers/net/ethernet/marvell/mvneta.c | 36 ++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)


base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.54.0 (Apple Git-157)

