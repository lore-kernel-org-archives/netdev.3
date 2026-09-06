Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B42F12C5
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788674591; cv=none; b=NyVF77o4+npamXLps3DjHaT/XObmdb9fYttCyY/cMhWLxL9mAZgGet/3zfc0oP8aAE6b6UP6R1q1LtcNBp5A6TTkH57AU2DetOUr3OsK3JiU0BvdhQycCndgwkj7Ht2RKCp49vCrWC6pTxkIiEeRFxoCIeePMPcD31mMA7Q01ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788674591; c=relaxed/simple;
	bh=Q2OqRxF07h3GzHgoAkW+d8FdMTnttaOQ5y9/PQKMMNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeXyw0ql5ioi9Qh/+hTs+2izQi2vfkLq1RiBPNP5fa3OxBv/yRxeMw0U8pCO3b8pmSlyc/7Vf142au3VEOlG+6HpvNTOynKEC1LTreyj1BdsDX1LRUoXg5ZUeQ/CajXV+6PIb2zgnUI4blQyZ1+4HKQ3uQzHUcZ6O2f/S1cFqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8FnRJRc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8FnRJRc"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48431648f33so2487792f8f.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788674588; x=1789279388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NG+h0fEWkShkE2dq/JvgIwncxcSUVIaRrf1Kfa8GBLU=;
        b=F8FnRJRcBSAZ0QO6Gx3J1dy8RUY4FbExNXGsiBsmz7K1eSayhjBNQH+0mTrqV8eiX1
         1xTNIhs8gUwZzwy9+cheS6f3kiscxdTxGLXcuL3MEU3q5sVFWtpoAz0ZYJ+0C44X8slM
         scLJ8ExlL8r049KOaAUvqRPH9aZ6y45TH/2MCUqGdQlMtrP4zlKYWDmCA6yPGQu0MTwg
         V3Rww/QnAXOIfV+mgelQ7Sja15Gn/7h6jqhdB8X49Drqi7ZXFVal6bsBEeYvJIFP6Ees
         nHgoibapdnks5pymHLh2e2oMFJGwcmPNw5LzLNzmPkDz9+IdtkJHq5tADHw45yXD1zar
         MI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788674588; x=1789279388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NG+h0fEWkShkE2dq/JvgIwncxcSUVIaRrf1Kfa8GBLU=;
        b=l3jQ7/0SaGVUQ++gFlSGR2/7jV/Sogdof+huO7bywg2AzHGUsaEyhr6brNgiRcdEJk
         I5h7+NE6MWoA4DIXlzM2sJdUeU7Xgjqv6kLMRiNOzBH95lvj+fa5pI27zyGxetnFdolv
         gaOdNPZtUd+uxZ+ATHM92ejqMUxWQhcmATKVr++/zuEuvOhLTr4X0/HUV46rPY3aAUBS
         1mXuKnRq96n9XjPafVpzlOaDTIjWgFHJb1HLE+OKjl2yNAjgV7fWuntkpflSzmeHucM3
         8/TiT/jsa1vD4Q1zXaP3jCnUfQEpoYwt6Wj+oVKXhMNmPNIaPM7zNP0s2kXwXo0MkHAk
         tuyQ==
X-Forwarded-Encrypted: i=1; AKwUvBziJuiQ20C5zwULSxZc1Y7yJ2G/ZaYeatGNQU697dGQhEmUoP5QsQaZWL45FmwzplrFNisuIAE=@vger.kernel.org
X-Gm-Message-State: AFuF++kv+ZpsbTEZxu3HTk3thYGUwPHSBrkNgnAXarR3/QcH+iEdb9JI
	VJXoOME6el5+gZgXFcQls/+l7nNNRlv/gniWVSdZPw0BzMFnaBNdQAw=
