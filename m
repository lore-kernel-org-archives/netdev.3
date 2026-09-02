Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907646D55A
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351043; cv=none; b=sPj+H7I0Dt17vv7Dtzi+yi3gdfD5zfeQdyCIfi9OAwSWkh3rRl9Bhy48Q0vJiTDnSPeP6boWNdfJE2O7hV0tABFlxauag6HsTFxO1vJCPdUNIU/75Q/tqcCYATJE9mbxlrr4vmNuX9Knq9mjakBYc7RrHg04noapsx0T7eeQOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351043; c=relaxed/simple;
	bh=Y1wV/sdJ0I2tS5+afhbpaQktFXztVIMcXeD3dCZ+IQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZtCibgb4ac1sMkMSrkDoNlgcdkJpe0PvXYzrJfgKaCMsm3wYhLKUmVJY3uqXlzokXOesNCHG7xNu0Ktn26SJ4Xd+pI6u9PYLIVdkJzu6SWkkqe3GTRG4uG0vZoBKXyF3UCFm3O/Q7C9iPlCunNNscnKy/0iX4dRrto2uq7FlcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYRk468b; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYRk468b"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-851cbd64814so314572b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351037; x=1788955837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWQGAkWlUzQFpRysKqIStAsuXjs0d0k3Dcf5bsCh5wU=;
        b=pYRk468bicRkTW76QtyZ6Y629st3X8z7UTacI8+akxVc2J0McuOkvOTC7C/epbCIeh
         oEp+kPcNyC5aXQJRLBQvDeDFAoQQWt2ZWLKu+I+DeZqsVZ6mKKr5khuN833jsIgLWV+K
         zJRU6aKuhw78FgTaTwzTicxVwlfBAr8AfH8QDt9MZuNcMSZTZQntJxtNGWYhZTy0ePfz
         8ANLomGoVVSPwJ6Djb6Y5EIBhw7Eo/EG8mHF65/0V26KyH74o1DG+YU1p8eFphHqW5vK
         HaZbu2cvB7ofBYT+KdLvIkr7GTo7nX/fyc355nyOizmCRFu63hd0nisBF2fcPVknu4is
         +hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351037; x=1788955837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWQGAkWlUzQFpRysKqIStAsuXjs0d0k3Dcf5bsCh5wU=;
        b=oSvdICjxI2xvSOlJs1oEXoGck2nYD5p/WJWnMg67WasSZp4uahec+ghYa53GSTlSya
         Db3CkrMhof85mk6QM7t0g3H4ZIji7sZi+ThufjXo1Gp0VEDgBPS8id5oeW1rFmnGYxOL
         2q3dHW5yGvXTn1AcoYfIUbSoSEbwWzxRzjM4OaSfaMXAyo1PPBBUsJ3afJf/klFI8EqY
         1u+nywgTekvh6WuglMYNs62H/6dSunGpXxIO484wEPSdxcawxGOPtHVqNSRalfKv6C7a
         2NnbVQR9CHIvOMx6/j1tVUTmR0rmN7YuucBxp4LJiEYTwR/G30pgQAMHFK/zKb+YQ+GA
         MT2A==
X-Forwarded-Encrypted: i=1; AKwUvBz+ptygbXGe1sB35z9rMz3bykwk9xaDlv+QYSMU4Hno/vqmvLNvap/6eBrFJKqHGIm4otYEmRA=@vger.kernel.org
X-Gm-Message-State: AFuF++kt7AjLW973jFlDtW4HZIOt7BoyJ9r2/CozdG8JB4kZ/ltYy+EX
	289qd7/q+tpVXvhs6k5LYUcLWJ3oKiu3IvH/1IQ0hIhD01M6rTz9KqB5
