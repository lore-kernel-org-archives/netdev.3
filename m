Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8F4B3364
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660436; cv=none; b=pm7BsO9a4xqpJBGVfzB93esMgkflM/nJlK39SNh8HDo33Hf9oc5kVUtTGgLQWAPsecOXYslcsCj+56Kf0FlIRxO5CKksOuOMx0MjWHjbl6FupnWXT1RVOYJRvo32GRnNdJCCBBOsn3hG3hE+iDLdJkL5KyQchq/6JZqpLh4sYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660436; c=relaxed/simple;
	bh=ec8nIuloHgqueuWiPectNTRxxXUD0xgmT3NqvP+fKfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yj557RdNSlO22JN9yfhozgy9PrGroAeC4ZLuwLL+3gsscx+UrFlboKh+jGO5W8O1JoA/cx53ek9gUp5DnF7DImgJWiAuFsgpXzeTWVhxOcr3vzQo3WcWkS2OvmrFbjIt4hcPW32A4osA8pyXJc4CcC2V4U/4mRn/bLocZ5z/q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Y4ySRClv; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Y4ySRClv"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-351767ef18cso2539450eec.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791660428; x=1792265228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfk5yrsogadbKnMj1jh+Cdq2RJyiLqyab9B5qMCFxFw=;
        b=Y4ySRClvRZCEAae9QBepinQAifx0yP50BtxtzBLVBvv2I6OIVHtht6exZ6QjU9XwOl
         7q/CxcIep1e9W1wCts40cUlV5Arkba83GQkDF2NUnTlPufmyCvcgt2aR2DxXFelcLwk4
         C2fNAgPhNgjpdTYJYG/Nu2Dvqco0HF6RjQkPns3EP73ehuoVxKsn48BqTXV08RDgFYD4
         UAzuvG8D6BFSrS8NDHx6Y9XQXYdem/KYiyJjaj+Q0Ynros2ob5dRkM+hG5moYDrr/z6w
         W/aFZEH3cQ0uuc++i0MsqczDi9aLO+/PB0qnZrM/MFGhOROa8E8wVsVjij2b+1acIEsE
         dtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660428; x=1792265228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfk5yrsogadbKnMj1jh+Cdq2RJyiLqyab9B5qMCFxFw=;
        b=ZDNlglTCJhOLFw0vRUmT3P0LwlFiXZU7UXAiwXyaIZCYD6L+mi6DqCU/rEvpi9dVls
         LOFhAIjkfQVt5hAX3Ln7cpnkAxtUJ99MzY1870eQ+s5mMxYiRP2ihVLOMQ0z9uD5vsKd
         ffgD4rnlnI4sK/AWiDTV2xWYcf61EYNF6pxcnDf7LDLoVDUFmjUvxpuHKtzZwaiJ9YbU
         bkCnz/R1KFiL5o8z4X5FMAKJueQ/NuMP8v+ROAE9x+AOVsD2wsZJG6d/zWjITM+IYCsF
         gKY1HjJ+4e4zwoM1VuAKS2GoPwh0472JCowpXKs6w43uLD0U1YbmxFfVAWOZlnuNCXzw
         iE8A==
X-Forwarded-Encrypted: i=1; AKwUvBxD1S675enkArDI7gOehncOklbvNktYzBkPnFTlBkId3XfpuvvA5FS2eWT1gQW7nj/7RaZVk0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIP5MSiL/hXz0/Sh3N+qN+PUP0/yuGFR5GxKjU/ZquqI33aGHEE
	N7CehtHzn7Xfn2LYlqFUw71KhR3Q6D2I376sj9vS42oIgMNVfxjwCwYXVb5fBvxbUWE=
X-Gm-Gg: AYBFou16LFGQBAXJP57ohGQYrkBzzFqN8g0gu+IpjkdkePFYCBCRGCqOPbRWblc5BvL
	qAjImKsGQwQGIMvRJR2xXfdHHtcQXI+EL4EFdysJmNcjkmrgNZkGAeoW1838r9xrNPBP78bobzg
	qDkSRLw20R8sVx/wxL8Tn8+LoH9o9wM5xvmkOrel26EZn4vT6D5XXizzTybjxxciC5mYa/sBD/Y
	sMgDJ+MIQE9hRllS45DATCl7HhmcskqgBjDBrfciet/5IcbGQx5uIDEH5/8lUZr/BJor8jJEwEF
	mzqfMCCbRXjfGGhd1P3fXtx9Fp0RDZRVbJSA+PAT/aufkw2lEIk19i21WGYDeVSoxRTaMO50OE+
	68snC9g36dSwInv4Uo8l8Ths2T1tywKiNuJPg9pnYOHP/1RomsBN89ofsM9EP9cvZam6lx3axT+
	HVcXXJCSC5oZS0IVVs+FBFmssuG32dFNt4FtrMHtuzQCogiM2GtD/uOYmF+pVg1JMHnm/M9WS0m
	TAeXZtRnfU9Z28q21LVcw==
X-Received: by 2002:a05:7300:a92:b0:351:4d5d:39b7 with SMTP id 5a478bee46e88-3537e0a4a27mr8108185eec.38.1791660428253;
        Sat, 10 Oct 2026 12:27:08 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:9657:9541:a576:7d2f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm18641806eec.10.2026.10.10.12.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:27:07 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v2 0/2] eth: fbnic: validate the Rx completion path
Date: Sun, 11 Oct 2026 04:26:48 +0900
Message-ID: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is v2 of "eth: fbnic: validate the Rx completion buffer index".
Besides bounding the completion buffer index against rx_buf[], it now
also rejects a buffer-descriptor-queue clean-up head that falls outside
the ring in fbnic_clean_bdq(), and sets add_frag_failed when
fbnic_add_rx_frag() bails on a buffer that was never set up.  Both were
raised in review of v1:
https://lore.kernel.org/netdev/20261009175358.1598001-1-yhlee@isslab.korea.ac.kr/

Patch 2 returns a page-pool reference that is leaked on the
fragment-overflow path of the same function, found while auditing
patch 1.  It carries a different Fixes tag, so it is a separate patch.

v2:
 - patch 1: also reject an out-of-range clean-up head in
   fbnic_clean_bdq(), and set add_frag_failed in fbnic_add_rx_frag()'s
   no-buffer bail.
 - patch 2: new.

Yehyeong Lee (2):
  eth: fbnic: validate the Rx completion buffer index
  eth: fbnic: return the page reference taken for a dropped Rx fragment

 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 40 +++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0

