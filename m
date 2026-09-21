Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591133DEDF
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789966764; cv=none; b=kzMYQSMxuSCTmzJUrXC8Gooj+VTqCsy7nKeHdr5MrP45xZ+iExqIrSlXyVmu+K8RupEVEs2M9le18w7Vdv6kfU3ZzqXwDoAQQ7rKeffCCHKpv3CDsPEpxr6rlWq3SfgImK+RAQENf1CQHpJh7ZrntCqarbAG1RTEcIk59P3rY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789966764; c=relaxed/simple;
	bh=b4CbI8uG/t5WRhiLbFsybqoCQb0cAqPt+YhPl6f1U+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub0L6P6CxnpR0u8SSj04MCN0TXn5vtC0bCRbUzTnCYcKKVsC6txqzS1UAO3j1MqZ/jhI0W4rjAxIgtIEJr0NH5Z/GZWqPKRWOQzGcbIxB8aS2cRK7c41RrPM2HjRp0w6iXR9wLGuLr5HM/O4Uz5djnZOv8ATK+j1mnyFj7pBHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWiiHpix; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWiiHpix"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2090359a91.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789966762; x=1790571562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21WhGDIaCD25/aTs5QNVHTdMwpo2rK9F3FrQcRWeh8I=;
        b=VWiiHpixtf2jDLZgtOdl01GZUctUTSnplDKhKL2tppgtesJ1oi7BEntqtLhbMWpSAG
         HAsGUO1UFM5xJLdy2w/Rs2t02JdUhBgL1uNY6SIgC6M2MLfG9oAyzBCreLD4kJrCcxnZ
         wdiVna+riLmy9lJucTK6QBgAGTdBxvJsbHvfjp/tZNiLfiMYmxvDeNWEQg45Y4RPUZpR
         dpJlt0DTbKxFfUsCGvD+lAcopA9g8wK7FMe92NAiCPwkmyFQ/cSPCsNq/5r2CWeodk5W
         CH/F2hGeAT58bZC/PY0Bg726PLdsG/eHYI0Gl1U5u4puLhOEQrSxSC/Y+arAt0o4uXW8
         EEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789966762; x=1790571562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=21WhGDIaCD25/aTs5QNVHTdMwpo2rK9F3FrQcRWeh8I=;
        b=ENwgEmtfxTE6xj8KsaS2Zu571/acTl8C4NpWGbJVqRedeB/cMz1mrLwkJtzPWLbK9m
         QEfqIXN0SuGkNA6HgyR6xH4WA75DvY2RNvmLk2dASzqPsDeCfMn443+89LLNAUphMJ29
         4q0EG79/t6zM3yxx2liNLASX6d9LyQlSD7SyS+uGXZJ/97h80RHyijeeRvv1nXZkeKOY
         bhiyNSrItCOEBAiN/XcqRJ2g3mb5ZxGhgvxhPXG8ip9ofMPh3R9czljjwla5H8tBZS/5
         deRBsHqjBoYFFDIBI2NFF15X1Wsh06JoIURnS4XPcoxJYCp7t9vIHUzDtx3AhENq/+NC
         MStw==
X-Forwarded-Encrypted: i=1; AKwUvBykM4GiUHWekJstqWGKTgv8aVDyqYc2Yh8cUlwVSPM2xHGlpoPMRuvjSP+kv3WjgRPKWbcf2Xg=@vger.kernel.org
X-Gm-Message-State: AFuF++npleQnFkCxme0NY90rfNY5r4unIDm45y2ERqgdFWYfRc6RP7+S
	swEgWF1Yyn+MiIAAY/HEXeYmj2wl9+B4iULwgvpFiDKV+W07z4c+WbXx
X-Gm-Gg: AYBFou1kwVB2Gn2lWu94FqYbM/OLzl+Vljvc0dAYnkBdCRYpVW0dD/j9TPYkTcCVjjn
	OzB4r8NJ7WW1z3vLYTqSodhfcP7GfdHM333CGl4j+zle+z9VZEs2ov7x7wnxUCUkUd12T5jm2Ya
	cO4i5BbmH+tXuIKuq1T73d4PBa0XraV8YiwyieQMN6tI3HzuHLzvoitovIxJ24nsRp4twYVoqSu
	2mT+PY7poX/YrhbBdSXN+5nWEwvSBIl932+xMg78q/gxN2leDlZZDDyq6bRtJMQW88ilCG2HVr6
	6pxGMrJ3NIK4sE4p+MucdeU6hiHMm7O0jwdOu96YmSiOu77SweihOKY/C2PfGONO/9aedCqAQlB
	wHWRT0RCo1LsOtY5XBOwRcn+66IXsbWSmEp9EI5j1z7HW3kh4mD4vfvANwwjSBP2YPPbS7QY9+P
	KCLx/HnhKN4xkFPIa99aKpuWAWm+5JuDPuBKAJoG6+PTnWgI6KL49i8j6klB6SSqcaTDgH8bB8C
	ORcjK7wDt+1faafXMezv77qNk9sgG75WAxowa+6xVn6vCEXB6qMiVdK3cy5jspQ0/5zfZXk3x01
	2yjFmxOKqg==
