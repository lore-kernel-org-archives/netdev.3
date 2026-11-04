Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832325;
	b=txzxFMlGecor1mZUYZqewvisdjCD/YFVeJsX65Y/6OHfsWuH8X3NaT93WW29E/v21IIg
	 6RC4Tz0LMGQfjM1WMHn9vXuaXeZh61h+N6uHIyB2SrT0bNZO/dhn7v1jM11nkrKZKtiZv
	 1HWCTHExCynu2tujVYCd5atP72KMoyBpvhH37tHngbHYt9kj7jAKnAYa3bCaQJH9a0wv1
	 Pp7tcrts4O9GhWNtTei+74us5P7fY1sPH9sZjqJLtS0DMlEJdQFa3D2MoQyRVyoZnCGpP
	 /XSA2Rn1rG9L7+QX7hHgtULQt3re9CGFNtEAT//hPeLSHC1JzHj/cFE7XCTqwjKELSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jC7wzUlJenFIhu426Ht6bZZy8FBuUFtiZJAgit2LxZA=;
	b=d563mW9F9gjVOxEIx77xkTeDV/s2ceMIVkSwNi3sSLNCBK65NsNQ4ZGNFjWIn4kJu3bj
	 fmXvgT6ZrBYKpvhQdXnLTYBmjcDksflTwRjDxC3vNQFMybDKAq54VY6vlZWW/tGwRsPGD
	 JMPjSLlK9pQDixy/JEd8ANmFQiji6VIDmrP4oZ1KdPldoqARdfiXClzECC8mGg+jl3oW+
	 n/oRY2crRxaPSmb11s047AQNV63F9ky9RoCKg73r2G8Gd2hZ3WyfaIrcx8U2CE/aU825o
	 WycEZNpvqW5t5/+HaC68Rp/27FdAM1r2jJP9kTl+qbarCVjZhSXYldqLd7cSbTt8S+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l7kwhkh+;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C57606A32D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C57606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l7kwhkh+
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so788085e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832323; x=1794437123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jC7wzUlJenFIhu426Ht6bZZy8FBuUFtiZJAgit2LxZA=;
        b=l7kwhkh+Nt2G/jrfyS1YlKGEnk4++f3fHPPQdRzEtHxZonaOHzEUrY1TrOXe9QtGz3
         YaUb1vGwFSrpU8BMe4QfZLTVBjvjqnqchoEwqpRPCtXZl2hSf3seYmuo3Rw+jC8jY7rZ
         wEoKT/ASSfsPvPvAEgtoRycJCqm8zEmErW/ZEjgZG5eZfhAyp9+YSY/asO+2u/UpwKhz
         mmEMKxogHskLSNyTQcc1MTKfm295P+XWVtqueWjKbmjA2hL1Ufvnfw6qeEvzSXl/jH4/
         j1j+MjLDj0uapJV6QbvPUEVciupzAtkE4SEK4V6snhJ3QJLKTYvlzOr30IETf8eTXrpk
         9gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832323; x=1794437123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jC7wzUlJenFIhu426Ht6bZZy8FBuUFtiZJAgit2LxZA=;
        b=kZIPz1U2lNJj6oWCTCmcXUtPRq9B9s5PAU0ai4X9W20fThTFJrNcJzXDTm8+n07jZl
         AAVmTLuL6IMlJgh+R70JRQ5UET4T34q7T6HuJ1Cjh5v/M6bjd9I+n+xMbhovd4OhO3MZ
         r0ovWCVbG2P1KSNuy7P9/bxkynQMq+wsWXqOiADfJnPYYAILsZh0MQ+gc6TwNRZXEazz
         2oAWqJw5lSIO8e8Wc0E6+JwaX2B4nzdkRKPYjmtwIcYJPS00oukMm85YoQqvob/I493l
         83/2J8++zlHWl0jU65zRar++RW6wQKYD1fyXHbj9otjSvUDOb4Umq5T6KTkO0Fg50MQJ
         P48Q==
X-Gm-Message-State: APuU4Z8J4mz/yoZ7hOiOqh5JLWzLd/de9Zs3jgFdOGrrkxI9taMPJfKG
	9O7Nn8SI7uZP1Zj5A8kX35TYSJNfX/JSnzVFMiIXKk2U4FvqVJEqLc7lERnWH1m2
