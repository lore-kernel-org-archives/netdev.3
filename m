Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E6489FC9
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007306; cv=none; b=aETfaGyl8zDKiLYnUjEGXOoFHndnDCwTjToNLekNbXCceQgJFBM2rFzbwxor/P77OsZ9xD4bsiGfQ3EHwZbUz80m4TQ2Ugh1Ywe5EE9PKWznGXpmEtbPYnBQeAGi+rAJMIMYse+RlRHsxnx/2wcAyY+f1PA7W0bbfvWEbDdUlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007306; c=relaxed/simple;
	bh=1TD8ZpH+/6jv338rRp4EboOBdgmpy9DftuYG/3dQ1EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noBxr6flf6nQi/vdsvXDOw7TiOpWYpqTNuM7CFArpkWf+H6/EvS9AOgymWJwjXc+GfYhKoGlx7iXCRP3XGFX7R4zJlXMNkMjzpYK+VUNvr+wduPr/IQpAQO6isDNBPkcnZooHf/dte7q1PWMk0qy+9Cekdi1GfpJZIepe0nCaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etAmlb3g; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etAmlb3g"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8520161fdb9so537311b3a.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792007302; x=1792612102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1OEKiLFmZZA8uQuqTPnrH94Sp0/0PEPLNTXQpBXzI8=;
        b=etAmlb3gElOknz8YWisLYv6Gx2htbJakBmr33uyYGsuzlNgfcC7kd4lkTWVHAi4LHv
         cKya5B91F4bc2yTEXWBj2hexqmUTvLxlontr/JM9Dbh5R8igRLtsDCK+2TFRd+J76IgO
         RLCZzmgCdaPqrRzfKPFGrHc3MZazFlbFp5Wb5gJI/SkK5nRhoUQrrpe/30At5AS4mn9q
         qhJYyHetxntw3N3GzsqkBB9z64JTwsvvOR3SeGqaZYPGlO2/DeqrLUhZ7VVHg57+twL9
         vllHfoCSW5NUDTSdZY2qk0pGKzyEao6kF9rmqLTHHM7ueTE3R4kTzYrPpMOp4M8Nhmm2
         jYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007302; x=1792612102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1OEKiLFmZZA8uQuqTPnrH94Sp0/0PEPLNTXQpBXzI8=;
        b=tKAcjkl0w8KNMjuFWjQfE7yOvWL+nvfhOoyddjRcW5LqT2fR2JEP4g0sj7H1/xJNR+
         7/5p5VgGJgv0RFdy73DQ8MQMEbPZluaymvT+7ozx/tCVbilzkeErO5+7aD16ovXUppg3
         hQvZj841I6IyRYcwhlgju7uUxOYm5uA62dQVmGALNZD+ouWnzx9yUqdXVKBjrUqW+tlC
         Ja4ZGhuPjJ2pC+c+Sg6WqLYxx+XBKJGdLpLDr0M01tSvmuryPA7E6BHwBCNEBhqlphQr
         PciK5C62qRlg9VqrAZUKmLGWkSR3IXQd3pV84SjbXkInvtfCO0OGxOZgVzAW04zPee2i
         slwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCerjqjMZ9aFOeEo7L8F09VViitdZVE+OHH/Y0jiGZGDphci4ghtwaV9FCBHDSbI+o+vRR85g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKi1pF4WtGeMDhajHMJpp6EPibnq+AIQWBYDpe0U4ca8ELQl2u5
	Rq1kdrZwAE08DUlaZ1DwulDAZU8UBnF+5TGWAlxl6sjNc9r6ljdzskWA
