Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474912;
	b=TcJ4uBoBawR8FDvN15DVOrpp6UFGzxim22oAb2M6nvgJHAbDxhpyT/V6KBduaiGjPlAx
	 e2fqZNLzdjmCLhiMu7ZMIjPgcIp5JAmjw1Wy/JA8b0xNiIsnUBZ+/t9MNEjB/KBn+NFfj
	 2eH0W+TlYydToqQeCoCE0JtA26gmCEzjRYmIUO7nxvff6j6IeP7GJ1EVFjwaW6YbKtXyB
	 y14Q5+Ki7ibl8XbUTlSsLTRHvK+o1rxgxLPo/NcB96xaGtHh3u7aot0zYZDdpULpItHao
	 R/iwdBEbFvbPbno1PNKDwrx8N/xsaZZZR5IRXQRIH8aC7BlpE0zfkGtkuSvjHjVht3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GsxQU7PCIOfVFnHVCuEFA8lZ75gTP1s3K7X0uR8/ZKs=;
	b=unsj1KF4XOVREZmEkAiBFzNLMPwJBAw+MX3vbFjuPtYSjswnmL9i+WpEXDNSsutIOP2b
	 RCy3DCyG6Mv+r/y8cjKVZRZikO5G8UsNaBnmokG4nC2YDJWP7rqLKH/dyTZnHDb4E+NUQ
	 D8lfZbzBhGa1C50ES3QHvJlkjB4Qs7PJmU75YfAdb8eNPoeLUFYLR6VVwLnnM52ku1Alu
	 pgNTe+adUz+7rF6rGiq1yQmmni1SH4yi0WEKC9vupECR36hKRszpst8ve4nOmZ5ld21bJ
	 BGkr6WcBYUMOGFZts/+KzDm2H65QoERrJ/lnJlhyABY6YTYgHnm2nSH9YRDW5/f0yWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ok8nSORB;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570B606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D570B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ok8nSORB
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36f8cdd30beso7543519eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474911; x=1795079711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsxQU7PCIOfVFnHVCuEFA8lZ75gTP1s3K7X0uR8/ZKs=;
        b=ok8nSORBKrT1BcKGw2b5VQkCgjetLaWPtoTx2ZcMID4k6GbYbbqMm+sbb5WByp/mqb
         BPRjbv5vaFBwW2u5IQh71Nmt3/9GoWLb7yMhHLVwVGOj5BvTR0M4CoK2daub1vERJCE9
         Er+g5HJ028l6yoc1pFkpaTu6+zwsvyUoXZ+VAf5pUu3fMSTHKCoNBsRhbw7HX5wPpSSd
         YezEVKYY7wXOJC8kac08HlIIrdgp/nM1cB1rUJngGaxmsQ88n2axlN7p4/+Wu9swielx
         usuXHrot8mo+oI0hX/v8t8nH5j20M+kIAM4DhNx2QEh7hM2iCco7Jytq4m3qTj5s3898
         hrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474911; x=1795079711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsxQU7PCIOfVFnHVCuEFA8lZ75gTP1s3K7X0uR8/ZKs=;
        b=sofLm0MhBJ3VsWxxUiIaiaayrI4v/G/H1VgWC138Jrf/+NQS5BfHGeH/DKxi/GUQZp
         Ol53WINfc1vxytk4B0nFI82ECqcxqkC6yWwzpQNesiRjQ8MSbDdYYd4bi2H52T3AERQW
         sdX3oiUvZ04JlADrTrK6hOJtE4MhZBAUWbgQs6UHenkS4ckp+U5oEZnfEIol3LtQ4b7Q
         SVKoMl1vlOc82qMUQaUwvsKUC43s+npmU8Ydmigs0jrkcxN4OkgpW5xiqO4jTuVav2Jq
         JznC3oa1bcMoW6Dt36gi9qG7drFyLIkF87SBuGl6PxOXsZaMDmC6tdL/DjarosAb2Mpw
         +Kxw==
X-Gm-Message-State: APuU4Z94fovNiBwy7L/JYoMNpL43sBBEtFASQeXZuORk6Oaf3w84YPCc
	wmkHFc5pdMlr9fBO3RyobH0Aqmftdk+xhaXggbjSix3LrePw1qvTh+dUpgTajQ+T
