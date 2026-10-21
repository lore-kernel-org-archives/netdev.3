Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590447;
	b=BDcDVMTenM5qFbk2TdCWTkDGGhLsER2ZRCtJh6frQad4bWnXpg+Ihfk83AtaicyT6DPl
	 AYHe2a9/6u1RDosNvksNbtoRfZ4yRvOMsa94gmTUzea9zE7Z77UUBNdiFJZrGEolngqH+
	 TeQwv+xJiSA2JISp5+rN8G0GLKJ3t/v4ZxNff5C+3+NXo4FsrbXH168fzOyYKh0XHHt3O
	 lge7IZ1GaOrRkGyUmqDVYztmAfTgmNvzIfdFqzbkYZF193o82MRKGRkvMocmWX2QfHCWy
	 FNTcAUSFuzzu53wjd1ri/YbQIsKd42RBwBM1olHlXXBfdg6ryBlZIM7bQ39fX1/0xIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NueD3KcSYkb8JdZSOJlKL8CiOB7BO395X3cXr1iZapo=;
	b=tB6wMlnDjeUNJDeVup3i/ocVADzpQLGc3MLBW0XjElwSNopgCHfjnaQcHVUqZiTkC8Dg
	 jBeYD7waDcFP1e/92M6HOxZEWdeNyltXnu0bo8SzphBwLaPdM7I2nY7ADVa0NPGxHe2JI
	 camwLTNDnxf6GBE7osWmeqCX7QidMpfSxHdFsilZAvT5+82RGPRdiSqfmXLowYNc/7TYl
	 pZ4j6Ne0c+C1ioe06zEUzD3WZsF4Dcx4umlpvi9+vTEAWVdVCezDJI+qS6ZuQPHvuOl/F
	 uFME+3giZZ9EXfRUA3xSCnLBlJv7rBeGQtgQXxigs1J78/5jbHlhijhUuBbAe7SvqmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ZWfEGX7E;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7060A2609
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C7060A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ZWfEGX7E
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67a000ac7efso657038d50.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590446; x=1793195246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NueD3KcSYkb8JdZSOJlKL8CiOB7BO395X3cXr1iZapo=;
        b=ZWfEGX7EHhCKxrSucIGaIW2UhmKHQUB/Lw0OMR4JhXLZ7mfAYc2/oFeNe1UkzUk5bJ
         AO+3j3aor3xFlC311J81qY0m20zBQ5f6FfSpfJDkXc/uSLoGN6tnvIL+QNgP7PVwLO0/
         dg8O0+Op3/oQem0L8BkwytsuDtC5RmDQDirNRm251D8uYyzF/eqROPjL7TK3ZeSLdDD1
         2hAlDTwBZnJZfWC9Flfdc6AFRaPgt0eP7nSVmuqiqAi6FLwYUt0jCthc6r9cQHlXdiCY
         E3MsfmTcsPNLU2LMTiO0+LfBMkBWX4ys70jOBC2NyoROhqRwCSUXsoVkFXRQpNn56Dp5
         knzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590446; x=1793195246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NueD3KcSYkb8JdZSOJlKL8CiOB7BO395X3cXr1iZapo=;
        b=Acxo3mR7sdUuj6FuZRH/nIIeYq0M0c9WwNs8MUXLHMnvxX04D6q2NMh2lR6Anwcqi1
         N6Afu9bpqjF/ALK5HblT3K6RDoilQbkdNyJ6LSBNXQef8mlCF4U9p2bs+L1TjDVyP4ev
         FJtKmjLA2TRB+xJutf8X1lGUqNm6ZT5a7anuxhKRfAyOrcnBDovn/P3wPpj8znG4jZyq
         jMrDpJ02I9K8vdxO+4jRfZmy1d/HceaQO5GlHe3doJ8pd1uvIeJPQwXtI3ohIkIEiDZ0
         A2gwie1tge9E0d2Bgp2zzzMXrfl3Bk3cQ1DKE990muQlxw/QfRIvzQZJcLO1q8QOwAKt
         BZRg==
X-Forwarded-Encrypted: i=1; AKwUvBw87e5lw9UZuE1CZr2JBFhV4jXUrcKCuJekIj9b34sppM4zG0CwTUrHDR2nZ81+w925XM/etRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0TDP2zZgAhoi9Nx9BjhWp68waSAHKnvhSIGXQyxIZ96+7uI1e
	GL8EB9ZTk607qzLlcqP/CHjkOu96KqHM78cPiUVtBJLhUBQUsi4mH/Pd4qaDjWNK2qg=
