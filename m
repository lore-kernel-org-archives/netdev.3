Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD593603D3
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294071; cv=none; b=Ety7M7ywlsqUQ4YqNQNncRJV2x1NpjwvsgURbSIvvbuQgrF64MD/BMXjqilfA0vceSobVI3F1gUZVtAZlkhg03BH25x7kkpGKpXuZHzA1QHXfViRvjzX1qOCuhymF4nUcgsuU26I7xeTS6+dYzhv6mC6mPX4mEh86nB7goEnNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294071; c=relaxed/simple;
	bh=QADeywbTPdfKB8Qp6OcHSYccEUAFfm+PWOQ/PnFtrK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ui53B3DiMNpgSIgdannNTHRXnYrj+Y1del8M7vfxI2r/RsG01/lHNvoS+cX5gdU5cuuLDfPeS0lJswE++JnqY8zH7J3mT14jRKPeWkKW8CWCrKLSFYf3xhtpX/ocDeDkprtiQjDo7W82Z4M8x6vyv6tjZtA0nc0/AlhzOgmBHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfABCdKF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfABCdKF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a3e5ca66eso54251b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294070; x=1785898870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=bfABCdKF1X5u1rvpnwEtk3LNgv/n9zXufz/o3Ort5I/pq0AHnokDbemxXR+Pio8s52
         RaTEi1rJgC6NaBj9LpIal97z5SQneQykMuRpOQzk5uf7OcaHwPgK8Izd4d9ocZ3+tHRb
         EDWFRLFe2lRAg2XVbC+JWyigs2INIwK8ggxpGL1+f3yyGOQTWxQ/5qHU+QLbFFXHLAeW
         +wHMeCOlxmzR9lPJ6fMeHkJEwkwMxmgj1qhCK1CF5C+sAbFngPchTaV2FPxyUC+5cV++
         7ocoq0xXPzjUnvmTfcVJU7GQAHkchnmII5TmP/RXZjEW7C3xoL0VZxGqhAcGm1IF7bW2
         5f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294070; x=1785898870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=tBh1Pb48vtEq+xd7FJsX9sNHeeD0kuZt/g6SwKZmWi3YL827hqRmIeL/lkgLS4rNNm
         TNOaUcqjVQjQG4LbBkb+COyoKdfKYAIxc6vzzljzfcdJ1nDBogZ7RtQSlFtKiAHtPxnX
         cxYE9CcF0iA0yaaPw9hVcFnIefcVm0Vf1yNOramkccySbhz6fybodCi1bfZJ5B9hTRTk
         F6yO2lDvNMIYI/UG8ajxeKfC1cn6FAgJZbth+lqePNTM/6gFbofkLjzjEL6+nFymkamv
         C//MArEnQpRNQxDfQflTcLDdgeBeDij3CsklxWtHqhk3Ek8l+WmhRjtla5j0TY0RH+Pl
         exUA==
X-Gm-Message-State: AOJu0YwEhyBgUU6JYpYiK7daSwCKM02gC0ptyzGr4yalDS993TMS9Av4
	xPQs4Ch6jnhJUYwEDY11eG3kiD9kFHHcUIKCv0Q5R33E5qAhqu/77BRD1FsF6sJ7
X-Gm-Gg: AR+sD12Ql9Ni0nVLzKlnyI+v6zzhI0Fz3pltqyPGZAQoHxG7qXvjCVbtwMAz/R0uG4O
	xi8CM/F+GC1sRr+n2gOHHGmB7oh8ZhY/hdMP0Gr/Tez1RdQRW+l6eRnW1PmFyHzc7VEb8pTOFyF
	tV2knHKeKZWutyBAXPBAKVIcIMpmMCEFtDLS/EfGbN7Rved3T2Y/5C/sy9qnhEp+enJqEo5eipw
	SUPWuF7VVfxeqn3YswxkiFR+iyKWYTudMGrUzD4sFeQ4gtw3jEVN+L3PT4W+YxRbii+zTq32+3H
	EPKwP3PPNDTWihAgLmrNcw5OrktRvHrLOiA/iqOa8dna1phBxQavwADx4vPnyl9hYJ+87do2toD
	rq0MCc2chNjx2Vus9v+1FonnJOjO6iCNeXxXHonLBK84BXHhSaMv3zDfyc3HyovaLG0s9g56MmR
	X4OivenrFKI2NblXErr56Kb74y6jRiE/1cbWz36mM06cNoE8WV71AIrrXVJlYkqDu6xAOvQu0HO
	E3b3Ot3Q5nmanJuqGy8Ch6ctR/GjCIqFTaFvebVyo48qnGs9tovRmByOR1NVlM=
X-Received: by 2002:a17:903:2f07:b0:2cc:d6de:d58e with SMTP id d9443c01a7336-2d015c2fa1bmr45167035ad.4.1785294069801;
        Tue, 28 Jul 2026 20:01:09 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf4bfesm4086165ad.58.2026.07.28.20.01.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:01:09 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v4 0/2] packet: use consistent hard_header_len in send paths
Date: Wed, 29 Jul 2026 11:00:53 +0800
Message-ID: <20260729030055.21334-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_PACKET send paths read dev->hard_header_len at several stages of skb
allocation and construction. Concurrent netdevice reconfiguration can
make those reads inconsistent and cause skb headroom underflow.

Split the regular and TX_RING paths so each patch has one Fixes tag.
The separate SOCK_DGRAM consistency issue between hard_header_len and
header_ops->create remains outside this series.

Changes in v4:
- Use one hard_header_len snapshot throughout tpacket_snd(), including
  reserve and per-frame skb construction.
- Carry Willem's Reviewed-by on patch 1.

Link to v3: https://lore.kernel.org/netdev/20260728031345.49562-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 +++--
 net/packet/af_packet.c    | 46 ++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)
