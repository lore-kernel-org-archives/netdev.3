Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598095;
	b=cEXsghFNLvarLzAdsAF5KkqLDQd43IaSOy//F0fXtziDdVeuN8DR6RjgtXa6YaWky7sv
	 ep78LKO4SjvU9jBMsoyZL+LRTmWHc3BJUUIrrxrRUmTQrwsF8a3eHUpRoaVwaKEUdZWhp
	 OHuyuPWBuF1yZJnzmzuHGdlBhAm1giOLx+gZMzJKD+dZ0HV5l2cIH1RdQXX7tec47xtvk
	 PkWpgPYeybCr4K0qJKKt+NahSg0m93ukUS9ks4cLdnfr+M/sxYQnlMEYlRf32mGSeESgD
	 yC1dWxCCMa/CQ43yDKZbBCrQfbw0+enHL0LrCuOveW3BKM0OgCHj16cD8yKu1HmMqqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=if6TsmMO0l2mME0Tfwvz9OCFzNyd7L9Z9uq0gv3oGvI=;
	b=nz6CpZythVVkNZ6v3MxMUQbKr8hQYSgcWo5DXFi+FD1qEEc+DnYhNa8BgAOhLlv7Mdrg
	 9HMqnXaHvTvxLy2uNuVESofbt6XbAv+1gt+WHoN3Za6slJ27vguwMMTMXVXIOHTGZIZtZ
	 Pv2uF5QFh3L+00FyuYV3EKkzgGeB4p6a1hDMj0bzKTkQhs1zYZ3NvYHQIxELTuQz5DuKD
	 irhxjjatWVLeWlDjqxSPThRGYZNyvKwtOBTHe55+OoAzaMEdpJWMRzifUAVyJ+sDm4VdS
	 GFVSRSzuJ6h9LzMXz3x5QjraHUDC+nBlXNkK6cZrBlBwqUCYD1s8Sz3vAJ1lNlr7uRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ISfz/zdG";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C40606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C40606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ISfz/zdG
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso400350b3a.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598095; x=1793202895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=if6TsmMO0l2mME0Tfwvz9OCFzNyd7L9Z9uq0gv3oGvI=;
        b=ISfz/zdGaUAi2cIYGldhm87WGz/D4Oy8Th1U0HLzwQPzZvt2jXkakFquqzKOxEF8uS
         EwfksyVCQQy2FKLNcIbO1rCBj/PlzXxRXzONV83M7xWS1W7F/qNnHfNyBS9l263zfr92
         A24yV8qVyykYTxfQEGWl1mkxFuubALcei+uuiS6qh4d5ea1rYbrue/sINCSXx6jeW56K
         auDGsXgwz7R5/u6YLQuCFTAQUTCPoelZYpti9H5jE2G4LUU6NWDjwHU/Twjg74gf368T
         otgJmCZdl0t/a1FCVJmo/Oelz88B3ZBTJnCtgRebBmrXiafFMtV6LvVrtvKp9DIg82jV
         vwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598095; x=1793202895;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=if6TsmMO0l2mME0Tfwvz9OCFzNyd7L9Z9uq0gv3oGvI=;
        b=gpJwMqO6OAE+ZqzqnrCWnJaY3x724wB2EN0i5hAHetzf2TBW3bvuwLJcQDm9zodrxP
         /rjAYApXeBQXPOP4hHRs0fnti7NyaPphEiC4C5suacE0JfLZz5reAnnQQ7fsVtbPLhcn
         V0cwSJizrlntbtM9Gz5dpHYCdmXPbi1yF1vgxd58/ak+M0EfutNloiA4B6ul7pbiMPym
         ai88Ntg60WcoF6O+5ad71qZYBzgxXveSzSS6C8WQDCcmUBRKQAEHXbewHkMPxSjuJ0VY
         16/eSKdkj8Qsd+CjWKCelINP6fZqTrQIS7T++q+qRCE7OvwAQTjf1DoPZ/lhrWZCStcJ
         GIWA==
X-Gm-Message-State: AFq9FYK5PVmgUVk0bkBCyVncl8Lcsk79TMwcnHANuE5LrddDAkfE7mDi
	TFBquugyoLdC3ERx01Fj8JEBX+neF/NN3xObDmhr1/fp6tC9qs0xaRxnyqqASQ==