X-Gm-Gg: AYBFou11G7gj9GdWMIDx61F2chuYcPssC+r0lw8HM234x4em1ufJSP8eeTUKwRtYOQm
	oBFtxq3T6FqBBXEFV/1bRdE0ULRqmUi/cgwxFcUQG8S0iGifEms1Lc/aU8gyOrIzUgoPYXKH3He
	8MFb43TlBwWlzn7ExoBfhGRpLhpPRg1oWXL3Gwo8g/GsCxdh+AFFZLC9lR1uFhClHucbml48Fbq
	W6s0iKRDbMCFEUTo+bXyNycwxKc2KztjRrhPLxrBX1lCn5kI9GN9FnYj1f5UZztyfwHTFxfjGFf
	Zfbi5CEq660Yhydabrka9/geGRNbLBauj2UoxUo0qMII/5TxYCAuUo+oWnfv6kef0z1DAlBWEZ2
	SeZX0M9gfQpsPW226l4GxtNnsWV9mJ7p196FE9CIWC90t570XCjfkWlJQnCbURsZOYKuEBDA2Je
	rmCoiw/wjLf0At1FTPOnsdYrtrlAr9FrMkUubPsWmrPSrsJt0Zir4ypMdDxwZ6uaHDJWY3u0+k4
	0UX0vefcj7w+frHxJYCjeQDWo4YhQSFbcg1sSsRJk4ojojKYbVpqK4e2xkjJDsnitO6TuCZkmoJ
	9ns4UkGvHAgmOYAhKkKOATBnjWZEW60JIM8vkLlPTYlqcmfU
X-Received: by 2002:a05:6a00:1806:b0:881:552b:15bf with SMTP id d2e1a72fcca58-897c6e1b2bdmr16161905b3a.19.1792007302159;
        Wed, 14 Oct 2026 12:48:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d8050d76csm1468779b3a.52.2026.10.14.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:48:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY)
Subject: [PATCH v3] powerpc/lib: prefetch ahead in __csum_partial()
Date: Wed, 14 Oct 2026 12:48:17 -0700
Message-ID: <20261014194818.11640-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__csum_partial() walks the buffer linearly and reads each cache line
exactly once. On cores without a hardware prefetcher, such as the 464FP
in the APM82181, every new line is therefore a demand miss that stalls
the loop. Packets received by non-coherent DMA are never in the cache,
so this is the common case for GRO checksum validation: when routing
TCP with GRO enabled on a Meraki MX60, __csum_partial() takes about 30%
of all cycles and is the top entry in the profile.

Issue a dcbt MAX_COPY_PREFETCH cache lines ahead in the main loop,
the same distance csum_partial_copy_generic() already uses. That is
128 bytes on the 44x. dcbt is only a hint and never faults, so
prefetching past the end of the buffer is harmless. Lines that are
already cached, for example when checksumming data the CPU just wrote,
are left untouched.

Measured on a Meraki MX60 (APM82181 at 800 MHz), single TCP stream
routed through a qca8k DSA switch, iperf3 median of 5. Only the dcbt
was toggled at runtime, in the same boot:

              LAN->WAN               WAN->LAN
              Mbit/s  csum cycles    Mbit/s  csum cycles
  before      495     30.5%          439     27.2%
  after       599     15.3%          520     13.7%

That is 58% less time spent in __csum_partial() per byte.

The prefetch distance was chosen with an earlier, slower driver
configuration (median of 3, Mbit/s):

  distance    LAN->WAN   WAN->LAN
  none        370        341
  64 bytes    430        381
  96 bytes    438        397
  128 bytes   438        385
  160 bytes   434        386
  256 bytes   423        383

Prefetching the first lines before entering the loop made no
measurable difference and is not done.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: use MAX_COPY_PREFETCH
 v2: reword commit message and retest numbers.
 arch/powerpc/lib/checksum_32.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index cd00b9bdd772..5bb872e9e68f 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
 	bdnz	2b
 21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
 	beq	3f
+	li	r9,MAX_COPY_PREFETCH*L1_CACHE_BYTES /* prefetch distance */
 	lwz	r0,4(r3)
 	mtctr	r6
 	lwz	r6,8(r3)
@@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
 	lwzu	r8,16(r3)
 	adde	r5,r5,r7
 	bdz	23f
-22:	lwz	r0,4(r3)
+22:	dcbt	r3,r9
+	lwz	r0,4(r3)
 	adde	r5,r5,r8
 	lwz	r6,8(r3)
 	adde	r5,r5,r0
-- 
2.56.0

