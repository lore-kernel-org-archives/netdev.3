Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7561C37E5E6
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148245; cv=none; b=Pm4IBz2XD9CALzs+FQ1Lytfpi1qZwvaa/Kg+MwIJhzxEo2bXOODzATghXmksRg0NgN7ooAntjTf90NVSfy++qKlnkENXlFhasHYqoFZqEBcQAgLnLSOAeO1Gdl5j0j8Lu2PmiBhX6NIB0ce0RmiROY3EWsQC/b5wSRjppXE/iXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148245; c=relaxed/simple;
	bh=37Co+XwP9uWZp5tfMpf5fcEYp8chfhoFKZKhxZtxJ2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNqXc0D2XqruNaYHdLbV7Abu5hqFMy0Cys0COXZZgAcgcxZgUQoCjZVusO5YGLKqHHnpsGlfH0iXtacl8cmC9sUxYVdxgugb4Uz6PuohbCdIb9JzRRFQRg9EcEAmX05fel2sqTRpZAJTPjeBNz7vOfavDFVfmF9tiBIsY7yy0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfxaVYGl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfxaVYGl"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a2dcede83so3296589b3a.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785148228; x=1785753028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezCW4lm9mYFN6PTDfYpk3rq7ZibyjvVjQyvO71TAYU4=;
        b=mfxaVYGlGxaXr0Lm8nh9V23Uuq39BxX4w/YJt6xEWuE3ik8GL1rMeBiX2gW1m1YmVx
         mSiSeUAPkA7h9so1J2uqS1nfhHWYqkWZeOKzQQm9EwVh6Pk6HZ5JEkka4gHSQ+A7uZuq
         UxTRKye7tO4X/Mqs+89zEroWqrFMDfqBbPdAJ3fhRoOOZdujJVOZWX9MTM1Ttcvq67vL
         rKZHxYnys96pYuiTlgnmVgze0AjiJkCDMQjYgUNXp7ZaXtYIYSUbmCNCnQ+tddVibK3I
         jZLoqn2R43DWgZdbm3wn3LCpULPXX4wz6vtnhtaCFnY3l4xnY6hEV7wDhxn4IEqrv5Ff
         c4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785148228; x=1785753028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezCW4lm9mYFN6PTDfYpk3rq7ZibyjvVjQyvO71TAYU4=;
        b=QyG+eIu4X21DNUoTmmf9kpih0BfDy5AWN94AfloeEpCDb1DU1c5cNtT7SGxqtwXDYG
         XI/o1VXRY5w0I2w8yXDW2DGEvb1g0K+DxmLBrpZdK1m/ywRTtFSybaNjBxTfJ+9WrJWK
         ++GwTaQqRtu7Ly581hiADsrCTQsMT0mHZPHLKZBfBnAviHbYZF6zv1DsfVADkveR+GdP
         eomeGT2xpDIY0Dx+1VfVG4wWxQpCcWTcITXvvrakJCLz0UzVubxsoA5H07AJA0iYv/aa
         /ZXrnX5uN83n4pFwydtbgu0duK3WnVZSSN+lrkO5sqHYgcoDEQC4tuV4KZO94arnW8rq
         a6Qw==
X-Forwarded-Encrypted: i=1; AHgh+RoYVLKHe7oc7LtzOYwlyT8iwfSIYyvKKK8qM5oM6YBoVWcHWYh8nz8xv17sfD6yRduHbC0XBsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhFHibA6NAm1GtmAezAfzw9550evMMFC1TONMafS57D+GDvah
	WcyrkDaBqIgxDX03EXOmFLmUAy0Z4REJc5CfQ8Jt/LYnT4DiJyTXZngB