X-Gm-Gg: AYBFou1CVuV3X5vGXseIgb6ji9LwCdKyvkrAZOaWbPgKMOMVfXPKfj7fo2AMC5VZ1oh
	jM5pAYdc6snqPa89MpALGD09hdDibtbvXZiNS4U0vaNAzNNTQptKHOxTHH/cU7zkH7FQEA5RNaY
	0dbp4iMseBIJ3aY2duewsoZ1nbMRb0Mh2XG8FF7IYddRPFQDQgsQUlK5WT1pFyrZVK5Bh2imTWo
	7RoDAFog66laR27C1N1VSR3DeyR3XdS28GUep8ojdcoaWRRclsbZ7VVTi8koefHOw/olA8e7X42
	rKet8sxrm6gUUZIZdSAyeyx4wRnSm0anxMEjKMfszmd17Mux0xWsdwSKSNec5YtlSgWgsFBrStN
	xe9gMcmoHvJdz+YLPFfR26/JXTwwKGOHKRUeJxAiLXY2nfa4x96KYQMDO1Reanx4l7ebQnrEk0Y
	UPItZDewKNI5BjrSWIGJG20pgkuJ7zcYfNpZMm8goIcIGqYvVft+DA/j3+ZfuYhd6tkZp5iAL7v
	rEivjsBCyaWBvadyzsgPWtyEMoaFmv9yl3E66rRo4Sz6b6NB5FwG/ziF7pWyfAJA1EIrNBlEKGN
	k4KB+zSSWriVk0H6eEY+Tl9qLT9vFA==
X-Received: by 2002:a05:6a00:418f:b0:890:a995:1f4f with SMTP id d2e1a72fcca58-8a089cd94a1mr1959456b3a.20.1792598094803;
        Wed, 21 Oct 2026 08:54:54 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895cce93sm1090647b3a.30.2026.10.21.08.54.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:54:54 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net/sched: re-cap skb->queue_mapping before indexing dev->_tx[]
Date: Wed, 21 Oct 2026 23:54:50 +0800
Message-Id: <20261021155450.66934-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

qdisc_restart() computes txq = skb_get_tx_queue(dev, skb), which indexes
dev->_tx[] with skb->queue_mapping and no bound.  A tc BPF program
attached to a transmit qdisc can store an arbitrary __sk_buff.queue_mapping
after the tx queue was picked; that store is not re-capped on this path
(the existing cap in netdev_tx_queue_mapping() only covers the
skip_txqueue path), so an out-of-range mapping indexes past dev->_tx[]:

  BUG: KASAN: slab-out-of-bounds in sch_direct_xmit+0x744/0x89c
  Read of size 8 at addr ffff00000e0802d0 by task A-254-2_S4/100
   sch_direct_xmit+0x744/0x89c
   __qdisc_run+0x34c/0x1d04
   __dev_queue_xmit+0x1aec/0x306c
  Allocated by task 1: alloc_netdev_mqs+0x758/0xfa0

The same stale value is then handed to dev_hard_start_xmit(), which
reports the same fault.  Re-cap the mapping with netdev_cap_txqueue()
before it is used to pick the tx queue.

Fixes: 10c51b56232d ("net: add skb_get_tx_queue() helper")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KASAN,
CONFIG_NET_SCH_PRIO=y, cls_bpf); it fires at the claimed sink, and still fires on
a kernel built with ea4d4b5dddb5 applied.  The reproducer source is not posted
here per Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
CAP_NET_ADMIN (attach the classifier and qdisc).  The residual is the
store made by a tc BPF program attached to a transmit qdisc, which ea4d4b5dddb5
explicitly scopes out.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/sched/sch_generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..c326d12942e5 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -432,6 +432,13 @@ static inline bool qdisc_restart(struct Qdisc *q, int *packets, int budget)
 		root_lock = qdisc_lock(q);
 
 	dev = qdisc_dev(q);
+	/* A tc BPF program attached to a transmit qdisc can store an
+	 * arbitrary skb->queue_mapping after the tx queue was picked, so
+	 * the value reaching here is not necessarily one the device can
+	 * serve.  Re-cap it before it indexes dev->_tx[].
+	 */
+	skb_set_queue_mapping(skb,
+			      netdev_cap_txqueue(dev, skb_get_queue_mapping(skb)));
 	txq = skb_get_tx_queue(dev, skb);
 
 	return sch_direct_xmit(skb, q, dev, txq, root_lock, validate);
