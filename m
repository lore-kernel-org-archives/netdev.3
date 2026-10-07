Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C34D2EF6
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400119; cv=none; b=X3heCYWNMsSRuwS8v0mG4yeE+zb+/fVOyVDgRrcMhLMYnwQF6ZtgH5MsDu5NzcUPjjLo8kOZ8AhFkZMUArihbeiiKXrgwpkiypTh04zzCfCR9JW+2gj0cZGTEwX8YUoSPyHXshn14wWdnDesDs+yXrVZmS8dz9zkkR3TU1uT/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400119; c=relaxed/simple;
	bh=T9n2DMbAcbZKwsbfxwnQrsq7TOFHW90UQz8k7zQjIuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsfCylgkmJdvhMOeM8DTquB0+aUb1laLtXA4ono0H59PR60x+iZXSJVZDZRCL+51PZompgd07PrqTJXkWWcCCuUZcuomvD8zoavI1ny0cKyU7ueiGmjJMkhL5J2/hVsLMmk4WIIvzTQdn+ccDW9RwauwGlhUk7awFw2SFRpd0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsHJnq1P; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsHJnq1P"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7ca917f9f52so357000137.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400117; x=1792004917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuo128+PEgN2LdloLyCW+rm1ZOlHKjsDDFXJ4dq206w=;
        b=lsHJnq1PuO3zs+AFiT+QxjQIcQavLnshGh1mblVGz8jvc6WeGPnwaROtiROeNNnt+f
         e57C4iEYrSHrmjHV4ul38jrzFFJyM1D/6k/IZLqWuzYpm6zuZ7fr9D7bvT+a8X/Ncn/l
         t2MWp79vZURpapiEXUNaoy8PbouI7HgRLJKamOBk0ncc0ShvAG7y7hpCjjem5xXPX2hL
         fRGxwDqoH5ULsvpYHCwp04v21kQiAjK5OqM+m1dGmRLjoWFomSbge9hsi/9DMS0kaxcu
         ukMB4PpSJKi2uCd2uYLflTv4aDZ4RWSdJusN5D0zacKI7XNa+HA6EcnqgcOBv3qXlhRp
         lbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400117; x=1792004917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zuo128+PEgN2LdloLyCW+rm1ZOlHKjsDDFXJ4dq206w=;
        b=R6E+VfrqmByLs8aT0umwA3Q2rVEEXnTCanOwkVeHXB3aNFqqpS/+qD6gkHU59XSJhU
         J1T3GzG0Unlso9bbyU5Ogn0cJtG8lJLhUNtQvls/AgoncunAYHraSZss/KBrXMsldl9Y
         f8xP0DzDWmo9Fz9Bzljeb4UHog/KsSDQ4PQKbdMV1/nBD2/N7d7N6i60M8E8k18un6Pi
         Jl9QmugxnsqZ32ccvU1ZURaOOvf0cySELkQXCb1KxGoAPx3J0y9sPPkQagsqgri4JtNF
         t73K2cTYko93jldc15dvcMI6+iTo2Wtu3ZuXyGRHOHicvRAB/qngXA6qQeEcWXcxzPH8
         LEJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhKC2Ez0gTwTFZAz394uN0SI4jaOzjlhEH2O3EcKvqo74TeFj93Q9InSDXIdAvduR3sD2yC5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMMAV87qQcoEzN/34bZFRUNP/B1WEdbPFTxnsEfB6WwFyUq1jt
	ZhlnDSgJVHvGpmwJdpxmeSIA+g/zVRb4akuAlRnzimD4zJse2Q1241Kz
X-Gm-Gg: AYBFou0+hdcfv0xbOUSmgpgbhkPNASGOOpq7Ht6yfJYPhFODJT1MlhZPhmJSdxTVY/S
	VFKcsrQv71InI02f5EiGjBOGRDhNVzGdaRXNBcHPGs4WtdO2HVpgcc0tgdrSSWSrtsBdrmymTJ0
	d9FOyKlLUzdbx4Z7bOnx/gGKsKwAsIyjn9ThooODXgHa79zm1uCITeqCZ95VpKTDgE7mONNYUNF
	+KgYHCynOshhn9Z/UgIRcrz7RqpYvFWoBNZEWLYbhAJCcPktLDmyXE1wXe3g1oaijoii5/NQtIT
	MWDbqKnLuRulQjuOY+VD3akpNFmF4nNeTtK3/PdbwO0spOfgx7EkVFZKQchd2S2h8+6bPJC5sv4
	GaL3qAciDdxjzal0V1qjAs6jNjG+FDLjpVUvCugixLSrrMsp2KCXgC9VJwVgea2lNXAJMno5uPS
	vjsxd12tCe//IfabKTMfx19x6fn9AOb/wylYRkMTpuFGJOY+8vAU5o2KlKnxt9/2EfUaDPUl/Bb
	RCvdiD3cLRau03t7Ko=