X-Gm-Gg: AYBFou0Kk0rkMl0xXxGIeN3XD/jI/MQ/xoyFb3W0XCO0WJpZwyo1vsMl9OTvbA7lqMG
	gKKUXX1qEMlgC4NjLyDiRGVPH/vmjlc43dSes9aFyBGXjzOG4i23X4yXJVOSOR8ABuE++3bQM5A
	yHXLMYPmqkezIfcu3filMxs4EQBo2v4BNjEYtEttDXkGRUM1JdyuZGXxYoK705ONwDFby4Q+whN
	WnQ+MjXGRxMs4Go0N2g6wdtAFXB4OBi8rhJkrqZp+8uDB1azJ1Wl7mpI2GoOpF86g4kWLWOjXhY
	gdv3H13p45kYyE/OCECsLZp8PAvlAE0BVqcsTFD6ywfza8LPayFyBOFr+aqmTMB68YkJu96ZqJ7
	rQxVjjuhQE2xZbV5JCRwoF934FFwiL1ds/hvIQQBOidAM6luJ2liQpvwETqfVGxHvRURlNqqpYE
	k5FOjXgVAP3+gCQ+09r1PZnxjIlBcwJVxhU3PnGj5krO2fkdXFHd9Igk8vP3NVsozzAV/olj/M8
	X1aLYlUEZqxWtLzmKEgDM7frdmeNdm6uSA77ENfComv1K6BAzt0fzVv4kZOERAyGzpr5t0lCZLP
	k65NuTCPPbtcnfYyPKlhpv92fqTpd6ZGoXt7XOyDx4WK8UE+5GtvfsuxDmsFRQ45ubpr0MOqjb7
	Xi83VxI2ua6XHtiJZRtLFdiGEz3P0FHf1O/b6ecTc5dVojIcAULIPV0MFrspOLAg+01a5i8L2QE
	JUacRA9WlSq7Nc7Zwin/gHUbPKm+MUELc7GjL0Q599jJSQFfHEiEh6hA==
X-Received: by 2002:a05:600c:6219:b0:4b2:4b5e:8141 with SMTP id 5b1f17b1804b1-4b55d4f759cmr11989045e9.9.1793832323021;
        Wed, 04 Nov 2026 14:45:23 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-947d-5f15-1dc3-a8b4.ipv6.o2.cz. [2a00:1028:8388:a84e:947d:5f15:1dc3:a8b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4320efc7csm36604235e9.2.2026.11.04.14.45.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 14:45:22 -0800 (PST)
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
Subject: [PATCH net v3 0/5] net: mvneta: fix the TX queue arbitration and the mqprio offload
Date: Wed,  4 Nov 2026 23:45:13 +0100
Message-ID: <20261104224518.66487-1-pepe.schlehofer@gmail.com>
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

Patch 5 serves the queues in weighted round robin. mvpp2 also sets its
TX queues to round robin, in mvpp2_defaults_set(). An mqprio offload
keeps the fixed priority, as its traffic classes may rely on it. Without
the offload the queues are served in WRR, also when skbedit or a
software mqprio picks them.

While working on it, four older bugs in the mqprio offload showed up.
Turning the shaper off leaves the per-queue rate limits in place
(patch 1). Deleting the qdisc never reaches the driver (patch 2). A
failed setup is not undone (patch 3). Opening the interface or changing
its MTU sets every rate limit to 10.23 Mbit/s (patch 4).

The series was tested on a Turris Omnia (Armada 385). With an mqprio
offload and "queues 4@0 4@4" on a 100 Mbit/s link, one stream on queues
4 to 7 got 94 Mbit/s and three streams on queues 0 to 3 got 0.2 Mbit/s
together. The other NETA variants were not tested, but the driver
already programs registers of the same block (MVNETA_TX_MTU and the
token sizes) on all of them. Suspend and resume were not tested.

With patch 2, replacing an offloaded mqprio qdisc under a new handle
with another qdisc that sets traffic classes loses them. The new qdisc
is set up before the old one is torn down, and the driver now acts on
that teardown. The core does the same when the old qdisc is a software
mqprio. A taprio qdisc left without traffic classes sends nothing.

Changes in v3:
- Patch 5 (patch 3 in v2): keep the fixed priority while an mqprio
  offload is set up. Moved to the end of the series.
- Patch 4: braces around the loop bodies.
- Patch 2: the commit message also mentions a taprio replacement. The
  code is unchanged.
- Patches 1 to 3: Reviewed-by tags added.
- v2: https://lore.kernel.org/netdev/20261103125021.70845-1-pepe.schlehofer@gmail.com/
- v1: https://lore.kernel.org/netdev/20261102112816.12322-1-pepe.schlehofer@gmail.com/

[1] https://github.com/openwrt/openwrt/blob/a5e96c837ead549820867bb83c1ad471e39f5ace/target/linux/mvebu/patches-6.18/700-mvneta-tx-queue-workaround.patch

Josef Schlehofer (5):
  net: mvneta: lift the per-queue TX rate limits
  net: mvneta: fix the removal of the mqprio offload
  net: mvneta: unwind a failed mqprio setup
  net: mvneta: keep the TX rate limits across open and MTU change
  net: mvneta: serve the TX queues in weighted round robin

 drivers/net/ethernet/marvell/mvneta.c | 112 +++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 12 deletions(-)


base-commit: f56daaadfecae1f760d0fb34385b256d3af68970
-- 
2.54.0 (Apple Git-157)

