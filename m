Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F37348463
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721243; cv=none; b=HIOOqHDVcyj+D4sL+7CSM1GqiP+annQjOD9MyoHJVwWf5bk9jEoTVnGTvJEmKetxwcj3btL6WAxWH/aaX0vG+qRvEWIwU4R0meaz+fcv+qv6tVGlf81rpQd9hScqLYTMP2uCga2W2BDoAy5DyrfXgy3CJ4KNPK5slby/E0Cz+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721243; c=relaxed/simple;
	bh=l3moDRzfh/3BmmhKfV1BXWgyDQVEtiuNgKocgLNxrFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2Zskw8ZHD/emtOIdInXRKATxH2oYOUm0cQyUWWbLLA+OsMqVqYxjZ7C4MhOD0Yjq1MlGDsyt+yai4VxjzfKBlvnvTiBhxj5gnmDYgzxyF8pfqcxmGLq/qYL4TD8TJFR3mhqb0aaxXQzfg2wEvaToH//gLnNTDIZM3WelXpzPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=UGHOpP+p; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="UGHOpP+p"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d903e972efso1781495ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789721239; x=1790326039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kjb0O/ptTQ0bI5E9YUUB6uAqnT7uPmCFJzyw6iDWb18=;
        b=UGHOpP+pjVMLGnSmO+SVlvWhTN9GZaHNWTai/8PSXJFHeP2ZfFEZ3MW6RYt7XmHyNz
         GlJLxZM2iUFIDvcXi4N4g88JxusrqOyBVFasDdddNqoQVAr+r2vGvbMnq6Kn7xg8zoRM
         7coMN6B72KF0OC+JoI5b0V9ZLLd+2tWr1gfdMzVf1GobcmtOcZ28KYPnAfoeHhaMCol9
         tGCq1Au0v4lxx2zxy/z9lqITx/PwZbwABowTpxOfDb6ecmOMAIijDYfas9oOQTuIlHTU
         9ZnHLm6ZmYhn8XZ9ODPOgBvMiYwxAf5o8dahy0TwCE1rYPH+qMr0gaQ0TLgS/yCIx7mm
         SfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721239; x=1790326039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjb0O/ptTQ0bI5E9YUUB6uAqnT7uPmCFJzyw6iDWb18=;
        b=QXfglvSNKq0pdQWv8xeNKa99AUnB7E+lUtO19+2m28LJ4if8h50D1hScJu//zchOcu
         2s3Aja3IIMItdSzzD3TF7U4uuiLGJ9e13m6SuTjf3miAr/mXlr13VxkGR4tedVoCgAxb
         izIwg2Dlbd9WPrKiNpT5yhMXQWeKdsz+mGHiLX0i8Y1DQDozeRoh32OyHy8augowGorN
         QOHVcF0Mt+hbMPfD452CngHjQp19QnGBq30ze57eIN0YW4m0KIbQvBo//j3mqRSMuaPo
         aPIbifdwowJKbsBJE9+50JOU8115JBXIyC1ByrjawG+68p9aBlO/6HzzE7OykSfDTTsj
         s0AA==
X-Gm-Message-State: AFuF++nmGsbCszlduy22YaZfQ99qHHEUJl5SqYum6VBe0vVO4fk6D3PT
	gWcbe6yCOOpPAR0CvtusBzyfIE9D7AXVNQQONizo8DE2bwobm2McehjfVLIxLRw/JfCJdwO9Z6u
	ZTHGXP2El787M/ALhIGNYN8fdSqrx3iKJgTp807dvRFAPbcaiR4R0CsnQ68XXRZUC/ITXFb5kAq
	50hzXd
X-Gm-Gg: AYBFou0EVQ0VP15eIn2RiXl/Qp0/pZZPb+9mmPElbl400y/h7Pi7XPb6dKA15Pv31EL
	vgLxW50rrruwMqEMQFxd1WM+QAvt14uPMC3AcOXXdQrkO0H76l6b2MW/cznI941F9VfEjw1ZanG
	Q27+GMbXXJAVJnlJ6TgHX4N47IlZ1UacBPuT8/Gvnvi1Ok0p89BelBRwkS7Ah0bbgdescWwKR2R
	KQ+Gz+m9RpCLzoBosNlBSj/UDutfl9rmznMBStS/67nQTMYKb/oKAir0khTbxgXmKoAVnRN0j67
	7u4F5frju18IaD2q8TfdVs1kcODjaA9pRdMNzBSBzoOgqiFShqatLAwq4Vw5rLk9mQWA55nDEDa
	LTzQk4Aqc2fP3CySUfcGGsyKPR2KJUGRG44IrynBmxS4j98pUTkla//L1/rvInHaav/RGoUtOEa
	5XUGxoTIGh33RrbpVtgNBYsgxiKA0GpC7NfcJLVhVSgp27fBEBVL1olUJXCro1eHjF+o8HC213G
	qma9riZKBI=
X-Received: by 2002:a05:6a21:1b81:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3dd8c3d3acfmr4145967637.4.1789721238917;
        Fri, 18 Sep 2026 01:47:18 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm2578095eec.22.2026.09.18.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:47:18 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 0/4] net: resegment oversized TCP GSO skbs
Date: Fri, 18 Sep 2026 16:46:47 +0800
Message-ID: <20260918084651.3022878-1-wang.zhan@smartx.com>
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

v2:
- patch 2 and patch 4: fix the lines over 80 columns reported by checkpatch
- patch 4: use KUNIT_ASSERT_TRUE() for the __be16 check, EQ warns in sparse
- Cc the full get_maintainer list (patch 2 was missing dev@openvswitch.org)
v1: https://lore.kernel.org/20260917063854.2011613-1-wang.zhan@smartx.com/

Wang Zhan (4):
  net: core: factor out the GSO device limit check
  net: gso: support bounded TCP segmentation
  net: core: resegment oversized TCP GSO skbs
  net: net_test: add tests for bounded GSO segmentation

 drivers/net/tap.c          |   3 +-
 include/linux/netdevice.h  |   4 +-
 include/net/gso.h          |   6 +-
 include/net/udp.h          |   2 +-
 net/core/dev.c             | 123 +++++++++++++++++--
 net/core/gso.c             |   5 +-
 net/core/net_test.c        | 243 +++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c          |  14 ++-
 net/ipv4/tcp_offload.c     |   3 +-
 net/openvswitch/datapath.c |   2 +-
 10 files changed, 383 insertions(+), 22 deletions(-)


base-commit: 4bb9710c6a68d35207f123aef55dcd50e7195ec5
-- 
2.47.3
