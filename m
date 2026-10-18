Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81F3C10AD
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314408; cv=none; b=UKODYlg5HnL+WbLEsv1+qXTsKbNFEvo9CCx0RlKUwlh3XLL5GXCm7Q2w6U7of3VmkYzlLCzv9x4VrSUwCDRChdi314PtZoEuvXxhsF+IAvL0VU2eCHm8d5TsoXenP7IiwA31J2uSiwRbqhSeVZNR6ur9M1KLVieAEi4BpFT7W/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314408; c=relaxed/simple;
	bh=S4WKD2aYHcIJH4cVj74AaLH+NGadEsqP/fj+C7Oow+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAYxmdpGCHbNQ7khNyO/6l0fNOTbsXOV0m7i6Y53dN/9Ex5WHiTxjN7MpAauE/ocDz6YhyuzkYp0AsEspvGdxI6+ExRc/qVStHZ/+aEWnJUIX2XktKX4sroywkneoctF3sBHenbqQRzpKUWb7A16iA0JSOA5DgOeBrz3/LR+X6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM7q8MQF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM7q8MQF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab3f899c8aso248330a91.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792314406; x=1792919206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TVLHsdZOGUdB7hYzL6avssJ0uN7VSZZ15QHDi5kS+Rk=;
        b=TM7q8MQFHllndXizixkC2jOrTqKshVMzuzIfmyOeB4TLgCmUuZ7gwIWUFcfPLBKjhu
         noOUScekNgSfZna4hI9kFlv4Q4gGiJIgTt/V5wmGF+/k6lowLE6o7Ipbe7jUfLh3YfVb
         tVQ0PjIsXx/xAXuvLaVyUsFw03UwuEHHRlxSHrKFVx60OGlSqv0mIgobqhBKn0RfDAqu
         qC3NpHd0Pfe6ONHLrszDedxuzXLTMfXUvaUvaYh8PxfzFNBwkA0lml/7o2wf45gEKtYY
         IC2hp0WMBytS5K5NKpkYDS/6xMp5rt1lAzjqvo18Yto4u0EBpensnfluptCMxUKyUbXG
         NOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792314406; x=1792919206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVLHsdZOGUdB7hYzL6avssJ0uN7VSZZ15QHDi5kS+Rk=;
        b=1gGpiwppdxCuqu/lSpI+79nn0MjiHeSLX1Ya8w7Vhp1a2e3YVALYch/DnI+G2ilvno
         d6IKnizhY53ImNH7eR7O2/5+oxY0viNG0xuEh9PiF6XexkyMYaZ0FmKhV6vMEZJOwpVL
         2z89lonwDiZ/rAQ0nVPxraRsL0+DvGEmThrwofOFQgISh41gwc5JBeAm8tK9AEecsMLy
         00EUwSQbycoSvGTfMM1yaezphAm6sCPqHtHNZcwIZknMPEWMW2EoQ2atkf8eDzaSnqF+
         CY384gvwIU7npIBEpU/vwIb62IpPcRmBy/cRgpEUnOYFIeDHsU2ms7dBIBmzfJ+iRClz
         8ubw==
X-Gm-Message-State: AFq9FYLSeOTnG+sXSzpaNThvx4qWN/UwUFqE1VguG2C03Rj3aZKpvxuX
	JWIDGekXvBqoEtU3XnHxLbCnlhtwLZirUDEtYXfJ+Bj2LUvPPOfcGXpcnJFPkQ==
X-Gm-Gg: AYBFou2pdrXJ48FEHUn3/C+YyShCC6MJYXuLa25LlbSNAleV9RE78J0vCaVl8oLLNAo
	4ARPdu9fZgclUr9GjAKDysHdFKrivckKCe19WXPK0gbl1YahdNMHbZQECaR5WtZ9XrNLdDkAl10
	6umFwyGyNW6l4LcXLPKwbEOElEdG4Z2UIq5gs1lbKvj0jWbJtRshHb6KPnawTn1ESZmW68fozSW
	xapor7nB7BbVxCsD5MpKUFAUz1rydim9NPVBxBH0AWmbWv1oQSo/0klHp8Q3YrJvut/Nqa8+Esi
	/xIIJSr2A0hnXjaiD++HWvm7vneDxeV7BvVQ36yroObq3ZVGo4NrRI+s3EKiIdTv2ku6zGzihF9
	IqlI1or7xnez0mCf/+gpqPIeXcV8UdX2uPQPssMLvWEp/vMjhsCCSZ3bdqoiWmqff7HTW4nPFGC
	Hcaw0RkIOJIiR9eMNUHYi6koGUYZq2HonN7NODnXCocXkquGRQT27+njY3qLLcf4B3tMj0Ug1pr
	Vk8BRHLvZXel4OpLTi12ykXnJc7pC5F7aFuKIzjsmUcX24A1TY+H/lT1K0HVygEfak=
