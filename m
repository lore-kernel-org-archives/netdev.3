Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E74772AD
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108807; cv=none; b=kdUc+Z4i3dAj6OGLos+lcJ7qDdJ4xANNdfWcwEivfUY8tLnlmVVbkTTgj3dho+UaX5CYXtNigirooEFLf8GnM1NeQNfG49SPvqtMxvG6abfcvYIF/Sv0sKG+4mXwRt5eNkJECbG5pbc011brNYBY+1RytkAnSiNIxOk6i6C4Q3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108807; c=relaxed/simple;
	bh=XEPKuFkhwe8ZEQpD+ybrZ931bpYJrWOlA0mPf2Iby4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiCco9WYlZvjQrDNKKjB8koCecW6n7R8Jt4r5xjsSkmPGSy4FF+VmuPtrr0oAmbN0qdfVvZuanIZTgavwLsmZehHd/mo4jIpZchRjwyX0/neV+/Mln13CDoPv7rfqjjkypEMH5vMLj9d5C7w36LP9EBza+c0swLzWno1NtC5jZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ67GseK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ67GseK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495590dde14so38621735e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108795; x=1786713595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JFwnycb9pT/CeFOR+3rV5yTDz73HQ1IY/EPJ9WblqSc=;
        b=kJ67GseKWztVBEt1G6HCpMjmx57HHOTCojzwIJzRYpAWdcL8AyoRTIrvFtnen/cB/U
         gJvRkOnwf/kP0dPNdpI4P8aSp6H49iskdMSH7aKWCcu1CvfIpbzp4MQUkMHk4Ht3NfbX
         pqZFTzDF4FpAn/U9/2sMYsy3N5Pu3W1LgHGX746kdSj/UfLRBNui87lZXEKsgz6riiff
         FRGOWSl7pQRAYxy3e+CvcJolD972O+5ZFMiPvM+/RlQH3Jt2u+kG2NEjge0A79I0ubru
         3LD0AjLJd0aJy8mz4vLNmYbo8PK8U8hrNLYhN5uhdzeu+jduBP12AalmBiyk25LUTZmZ
         obiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108795; x=1786713595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JFwnycb9pT/CeFOR+3rV5yTDz73HQ1IY/EPJ9WblqSc=;
        b=Eb23Z1qQBKVSjrsLzzVuCgqIg3yUpE4X+4pE02v+jL1SHCeLwGlMZQUNgcRV25Em/5
         sMt04hYd4Mt7q4CoVdp17ciPhh7a9pEbZ/CnQjPgss7BcGNCg6Jh5WHqb9yyt4C2kdph
         rHUDCXUvwxv9CS8ZgnA2VjO/kAMlcFuVtJfL7v5Mj+wYD6v9YgnHCqIMQEPuVl/OCXEo
         CQTjWLEMlHZGMdklTpJMP4Hd7bUGTRzwStEgSDe/7r8ayocaxORH7Q1f6m2OWAIt7To4
         zBx1bjZ04UesOGXRzOzHC49O3kKJuMytl0/n45xSwa6aVDI+p3D+NXBKpTY0Dh8xFGeE
         /iJA==
X-Forwarded-Encrypted: i=1; AHgh+RqABNlUNG6cH5HOhHJYQAQAUud2l6cYcgW3zP/yeetyjOiiFT8xYfEdxI4G/euKKTp40m5vqJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+oR87Nl9uKsiNC0aQUTEFx5s7OZTkVod3x9NLjXuOjPcGbDHH
	cC7pgQCTtPoniQbHSP5nwUsBM1AcYnm7B5ahkDMwXcMKg2GE6ecBFQd7
X-Gm-Gg: AR+sD133nPzdlVlg+S/+Q5Hjg61c+kz2+8kxYP1kJW8KOqYocIz/g2mlIoNiNp//3rU
	L617KOKhErt2f+VmA+FqawWJdT0Ese9TcZ+08IvuoOVsAZwHGq+NtR6m5IVd9JzgtZRcz6e2U86
	SGTyhlgnaJ+oLP0CDWRUkzyGbcqLDn0aThXjMNFixxjihcQGMSfiiWlFHaK4veNhO+LZLfzsNdB
	5VcvS2sBtFAHk2PB+83fqCzrx61YeDTgaJ2lXZjWJE5CHhlRlqI9Oits24786cCQ5qQiImeF2+t
	57WLhd84uatflMtyonuQuix4SK8kF4jpUk2ijx85u0oJPtStWST7lz1E3ttF7TD7CSVukNfe9c7
	ABsHQv6J925iM+r4OmA2YM7/lRs7u1VNXFu/YtXRU/65MA/zbMe8nQeh97xhqvOp7mSWWL7DhmA
	4cJaOncmjKRTn3gNC9wGJyKfzm56NaHs/XM7kdptvd7nlH+5r1fQ0rYVRFBk8G/edRoG8FTvzKj
	fAgRcPQw/lbdTei5r7oRlJWOZQPn1oi9v0Zik3R6CaDUGvFEl37qLWjiPWjalsbrJbFmtC0TAJJ
X-Received: by 2002:a05:600c:474a:b0:496:c361:fb96 with SMTP id 5b1f17b1804b1-4994e6db5aemr273450105e9.0.1786108795242;
        Fri, 07 Aug 2026 06:19:55 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 10/16] io_uring/zcrx: don't pass ifq_reg to area creation
Date: Fri,  7 Aug 2026 14:19:28 +0100
Message-ID: <76751ee4747abb4893058fcaaa36895dfe24a297.1786108672.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786108672.git.asml.silence@gmail.com>
References: <cover.1786108672.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We might want to create an area without having an instance of struct
io_uring_zcrx_ifq_reg. Extract a helper that doesn't have the ifq
registration structure as an argument but takes the buf length
explicitly.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 5b46e1335079..a142d6035f7e 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -459,21 +459,22 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 	return 0;
 }
 
-static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
+static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
-			       struct io_uring_zcrx_ifq_reg *reg)
+			       u32 rx_buf_len)
 {
 	int buf_size_shift = PAGE_SHIFT;
 	struct io_zcrx_area *area;
 	unsigned nr_iovs;
 	int i, ret;
 
-	if (reg->rx_buf_len) {
-		if (!is_power_of_2(reg->rx_buf_len) ||
-		     reg->rx_buf_len < PAGE_SIZE)
+	if (rx_buf_len) {
+		if (!is_power_of_2(rx_buf_len) || rx_buf_len < PAGE_SIZE)
 			return -EINVAL;
-		buf_size_shift = ilog2(reg->rx_buf_len);
+		buf_size_shift = ilog2(rx_buf_len);
 	}
+	if (WARN_ON_ONCE(ifq->niov_shift))
+		return -EINVAL;
 	if (!ifq->dev && buf_size_shift != PAGE_SHIFT)
 		return -EOPNOTSUPP;
 
@@ -543,6 +544,13 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	return ret;
 }
 
+static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
+			       struct io_uring_zcrx_area_reg *area_reg,
+			       struct io_uring_zcrx_ifq_reg *reg)
+{
+	return __zcrx_create_area(ifq, area_reg, reg->rx_buf_len);
+}
+
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
-- 
2.54.0

