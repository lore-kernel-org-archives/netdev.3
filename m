Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2334A4850
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594761; cv=none; b=Qs+MxWQrKwxoEEDltWulsLT21dNDKYKovlF6OrrvOBM2MLncQ3sCkUpdt8374JIsP/MyJL7V8JJ/oGJ3ZrkWE3OQBwVZQ4u4UEOmaMjVhw2ugl8wrqtZ6NMYnMDsouicGCaXc2y/xT5xs86t5FfEqqK0NjFFtXgVz2AVCTotcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594761; c=relaxed/simple;
	bh=PsPusc4qAHUgVH+z4010iQyTMiOO3rvfUXhn+vQgGZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hB1XVu3/UBrBslAUKr+JiM9GeVap0H2B96vscRpC0tb+Ls1Ea1BzsAY7QD/5eRq0jgZ9YGxH4B5+Fo+CPJT9R89kd4F74AxBpoak8Dm56mQfa47kIsOVgdKQFMdP87WGOe8qsat5Bs/TL85w52J2lN21ehTeAih5wTcxRhSwmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYuy5qSJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYuy5qSJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe459dso969025ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789594744; x=1790199544; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QGSIghPfDv6DsIM2E1JMZGyCZHHlvJzJCLg/lNVzFo8=;
        b=JYuy5qSJx4QsNiNUjTACR5UZJMAlOeyhgwl4tflv4rZI5bPEOF+DFgi8ocEPy01vJ3
         AdI8oy/+HspVWUpyIYHewJ40dA3BPVDTCZ/4F51mIrcFz5NWPu8jzA46F1Oo+UsxIK36
         Ph05iPC0LnJvpmgoAYGIMNouc4NwNyQp+VhaJZ/s923PGIBrVtb229R51jdf+D8ZbkUw
         tijOMcA9YCiEPHM2dBrHZISy6M9oGgA8ZKv+bZ362n+C/8yc187DdhSFs7pqagGKYs6r
         ZF5afGiLn6So3C5x6j+508tTlIQr0xHh4PkCKuLdZZyBBm1/f6ho1t9TYaN4ml1KEWXq
         qDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594744; x=1790199544;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QGSIghPfDv6DsIM2E1JMZGyCZHHlvJzJCLg/lNVzFo8=;
        b=SOyoFMvioCu6aVAotNdeOPZnK02l+o6ltv3C7q5liUMbi/ilAICiM41xGHfyVWSIVM
         9flfpuDUtR1xT20+528HdpBUTpkZpMl9fRy2Bw653NAZf7hjmenXn8gfBTB0Pbu7YwHX
         /QvXgTAKkQ9teCr6Y/IQEqQtJ/i5azY+4UaQ1q7kHFPBJ+ZyQbRSAER49NRJeEfRSeQr
         GtuN2PZD8h5YvLHS/WTrgLGrpgDx8n8HRyyEOVaAb30Ih+xb+RNR19KEboerz532I6eF
         hIObrZziTIovnFIcxhIEprBOwvoC1D4RYCh5kUEAOd3s4itpZwsPLeGPSzmEdkxw4QIK
         HSzA==
X-Forwarded-Encrypted: i=1; AKwUvBxpEFSPuOcmTQHciBzUuD0rW7VUPrgIiyH9kQsvs2A95zdp6RkzepYgxr++MJ2nCriZEL21LDY=@vger.kernel.org
X-Gm-Message-State: AFuF++nc/4izam2FpqkJpbW6H3oadpitPOk/LZ/LC3lsJ8s6ODVxO0LV
	ZRKe59rc8X+9R/Kz4+kiVnCF+NP6kkIRi9r9bNsb1vEd3CqPKJM2sG0C/6pkTth2
X-Gm-Gg: AYBFou1SwJdC8NlwrHDTchNNTG6GNDY7+xNlpV8v3EiYVD2DnJYmvBDgWyeWbZqjYDm
	QcRYuDxP3cBzVHWSYW19iIua5yoUssQW7O0ARHY/fROjVjcIahF9VJs+REs3engJghj/BhqzaFZ
	+SvQAZjOM5812JwPmHHHyKp4vkiYvTMBkGJI3yLrc9OOAEc9TdixAxosx3jppOHi0NEvLCmshiu
	cqQepnJdT0txYMs+ev0mmUdS1OEX7+G6aY05FEjq47IegmQCnsQBKwzG145ZXyMBKkT5PDbzr+y
	UM4JpnJT0hpgzO9dH4LLAxc13nnNgH+2u3mcw1FRdhVyDmQSl0rVeZNsSlQWxQje6CRarYHJHvI
	oaiXSxe14H1BeVym9dJoywiqenGGtseTLPNYdNYxL7vVMKSN1qxjH9rRA/covXtW9zQf/+oA+2/
	hI/Y6UJshklgsbbCjxlCWpBlX57ptGgdWUJecBqitoxp9LqJ9mqM75Cp8UdqudwzufEOuvdX1PD
	l4HosFbgw==
