Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC91C3F0C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454027; cv=none; b=X2WDeBpvXmJLn7f6WQ1/IolP0abF1Of5ZA4XF0ZYa8GJ2kw4kI91Qa6JoxEIf0citydtDjC1sImzL7C4mlxP9lyU7JGNIQMcZjOnGAJGnFUTkeeka5nXM7i1Jat6LlSKZUBKwyibaTdag35FP4iyvwJFlQDmTXggPP0GfFDDGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454027; c=relaxed/simple;
	bh=foj0QP/P68FpLf6MWPE4e5L6fJYCtkURtne05Z45eQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfMhR0QPmLrqe48Sc59Dej5IOzwEzlPPKnSmVlt2ifD4q5DFduU/+j1bVamLp7s7n5KsRM9RyTtOZl+mnOxHYUaLGeJf5yLSD1018WlVvaCa7Of6qtMwFF5TaMpRfqt0XfcsPBrSWqYzk1ANxaeOZsNDxm0SDdV20T6aELehC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=J65ZId3A; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="J65ZId3A"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15354aa70e8so1090418c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791454023; x=1792058823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FR0THU23djkd8GYvad1H8aIsJb9s7FKek/d1I7G3/vA=;
        b=J65ZId3A/UwP8+xoAjMyNaTxtWr8AdsnOF0B+Io5O4vRG7k0O7mdoX3guBGjLClSD/
         x42suRJ3/ta8CElSt42LQm3YiNmHOOjYIOkPEtPTSwZVqibTn+hhJau7y9l5mGrW9CWA
         /F0dc6X9+q5a0UWy3uls/n3LB0RwBZlQ7ZGG8cKnyM9bQEm2SCTJJzJSTvvrb8rbLzuc
         cGKG/F8EaOGYuw1esdO0jj5KoXzNVJ0CB2mZutnLi2BYAJ4xtoH9PCt04eFwQjW9Mx6V
         9PpqwwUAFbvt0FGUrnkYtfQODg2UNMBGACc+006pMrhQDaKrN8zrwdaatDYLVYdBQrlw
         sgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454023; x=1792058823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FR0THU23djkd8GYvad1H8aIsJb9s7FKek/d1I7G3/vA=;
        b=RntKCQz6KgWggQemr6sVpKXyHDVfFZ4vDHKJPbPutUEzl3CUBNIvngsfH7sFn0CYbR
         TTdkTsFTEFVYVhmn3qknGcZKxzhg33V5Ye/0XaHhe8jl3aD4pDniAyL73x2A+Jl/+uHD
         xjfuBEyD9sQRoS56YBSFz3GTgpsxx6MRsD7h394LKaioFMcgjY6EmDhvH59Cx0iltisT
         +xCVp+R98K1ojOaKKFEowpfeJj7uXLP+a/tMq0AOBCXJ64k4hAtpLKEXLSGzrxG7tBGO
         NMw0noq51MzNYDNz/0nNjfahFdC29fcAOnPBpnACPn4BGvCVSG9pWNJCwM0otVbKh+Ar
         P0Tg==
X-Gm-Message-State: AFuF++kIg5PA8m5eIqgrCGjlgFOq2Mth6M43NqCmg3fnsyWFkbJhSrVX
	m5ZJe2sWf4HnCakXmiveKRLogslG8cX1Z5p6fA/jm9D0PMPG2n0TAV7J2IiZkm/m4IGjLac9N1T
	mDkHRBeCpcjf79tjUAUUXXfhW32Tiqr/XTRN9J78X8uSgepmbASOthmZgfwoJqSYI9wgbZMgz
X-Gm-Gg: AYBFou23WFfMY/ae7eTpBhbKG1n4Ng1kOfULgKg0WoyO8UgLWKvaABb6grwFdaz/AKf
	qP1tgQ3lzBWMNwfJMN44XZoc85B3eaJTIbt/t0XI83xmzWFL6nEAkgPsDZXBo84KSCan2RAZOMj
	Bxepykc3X/nc5tWxkapTMe0/XoYWeCaP2ZfJRAsiFWa7eaHzc5aF4Svr7XgFTvKnhdNBm7ue7S6
	F4fG90a0nO8P8ksHCIgSPu4J93GELtewASfRX/DUjqwKK6B70yrfJVsn6g3NnMq1ra6Z5CxYeih
	aGD7WczgrSH9og6mgj1xE0JCpABgDv4Dyc+5SHoyyQihnjuUk+09ajFTw9/jOdrXYSJUpE8F6Pw
	27IUe1XFM4EsRQmqU6hIrLyKU44kN/s1V2QlrFhhEPNJUnJbwbWbnqkZTtc3UMKA2YMC+KQi633
	mH3wdZr8mZZ4kcr4kR+rV+4i1EKBk7gBpM53Al1hWaHfAF8w99f0dzbE+TUhY/hjfC3tOx+wXuZ
	jApIEbxRkRJ