X-Gm-Gg: AYBFou1NyY+a81HfZT/Oev++sAMtSdf5PHbQOOFz9ahfPllJ8WfAsNfcnYdPp19QBfC
	Eh/hv6iyxm5MT0haGN40ec/liLqJ02NHLd2sFKsqiNIkfGT8ynhFuWSxOV6yifZg8PVuBokG7R4
	C9XVraPp62oUN3KNHXcEv9EueXnuiYw0LQely0ng3fINyYu6Z/L9SisyWa/+vf9mOweCpsVDZcR
	9W3yeW6ZVEO3Y+J3FkpLQYmOeDT/T0d+nvzmu3Noupp0jcu0itlGE4YQY1D1r0p990sX+leHXGc
	iqIRynhv/k5nq4kfuLo4kqMV0EJJF7DtkLqWxBV4nzZw7aFfrsilfia7UvuZE6tULYgTsCVfEbR
	Wo9M0xoOVeeTdjyNCpIrfv6afjUaD/0CCEyDUUOR3RA9PvE/VEP3QiZNFvwonPKYkgX8Fu481c9
	SPqZC9kE+NKa/aDYGTuaMtBBxoveMbCmsUgN7bWVLEfpe8uv/DJTL1EMg7CqdwVTBqyzgwqPwu4
	g6NTCwjWEAKk9ZiBxPBbSJToh8B3xOV1Z2YhVAEcqn+JimEZUcnuPkWOaMCfQKA1OQ9czVKtN8W
	vW4N+iShE6xofhOq36B1CPDH9GuSSS3YdHQG/Sh1NZAnBJm6
X-Received: by 2002:a05:6a00:4c85:b0:846:8b22:4933 with SMTP id d2e1a72fcca58-85ed94b7407mr7471210b3a.17.1788351036779;
        Wed, 02 Sep 2026 05:10:36 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85da342023asm1300084b3a.0.2026.09.02.05.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:10:35 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Subject: [PATCH net v3] xsk: set network header on skb at generic transmit
Date: Wed,  2 Sep 2026 20:10:27 +0800
Message-Id: <20260902121028.74092-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When constructing an skb in the XSK generic transmit path, neither
xsk_build_skb() nor xsk_build_skb_zerocopy() calls
skb_reset_network_header(). After __finalize_skb_around(), the
network_header offset defaults to 0 (pointing to skb->head). The
subsequent skb_reserve(skb, hr) moves skb->data forward by hr bytes,
but leaves network_header still at 0. This makes skb_network_offset()
return a negative value (-hr).

When such an skb reaches a tunnel driver like ipgre_xmit(), the call
chain pskb_inet_may_pull() -> pskb_network_may_pull_reason() computes:

    pskb_may_pull_reason(skb, skb_network_offset(skb) + nhlen)

The negative int from skb_network_offset() is implicitly promoted to
unsigned int, wrapping around to a huge value. This triggers the
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason().

Call trace from syzkaller:
  ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
  __netdev_start_xmit include/linux/netdevice.h:5400
  netdev_start_xmit include/linux/netdevice.h:5409
  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
  __xsk_generic_xmit net/xdp/xsk.c:1079
  xsk_generic_xmit+0x277a/0x40a0 net/xdp/xsk.c:1120

Reset the network header so skb_network_offset() is valid (0). Unlike
AF_PACKET, AF_XDP does not need to locate the real L2/L3 boundary: an
AF_XDP frame is always a complete, opaque blob from userspace.
AF_PACKET only cares about the boundary because it can cook an L2 header
itself (SOCK_DGRAM) and supports GSO/checksum offload; none of that
applies here, where the frame is sent as-is via __dev_direct_xmit().
So resetting the network header is enough to restore the invariant and
avoid the crash.

Fixes: 3914d88f7608 ("xsk: Respect device's headroom and tailroom on generic xmit path")
Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
V3
Link: https://lore.kernel.org/all/20260901083325.3445-1-kerneljasonxing@gmail.com/
1. remove the misleading description about af_packet

V2
Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/
1. add more clarification about why we don't probe the header like packet at
the end of the commit message (Jakub)
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..2077bb6299ca 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
 {
 	int err;
 
+	skb_reset_network_header(skb);
+
 	err = xsk_skb_destructor_set_addr(skb, addr);
 	if (unlikely(err))
 		return err;
-- 
2.43.5