X-Received: by 2002:a17:902:d54e:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2dd8e40cdd6mr91502415ad.11.1789594743687;
        Wed, 16 Sep 2026 14:39:03 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fe15sm17650445ad.1.2026.09.16.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:39:03 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC iproute2-next v3 0/2] seg6: add support for the SRv6
 End.MAP behavior under seg6mobile encap
Date: Thu, 17 Sep 2026 06:38:59 +0900
Message-Id: <20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMMq2oC/22OQW6DMBBFrxJ53amGQTbQVaRIOUC2URYYBpgqY
 GQTlCji7gV30S5Y/tH/781bBfbCQX0d3srzLEHcsIb046CqrhxaBqnXrAjJoKYUArcGemflzsB
 DDX05gmm0Nmgba3JW63L03MgzUq/qcj5tNxm9e0xMMPBzUrffVnjYb66mTbB1OgmT86/4zJzEd
 fRmCe565wQQigwp001a52iPbV/K/bNyfTTM9McoMNln0MpAbamss9wWRP8Zy7L8AEuuYs0iAQA
 A
X-Change-ID: 20260523-seg6-mobile-end-map-6f5560bfb68e
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=PsPusc4qAHUgVH+z4010iQyTMiOO3rvfUXhn+vQgGZc=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqqwx1hRQJkyD4iey5vuqEsG2CTaGVXAvEFTs/x
 nrXdGYuHUCJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCaqsMdQAKCRAq19F1Kl0b
 Tc5FD/sGOo77idXWGwtJcdZgEQBI4OCl48hgJFxPuaUjGMK+RADtEqT9THUi6TPNmhl+UMHfF6I
 3yZFTMTRr/Y+3rM/Tb1qUqmwSjdQVk/rmJRRCQ7/IFr0dQ7YgpXzorpTfdz3zayJDt0oRrR/l2I
 OFPManWywyAdfPObeLamHPo46hUQPiqvJc/32JZHFqbSE2wGj/VyQAMX/zfrgq43cVN1x57y4qH
 CmOj0jUsUnQC5p+GDhJ6ZqaZwMHy8KrOU4hDA101PQHik9aTPT/MlqbrHfzcRvXXYjCASWKd2Hw
 +pq5ivP9emZb2YF8AN0sQ27znBYLoFRob5/3iGWFE+q1sHVKTsPkXB8IR7OD6lLXGoP4Q6BdCxt
 7daPqQxYrvHbqPNlBckwd+u7bgmZuAWoDpt6wusYg9VlrkNzhRjPJyFisk2RxlBsfX+zovVbkrH
 FJDBehuBdVxb+xPvkKHDC7/+jjs1L0ThJe+Fr9UY2p08UoBozfYQal+SCSKjbogPoOh1y1zvjvB
 WSIvQu8KRev3sBFbbOs0p0Xb1+0+jcNOmQdryttvtP2GQxxeN1E5gcdSHRHzPGxiCzV+D79S8dA
 ptMkHVe3wKpJpXRb5yF+BNzb3DRG7B3Q3AtyQPgiQlaY+ukqIGkEeB5JwNWdl2HR7Rpeot8Dn58
 WVN4MKjOBFbn1xA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

This series adds support for the "seg6mobile" lightweight tunnel, the
iproute2 counterpart of the SRv6 Mobile User Plane (RFC 9433) kernel
RFC series [1], starting with the End.MAP behavior.

Patch 1 imports the new UAPI headers as a standalone patch so it can
be dropped once the matching kernel header lands.  The selftest in
the kernel series needs the "seg6mobile" keyword to run.

[1] https://lore.kernel.org/netdev/20260917-seg6-mobile-end-map-v3-0-9890a60ac6a7@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v3:
- Repost alongside the kernel v3; this series is unchanged
- Link to v2: https://lore.kernel.org/r/20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com

Changes in v2:
- Sync the UAPI header with the kernel v2 series (comment wording
  only).
- Document seg6mobile in the man page the way seg6local is: the
  "count" attribute in the synopsis, an ENCAP_SEG6MOBILE grammar
  entry, and End.MAP wording aligned with RFC 9433.
- Align the counters helper comment with the seg6local one.
- Rename the nh6 attribute and keyword to mapped_sid to match the
  RFC 9433 "mapped SID" wording and avoid clashing with the
  SEG6_LOCAL_NH6 nexthop semantics.
- Add Assisted-by tags.
- Link to v1: https://lore.kernel.org/r/20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com

---
Yuya Kusakabe (2):
      uapi: sync lwtunnel.h and add seg6_mobile.h
      seg6: add support for the End.MAP behavior under seg6mobile encap

 include/uapi/linux/lwtunnel.h    |   1 +
 include/uapi/linux/seg6_mobile.h |  61 ++++++++++++++
 ip/iproute.c                     |   6 +-
 ip/iproute_lwtunnel.c            | 173 +++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in           |  34 +++++++-
 5 files changed, 272 insertions(+), 3 deletions(-)
---
base-commit: fce739fa4f2ec83206d8d9435aa94ce22f09cdb1
change-id: 20260523-seg6-mobile-end-map-6f5560bfb68e

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