X-Received: by 2002:a05:701b:450a:10b0:143:296a:3ed with SMTP id a92af1059eb24-162076c5c31mr6434615c88.24.1791454022753;
        Thu, 08 Oct 2026 03:07:02 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm14200933c88.12.2026.10.08.03.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:07:02 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v5 0/6] net: re-segment oversized TCP GSO skbs
Date: Thu,  8 Oct 2026 18:06:45 +0800
Message-ID: <20261008100651.2534957-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BIG TCP is negotiated per netdevice, so BIG TCP and non-BIG TCP ports can
coexist in one path.  When an skb exceeds the GSO limits of the port it is
sent to, it loses its GSO feature mask and is segmented into individual MSS
sized packets, which that port then sends without TSO.

This series cuts such a TCP GSO skb into GSO skbs which fit the device
limits instead, so the rest of the path keeps using TSO.  On a
veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP enabled on the
veth endpoints and left off in the guest, a single iperf3 TCP flow, six
alternating runs per state (-t 15 -O 5, fixed CPU affinity and port tuple):

  protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
  TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
  TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps

The middle column is the same tree with the re-segmentation disabled.  A
BIG TCP hop which feeds a 64 KiB hop loses 69% of the throughput of a path
which never enables BIG TCP; re-segmentation recovers it.

1/6 moves the GSO size limit lookup into dev.c and makes it follow the
packet's L3 protocol, so where the tag sits does not decide which limit
applies.  2/6 is the preparation which lets the limit tests be skipped for
one caller, and carries no functional change.  3/6 lets the GSO engine
group several MSS into one output skb, and 4/6 clears the whole GSO state
of the last output of such a group.

The new path is taken only when the skb is an unencapsulated TCP GSO skb
without a frag_list, it exceeds gso_max_size or gso_max_segs, and the
device offloads that GSO type.  Everything else keeps today's segmentation.

The output obeys the GSO feature and limit contract the device already
advertises, so this needs no new UAPI, no device state and no driver
change, and it applies automatically.  max_segs only says how the output is
grouped; an over-limit skb pays one extra ndo_features_check() in exchange
for staying a GSO skb.

Alternatives considered:

  - The caller could set skb_shinfo(skb)->gso_size to ~64K and adjust the
    gso bits in the shared info afterwards, which would need
    skb_unclone(), a repeat of the grouping logic skb_segment() already
    has, and a recomputed IPv4 ID for the DF=0 case.

Patch layout:

  [1/6] the GSO size limit follows the packet's L3 protocol
  [2/6] factor the device limit check out of gso_features_check()
  [3/6] let the GSO engine group several MSS into one output skb
  [4/6] clear the whole GSO state of the last output segment
  [5/6] re-segment oversized TCP GSO skbs in the TX path
  [6/6] KUnit coverage for re-segmentation

---

v5:
- patch 3: make max_segs a u8, skb_gso_cb has one byte left
- patch 3: only warn about the input segment count without max_segs
- patch 4: new, clear the whole GSO state of the last output segment
- patch 6: add a plain-tail case, drop the TCP path tests
v4: https://lore.kernel.org/20260930111526.2183107-1-wang.zhan@smartx.com/
v3: https://lore.kernel.org/20260928044102.1004310-1-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-1-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-1-wang.zhan@smartx.com/

Wang Zhan (6):
  net: core: use the packet's L3 protocol for the GSO size limit
  net: core: factor out the GSO device limit check
  net: gso: support re-segmentation of TCP GSO skbs
  net: gso: clear the GSO state of the last output segment
  net: core: re-segment oversized TCP GSO skbs
  net: net_test: add tests for TCP re-segmentation

 drivers/net/tap.c          |  3 +-
 include/linux/netdevice.h  | 18 ++++----
 include/net/gso.h          |  7 ++-
 include/net/udp.h          |  2 +-
 net/core/dev.c             | 92 +++++++++++++++++++++++++++++++++-----
 net/core/gso.c             |  6 ++-
 net/core/net_test.c        | 87 +++++++++++++++++++++++++++++++++++
 net/core/skbuff.c          | 12 +++--
 net/openvswitch/datapath.c |  2 +-
 9 files changed, 198 insertions(+), 31 deletions(-)


base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.47.3
