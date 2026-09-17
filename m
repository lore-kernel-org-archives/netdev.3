Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7B4F4D0B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661650; cv=none; b=dwOWIA+DKtFeBxLAUTW+nTkunyGh6LOJ3dudSplQHxPt1BAZN4hLfHnyJIGKUD0QIBaGDFYWI2LEOHesdfVVd2YMJ/k0CrPS4bqSgbDv+NTyQX3IKgwT7WsSti6BuHNon3L1NYxAAblCUHRTxuT5vJli2dKkDmWNJZUlb3h5Gx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661650; c=relaxed/simple;
	bh=CEQYbOWht2A7b+OZw6MvQpQz1NKPJ1hneP2IMPR4sXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljEpREf+P+gthbpEA6MYortPSf66GQBGRrNwqPMGxASKGWRVmGqqZ/p9qWB9yT13iGZNS853cZAWAvptPsfESNIzVYq5tAQAvKITbDF9AEYJEfxDKlQRQQZTFGWecYmKtA1untplm8DaonxZv47WW7eaKTMWSYNR9HYlATO26bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlqHyv1X; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlqHyv1X"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f38so10628755ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661647; x=1790266447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x8bSU+iv17p+dmRAzgAgwO3BTC71XsPeXgtmHePe98I=;
        b=dlqHyv1XRsLqDp5qUOXg+/wJ6kuePbWyEjwqg5LTns+wG5J1XsoZPp/05zOFlcUEK7
         XY2ZI0tsUi4subD+GCcnr9gkFh3ZjHWqlrqQiE0QgN/jzFkUcb0sXbaUknzDpFGLpVz+
         aWrysSgYPF2C5WmkHOQTDRxYUhdjt2mXomqv6KscQF1Qfs5DpRR05S7JWCoEJTdYYjua
         rfoyqm6yQbSMwsJUZ8mwyHwBCscj4hXEQPYz3ltpGtNolU9fnGCEyXATAPwZVbIsqu8R
         fVlN7r2lVwjrxjS6ifB4Wt2wYSme8fptWBi1CcVeJZG45uhY41B1InsksZAmk+uNj2AA
         8lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661647; x=1790266447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8bSU+iv17p+dmRAzgAgwO3BTC71XsPeXgtmHePe98I=;
        b=kXm2E3Wl6Ste+sztqreb1joxfJOVoiZmeK46vRE28Xowe7PC9lMbLqA4HHEXTVpdd/
         umYNYlK5cRmUAcjQnzwG0tTI/c9hRhgbsVygq6hshPxHsQHOiaG4gf4symecCE2qfImZ
         XuHlWB7lZ34+SnAscQH5ypVEsvAkW5+lW4zO3k0zuD21czZLbpaNThmXO6B7XPNtQHkk
         NK4Kjd0zEkB/sbwGSJ2Ke+hJWBBOcRBFV+ADIgt99bSrnMq7Q1ReP53nmR/5WWqVnF0w
         hgTU2dLvkikZmtqoFpq9agjcfer2l0XU3p8FcfbbjpHYYsrTPa43vEh1ycRGyx8fviV/
         YtbA==
X-Forwarded-Encrypted: i=1; AKwUvBwi/TCsHOFqxro4FfldjpzeaA5WKTlQm3s+TR0oH/KMDJCo9s8wrXn4aXF8AyP/Yep46FwPzus=@vger.kernel.org
X-Gm-Message-State: AFuF++kNoVm0m4H5yFqBpdzJMUXpPeY0FvVjmFkJcAVsul8e7OC4F8Md
	AGTRcdgRDrQQ2QSdWf41/bjqbs29M0tRQZaY+3kPNpN2/cnmitdjDU7Z
X-Gm-Gg: AYBFou1Hi9yaJEcovz1pSftyMYStjR0DV74IzsERt9oOHlrcpxgGRC58O2hFcqOgQuJ
	LDfSvdRQ97bOROkH6r3Nv1G7a7TK+Zpl6sWTWWPgspsRBHJMH3kiokCY25Jw8rHIi7XXbwhLvl1
	vae58xFeETT9qrXlo2ThO8vlHyq0UWUe8/DjOsurmQzm58qxZPxYd6UaZtfZm2l6QXMyxOrmf7p
	4npok6Mc8zjfBCM7hQmUHEnA3Nu1OsXA4ZakHOU8Ay6OJdOxRMn243GPzWJT9KrRQ7MjwaaSASA
	x30elakZAK4FJ2JweKNb8+cEkwP4nD1XzVKPSfbEoS+23ETLRHuQeom6D1u4WKoNCgji3HrfvlP
	VlcLBSA3NCyriett/nC0D2lSphuCTZsZwxJonii+MpRR9hudy1hbMX8h9wkc4fXa+p1Tqwqio0D
	3IOASOxhJAI9GyH4hPvWB4rah5RvN9+JA66oLZy7jAG6tgH0BmyhbJvnzT8tRkVY/kfsZtHxtVX
	7V91UF363MWhceqYSYrD+/1FUAzC9tu
X-Received: by 2002:a17:902:e94f:b0:2d6:fd55:3a9d with SMTP id d9443c01a7336-2dd8dc06da5mr150178695ad.3.1789661647417;
        Thu, 17 Sep 2026 09:14:07 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fd37sm29489395ad.3.2026.09.17.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:14:06 -0700 (PDT)
From: bestswngs@gmail.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+ac0a8c41de69121d@bugs.sh
Subject: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
Date: Fri, 18 Sep 2026 00:13:36 +0800
Message-ID: <20260917161335.1020405-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

__bpf_offload_dev_match() falls back to comparing offdev pointers after an
exact netdev mismatch.  Bound-only programs normally have NULL offdevs, so
unrelated netdevs compare equal; one loaded on an offload-registered netdev
can instead inherit a real offdev and match a sibling port.  An attacker
can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
metadata kfuncs specialized for the bound driver on the target driver's
xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
stack xdp_buff as a veth_xdp_buff.

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
  Call Trace:
   ...
   tun_build_skb (drivers/net/tun.c:1739)
   tun_get_user (drivers/net/tun.c:1856)
   tun_chr_write_iter (drivers/net/tun.c:2091)
   vfs_write (fs/read_write.c:595 fs/read_write.c:687)
   ksys_write (fs/read_write.c:739)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Restrict non-offloaded programs to exact netdev matches and retain the
shared-offdev fallback only for genuinely offloaded multi-port programs.

Cc: stable@vger.kernel.org
Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: <co+ac0a8c41de69121d@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/offload.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f55695..8c91d00d4 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
 		return false;
 	if (offload->netdev == netdev)
 		return true;
+	if (!bpf_prog_is_offloaded(prog->aux))
+		return false;
 
 	ondev1 = bpf_offload_find_netdev(offload->netdev);
 	ondev2 = bpf_offload_find_netdev(netdev);
 
-	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
+	return ondev1 && ondev2 && ondev1->offdev &&
+	       ondev1->offdev == ondev2->offdev;
 }
 
 bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev)
-- 
2.55.0
