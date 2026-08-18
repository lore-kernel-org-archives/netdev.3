Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC8375AB1
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068164; cv=none; b=YuJRbUKgLTbcsw67YYHy3y3g8sNlWx6t5xacT1G4jF+N6GwMB+ShUg3vbYiDxgw0m7Of+JvjQhAq0J2ZCeLFvUCZTT95WHx/iFsXe94xJ55G4yMzZOrNCeipu5nifKVqer547GkS2VZiUBYUKRuzKCm5nEjf4Qf61ydDlnrqvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068164; c=relaxed/simple;
	bh=fo5PoXZ5ZKT8MDrEaZn6E4TyN2oZ8TJ4XeZLBR3XSA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uaNEjxo/jpD9E6iVGaSwm5RBEgRJ2bmg1BMrzCGYgpoEK84j+U0m8nS5W5CqWX+qs/w1DoLBjPRBhSR6vpXk9Obm0LmSo+s3Q557/ql4QhjibR28I6IWy1PV+nuwYpkekVuKhjV2oMPRdKMMMPWh0c8tWCTUNoI7uH7MjGv3sYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PylBpURd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PylBpURd"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacb8416a1so47035775ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787068162; x=1787672962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSuvpzf7rU+xT5RM3KODXO3i5VoabBrqOkefcg/k454=;
        b=PylBpURd1jLiVAm8Cs7dCBobDJvvZy9TGx7l+ZjllMkDrnAoBsWnRm0LEitGLy5ior
         fRO+97ovEeHD7R0dkpTMuFZ+EvC90M6hly50UyUQh6uH9UTDJaxcM8TFuXxWlz47vI/R
         SU34n+TfVbXF7KAJpg8htzK4FqwDbv4ZY4JKsS82IADbPqjayswGuWbids6QN4Mbnnwu
         +2LK1O3IAtFa0o1igXqZm9XvG8epRDhBzHB05xh3qZILigP6rp3YgrPmZFFXipCCnaST
         TfLBjY+y6FCj6TXYhyh7fyoOYd+PNDIbd10JnhzysNf8PL1uKAqZoCfdsdFMHTetOXI9
         r4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068162; x=1787672962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSuvpzf7rU+xT5RM3KODXO3i5VoabBrqOkefcg/k454=;
        b=fm1eh3PKUOwr301BpL8hL87CjEjkNMgKjNgHRDACSbsr2zfYO5c0tNDyqYqoh1QL5x
         0vA8HMCCdSHLYz/zGWGjaHP8MZK1MV1p1QfvTtyqrCPj/ScuHF56IxhqrQthBkw4vDWh
         yRhOdgiGHUzE9oMXW/0UxRQNgaGlaXanIKTGRFm3S6AWP9UiSFUvPe+rF+r/o0D3duAz
         eqhSd98txzH937BaI46d49oIEob9aVb/9kRUzbWU8+mwHJxQ0HDVaePulOZb5p7Z2w9u
         0XKsLcEsl2V/K8B+qQVvKDY/SQ5K9Qfd1m9oIWx10/toGBKZzS7XowBdlY5LEERMxwhH
         W3VQ==
X-Gm-Message-State: AOJu0Yy4edSP3UIEFIV2erz8dVLgj9Wi3NUGHgJ0BB2YAY4hgjq8IoCq
	ccfudc3gv7DRNssood3Co/ibF4UQgJaOUbiV5Cax8QBMz+gtQXxsPoO6
X-Gm-Gg: AR+sD11sNZOpylZ1Y5H5VPyZKhZ+Khk71ocf7Fs+XBKdBHIfzWPbID9gBMErfKT59zg
	WUdzPwsOoB4gynjob4xbGIK9w12PNEQwxNWizYVW1gFDxSkaW4BtNCo0sryo9ooBIJF7C6WSoFk
	SpWDsDuRIV+X3e/r0LMpkTv4m+jeFU/rXSm5JdAJEx/OEkQoefPMRBc142qbauOmOuoVFmjzSaj
	4x1f/bAuAiQBuo6Sbd9+YRG4MDbimlPQxgGm8drFTZCyKthg1XeePeJL9HK3WekewWrz+7LaSi2
	TAdp5BHltvQMTsl3Y5T16RGD0d2fQPPtBC+2eRP9WNTzO1eyeB+VisBeYGJwLWEOk17fkexI22A
	j6QtJrkfcPkE/5kQbPplj4veYOtIo6miI+UcdVo57qLEX3DqbyYzAYFfYo74mND5NqeZtpTALTB
	VHN+6z+TQoAourAv2V5VaKVTHGvEvKiZeYnnSECILH/FY9hGZnJjBsEwIDZvbgdn2ZmD1cECpHH
	3ELjABPXFRM18jrepAkxTA=
X-Received: by 2002:a17:902:d4c1:b0:2c9:c517:d070 with SMTP id d9443c01a7336-2d3b0ad45d3mr352820585ad.3.1787068161635;
        Tue, 18 Aug 2026 08:49:21 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.113.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e543besm16937955ad.41.2026.08.18.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:49:21 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH net] xdp: fix zero-copy frame layout
Date: Tue, 18 Aug 2026 23:45:15 +0800
Message-ID: <20260818154516.793517-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_convert_zc_to_xdp_frame() clones an XSK packet into an order-0 page
and advertises PAGE_SIZE as its frame size.  It allows the copied frame
to occupy the page tail needed by skb_shared_info and records zero
headroom even when metadata separates the frame header from packet data.
An AF_XDP zero-copy packet redirected through cpumap can therefore make
the skb overlap skb_shared_info or place it beyond the allocated page.

Limit the copied layout to SKB_WITH_OVERHEAD(PAGE_SIZE) and include the
metadata length in frame headroom.  Redirect callers already handle a
NULL conversion result.

BUG: KASAN: slab-out-of-bounds in skb_gro_receive
Write of size 4 at addr ffff88800cf37004 by task cpumap/1/map:1/146
Call Trace:
 skb_gro_receive (net/core/gro.c:174)
 udp_gro_receive (net/ipv4/udp_offload.c:812)
 inet_gro_receive (net/ipv4/af_inet.c:1539)
 dev_gro_receive (net/core/gro.c:515)
 gro_receive_skb (net/core/gro.c:633)
 cpu_map_kthread_run (kernel/bpf/cpumap.c:395)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:164)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Fixes: b0d1beeff2a9 ("xdp: implement convert_to_xdp_frame for MEM_TYPE_ZERO_COPY")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/xdp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..4bb97790b189 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -585,7 +585,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 		   xdp->data - xdp->data_meta;
 	totsize = xdp->data_end - xdp->data + metasize;
 
-	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
+	if (sizeof(*xdpf) + totsize > SKB_WITH_OVERHEAD(PAGE_SIZE))
 		return NULL;
 
 	page = dev_alloc_page();
@@ -602,7 +602,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 
 	xdpf->data = addr + metasize;
 	xdpf->len = totsize - metasize;
-	xdpf->headroom = 0;
+	xdpf->headroom = metasize;
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
-- 
2.55.0

