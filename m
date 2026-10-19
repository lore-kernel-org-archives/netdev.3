Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3F4FC322
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417891; cv=none; b=S7IZG5W5o0PEjuWJ6evVOrYk1aMWDEgUqETnL4luyK1VXinXL6nZ9K/eyEt6RsZQoEuKqtWWX4lCpidVpX0e9cuC2NEvqkCM+/lH0OKP94Z8ewKGce5F9foaiQY7iDXeuD/wpOmQdk2V2sHUYX4PxdhpBLgarzIYezLJgy25MtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417891; c=relaxed/simple;
	bh=II/CP7Oe6pPmnThcZPqfbajOFeQVtnEAdIjZymwWmTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrHtaWRc3YfcWh3Ad6dobwibaATZrhDunQK670023hsRa4WZ9HqOwP/oKF7BCIK93+dKFw2IfT254uXFPUw9jyxzlw8aGtLjt5sSVuqis5ES1EEh317tKG42oYCpksyCnpEFjgo5oKLIM56GgooDjBkfsDa7ybBTA+HlnjgkmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=IQzPnE+x; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="IQzPnE+x"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5351d76e1baso27243281cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417889; x=1793022689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NueD3KcSYkb8JdZSOJlKL8CiOB7BO395X3cXr1iZapo=;
        b=IQzPnE+x7yFPSmjqOmEMMqz5aFIEjORBmYRit872HY5RZAHHo7+legvtcVpPVc3+xa
         n5UTKTuo7czq6L/sDBo4oe5P/AnbKjVRLk0H2Xh2Ak8MAgBOodcfd3EnY4pvdbw5jF2m
         6nTqg5/u8RTub9NDea3HnGQeVNx+udVd+ikiS+2v4zf2JMEZ7HVhfm23NVn/DYv1Rj+f
         Z5CyVfw8fVlWXa9XwUEYz1jZuYcbRnWLDF/fw+kBAgn8K62RDMRLMD0bV7kvLfxRlJTm
         RmdRw5o/ik0IUNxMJN7mxKXjgB/JjWPrtcsiRZqjg99t3JZnpn2lhFuovvv1nvwXSe35
         /mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417889; x=1793022689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NueD3KcSYkb8JdZSOJlKL8CiOB7BO395X3cXr1iZapo=;
        b=O9QMYrwQ0f4U8easNaz2e03Eww0Yr6YAqelJVgen259xTmdO8iPPM6JWumaNcSn+IA
         S9qEus7ou4is75vbxoYF8W308TV/f/laAhiAMxYiFK3sZS6Qah55V3L1e0vmzWzeMk2i
         wISXiedXQFAf8gVSiAuyIG9DwUIsbZ9vFn+AETfObepvlrLx7eO5d1VkeuhaCOYnGdrA
         SMPQH2FYD0zLU/fw9SR9x8aMdHFovdDF4/pyBGkl1rjvk3ZZwqd44OoqILKpsi5Ph54h
         oG7P0KAYMR1rdilhqGsQOAvGsqi5HJEr0K9STGkuJhdRAyAuj1Vfe/RA7uQJsRCg69Am
         4twQ==
X-Forwarded-Encrypted: i=1; AKwUvByIezoOURkgzi7t938w+EnYKmRBu0+WIr4Us5nscFkTfLFNWJJWi8ClIcsgimMllS2ok9hxZHk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpGlWP9CPEXVM1sMsIjPyLtoEa5pZeKo8YMcyK9p6mtHAGpbCW
	J6OubpKpdS+tY1Knjsg8xtOA7QtOXwTMR71lIj3SfYuGBuz8jXmY70te9FqhG8V55rsWqIBL4TE
	8M6Yg
X-Gm-Gg: AYBFou1X8JIOrWjq7N4GNTJyEr/GS/oPTfK/VmKUf9ekmRxZlJZtgRfmBMQcfxZAKr0
	zxl231O2bAQbiHB85Z5KcjuDCNxHG+6/m8NtmULSMh2yF7budMy6eGDUb308XdkfyumOp10V6HE
	a+RdOsxHPFCv/mPTG2h8xD+m+lo8g3Pf956YHNw1jgHTf29wzslwLaBqsCWDnhO7wWCfpMgPIrR
	2qOouqpCBLqj6ysJ5E/2XqQ24fXHjr6ntnk/c812joqZSDFACnePk3a0vCCcaqAo+UAGJvFyzfz
	d4tZXJNAM8LrArtc/pN16aOcILcej++PrM/QQU43XFic8HlkNj2RbCBGBJiBJbkXdJILbqGAJ9o
	255qGyZKNmcMTIst0OsfC7F7pGI72E7m3EFoTJpMkz8Sw8YVn7ogedJvrgbWNSyJ2tOp1ec4Ok2
	WM3cFJdO0wQ8U9yxvnyysNG9PRmokHBre0bpXwCd9XgoUC30gN4k0GDp4H4vDjOwrkRq+ajznLR
	8hCnzuZyT1i3Q8=
X-Received: by 2002:a05:622a:120f:b0:535:1d5b:a7fa with SMTP id d75a77b69052e-53645fcfd95mr105600221cf.14.1792417889532;
        Mon, 19 Oct 2026 06:51:29 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5367c3a016asm8422981cf.25.2026.10.19.06.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:44 +0000
Subject: [PATCH net-next 10/15] net: skbuff: reject a negative length in
 skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-10-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=2599;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=II/CP7Oe6pPmnThcZPqfbajOFeQVtnEAdIjZymwWmTI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLT77d+wO2aZJcnSaM7dE9IczO8S8pXOJ39O2d4Dqx9woYqiJPcR/OP7dZYvy9TOeJvXuBMsRjF
 HbZ69mG6gdAs=
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

