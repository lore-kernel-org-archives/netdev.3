Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815EA3F0AA4
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699702; cv=none; b=DTKEtylHzBszfhdJbUIwQw6R3EagFexNnSKivc3FFcXa1YZWLn7CHNLqZuSO/GNy7VnyM5ro8PiaSYx6acuw2hb8SAgGoy58s+1iWO0i+z85FDF2kwaBYRsCn8S5yUAxRPYNDAhmoxLO92R3kmlMVGPdfJhxL90tuC1CDw7nd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699702; c=relaxed/simple;
	bh=YSCPBbWl4roN1mtl+il3bx/ZLX4V0jvj5e6gRBXVirM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pX3omMmmcr/tZpavyk7xjlv1uD/12dthuv0kNlcJ5yBGIoiGM5LsPVhRHQohC1+XDFgD7rBzjtTXp6VbunqRA55hmgyEErzHQRUlCfPndDEpi//W3SR8fWvN8pgDkLUfY9TfKlJWEHR0rGVXbKVeQMIW5etwZ55lpANtbjQFQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5EIKSg+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5EIKSg+"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5176465a4a4so79685711cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781699699; x=1782304499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHZZLSqHFkc/ECYF16dyHEttzRgMJKqUzG20tg4x0F0=;
        b=l5EIKSg+kQGnciXADfLlWM2lCFPXARN8VbFlfCo5yuqidceLr5ECHEN685gvKcGl6e
         Xup2yooANvOYXK3cCLBcdP4Q4OHYS/PQIn1LpsPnQvbFz95sa34KHtgNHOO9v66cZLCA
         8a5I1hjagShKdVZHJnqxvhNXKIZYEJ0VcEZlpG9sylUVktUzQuqBQu6KdXjDcvoMbdPm
         UKYr6AyUB/Xy/DIOv80v/wWGWSQrOlu1s1dbzYrHW41TJylQNusuKLi2UVu08mMfH6/r
         AdvToOdht6X8a9ofO5GQFrqVOXP6iieK48Z7DgPmU2j9vZ9OJDzKw7DiQ43StxXrn5C+
         xbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699699; x=1782304499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHZZLSqHFkc/ECYF16dyHEttzRgMJKqUzG20tg4x0F0=;
        b=dlNvV/Cx93CS/9jlDeSfpXHf7jzUh1ff+IWD5t1s1NT9DIliireB7SdboR6ar0XJBS
         Omdw1J8u+rxMhYLjO8yEz1TWGLZyvqXmxpXxSGcGuCT7D0wjQMhSChQyOMTC31mGEEYk
         OsyBlN+4xZRWKJtOTdJ2iD7r4GId/qjmRi87NIg+L2wg4REOM+F7/qkWHD5fepZc0fEy
         jcjhWRiU5qOs/4wPls00YrAFoQVDhb95QMYfAm4iq0BoM8vW2SyCUlEpJE3z/vGyj572
         FBdqCoiq0PEaUf3pLqcqqiMoSSlR/gaxDABy95xt+x2BMJzCuMfYt6Ix4Jk99IQOJf7Y
         uFZA==
X-Forwarded-Encrypted: i=1; AFNElJ+tXMeHolZRMR36qj2iHmCctQK9Zk62KlrrKXVVhErWl9jPDHSGRIyLfhfEiPkxBOeSPD2F3F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhipWpkIEb+qDMqIGXPqNKdhTSbxu0J2joa+8bbWATP/GhR5Ig
	0r3wi3otkFBjb9sDOlnzJGYk825dK91vtjgAb4+oaI2vuCDCNFt+lRYn
