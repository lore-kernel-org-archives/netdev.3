Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856529;
	b=J3D1XZqZQiF+JuK3O6MiLSHozXeeYsCD/4lmQ8MBFkHOkbqnmLbI3asrNE5iJt7T+sVd
	 CuY12Ads4LSqIKFebhEHmqfxP9H5auTu7QmmdBtaKgCyBCChpc5qTUMpCHrHSrTLLPaOP
	 S+3GVrj70YyOWpikKVYL1/tJqmK92Oxy2UQCWDBcpTUk8yRL78YWbIfnrj5YJoq9oTYGz
	 FdvvXsyraxWdeCGpXMGbjPClwdKeEqmbXL4Xau4z96ALN84b8SWcmkOBerYRYi1UktSAe
	 UVX6hrT3MX0mQ96VDEL3bNf+9X91NFtpJ4SpaC4bu9f1lIHMpBbUpqRnTjvbRLdOS/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y0Zlmu99I73712v7dio42Q8sSfQByYjnANjrYzCm+Jk=;
	b=JrZOnNVX5P79IFKMezN/YA54J7AfX2TFF9fKD/GiZBqP5TAuJT6VJgaBgMlDLJ7ontqN
	 fOtwBK+Pik7S8l18U3Ldb4la86vmxrW82m/JYUkU6ReJVACZl/qVbnFMrQE5dpp9kMCLN
	 QStzW2YQEVdIXme7k9omJw5sq4+opYr8qYhHOrS8FTNLgUZr2+ObZK1nwks1Lvk148Lbs
	 mcG3011NUrmTl+n5iqtQ/ilLDJDl6iAv+vDZuejAaL5fLYKUzcJG1vmRCPnodb6ahHIqp
	 zKic90IFK7i8LnVFy6XAfWe85xfa1p+nwb+Zk/rtuA/M5lueleZMANaviWraYf7Bzhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qz41Bwqy;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86847606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86847606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qz41Bwqy
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3550c917fd3so2679228eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792856529; x=1793461329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0Zlmu99I73712v7dio42Q8sSfQByYjnANjrYzCm+Jk=;
        b=qz41BwqyyY/FmwudE5RNN6xkRdWr7oi9Arxs3n1P7QJxIqvkOF/V4a/GtFbbVr2I5X
         7LrjYuZ51P+zQ3SQ54qtmKVb+nzsDnS1o+00bLzbAeYhQuYkjQM4g3axy3SGvKAgPSWo
         bvWu9kBrGxYUJ5wszVBlDWC90U0uJATwRiniaX4bMe994yBt5dYBaCHx6NnjOai8/7fJ
         V90Xx/N1FnysApb9zYe+oMBuphsJ3UI/BlLvZeNTbGDqhziGShxzOvaDeja9kXxfJBMe
         6cWI4gpIRNzmbYU8/9qwNOuQ66C3gYn2Co/zwoqdsYWOFbdFam3ktXl5hvaphfcy5mid
         zzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792856529; x=1793461329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0Zlmu99I73712v7dio42Q8sSfQByYjnANjrYzCm+Jk=;
        b=hRQj3w/ReukNpvp8/MKb1HIQI9Rqy2CpqhrL9FnIrXeIF9Izy0sQx3wUie8p9FjmcE
         nzDVCq2B/MduRTQPRt99+/33TpCgiknMsj5FaTPThg2/yJfmPUibavJ9W30jIHscIPjF
         nofbKV/7T85zdHzmUgUgkMyCV/xYIvLCCqm1y80oUacuBiHD8ylLyKiXt5Ng2DQsi0iW
         aSfG1fjxanjgW/ny04CQyyLm7I3Bl7cy4qLfvEEhho3XEfiFNcx5zWBMBInEp6u+vNQa
         ctGRxDxT0BTsnKcOTaAu39NEiki2rRSbKhTO4ZJ+HAEmdkZufN245KyRfu05yHYxhw6q
         Sjrg==
X-Gm-Message-State: AFq9FYJJR4p13SAOAzA8laaNpV5MJMMS8fIlSHLHeKgUCDIObvA6mSAc
	zc6gOhWhf0fK2qKjWt0vCxSs8PUEQMVjbIlpcKvBlkQTJ77wuSyTe4KHO9ymW96Q