X-Gm-Gg: AR+sD13OSa8c/PtulGSfHKxLkQTH5b/1ST2Re0UVZGSw/xxMTrD74WhyuFyRcMM73az
	ViCahYerqgwrr98yuUZ7uJuxb1hKfcWONzvmukOK4NoUVH714KTRLobas7pIfssoCSQ+Qf2oV1v
	kKe6a6tPXGIuwlcUo9VQXqMzAE2u3HWyMwvMdt7iuQtGMmhfh2JJy5Q0rTqIg7HxsU5+6WKuv2q
	q2+TGmc9YzSMsjcO53nhK14y2H9cEItNSXc2p/c8AZp41C1dSgo0+/XXK6IYWAqNHTP9zKd5TVY
	u3xkyw9zYP7TUeoaN5fTcTyiGKv7TTL92bkZdMY5thI1k8yU5AsZYMQRAyTqUQIEATKid/7WN+8
	1Mn25qT+7DIqAVjVdfQI+p3nZbweaCrmTyn1kOPv2NMU7efoQgFqrW+o/LPM7CgZ3RPnFysap
X-Received: by 2002:a05:6a00:4fd3:b0:842:55b6:f5a1 with SMTP id d2e1a72fcca58-84e5943132cmr6671649b3a.6.1785148227986;
        Mon, 27 Jul 2026 03:30:27 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533cb54dsm2823860b3a.31.2026.07.27.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:30:26 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Graf <tgraf@suug.ch>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [PATCH bpf] lwt_bpf: account for aligned neigh header length
Date: Mon, 27 Jul 2026 19:30:05 +0900
Message-ID: <20260727103005.897983-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_finish_output2() expands an skb to LL_RESERVED_SPACE(dev) before LWT
xmit. An LWT_XMIT BPF program can then modify the skb head and still
return BPF_OK, so bpf_xmit() rechecks the remaining headroom before the
skb continues to neighbour output.

That recheck uses dst->dev->hard_header_len. This is not enough for the
neighbour cached-header path: neigh_hh_output() copies the cached hardware
header using the aligned hh_cache size, HH_DATA_MOD for short headers or
HH_DATA_ALIGN(hh_len) otherwise.

On Ethernet, hard_header_len is 14 but the cached copy needs 16 bytes. If
an LWT_XMIT BPF program calls bpf_skb_change_head(skb, 1, 0), the skb can
still have 15 bytes of headroom after the program. xmit_check_hhlen()
accepts that, after which neigh_hh_output() hits its headroom warning and
drops the skb.

Compare against the aligned hardware header length in xmit_check_hhlen()
so the BPF_OK path leaves enough headroom for neigh_hh_output()'s cached
header copy.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
Tested on a veth pair with an LWT_XMIT program calling
bpf_skb_change_head(skb, 1, 0). Before the patch, a UDP packet sent by
the reproducer triggers the neigh_hh_output() warning and is dropped.
With the patch, the packet is delivered without the warning.

Below is an excerpt of the warning before the patch:

    WARNING: ./include/net/neighbour.h:538 at ip_finish_output2+0x19f0/0x1f80, CPU#0: lwt_xmit_headro/55
    Call Trace:
     __ip_finish_output+0x59b/0x8b0
     ip_finish_output+0x67/0x390
     ip_output+0x1db/0x700
     ip_send_skb+0x1f6/0x270
     udp_send_skb+0x8d2/0xe00
     udp_sendmsg+0x1717/0x2620
     __sys_sendto+0x443/0x4e0

 net/core/lwt_bpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index bf588f508b79..2890aa59a3a0 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -169,8 +169,10 @@ static int bpf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 static int xmit_check_hhlen(struct sk_buff *skb, int hh_len)
 {
-	if (skb_headroom(skb) < hh_len) {
-		int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
+	int hh_alen = HH_DATA_ALIGN(hh_len);
+
+	if (skb_headroom(skb) < hh_alen) {
+		int nhead = HH_DATA_ALIGN(hh_alen - skb_headroom(skb));
 
 		if (pskb_expand_head(skb, nhead, 0, GFP_ATOMIC))
 			return -ENOMEM;
-- 
2.55.0
