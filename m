Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FB64E50AF
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627164; cv=none; b=mzkMToOVfIXCw3XhvW9r9mqcN4X7U1eWlvWeehxxF2nK8zCQOpUFzLdfCMCniuy1Hgrv7XCJLh2ljINXgJVG1PcKpbNYWgox5gmSFcmTSFO63N8CVJnxo/iFbnrOKJ1ikO2DyuVHdwcXuk6fgt/F/umoQiWDZjFPjza3egIp0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627164; c=relaxed/simple;
	bh=TyuDivUD54R9KGx3JhSlFIalYLeavfULpQc6iYJcOMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsTx83ubNwKCh8yTwOghBkY/mgkNSkBlP+D8/A6eZpbDmPk2RRik2k+Xcx1Bw/xFU+2fIs75ilyiW9raHw6vzGDRRobDa47w7HHrq542Pi3m1CFXxqYQlZJVZKMtWMVlnmvONvyTfiGsq0d33sUtDFNm2DZxaYcn+K6zNJ4IyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=lrKgCf2Z; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="lrKgCf2Z"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso379118a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789627160; x=1790231960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MxHxOWAiU2enmb4ppG4thtqmKaJDXGiqoa9H8FyIx4A=;
        b=lrKgCf2ZjaldL23cMwF0wNOMJw+SCcUDLdUilur2J4lUmnmgGFwGARXfQ9S16xjbzc
         zvwzsZ24wkwgo+bNRST+4DXX/d0f+5GSlov/6Ab/ewJCTCnGQNYRC6y7sGEWXf2vFcRg
         Pyawr9J7WB5wv75FbsCJ9zfxzHwk/fbRomkxEnKQf2iqZY4cjblJ0BNwlDvsuliJnWsr
         L9bfXh0od8cgmfHF3aPsOeJuISkLpXF7bDzBKUNf5M4/W0GSY//lgZBlVMM8YidCnnxo
         ytcB2yFlF0GA2drLMaadmavVMkirOWWBhfth47Ykus9nve5CBwZVp9MgQcoRbehtKxzJ
         q1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627160; x=1790231960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MxHxOWAiU2enmb4ppG4thtqmKaJDXGiqoa9H8FyIx4A=;
        b=P0EZd88ARkZY2BRMDZbEWS1kTsq10FOfzwBZV9qakPDbcBAHhpeuZY5yHa/mH+jMcu
         aP+5bUbI8qwEJGE04vuq7YxyCSLQ3lv2OJCtdPknQTYwebQ6swJLk+gYmA9JMZhJL3g0
         Vu93HR2QT5QvyjuTRW/yjDw3A1a5ESF3t9lgQ6hGIQI55B6qv9mVsEzdr8QvZHTqRHUr
         cFPkM8+2ftbI3qJerSr6yrkom54LYlVK+FV4LPixtkelsvV3Xw/hX5PdnGTWgN/s4tuR
         lUIijaXnp31Z4SJtM4hNKHqBi89sg4Jfb/71MgopHXGn6DwIfZzwaNVJldt6WC1uIPQx
         1fvw==
X-Gm-Message-State: AFuF++n3zGRR4dx4qq4SIj0NAKl2GBArxUcq8qmniu23OJ/ifrMTLVtA
	HG6+nK7lpjGHUZVx7OBUELsgEklQnO74AnXyCE9Yd4FGrYlPvT/dzsGOlWx5AFLdZ/9u7UA3Ds7
	xoby8CMduA0okpl4R/IuY0IuzvD9aVqpku45TAJh42N+CRfDo9CDf7CCjsdzwOsm5MHuL2VRokM
	LoKw==
