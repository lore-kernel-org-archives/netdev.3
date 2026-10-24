Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856524;
	b=UcymUFMpno8MofL3QePXTCwecmd2INJNHlzwxpt/AY74nh72nkuqoN3MZBvCxvUiZRI1
	 CyvYmzwSuLkd+OAxoIAFo1FQ2EgJXsfNKLip9e+Oak3T16y02hiz6gAASPwofDceyJC9Y
	 vTd+VquCxGxSJq4Jf2W5ps+tiwtWMQZKidhU4fECzgIC8+Wv06GcYPzJpED7u8p7peZ0x
	 4SxY0mutlQ4H7CTK7QTxEbIVALJ0RIgU2buv+qVYNw33QN7/bNkfJDx6yu/Ygnt6rSpPV
	 wdvY7emoL9PRJP83ppoYsNtwBZCRObxT2FOThc9B/+rt9/wzlw6Co5496jZ1Zp1uzeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ANXPqZSHJyzWuXCvN2vxk67OVN57MUfNQmVBTDzT6pM=;
	b=yqQc8aLOZDHeConeVZnbxtHup0ZiG3/oMdmhVEwO96RqqYP8qVBNQa9oRIdwvc++NWba
	 dZzjoBDwN5Js/dU1ShdG7tV3lvGOrUBjZMrZKNdIfnChSXssQDyv9arQhZgqU4Mxe+P/2
	 YYaWvUAisRX96CFOkObUCpyXcsbGeBer4tpAeSsAozn2RVPr3boKQldfajnCw5DSTVIpO
	 QWEN2icLw00Y0Gwwd0z/qnJVK19mZFZZ37FyMSwxeFuR4JEkx8UN8qw6nDsNh2thSJhKc
	 iQNo6Se0iHPtOmnRtB7q0dOWEC4KYZ2hA2/fOz+OznlEzC5yKUt1YuOb1f6EAQ5szJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l26u6Qyo;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95226606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95226606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l26u6Qyo
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-369f33df08eso142153eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792856523; x=1793461323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ANXPqZSHJyzWuXCvN2vxk67OVN57MUfNQmVBTDzT6pM=;
        b=l26u6Qyo4VsDmQaHqwSB36ri5GN01lYrYiOcWD7Eq5g//0E6KjMfeLg0rYu0dcLsrU
         iOyWaupPt++FB1O9YhHxy9pmzIzhxqd+E2wKD+g4L94R8hUybkHwGHdHJgCKza3jR1wr
         bpnQDdfIpoxXNa35d/DBjlTkyx4BK4ftM2L8xxL1KBbaICc1TfGxO/vtS5Ey2m8pZ3s4
         L59imEjt5NQl8JARRGu3IapMlKYDBSkCUmTkI+vul8mjR4BElg58JBThFkDWT6TKi+mR
         jUHihECpRPexgF3esg4mIhGY/8MWPYDQKBky0kqXiCtEj2yKEX4531auLfTqc6oaqrEr
         AT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792856523; x=1793461323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANXPqZSHJyzWuXCvN2vxk67OVN57MUfNQmVBTDzT6pM=;
        b=zlJyRRTmvVkXYojVMa8moJrjAS3nTBCbb0SxID0hEhEMLhkC+lgcFDSkW8C55UBqmK
         wNyEJC/KzUJeeNn7RrVdtYn8C/SxW9kcc58uu0JpJ+EBj1tEq3WnPPB+L+qiatXwXzD5
         uSAleAzw4alOr9tWeLJLZ7JpuJlxeSEOvMxYycHk9CKsGi28k1ttQZRZu4S+VkR6uG3Q
         dTCL70s7ubL1xrBPI5kD2RvWUt0RhxgJaLr8D7c75jw59uLUoUvQkv9Uo5hUfN0xAr6G
         edgMl6n4OhywmerJH4pTrleasdrnGxfKeIQHKexpXaHmLJx3Vj78Cw1vqd96q81tgZ8/
         8kAQ==
X-Gm-Message-State: AFq9FYLgr/lXQA93Bvyo4nOIomcj63DjykZSVPSowrbAH5glxtQDmayQ
	Yp7YjZx7xvH5FLRPB+EDi57bN4gz7khvO4F1+w3SoD61Z2PQKBh6CMW/dZE57MZv
X-Gm-Gg: AYBFou3BB7YctvaQsfHU1cP/XaRxCnLrIbzJneRgeb6J2XZ+Fh75g9EYLTEPsnB9x1p
	qbvJZMhYlLDbKxPCt3H4MAZzDMzuHPVxmj21MtGLrT5WL/RRWDl86/0ISiljX3vHmMs3koeYt9c
	c9XSDKa1FpB+TW8ghwhNsG492AL80o3rO09/dKV9Bze1j0Y1E3eFkjO2x4D/QFdyRTcCQxkfCZi
	oh2hIigVDDDXi+MR3hde5KG0A3+I8jsVsgqEGmCEcNzc3zzp+SCnYIbxb1JclUdKBV0VccMGRv+
	ZwATIKNp82xjBRc6EEDHsUgkMSvNKRmA7TpXTNWypqsRBBZxyxdluRfb5XHNouokeBaFOR1aD90
	QhCFWEksfQNkWHbhtia8udCp784bO66Xi0z6N3F2B1GqmCOaXnrmaZW2gSO2bm+jZ+th4Lwvo6/
	TSFEg1WF9CH6rYIljQXlri1varbx5afUBWw0nLJk6GlJ04SVQu1+ueO2O8FnV1lt2XDMGYT7AYn
	FLiMaI58z8D6SaV2GyqiKhXd1OH/r6yZg9+VOxpwC8UYZEJ9i2rtUGORA==
