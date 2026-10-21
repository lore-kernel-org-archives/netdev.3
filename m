Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590433;
	b=yVP9NVnrod/1wMTAJxa//alG/P2kOpCHhDGWH/MX32zvGVCXvj5OBfDRwoHlH/wdU1Hk
	 wU1ohDLm4U/b0dWCruL0SgcduwKMkzOlrsOSi+84z8nRKLs+YzISZsB6X0Q45lIBD/hyd
	 61XGOz/d36cqaA8KmWIyDbPLzbXLT9ngglJS7n4i3Cv7ZrBwEb5LuriHc/OXrtpM+G6p2
	 iuz+7tjUhePEsKykT7pG3Glvl1jwt8/+cfgD37u3D/VX+KkuejbVVVgNLeHPpGMNrMYDC
	 3cdVpo9COhayDvT88khaDgVd3xh9iqnhMeg4TTsWh3aGOS/Cb6z127bDvhBA0MAWz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=DPzcetTQubRCe4lOTpMna5FIDyGXRIDSoyAwtL9E3zo=;
	b=TyWrDr5hSnNub+geegx9u37tP4d8xn8laUyUXEXiFdsocNJv3w9YxIvzrPekt3+j53ev
	 /wTXTZGThCZ72JnK/EgG6GOKMcRKn4BssPbkzO01PqP504Zk+iZhVO2mRAp+1CHTd406A
	 XnU+W4qUQ6uy2Sl83UcCkHnks6ymLohOf6bl3r8EE99crym8WlwSaiYQLnLd7QnNDn5wv
	 i0E3vmktIOEeFSSZ2ZN1/1/7OELtuE0MwglLsBmeIlNrZoXz0iMPGrz0UmCCzy0Ax3j/C
	 UynruoifgiHOz3ET2o9i0CpD42pBIs/wp9ssmhU/F+dgWYhNGaKtVb/XOOd47h8rjWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="i/GWVRLO";
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77093606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77093606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=i/GWVRLO
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e55db58cfso62040885a.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590432; x=1793195232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPzcetTQubRCe4lOTpMna5FIDyGXRIDSoyAwtL9E3zo=;
        b=i/GWVRLOtamq47Oo+QXl/wGDs3DOFKU44TXcYQY7hC8hISCY0vko9sehzH8hXYS6CY
         TnC+3QI3mTN/bsFd9y9F7TPTPhfVg0CxFoeo1chJsTUjQMVonw3mkIb53Bs9X3Xtf3Bg
         9ZZ6yJ3YcMvIUj7u0mXx+BrGzQnNNimx8y8aY6pyKboMBZYdp6ARjRriuZ6iS2whxjAA
         KdZJ4OAmFuDHdISuekOXP8ZWlfxBvwbWYkTaG1AqEEn5W2dstFp9oxDuLVVY1WMXGlUw
         xXtcREaorwZi5Lzpu18roHgjv+aBMNhDGPW6xAtL85fquUYRZ8UwEgjnLUDcQt9Moem3
         PstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590432; x=1793195232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPzcetTQubRCe4lOTpMna5FIDyGXRIDSoyAwtL9E3zo=;
        b=bkjHZWKM84uVZoZT86I1CXasSLnIKgp8QvgJNtlMr0o5Mg8XNYpIW15W4WgIp9ks/G
         ErEDGepxb7BbNQyqOiHMF3ZGq46GZhNE6RlQnyOBMOXDgHhna3ywJFBCCnN/gRBNOEJ3
         AnQusirhoGhVX5agTLs/Aj3VVGJtQ5Imx95tEI8glDXfRW3eHEAi2af1Y7Wo6OLnFv+L
         u6OXmf5cTg7JOUNJoOkZu4DKe4bFDH5c5OZPgKGu6yNJIevGKgZ3Ag8eRKIt+JWc1he9
         554p6oJK7KbgnxY/PZiMVqGsZSHB5yVF5incjxr+qo5VZkxEZ/cLajMWItLZM+ztcd6m
         3SWg==
X-Forwarded-Encrypted: i=1; AKwUvBzl6Q+0uuW2ci4AFfpaYhYwGoQd/p8cKh41VEjfVbnm/UuqRVksHItnOzhxUBQz4+CO6rVE7JE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYFKO6LBvqLFOf361UiGlP8vQKpL6PJvftv9pSTCa4etqxkIEQ
	DK1b+hb+U6rfb/rJ4bE0bbwEYlc3J6QZHLI96J/0lbuRNfmhvlB+7mTrceNxZh2ADE4=