X-Gm-Gg: AYBFou3g0DrPlvqK45h5MjVTpE+mY7YBQ8+DS1ymnY/VeJ8nJkUuni9B5o958Y7yDgX
	lhh7SwhTM1I+Jnheyv9LTj1/dPi/qwfc71k6w8KSHGk/oSEmp0HQar0tvlcds5Frc2F9AURk0n/
	Kh9HL+Uu7RjrUGMGMPevdln0xwg7qKUlMi/ML3zdVwAZy6qZwvL6bXJ4ZWkPjuviOH3QFH7MlTA
	0LYkVHuj9VM/JnPdV3v8CBJw6fexbZvq0TdfuPm2ooHQXg3ygpHNLQKsT5SJkZ9ZFMGLfl9j7Rp
	P3q4rTakgbpPRXmzRzPSRr6gcbmIr99yzlI4LU25YVphjed71yemyZLyIC7J9XLCQ1t7iSbGo56
	QSf089VQV6WtQvWRlM2hl4tU1yG/ijQt2bEgv88qKzP/QiGklHDAMM5CKVIJI+4CsrUIQJBVqPz
	njnaJkOeOsIA1tV5qleRFmx0rJO92Z3jsKLj+90DtDzDJLwfqGak+A74x3T+ix3rIo7/tWuIALW
	2a4cgX4GPzf1uQtKNi2pB4=
X-Received: by 2002:a05:6a21:517:b0:3d3:ae0f:5269 with SMTP id adf61e73a8af0-3dd5f72b339mr14364370637.21.1789627159656;
        Wed, 16 Sep 2026 23:39:19 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d76834sm10904606c88.14.2026.09.16.23.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:39:19 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next 0/4] net: resegment oversized TCP GSO skbs
Date: Thu, 17 Sep 2026 14:38:50 +0800
Message-ID: <20260917063854.2011613-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BIG TCP is negotiated per netdevice, so BIG TCP and non-BIG TCP ports can
coexist in one path. When a BIG TCP packet goes to a port without BIG TCP
support, it loses its GSO state and the stack segments it into individual
MSS sized packets, so the port TSO is left unused.

This series cuts an oversized unencapsulated TCP GSO skb into GSO skbs
which fit the device limits instead of single segments, so the per-segment
work stays on the device TSO. On a veth -> bridge -> TAP -> guest
virtio-net path, with BIG TCP enabled on the veth endpoints and left off
in the guest, a single iperf3 TCP flow, six alternating runs per state
(-t 15 -O 5, fixed CPU affinity and port tuple):

  protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
  TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
  TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps

The middle column comes from the same kernel with the bounded path
disabled for the comparison. A BIG TCP hop which feeds a 64 KiB hop loses
69% of the throughput of a path which never enables BIG TCP, and bounded
resegmentation recovers it.

The new path is taken only when the skb is a plain TCP GSO skb which
exceeds gso_max_size or gso_max_segs, the device offloads that GSO type
and has scatter-gather and checksum offload for the protocol, and the
bound leaves room for at least two MSS segments per output skb.
Encapsulated skbs, frag-list skbs, GSO types the device cannot offload and
bounds below two segments keep the existing full segmentation path
unchanged.

The output obeys the GSO feature and limit contract the device already
advertises - gso_size stays at the MSS, gso_segs stays within the bound,
and the frame length stays below gso_max_size - so this needs no new UAPI,
no device state and no driver change, and it is applied automatically.
I considered a per-device switch and decided against it: it would spend
netlink ABI and net_device state on a decision the stack can make from
capabilities the device already advertises, and it would have to be
configured on every device created later.

Patch layout:

  [1/4] factor the device GSO limit check out of gso_features_check()
  [2/4] let the GSO engine bound the MSS segments per output skb
  [3/4] apply that bound to oversized TCP GSO skbs in the TX path
  [4/4] KUnit coverage for the bound, the device limits and the TCP path

1/4 is a preparation patch with no functional change.

Wang Zhan (4):
  net: core: factor out the GSO device limit check
  net: gso: support bounded TCP segmentation
  net: core: resegment oversized TCP GSO skbs
  net: net_test: add tests for bounded GSO segmentation

 drivers/net/tap.c          |   2 +-
 include/linux/netdevice.h  |   4 +-
 include/net/gso.h          |   6 +-
 include/net/udp.h          |   2 +-
 net/core/dev.c             | 123 ++++++++++++++++++--
 net/core/gso.c             |   5 +-
 net/core/net_test.c        | 231 +++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c          |  14 ++-
 net/ipv4/tcp_offload.c     |   3 +-
 net/openvswitch/datapath.c |   2 +-
 10 files changed, 370 insertions(+), 22 deletions(-)


base-commit: 7bc21b740291c06b6437fd7ed7fab2d707b35cff
-- 
2.47.3
