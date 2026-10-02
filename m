Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791C43B3EF
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971175; cv=none; b=DNmi0ZAW0mALi8sMG+ZJpYJIgRzMHKHvhTeXsMEjtOq2ufy/9iYVNjJghNEh1k3AjPwQpLJ1b1wH/SUqI5ewMf4EUzN0yeESd1pSIDes3Ow8E3/OD29zxS6xc56C/j/Yg1Pg9xVzLEr0QX995T3m827dh3DvoHlNmV60MDjxsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971175; c=relaxed/simple;
	bh=AqdfxWHpA6OLvrsqalu0CpHGcnApIAQPIOY465Aydy0=;
	h=From:Subject:Date:To:Cc:Message-ID:MIME-Version:Content-Type; b=l0nZoOoNUORfiXMwmo/CZ/ykp7MgzflWTQ/odB/reYsTb13AJzrmMIy7d6FnjmVYZsRcfbBlH7n4z0jGw1TCZKPg7dUkLVxwggQsh6yM/zdUJgAiWZYx40T69DMiNhD0SpzYZhuZzMuuNbeBLLa2CD4wzmglcrWxDQguJaFMNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuPZejgx; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuPZejgx"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so33828535ad.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790971173; x=1791575973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:date:subject:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6YkNySkevaXFzq9kUZiGhus0grokqN1L+vX85xfWkY=;
        b=kuPZejgxck3giYaFEc3OpN89nsSoZu8cgxq18C7v97xRXGe1EmgYaDYFVCbPdXJIM1
         cqNg1hpIocu27/85GQBWgzB7Ojl42eJ0CQtUvJsygsRB32WRdIu/r5nMFIsPDUkuSIJ+
         fhyQf2iASfRc9FpC8yKWut15SlPc79/LvcYN+hvHeW7WRaBlCl6XQd8J/X8N2dXE59qK
         FKqHnV8qiKhPV1vRFigERCiN8SCYYR7xGApKQjZo9WhglcuQMSGSE4juKnk6um5Wth09
         wAtIQBDcZ97aFVpR1cxy/8+3ly2LNab1iyY2uhLK8H3echFk5M7RzPBJZKjuj7B/Ewc7
         pyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971173; x=1791575973;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d6YkNySkevaXFzq9kUZiGhus0grokqN1L+vX85xfWkY=;
        b=0equspQN7/7vbDolMCwM7AnPTZ8nZWuvFdIeuMjq6z1ha2VHeQO/SIYpAmxCvmBCpx
         a4rkBxR7xz+TlxVieZuMpgdJPXdFvLjGWTojFggFisZo0RJN5W1thpJ5nJ8PItcNA8ad
         VvVaTbikW+B4OC+8mADLe4OMD0CnsoQ25x/4uSggp52nxM7HEZgV+mw/rL1buVgQRVQI
         zqZ7yHEpCYYzTM3bryAOJZgXlc9yv80mnr+SO8g7WHlPr7lin1qWDq0XiCwl7LRDQBvO
         3r7WLXJtdcfD3xRFRFg36sA0WxAaPyVDFf5JenkLsvCwD6aw4Mb0zcXDKGHpvqmaaeDo
         vtCQ==
X-Gm-Message-State: AFq9FYLTu2iA1xsKH4eU8iYZhAklqAFW3KuUQ51qVaN2wSzAXIjIGuJb
	k2pDy7yJygnerYQF9N58OjnAny2/4ZcV7ATqbPIm2/m0FPDvdx8f84zO
X-Gm-Gg: AYBFou0/lveK0fQV8iJFgG1FG0D0ZgwnhyhHsQUff8VPmUFoBy7Rxd99JdoIoACAxAI
	2kLJncaC+sAcCJgE8Sigepxkm8W3phSmFKeaTi1aKLnPq4NiyUWCAC+9UDf5lwX0u5QTBxxa9w3
	wYKhSTLfjrWMoeNGDmRQnsjw/wPp400W6aPSFeJDqfl/ySxTZoPfhc5CvuvpmpA1/GMbcba7Vfg
	7uc3p2zAdEBe5hLCI+7MxakVq6K4kaxxHOTE6TGARK/E2El1h+ZSVkTNkr8j4OieQNQv8efZ3R9
	1rm3P37FsIgyITBYM90pOp0Dh3ZoGjsb8wsKHjKygjqBGzWuPNSrOClWGGr9J33/erx5mIegkge
	0O9ZUU8mjm3xyx0cb65ojQQo9P89DMfjtGo+AKbwzlh5E3xCktJgpeAZtX8mIj2I5gTwoAmoe3/
	1OCpTtlMt7h0SM71a1F/uy/g74RJjBU+2Q0rFvYAJA/ElP3VhP5oijo5DqPl0LoM1ZsMHhKTHuo
	94twlMte8Pm+MPzBvqr+Ns=
X-Received: by 2002:a17:903:1c1:b0:2df:90d4:7758 with SMTP id d9443c01a7336-2e49b6520b0mr32254135ad.23.1790971173383;
        Fri, 02 Oct 2026 12:59:33 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6c8421fe4sm5419796a91.12.2026.10.02.12.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:59:32 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
Subject: [PATCH net] sfc: handle rhashtable walk errors in mport lookup
Date: Fri, 02 Oct 2026 19:47:40 +0000
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 Alejandro Lucero <alejandro.lucero-palau@amd.com>,
 Changyul Lee <lcy8047@gmail.com>
Message-ID: <20261003.final089.e0910b3ffb849fe4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

rhashtable_walk_next() can return ERR_PTR(-EAGAIN) when the table is
resized. efx_mae_lookup_mport() currently dereferences that value as an
mport descriptor.

Skip error values and continue the walk, as the other rhashtable walkers
in this driver already do.

Fixes: 5227adff37af ("sfc: add mport lookup based on driver's mport data")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Compile-tested the affected object with x86_64 allmodconfig
and W=1 (GCC 13.3.0). Base: mainline 3b7cab693ba2bab63774bf5b988e8a61b2ef0f32.
No hardware testing or runtime failure reproduction was performed.

 drivers/net/ethernet/sfc/mae.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 7a8606efd492..b6de61062a86 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1030,6 +1030,8 @@ int efx_mae_lookup_mport(struct efx_nic *efx, u32 vf_idx, u32 *id)
 	rhashtable_walk_enter(&mae->mports_ht, &walk);
 	rhashtable_walk_start(&walk);
 	while ((m = rhashtable_walk_next(&walk)) != NULL) {
+		if (IS_ERR(m))
+			continue;
 		if (m->mport_type == MAE_MPORT_DESC_MPORT_TYPE_VNIC &&
 		    m->interface_idx == nic_data->local_mae_intf &&
 		    m->pf_idx == 0 &&
