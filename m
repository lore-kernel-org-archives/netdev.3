Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897012;
	b=c9feETVyqntbFMzEvZTGXsfMd4Op5kw1dyBmxNlJvqY8SRvCcV/G46O3aRHocceuJatq
	 5akBnCh3wGZMkNyTL1DoAPwRrSQyzImB4/Axttat2+/EifE4Dl7fhu7gxxEvn62L+SA0g
	 ev8HteI01rFSt2upQJM9eZJg8cPOL98fdP4tVfvCoBdxRkawwc7OMwXJJUzo0JCRTWong
	 1TZiAAqWF+7SiPC/T5jILudnHiHxR9bJ7t4i08kzwFhvT4n+lc3br080RShmchLaBNzjJ
	 BbIiTJuF14IjlvFmMdm2KGHrsuxgIXqVPiNZTZWZ8xD54Diz4uDnIzKxTlrV2HseknA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U2gshDq2bNSNVDi2ZZPuvyhhYbiMNkYLcIK7Najb9DU=;
	b=zrQLF61heuG8qDGX4JCEq8NlPdzJeSOldeatH/lVtg9Q0gMItEoKKR4JkJVmlaz31bdq
	 R4dbqhQgVS9aLS2Zv2LKYwN2I+2/g/hqlJIMcM7PT9z1jQIq//aUR0R3M1l/wBj3wTOGF
	 8R+MXtLg7VGrybDU9U7Sx78L7sV426yWgkehFUbguxlOXsH7EgLd+4dC72UfUjNNFb2nB
	 kx/ZEhBD+W2OWNTGwx+FAHVWOmdBUYKJ1fsP8OAfHJebxolJ9LUJpFbsCjyM2XvcuNlQX
	 JZvPAgEnuESIsGyzOJ/ckjLTez0MItuOyenglIORzx6uPACabazxHCJyeqL2H4y4nMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0CL5WTY;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD796606A90D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD796606A90D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0CL5WTY
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c1f548f87so32188336d6.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897010; x=1794501810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U2gshDq2bNSNVDi2ZZPuvyhhYbiMNkYLcIK7Najb9DU=;
        b=V0CL5WTYpoM1SYQ7P7pQ063tn89UFTxXRJ2vPwv2nuvsSTbAWYBlRkIlh2wtt/0rGM
         R5ssh7gAFZwnVkmnyQeuCK8rACXBvTUUcWBgKkrg2O+CuyQ/shQBTwfGjGFqMPalk1xj
         IGK/ck3grhWUZMB1tNrOHeJY4KQmAef7nDtT/kZUtFx3yRArG+gN1PnnzrnWPHjDU3F5
         fqLuVwgxKp79D+d0YbKXCOhWDgtFn63halgXcdxhiSyOES90gJt9t6cT8J6hlmLi1hN9
         4d/KYpe9g/l1xEy1CFSC2MwT1ZTq8vWpNShFeneAm6bTm2QoVn9LQ+VcvC4NPAqWD3SC
         5dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897010; x=1794501810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2gshDq2bNSNVDi2ZZPuvyhhYbiMNkYLcIK7Najb9DU=;
        b=Mceh3S1XN7bwlp23oto6gubXnzuiKujGQ40Y+OOW02B0bofN4/UE9/8ZlJ4ubKhlJc
         4tNNE/y4HUmpqmEyRRLRBkaALiEddYL/PZTqH0vJ+d8wUjazaba3R0IlttCbNh8ZU3Qg
         UK6Cwu1uwmAmKhk07sCqOdAU4bVK0vTNNU/XeLcllKtsnOKY37ExPtRpIezKlDFqLlxU
         tiXFvVxev1oAxQifqN28UL03fjv294GtkiPjQwcxoE8CNAnPSOVUbCW0l2Kqesf3383y
         sP5zZ6tsHM1qWs7gIdzOSc/porTLeZsy2z2sEglf7mr7vG7NCPlWyRE+xbMqPbMI386e
         cY5A==
X-Forwarded-Encrypted: i=1; AKwUvBzYCJY4Lh/QrbkHMy3Xebke242CMzb9FZTf7Vps01GlwFE5ulWuCAv9bcto3o4vRiACyri3IgM=@vger.kernel.org
X-Gm-Message-State: APuU4Z86mqlI3P192A6YiMveawhQdoY5k8KRW52tgUtREuHqDJ/7krL8
	9ppIinoGLRC/UeZoLpZ7Zvbfn0b1xKR1UhM1kNZcMBsBhxAg0rGQLHCI
