Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598145;
	b=N5AywxVPFAw9vqhWo+YWqFp4fonyBI+Dvvu9tdqzgPaew1IbgT0IczQU3m2ciDstkkV8
	 yWPeY0hc+bV5Ez+PbB4m5nXp+p8wnPVF84GPjCUHHspmdz6p0QB4BS5jGhEJjaw6J85fH
	 1ATKvLJmIlsWNV/Kxrd/QwjKcn7RnS0Qy3363p1FH1PMlg+L1tewlImzIlhogSXwF4j/G
	 AvGtGQ+OHZsSokZqyF+lMKVnEbD+9pwMxHVU8ituUKp/6LM+ItyH0ZEkMzjCkrjIMUanc
	 at8nZYtLellNsafuhDflHducoEk7AEIMwlGn0o4eFL+1RYK8blCG8P38M05TCPCk2/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5vb/fX1w9ccynX7DUs3hjlSnMnkkxJltOf4ogi8dh3E=;
	b=gEfn4lvzaiGPkcLRqGoXPmboQRWxwCEbpy7sjbqzszFqOLXUKz67htxER4g6Gq14idiC
	 bkEBXYOAkd2aLTIP1TDVKZeeCCon0qaR7aq6JzJiMoVDT1k8Jjwv4ZxgmXIvPHK39WDZw
	 KRYEBKwDlrq1ftaJYKdn8CrhJ8dvQ82jeYS/JVMKj3yjIvS+bRD4zB4t4QZqSLzXBi/f3
	 c1S6dvODbun4gKCf5+9+U7XrXTm5PkLvFf/aZj7xdTBnZXOmNT6A+efcwVlrkIbpMMmGJ
	 zLIba4DXw00svsyWFbrxkn/HrCtJKC2cPVFDt4tCCIM1XKlAkx2qXFCyQ/7N9x/4+ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="oP/SAznk";
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47C606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D47C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oP/SAznk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-881269371acso911890b3a.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598144; x=1793202944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vb/fX1w9ccynX7DUs3hjlSnMnkkxJltOf4ogi8dh3E=;
        b=oP/SAznkONuwRnLYD/OUDAZ1F7COCt4M4e6WvBG3jW2KhYAJA9elXgOIMOGomq773Z
         hjmWQwQCy6TcouJq6xYwVW+xR6yYCakqsFsu9c/hYgvA3mK2sADcIVGzS+eBpg84at5t
         /2VCLplG20F3K80qO/H0EwhlXVmvd2/xIDE4yX/kfJit5u5dXx0kfRlyk5CWzR6w0n25
         AXuJWHb67veNyrcGrynIdvmvDbL9rW+p7p6rVKxMqGpITBHgP57kdxz4+T1GSm+WIgT1
         3Jz5ah3IQ5uDkPvyGhr9Ca1vNmcszE4jxG7cGzXUrN1CYG+n6zPsmhC3WUHtNqbmZ4Wl
         Utow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598144; x=1793202944;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vb/fX1w9ccynX7DUs3hjlSnMnkkxJltOf4ogi8dh3E=;
        b=pe6NLOKPyuyzCvEMWiqI43tmgwGqlzZ+lXCy2LJrwVPD5Zmz6v29iZytiKhSiNEspA
         f2tcLv2JBEM8G+lFK3BbzYbwXH6SsT8MUqLX3FZgA4JYtLRYk30DrtRUGBZ0Zx5CUfgc
         HCuFMt2BOB5KdMPFvcTvKjlCoMhGaxdxcu8o4ZCSlR9J6jk9Rt/8haYYiUtUHIDA9kX1
         oe4skNRJJzyfvHlUWtiomk1k8q3j+q2ODF03KBUairqXF1ye9ovhsjfWiOAeXn4JTR8C
         i3mkNzfSDJDkx93RF9m54BqcbbySNZkWJSibbAxsCR0wLC4Umm+gSVYgp8dV7FoqX4Qt
         fGNQ==
X-Gm-Message-State: AFq9FYLN3pYvZipVDMIo8SgUCs5SBJLdEQ0ehJA8KRJYhlkAzvb97/Vv
	Q/DR3s0WI/WYTkXBVAgymHDttaQJ23gCrZ0+X8vkGPLXma/m6CepMIZ3bRSk/bHA