X-Gm-Gg: AYBFou3V0qc5HFxREn0jbT0t593XpUU0/DLVBkFrNVWsXD79VD04fd5GJmpgSw8VDt5
	EWqjzDXAJkBZ62Fm/+Q3G2UBBvjuSGPtsopfPyeB5qkZdxRK6lGZWQpNCHA3FKfycNfKKOATrzk
	JyMEemmGZP1YCoczuy8g/kzTT9C4AN6cLrumveIIDb8LLU6k0rrM0ArPwEGumpmc4AbkOg3Ly3e
	5iaZd9MtimL2gmoAL8vVteQbsnFF8Bm+oXgANs04GVdegypC6Tw1bKLtF4gAHZg/C65b8XLVKnr
	n9fmiWuyFDbFk1iBVKF8D1EOtyW+DkMO0eyTkS66W2T9RC1L8kcjj1pdLDssv16IUqy9KjZ7VqN
	Z58sc/QgNrBiEF5A0uSTqJEROfSONuPYhHoDuvQ4vmoft1f8QlXKA32EzuxNLOiNBeAAldHFmw6
	D35XWj7q13aR2xFsbuIltw8UoDoGahb+FAFJZqgVW+gfckM8cVSr5FmUByb6VBb6xgOuH5i996o
	P16hLwe8OvStbAKZ/H9qi+TsvcGVhIa++pIiyjc2t4Emwec5tgYGZghKg==
X-Received: by 2002:a05:693c:80cd:b0:34c:fb30:3e30 with SMTP id 5a478bee46e88-369e842cbf2mr3808651eec.7.1792856528662;
        Sat, 24 Oct 2026 08:42:08 -0700 (PDT)
Received: from plex ([2406:6d00:a27c:4200:aab8:e0ff:fe02:33c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm7766450eec.18.2026.10.24.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:42:08 -0700 (PDT)
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
Subject: [RFC net-next 1/3] dt-bindings: net: airoha: npu: add DMA pool memory region
Date: Sun, 25 Oct 2026 01:41:48 +1000
Message-ID: <20261024154150.45733-2-gilroyscott1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024154150.45733-1-gilroyscott1970@gmail.com>
References: <20261024154150.45733-1-gilroyscott1970@gmail.com>
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

From: Daniel Pawlik <pawlik.dan@gmail.com>

The EN7581 NPU can only address host DRAM at 0x80000000-0xbfffffff;
higher addresses alias the lower 1 GiB. Allow an optional shared DMA
pool, after the firmware region or after the WLAN regions, so coherent
buffers shared with the NPU can be kept inside that window. The
firmware region stays first for existing users.

The original version of this patch was written with Codex; it was
rebased onto net-next and its commit message rewritten with Claude
(Anthropic).

Link: https://lore.kernel.org/r/atCRsquzA1UxSpCc@mediatek.com
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
Signed-off-by: Chris Scott <gilroyscott1970@gmail.com>
---
 .../bindings/net/airoha,en7581-npu.yaml       | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index aefa19c5b4..21a1a27500 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -42,22 +42,34 @@ properties:
       - description: wlan irq line5
 
   memory-region:
-    items:
-      - description: NPU firmware binary region
-      - description: NPU wlan offload RX buffers region
-      - description: NPU wlan offload TX buffers region
-      - description: NPU wlan offload TX packet identifiers region
-      - description: NPU wlan Block Ack buffers region
-    minItems: 1
+    oneOf:
+      - items:
+          - description: NPU firmware binary region
+          - description: Coherent DMA pool for buffers shared with the NPU
+        minItems: 1
+      - items:
+          - description: NPU firmware binary region
+          - description: NPU wlan offload RX buffers region
+          - description: NPU wlan offload TX buffers region
+          - description: NPU wlan offload TX packet identifiers region
+          - description: NPU wlan Block Ack buffers region
+          - description: Coherent DMA pool for buffers shared with the NPU
+        minItems: 4
 
   memory-region-names:
-    items:
-      - const: firmware
-      - const: pkt
-      - const: tx-pkt
-      - const: tx-bufid
-      - const: ba
-    minItems: 1
+    oneOf:
+      - items:
+          - const: firmware
+          - const: dma
+        minItems: 1
+      - items:
+          - const: firmware
+          - const: pkt
+          - const: tx-pkt
+          - const: tx-bufid
+          - const: ba
+          - const: dma
+        minItems: 4
 
   firmware-name:
     items:
-- 
2.53.0

