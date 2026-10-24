Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879476;
	b=DOEfr6ef6iak7Gn6BIzkcMBXFiHdKTogSiNnUrZBekZGnjXcKbXwxtHU9f6ZkLvQpB7k
	 4VBEudQUGv6iL+RgKl2WN92nQmegOmXKoyIYzQN3S48SW0/qwpiSFysMe1kfgWHSWXc6X
	 D7qWampX8Gn6rdunB9nBEKOUqHJM83jZ6tXBJfXHWNAGklrcT1SkX7HgvLM0pC6dAjqGC
	 SzyJX5uDTmi3OpIoq3FpNpqnzK9uAYo0do5QGydBjyH9IY58KhcczrRvoXyZe9hPtLfMi
	 531S47PK0r7Vrc197Vuys5fQV8WvwcBfWxVJqtIWKimSnl8wPUiHZq5dkP6uqZ7O8Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hHtZ/a9O0SltqM8PiDX8PaUv7RpZyX8CwA6SIrBRmdo=;
	b=QswSf/raENX4fpD8wsgXg/FRwqJEcQaY+Q34GhxfWwUTCqqV10xbNz0+9gAlLenVYzXh
	 jrRL4v87esh0/NTgYxn8r6g2B6V9ZyYUoxA1O18n6IMpR+vx2pjTMasSbXlb2kiZ0uLJQ
	 WoHWcKnT4WJuXUQuBw+0jsyrvRSCij1jZ9Hw2mzT1F7Fzn+u4YyQzfICHm8NPaWrrB7HN
	 KaeJj2gPmJCVKyxs62wFDMtDtXZUowxpgK6D6KfxqOTfGB5Sl67lDjKbXpQ7JCpgVVboJ
	 FxMZWrh+Z+dBaJwCVY0Ha+H3uiGqpLeU+exGYWNs2kHwXe3SKIcXRTEhY8LOaX/N03A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX3pI8ze;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F8606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 22:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX3pI8ze
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc81984fceso559233137.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879475; x=1793484275; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hHtZ/a9O0SltqM8PiDX8PaUv7RpZyX8CwA6SIrBRmdo=;
        b=AX3pI8zey3LHSIUBTOLj/bayKWdBhrcacs8xqYDR/8q0fMK5lajH+2IXNfErO44yVE
         +Xa08g+SMFrYhq1PKA7KkEFhDHO9QCR18i2fcK/vOlBDtqyaDeaNxnjavaQgAN2q1CMH
         /TAMii9WeqxRXKDsV4gkzGAa2v7lDXmsqV//k64l6ylWtlmdy9iPsTxMoOxO9vLjOOkO
         QccnkwilMEcwjiXFxrXJ1kzrjF+Si5sNowYavmnQ/hHq6GqmXt78TtchwEhkSiv9EvPU
         u7i+RoT7VuPfYZzsiqmmlW5MSlk4dclmJgH8/dVilX1T4iPG0aVvzfWswrj30SdBe+MF
         zwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879475; x=1793484275;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hHtZ/a9O0SltqM8PiDX8PaUv7RpZyX8CwA6SIrBRmdo=;
        b=b9oqi/6mmZEIAey+dBLDMTBveL62J/m0LRksQOzH8BovaCkLHU2hfroJhaoj5612h2
         BqCGAWF1QUiVEJ4p3yECG41uzp43WoSy+EXP1rhs6xJC1GsIAo0H/RWd26QGGDKI7+ZU
         3JNpNt2MKeBOKNTP5IT4B6er81UU1IQaeWufJfNBvn35HLrgz37QJ3g2/Fo9dOhQSL7l
         6O9yvbYGKZ3jgTUKxB17wdbRTPaE8G8gxiUeR2622TvHVK2YOai/p1F+XYxyoA3lr3Fz
         oyBbMFoWdvwd+Ef7Wc2TX5AZKlCUXKpNpjS9c+EJi3pEr4lhE5nhOxLMU8CWOsxMKx3b
         mqIw==
X-Forwarded-Encrypted: i=1; AKwUvBwZkE5in6LWVaIM9CwTfGwYafZ0lMhxc8VqBdgj0Zmx6SY2qlifbSYkI8sjjyvU9qCJDBIqBvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY9Teqdgkue/zKWDABaJ8O9sPIA2A6vvHC6hGwf/gNZVPxf6rm
	pd/esBoLC7973ZUkAICoj56+Py+RwkoeIwZ4bbWHNDabIPOX+B+RN7zGWtMtg3YR7zQt2g==
