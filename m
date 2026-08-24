Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AC46E005
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590172; cv=none; b=bdVKn7o2+SfSBaNwBqe5Krcs5OKdQXYFOHdtlGBRTlsin0WPVZXmUH7Q6gAmYFyjV0XKJZZaBYuVOU0qjPS6OtQLHJOsoqZ+Sh2EkcPt+YXWzWHAch0VcIC7pqKFGQCDTqz66fhVyfuaorqTz9gCBPZGE7ZDw7sONw5rlLHU5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590172; c=relaxed/simple;
	bh=SHRUZ8sJurUIXz9RUsC4qyeB5gvhbcvDMlA2o17YJ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBL3768/GLQ34vTim/Shx57KSkf2ePLpyS9nT5826ARszz17vGw1qnNpPGVEkyxsgJNvu7Ndb3JoKD+OYh7MrDOSeB4538CozCcrtCtDmV2oNHtZD+iJ6ToFrJvYLpr/TmdCEPmIiC66r9oTXTP4hAdzzYNMgwmfWjMFUQ04QZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=D8vLxGdH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="D8vLxGdH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso1375275ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787590170; x=1788194970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wo8UXqbLNIs+Jdc4TRjKQJjrdjMcgJ+wf5JwoXpifAM=;
        b=D8vLxGdHtudMVt0h9EokfP7OkpGNt/k4GqAXSyhKPGCql9cCddS3A4tYX+ddiL5fgI
         ZCbYQhp5xOvtnn7UyPJ/CVglm8uJLzcvU5g53hGv1/bcIfKa7TzepZdNQTLW1AXZSjQ6
         pR+tQGXS/Nv9zdhOiuUT0nh9QDx0yp8ZLfi0PddsTVkKfTNzVDCGdwTg6TpSdiQJkDoX
         A4jCdY9zh7EStvYWEDrpeqCrrSGk87GiKvQis6nSfpovu2d2Ca6SPg38ZVIRcot/Dvw+
         4kxnHQFQsVQ8FDrWnG0WONyHKb4mflc+15W/YWArCw4Apgy5fm7cNrRC+uiWDKy896NK
         lW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590170; x=1788194970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wo8UXqbLNIs+Jdc4TRjKQJjrdjMcgJ+wf5JwoXpifAM=;
        b=af41SZ8L9SSW3oa9w7NLSLkx6lzOQOd/rwxpW9CrUev29ey/h3g342wlxiP4oZLRaw
         cZHtp9by0tZRRFcEwkCSZBb6BKd9GPo1MmeXVSrlKSaovdKAv6+FYtQN0ClXHy83P58M
         lixNNABDDR1qAo4UfQZk2XSOQxHkIHlrH6WnbMlvAx07JDHM20y9KnJMmtU+l2stKjk2
         469okvq2gfsmb6sinAooRPxXDVUFm5dEHi9kilxQzY4+HTSptSCL0mwIgmBaLKWigy2c
         vVUw6xvZpOQctQ4fW9U5AXHDLMo7a0XAOErZOCRDEpzzye4qqcowEGeqwKHYP5GfXF8S
         G1eQ==
X-Gm-Message-State: AFuF++koaCqx8i3cXHZsWtAmuuLHjvllsiygrZ4wgf94NXl7iT/+vuFg
	A9fWOM0xUaD8AX36+Unqf4uy8+V1rTZuTFzOqv0It8exr4/NShGh3LN2BCBkZf7WJ//2WLh+t4B
	18RQF
X-Gm-Gg: AR+sD12yKbuAfF4oK6GMD7qGN78hkcViA5P7iH0TVK+UCKYtSRskvl+lZBGv/uPiddZ
	PXliOQ0semLIu1TfFv6vMCPZ/AFkndRtPlvNw2oi3/2oySIIKmyBrbq3ZQrzheH0CIrFbk1pHY0
	M2+b3d7S5N23DJfrdoEA47t9crZa6/c8bhxPIFfCvNOaiXLvi7ra3+bCr6GrIIJm3pbj4CAcEtY
	gawvl1nu8ftp3bM5652mB4aJ3GX0AfibMuN5rdDeCZFYdGraBIN/DKRMHpgmSeaJGmupOH7BJgM
	wbSEH/lOY1JQ/cVbl70RqfqUKcPvH8xmv7TCNinv9bnAlAMgnA14Jf7s1pNtxsFxmz9fHEv32tH
	JpM4UtKBnvqcol8fb74ijGb+SIj25X2J+8Ec5hbWVVGYAK8sbXtdZqtX6WlTcCBfW7mJ7Sa2Oar
	c1eTQpvnWEWGNPekCWXP71NsXVJtQ9xlViVPrjiPqTsVF2vothhQL3ln2iyouyHoM0aYEb4RetT
	rxMy2kaVcONoaap/9C+UStI+z0wx54cSREcCA==
X-Received: by 2002:a17:903:468d:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d6dc97b332mr6673345ad.2.1787590170224;
        Mon, 24 Aug 2026 09:49:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767626d6sm19552125ad.11.2026.08.24.09.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:49:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] iplink/can: fix format string warnings
Date: Mon, 24 Aug 2026 09:49:22 -0700
Message-ID: <20260824164922.575038-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang complains about non-literal format string

  iplink_can.c:531:36: warning: format string is not a string literal
        [-Wformat-nonliteral]
    531 |                 can_print_timing_min_max("tdcv", tdcv, *tdcv_min, *...
        |                                                  ^~~~

Small change to use "%s" in can_print_timing_min_max.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iplink_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f631aab8..450a19b9 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -448,11 +448,11 @@ static void can_print_nl_indent(void)
 	print_string(PRINT_FP, NULL, "%s", "\t ");
 }
 
-static void __attribute__((format(printf, 2, 0)))
+static void
 can_print_timing_min_max(const char *json_attr, const char *fp_attr,
 			 int min, int max)
 {
-	print_null(PRINT_FP, NULL, fp_attr, NULL);
+	print_string(PRINT_FP, NULL, "%s", fp_attr);
 	open_json_object(json_attr);
 	print_uint(PRINT_ANY, "min", " %d", min);
 	print_uint(PRINT_ANY, "max", "..%d", max);
-- 
2.53.0

