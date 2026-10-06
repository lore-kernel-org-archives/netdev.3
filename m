Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50D4A8FD7
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306660; cv=none; b=W67IT6C/qYBHB4HBTtQWeZp77XZl+sK9T+xmCJc0m1I8d3D8DVmdDXDhWo5+jr4PjS1IFnnhpg6yijitxRVbKkHT9jYpnSDH22shgWU7hiDx//nsGe6r0ahMDvUKhFnm6ZuYRWBj+b7kyzj/uaLQSONpYuwJFIhzePELSzO3fN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306660; c=relaxed/simple;
	bh=xX7ZA4Pt/yD9efhp5Id7SFCUZe9AdU5ywHlMrl9VEGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZUY+/41tXB3dHoDh4F30avEWaaXRYymgWXdFzeqVaHb/Y5D1Jq3d3M8CAZ0fdy30dz6wRPVurEhf7UL43M6yXj9d7OaqI0GpSkRo2pJgCz7YR/CKkravuHIXObfbmgh2NiLwj5n3cq4bgY1by09BHHzlae9TkmoLWw1+e/Abik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=P1b3C3de; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="P1b3C3de"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533973605a2so10244911cf.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306658; x=1791911458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bnn5ZUBxpD3vBwQoOI4ac0trMLAbv9PIx4bA2k8/Jlo=;
        b=P1b3C3deQo+i7RzWPVuOYb0ZnlJajbQvB5oOO4+Uix++4JqpM+DNBvNP15p1Tgm4+a
         ZEby5OqBp1rkdWBzQG9AeEODBLPxlpP+8qXFFZAW7ImzB2NOx1RrO5mddvCQ69Q3eGZT
         NMjG5lbB9DPWYLhUkXHtK6yMhMW5YPuNE7UiNLMGqk1XnjqSViSOti2GMWS9PjPyx+wh
         Y/inPOkN+XAFUjU1tul0ocmsbX4G4hoYjgMa4Cwa1PezgdZ/Fo0J7QiphGe/Be0MgeiW
         9sdMQSBsBqR0Md7UtvdXYhppKJl1MSVvfcWDa8QDb3DElG8X/0hpsFr7xurdpk6RRuDG
         rqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306658; x=1791911458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bnn5ZUBxpD3vBwQoOI4ac0trMLAbv9PIx4bA2k8/Jlo=;
        b=DbuA0EaHIwcFHBo80D06cFsfVkigdJj0ASI8J54ycaivCHx6JSGk3buwpgRO7C/Ppe
         yWuN61iMGuq0O57A0J3LcEAMolwEnjGsRhfIIKMNjDL/7RuaYDohZLVuMG/sEshIa4gS
         eam6Ua8XskZs4PYoOiPJp01KOlXiRHm46gTIHl9fyq6QjhMmKFpxQg2xUNQ8ZWET/duI
         GbIGrizmonQxI9J3xRrnEiMjUmt0iMW4k8DO9UnQ/Z/PDJeGt9rhTh3UUEWdy53CzPgg
         YhzQCjdaoUX2mMs6uGS8Xjt80wQDfzF7LkNhR1KgPYiRdDcMoYJvItg4VKHdAEbcuKP7
         W75Q==
X-Gm-Message-State: AFuF++k8pBo+IxXVDvEqlKrAPQE/CVBtWKE720igesTv1z0FvbIzeZHy
	OArH8c5rivQsX+LsePye+xbgwIruP64vr+zYhRjxyrdCcMyHLqZRUV43fcFfxW7Iysg=
X-Gm-Gg: AYBFou3MD2zOQH3/5yxXRzAXeFn1Cyzo9u3pPKmk4pxs87Yl4POAqmbbvdIfckOOOpl
	eZbGv/3LSFgbJ3CRksDBfSTiEgAOESaxCIrsEOTCVsUIiMN8AZHsaNdVy4cRDBKcr9dNVQERSe9
	Bj/Z/7/ZGadH+3QtkXFIxSkxsp37scXsJ82rXO9iUEzBQA/RbEF5E6X2UkA8o9zVrik8Bv8WvhK
	ATiQaywVwxHFknb8K52H8raD5rErJGSJevVL8w/JuF1y6+V68uIRafbTUyEWgqDtYenDYSE9KAt
	6EWfObPznwdJhX1in2fO7KdVhgqYykEGcMEkM+lhLqQ8lYfXkxmRDiSRune2A9d5HkLlc3wPTOq
	z1uD/giXDAvNcwXSVT1VgJADn6FeNBtBNV5dYTEmQq5FO8wbDtjCKeFXfULCWLHQ9wS8yjtKxDK
	PBJBVWXRFPt3fWlkoqy0y/7e8Q4nBcUxZmDvpX7q3o7ckoqUVaMIKz9PwN+NCor0mWxaQnQz5gi
	Ombb1rkRvG9QN4=
X-Received: by 2002:a05:622a:580c:b0:535:e8e:9b5a with SMTP id d75a77b69052e-535668c62fcmr37467101cf.18.1791306653658;
        Tue, 06 Oct 2026 10:10:53 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53572202defsm223901cf.31.2026.10.06.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:23 +0000
Subject: [PATCH net-next 8/9] net: skbuff: don't BUG() on a missing
 head_frag in skb_zerocopy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-8-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306634; l=973;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=xX7ZA4Pt/yD9efhp5Id7SFCUZe9AdU5ywHlMrl9VEGo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKn7ZRhDKzsGjGka0wq78eLdjqGiG/lGiR6y0qXeniw6WxfcrOu9kyKr1Pa5yVyVb6T6Pafp3f3
 AfiMDSGOYlwk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_zerocopy() BUG()s if @from has no head_frag and the caller passed
hlen == 0, meaning the caller didn't ask for the head to be copied and
the head can't be referenced as a page either.  The check runs before
anything is touched, and skb_zerocopy() already documents -EFAULT for
bad skb geometry.  Warn once and return that.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e29eda2eaf3f..8c6a45a20eb0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3906,7 +3906,8 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	struct page *page;
 	unsigned int offset;
 
-	BUG_ON(!from->head_frag && !hlen);
+	if (WARN_ON_ONCE(!from->head_frag && !hlen))
+		return -EFAULT;
 
 	/* dont bother with small payloads */
 	if (len <= skb_tailroom(to))

-- 
2.55.0

