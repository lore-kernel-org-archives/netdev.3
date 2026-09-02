Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884293EB112
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384566; cv=none; b=T25sf0BtMglbrpfcWcMO5M2j4z5+9QWmz9FHht0YvMMtFn+qnGGpKLY7F4ok6zxwXovQmENk+WGMrMXLgUgrk03opmNYzfTCffIOs+xDpMroSmA4pppWoatu8rthHziwKUPWOmM/qkyIMNeRWKZCLdOnSZvGoeISwKegJiDgeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384566; c=relaxed/simple;
	bh=dAbGgP6x+3b3BaLO9L1pUjQPzqGBICTOfgVRYWKJuOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJ/yLR+cwxgg1rmDeu2IdfFdlK5e6TWP9f1xh7SVPK1W6rcgvdLON67mJPZuMw0B+G+otkZ+9kVoCmcugQn9u9EKIp3HE2QjdA+VSihrR7P4zLtjEAy2I0A4S3h/WUB5PVJ6ivRvLp0cX2Co2W85HQcMuqT91awzzGnfy/QOWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NRJyw2Y1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NRJyw2Y1"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92ed19f4d60so37707185a.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788384557; x=1788989357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJLbb3RbAxCQKLzwDVl++Syy1ybQRe9fgWS9wwpr6uU=;
        b=NRJyw2Y1KKiv6hkuO0WJ+ZSjUdAnH3Rr8wrLPBpZ4uhHxMq7SzWhNAzpl2FiJHrHBu
         NK5gOnyrhU5OEawdIeYZC7nPEapqnSB9QZyid2VWNQTGn0dVp90VcUkl0ZB+RftX6gpg
         gC0Yxar9KNwvFtnZb9BtY9lUM/+cAe8ATJ+Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384557; x=1788989357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJLbb3RbAxCQKLzwDVl++Syy1ybQRe9fgWS9wwpr6uU=;
        b=ibeQhJHzZHA75wOvwuVoPj4H7YIdmDe0c5ZnHnOi7rMiTKVKV82fxsn5BLM7V+EQcT
         hRbqMJHcNuBC0VRqqcMt2Vl/raX2LQQO5hsymylc2zuyhsTGkqOlw+pjLGb18tyyFUqy
         rxnDXeDxSThQQ9cjIy+VsQoG1gBEhlyzzQkuxIxeGhXJHbuBOkBMicraBj/4n/Au43Ce
         y92ZSz45LyC5Jv5yWusFbq4rHWU50OeSj6nABsUZ79PCdi0a6TGwm9jwAJxXtPR9wBFn
         uD7bW+TcVQj5+BnbQVfpDFYA9CDAddIPNk1fda9kg40MMEXe5jAgWB58MjVnUWzdw0SU
         XMBA==
X-Gm-Message-State: AFuF++keNuzO+FesJsv7FiHcXB9PWLW9AWrQ9O994xKx2X6M4KTnWCnb
	QnxJr2bzQvBqV98QtXrOoUnC1QkRUDSptlm3fKjx1MFoEr48ztx49yr3EZBkn3gWe+f+F1cK5fS
	iEuIi4w==
X-Gm-Gg: AYBFou0A1yI3A+ILNqmqFAGUBE15gY4jVgFUoF23DYEVXjXzaEew2VpPvD5caD4CWvf
	PmHkI1QVmkv7fb9ZBbdWzL4jpnShIjZS97wBsBQD65Rlu1iLnVFspSWnG8UfWlZJWyJt2T7sBtk
	7IB8ngBkStfIyoi8EQdK0l6XL2ZMKLTQYmtx5tynmui6hfQwAYshU9mA2U9/GY9ARuhy7QOyFDk
	zGqcpwBAsl0pzpD4Zn4UAGU1N5n4DeCG8Vbnf+IUoFDlOMMb0OSGzrMzJrmYYP4YrHir+Ktt5dM
	Msh9G8WAr41G1oucoKH9WBA5wjARNzHlEje4fNaoFa5tHd0RjLmUiVBE8u3x1ghxTh8DAMLCC5q
	1giNOcP+5bnZ9IS5m9S0q9+dN2g9fsyeombeqViWb/VRCMAMil/yxXQzC7qc1jN2V3ocO3EMTIJ
	IiBuAUnMbTMaQpDErv9CS7jKisxf+hb7KYIq6KzZyN/9wzyn2pQIw+tQXCqF7NmFlYyljC7u8ge
	VfE7Ki6gDzUFCfP2tc3V4MoIeDbC98x8IR9Vr+KUXhu5zgo
