Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825283;
	b=ps1jF6ubdyel7EoItVWLm32k0S7x+agOOfKS5gJ4G3pfOF20JYSZ+So8uzvTO2jmb7H6
	 LbJYhrJpEO8OYrgyqAa72Ar/Vp/3aSPFDzYHvwzFu5MO8C+dNR3mOe9F2bzf70v2hi9Dr
	 7+pj9MpuQvsmMmdAql32iDSPBRPKAGcV1+imLZUwKo1hcUQ15AZq+2Cj9H1ZfZMGUt47n
	 7IuoYhTh2H5eE1oFDP0N534PMm8+vShA4jbyHZ5TFuTvmjKPqTSxOVParvYPh1STKv1V2
	 wcwj91ZePrcQSa/7D9vDgr6AgNIhHlX+QlhmfKqRf7Da/mhvX5I8AFu6RP1F5qbxVgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=PP/fidHZYkfblatQP/IijP74GKPYKHpT3ch7DoXcS4E=;
	b=R3gRQw9oyrRFk0cG3HgOCHD4LrCQrJdnDQ3bmpvLdnYRD2JRbAYMNLEp9LIrFGtZ0wCx
	 VacyRDJSZYDIEaO5sLCjlBvAiFPuo8aGUrEO8LFSIGFrQ1d+3rlhB/4JGuIkxswcZ9GRv
	 A25utsXDGAa9AWx68eJ5pOEV8vVRL2pcj2m+Rr6iJJsfDtGGJQzjV3vVhjEw+ZKhPW9wT
	 nwRnA2nZS/O89GVU2Kk9lKZ/UuX9EKwuL36rrSNSXvpT9COan39xE+vlaRsrXT3G1REx1
	 IWmfSVNSw5y3DTpvCo+E7To95bBkD71SNpDocJqYO9LdGdrCah7txWsY3HpWvSU0w2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=UDyEGERo;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A320860A6F4C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A320860A6F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=UDyEGERo
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f22a8515eso113948385a.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825281; x=1794430081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PP/fidHZYkfblatQP/IijP74GKPYKHpT3ch7DoXcS4E=;
        b=UDyEGERoLdfOCtbRBl6mhF5vCiTIPKKkkFvAlPeTb2DdgsEnpcpTayfj6MjlmyZmjn
         Kai/ZGN3HzOxK7Srkd3tvU+hruGw0Vi7J8GgLGlY1b12s7meMpdQpOyrg+nsXEEzqFeo
         ohuYvTQ3CpXd4RZtZUQfpGjCVjQbHFmuxAbaBWnvj6b3W32zgSbnkFi+AVOpHaJuTtsN
         36fKlKeaVA0NhT2G4upI9o1wpHtekeKWvjT0xNxSJrI/DnMY+WgToX4BXC4kZJvX1w0c
         oeR+ZY3mcj2uycKHuhlPayrYSmQvCYTa1weiU4w0dkXeTWxXICY3CWppgw5GHyurUI35
         mx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825281; x=1794430081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PP/fidHZYkfblatQP/IijP74GKPYKHpT3ch7DoXcS4E=;
        b=yw0P3od/NCj1W8dQys/VjUzTlNNRP+9bfgXJTT+OYVetI7e7GgM4jjfR+z6o6wp2jz
         XDFOxJUYH+bZCA3tUJJfH3fxOW7EQ9POqdZjpJT7YhfymJx5bzjxFehTNBKCsBlP7Xo1
         U8kdrwzlQ9MlFiV1Q54G07i8C2p7CVqGDJgruuHTA2eOLbffembNKHCulTsri6myr5lR
         w6dOGFpRyxAN7ENZ/zGYEIWOD1jbltfWQz9KyZSgTbEDHlwSaGIaUP7E7XAkxHs4ZGti
         XLLqr+Ovp59H0r8S800mrAjRbcpb43bfdCSlm5B3PZAoGCtwxwTdfLtY1hDzRKnuxquA
         KvVw==
X-Forwarded-Encrypted: i=1; AKwUvBymlF4eKbGF5y5Izzme73+e5/gS365D4tOj7rutMZ3CuF4oJiip6J2JPlXCLMjN7cA3pY1Yjt4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JYbFM12qa0o7o/S892FQAjOmPVAL18M8wbbBNoS+Ylju+kzcD
	3evmb7D/coU8g4apKTuDRNI6Qdau84UCCgndABERLpUmC8f2GKo5i7W0ICeRJpjVY4U=
X-Gm-Gg: AYBFou2r1t5B7KW7ZVzIjuJEzAmZjiZrxQrx7FQYwbs1b6ELn8zZlecX0aMyionNINM
	XMLnfqN1RT75P/nPHu3NBVrikQinxrvzhXsw/D4G2VH4FaDJVyzOnnpR9WGfl7phwLp6afWqIER
	493BixEV94ulDVWncm4B4DjGgjJ+8WXcmWnWTIvCS6MuB8YA3uYLWOrcoQGNBW/kd/0Immersb3
	S374/CqxgL6MmPwCWzt/IGpeGD7TFQ+kqUTr3BI0btGD950D3/KPSXjJrbw1Y/GHVC6gzFb38hX
	kB0FmZp18+lc2u/7xRMujHPyh+2E92yl7wu5LoVp9StfQ8ClSbOCS3XkgqIgTI2FIwl3LZGxFD/
	Xz3YKqBfmkscvA0gT9wqyVYZxk2W0/EipVX27NjKsWggpm6jnRrnFwELL6j1IXnIhxrc7h12Ga2
	Ad2Uk++k2jnwvtYNliNrDub+lZiXB7xgaDmOzMAmhJ5XJNb7I04yuwElvRFrkfvJvZriMPWohL3
	ZHA07jn/sEfNuyC1YCdvkKbY36cT/MlvhkgoD2CncqII+puNfgtGzzlWVxzF3J+oCzxTWaT5f2Z
	qCOz6BbRnWMQOmg/Z7ReOsi0Xb8k5ejqVTF+/BP5v1b5HQ==
X-Received: by 2002:a05:620a:2b8b:b0:93f:2941:6b8d with SMTP id af79cd13be357-94421581808mr2833471185a.6.1793825281522;
        Wed, 04 Nov 2026 12:48:01 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468f69asm294179385a.1.2026.11.04.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:48:01 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:22 +0000
Subject: [PATCH net-next v4 10/15] net: skbuff: reject a negative length in
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-10-b7ffeb364f5d@toxicpanda.com>
References: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=2784;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wThWIHnCxUs0o2n1wKVOZp8MJH+DkfwjLDuEZ2TxA3k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFsB+WUd2uViaXOb0v3E8Fyx/YypTY3hkcuEnhwIIaLSj1kGnyibicHErE4iRl1Wqf0Tvo/bwuX
 fykUuqyoPQgk=
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
index b017c9f861fe..7ecf6701f68c 100644
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

