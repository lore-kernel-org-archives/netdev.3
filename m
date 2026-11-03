Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672946;
	b=SEj0x6j1sbvSeXrZMHF6n6MwWJh4HbKy9jhQDGEJZ7RAe+33FKB8v1FgflVB9UQqfrKD
	 uPB0mpvkCeW5+9bUcjsJjBBUq3oLpIHyfVjuL+AJiAm7IOGVgPyfvLTp2Bu4jBaEscrMx
	 ZCmYZAeLKNVSZ6SwLHmAWbRnxTe3aAaQLDwjmktMVBtXuVMokVeC/q3tSpa2U6byM2X2+
	 5GexTV/ghGUZo03j5BlBa+bFX0zhRctSydo+EpI7kGtGU+NO/dpuittUV64HUb3d5qZXL
	 +dld2UW3bxFi5u9ZvIbTzeZU0/2K8UYv4rAimf9uEs3ypltSctMoi+pU0xHvE/cAnkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=JVitIrAzmZ42ioJp40YLaoRa+dPpR6cnKnn2NFUMG3c=;
	b=BEcMbfogGJxT9QgV9al+t9AIEqmAC13E+GyK9o8kbWfPOW4Mu15O67QZlbFRtfZpLlt0
	 wWEbTfXlo3Ueo17Db4xlo1leeMF7htLblAsB6eNJgWF6Md+QnHp4sB7FYwU/4joMMNZkC
	 PCSsen18PbYmqsu5b3O23Lc4diqmazwNUJ6hK8tftJR93Oyi4KtubwiB1Ezf+7BvDK8Ys
	 b/dGOt1l/MVFfLAoFTpGAGi3R6tOs79gTVtEbdGj3XUVcHvlQRVxCIBhrSIPnjous0PDY
	 GWHXKhviu3LaJAcvSDtK4VsxrtnrM6SnefCf2FvoEyccUSg1mYcHjXVRZ083yBKqKUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hKgxe1Vw;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F6606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF6F6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hKgxe1Vw
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c76540d0bso44011446d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672945; x=1794277745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVitIrAzmZ42ioJp40YLaoRa+dPpR6cnKnn2NFUMG3c=;
        b=hKgxe1Vw7lUWJvQ9w3L+5VF5XotyCSgkX1iCMP/KcmfY3cTp65+mNy7QilLk9HH/xA
         edIIY/pD4UkUPEwyDNfj4GVO93TDzKB3UGMHEDvztYDqHwEwz/uYwS6f8fTDyodzyNAe
         nKkQSN6SH3u7IUabWfcGLPSHJas9aGDIWbJkz1vB1KF/TjOlpTpiQRXBdYRUthPuvPj+
         1sSM9k+xZiB9q4mbcbhos4PvLpf9tTEE0zOHNmxmwrHgPMlZrbhmnw+prvlG58Dazhtb
         8evgTI3lUvyVQ/X6znCoyIGK7G/TvGss08hO/qVT+8Gw9gG6rc3KK7gKSIj3O5Lh0ziu
         jjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672945; x=1794277745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JVitIrAzmZ42ioJp40YLaoRa+dPpR6cnKnn2NFUMG3c=;
        b=1Wm042WEzLOrQyBDq3UeolaVDhxLv6FsmXqYKp3mjjGN9yIH00hq0YteY+1iBP3onz
         119cNAA8d13YHeGh5lwIHTVSzh4jdGgc249VPypfCWRhbsfeRDbzZdhrkoR2tz9TbQfg
         u9Dkzp3UcEcehB5orrRJzufab5PO383zLkRz5LJuTkLEKWD3s7vAk7no95didANpvkhX
         zJ7HuKhCFMknfqdtDy2bjL7Fl8gussCwXt8sJIRoF5FCFMBi+FmFWprNAu46ZZmPRI0H
         4iFrJEp6iucvHNFCmj70o2js+kMR9AxvOoazb2PqsBtP0p95GQmh1h0Vw+W5D18mLZMv
         1tkw==
X-Forwarded-Encrypted: i=1; AKwUvByJ4Imxe8ZNfi4L0m5ezSHbtetw+DURkREi5GfriNfpw54xIYg/0aArMTI8Rc2hzND6tIrWZvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Pw9ouEy7DqiNEXmL/bWrxb2MlqPs33TwpYzyR7B7sD5jxesi/
	Bd0h11J4bKm7FpLCNlv4oUX+qR8jQjC4WyVDgMf/wB2sY/qyXJaX1eWMhsg5KqDsmQw=