X-Gm-Gg: AYBFou2DeJhMH+q+HqCQKcQ6C70S6wuKppHl6MCgy3dJi4mZH43apndIpFg7SqHOmqt
	uaFevge3+ufMwBaiu/PwoUwV5n/FIA41R33kT2SJAbh5HWX+dGsRMj4IZ1apdzHHSEVFaHVf1M5
	Ypgs7S2wV/kT//C3ATRtcLD7GUE/g2MAlqcWvj7W0zX3touR1FOsBCsjlUCPGBC73uUVle+w02D
	IBQzfN8grt1B5xWclpcCwrdBtVxWs1ZMoKnvTlERZ6UiRg2PFinrcakmLgZ2ZHDAHO/FAvTIH3t
	c5GjTNeKlr3txAzUXQiwshl6Obf61Gf3pctKg4nw8KkzyRn6JOvIx6LVf00ojkiN6AD32eF4rNW
	U6sLcfrHBjQB2p5u24gRHWANs958nf/GBAg/dR/d/MWp1CVGIUk7cCwa64CeRL21KJ7CYSWP6At
	px4ZhXHT7hqtsB2b1AK9haMgzs+li8ZxXjKTff8ylNbcwdKYHMi291PlzPOwgBzhYgCayr9B5qA
	MwBXdUW3g3mpNCIsg0tt1YeKUjB84Nim/z7UAvpy2+JryQsUSsIjdroSCs/OzSmhXPFTYlID2tH
	GYrzbKbk74slXwyl4SfHMcAgfo5aoWTRYiPNMFApEzGtIa/mW3mzJM/mWBZ4mq0nwCblcwiI6lw
	=
X-Received: by 2002:a05:6214:501a:b0:91e:8e12:f594 with SMTP id 6a1803df08f44-91e8e12f9cbmr74222216d6.39.1793897009503;
        Thu, 05 Nov 2026 08:43:29 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e97b5ae75sm22803706d6.38.2026.11.05.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:43:28 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	netdev@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net-next v1] ptp: kvm: x86: Leak clock_pair page if changing its encryption fails
Date: Thu,  5 Nov 2026 11:43:08 -0500
Message-ID: <20261105164324.23501-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In a confidential guest, kvm_arch_ptp_init() shares the clock_pair page
with the host using set_memory_decrypted(), and kvm_arch_ptp_exit()
makes it private again with set_memory_encrypted() before freeing it.

The untrusted host can make either call fail and leave the page shared.
Both paths still free the page: the init error path with __free_page(),
and kvm_arch_ptp_exit() after only a WARN_ON(). The page allocator can
then hand a page the host can still access to an unrelated user.

Leak the page in both cases instead, as was done for the same situation
in commit b9fa16949d18 ("dma-direct: Leak pages on dma_set_decrypted()
failure") and commit 03f5a999adba ("Drivers: hv: vmbus: Leak pages if
set_memory_encrypted() fails").

Fixes: 6365ba64b4dbe ("ptp: kvm: Use decrypted memory in confidential guest on x86")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. Compile-tested
only (x86_64 with KVM_GUEST, AMD_MEM_ENCRYPT and INTEL_TDX_GUEST, W=1);
I do not have a confidential guest to test it on.

 drivers/ptp/ptp_kvm_x86.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 6cea4fe39bcfe..811758bd8b0de 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -36,7 +36,7 @@ int kvm_arch_ptp_init(void)
 		clock_pair = page_address(p);
 		ret = set_memory_decrypted((unsigned long)clock_pair, 1);
 		if (ret) {
-			__free_page(p);
+			/* The page may be left shared, so leak it. */
 			clock_pair = NULL;
 			goto nofree;
 		}
@@ -68,8 +68,9 @@ int kvm_arch_ptp_init(void)
 void kvm_arch_ptp_exit(void)
 {
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
-		WARN_ON(set_memory_encrypted((unsigned long)clock_pair, 1));
-		free_page((unsigned long)clock_pair);
+		/* Leak the page if it cannot be made private again. */
+		if (!WARN_ON(set_memory_encrypted((unsigned long)clock_pair, 1)))
+			free_page((unsigned long)clock_pair);
 		clock_pair = NULL;
 	}
 }

base-commit: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
-- 
2.43.0