X-Gm-Gg: AYBFou121wXR3rk7U6wErIBqRETRRLzKHZnNfruNVK79ZMoz6skuknYHS7SwCoIU2zx
	etq6vd5K+ZkTd4PGMfI2nX35YoR8+RZBXOavdib8kVIqsZr/7o+ivjqDWdn7augYFGy/k7UDD4f
	Zbe1rX6udlb87UZzMT7Te2nrJZ85Y9QB0hxyOQhQvn0HwyVz1zEKhhUabFUH6k18i2S1E17kDUe
	fJ8jX7bCCmO2HdUR5582V+JlE1/itGMgaLXaQQh8k6Xf150f1a6s4A4/dIGhuOPLdfEIsQfB9Dp
	AmGY75Jf88RarAgXtsCa+EVlip0U78i1ehn7UuQ6W4McaCkRhjdauKgDNY+vaHQY1eT00QL4K1A
	9GBdUAGHfI4ak4BI3r9G5wlgXGKfhoxxNzwXxUSaTQIB1hQU0UU5RhgNZeFruqZrD1kbBkwo5uz
	92rFx8XzlX3eT6513rpl7vUc+YJUWSHZmqo7Rsn7RtoWOEcbp69i5D5fTlAAi5a/Nk97Hxj4emm
	vclujGxCz1K0wGqWfbePC8HPpVmA8XH/EWlhhhkPCPj7RfbyWaK3UFVb7OvXcqP29JD37/JtL7V
	/TaVMKnbh+WvTvL9MKXsQcJDKvobl9HOiJhvY0kyFG9eWTyzLSA=
X-Received: by 2002:a05:6102:955:b0:7c3:2b19:6266 with SMTP id ada2fe7eead31-7ce5cde704cmr628194137.22.1792879474958;
        Sat, 24 Oct 2026 15:04:34 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2804:7f0:b101:277b:c08d:c9f9:7c08:79c4])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7b7069sm3604395241.3.2026.10.24.15.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:04:34 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH net] net: mctp: free reassembly head skb when key_add fails on SOM
Date: Sat, 24 Oct 2026 19:04:28 -0300
Message-ID: <179287946888.17431.11219154409333681184@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

When a start-of-message fragment creates a new reassembly key on the
broadcast/bind path, mctp_frag_queue() stores the skb as
key->reasm_head before the key is made observable with mctp_key_add().

If mctp_key_add() fails (a race with another SOM packet for the same
source/dest/tag, or the receiving socket going away), the error path
only drops the key reference via mctp_key_unref().  The final key
destructor frees the key itself but not key->reasm_head, and since the
key was never added to any list, neither the expiry worker nor socket
teardown can reach it to release the queued fragment.  The skb is
leaked.

Free key->reasm_head on the key_add failure path before releasing the
key.  Other teardown paths (__mctp_key_done_in(), EOM delivery) already
clear reasm_head before the final unref, so this only affects the
failure path.

Fixes: 4a992bbd3650 ("mctp: Implement message fragmentation & reassembly")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Found by code review.  The reassembly/key lifetime was traced in
net/mctp/route.c: mctp_key_unref()'s destructor frees the key but not
key->reasm_head, and only __mctp_key_done_in() and the EOM delivery
path clear reasm_head, neither of which runs on the mctp_key_add()
failure path.  Not yet build- or runtime-tested (build environment
temporarily unavailable); the change is a one-line kfree_skb() on an
error path.

 net/mctp/route.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index e7c95eeac..3d79c2031 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -552,8 +552,16 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 			 * can do is drop.
 			 */
 			rc = mctp_key_add(key, msk);
-			if (!rc)
+			if (!rc) {
 				trace_mctp_key_acquire(key);
+			} else {
+				/* key_add failed: the key is not observable by
+				 * any cleanup path, so free the fragment we
+				 * just queued on it to avoid leaking the skb.
+				 */
+				kfree_skb(key->reasm_head);
+				key->reasm_head = NULL;
+			}
 
 			/* we don't need to release key->lock on exit, so
 			 * clean up here and suppress the unlock via