X-Received: by 2002:a17:90b:5305:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39e54dcd917mr21660064a91.6.1789966762169;
        Sun, 20 Sep 2026 21:59:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a026898b76sm9772930a91.16.2026.09.20.21.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:59:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Tom Herbert <therbert@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v2] fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
Date: Mon, 21 Sep 2026 04:59:20 +0000
Message-ID: <20260921045920.1613098-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <CAAVpQUDwLnRfv1PkkexsC04D8wLSeARekuUDSTOenyRctWG8MA@mail.gmail.com>
References: <CAAVpQUDwLnRfv1PkkexsC04D8wLSeARekuUDSTOenyRctWG8MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7a9bc9e3f423 ("fou: Don't allow 0 for FOU_ATTR_IPPROTO.") added
NLA_POLICY_MIN(NLA_U8, 1) to fou_nl_policy[FOU_ATTR_IPPROTO], which
rejects an explicitly supplied FOU_ATTR_IPPROTO == 0 attribute with
-ERANGE.

However, FOU_ATTR_IPPROTO is an optional netlink attribute. When a user
sends FOU_CMD_ADD with FOU_ATTR_TYPE set to FOU_ENCAP_DIRECT and omits
FOU_ATTR_IPPROTO entirely, nla_policy validation succeeds and
parse_nl_config() leaves cfg->protocol as 0 (from memset(cfg, 0,
sizeof(*cfg))). fou_create() then creates a FOU_ENCAP_DIRECT socket with
fou->protocol == 0.

In fou_udp_recv(), returning -fou->protocol to udp_queue_rcv_one_skb()
triggers IP protocol resubmission when fou->protocol > 0, whereas
returning 0 tells the UDP tunnel layer that the skb was consumed without
freeing it. When fou->protocol == 0, every packet received on the socket
returns 0 from fou_udp_recv() and leaks the sk_buff.

Reject FOU_ENCAP_DIRECT when !cfg->protocol in fou_create() so that
creating a direct encapsulation port without FOU_ATTR_IPPROTO fails with
-EINVAL while leaving FOU_CMD_DEL and FOU_CMD_GET (which share
parse_nl_config()) unaffected.

Tested in QEMU against Linux 7.3.0-rc3 by sending a FOU_CMD_ADD Generic
Netlink request with FOU_ATTR_PORT = 5555 and FOU_ATTR_TYPE =
FOU_ENCAP_DIRECT while omitting FOU_ATTR_IPPROTO. On the unfixed kernel,
FOU_CMD_ADD succeeds (err = 0), FOU_CMD_GET reports fou->type = 1 and
fou->protocol = 0, and sending 4000 UDP packets to 127.0.0.1:5555 leaks
all 4000 sk_buffs (SUnreclaim in /proc/meminfo grows from 41456 kB to
59008 kB, +17552 kB); with this patch applied, FOU_CMD_ADD is rejected
with -EINVAL (-22).

Fixes: 23461551c006 ("fou: Support for foo-over-udp RX path")
Fixes: 7a9bc9e3f423 ("fou: Don't allow 0 for FOU_ATTR_IPPROTO.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Clarify in the commit message that fou->protocol == 0 is reached on
  current kernels by omitting the optional FOU_ATTR_IPPROTO attribute
  when FOU_ATTR_TYPE is FOU_ENCAP_DIRECT (whereas an explicit 0
  attribute is rejected by commit 7a9bc9e3f423), as noted by Kuniyuki
  Iwashima and Sashiko.
- Move the !cfg->protocol check from parse_nl_config() into the
  FOU_ENCAP_DIRECT branch of fou_create() so FOU_CMD_DEL and FOU_CMD_GET
  are not affected, and drop the redundant check in fou_udp_recv(), as
  suggested by Sashiko.
- Fix the Fixes: commit tags to 23461551c006 and 7a9bc9e3f423, as
  pointed out by Hangbin Liu and Kuniyuki Iwashima.

 net/ipv4/fou_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 5e867f1b5c1d..f30f22389283 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -600,6 +600,10 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	/* Initial for fou type */
 	switch (cfg->type) {
 	case FOU_ENCAP_DIRECT:
+		if (!cfg->protocol) {
+			err = -EINVAL;
+			goto error;
+		}
 		tunnel_cfg.encap_rcv = fou_udp_recv;
 		tunnel_cfg.gro_receive = fou_gro_receive;
 		tunnel_cfg.gro_complete = fou_gro_complete;
-- 
2.49.0
