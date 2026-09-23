Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C52481257
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188829; cv=none; b=ORM+r08EmZvek0WyIT/VZB7scqDiOh2+xHS/FI6+9Xl7KQKp2xDchsaMJFoJozI6w+C6Dhu7seApp7gZcaFSJWoAfrVRs/z32uDeUsF/q5bO2ZzrSPiF4noIs2Y5/fDiAYeYoJtYGnROL8LxrpCxXdjgW0ERwSgtQ1H0u6tzvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188829; c=relaxed/simple;
	bh=+kKmRSHAFbZ610bwi6FiHGuRD8TJDim0w7kTnt9xnMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8lygr4MqBJl2JyoqqNzvvkC4VnKRm0n+yXXRx2dhLp3MCX374tIgKflXeM8OWtJfAr2fqBFk9Bs8Z2PxVUsd9XDcxsjdRTroOmkP1d2QIwQpDqOudUf6dLTdph49OpmAhygOvCV8Sdy7kYyYfJDfbBGv1d1ktk3JbSTH7B+xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuWuHzEd; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuWuHzEd"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaad1544b7so2037994a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188811; x=1790793611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zqyJbHjr6LcXcdK9aE9i3DnVIewwpBEVNVy5+on1Af0=;
        b=BuWuHzEdLM2OZnGyyxcIbp+db9SDVEWxH2CbJIMhiH/PQT5BatdaLXMw+6o39iz2o5
         BkjibZbPjMK+SHKHVs3tWgeaJOX6hY8a9CzEcZdplW3353m3MWG3rfauVIIiYpUoYHLl
         hqUfQnGhlR9tlY4ijP/b81RWTTkw7kMeVwtH8CWry7w6KBtB251zKwn75gRUJBYEyzBj
         KySZbG7DDK5ZNZy/3iuzKmibkb9kwfwq3lufDtflYYF3A0y1GvbTYpbKZeRM+avLiCnT
         HyVAIY7KSEWKOS06eH4g+uSL/0AzSsoTD6MLpFBx70bVEbtTPbI5nLELyFThYdkcgonZ
         c3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188811; x=1790793611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqyJbHjr6LcXcdK9aE9i3DnVIewwpBEVNVy5+on1Af0=;
        b=C/Ien2o3HO2vy8CQglRY32sIr0275qF911ZvWBeC7T2I2CtNOw+Xe78b1AdJr6H+yz
         jv+9iH5nmjVax+vBdh290JvVo3mDlynzqRNiYbJE2VjW4vBeM3ZhHAx2+NdG8Ptzej6K
         vn0fPTajmluRTeiZbMGyAP5j/nOfkYz9slSB+o8Km+Ztst+Ct/bL4rMsJkV354vdlvTa
         lkpOk3A3qzbk/btRfkSacBzEtGJcX1qES+s4eIdUlXbPLQ2m9gvmWK9bCeW+OVeEp+5Z
         qTg8YixtuoYCy3vaMw8Kfq0oxxBVK9O2BhjJLl4JsJp/sqGvNwUaul1dSit7+xHZj9yX
         t1Fw==
X-Gm-Message-State: AFuF++lNbAJsj/Bfgn3qajsNX2/pt/jYtFtiUep6SiLZxJgdXWaa+1Nk
	oJTrtMf08avNzHpzPmKnFTzLCCnIjuDnElvtnwBZOhYxClKcwMq6NX/rcLii07qD
X-Gm-Gg: AYBFou0jvD5VkaWma5ffTPbhLh8oFf7TEEYAQavLYFEliJWU0a3NutTHbxDOABKrGk0
	Yz2jUoGGM1HTVvMbUBwUMmyCsRskg4uJUsh8EnG0+zOGxmJjvvyAG3wvWtFoXYoHr2YE8nT63mo
	UxNxiazUuePxbK1s93A3Fy4qS4BiRI9m/8zMkTcTZulRIr2hTxAJexkBDd1A2SR4jV4jUpI4QOL
	5iPouKiSRL5NAJ13Y1lEF7F959uZV6r1Pa4fI0T2i7YMIe3mwojD4xz/yFXRXZq2caIKUZWuXjl
	4NCRBbPCdsjGGRGrf4c3QuJpOWW6TIueNoITVrMgBc6WVSiYlKwP04uAI8jXGKGZI9oQCvtKZG3
	XndHu1tjgtfimL2rTUH7pXRXy3ENb7ScFjU4bxRF/VT8woSc7ESqSrdM5RBQ0CDoYk7yO841SrV
	HEhJ0l0b7FB7rg8QSWhlWs3ZKSGwchF8NFOvS7wElgq14/dRGF3Xd2m3A9UdIMHJvD+2g8Q5eIt
	UTgFJb2DBi+mtA1N4463IlPD3oRSfhdW3oxh0G92sMtu03bUuU4DsG9shpYaelBRiDmrw==
