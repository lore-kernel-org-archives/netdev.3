Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691353;
	b=BqmY+x1SMuOXGYgvLJgIkra5Wy1qiuJS/DT/bTX7jE/X7ZtXcQtN5DDb4Ipu2QE1u7+7
	 tADAUhJW2D6N+PCDk+sClPnyOucIixfXRlaSzN6lue8Y3hTxzRXMlaZ7e2nK7dRrb/0NL
	 T78qafL70jmmYcrAbvnuIGB9q4HBW3V+vLitlxvrnXEfGdAgfgKzwagF3Jdd1hALFmEPy
	 +opgAb/voqeGi7/CHeoTmxTYQeuxD1ZjPbMWmkDZnSVnS0Ifa+gcIAcrexp9I7lun4Ydj
	 OfK1u1kl3swTiy6mkl/o2wJFhqjBS/MreIqTBKJC1ELaty9bkQWkkAsk2F7uIVAFMGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f0ZLBISeyce6U7/hTVm4ywHVaFNN2V0ZlhVxxqx6eaw=;
	b=TusR5trwuDAMte8biFWQDWDLAWekYzICrHsWgKk7dsL4OcRdXyDNJ1jh8OaUvy8xzDec
	 dJjE0Ed71z3daIbOBj+qHayBCWqu2zO9A1HY51v/AwFcTz3iRIr8gLoCgR1Qwdj/8x3YC
	 EClWIcmDhYAx7VsrszuIQ+9AVWItR9ub8uhKdWr+zBX1g9qr1mWmk0QQZWUo7Ql/GqtM7
	 JBfvL16ucrxvO3nqxceIDksxr/KXTnyGDcPk8VjKN6wHjdj/P/MgB5B0JqoxxOAm6GYRI
	 UYNqqPXOWxCLolE+eK0DfE61bfAjlTBhnuTojuRslv62DZ604SejvvvlAl9unLvA8CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BzfT9vcQ;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF8606A322
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44FF8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BzfT9vcQ
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea759cc9b6so3105ad.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792691353; x=1793296153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0ZLBISeyce6U7/hTVm4ywHVaFNN2V0ZlhVxxqx6eaw=;
        b=BzfT9vcQo0dX9K6hykJfFHWOLKclttgOrxAGaeJvwHPh40AsSaB2+B6F9Pxqkm7hb8
         YF/EKuS3WzwcPYEUI8mQTzKQe57H7DY2pRVx9fKu2nFT96xhQgLhXITu7gs0lhAsElfh
         uATNeLWjFzfIEHZiN6z89LhNyNM39SBZCGe3mpU2mHEuJBeqdt5Q6CWVotqLk2Sdyw29
         o6+Vuz73ku9T1FK0v1w02r2HKp5n2hEk0T404r5gRbt4CykpuinAHNPT1HaWYCjfO8OT
         LTLvQHdDMTG30GSCGhC2peA8PWMd3dWf4DPJopyezHSD4rzWwsCcE4QjbbcwLTWAnQfe
         eHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691353; x=1793296153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0ZLBISeyce6U7/hTVm4ywHVaFNN2V0ZlhVxxqx6eaw=;
        b=kqDUqUkeNbFgqRosLyLWDvaJXpaUEgd5oSBeWR4fhRhSr8wE2acLV+tAPSp68yxsg3
         1+SWmrpTsfhQjFQ0SPxvHjtmdMSk73wbjkzSeQ5cNlloKHMtNKVcg/uXUzr1mB7+AJ+O
         DSROks8Bfu0MuxYuX9XiKmT6bKSY+41rJNIUkEJeRUavpw39ni865PWZ1UdjS2MJPzG7
         e/8dEsJa6Ks/A7HDopqH6Rs3XUB4uuBcKXgn76BvSkLPnMkChI7cPHzN9LTeVxQzsvLD
         LEzDgHklSXAhO49H9t6t/7oZ3anPogaSCi+H/HTP5jEpFtSNWYIgRN7qp1nVhQh8sw0n
         phuw==
X-Forwarded-Encrypted: i=1; AKwUvBxLpNl2lqLY01N/mpNZeeOQKADlkLYf+b/MRddWQMoixLN+SWigsThdILgSZon2eBm3c3vumpM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS0GcsQIdind4HC7LA5RcUdZPggxsRU0Z9saygIyX6p++sjY2P
	6LcBOqry9Kz78F9WEnOCblflftI0E6xMpV4lYWoNzTdSO0Bawo6oeZJE
