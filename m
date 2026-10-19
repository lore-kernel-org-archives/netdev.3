Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7E4F96C3
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417862; cv=none; b=s6QQ1yVPVSU86tj3ElIdcCAMJt36Y+GbBYh9KCyhAAZ6ILNUTPT6rNHLooaxf/qUHmZGPYpEVWZF4O/15Ontji9SIiuSxFz+fDeVVEZR2SNUdVqkYGESZNYeurSnw4P0TkI7Kwt+loi1E7hYnVeUzfnhSr34ghRXzjU/3BNpHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417862; c=relaxed/simple;
	bh=prj+BQU7C60dBsXDxJX9jL8mklYfFucWwKvpS5MOuJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Od6iAKTMna5bsqFJjXCQEFtsw2jajU2kzjNZN+DoP8vkP+Srb7nS+Y8qIoPOzZ0vVCaDjj+MA4bIcm6Qp+bigTodDgMac1ylmOn5caFputzlbcgCyoSnRD/PWR7xgYkzP/xC2a0HCaiJonW026rvH4dD2lFloKnYzzOFu5yoen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=i/XUb1xI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="i/XUb1xI"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5363316fa0cso28487551cf.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417860; x=1793022660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPzcetTQubRCe4lOTpMna5FIDyGXRIDSoyAwtL9E3zo=;
        b=i/XUb1xIAQTyzjyaYzPjxD2joerTuwqoiJVXMqaZpLXVhvWKCKeAeZRYExtKkOHdza
         HEfFvlbn75PswIky96DxAe9+H6CpNV3DwKRAwNQ/LOHppZdp+2dDAxQhjclL0Oo/ZlnA
         joM5bPXgQkj7VpCM8uWoV8tY3AP/oTsoWD3Qfrx3H7F8jh6lLdGsOLZntVvmE7VHdil3
         SMUkULu7QnUBPDOwjsmRN5vku12tdOA1e3LS7qPbYxGqTylWh6GqEmdfWycHlkX6ond1
         3D7fgAuMLkHchJGvQjWQAUZv5O4TXFp7XZ+Ujt7n49vgUVkkJF72Wn6l+bvxF5cJsFJK
         q+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417860; x=1793022660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPzcetTQubRCe4lOTpMna5FIDyGXRIDSoyAwtL9E3zo=;
        b=rCh8cesdQAIMb5qeXw7NVZk6ZseMjrR6U4gT+aA1/FbyJHCuwcPHNwSKnQiJNjBqWM
         W2GXRxHP+xi++wiJjsnq1azpimxJd0Dp5rVQ30Gaipgv/MO4QGxbTb6oG1Fp8ulj2xBB
         D7ZM25s5YLBdr1qGuXe8WnqsqtZ/4NAMcIxDzLmn3/Jqd6lF4rC5oibm2OcGQN6iTuup
         sCpk+F63nBWG9POKE3KBtkuNZeMU5qqC2/3Hxpe6SCEcOmACRjAbAzlJQpQjsQv0vtx6
         fEy227bscTTDJIv8FE9P4v36iJpK/IRFVjmxx3q379PwiR0O7zPvPw/KJq8/sc1PWxlM
         YfEw==
X-Forwarded-Encrypted: i=1; AKwUvBxGYwDbwOugQVzWUJwGEX1LHHaEAuXcZoIJDRZ/pbC94KJIDY1NoUBYpf35hoWQC0+ZhH5uXUQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC8urxuBZWleNtHaKkZ+AvJUa1eiybOnD4CmG26BC8uj3aPwL7
	TKIZzDt4CYR46jkZCfXaRd5yvbYRCAtItbbduE64/I8ni63m/94ek+AQ/mFcoWtfW88=
X-Gm-Gg: AYBFou1n0PkZj9sJ/RFHNssfOs49Q80qwML8J6YWFyYZupNVpBSIRjwIrfIdMizuuk+
	bnDz0kJry08smm1D83C9ZjnG6cawk2UoOkk6i6OUWM/xX+xd0k6uaUT3/z07LwOATBgbQwTsIHC
	Y9Er1TcxEOcqajHXfuheCn8cHtxJYLG8xD3iVTA29UHHAfzo5uh7a/UlLQqDiq39WV/wZmcJA34
	Bf5hGdQeLqImHv+mYeivCV4WA7sPCUTzcZvaR5u6ho91CaxpM4YWK3b+7hvmUAe80BIf8iM8jzY
	sER81Dumb01U3tdBRQFARlFusO46cxoYAgAASxnK+g08cn5WI3sWi32m8Uh0bTngjFyvj+iha8y
	FWWNc7RdqnoI4Q1aXlTXnfAR6hq9uQaNb3E/E4OaUVC5d4i5UvXvuzqe2HOKSJpeSfIh1MS9ACK
	iNdfjOa/gXNYiRtu25kCacJXzp9xipUiCysC6yDLL7+K330p1F8Jc2RvknIuS+oKdQh1vLn3v3L
	uYlsVxnV1GqjWg=
X-Received: by 2002:ac8:5745:0:b0:532:abc9:8f4f with SMTP id d75a77b69052e-53645ff0043mr114359591cf.37.1792417860150;
        Mon, 19 Oct 2026 06:51:00 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb27839sm98396566d6.35.2026.10.19.06.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:50:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:37 +0000
Subject: [PATCH net-next 03/15] net: skbuff: fail checksum validation when
 the skb can't be checksummed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-3-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417848; l=2860;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=prj+BQU7C60dBsXDxJX9jL8mklYfFucWwKvpS5MOuJ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QORYeqwwHo+WYErVqZ8QYEvyduUuJE0wPwwChX6fbXgz7Urjug8C88v1GDgpgDsaWL42fgGzxt7
 mVAv6CTaYGQk=
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