X-Gm-Gg: AYBFou3JrRKV5C0tUpJhoDbkjLMxpZcwuUnMKQCaDLwim4ORcDer0dqL/0b6eu5sKiu
	F+ZOzu3bpB2H+PHwAjR0oBzY9q+5XQLHU2jtGOpN7m+3ouPUVhUpnxmQ57GlzztkJMQEyjxjblK
	O43U4l9mNJcR8X7CmbiwrC38yIjxzNdbkPSLffUCUNdQWNlxU+0jxTodF4moHbCODf8b0mRdd5S
	RbKHUzxpRmHQI667/X0dvh3HkhQP8ID97CATmVlDpgwhQVufwOUPoVe8utNcqewbdUfQXIlNd18
	S5a4rp36PtAai9mMWUSHdqhPemen9+SdTAbzEEHNtP8o1Rvose9/18kwcb0vScIWQrpeJd16eIK
	QtWYJzH58H1q2/z0qol9rvllqRVsaNnKHvPGrHLm69unT7gzuCwaie6hFwqg8Zs1GNfYOj8Wwua
	hNik2QF8cn2DWhSnaHNerUx8m1BmVR7aR8gHhAKIgI7Snye31RwD11jWec4PcQLv1DeQfi8msJX
	mDCr5vRxzs3NttS/aqyo6qBSvRhd/arUoGsihyN4NZVWwr+pReAOQi3cQaYzyohk2QyIGJNhNms
	nx7XKGyVJJFUpBn107PQ6fdPQohl+LCY8W39CqCLHFrsCA==
X-Received: by 2002:a05:6214:d65:b0:91c:8fa6:1789 with SMTP id 6a1803df08f44-91ca4b92fdcmr194775386d6.28.1793672944680;
        Mon, 02 Nov 2026 18:29:04 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f25fb7sm106263956d6.12.2026.11.02.18.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:36 +0000
Subject: [PATCH net-next v3 10/15] net: skbuff: reject a negative length in
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-10-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672923; l=2784;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=PruTOHBwv5dTjTwNqILcr1QH0bLKSEEDfj9BCJzaYZc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN22JQgoXgrJiR5yAYHNf+ITF3NfM8ygPUQ+LdAZK32fRjNubeEAAV9Ib7v/7F/D7ljAdUlHQzF
 J2Sm3nsf4Vgw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The head, frag and frag_list copies in skb_copy_and_csum_bits() each
clamp their length to @len.  A negative @len from a broken caller
therefore becomes the copy length, and the copy takes it as a huge
unsigned value.  The two len > 0 tests around the zero-fills only
protect the zero-fills.

Reject a negative @len on entry with -EINVAL and drop the two tests.
@to isn't touched in that case.  Every caller already handles an error,
and skb_copy_and_csum_dev() zeroes its whole frame on one.  No caller is
known to pass a negative length.

Found by the Sashiko AI review of the BUG_ON() series.

Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b74d8a6ef0f9..e3fc6291d223 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3731,8 +3731,7 @@ static noinline int skb_copy_and_csum_frag_list(const struct sk_buff *skb,
 	if (unlikely(len)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		/* Don't hand the caller a buffer with stale bytes in it. */
-		if (len > 0)
-			memset(to, 0, len);
+		memset(to, 0, len);
 		return -EFAULT;
 	}
 out:
@@ -3748,9 +3747,10 @@ static noinline int skb_copy_and_csum_frag_list(const struct sk_buff *skb,
  *	@len: number of bytes to copy
  *	@csump: where to store the checksum of the copied bytes
  *
- *	Return: 0 on success, or -EFAULT if @skb has unreadable frags or runs
- *	out before @len does.  On failure *@csump is not set and the part of
- *	@to that couldn't be filled is zeroed.
+ *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
+ *	has unreadable frags or runs out before @len does.  On failure *@csump
+ *	is not set.  On -EFAULT the part of @to that couldn't be filled is
+ *	zeroed, and on -EINVAL @to is not touched.
  */
 int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 			   u8 *to, int len, __wsum *csump)
@@ -3760,6 +3760,14 @@ int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 	int pos = 0;
 	__wsum csum = 0;
 
+	/* Everything below clamps its copy to @len, so a negative one would
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
@@ -3775,8 +3783,7 @@ int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 
 	if (!skb_frags_readable(skb)) {
 		/* Don't hand the caller a buffer with stale bytes in it. */
-		if (len > 0)
-			memset(to, 0, len);
+		memset(to, 0, len);
 		return -EFAULT;
 	}
 

-- 
2.55.0