X-Gm-Gg: AYBFou1UlPuFvaZYmsbpi2Nvexg+zMAbZAFl7Y6VFsAzkUmAW591FWnLQSFPq7SSE7Y
	Ekdf6Tt7gVXUl9N2Aupf1j6isYJh2+PQFDrIV7uhlMFgzF+U+ng3+kVPJQw9U2F/amCz278Q6Rn
	NqcDntzIVe8TJR3MqyW+vaYelhyWmPBm4FVxeOg7OhAd1EPs+71z54+X8Fryx6UdarFFOWctW+3
	Fwa8XUp43SMGoS3+8Vq2S+o9AO/7no2wxg2/ufVyAwX8oA8zEEEWTb7TQnZqXoUXyKtPMk1LBuG
	OGMGOuz3er4x/7BiZJU/Rx0QO75MfqDXsalj+73M23R6u1wqWDP7qU7KOYu9gyTztOG4WafgbVs
	fBK9Qek7e5OrVmdGcD75tPTKBTLrSUL0VriEaNEZ6Mi2O0iJibl+B08pa96yXgZfQWc7+cq+mAI
	D+6C7BcPZ3MxB+db2cT10mV5u0wG28K3MqIVWGIQ2A9OoO7gikjoCzMs/KOSl7kldMAjNAivXaG
	ng/m8rtOvGtaQn0W3QClZoRfOcRPGCx2/SnNxqbfmukGf4xDnjrE47sayfphBu6xTQABgqJzL2k
	erJCTZoItNoWvZffZIp+sN9i7YWSQ6QXlEndNZbpixC0em7gu0c4OQUhhYhKNvBsjM+GRSPhLG8
	kkgRZSw3GfAI=
X-Received: by 2002:a17:903:2f8f:b0:2db:733c:fd1f with SMTP id d9443c01a7336-2ea7c169201mr1589395ad.8.1792691352522;
        Thu, 22 Oct 2026 10:49:12 -0700 (PDT)
Received: from test.. ([118.68.116.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7af67e12sm1722565ad.10.2026.10.22.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:49:12 -0700 (PDT)
From: Duc Anh Luu <luuducanh05051995@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: netfilter-devel@vger.kernel.org,
	phil@nwl.cc,
	coreteam@netfilter.org,
	eric.sesterhenn@x41-dsec.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duc Anh Luu <luuducanh05051995@gmail.com>
Subject: [PATCH] netfilter: nf_conntrack_h323: fix out-of-bounds read in get_bitmap()
Date: Fri, 23 Oct 2026 00:48:55 +0700
Message-ID: <20261022174855.615855-1-luuducanh05051995@gmail.com>
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

When get_bitmap() decodes a bitmap whose end falls on a byte boundary,
it reads one byte past the position that the caller's
nf_h323_error_boundary() check validated.

For a bitmap of b bits starting at bit offset bs->bit, let
l = bs->bit + b.  The caller guards the call with
nf_h323_error_boundary(bs, 0, b), which reserves ceil(l / 8) bytes.
In the (l < 32) path get_bitmap() first consumes l >> 3 whole bytes in
the loop and then unconditionally reads one more byte:

	if (l < 32) {
		v |= (unsigned int)(*bs->cur) << shift;
		...

When l is a multiple of 8 (l == 16 or l == 24), l >> 3 already equals
ceil(l / 8), so the loop has consumed every byte the boundary check
reserved and the extra read touches *bs->end -- one byte out of bounds.
The value read is shifted below the final mask (0xffffffff << (32 - b))
and discarded, so this is a pure over-read, but it still crosses the
boundary nf_h323_error_boundary() is meant to enforce.

The extra byte is only needed when the bitmap spills partial bits into
a further byte, i.e. when (l & 7) is non-zero; for a byte-aligned end
the loop has already read everything.  Guard the read accordingly.

Both get_bitmap() call sites in decode_seq() (the field bitmap and the
extension bitmap) are affected, and the decoder runs on
attacker-supplied H.323/H.245/RAS payloads when the nf_conntrack_h323
helper is active.

Reachability and behavioural equivalence were verified with a userspace
libFuzzer/ASan harness driving the unmodified decoder against
exactly-sized buffers; the fix removes the over-read while producing
byte-identical decode output across the whole corpus.

This was found by incomplete-fix analysis -- reviewing the recent
out-of-bounds read fixes in this decoder (decode_choice(), decode_int(),
DecodeQ931()) for sibling sites of the same class. The code review and
harness work were LLM-assisted.

Fixes: ec8a8f3c31dd ("netfilter: nf_ct_h323: Extend nf_h323_error_boundary to work on bits as well")
Signed-off-by: Duc Anh Luu <luuducanh05051995@gmail.com>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 6830c9da3507..8c04925b7007 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -229,7 +229,8 @@ static unsigned int get_bitmap(struct bitstr *bs, unsigned int b)
 			v |= (unsigned int)(*bs->cur++) << shift;
 
 		if (l < 32) {
-			v |= (unsigned int)(*bs->cur) << shift;
+			if (l & 7)
+				v |= (unsigned int)(*bs->cur) << shift;
 			v <<= bs->bit;
 		} else if (l > 32) {
 			v <<= bs->bit;
-- 
2.43.0

