Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF633688B
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822061; cv=none; b=IH3WZr5B102tOgaZ/S4z+PxeyXwRpOozIrDUXlGYkmz++w/fPFxflWTh2F9tsPFbEr+WNGQP31N7MOCeR4v6oTsl86/sJ2ESKYKnoUS8gLfACuCjVEkGM44cY1XKLe5hK2vsprJXJ7A0nsa9ZjrY3DqBw3Iz8sJLB9XVA2tjZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822061; c=relaxed/simple;
	bh=+HpGf3LoSzduFxk132QfTs1NVy4vbdD0zOb0d/ZqjPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snI3jfz7yTXpZFlVEyBEgCsi3g7RH6BhhGcdj47q2wLmiGZ0jzKzcVfj197tvrYAjQe60TGbYxAOnqUg+z1ETG9W0WMbTV5MAw3BsQ67yRFb2LWNUKcNF25Q5/EZfNOxsD4lOYgEu2wkEGgF/J5xeHbl8VQ2lgRHLJ+JN6tiCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3GPIwQC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3GPIwQC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e507b079dso2987864b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822060; x=1786426860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVYoynVbiX5DkPohCYrGWG74ca2waR9to+ufYwdKFiY=;
        b=E3GPIwQCNVm+YqxS+ydy4QDGcerW3x0UUcjMNs6fRL/W/kbBFU+ztm8F1LhuMqe3YV
         PG+Eprk2lTety8jsAlecig4HIkCFTKQxKHFaCbLdYidwCRDg8OFORm3Fyj1daS8D22Gt
         e+K/xA9KRV8rGAeUZvx595OGS53fONdIcNzZgPDUKPDHqFNw2YKNw7kvlKYngyHeWoSq
         0R2e0Guamp0hpWkkcyAbCWBzy8hAcjS4JVFwhMGhl2sAdVN9TSLL4ctyMG5WOFrfkL91
         mpz5S0BOP1ZpcIYgrwVhChtgF3lGAglujnuWCBsA2pLn1hqpFzvddyXf/s3fokEeU6cO
         xB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822060; x=1786426860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVYoynVbiX5DkPohCYrGWG74ca2waR9to+ufYwdKFiY=;
        b=aql992pSWrsbctx3Mj4rr/n04XCNHKeydcI7/TmFMOWr7jdNc5RLNAkhtiB0jGMhNt
         yC6IYhjPmGFVkAXE61kSbHI9LqyPtn/evVsZ1ih4p/KPZ/xBjKZYBuRQOvnBm9NIRv9d
         pODhGS1c1q7FjDfZ6n4AGGFJNv9C2vK9U9UWPXoQZOmpM9XryYLAypDvL3VSkYY1vufI
         D3IXFyghUVjQ9UwqSGsckNon8Xe45SNVdY+3NWCVpqj36gHlaLUYhk+3VKB9lbjTEinZ
         5dxkToCrVxB4eLvD1yrFniLTbyOuQ07l0WRu4wOEgd2Y4tNSDMdsibfLHbQTN9CDcTt3
         bW/w==
X-Gm-Message-State: AOJu0Yyv9b3SOjLe/RDdKbccBP1HbOBDT7uZOJoWKT9vY4Ciyg+BYHNS
	Y8r13unFK4Or+sLmqNrRfS+dmRBfQZymgAM0AVN/CewXrP9HZPo/w3WoT5y3jRcnS7Q=
X-Gm-Gg: AR+sD11dhEQz+9BAuchfj05Gk7e3kMS1QMCjklzlpbb9H+dqnk6qhEZG3L7nltlavVD
	O0fUVAkWa0xk80UPAb3flJY9HtLcHrfkN8upcGFFhPxXhb44ctfSpzGN4wJchx028+OdDRmN1yR
	BVwX2tTMKlZrwi1+Z7MI9/1HTliEnKiwBZL6IShMg8NXxQboN+DGwik4Palg/+NmU/bqG1ALJhn
	ry/ZeqQinSisR7coXIkLaTzqmY7R2uCwa+vPbbwTMszII4olFAC1vJVymGt0dRJCP/PwyOShC8o
	onGJscbMSG6XuZI+/KIkf5JJLDYldLWI+bkvllZ854fy/pY3eXKh9+iJAq3dTlLD39wN2mP6Co4
	53VEgss0pqmYj0ADCCm7eDsLf4LeuMFpePvQBj1svU5typqeBceo47ilgZGFVatepadfcG1brB4
	2zq5GTnrpASnYF1NLBWgwJbMP80hEDb4j5E0U9TAD9rhC5n37G0atlXqCnP5KFG7uNL5v+B/UM6
	cpS+Hnc8DiG+CJaMToD0QbDueOcncnapUZ8zwtXPThT5i4KvnftnnDawKAx+phg/ymvV3cuLPNn
	l9MYdjfyvW2Gv0LMfoyF38A=
X-Received: by 2002:a05:6a00:3d44:b0:848:7731:d95a with SMTP id d2e1a72fcca58-84ee48bc67emr11526034b3a.37.1785822059843;
        Mon, 03 Aug 2026 22:40:59 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([60.168.97.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe5702bsm4678737b3a.16.2026.08.03.22.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:40:59 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	stable@vger.kernel.org,
	Mohsin Bashir <hmohsin@meta.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net v3 1/2] net: fix skb length accounting after generic XDP frag adjustment
Date: Mon,  3 Aug 2026 22:40:38 -0700
Message-ID: <20260804054040.613675-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
References: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
xdp_frags_size back to skb->data_len but leaves skb->len containing the
old fragment contribution.

After a fragment shrink, this makes skb_headlen() larger than the actual
linear area. In the reproduced UDP receive path, __skb_datagram_iter()
copied 1024 bytes past the actual linear tail to userspace, starting at
struct skb_shared_info. The copied bytes included the affected skb's
nr_frags, xdp_frags_size and a kernel pointer from
skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
amount and truncated at the end.

Subtract the old data_len before replacing it and add the new data_len
afterwards, keeping skb->len and skb->data_len synchronized.

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/core/dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09e..5c37cf6c4aa1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	}
 
 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
+	 * from skb->len before updating data_len, then add the new one back.
 	 */
-	if (xdp_buff_has_frags(xdp))
+	skb->len -= skb->data_len;
+	if (xdp_buff_has_frags(xdp)) {
 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
-	else
+		skb->len += skb->data_len;
+	} else {
 		skb->data_len = 0;
+	}
 
 	/* check if XDP changed eth hdr such SKB needs update */
 	eth = (struct ethhdr *)xdp->data;
-- 
2.43.0