X-Received: by 2002:a05:693c:880c:20b0:369:2040:cc88 with SMTP id 5a478bee46e88-369e86144a3mr3470823eec.20.1792856522555;
        Sat, 24 Oct 2026 08:42:02 -0700 (PDT)
Received: from plex ([2406:6d00:a27c:4200:aab8:e0ff:fe02:33c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm7766450eec.18.2026.10.24.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:42:02 -0700 (PDT)
From: Chris Scott <gilroyscott1970@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pawlik.dan@gmail.com,
	zhengping.zhang@airoha.com,
	Chris Scott <gilroyscott1970@gmail.com>
Subject: [RFC net-next 0/3] net: airoha: npu: keep NPU-shared DMA buffers in the NPU window
Date: Sun, 25 Oct 2026 01:41:47 +1000
Message-ID: <20261024154150.45733-1-gilroyscott1970@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The EN7581 NPU can only address host DRAM at 0x80000000-0xbfffffff;
higher addresses alias the lower 1 GiB, as confirmed by Airoha [1].
On boards with 2 GiB of RAM nothing keeps the buffers the NPU reads
and writes inside that window:

- the mailbox buffers are streaming-mapped kzalloc() memory, which on
  arm64 bounces through swiotlb; on W1700K the swiotlb pool is at
  0xff6cf000, so the NPU version query reads back 0.0 and mt76 does not
  bind NPU offload (this is the issue behind the earlier "use coherent
  DMA for mailbox messages" / cacheline-buffer postings [2]);

- the coherent buffers mt76 allocates on the NPU device (NPU TX/RX
  rings, HW-RRO and TXD buffers) currently land in the window only
  because of early-boot allocation order; reserving low DRAM away makes
  the SoC hang right after mt7996 firmware load.

Patch 1 adds an optional "dma" shared-dma-pool region to the NPU
binding. Patch 2 attaches it as the NPU device coherent pool, so every
coherent allocation on the NPU device comes from the window. Patch 3
moves the mailbox to per-core coherent buffers, which then come from
that pool.

Streaming mappings are deliberately left alone. Packet buffers are only
passed through to the WiFi DMA engine; restricting them with a
restricted-dma-pool or a bus DMA limit forces swiotlb bouncing and cost
~22% of host-path WiFi TX in testing, and the default swiotlb pool is
itself outside the window on these boards.

Sent as RFC while net-next is closed; I will repost as v1 once it
reopens. Feedback on the approach is welcome, in particular whether a
reserved coherent pool is the preferred way to express the NPU window
rather than a dma-ranges based limit.

Testing: Daniel tested this series, backported to OpenWrt kernel
6.18.57, on a Gemtek W1700K (EN7581 + MT7996, 2 GiB) with a 16 MiB
pool: the pool is assigned at 0xbf000000-0xbfffffff, the NPU version
query is correct, all three bands and MLO come up and there are no
warnings. I tested the equivalent of patches 2 and 3 on the same board
with 6.18.55 and 7.3-rc6: all mt76 NPU rings/RRO/TXD buffers come from
the pool (~10.7 MiB used), host-path and offloaded WiFi throughput are
unchanged versus no pool, and boot still succeeds with low DRAM
reserved away. On net-next the series was build-tested with W=1
(airoha and mt76 incl. MT7996_NPU, at each patch), checkpatch --strict
and dt_binding_check.

mainline en7581.dtsi does not have an NPU node yet, so there is no DTS
change here; boards using the WLAN offload need a 16 MiB pool, others
only need the mailbox (1 MiB is plenty).

Tools: patch 1 was originally written with Codex and patch 3 with
Cursor; patch 2 was written with Claude (Anthropic), which was also
used to rebase patches 1 and 3 onto net-next and rewrite their commit
messages.

[1] https://lore.kernel.org/r/atCRsquzA1UxSpCc@mediatek.com
[2] https://lore.kernel.org/r/20260809152813.585797-1-pawlik.dan@gmail.com

Chris Scott (1):
  net: airoha: npu: attach a coherent pool in the NPU window

Daniel Pawlik (2):
  dt-bindings: net: airoha: npu: add DMA pool memory region
  net: airoha: npu: use coherent memory for mailbox messages

 .../bindings/net/airoha,en7581-npu.yaml       | 40 +++++----
 drivers/net/ethernet/airoha/airoha_npu.c      | 83 +++++++++++++++----
 include/linux/soc/airoha/airoha_offload.h     |  3 +
 3 files changed, 95 insertions(+), 31 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

