Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600BC2C8
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789520443; cv=none; b=Tv/SykCVzw5waDopZeS7OkYCJTxj4JUCN0MGVPs7RrBho2z2eUBcDg46Eb/4emw0epNRtl6NlRBcJ4kAzgAdR3MBNS9KzOaeYKWIj/SKoKVjzhX3SqqDMmkFk1bvuHaeLkFgGBRQKNa0UfCUoi9l1bnVkjLBKYfmYPefoOj5QAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789520443; c=relaxed/simple;
	bh=xPK2t4dVouE2ovJ9joBM9NP69qWKdD0UzEOb1CVD8zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4TTr4q71/RKirfMB4MIr/8oxMSVOr5S2GSXwl604tcqN14G4/coi0NT4QT6Szrc/xzZGXhPFL1pcfkPaHuq1Jux4V0V5w29/DOn+klJrwjLiJHroj4W/Nyc+5i6FAtPmLFbSl1wVrhTFMvdud7Ko9feLVYKDiAJ1sqqIWhe/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFuD0YKw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFuD0YKw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2db710396ffso13292465ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789520441; x=1790125241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGlFz15R1rbiCxHN0uJe/I5FW6CkIy16D/PLU4iFFD4=;
        b=hFuD0YKwh5HXZD2zW6PJVoCWA3p19jqRIITD7sumzouh9VjIndoGRyoFxGMEC1DRB7
         TZy+wXEzL2w0Tpw+F5INTAOnB96UmZyiptDyldAXSVbJOb7j4d3pCPznKWuM5hOKyUeV
         JDfLVxHD66xb9vLz99IX04wS7gxJmDHUD629Rqlttl2YoPkyP74c3FU8ukaiXSdHEb6I
         EkjJ4nNPmxRmD8ZwMAnRkX9gH6KLVzk3V/wIN9+9Yoii3+eyjYcKUGcIlq5c85HRZebI
         NnUTWwXJuaH1e3oNaJdgOU23cqvcin2BoRgb8Ybp4PXiFtQMq1zQRJZP703hihwilqfL
         a/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789520441; x=1790125241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGlFz15R1rbiCxHN0uJe/I5FW6CkIy16D/PLU4iFFD4=;
        b=Pdt+tl86GuSBMVFw3LRxH2MZ0tk3zIsXU6rTj4ceAsa/NOt2o5DxsbMQUQJcrfmCmE
         Alur85S47NKaVcXBfE8SZiFzsYYC1f3iJPDvBlaqShMEuVslDKJv3injppB8w8hoxsMt
         2DffVI05wvw+yh4SQjZd6HiFB1KIBTTzcigR/SEkm856nj2MmAeBuviLHh7vChntyInk
         OmdjoziY7rCt96RIkiNgVesq6rKK7PD1+cNTeyVfzd1L09TBGWXINweapqYeG6oDnpip
         fllxGW33ZH5Pc+nKZtzGU6MJ4/6F3AuL2ykL1TccJt7scf6iHUdiZIIoo8NYvId9rZKm
         gJgA==
X-Gm-Message-State: AFuF++mxYfJzcDhwzlS3qRmlVbcc+S+oRcCa9V6CYB2+sTJBA3YDGkD9
	rhCPkzhix6NOkm/+HclGfJvwn2DrSx5AbywXQhBoPmmPiJH+YqKVap6BdtzkmaJE
X-Gm-Gg: AYBFou3yEJh97n/WUPc8JPZwmzCTpg9GSRYPME+yEd2rinjR7bpikSUyiIauSk8u4RZ
	1d/Njrf/jck4Ds1KM7WC821J3Kvectj6edCMRV7QbRRmW7SSOePHw8Sh2+mbolra56m02nfwiLo
	1oimQdOPjIB5gnR+SS//oy1gjNnWm7FENnRwBmLi6piEl8B45DYQ+wMOBwu7Xg05K15C46sZG4z
	gigxz+J6hEfFiqTgoiVL/Acgq03upVTblCt2I6vRZhcWicBIejX0KKQse9didGH+nLc+C4hVmvp
	yEDYC5qrhWoHFR6jwV4KFk4bwXkW8YeEQQ7L9RByOuFIKZ4QKqblUyki5vBX5zcL+vdSP10INAH
	odPSmIsdpRY1c95APvy33Zx6vL9xT6VgDP6TQcMwmCPeNzIKau+FX1/t75HjTQq3gnkgc8lBA/1
	HPcbxAjkaoqSo/45IuO2YVig+HkrahELc8ZTmN4Jmmh36/dGhty14L77eYl7CkM3LQMfmxT8pAj
	OVNSZP1fpHTs0ogwgfbbSoHO/l1jCi5e/Xd5w==
X-Received: by 2002:a17:90b:39a6:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39dfe1c9d0emr8791472a91.23.1789520440642;
        Tue, 15 Sep 2026 18:00:40 -0700 (PDT)
Received: from narcisav-mac.thefacebook.com ([2620:10d:c090:400::5:7b05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395bf6e8esm2123023c88.0.2026.09.15.18.00.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 18:00:40 -0700 (PDT)
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	daniel.zahka@gmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Anubhav Singh <anubhavsinggh@google.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Coco Li <lixiaoyan@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	narcisav.kernel@gmail.com
Subject: [PATCH net] selftests: net: gro: fix OOB access when under-coalescing
Date: Tue, 15 Sep 2026 18:00:29 -0700
Message-ID: <20260916010029.50911-1-narcisav.kernel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more packets than expected are received, num_pkt
could index beyond the end of the array. Add a check to prevent
OOB access.

Continue receiving until the FIN is received to obtain
the total packet count. This helps diagnose issues by
distinguishing the cases where no coalescing happened from
the partial-coalescing cases that didn't meet the test check.

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Signed-off-by: Narcisa Vasile <narcisav.kernel@gmail.com>
---
 tools/testing/selftests/net/lib/gro.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 7a333155de1a..85ba69eeb6aa 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -1211,7 +1211,8 @@ static void check_recv_pkts(int fd, int *correct_payload,
 				- sizeof(struct tcphdr) - sizeof(struct iphdr);
 		}
 		vlog("%d ", data_len);
-		if (data_len != correct_payload[num_pkt]) {
+		if (num_pkt < correct_num_pkts &&
+		    data_len != correct_payload[num_pkt]) {
 			vlog("[!=%d]", correct_payload[num_pkt]);
 			bad_packet = true;
 		}
-- 
2.53.0-Meta

