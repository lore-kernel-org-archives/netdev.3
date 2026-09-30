Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623404BD7A4
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777073; cv=none; b=dYMS0+X0FjsZKMADZvJiN4ngJVPfP4vtcpA7cotD79DJrFIrI8gTsJRBUe2ayVXrXyCBLA5s5TrNrNUABb1MaHK6oe3iMp2XdoG+C27OAuaKMawuNyWXO9LKEkZDuN1/k9EUPZVQGdai+M4A3YwEBAYiHUIZqazbMyCGncZyUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777073; c=relaxed/simple;
	bh=dDRtbqYPrbcSZk8XTIR1mhxTewKaoQ7Hl8OVK4zyccw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqEU4BTOXp6G9NJoTtxj6HFdU6Nu5gM84W0VMZpkO/7gdDeXHka8N8UKZ46CyxZ7AgkO7lwaYtteRE7gkguwsZi9h68BeBfe+U+ez3OKhaSIIeNW8/JFzxIN/pczQU+sKTe20I2oUFkj4AGaBiea1sXJ47uiAavHp0CivitukLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5xr+1lP; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5xr+1lP"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e5eso2624647a12.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777053; x=1791381853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/hVX4C+yQqwsDE4LgI16fX3ANft9SjFARlaoadqqlc=;
        b=W5xr+1lPy4kXFvznJdBdMZA81GHwJDOEyvkLvK1qXGzVdR54+Y1w/jnsnEsyR6XdYT
         73zya3usx/nxhX0b4L2cime9dP1bqlLPQ3STEAxH+8S2npascYUrAgmZi/6/u5HF95Co
         ke3PoUrv3CyQNK0D6VHRIw+WBIjiY6TWTFnwmdKqXwgfBEki7b4ovfMebRI2n0VdI3gy
         XDrEkkZguSzZ+18kiqVU/g9HsiQwo97wvz/JQTZBk2PZrz7pXPHEVcsUiNLx4ZTijRH8
         lpKBYou6V3WBUnRxDNbqbHiWO6Ll+JOMCKQY4B40EHHo+5GWEWC2PZFOQdHFda7/4iEs
         uJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777053; x=1791381853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/hVX4C+yQqwsDE4LgI16fX3ANft9SjFARlaoadqqlc=;
        b=I+u/llxeX6d4zKXU/nOOCdTbTvtPnXjYrwRT6upvz6VQDsDo88luVM8WRnthJJIwR6
         x7LkY3QRRlI7kLrzS5R8o4dfCnf32w4ac6uKLpoXlk4jqswkTjn542am1xcjfqvw+vaP
         eCJuxic+hzSdH2NJXZtBJUhvRKK4OGqvJVr1Z/Q8UCB5MhnNEv7jcNVMpHGEmpuRs8ps
         KPLtSVqtCFT+67LroSU7EEXWCu8ry2jtiOGC64Jy/ptxfjHMIumXWUas2PyNoykxQJ6b
         zWMNugtsY1YrklzonHiEIo8zS/h7LTZnN4/rDyQTx0Md5svuMViKPJ5viAGzOjhpK8SV
         fI5w==
X-Forwarded-Encrypted: i=1; AKwUvBxr1/CvTuV9zfXhvsX5tvWRtdcOsxGhlFEEWAbYGF5QV9iAzC9EpQ9nXvA6n8vqcTF7LTU6KjY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFajJGqIAjMwwn1jhHgrxTm7IEFNX8/kfn0FedCitLS5Le1d07
	7xFwvYlWXb5D8LB474QSeVz6Idj4lQlCo59FRtSWNPXHIwNbAtzJ0bJb
