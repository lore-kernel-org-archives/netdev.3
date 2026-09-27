Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0B3EF66B
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790514631; cv=none; b=ebFyCSelQvdymOP0PrHOhdT2lwD/gMLAnBnBQyGsMpZHRBm/Z8mh89of/cNtb3zGwPDawx9/wlxA6QX0lVQHv3KcR79OitJ6K953i/diBaVaQ1uemWgsYFkIsca3jDYLn18J4FhYUPhNlaacz6uPZAhGMj75TKMBJlUJOv3NCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790514631; c=relaxed/simple;
	bh=HBEZ8gvSuuTPFRjoDeYmiebMx2iMq5KUi9vEstX2HoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTucb1VTsu2njIuYJTepFheTzB42YPyTDhc4MQ+o4CMg9CE1nabvEiLSmDMBqbcQSw9aDMQ/dvWP0IagUwo9jbZIU41heMGyMEcaU3A1UtT2TkBFCAMscV6TxkZ0FYL8NQ152WFZ202HRClP7MALU1l/WCedp5Eoka++Pk8GEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktd/Ke2u; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktd/Ke2u"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1438144a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790514629; x=1791119429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bkDmzZIfjmIBLLdMK74q6txJ55ZXC/oT66ennoBB6nM=;
        b=Ktd/Ke2ulLTbNok0HLAA7F3DBiha7pSO5tXXOAW6iMLuHYuKRH6BT93iJnlgZMEdUa
         b4rIOmhNg3rU8um8FVopGudbry66y1iftvcNVHX96vSI3Ue3z3kkAQuBRz+uEB0WDt5P
         u3XmALWq1EPmZyzjvSsl1oSchdrORzwzJjjCv6lmNOeUriKtPkxduN7dHcN0X7q/CuUh
         HmJ0C2B+bHdnWx1yF6E3mOjXHSKEQJs78ppNz5u8i8vjhmFnr6+4eRrRNRfriXgLIGvB
         DEfGUVx1V39Ib/Wb1xSBoEOwWv24Wbfy0UEBGXbJixB2sTC4h4l+rOWxbQC54QmA/Jtj
         NcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790514629; x=1791119429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkDmzZIfjmIBLLdMK74q6txJ55ZXC/oT66ennoBB6nM=;
        b=h6dFCXpDeet1sbQdEpSokk5PHA6E9Y1NuZqbvZ+NQrVEH0y5H7DyZcihfM5lq/O9J4
         /dTstWRsZCshCsGnI8Qvutchvf7O6gW6VMfbmoMEOE1O6wA623vne3soP8b5mFsBwRJF
         MYDRgusbCke77AD4AZrhTRS1NymVju+beBITb8jybA5E8BlvwOVR9VBpXL5n58CJUCp7
         FL4VLH2VF1IOz5UEmlXIb3mDnS/r6XzuBWMvsm2+chqcLOI60Bpb+XasNf8oxLdzERJU
         Ib6ZqWS18GevcsN+zf99cgEoR6BUq47CT+gkxfAuY9tEowMPNgXyREWmOPcyZlCghoVf
         fHBw==
X-Forwarded-Encrypted: i=1; AKwUvBy+TNCA5B+Jp4oAmhqQKwNX78nFJxH4dFEpETzRz+VFnCB9Q7VNjKfeGtF/TPait20PARLVtBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRFbQ0V+1DDZ/D65H5qcuQkzSnnuriHYhaLHs2nkzN/WQK6JQJ
	olfzvcDGydQ6tY983SnCk/ndNsOdh5D+FMAsp7S1N11gPXtmp1ZIPlHs
X-Gm-Gg: AYBFou0GWzh2U1bAzTZRQOGCakh7qELbIezHGiPy0DjvzsKMfRHk0GcPfCC6k6DD9VA
	Px1DRG8JXq8pPjLH+t/gxkSBf8+f7suIZr2ic9/1VLW0hPUzDk3x4g0Bx8N7ktg+AAMAOO7icHI
	qYiq87BLUJim/jlsJHhxJ/F5r6CiYSPDMNv2E26K2NaR77rZVUJ734XqKE877ZJOdkxc7OvgYGZ
	gDrCTzZlW+vKZw18hdF8P12aqQXp5ZuxbP7EuOODcMAHUBnGSVNES/nyN1RxZCA2vT8TSwg58TU
	EV7uPL5v6kyboArbyvrog1VyYdhCGuc1xAjAUIgj8M0kggaGBDAHS8CeDC01VrzqaxEfnhr31Pj
	uN47iuT1BFDEqqbXBN1l4WJBXY6D6p3CypVtbVOmalSolpb0M54x37KQyTkUxJsN3GqgzDO+luR
	oM1HsJajdRgE+VNgQ3SZEzxBKeW3BXvGVOYs+YrqmqrUsDjqyZyqT44CfABINuBV/Hc/DH3gq+d
	dHlWNPYh2xrHOXjGZNsKU+tGbcZbWUf1io=
X-Received: by 2002:a17:90a:d883:b0:3a0:2900:f577 with SMTP id 98e67ed59e1d1-3a098dff5b4mr8264184a91.51.1790514628797;
        Sun, 27 Sep 2026 06:10:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:84a7:e3d7:8c7e:980a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm14890506a91.10.2026.09.27.06.10.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 06:10:27 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] net/sched: sch_cake: prevent shaper corruption and stall in cake_overhead()
Date: Sun, 27 Sep 2026 21:10:07 +0800
Message-ID: <20260927131009.24250-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
hdr_len >= 0. Both hunks date back to commit a729b7f0bd5b ("sch_cake:
Add overhead compensation support to the rate shaper"), so they share a
single Fixes: tag and stable range.

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

 net/sched/sch_cake.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.53.0