X-Gm-Gg: AYBFou35bq26EaA0Z0u7YLiH82g6xPFMoLebrKQWK4PErq45x0WIMWy01xFlr4Ocpzd
	wIbWRZSdtm+Y+UkAs4CiqT4fi/2C6CG7m0pJD2+kQVpVcrq5n+q4FySEMiqK8Xgb0foN6JSvODC
	XbzWcPM08A1wsGI+84+PNeo1lZ19fsBYsfA+STFpsnea8UQ5fqbAZBRBpTmVHlj3BPZdEJTu4zD
	y7wKhwXZZe5EJwymHoLz19st95wV949viOtDUkIuif/5nACaW+d34vHUXY25Mg2WA43TyFTNqks
	fLTzEGk6x/LxR2ga3xK5gngqA5f/9kkYsHh7F42p23GJSUWMaHGCB+gJBIsNBdOZB1TV1esIQZ4
	Aov5wY84vZmYtC8UDaBu8uM5fO6qjjhX1u0t/BgpleopvrLhjRDgerjGLE4gOkZByFqGEqFYY6B
	86NH2E0hlwmn1VsAO9TwtBGF0njwAs5jNgykQNiqOSxj6Y6lAJURA=
X-Received: by 2002:a05:600c:1d07:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49cf86f4fe4mr138838165e9.10.1788674588092;
        Sat, 05 Sep 2026 23:03:08 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm298147805e9.4.2026.09.05.23.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:03:07 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: Re: net: airoha: RX rings below 32 descriptors let hw DMA past the ring
Date: Sun,  6 Sep 2026 09:02:49 +0100
Message-ID: <20260906080249.944732-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906063750.719445-1-sochnev.v.74@gmail.com>
References: <cover.1788286284.git.sochnev.v.74@gmail.com> <20260906063750.719445-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correction to the platform description, and a stronger dump.

I wrote that the images "differ only in RX_DSCP_NUM(); no other patches".
That was about the difference between my own images and is misleading as a
description of the driver. The tree is OpenWrt's, and it carries an
out-of-tree HW GRO patch that touches exactly the ring under test:

  AIROHA_RXQ_LRO_EN_MASK = GENMASK(7, 0)   -> rings 0-7, including ring 4

For an LRO ring that patch sets buf_size to 16 KiB instead of PAGE_SIZE/2
and clears RX_RING_SG_EN_MASK, which mainline always sets. Both are
plausibly relevant to a DMA overrun, so the result needed rechecking with
that removed.

To be precise about the base: it is 6.18.44 with the airoha RX path
backported from mainline, including 269389ba5398 ("Set REG_RX_CPU_IDX()
once in airoha_qdma_fill_rx_queue()") and bbfb1983944f ("Reserve RX
headroom to avoid skb reallocation"), both in net today. The GRO patch is
the only out-of-tree piece touching this path.

Rechecked with its LRO mask zeroed, which restores page order 0,
buf_size = PAGE_SIZE/2 and RX_RING_SG_EN - confirmed on the board by the
posted buffer length dropping from 0x3E80 to 0x680. Everything
reproduces:

  ring   LRO   panics                        overrun signature
  16     on    3 (one with no load at all)   present, 560 words
  16     off   2 (one with no load at all)   present, see below
  32     on    none                          0 of 768
  32     off   none, 268 018 frames          0 of 768
  128    on    none                          0 of 1024
  128    off   none, 273 921 frames          0 of 1024

The clean dump, ring 4 = 16, LRO off, taken while the ring was stalled.
Descriptor 16 does not exist in a 16-entry ring:

  desc 15 (last real)      desc 16 (past the end)
  +4  ctrl 0x80000156      +4  ctrl 0xC0000000   DONE|DROP, len 0
      DONE, len 342        +8  addr 0x00000000   no buffer posted
  +20 msg1 0x2A5E0000      +16 msg0 0x00008000
                           +20 msg1 0x2A5E0000
                           +24 msg2 0x007F000E
                           +28 msg3 0x0000FFFF

msg0-msg3 are bit-identical to the dump taken with LRO on, so it is the
same engine either way. addr = 0 explains DROP: hw ran past the posted
descriptors, found no buffer in the next slot - a slot that is not part of
the ring - and marked the completion dropped, but wrote the structure
anyway.

The panic in the ring 4 = 16, LRO off run landed in yet another place:

  nf_conntrack_hash_check_insert+0x480 [nf_conntrack]
  nf_conntrack_in / nf_hook_slow / __ip_local_out / udp_send_skb
  Comm: ntpd

Five panics so far, in four distinct places, none of them networking:
cpufreq's deferred work (__queue_work), the scheduler's load balancer
(sched_balance_rq), the scheduler's stack-end check (twice), and
conntrack's hash insert.

Nothing else in the original mail changes.
