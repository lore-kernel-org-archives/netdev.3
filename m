Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66322D7A1
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800738; cv=none; b=LLhlv3iaiNZa29tFucMCbzruC83oDjuTwPFMAL+Bkw04V+XK88DJHnTlIswd7IB77Sfdn7yfU4L+rdLW9qB+cJmh90tDVcn2Ja6r1ONeuRs3qjsomF1pokIaiaQi4XR/+HLtHW596bemmCVp9L7G86oKBOg9U4LFd//wkBSs4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800738; c=relaxed/simple;
	bh=H8dicloFkpE4cuPt4MOZcMsWKtyf8iNrviii2Qsm97I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBuUmws9oj/NEfVkFjEO1ViC9BNGM7O+eABbKBN6aUPbCDYguAy+izEiQGHVoGjEvEPC7H1Vx91tHRyX+0xHseucgV+q//Ma4C0H9YRswVEs25N/zyfPPfxaCszP7VBXaOa6l2OkMikVG8VNzF8U/7Hy2s1bxkSdDEPTVu1paus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctmONGPs; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctmONGPs"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so2171894b3a.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789800736; x=1790405536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xetN3D4D99Kz4sK/DZa307tsVknT8+yfEFtXecX8uow=;
        b=ctmONGPs+3qySuCCRyfTBc1zRmSh5ONYyCqJJ3aVu+uZcGtHqzyyutggc1C+44FPSM
         Qjr3jHUyxY3Liabcv62JVTiqvZ6WW02wWOrB35qBcvgU14ciqsX0go2APgJoaltHaqWd
         fFUKsP7y6lJasT3FPuSbYFafYBHyqP1jX4OY5ZWEKJIqm4Sx3E2L0gyBmcKdWSqS8eQE
         fGCNUrNKdEddsRLz+DozAqZyfNep4slYGLbCAMttBdiYAuiUg88Ngpju6lxH7uTNsrYm
         arbf0poCvOmo9jz/+a/M5pj2FS2j/TtMgwnEyl4u5Wm2jNvmM3L6N1OSm1BF1GTJhhrY
         BQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789800736; x=1790405536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xetN3D4D99Kz4sK/DZa307tsVknT8+yfEFtXecX8uow=;
        b=z5PmSKHb8FzsvlSKbcK+ZLbUM6zTfbyO4yRbmwD5Ww7O6EyhI+OXENbNaOWH1OGxqW
         r2Hnns26ISw9RKthPqxcWS2vITxEdxGDjLdKJEiOADG7UjSm8hqucEAxd8abFLMJ+Uth
         ABUnhr7+8jss9nQvm7gbZjpHd8SLjW5ZfPCHuyxjcGhzL3yOAOUmLTt5LMV3JaW1SpvR
         BmSrg4ohEcFJvaMgrXRkcnFo9i/oq8ouP9x/DXTgdBK9neJYNfRvC/czXUr2u5+22uX1
         eNTDznQVtyvs4sDH7GuBWWVGtx7RiBugkntDCggQUVI4Qeg3dnWxJDwnlKDIwGZ8kJXq
         a1iA==
X-Gm-Message-State: AFuF++lNYNfkR3v0Fm0FJFLa1fyLq8rhWhiXVFE36oeg39HZ6NeFGVHY
	24ZoMy4e6iC/YlKtPjoRQSMLxJZ1FwgX7Kff0aVxF4He09k9NmAkvLEloPeYdg==
X-Gm-Gg: AYBFou0V5kxirNspKRUuBRUKwH4brI2pDfT0ivE0SEbMdULDuBxL1AxvQ36E9Xx57+l
	HJcYgWWkbjKwAaSye/I2sSUWyIPecPfVO7ESps4lEBNJu3WfSokqhaXHMjQXezNfKZHs1xnifw2
	RQycLb87ediMrqo+B39BM4+8z18DguVKmS+yecbkpvEvijc3fQ6MaZY/FdGeZyF+s4fSJ1TBLy7
	sA3ia815zcLl/b+phe4G1hXWNstK8LEPE+DAF3wJ2rIDvu+P93e74XyxoSWw6h3gCP5QDCfFi2g
	wX66B0L+P4PaziDyRz8Bu1VgUsP5JpRH61k7scF3naSLVwfTw1pVli8dtz292xpvbd/rNGWUj4x
	mTfAv27rfLk2JTnvY/NJFmU8nmHpCxAbgLDupjGRXztvMqYcHta3OagwIJDjzyvTLp0bOdWAPxq
	J4a0Uq3suGFckH1Xh5aY5TvBlXxwfmKIgH4L/ZoHTIB3BoQVI3BfVp/FAjZhrcAzni0qM4ryGg5
	DK471uwQGlNLHz6bfdM5VkJLtl6q4TJNQ==
X-Received: by 2002:a05:6a00:ad08:b0:857:726d:270e with SMTP id d2e1a72fcca58-874dea02499mr8194513b3a.26.1789800736235;
        Fri, 18 Sep 2026 23:52:16 -0700 (PDT)
Received: from abs.sf.dndws.com ([50.35.86.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f5464sm678077b3a.27.2026.09.18.23.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:52:15 -0700 (PDT)
From: Tao <gongtao0607@gmail.com>
To: netdev@vger.kernel.org
Cc: Tao <gongtao0607@gmail.com>
Subject: [PATCH net 0/2] net: dsa: mt7530: fix trapped frame forwarding and egress tagging
Date: Sat, 19 Sep 2026 06:52:10 +0000
Message-ID: <20260919065214.31604-1-gongtao0607@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses two issues preventing trapped control frames
(such as STP BPDUs, 802.1X PAE, and LLDP) from properly reaching the CPU
host on MT7530-family switches, specifically when bridge VLAN filtering is
active and on Airoha EN7581 / AN7583 SoCs.

Patch 1 fixes the egress tagging mode for trapped link-local frames in
BPC, RGAC1, and RGAC2. commit 3ac85bcfd404 ("net: dsa: mt7530: preserve
VLAN tags on trapped link-local frames") used MT7530_VLAN_EG_DISABLED
to preserve tags, but in hardware this disables the per-packet override
and causes trapped frames to follow the CPU port's active VLAN table
(VAWD2) rule. Under bridge VLAN filtering, this causes incoming untagged
BPDUs to be egressed with a VLAN tag, breaking userspace STP daemons
(such as ustpd) and the kernel bridge. MT7530_VLAN_EG_CONSISTENT
correctly preserves wire state (untagged frames stay untagged, tagged
frames stay tagged).

Patch 2 fixes hardware CPU port forwarding on EN7581 and AN7583 switches.
Setting MT7531_CFC (0x04) CPU_PMAP alone is insufficient on this IP; the
switch MAC forwarding control (MT753X_MFC, 0x10) must also have CPU_EN
and CPU_PORT configured for trapped frames to exit to the CPU conduit.

Tested on Gemtek W1700K (Airoha AN7581) with bridge VLAN filtering and
RSTP enabled, verifying that untagged BPDUs are correctly trapped,
delivered untagged to the CPU, and achieve STP convergence.

Tao (2):
  net: dsa: mt7530: use consistent egress tag for trapped link-local
    frames
  net: dsa: mt7530: trap frames to conduit in MFC on EN7581 and AN7583

 drivers/net/dsa/mt7530.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)


base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
-- 
2.55.0
