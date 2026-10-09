Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFA4F472E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576900; cv=none; b=fgNe10l9gI3zjR+hR3Jp6w5QcZ3yJ5PwZ/HT9r2p8UrDDn/DoGbrNcekrBMVshHxVsYDy6PvFHd0jmOj0Xj7EhdKGflU4b7rMqg1Cen65SD7ELzPuq6j3r48AlILHg1N4ubOUs5iX0dj7zExJ7+Mog6mX4EkoYKz2ncRT5JjOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576900; c=relaxed/simple;
	bh=vpSF9E5Y5ggCXdC7ttEalv4ViwRw4eLOK1WsVdCM0zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ed4NJNTm1QAsmr7bFlf8vKfuczrzk/QQnfgHCmJL9R1/uL6t3+GH0QxE5aRjzXFEOQTyNa1kNRfbamO3wPamquOb7NgUyhsH5so3DSyKvF7yNPVtXj4AFyIU6KP4FSKyKkFjlwS5N9lP7OxaYwcKT0JfxfkRFHSn6Z+nmCMQ8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=a1Cz1glg; arc=none smtp.client-ip=74.125.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="a1Cz1glg"
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-35178db8192so14053eec.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791576898; x=1792181698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KuoCU3FLzxs/pxFBGf8JxfZ2rnZfcXeJRrZEEpqh2s8=;
        b=a1Cz1glglQv8QVzt/iZmiN2PIa2CgLjBfceB6vszaePmSc1UQqg29TCvtDKzjzvgrl
         YoVFVBYiz3Mo3QVF88n1sKCVg2wDoeidKlPVWhGbQ7y1ualcwRqNgRRqcWYLEmYPgV3f
         9Uk9xE/OQHU+2c3ppYIJCt1GuSQpyYVXSArtHG8TzYzpV91y1J1tV2qHPS7XeetnJzI9
         PutZ/244e0O7b6ukm89Jdv0lAaANLtNhhlFenWFBWJyNhH0uOtcy7HgTfKIQfJ/lB6/V
         YAaDNv92zIEtLdiCY1YS+Yb1ZS8kT3phGrlcqyUe5vU1pyS/vtWuInbp5k4pO67XGHeK
         fPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576898; x=1792181698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KuoCU3FLzxs/pxFBGf8JxfZ2rnZfcXeJRrZEEpqh2s8=;
        b=Bhz3N7HO59Tcjk6JRVs4XU/qSL55JpMzw51PB+VvucmP4zWrMif6U3/L273NsJreaQ
         QD/P9LoY/bo9EQp5Xi2C6Biu+IahTLQ0mGyLnOMBtNIpQOMlaXo92RQXTFRqVfPnUvWF
         vLHugWPBg9zipu4X0XshHRj3mdVa7H/txwNyglPb8dUsRl+RkeS+dD3gjmwK7IgiBuxu
         iOwjYiK9sKFvOjXAZCyj+vswlRaZ6fJ3DlfDvFUE4ubeD8A96cXQtDry34N8RhTyHhoz
         EHwKSrmaRU3jx9bTl17Rljp5mz9cY053NLT3Js4bw583RSIGRtJymCcLJg43KtOi79il
         TP3Q==
X-Gm-Message-State: AFuF++mmqw+KTARRD5TRqFNYmowxazCdtSA1eYtiDesdszPZ/4zsmDUn
	DRPKGRG/C0cf34fjSbgjnCuKrJFysbtnxxwCg773l8MH/lm9IutRYMPIj8vdZ3PMco0=
