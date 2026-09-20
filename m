Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74A2EEE93
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789910631; cv=none; b=p5QGZ1EM2hF3HvoefJwZohh+IHTjZ/cIq+gZIcViDheVaFLNpaQ8hz4V8rN2hHJTtFHNtmW0PT+Au1ihLc0eFhHXfb9BCsz5MlMXdNLeSvdsPIsbrrlZf6XOcigMbOeJEuS4FzQQLpaIiakMiMKjQfvAYA4kpFcpc9mGFjeiAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789910631; c=relaxed/simple;
	bh=BFRJNjLUzJzfA/8a04/wk9tNDyU84TQV78mHxEY4ptI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGj1Q7kM1kTv0zCORpoK09OsHjKPOoKqgHar/i4pvbuv/j8A4BoIpx4t7kUHcGnvYKqX5J5Xnm2FzPHpu9F1PI6Zl1erhtO0e5xCnnYnoEvKwLDC579tRgi5/ItamBSyKSOEiP6FMXfP6zMfQeGQMUheEcqI6V34eV2rnuOoTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF2o0hfn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF2o0hfn"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso21294705ad.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789910626; x=1790515426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5OtWrGtaPspTRm2sx0yEDn3GrMGiAo7FKIGCtfn1P8=;
        b=OF2o0hfn0ImRlCgZZhYSu6a1oRLt19qdkNM+GBvu5nfR4f0Oun2Lq4ZEVAGKROh0Ur
         0/8zfeBOK0hcthTAvk2A0prIGSA+HIlHWpljt8C4j5BBdpYE6zQqcelHwP+auHaAdEZB
         kEaD1YFp1fAQFH0ZaQlTri8ABmqwVYe575v3LPlXf7OQXZOBA+lS69Ir/+7BCInzkD+3
         Y+dosLm6v9T0i3GqBe6u1cYhpq1LmL5fUhwn810DjMjQaaRD/EiT03lXDO6hNfxF81+j
         2MZtRHRFRzzwrtKJoTU+bCDkDKU4ddq5v9EL3op1qd6dvqwUKSoC2AtzwVlJzTozxOo4
         0cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789910626; x=1790515426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5OtWrGtaPspTRm2sx0yEDn3GrMGiAo7FKIGCtfn1P8=;
        b=ODZZI+ctd2cJYTSkIdsB7YmaoJhdBkuuzCTYISUjaUFzfnltHTVUHYeX6I3LCx4h0D
         zWaNeM0REzEojY3ICAW93iifjVhgC77poZVVVgJkQbjaTjxvCVGmB/Fd/Dwe9GzICIkM
         yhEbfEe250t8btTovxLfcvY91WAJDFL4ALedQJqFkVgbyK/Esnev5HbK8iJYdErCKRVy
         2Fx/o0g+ojC0GZ4nHMCmSZhZA0l7m3R4kjSMuDMzTiyXifiboTKFSBGrQsT7r+cUAd3l
         j5/e3kPE7ZGlNB2J5usE1tvjobWu8zsIJ1SL+VTRyU2nn7mLGc3F8jx9jAOvmYXw+Kzd
         iDBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWL2um6UykDsvWQkxIlj8KPL4T/u4MkwpfShvlFKnfvc0RT4wHRQMUGyaq/pVPkov+cB0qTEI=@vger.kernel.org
X-Gm-Message-State: AFuF++l8OsuAr65AXRj8w+m4PZDst6QDu9f546jh5B7BksTtSCw3+356
	zxI9cv4w8AJOKM2pw9ffBWOGf7GEMTICJk6ecdlh+V3H+l9HaJcct/R7
X-Gm-Gg: AYBFou3MuN2RUI2Hi83XzMU6VA3tZEYzqvyjS34ZQhXg4iUW924NHL5TfUzbzwwozjW
	SQLqsXL8exPteEaDE6K17nxhwNSvkP0LIFT33RJQRYeVcLpBG80MLauN55jqmg15e1jWEOe88Vr
	f8LJoV4jVCvu4GG0SiMli9KhUWI0Se/dSN3H70avjEqs+dM1es4XnRZmkUOawBxjd35KKcRb11t
	ZYhiz3/j92t0zb3UYGnIHjX9l/vPbgO0kfKkOcWjHvvNzHajHiz9vBxSND1AqqeJJUqDNL2Bxey
	nhAkPJGQ+vg+dbeOSZoX5uXGatPv5CokiL8YY7CrPaarnzEFahtwrbeAqbCLxdyTc7ON/euOmbx
	xmNl4Xx0e7SF1zCMNXIVMh/JLLWFBNVCvvjTD2w3DmGpMc0ftG6blBs6kMwUmk2g1BalBqUxgPb
	61LTDql1bbJiRLVWA3jZIxo2aMYwL6HpwaM9N8BnpCCVcT48BhcRwHsgjwxGjR+2U7QLNHPjAJA
	gpQnpWGkK4ZE1pWdl9jUpdzdG94UpaW
X-Received: by 2002:a17:902:e806:b0:2dd:c053:d742 with SMTP id d9443c01a7336-2ddc053d7ebmr70642425ad.41.1789910626267;
        Sun, 20 Sep 2026 06:23:46 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df44393990sm4857795ad.20.2026.09.20.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:23:44 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+ac0a8c41de69121d@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 RESEND 1/2] bpf: reject dev-bound-only programs on other devices
Date: Sun, 20 Sep 2026 21:23:04 +0800
Message-ID: <20260920132303.4109240-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bpf_offload_dev_match() falls back to comparing offdev pointers after an
exact netdev mismatch. Bound-only programs normally have NULL offdevs, so
unrelated netdevs compare equal. A bound-only program on an
offload-registered netdev can instead inherit a real offdev and match a
sibling port. With CAP_BPF and CAP_NET_ADMIN, a caller can use
bpf(BPF_LINK_CREATE) with a different target ifindex to run metadata kfuncs
specialized for the bound driver on the target driver's xdp_buff. Running a
veth-bound program on tun reads beyond tun's bare stack xdp_buff as a
veth_xdp_buff.

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
Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Resend:
- Start a new thread after the previous v2 was threaded under v1; no patch
  changes.

Changes in v2:
- Drop the redundant offdev NULL check.
- State the capability requirements instead of using attacker wording.
- Move the regression test to patch 2.

 kernel/bpf/offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f55695..d85539981 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -698,6 +698,8 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
 		return false;
 	if (offload->netdev == netdev)
 		return true;
+	if (!bpf_prog_is_offloaded(prog->aux))
+		return false;
 
 	ondev1 = bpf_offload_find_netdev(offload->netdev);
 	ondev2 = bpf_offload_find_netdev(netdev);
-- 
2.55.0