X-Gm-Gg: Acq92OGq9AKrAukhgU3T9vOOL4ZzILuxk2tZpdFtVo3CJyinFYDI9ox+NCkpMCa0Zb2
	N2H3rf7PRoCR2ub5gd55n+NPJxrx1CWF2cC7ro75I5r/ST25Wi4npECB9sAxI0AIF51xT4yHR8j
	qnjQ8IpItWIzTU1vQR/L2T81v1ya5OcSRvfdZ0RCnoDnVseKoALYgSgKekv0fW91hcAkgzldBDh
	dqaKWzGQdfHuNs3oZADLU5sEIWWKHtHLtn1cAaubpn6Mf0A71MrkmSr97JN8aTXVrLgkH0r6tlQ
	eg/6qthSTMuEIu7iyU2+35TRe0HxFUExnuNTGi06udOXknAivcV61PVayynCdk6KkrZbif3GIlb
	nf/tkr1AHs1qWLeJ84aYfb5alVKDVP5aSc+I3DcTJ77cP3sJfy6+twm3hj7BOXPCP7h+8kYMqru
	588pWREeoIveBPz4e31DntVwv7pcHGPwm0CvJLfPPsv1Uz59rZ60g3cPDVkIEPbGcCQUFDNVAst
	kIO7YQnppDa0uoRd8Xww0hWyMolVfns
X-Received: by 2002:a05:622a:a54c:b0:517:a023:39b5 with SMTP id d75a77b69052e-519a8fa6ad8mr45491571cf.33.1781699699277;
        Wed, 17 Jun 2026 05:34:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642740sm167164481cf.7.2026.06.17.05.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:34:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] amt: don't read the IP source address from a reallocated skb header
Date: Wed, 17 Jun 2026 08:34:43 -0400
Message-ID: <20260617123443.3586930-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


amt_update_handler() caches iph = ip_hdr(skb) and then calls
pskb_may_pull(). pskb_may_pull() can reallocate the skb head: the new
head is allocated and the old one is freed. The cached iph is not
refreshed, so the following tunnel lookup reads iph->saddr from the
freed head. On an AMT relay this lookup runs for every incoming
membership update, before the update's nonce and response MAC are
validated.

The sibling handlers amt_multicast_data_handler() and
amt_membership_query_handler() re-read ip_hdr() after the pull and are
not affected; only amt_update_handler() keeps the pre-pull pointer.

Snapshot the source address before the pulls and match against the
snapshot.

The stale read was confirmed by instrumentation rather than a sanitizer:
after the head is reallocated the comparison reads from the freed old
head. KASAN does not flag it because the skb head is released through
the page-fragment free path, which is not poisoned on free.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Acked-by: Taehee Yoo <ap420073@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: per Taehee Yoo's review
    (https://lore.kernel.org/all/CAMArcTWCg4x1bxrzr+XHc_FqbzJELCMu+tE=x8Jhewgr-_A3Rw@mail.gmail.com/):
    - retag the subject as [PATCH net] (this is a bug fix);
    - drop Cc: stable -- the Fixes tag is enough for the stable backport
      process to pick it up;
    - carry Taehee Yoo's Acked-by.
    No code change from v1.
    v1: https://lore.kernel.org/all/20260614155539.3106537-1-michael.bommarito@gmail.com/

Confirmed on x86_64 by instrumenting the comparison: with the update
packet built so the first pskb_may_pull() reallocates the head (it pulls
bytes out of a page fragment with no tailroom), the read runs against
the freed old head -- the head pointer moves and the old page's refcount
is 0. Neither generic KASAN nor arm64 HW-tag KASAN reports it: page-
fragment frees are not synchronously poisoned, and under MTE the freed
page keeps a tag matching the stale pointer, so this class of stale-
header read escapes the usual fuzzing oracles. On a live relay the freed
head is also exposed to reuse by later skb allocations.

  amtdbg: cmp reads iph=...e000 (skb->head=...384380) stale_head=1 ref=0

A KUnit covering the re-read can follow separately.

 drivers/net/amt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139..af6e28d 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2455,8 +2455,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	int len, hdr_size;
+	__be32 saddr;
 
 	iph = ip_hdr(skb);
+	saddr = iph->saddr;
 
 	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2472,7 +2474,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == iph->saddr) {
+		if (tunnel->ip4 == saddr) {
 			if ((amtmu->nonce == tunnel->nonce &&
 			     amtmu->response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