X-Gm-Gg: AYBFou2RO/EdRMS0kIR0Wo08RJLYvSiOAWmFZVuGkHZgGue2zLZeNfIhUiEV2YGgSVz
	Z+HED+bCtDjgGC9zmZY+naLho7shRYDVTZLibTvFlyvFmOs3b4hZHY99CJ08TtYrNf3rj0WW9S8
	95rZHUEHewkXFc4ySkwRzz+HN0TJoaXypXMpN+Q9HSY1gBp77SCz+53AfPW1hzJ97ZnQfGeSnBp
	CaDGJ8Id1C/xj89O8RSe6V9qsnQHWQ4iW9I469tKNDvX0emrNewviOgBKV2za83W3+lm2389Mh8
	omBRvI5zFKUL84rjy86RloJ1d3S7XT5VbHr1QO8TWAvWMQAGSEqE2zRqgfyXkE77ACcD22/r3Ly
	YYeHyvIVRAHpLmduD309eVaw2t47SRGbKaf2zZuz042ir8N9HrSbq9Sr4YtmhLzjueSIBfixyFf
	GbOq2423el94G1R0QvRId+1No1oFVUyCD/9eX8JZztpiG5aAR+1/JyT7SAwG27Q5tf0tcETfLOR
	7FESDd4dZ8SudEnk2l+7u5/IzdxSDP0ALVdf58r
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id 5a478bee46e88-3537df95584mr5251326eec.16.1791576897822;
        Fri, 09 Oct 2026 13:14:57 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm8994643eec.5.2026.10.09.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:14:57 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 0/3] amt: fix relay tunnel keying and unauthenticated-Request DoS
Date: Fri,  9 Oct 2026 20:14:51 +0000
Message-ID: <20261009201455.1904698-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes related problems in the AMT relay in
drivers/net/amt.c. The relay creates and mutates per-tunnel state in
response to AMT Request messages whose source is never validated, so a
spoofed-source flood exhausts the tunnel table and reflects Membership
Queries at arbitrary addresses. The same code keys tunnels on the source
address alone, so two gateways behind one NAT collide.

Reported privately to security@kernel.org first. The security team
determined there is no memory-safety exposure and no embargo is needed,
and asked that the fix be posted here in the open with Taehee Yoo in Cc.

Patches 1 and 3 carry Fixes: cbc21dc1cfe9. Patch 3 is the core fix: the
relay now answers a Request statelessly (it computes the response MAC
and emits the Query without allocating a tunnel) and only commits tunnel
state once the gateway echoes the nonce+MAC in an Update. A spoofed
source cannot complete that exchange, so it allocates nothing.

Testing: booted net at commit 6d25ffca055a ("cipso: adjust cached
option offsets when removing CIPSO") plus this series (arm64, QEMU via
virtme-ng) with CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y,
CONFIG_PROVE_RCU=y and CONFIG_DEBUG_LIST=y on top of
tools/testing/selftests/net/config. amt.sh passes all six tests,
including both forwarding-torture cases, with no KASAN, lockdep or RCU
reports, and debug_locks stays 1. Every case completes a real gateway
handshake, so this exercises the stateless Request path and the MAC
check on Update. drivers/net/amt.c and include/net/amt.h are unchanged
between that commit and the base-commit below.

A companion change bounds the number of verified tunnels admitted per
source address. It adds a new netlink attribute and so targets net-next
as a separate posting, not part of this series. One note on its default:
a per-source cap closes the non-spoofing exhaustion path (one host, many
real handshakes) that this series does not, but a low fixed default is
wrong behind carrier-grade NAT, where many independent subscribers share
one public address and would be refused past the cap. The net-next
posting sets the default accordingly and documents the CGNAT case; this
series does not depend on that cap and closes the spoofing primitive on
its own.

Changes in v2:
- Drop v1 patch 2/4 ("amt: send the relay General Query directly
  instead of via dev_queue_xmit"). The same fix is already in net as
  commit afae89de73dd ("amt: send the relay's General Query directly
  from the receive path"). v1 was generated against v7.1 and did not
  apply to net.
- Rebase onto net. In patch 1, the port check uses the header fields
  that amt_update_handler() now snapshots before the pull. In patch 3,
  the Query senders keep that commit's tx_dropped accounting and take
  the destination by value.
- Redo the testing on net. The forwarding-torture subtests now run to
  completion.
v1: https://lore.kernel.org/netdev/20261008003606.3666617-1-omar@blockcast.net/

Omar Ramadan (3):
  amt: key relay tunnel state on the (address, port) endpoint, not the
    address
  amt: make pre-query report drops visible
  amt: do not create tunnel state for unauthenticated Requests

 drivers/net/amt.c | 266 +++++++++++++++++++++++++++++++---------------
 include/net/amt.h |  11 +-
 2 files changed, 185 insertions(+), 92 deletions(-)


base-commit: 37f12441f557468a56c1e27790413aa78c82afa2
-- 
2.47.3

