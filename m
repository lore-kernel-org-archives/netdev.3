Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD94BEE4F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601908; cv=none; b=oKC2NfZeYXdTsORYReuhHNDfdQ5k0e6xzKlTZa+73PEUoMBCrYbjqnD119hkgc4/pQCXPwPRTp+gz9Rmg6fRQHyw5aQmb+aCYVogQ2RCgRZIQwhLF+UQhY5D9flEeX0h3ALbcjLS6aMGOLAnULJs4z4WMhyf2T5XZqR43U3ZOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601908; c=relaxed/simple;
	bh=u7GTV46Kc3atN0PkVHNGN5ZvnEXCF0ExjGMVF2Sn/vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rSSWexh8IrH8jlFpss61SpNFknhzteZ9ubIMGcNiaWy4EL0HDuNncOTRNCObbbkMFO2FXllcCzPkffYDyZkVO9PBq/794XfWA+Z9gC5y5fuSgfAm1+smBjKtvz1/5AWJMfl98u9OoRLa8QMyNxQpszg69qAwWvAWqenaPSlGH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ob90t9sv; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob90t9sv"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e5505aso28246877b3.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601906; x=1791206706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xMUlBVNA1RsBcAarv0vzsm76oqs4M2vGHPlhW4TkRw=;
        b=ob90t9svFNLiLnOtdfAU2GUhxSVIhsWxZEaTzMrxQCucw180bqCUMvwxjsPuQUjxLo
         8yqT6f26uvnJpPMIb75CMPXQ7rhlh61hnUfXbn7/D5xUui3erBryvWFn5lvdK+4H/ux0
         NEATypIViVr3xAs4dWmLKnIIoRqfQD7bpGd/vT+M/s2y/wrmrEwsFCNu2vrTxtsZwemu
         /FLHj207wstq+ong4Y2IVMwT3CUJmtHDOB/aov6776AX3ppk86XoqA2g91on7es7TY+0
         ymgx+aqJpnhABD9GOd/bB04GnGvv+Co1I5cCUdg4gm4Sos8VddZWztJF7ngYqY+wPyyi
         tspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601906; x=1791206706;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9xMUlBVNA1RsBcAarv0vzsm76oqs4M2vGHPlhW4TkRw=;
        b=lJvveBgtR5iB/k/CpjLMzSRYK5uSwEcy9vnK8KCLxeEvecyX2GaeznD/9AobQrsFfX
         Y0H0J66hkpEtzAqxSxxX73MB/LUZiEEMRwEohOZqeRPSiFMrKO2i32GyeADqI1eDRQSa
         7NfZWTcK+mXHVrdZYGC3fouc44XkbrEGMdjEgZChTWllAIb/N9RglQ7Z4f10X8wdDidv
         6Cz1SrRT+AwR7ro/nSghRntfZuSJTONJljRnkDm8nHXi8MqmGzN5CkXeqgPh2B3KvSOL
         X4QV5j9hneF966sX7OzoOHkashGr7ygd3yD5W0mGGTvGZRfTNiL1+FubhiUT6QjJW0in
         nRqw==
X-Forwarded-Encrypted: i=1; AKwUvBy8eGT95GM+6qwTkO8CQvn0brIJWWGmKaiErRSpHamdV6QJyFwsg65McjOJRweEPSU7xU2+w04=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTY/m7P34p9rbcLAd6zZwWto4QgohboAt/rzIJ/Ftm1E1RINn1
	MPKjJnjNxDZ6+RsDCFmzh9YdbjzYVGfeXeoxwdlwS6GMfAAgCN6SE3KS
X-Gm-Gg: AYBFou22a9cUX0eUaJGf1XzkfBSeKNT0ZnRNlhx2Y+pwyMaAnv0NM4kp/in3sjXYTBq
	nTc1joOJr680bEjfCkCKMnmrCJ1P/d0NsyRwGcO6lxUmLnLAzFPLqP6RFsJ6OsMKVt7EEmfKnWr
	R5ZG4DOUjgf1PJ8CjcBlf3YZHFyiAyEnMKbvVRpAHAn5YVX6FtLK9p1W5IG//ANMZS/6jGPMyiz
	jK8KTkpc9iguUXJcV+NoXklonzQvHj72LXejr3uPcuyd2WcUOV7bjNBLvH9DUOaGIw/VPOJ7e5h
	9KpwlJ1MAYhVE9ZJM6YswimABljvumHt9/1cs+aYziepa39Rx9zVyCfbM9KHHCvzLQ2oPkg4ACf
	zUcCHxg6+MEZwzM5kFBjiA0yE+pizu/UdBIS3E0w8H3fAbA9hAUtKxrtZr19hoGAQb4Jfn++tju
	gPijjOVJGodGA+zsf/MU0GKBfeQ9LkIv4RQW1XT1t0MLRTetamYiVrREycM73jjFpjegAGGR5nZ
	8V1voXuG3SPnhLN69gjC7641tPukUv6+cROWw6E
