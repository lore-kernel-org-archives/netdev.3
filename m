Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A527453
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029807; cv=none; b=uTpqNB5XBUcZsWWwe6QMfHTaVeQ/V0G6cDR8HnRFiC4TML8146D4T+NaAPleLjfPkTEoCN0WNke4zt96Z8Y3qPuH/EM+hjbxReZP3C7YLwxc3xynRDfNuO6VdXo2T2llFuseqB9XlPgNy3KjN9yahV3rxgArHlmXns3vwJSK0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029807; c=relaxed/simple;
	bh=INaGmIt0//C93uZOPPIiep3TMeifrVgauwt4fvfY+yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBB/wpKWkuwRNpDq6m8onvQmvkIkendyzAOEM4IMJdaHnEN3B8MjNl+JFI0ZAempUDshRK7CEjEq7dqdOmJ7+6/7RFCqciVRSJPe09WpOj8NPBkoJOWYExBucu9kyxEDP4gtTyMxs8OaMgh5XMTxf6D6HhPV+5JW6iwP+5rb4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5jN8EXM; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5jN8EXM"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso692561a91.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029799; x=1779634599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7WER+JhbZ/KqlU4Zw1Oz1ftuqqMYu4Xbn9qvubzl5s=;
        b=K5jN8EXMBLZhe6vTLC2Mw+UvmuwYDYJAk/4l1MPkcWhaiLC4lEJQoCZzrTDONmvn/e
         RTkPMgukAKfgjD8oi4Zc5WcE0xkKEeUQOhT1B0xghrHvGIi9BwTBhW+koTfJ6Vkwj6BM
         cn8GHk9+36e3hxweBL8kajUU5uCd07tQTTSBHPdsn7TFe1LuWfwlvDLhEAJib+QMek/S
         qopwylK9v3xmrqDssfOc1BedhrRvYiIms8I6xGu4CCU0RO8Zi/32Hia35fBhX/8L/u5x
         4894uAgn8J1biqW1JFSiOtn4rWMKqK3qHcHvm5rly/pgOOEctWO+uxPSar/mCso25hRj
         45UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029799; x=1779634599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7WER+JhbZ/KqlU4Zw1Oz1ftuqqMYu4Xbn9qvubzl5s=;
        b=O4GqwjpaR06Bbu7V/8Cd9FBL3FjN4BkbatOICyXlAeM4JTZJuYxiWShiaH8shGZmB5
         fDfCpPRYjsFJCsR6gKWn8hwLqDrtQUZB6MSWwMLDAizgN14sP1iGpwLCdmNlMDm89RIp
         6qaIA+hKJ6tgw7vASbgJWLKecyOEqAzaZ8yjVKBQP1d1deNBSJAXRyz4LukKIVeqo0a+
         EkDl7vNIAVbM65rwNEu/eeNw4pB7MaUJukaew5ciYs5dChTU4UQoDa9OmgyotBhdfdu7
         PfcIBnGAAmVVHAfcCk7PDNGl1OTTdVkYxz8f4c11EoJCHSCJmDdUMVaxhAVYDzV1O8sF
         UqVw==
X-Forwarded-Encrypted: i=1; AFNElJ9tmue7KhZ1z/uBKd37rYUj4Y32J00lI73Ix9FHFdoVMI6wTtql6xpr1RH8L7D8zfaFY8feiFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxarn7mqoYHwCpNvKK5uHW3q88NgP5jPN0j6LrR4v63iyKAxygs
	sCmfBK/MRvWxE4s64zRwlxYgSEPXypeW+/Tu4SxlIvbvljS/5vC7kAfQ
X-Gm-Gg: Acq92OHTUgAlXOYX4NuR/hC4tPQNAnPrcbM3RJSR79EEyd/gJqb0Yq6VQHnEh9hzj01
	Wa2yNpw3kNE+0X75ZDmC6SRfuV5wsrzjm0bL5Uc/HZgkBHCrPNapC3YsAN7AHrvXe5fThDQp1Fm
	0bdCfdhAOXc+JJTix7ZFbysPanxDu7d4Ps8T6bGsiG1TBL5wrWFItrlSKTebgwf7lieahG6o97L
	u9eUA7NwEGrZRpnpe50SIHgjw6OAUZPz3TXdIZLAlVKRoePjHHUBdstFbhAHOAmK2oNk5OUnAjG
	Cb8x558Dl15v9PEidqcJJasKxxnjTc6XkmYDIOR9Po9uRXZh7L0LSZgfliYd07nFaSNi59et6RI
	wXffdIQluGQtIAhRwuXK3brUAGy4M/vcETKrv45kXB/bRm+6XxOmEM4iiaRQJXhsObJZ3har+aK
	duVhahhA75wc+jN6FAkevJGnIXFku8bhcO0tU=
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36951895b57mr10465826a91.3.1779029798633;
        Sun, 17 May 2026 07:56:38 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm10392522a12.21.2026.05.17.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:56:38 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	mrpre@163.com
Cc: jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v5 0/2] bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
Date: Sun, 17 May 2026 23:56:25 +0900
Message-ID: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sk_psock_verdict_data_ready() lacks the tls_sw_has_ctx_rx() guard that
sk_psock_strp_data_ready() gained in e91de6afa81c.  When a socket is
inserted into a sockmap (BPF_SK_SKB_VERDICT) before TLS RX is configured,
the missing guard causes tcp_read_skb() to drain sk_receive_queue without
advancing copied_seq, leaving a dangling frag_list pointer that
tls_decrypt_sg() walks — a use-after-free.

Patch 1 mirrors the fix from e91de6afa81c: add the tls_sw_has_ctx_rx()
check to sk_psock_verdict_data_ready() so that when a TLS RX context is
present the function defers to psock->saved_data_ready (sock_def_readable)
instead of calling tcp_read_skb().

Patch 2 adds a selftest that drives the vulnerable sequence end-to-end
and verifies recv() returns the correct decrypted data.

Xingwang Xiang (2):
  bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
  selftests/bpf: add regression test for ktls+sockmap verdict UAF

 net/core/skmsg.c                              |   9 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 103 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  21 ++++
 3 files changed, 131 insertions(+), 2 deletions(-)