X-Gm-Gg: AYBFou0S6lbdz+yEkU2T9CLYJwLCbvIqWPOaHqYDExJ0GNBLefLkLyeyXMh9cjkn+nM
	kCGadwVuiTWqKwUczKJPYImZuTST63SZ4/JK7Ja4glufrxDzy7lt13xRzQ1BPEnmTiraPJfywvP
	rqnaPGbWVaz8zX7rko3pHEJ3bH433nBN3Rr1C/tw9rlDDuM3qTtxBKt4nMtB4ff4DbQb8LKX13e
	PqVAQCgcXi2ccsIkVqQqM8WglmND6dqf3nHnY3KZyj72Br6S9gEgoTyz1+8+c97IyZEpMiZXzkv
	MJxI8vd0vmGQxJ8dSD4FJQxupdt+CWXT+B1v/47bEtMTRrNdQgmjoYeFim/oD2KStwSs6f4Dln/
	Qanl+tnhB/cYhrbAfWpWt/xCpnB9REwt5Z5sCTYJsQuplSpDXodmTR1E13Hm7woyBrYWq+EQo9v
	M4TPS9OCLg5iK484qpX2tuM1rxqZ68tKKaXVT96/yHLdtcfj9IgywiFxx2YDGH1NcpTQYmuxK1i
	pOFKvVRLB0aMm/Xw8QeEB3Qo8Ly1lKgF23xiCQqQuYwHOAcV+iUuSfscD+M7YC52NnhNf1NEbIL
	vVKrxdA3VTr8IK+LCRAaUo4MN6mgIgdxOvWsl8iwzHt+
X-Received: by 2002:a05:7300:547:b0:376:a6d7:8f51 with SMTP id 5a478bee46e88-376a6d79070mr7136789eec.12.1794474910716;
        Thu, 12 Nov 2026 01:15:10 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:27a4:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm40096319eec.22.2026.11.12.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:15:10 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v6 0/2] gve: fix RX page refcount overflow with the pagecnt bias
Date: Thu, 12 Nov 2026 14:44:49 +0530
Message-ID: <20261112091451.22969-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gve's GQI and DQO-QPL RX paths bias every RX page's refcount to INT_MAX,
so a single get_page() from the stack, e.g. splice() of received data,
overflows it: splice/tee fail with EIO/EFAULT and GQI can reset the
NIC. Patch 2 lowers the bias to USHRT_MAX, as other drivers do.

With the smaller bias the driver gives up its last reference on a page
once every USHRT_MAX handoffs instead of once every INT_MAX, which is
only safe while every consumer holds its reference until the buffer is
recycled. That is not the case for an XDP_REDIRECT from DQO-QPL to an
AF_XDP socket in copy mode, a path the driver never meant to support:
commit d8a8ca14c937 dropped the queue_format check that used to refuse
it. Patch 1 refuses XDP on any queue format the driver advertises no
XDP features for, today DQO-QPL and GQI-RDA, so patch 2 depends on it.
On GQI-RDA it also stops XDP_TX from writing into a TX FIFO that raw
addressing never allocates. Trees before 6.17 still have the old check,
so there patch 2 stands alone.

v6:
 - Patch 1: say the check also covers GQI-RDA and why that matters
   (Sashiko). Message only; carried Joshua's Reviewed-by.
v5: https://lore.kernel.org/netdev/20261109100437.331423-1-amaan.cheval@gmail.com/
 - Patch 1: check dev->xdp_features instead of queue_format, and
   reword the subject and message around that (Joshua).
 - Patch 2: name INT_MAX in the subject. No code change.
v4: https://lore.kernel.org/netdev/20261106114551.212675-1-amaan.cheval@gmail.com/
 - Add patch 1/2 blocking XDP on DQO-QPL (Sashiko).
 - Say "overflow" instead of "headroom"; use USHRT_MAX directly instead
   of a macro (Maciej).
 - Say which trees need patch 1, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/

Amaan Cheval (2):
  gve: refuse XDP on queue formats without XDP support
  gve: fix RX page refcount overflow from INT_MAX pagecnt_bias

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_main.c           |  6 ++++++
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 6 files changed, 18 insertions(+), 16 deletions(-)


base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.47.3