X-Received: by 2002:a05:690c:c609:b0:88e:edf8:e375 with SMTP id 00721157ae682-8a64af41f90mr55822717b3.5.1790601906046;
        Mon, 28 Sep 2026 06:25:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:94d6:8f64:6f66:fcd2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab391acfb0sm298087b3.48.2026.09.28.06.25.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 06:25:05 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH net v4 0/2] net/sched: sch_cake: prevent shaper corruption and stall in cake_overhead()
Date: Mon, 28 Sep 2026 21:24:50 +0800
Message-ID: <20260928132452.59996-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses two issues in cake_overhead() that can lead to
corrupted rate shaper accounting or long dequeue stalls:

Patch 1 fixes an integer underflow when segs == 0. When an skb with
segs == 0 (such as dodgy GSO packets where gso_segs is not recomputed)
reaches cake_overhead(), (segs - 1) wraps around to UINT32_MAX,
multiplying per-segment overhead by ~4.29 billion and returning a length
close to 4.29 GB. cake_advance_shaper() then charges that length to the
shaper, stalling the dequeue queue for tens of seconds at 1 Gbit/s, and
for minutes to hours at lower rates. This was introduced by commit
c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()").

Patch 2 validates the transport header offset computed in cake_overhead().
When the transport header was never set, skb_transport_offset() returns
the ~0U sentinel (~65535), which inflates shaper accounting by ~66 KB
per segment. Furthermore, if preceding egress BPF filters (e.g.
sch_handle_egress()) or cake classifier actions (e.g. act_bpf trimming
headers via bpf_skb_adjust_room(BPF_ADJ_ROOM_MAC)) leave the transport
header stale (bpf_skb_net_hdr_pop() only re-syncs it when it aliased
network_header), skb_transport_offset() can become negative. Because
hdr_len was declared as unsigned int, a negative offset wraps to near
UINT_MAX. Patch 2 checks !skb_transport_header_was_set() and ensures
hdr_len >= 0, unifying all early fallback exits to an 'err' label at the
end of the function. Both hunks date back to commit a729b7f0bd5b
("sch_cake: Add overhead compensation support to the rate shaper").

Changes in v4:
  - Patch 1: Add Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>.
  - Patch 2: Consolidate the 3 duplicate calls to cake_calc_overhead() into
    a single 'err' label at the end of the function, turning early returns
    into 'goto err' statements per Toke Høiland-Jørgensen review.
  - Link to v3: https://lore.kernel.org/netdev/20260927131009.24250-1-ndaugoing@gmail.com/

Changes in v3:
  - Split the v2 patch into a 2-patch series per Simon Horman and Sashiko
    AI review so each logical fix carries its own accurate Fixes: tag and
    matches proper stable tree backport ranges:
    - Patch 1 Fixes: c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()")
    - Patch 2 Fixes: a729b7f0bd5b ("sch_cake: Add overhead
      compensation support to the rate shaper")
  - Clarify the timing and code paths where header mangling can occur
    (sch_handle_egress() and cake_classify() before cake_overhead()) rather
    than inaccurate "post-enqueue mangling" wording.
  - Link to v2: https://lore.kernel.org/netdev/20260922084124.36858-1-ndaugoing@gmail.com/

Changes in v2:
  - Accurately describe the impact as shaper accounting corruption / stall
    rather than OOB read past the allocation.
  - Fix integer underflow when segs == 0 by checking segs <= 1.
  - Import companion check !skb_transport_header_was_set(skb) from
    qdisc_pkt_len_segs_init() to prevent unset transport header sentinel
    (~0U) from inflating packet length to ~66 KB.
  - Link to v1: https://lore.kernel.org/netdev/20260917122153.62722-1-ndaugoing@gmail.com/

Yuchao Zhang (2):
  net/sched: sch_cake: fix shaper stall on segs == 0 in cake_overhead()
  net/sched: sch_cake: validate transport header offset in
    cake_overhead()

 net/sched/sch_cake.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.53.0
