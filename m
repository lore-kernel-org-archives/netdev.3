Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A083B9956
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535318; cv=none; b=uSf3dYiXro0O/2RhF5NiKj9wl31avxKHbB7Z9/wH8/GjKeuwQRZ20HzhFtv1xOWtBQ554DAitRa9VgTYccgh/IyQ+sRfivzuesDAaZx5aMNNLVTgNe9Xpbv9GWuTN9tQSo5zBNd6Z/8TFXHltkZtLrsy1+YcJAQl4BCNIf6OxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535318; c=relaxed/simple;
	bh=lcQNPYTsumozJUsj0iUIOLSW3dNbINPXQ42kzsKHFhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjcyyoZQQlqY1NDduTHcvKh8uoZ04513040y7BpBJ3Bf7GiCjG/JqxleosQKzGEEUnXxkEOnLwU5D5i0o+2kvl0dDtPtnR3c1Psi2yfFg9H12Gbq5nGH9rgGTtPxoVcFCRFQASdXE89Je6Wl/ChIRgN7xeDb4W4oGPO0BNifNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=M89exlUK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="M89exlUK"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so4225985ad.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535316; x=1790140116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZufkxNInN1GDdoz+ei/fNQlm8x79g0qE/4kB3l+tkI=;
        b=M89exlUK07LseesesaCRse02lZTT5f7o7mcbJ2y0h4iqxdqms9E13KRispo2M0OAPZ
         5Ke8/Jr9PZeeyp2p84Ot8pUTwAktpLLqfuUkTyLIRn5kmPns+V7YV5ByR3nkO3ty0hat
         yekQ+2WqqOcdgG5LpDumBwJIFvLr5UcAAJ0BIT1S9mfDGgc5Ht/QpD1WNbXs3DmEsqFf
         SYJD2su3m1Gbhku/D6gNbMoShpyc7v/qZaBvBefA0G7bPInmNCeqAK+J1ErcZPa3XuaN
         f9M0YWrWEcj4+ZaPe2wDRYHRrn0vOv+avH4WY4x1QZZp/pZguTQyAdExMxUiVcNCSOsK
         8cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535316; x=1790140116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pZufkxNInN1GDdoz+ei/fNQlm8x79g0qE/4kB3l+tkI=;
        b=NJQ6RNfcdK5jgV5r/Sk+t/NzzR6aE2+cVBLK9lU9AO4/n+HVwbX2raSAsq5vYKeFND
         8MLbzbjFIZDdus7W0YVQ6eh7M1BhGDLIndRgkp+7SVDBU/fD8DRXkCYFOf7ggiqLz5RQ
         bW3P0i5A/eVtoLfKeqLgb8puuTJ/TwO283+FEiqd95jQrKr7y9XI/O+qfa+Q66DxoStV
         Ih/cDP1HZpnDNVYK/Cw5SFh34pPzfcJSOccpVak7ZLS0am8kcU5V63T4NA9fmdMYk+XE
         P40iEY5pykkpuvilAilC7LZEsO04sTKbV7QxU7HRSddk6aid+pXSEicl6Ax99PQs1FQ7
         BIlg==
X-Forwarded-Encrypted: i=1; AKwUvBzIBZ2wFshC8C6yC8aFYNawYAyzwaup53HLFOQ5CObhCPB42oj/qtMxd8JcX75x5hahM4KlXCg=@vger.kernel.org
X-Gm-Message-State: AFuF++lbhZuoAFvtLktaNJtD4FfkcAV1pU62YQnaQE/C4SeS8FXinLlZ
	CAeppCn8YchffTrxaj2sfLoaRX0G9fRcZXS8U2V8X8RNnVfOZbmr6OM7oXtZvfOIhEo=
X-Gm-Gg: AYBFou00yQdpz6uNS0xeYAn58AnfuFhAa7cBCtb1t1h5dR+4rpkjGFCAFvf/Rwbwi5s
	YPddWGN8OIpAFcwTZYr2oRAaUohFjd2jRjkm2rENMLO6nqHcFR5fdmi9UNMyV1ceMnBF0T2cGrS
	9QDKeGnkzlTcomFlGZYsakiYxHa6ilOoSh6+UN8rjRs9sKDZ+Cn3dGnZ/cUfh1zcAPiNBmg1NU5
	DwMNKjrYTkYbXMrcbSTingFIMuud5Hn8hTtibBDXtyw/CsZyvcZXsywq2jfJjt3MekoPEXuhngQ
	6kIKgTLyI43NAi6FJs4xq4vlmWaburkKr5+uUg+2+O9b2Aqjhe+a23dNo9nwgNWSReBgxbkxkIt
	sd95n66tXTWLYRJvna+y1rn3u0Ym7Ku+XuClZZq8yLkN8doCKcMWCMiojEhpJxkJhprEJtd7/9/
	AU+xItUDLFGK9MfuSsZhUyQQ0cWyEIfDdJjzc3aWr3FeABzkLbT+g9G+Ll0sg5P9TOFWEfc4jNT
	xBEo1VSz5YgkJSD4HvAbsT4NxpyogOm8CvH2w==
X-Received: by 2002:a17:90b:3c91:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39e1e259f98mr3061577a91.1.1789535316139;
        Tue, 15 Sep 2026 22:08:36 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf 01/11] bpf: Fix bounds check for skb-backed dynptrs
Date: Wed, 16 Sep 2026 05:08:19 +0000
Message-ID: <20260916050830.8774-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb_pointer_if_linear() function checks whether a
memory region of length len starting at offset off into
the skb is in the linear area, and returns a pointer to
the region if so. The check currently subtracts between
skb_headlen and offset of the check, and since skb_headlen
is unsigned the subtraction can underflow. This causes the
bounds check to spuriously pass and generate an arbitrary
pointer of the form *(skb->data + off).

The only user of this helper is currently skb-backed BPF
dynptr code. Returning the wrong pointer leads to the
dynptr erroneously being backed with invalid memory.

Ensure the subtraction cannot underflow, and fail the check if
it would. Use u64 arithmetic to also prevent overflow when
calculating (skb_headlen(skb) - off) since off is unsigned.

Fixes: 6f5a630d7c57 ("bpf, net: Introduce skb_pointer_if_linear().")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---

While the code for this is in skbuff.h, the only consumer is
BPF-related, as is the selftest that validates it in the next
patch. So I think it makes sense to route through BPF. If there
are any objections I will split the patch off and resend to net.

 include/linux/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45..d0c1463db 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4372,7 +4372,8 @@ skb_header_pointer_careful(const struct sk_buff *skb, int offset,
 static inline void * __must_check
 skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
 {
-	if (likely(skb_headlen(skb) - offset >= len))
+	if (likely((u64)offset <= skb_headlen(skb) && 
+			(u64)len <= skb_headlen(skb) - (u64)offset))
 		return skb->data + offset;
 	return NULL;
 }
-- 
2.54.0

