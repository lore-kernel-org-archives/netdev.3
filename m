Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FA4FC32F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417903; cv=none; b=AICYKCw4NEAEjQz0WDDWSgPfuJ4ZXQXKrbvJJcjgcfS8ItBJAOlNctTYZ26vuJ7P7ksg3Q+iRdttxMyiPCgu6cCundz3cntzzyQx967D/TKawOc5CY4uuxzMUDoKcVUvh1Oo7Q25Bg+760g8Qpp2EWLKhYRLOvajDYycZHvGI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417903; c=relaxed/simple;
	bh=9EvzAU9EO5dyvCGQMaA1nd2saqGuALWIDCXk9Xn6dMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrBIyx//lRQv4Io+asmiOQYvANJR2+O2Ljz9zg8oeFPdgv+HGtAZU7bJwTph+Csz+JxbHnPOIkTRpfstDl02CF9XsgzncyqD4i7YH2bZ7/cvvpoLRPLjIMsqlz+Um8nESPHlxlnAzOzxAu/t9yr0kBWdbDGo7OJXNOmGKqf9WQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HXYKWFtU; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HXYKWFtU"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5366ae57896so9671241cf.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417900; x=1793022700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2su03NSLDI+QURR7+Op6WIlpfTiC3EObk5mJFR1rWs=;
        b=HXYKWFtUxjpff9h5xKl5lq1Rj1z25XYNDICxOc21tpTKNvC1GV3HCUbSCsSqdP/NXL
         3NRZgow/046lwF5/vdRAvXT4A7Q26mDUdA/Td+qbWFWvvgpoXD/zml8tEtzgG+1zPpzZ
         XHd7FgMiqmZp6FeazgD2Y/3lGfr9GAY3aP0Ba7+cbRsKdFro7TYhSiqrGxSfyjPnRFVE
         KWP5e3kdgNdKcbc6ccZkCzYcph3okZl4n149l4yYf9LP9TwYNK5C99tiUqcKNr+d8xup
         4mhdUVKL6m6AYuxmilOEuI8k1SDKlvI+2DX9nNIOU4RrvN8sn9w562flPE4I2jJ0P3Lh
         aFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417900; x=1793022700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l2su03NSLDI+QURR7+Op6WIlpfTiC3EObk5mJFR1rWs=;
        b=V6j1nXl+IakulvSJVSLKaZzlGZcfOjSrLC78T57isJT2F6vjvtdNFtdegF+2fHZ5hb
         Md22TkUNRJ55v/ULGEoP7WSSGUj1b/kOnV/jovAF7IAhnKpjWUQaEFa6EyYSf2YGiaNC
         iUtTNfJ3BWAr2+QBJHSVW04X74DC1Hz8Y8OlLrmAucwLzD8ulhL1T1yf3jhNz1Ic7lsa
         UrvGz0jvz5awSz/NE4IfwWWqYqabKzsTsFUSqFANxnKIuFN+Gne+jejxr3EhUMgiblPM
         fF5sEf8JsW3MEUK4QHYHn246ECL7aWV5whrWcPIqAWJnDUdmoIYlAu8WHGDRQJVjyymQ
         5cSQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4lazngcM9+h7fyGkAmuwNyvr3C2wsrZgviPx9lMzGIwfI7EQR/Z/I5vXaRtSxuNsoTPb5E7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIraaBJrOqNVDDw5jvZTtygRX/7TSk8bv4WOiaTHXtpPmr4M9ow
	H8qc0CV/onjmTta5cOZohE3u0Zbat8huB/RCt4rce/MIAYvQKkiM4SdLH9dYu3/3H6E=
X-Gm-Gg: AYBFou1nTXOA4nq6bQRTK6zJpFA4JpC5ivBH2KWlKjdyUNMWcXMtvYZzmA+dlYW+O34
	qFC72u1dH8vpPc5KI8npSOvZcJTJorZWxiFcf+qefnehKPEV1B/AKPt+eZUzJGUTBYnc/k8ciQT
	N+XNgmYEunrywUdgAH6YJ50l2aTcJhOyFUL5cgswdyWP31RptoRbaTe2kpRzRsp3FVnn2KY9jCR
	2S4lngEK597j6V8qrgOelbLbDnG+J3FVVN5KMgmTQBHxKRPSEHAku64+XaXE4t2cXJZaJ44XoJw
	g2q2t1+mYS/TsMfVpWiwBHMHM0JsvQdCQ8OWyxwrDpwrbgtDh7UzeAOOCZxxx/z6dg4rseAtCTc
	UYWnXZndrq77nqRq4AGpmp3UjOO15C73xIG0kiP9ARikgMOuCOYJKoIzteWvzlutOgvt/4bu4lb
	9WT4NPrDLzI1iDKK4i9HqK8z6YtgPv6xPObHcVGCraeXPZ9Szu0KBLe5erFHNY/YiCYnFa3EUnU
	/heXXNLKrmz8RQ=
X-Received: by 2002:a05:622a:1b87:b0:536:702c:f8ea with SMTP id d75a77b69052e-536702cfb33mr37062611cf.47.1792417897687;
        Mon, 19 Oct 2026 06:51:37 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5363455e7d2sm89038411cf.13.2026.10.19.06.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:47 +0000
Subject: [PATCH net-next 13/15] xen-netfront: don't BUG() when
 skb_copy_bits() fails in bounce_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-13-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=1219;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=9EvzAU9EO5dyvCGQMaA1nd2saqGuALWIDCXk9Xn6dMo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMKSzC4sHZmaSUvthhUD2jAMmS0Nr86UIBJrUbV6zvlVJH8olJ0s62bKQw5Ehhrzn/DanWtOPAh
 Q6nevl7Ie1gM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

bounce_skb() is an open-coded skb_copy() for skbs whose data isn't
page-aligned, and it has the same BUG_ON(skb_copy_bits()).
skb_copy_bits() only fails when the skb's lengths don't add up.

bounce_skb() already frees the new skb and returns NULL when the
allocation comes back misaligned, and xennet_start_xmit() drops the
packet in that case.  Take the same path, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/xen-netfront.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index fdcb91042f29..17811d81937c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -695,7 +695,12 @@ static struct sk_buff *bounce_skb(const struct sk_buff *skb)
 	/* Set the tail pointer and length */
 	skb_put(n, skb->len);
 
-	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
+	if (unlikely(skb_copy_bits(skb, -headerlen, n->head,
+				   headerlen + skb->len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		kfree_skb(n);
+		return NULL;
+	}
 
 	skb_copy_header(n, skb);
 	return n;

-- 
2.55.0