X-Gm-Gg: AYBFou0BqqSBaJFMfXKG8Jnr4bIhQvtIxVu1vAZaAE0M1CO6/YTOpcQrcF8Q98PNZOV
	145UQKa8pl6RJOxNwTHHPV/fgCcbyw+tbrhpggkp1Mj+H3jSTjA3OTDuCsUv9JgTYvSpzwOmJku
	VdOAoUQm8cd+z2ga6e/gI+SiVQT3MCjNbqCHMrbIvyxAYwO4oAjBCYvlvSHJ3L+fDJ/sSHMa9NE
	4CmFqR+VktqBSr8deinSzgdc8xxhmSMmjZo69TA+/y8/HofjlmGtRKw3brh04yvFRxD6RjhbPCE
	/HHyYoMPiYJEbaqM7VsinHGA2f+hzxzPGJ6YY/UBdgUySF/r0YXT3k/iWZ9hPwEOdDJY07cFg7G
	ArdIMChtFzR9OnJkd4yZNtRW8q53FqZdX8UTB923fFTprjU1AUi2c6dWTmvWNmJlBLG6PjOVMOI
	awEB+dXMKuh7NgTwte3ODwQ7EEthBYdX0zRM//bZ+stujRA43WzYxHV7kDvXmRIYyKHgHQsMUNX
	4Hq6OdlfX8=
X-Received: by 2002:a17:90b:564e:b0:3a0:d9ee:a2e9 with SMTP id 98e67ed59e1d1-3a4d18c09b8mr1192177a91.45.1790777052463;
        Wed, 30 Sep 2026 07:04:12 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7dab202f1sm1031140a12.27.2026.09.30.07.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:04:11 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] cipso: adjust cached option offsets when removing CIPSO
Date: Wed, 30 Sep 2026 23:04:00 +0900
Message-ID: <20260930140400.2955466-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cipso_v4_skbuff_delattr() shifts every IPv4 option after CIPSO left by
cipso_len, but leaves the cached srr, rr, ts and router_alert offsets at
their old locations.

With a valid eight-byte CIPSO option followed by a seven-byte RR option,
RR moves from offset 28 to 20 while opt->rr remains 28.  The stale offset
then points into packet payload, letting the sender control both the
length and bytes copied by __ip_options_echo().  Setting the length to
255 produced this condensed KASAN result:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo
  Write of size 255
  Call Trace:
   __ip_options_echo
   run_cipso_stale_offset [net_candidate_probe]

The destination holds 40 bytes of option data.  In an existing
uninstrumented x86-64 v7.2 build, __icmp_send() places that buffer
immediately before its stack canary, and the 255-byte copy also crosses
the saved return address.  A canary mismatch unconditionally panics;
no canary disclosure or control-flow exploit was demonstrated.

Mirror cipso_v4_delopt() and subtract cipso_len from each cached offset
that follows CIPSO.  cipso_len is the logical distance moved by the first
memmove(); hdr_len_delta includes padding, while the later header move and
network-header reset relocate the bytes and their base together.

The adjusted input leaves rr at 20 with length 7 and completes without a
sanitizer report.  Natural remote reachability requires a configured
SELinux/NetLabel gateway and a later option consumer; the retained test
invokes the real mutation and echo consumer directly because the available
rootfs has no SELinux policy or netlabelctl.

Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv4/cipso_ipv4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index a05aa075de1a5..135b57c2c4f9e 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2272,6 +2272,14 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 	new_hdr_len_actual = hdr_len_actual - cipso_len;
 	new_hdr_len = (new_hdr_len_actual + 3) & ~3;
 	hdr_len_delta = (iph->ihl << 2) - new_hdr_len;
+	if (opt->srr > opt->cipso)
+		opt->srr -= cipso_len;
+	if (opt->rr > opt->cipso)
+		opt->rr -= cipso_len;
+	if (opt->ts > opt->cipso)
+		opt->ts -= cipso_len;
+	if (opt->router_alert > opt->cipso)
+		opt->router_alert -= cipso_len;
 
 	/* 1. shift any options after CIPSO to the left */
 	memmove(cipso_ptr, cipso_ptr + cipso_len,

base-commit: 99b43ede9e355ba35244cc9470bf1819774ce39d
-- 
2.55.0