X-Gm-Gg: AYBFou1Ag9OphNhvo2wIc3zgAa9+7awa0nHzsT9nWV1z5sedSJRXQ06V/YfkJfMKohz
	lUDUIs7THvWt9mh/fwXTeC0c3h8Yr6xDClqIybJNtZtmYM720O2sy3Rd3utKzY0OlsFRmu/ePyv
	Dco7EYmm/rEhHM4aubpOP6SaM/65UVWLEQfGej0qanw37avJ6EtSmCkuepFo/l730hNht/UlTI4
	71ls/101yeLlw/lSaCRuP32Hhf+lwFQRpTMvsuVcJYy1xmpjXrQvBflWKsY+0aqNrOriN4l+EjA
	r9ufVB+8gWP37RGUOGOLIyFeoK6BVmjvPumI8nBorZf9n7CPvKaZkn9JFZ4VuAmSCP3V5N2IZ2h
	mA+TniL8p5bizWtw7Bjb1EG7ZJftBlTB/ePPCD7cORXBx5MIoLWCijL5YQiSp+OQ7l61i1EIaD4
	JmC9cyMa7HjrFc7EvN9fYTYWr4pYp/RDdyWZ8nJmiXXOSRoDRpXS04eScLIRKTNWdy6pnUUBWg8
	YWItyBZgZuXbjxm4W8DrVI9ZatiFZa6ASx6sw688b6I51IOgrYonKQEbv6XT87FlxMsv7wt
X-Received: by 2002:a05:620a:f04:b0:93e:4fac:9d31 with SMTP id af79cd13be357-93f57f2012cmr439406185a.26.1792590432356;
        Wed, 21 Oct 2026 06:47:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e221fcsm254323085a.40.2026.10.21.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:47 +0000
Subject: [PATCH net-next v2 03/15] net: skbuff: fail checksum validation
 when the skb can't be checksummed
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-3-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590422; l=2860;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=prj+BQU7C60dBsXDxJX9jL8mklYfFucWwKvpS5MOuJ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB6W8Sr4kysX4RYVPQ/s/LIgV/tAxufFvsN3bU4kpLKDEj3qrHCW/VhTdVB4zPVL/3cqJoYEUrD
 0TwvTS8OOXQM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__skb_checksum_complete() verifies a received packet with
skb_checksum(), which returns 0 when the range runs into unreadable
frags or past the end of the skb.  0 is a valid sum, so it's treated as
one: it adds skb->csum, the pseudo-header sum, and folds the result.
With a sum of 0 that's csum_fold(skb->csum), which is 0 whenever the
pseudo-header sum folds to 0xffff, so a packet whose payload was never
checksummed is accepted, marked csum_valid, and left with a wrong
CHECKSUM_COMPLETE value in skb->csum.

__skb_checksum_complete_head() passes skb->csum in as the seed, so a
failure there folds 0 and the packet fails validation, but only because
skb_checksum() happened to drop the seed.

Use skb_checksum_full() in both, and report a packet that can't be
checksummed as having a bad checksum, so callers drop it the way they
drop any other bad checksum.  Clear csum_valid, and leave skb->csum and
ip_summed alone, since there's no full packet checksum to store.

Found by the Sashiko AI review of the series that made skb_checksum()
return 0 for a range past the end of the skb.

Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 061c61422a38..40d2dd20d47d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3860,9 +3860,17 @@ EXPORT_SYMBOL(skb_crc32c);
 
 __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
 {
+	__wsum csum = skb->csum;
 	__sum16 sum;
 
-	sum = csum_fold(skb_checksum(skb, 0, len, skb->csum));
+	/* If the data can't be checksummed it can't be valid either. */
+	if (skb_checksum_full(skb, 0, len, &csum)) {
+		if (!skb_shared(skb))
+			skb->csum_valid = 0;
+		return (__force __sum16)1;
+	}
+
+	sum = csum_fold(csum);
 	/* See comments in __skb_checksum_complete(). */
 	if (likely(!sum)) {
 		if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE) &&
@@ -3886,10 +3894,17 @@ EXPORT_SYMBOL(__skb_checksum_complete_head);
  */
 __sum16 __skb_checksum_complete(struct sk_buff *skb)
 {
-	__wsum csum;
+	__wsum csum = 0;
 	__sum16 sum;
 
-	csum = skb_checksum(skb, 0, skb->len, 0);
+	/* If the data can't be checksummed it can't be valid either.  Leave
+	 * skb->csum alone, it's not a full packet checksum.
+	 */
+	if (skb_checksum_full(skb, 0, skb->len, &csum)) {
+		if (!skb_shared(skb))
+			skb->csum_valid = 0;
+		return (__force __sum16)1;
+	}
 
 	sum = csum_fold(csum_add(skb->csum, csum));
 	/* This check is inverted, because we already knew the hardware

-- 
2.55.0