X-Received: by 2002:a17:907:3cc1:b0:c26:19de:9acf with SMTP id a640c23a62f3a-c2ac2338f7cmr4037366b.39.1790188811203;
        Wed, 23 Sep 2026 11:40:11 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33faf4sm173417566b.3.2026.09.23.11.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:40:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v2 0/2] vsock: receive queue hint for io_uring
Date: Wed, 23 Sep 2026 19:40:06 +0100
Message-ID: <20260923184008.153541-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_VSOCK stream receives never fill msghdr.msg_inq. io_uring initialises the
hint to -1 and treats that as "unknown", so it cannot set
IORING_CQE_F_SOCK_NONEMPTY, and it speculatively retries a multishot receive
after every completion, including when the queue is already empty.

Patch 1 fills the hint at the common exit of __vsock_connectible_recvmsg(),
reusing vsock_stream_has_data(), the transport callback that SIOCINQ already
uses. Following tcp_inq_hint(), it reports a terminal hint of 1 once the
connection is finished, so the caller still performs the receive that
observes EOF. Patch 2 adds selftest coverage.

Numbers come from a ping-pong over vsock loopback using io_uring multishot
receive, 4 KiB messages, the queue drained between messages, with kernel
receives counted by a kprobe. The baseline is the same tree with patch 1
reverted:

  entries per delivered message   1.97 -> 1.00       (5000 messages)
  receiver CPU time, median       1.640s -> 1.587s   (-3.2%)
  receiver wall time, median      3.260s -> 3.183s   (-2.4%)

Timing is 25 runs of 50000 messages per kernel; CPU gives Mann-Whitney
p=0.006, wall time does not separate from noise (p=0.12), as expected for a
latency-bound workload.

The hint is gated to SOCK_STREAM; seqpacket is untouched. SO_INQ and SCM_INQ
are deliberately left out: they need their own per-socket state and
ancillary-message semantics, and a byte-count contract would have to account
for transports reporting less than the whole queue. That can follow.

Testing: built and run under virtme-ng on loopback, where the new cases pass
and vsock_test still passes 41 of 41 with a clean dmesg. Other transports
were reviewed but not tested. Hyper-V reports the current packet rather than
the whole queue and can return -EIO; an undercount only understates what is
readable, and a negative result reports -1, the same "unknown" value io_uring
presets.

Changes in v2:
- vsock: rename the helper to vsock_stream_inq_hint(), fold the NULL
  transport check into the finished check, drop the int cast, assign
  msg_inq directly, and document why only SOCK_STREAM reports a hint
  (Stefano)
- vsock/test: move expect_res() to util.c, add uring to the SOCK_NONEMPTY
  helper name, skip instead of failing when SIOCINQ is not supported, and
  drop the redundant final barrier of the EOF test (Stefano)
- vsock/test: queue two chunks before arming the multishot receive and
  check SOCK_NONEMPTY is set on the first completion and clear on the
  second, so the test fails without patch 1 (Bobby)
- v1: https://lore.kernel.org/netdev/20260920194710.1114748-1-devnexen@gmail.com/

David Carlier (2):
  vsock: report pending receive data to io_uring
  vsock/test: cover receive queue hints

 net/vmw_vsock/af_vsock.c               |  35 +++
 tools/testing/vsock/util.c             |   9 +
 tools/testing/vsock/util.h             |   1 +
 tools/testing/vsock/vsock_uring_test.c | 391 +++++++++++++++++++++++++
 4 files changed, 436 insertions(+)


base-commit: cea851523034d83dc61d882b1a6a3ad273480f7b
-- 
2.55.0