X-Received: by 2002:a17:90b:1a87:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3aceec3d0c4mr6800762a91.4.1792314405637;
        Sun, 18 Oct 2026 02:06:45 -0700 (PDT)
Received: from localhost.localdomain ([113.102.237.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm15580675a91.11.2026.10.18.02.06.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 02:06:45 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/3] xfrm: fix vti tunnel device use-after-free across async crypto resumption
Date: Sun, 18 Oct 2026 17:06:35 +0800
Message-ID: <20261018090638.55686-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces the v1/v2 vti/vti6 series and the earlier reference-transfer
rework.

vti_input() and vti6_input_proto() cache the tunnel pointer in the skb
control buffer without taking a reference.  With async crypto the
receive callback runs from the crypto completion, after a possible
device teardown, and dereferences the freed tunnel device.

The input hook takes a reference on the tunnel device when it caches
the tunnel.  A successful receive callback leaves the cached tunnel in
place; xfrm_input() releases the reference on every exit, including
after delivery and on the drop paths.  The error callback only updates
the counters, so the common drop path releases the reference after the
skb has been freed.  IPTFS, which frees the outer skb itself, releases
it through xfrm_input_drop()/xfrm_input_consume().

Patch 3 depends on the first two: it releases the tunnel reference from
the drop path, which needs the receive callback ordering and the address
family set up by patches 1 and 2.

Changes since v3:
- the cached pointer is always a tunnel; the address family selects its
  type, and a non-NULL slot means one device reference is held, so a
  nested or pre-installed tunnel device cannot leak it
- xfrm_input() takes the device out of the skb before
  gro_cells_receive()/transport_finish(), which may consume the skb
- the device reference is dropped only after the skb has been freed,
  including on the error path
- IPTFS passes the state's address family explicitly instead of
  inferring it from the secpath; the consumed skb keeps consume_skb()
  semantics and the drop paths keep their skb drop reason
- drop the xfrmi changes: it re-looks-up the interface and does not
  take part in the reference transfer
- merge the reference and IPTFS changes into one patch so the series
  stays bisectable
- the gro_cells NAPI window is pre-existing and is documented, not
  changed

Runtime evidence (KASAN, aarch64 QEMU):
- VTI async success and error: RTM_DELLINK completes without a KASAN
  report; the unfixed tree reports slab-use-after-free in vti_rcv_cb.
- Async resume with the SA deleted in the crypto window: the reference
  is released and the device is removed; with patch 2 reverted,
  xfrm_input_take_tunnel_dev() warns and unregister_netdevice() waits
  for vti0.
- IPTFS outer-skb free: RTM_DELLINK completes; with the !first_skb
  xfrm_input_drop() reverted to kfree_skb(), the reference leaks and
  unregister_netdevice() waits for vti0.
The IPTFS timer/reorder/state-teardown paths are covered by code audit,
not by a runtime trigger.

Previous versions:
  https://lore.kernel.org/netdev/20261013074610.17808-1-q.h.hack.winter@gmail.com/ (v2)
  https://lore.kernel.org/netdev/20260930090813.73901-1-q.h.hack.winter@gmail.com/ (v1)

Qihang


Qihang (3):
  xfrm: run the receive callback before dropping the skb->dev reference
  xfrm: set the address family before the early invalid-state drop
  xfrm: hold the tunnel device reference across the input path

 net/ipv4/ip_vti.c      |  3 ++
 net/ipv6/ip6_vti.c     |  4 +++
 net/ipv6/xfrm6_input.c |  3 ++
 net/xfrm/xfrm_inout.h  |  4 +++
 net/xfrm/xfrm_input.c  | 74 +++++++++++++++++++++++++++++++++++++++---
 net/xfrm/xfrm_iptfs.c  | 25 +++++++++-----
 6 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.54.0 (Apple Git-157)