X-Gm-Gg: AYBFou34tPH2XbZ9uBfZXOqjZgKV+uRnRe2zBU7rjM6OUwXCxG2ABUw+1y8yyywu+5f
	o6P7r7Voy6S8pSQzvzaqabJgaqEiUoo8OTnzESwCuwHlHyeSMu0M2iWclKnHIAtvacSjlgeVblu
	LDyovFlfTeo/xNXa/GGuthc/kDPKcmdlCcXIavtooJ2nmvBhSigvXLSZkYLXuWKjQ3rQG6QBW9Q
	25SW/AHlVGjhWC5oINDICyXf3Aypa+eNDNQX5j7xsv5iOl2xHWxYqB75BTdGMzv3Tih4mdwVacI
	u8UYQBccdrq7AABeape6TSA7JrSAP+wGo2sBoo+Dx/DKF65W/hBQopXdgKDh5e5CekUimtcfKTE
	a/GyewAbzEgzRHz7C/Xmx3guEDKml7eFEUB/SDDUVBtd4+iGU6pwOw6hQtuXVLySYslILvFOpk+
	WeIuxcimvER93W6ayjfl0b4KjqcK8g6iEAHTpEZ9oj7TgDeZNQJq9gFOFd/bmfd93hMFCn8Pk8L
	PvoOGCI7EpIommPWclmc8Rajy0mX5ZdIJGsCqSf0lRQTsrwcPpIKlklb2Z7dbodbU+9aWMgImBl
	pxHQ2xEsl6Opw2rH2rJ//GPRDfEy2uyB93WapojQv1whW93H+oZzef3N4mz8
X-Received: by 2002:a05:6a21:1398:b0:3e1:fb0f:9d1 with SMTP id adf61e73a8af0-3e2875e0677mr1297034637.0.1792598144332;
        Wed, 21 Oct 2026 08:55:44 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08960fa88sm1078007b3a.53.2026.10.21.08.55.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:55:43 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net: xps: bound the cleanup loop by the old map's num_tc
Date: Wed, 21 Oct 2026 23:55:38 +0800
Message-Id: <20261021155538.67867-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__netif_set_xps_queue() walks the OLD dev_maps to free its entries.  The
per-row trip count uses the NEW num_tc while the row stride uses the OLD
dev_maps->num_tc, so when dev->num_tc was raised without rebuilding the
XPS map the last row indexes attr_map[] past the allocation:

  BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x1458/0x1ee8
  Read of size 8 at addr ffff000014f69458 by task insmod/112

The loop frees entries in dev_maps, so both the trip count and the stride
must come from dev_maps->num_tc.  The map is sized
XPS_CPU_DEV_MAPS_SIZE(old num_tc)/XPS_RXQ_DEV_MAPS_SIZE(old num_tc, ...),
so iterating the new (larger) num_tc reads past the end.

Fixes: 255c04a87f43 ("net: embed num_tc in the xps maps")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KASAN); it
fires at the claimed sink, and still fires on a kernel built with 4da3b7b8b50f
applied.  The guest has no ndo_setup_tc NIC, so the reproducer stands in for
that hardware with a small module that raises dev->num_tc the same way an
in-tree driver does.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
CAP_NET_ADMIN to set the XPS mask.  dev->num_tc is raised in-tree by the
drivers that implement ndo_setup_tc (the Intel i40e/ice/ixgbe/iavf, mlx5
and mvneta families, among others) and by the mqprio/taprio qdiscs.  The
QEMU guest used for the reproducer has no such NIC, so the num_tc change
was driven through a small module; the defect itself is reached in-tree
on that hardware.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..3023f0ca4713 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3003,7 +3003,7 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 		goto out_no_old_maps;
 
 	for (j = 0; j < dev_maps->nr_ids; j++) {
-		for (i = num_tc, tci = j * dev_maps->num_tc; i--; tci++) {
+		for (i = dev_maps->num_tc, tci = j * dev_maps->num_tc; i--; tci++) {
 			map = xmap_dereference(dev_maps->attr_map[tci]);
 			if (!map)
 				continue;