X-Received: by 2002:a05:6102:1492:b0:7c3:2168:d603 with SMTP id ada2fe7eead31-7ca355c2b2fmr979882137.0.1791400117578;
        Wed, 07 Oct 2026 12:08:37 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:36 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 06/14] hv: vmbus: cover all shared-page policy combinations
Date: Wed,  7 Oct 2026 16:07:44 -0300
Message-ID: <20261007190752.336426-7-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Name the shared-page selection and enumerate all eight combinations of
Hyper-V isolation, independent guest-memory encryption and channel
confidentiality. Either platform visibility signal selects shared
backing; the confidential-channel override keeps private backing. These
are decision tests, not confidential hardware qualification.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c           | 16 ++++++++++++++--
 drivers/hv/hyperv_vmbus.h      |  2 ++
 drivers/hv/vmbus_buffer_test.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 0c025a12808a..8ed155f2669f 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -45,6 +45,13 @@ int vmbus_buffer_round_size(u32 size, u32 *rounded_size)
 	return 0;
 }
 
+bool
+vmbus_needs_shared_pages(bool hv_isolation, bool guest_mem_encrypted,
+			 bool confidential)
+{
+	return !confidential && (hv_isolation || guest_mem_encrypted);
+}
+
 unsigned int vmbus_buffer_order(unsigned long remaining,
 				unsigned int max_order)
 {
@@ -837,6 +844,8 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 	unsigned long nr_pages;
 	unsigned long remaining;
 	unsigned long page_idx = 0;
+	bool hv_isolation;
+	bool guest_mem_encrypted;
 	struct page **chunks = NULL;
 	struct page **pages = NULL;
 	unsigned int order = MAX_PAGE_ORDER;
@@ -853,9 +862,12 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 	nr_pages = rounded_size >> PAGE_SHIFT;
 	remaining = nr_pages;
 
+	hv_isolation = hv_is_isolation_supported();
+	guest_mem_encrypted = cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+
 	/* If the buffer does not need to be decrypted, just use vzalloc() */
-	if ((!hv_is_isolation_supported() &&
-	     !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) || confidential)
+	if (!vmbus_needs_shared_pages(hv_isolation, guest_mem_encrypted,
+				      confidential))
 		return vzalloc(rounded_size);
 
 	/* Worst case: every chunk is a single page. */
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index e08c472041d5..06094000f2f1 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -557,6 +557,8 @@ int hv_remove_ring_sysfs(struct vmbus_channel *channel);
  * These are shared with vmbus_buffer_test.c, which is built into the
  * hv_vmbus object alongside channel.c. They stay unexported.
  */
+bool vmbus_needs_shared_pages(bool hv_isolation, bool guest_mem_encrypted,
+			      bool confidential);
 int vmbus_buffer_round_size(u32 size, u32 *rounded_size);
 unsigned int vmbus_buffer_order(unsigned long remaining,
 				unsigned int max_order);
diff --git a/drivers/hv/vmbus_buffer_test.c b/drivers/hv/vmbus_buffer_test.c
index 60fc526af1af..9b401ef2ceea 100644
--- a/drivers/hv/vmbus_buffer_test.c
+++ b/drivers/hv/vmbus_buffer_test.c
@@ -38,6 +38,34 @@ static void vmbus_buffer_size_overflow_test(struct kunit *test)
 			(u32)(U32_MAX - PAGE_SIZE + 1));
 }
 
+static void vmbus_buffer_private_shared_selection_test(struct kunit *test)
+{
+	static const struct {
+		bool isolation;
+		bool encrypted;
+		bool confidential;
+		bool shared;
+	} cases[] = {
+		{ false, false, false, false },
+		{ false, false, true, false },
+		{ false, true, false, true },
+		{ false, true, true, false },
+		{ true, false, false, true },
+		{ true, false, true, false },
+		{ true, true, false, true },
+		{ true, true, true, false },
+	};
+	unsigned int i;
+
+	/* Either platform signal requires visibility; confidential stays private. */
+	for (i = 0; i < ARRAY_SIZE(cases); i++)
+		KUNIT_EXPECT_EQ(test,
+				vmbus_needs_shared_pages(cases[i].isolation,
+							 cases[i].encrypted,
+							 cases[i].confidential),
+				cases[i].shared);
+}
+
 static void vmbus_ring_fallback_order_zero_test(struct kunit *test)
 {
 	unsigned int order;
@@ -317,6 +345,7 @@ static void vmbus_buffer_order_zero_allocation_test(struct kunit *test)
 static struct kunit_case vmbus_buffer_test_cases[] = {
 	KUNIT_CASE(vmbus_buffer_size_rounding_test),
 	KUNIT_CASE(vmbus_buffer_size_overflow_test),
+	KUNIT_CASE(vmbus_buffer_private_shared_selection_test),
 	KUNIT_CASE(vmbus_ring_fallback_order_zero_test),
 	KUNIT_CASE(vmbus_buffer_failed_teardown_leaks_test),
 	KUNIT_CASE(vmbus_buffer_partial_allocation_cleanup_test),
-- 
2.43.0

