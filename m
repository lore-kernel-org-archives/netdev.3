Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E34FB9C1
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417902; cv=none; b=UR+PrVPn9Bv4YqqY1jynjQvGQT8men8DBh6l76c5+gW/IT1tBsIyYHWfwpDALJqSs2v1EbNmANsFV5oYoyG2hxpfQsnN5ebClt9PfmjVXhzEJExTOoA6d3bInO7iuNAZMOhsS1g3cX/zuYfjFula9fU42w8vsXvJEGxuIF9/EAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417902; c=relaxed/simple;
	bh=a5Mq1Y08mQBlSbHPsSgUKJSU0iN0kG1IRQ6Z8TBZzAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvkdZTqg60bTSfGo/xBqmbZwwFjW466eHVhlofpIOducTr+TfdcWnZQNzdIwcqVeN+nmY+rg1Q7q7xRavfB8yHNYyVY4im/icpElU77oDso//c1D/OgW5KuRKq0THIuY4ilcKbPBlgBF0VMiXf+Jvv//N8Ite+1dkt5ig9tPViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=D+9ZyQsD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="D+9ZyQsD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53644b28706so23297731cf.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417899; x=1793022699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBRr7gTw0LaEROSfxIaRRGeZueq1UExVdpAZr5NxHXs=;
        b=D+9ZyQsDxOFWR2rpYdzhS2wqYm3cQEPKMhwyvvmCX7a+KObvQV4UMfNwsBmVj1fixp
         MSMrJzOM+rg8bo2A/+Du6t6lZIeCXZu1FD8jU/iCIIcGz1ikuEMfX2lCi8i6oH5H28GB
         7Pk9Z6pPF66YWCaWbNjKLlHBpFS7KcxfK1BnxPn8DFvJZ6ygp46ZJSJPu7KX6uDCXNiK
         JM9pDj21WSnF9lbcOvPng41NkHsgcYgF50l3FD2dSjpnaOmytOob5Tt/E0WUTm6uDEAi
         mFUkSY6z8SDwPjGjlC/zH2jm8lPj9j1GLCVM8IN1oxKrUB3wHu7fYQMogJ8pWp5nCmU0
         IcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417899; x=1793022699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBRr7gTw0LaEROSfxIaRRGeZueq1UExVdpAZr5NxHXs=;
        b=0KU3g8jIluMjI2gCcpRum5ap0KYFRIStn1qIc42zWWTezqOUsznHjBEvwhkw0bsFMv
         em81UU52EE+XqbZKCGiYP4pr6ni76i76qhuR+9etDzhFGyg/KOj+oim5m6UmjWqebmV6
         ks/gzzuAi3u7c5P5XZR5bmMliIrcFB1Jd0sWBPZoLU5jJaeTPY4m4ksYUD0NYd2cXDzj
         a8YbYQS2p8oz/U2s7zuEz/8OOg+61CBoVwazKEOKeI5j2QK9g6QQDcf0oSk9a/HW+guO
         QmBdQfdzPPvp50aQiqlJ2reYB2Qk393PLbyHi/v+n+1okqZ+QK5H2nrxh076g7Jw7EjU
         xUyA==
X-Forwarded-Encrypted: i=1; AKwUvByvGdWSBYsfT45XZUJICRQFck1fBxsFSRgamW3XXuM0xBtARdWzR5UDhvZH5qUCKYElnp6yiC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYiM7gnsXc9wcHEyL1V0MBDwgNUiGkJi6OeZKFFAa6YaS798sM
	MleagD2Ghbe+uptXGW3n6U5wX4pm2LduYu8rH14HvKh0dHZGujpUTHFwNhajfkD2HFg=
X-Gm-Gg: AYBFou1ox3sOmDbW7co29Rhd/+VUBa4swUhVsNKW2qgbOWB5O1EQUnMrbO2dgTboX1f
	LPeeqCQcrLUbiv17cLwVx0STekQJyLvrx3zq2OOsxmwrsceGFO+Rv/+kEKktR5krGkLooVPFPE+
	I34nK9hp9D1l5oW1b/mkp6QCSEj/sH/8RJx9n86PXI/AXlvtUxAIMbbX9Ip0RT0YFDxLfW1bcWH
	rT37e75RTOWi9aUjW5EknyZ5jln3gABYhKqLGLbNufr4ZxhmVRACbM6IFya/CfLxR9YejlhG7Hu
	rrB5Pk1CalCzQG62BNALly9W9nk+UcMNbMLfG6OvMRvhGBK0cdOwR6be3iPYzLqOMZz1iuKJ8y5
	xEm1BmVLoZ/tNHb0LpL+3F8jY/aNHRt95ovENNIOcqmRI3TKx6A/rERza5QQ/19lWgb/IDNTKCq
	1Od6oxDvSqqvbj2x97YuBnej5yK17yiYp4+fDhwwhlO8LoEjc5xb4MvIQl4ELBNr1zYdOHxaTJh
	SyCrUr4VgZMU+8=
X-Received: by 2002:ac8:5e0c:0:b0:530:1b1:72be with SMTP id d75a77b69052e-53646005c93mr115881901cf.40.1792417899549;
        Mon, 19 Oct 2026 06:51:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a9dbdb5sm99695721cf.22.2026.10.19.06.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:48 +0000
Subject: [PATCH net-next 14/15] net/tls: don't BUG() on leftover length in
 __skb_nsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-14-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=1174;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=a5Mq1Y08mQBlSbHPsSgUKJSU0iN0kG1IRQ6Z8TBZzAw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAaOzcOEyDqIT7ixMNNFAojpV49DkAGaMSTgMMsV3T+Kry+T59Y4cK1hbqIN6aNryN+eDJKEsst
 k24iTK/yjrAM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__skb_nsg() counts the scatterlist entries for a range of an skb with a
copy of the __skb_to_sgvec() walk, including its BUG_ON(len) when the
skb runs out before the range does.  tls_decrypt_sg() calls it on the
same range it then passes to skb_to_sgvec(), so a bad range would BUG()
here before it got to skb_to_sgvec()'s error return.

__skb_nsg() already returns -EMSGSIZE for a frag_list nested too deep,
and tls_decrypt_sg() fails the record on any return below 1.  Return
-EINVAL for the leftover length too, with a DEBUG_NET_WARN_ON_ONCE() for
debug kernels.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/tls/tls_sw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 312e51270f29..1c578ea47a1b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -142,7 +142,10 @@ static int __skb_nsg(struct sk_buff *skb, int offset, int len,
                         start = end;
                 }
         }
-        BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
         return elt;
 }
 

-- 
2.55.0