X-Received: by 2002:a05:620a:aa09:b0:939:a45:8c96 with SMTP id af79cd13be357-9396e07a4d1mr234162285a.19.1788384557277;
        Wed, 02 Sep 2026 14:29:17 -0700 (PDT)
Received: from majuu.waya ([142.159.91.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm27169086d6.2.2026.09.02.14.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:29:16 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vega <vega@nebusec.ai>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 1/3] net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
Date: Wed,  2 Sep 2026 17:29:08 -0400
Message-Id: <QDISC-2899.v2.20260901233641@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com>
References: <QDISC-2899.v2.20260901233641@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several subsystems allocate ring buffers sized by dev->tx_queue_len
with no upper bound. An unprivileged user (via unshare -Urn) can set a
huge tx_queue_len and exhaust global memory with ring allocations:

- pfifo_fast: pfifo_fast_init() and pfifo_fast_change_tx_queue_len()
  allocate 3 skb_array rings of tx_queue_len entries each.
- tun: tun_queue_resize() and the queue-attach path resize ptr_rings
  to tx_queue_len on the NETDEV_CHANGE_TX_QUEUE_LEN notifier.
- tap (macvtap/ipvtap): tap_queue_resize() and tap_init() resize/init
  ptr_rings to tx_queue_len on the same notifier.

netif_change_tx_queue_len() is the single entry point for IFLA_TXQLEN,
sysfs, and the SIOCSIFTXQLEN ioctl. Cap new_len at S16_MAX (32767)
there so the oversized value is rejected at set time. This takes
effect whether the device is up or down, before dev->tx_queue_len is
written, before any notifier fires, and before any ring is allocated.
The "> S16_MAX" check also subsumes the previous unsigned-long
truncation test, and a negative ifr_qlen from the ioctl lands far
above the cap after conversion, so both old failure modes are covered
by the one comparison.

tx_queue_len is ambigious: both a per-ring sizing multiplier and a
default queue-length/limit knob for consumers that allocate
nothing at set time (pfifo/bfifo/gred/plug/sfb limits, htb
direct_qlen, qfq max_classes, teql). 32767 is chosen as the largest
value NLA_POLICY_FULL_RANGE can express for the u32 IFLA_TXQLEN
policy in patch 2/3 while staying a legitimate queue length on
high-BDP paths; the ring-memory trade-off of a shared knob is
disclosed below.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn).
- pfifo_fast: create veth pairs, set tx_queue_len to 500000, attach
  mq+pfifo_fast. ~28 iterations OOMs a 2GB guest.
- tun: create 50 tun devices with IFF_MULTI_QUEUE, set tx_queue_len to
  500000, open 8 queues each. ~1.6GB of ptr_ring allocations OOMs a
  512MB guest.
- tap: same as tun with IFF_TAP. ~960MB OOMs a 512MB guest.
- On the fixed kernel the oversized tx_queue_len is rejected with
  -ERANGE at set time (all four paths: RTM_SETLINK, RTM_NEWLINK
  create, sysfs, ioctl - the latter two via this check, the former
  two via this check and the 2/3 parse policy respectively).

Fixes: 6a643ddb5624 ("net: introduce helper dev_change_tx_queue_len()")
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/netdev/20260828121902.66837-1-jhs@mojatatu.com/
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..1d3fc0a268a5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9982,7 +9982,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 	unsigned int orig_len = dev->tx_queue_len;
 	int res;
 
-	if (new_len != (unsigned int)new_len)
+	if (new_len > S16_MAX)
 		return -ERANGE;
 
 	if (new_len != orig_len) {
-- 
2.43.0