X-Gm-Gg: AYBFou2IVo9xm03147ZZo1VWDXmBFmrgvPLATom0oFyc3qUgwcG4uJ3ceddLNWQDoVn
	lb9F1am+L3mL9HuzSk6YhjaUseDrAOR3uwbhfW1EQaRSo/5yHSbBoTM4+qGKGsT2btLCVIz+EgU
	Mwcneky2r4lc0SOp0bGhw+4lKWMUYt7D8pVDCOiQyfJ/4ni944bwMyN+zqhKgzcbesFOS2WznMn
	lYzh0wQSMv2D2miJdexIsR5OpzYKalN4xEb2m3FhbUaDklBaeiS7jn6UgzYRQZpTE8GAA0BsagI
	pRwWRHQ60pCsNnRKgePM2KcGbfQzzw9MODDA/2A46ErRaHJf3ScSlNQqy+Y1CEMjAbu1F3eHHFs
	qmEmdUnK9soe5ZiTx/0XoWwKAz7nER+FboG6IbwVzrSfIQ8uq03WFheHH1eyrFBzI/uc5A5TboH
	LP7qcZPbjoTrAiEo5ALJ4JnBrVrh4JkfpBZkpPpBC9pCgDFRiejSMdA57ZMPESmiBKYMkqNZ/5x
	8LGvelK8EJbN1WjygEvka3y9dBjsosJp2Ueo9QRai2xRpmUj7B3qNN/kj3Il+Ng8tv49Gh9
X-Received: by 2002:a05:690e:4853:b0:675:617e:6c2d with SMTP id 956f58d0204a3-67a0e4b66b2mr896013d50.25.1792590446255;
        Wed, 21 Oct 2026 06:47:26 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e185441sm1078051d50.3.2026.10.21.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:54 +0000
Subject: [PATCH net-next v2 10/15] net: skbuff: reject a negative length in
 skb_copy_and_csum_bits()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-10-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=2599;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=II/CP7Oe6pPmnThcZPqfbajOFeQVtnEAdIjZymwWmTI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBCv/T4tuugSwX2rkOLKSCWrxmAA7LyX/rWbZaGf+yX4wPBG8KKxQ/YtsGe6jDvfA44EL7VQpSI
 8w8aIZgV/RQE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit 417261779eab ("net: skbuff: don't BUG() on leftover length in
skb_copy_and_csum_bits()") guards its zero-fill against a negative @len
from a broken caller, but such a @len never gets that far.  The head,
frag and frag_list copies all clamp their length to @len, so a negative
one has already turned into a huge copy, or an endless frag walk, by
then.

Reject a negative @len on entry with -EINVAL, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels, and drop the guard on the
zero-fill that can no longer be reached with one.  Every caller already
handles an error from skb_copy_and_csum_bits().

Found by the Sashiko AI review of v2 of the series that made the
change.

Fixes: 417261779eab ("net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 782a6bacd568..56cec58bccb7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3678,9 +3678,10 @@ EXPORT_SYMBOL(skb_checksum);
  *	@len: number of bytes to copy
  *	@csump: where to store the checksum of the copied bytes
  *
- *	Return: 0 on success, or -EFAULT if @skb has unreadable frags or runs
- *	out before @len does.  On failure *@csump is not set and the part of
- *	@to that couldn't be filled is zeroed.
+ *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
+ *	has unreadable frags or runs out before @len does.  On failure *@csump
+ *	is not set, and on -EFAULT the part of @to that couldn't be filled is
+ *	zeroed.
  */
 int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 			   u8 *to, int len, __wsum *csump)
@@ -3692,6 +3693,14 @@ int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 	__wsum csum = 0;
 	int err;
 
+	/* Everything below clamps copies to @len, so a negative one would
+	 * turn into a huge copy.
+	 */
+	if (unlikely(len < 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
 	/* Copy header. */
 	if (copy > 0) {
 		if (copy > len)
@@ -3777,8 +3786,7 @@ int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 	if (unlikely(len)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		/* Don't hand the caller a buffer with stale bytes in it. */
-		if (len > 0)
-			memset(to, 0, len);
+		memset(to, 0, len);
 		return -EFAULT;
 	}
 out:

-- 
2.55.0

