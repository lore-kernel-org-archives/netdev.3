Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55440DB4C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889124; cv=none; b=nm9xaUFxK2iyP/jx9/MR16qh5HuIiR+gwIeb98Hdc4BUyl9eiWTQsqNWbx09plwS9kGZGD0i0Zb6jAM3Rg3nM61KPviPRSJLbMWYm+5eT4zCm9hCgNaGXVjYNmDV1c3GTTaYL1gBghJ9tF8LcA1Sq6G9pE56dOVEnCQm1BzwdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889124; c=relaxed/simple;
	bh=7ONX4vDOeMj5oyXc0wpCu79X47WQjrqzwSNypYSUYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+PHUIFRJUSJ3r9GhqDm0vNElzSAml6b/gCLmPHphz6gFBSrRBwsDjBEJFByGD1hTnYro4FHmU+1WII9XQOWn343Xuy0egbmZGkgxv4340Tcmibs6iRNQCwVabxUDDUjYFiDiQz/VnnnUylx2MW65u2Q4iliRdBOyLjiLmcy9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnB+Jp34; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEk1okJ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnB+Jp34";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEk1okJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IntiDFOBDv3N4E6ikCGJ+h2ZJ02HJSndIefAXObsa/U=;
	b=fnB+Jp34Ksw4//wNp6T/xjxV5CTGmU8L4ioaNvZFChBW8ZI1MOedywYBGN2BYTsNJ+Qle6
	OMLA/sJZ+0rUE3JW085iu7xb0mNjTONXCc1jKv1aH0vT/R7SZVxpWQ0GCTgIxWoPOKj7vr
	c0z+JjU3HO7U/wkfvYJlGe8wjHP2Nw4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-2mLV6v_SN4eLxXgTEr-8Ag-1; Tue, 13 Oct 2026 10:58:33 +0000
X-MC-Unique: 2mLV6v_SN4eLxXgTEr-8Ag-1
X-Mimecast-MFC-AGG-ID: 2mLV6v_SN4eLxXgTEr-8Ag_1791889113
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1af80b913so2753605e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791889113; x=1792493913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IntiDFOBDv3N4E6ikCGJ+h2ZJ02HJSndIefAXObsa/U=;
        b=XEk1okJ7ZWR7En/1sCTqJPKfHZ3+mNi+xCaD7XEXWbIKxqU2Dg93OnVty78/dtHR9a
         VM6RdCtWu8v8b4d03vnYqbW+HCAauvF3//7pliWXSaOiThOH9ERuNdZ1WNYByBFhLjWw
         Rcy2Ggimpu0bkciHnetzpQgt1HUUH37atpAgcgOz8ZmzffV5lxke0aI3qdTKWt23Wh1Q
         1nbjwODnM79fCqBNYSeXJnRGKywKqk2ntrvJVVoNeasXLWFHlz/e98tHVaag6hgHHA11
         LqcW8alBRCmvNPgZ0Epv5oEadJwzvTKeXiPuQwYgJtZzZ3ApB6KzTbg+/1WAafBx8GDT
         qYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889113; x=1792493913;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IntiDFOBDv3N4E6ikCGJ+h2ZJ02HJSndIefAXObsa/U=;
        b=PntBDqX3p62wYtaT7g5m2gpL+cJwX3W0sI48vOlgQ2I4Hg5LvcA9KwqVdK/FDLOZg0
         dQS8ToLYOhR9hupw0XnAPgiRYmrhFuHskDwVVhWYBU19pzkuQBLRi2fTkfG82YFs+IXz
         lQGCjrJCCaRlLliCYLp8cBhcUBt/5g0Nh6mBUltneEy2F0wE5ZThYL1j8M2eC+NaLlaP
         WTQzOHvrDoVMLap6Ln10y6Ow7bw1mgXpT3qWBUHwMYgW4KwqijJoy3Cc9NKNHp81wGHz
         9xFKjtE8LzVGPhwcLEvD8X2oOuyXQ4Q6lpD5jkytGJUSIS96ErtBaNILEjQTY2PCzXtq
         Geag==
X-Forwarded-Encrypted: i=1; AKwUvBxVtqWBJC0nQCibhVWwGzlQEgbGpdNWZ+UFjjSp+dE+kb/CKJD1/JuyQLbN+8RDro3MykmSM0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn6FFXVWPUL+xXLR8RINARCv2k8MUM/+PIBRJgm8SIZc558EEZ
	Q/92hCaiOT/xgbgXfyNl3aHgW9f7I8yJLFcRhN6UG/Kb9vA3JLa9WwWk+NfqwrV/X+7rsREFP7i
	fVX2dgvGorjQnX8CKuJqGIUdA/EVArfeVoNq8oH7JqpZnbXG9VZPD6JtLww==
X-Gm-Gg: AYBFou0o70WbfektySDCceiGdz12OYYjwdeukf7snCryC7Fe7VT1MUm6wnspZRvfshU
	JTsp70MTfAqxCng/PihlijO1jpP9RQF6DlGc7d+ZZ1FIAmriYOUpWmB3DFdBeagfPlkRXorXMyX
	3PZmJII5+fhplRVNN+jfi5XiEoH91dp+wlYfs47JSedwyUV3LiRuLT1PWJ8zs8rQjyogBkLI3y+
	eOmKnn49NzzrUBZ0jQwtdoMUthICp773VwFUV9AK4vQm+59HyPPF9B1TPNRI+JJTV27uKFUURC2
	kTyqD5ONLHeeVoSH2sVJBEss2M49PFDaYbp5cHovegGe2RztXu04UdtC44UuT6j02vD/ug==
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247249015e9.33.1791889112593;
        Tue, 13 Oct 2026 03:58:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247248425e9.33.1791889111969;
        Tue, 13 Oct 2026 03:58:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf3e044sm344208705e9.14.2026.10.13.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:30 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net-next 1/4] net: add ip4_parse()
Message-ID: <bfd6257f8fc8a5c6cd876b8ebc498b8a4ee0be8e.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791887415.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

Multiple places in the net stack open-code the same minimal IPv4 header
validation: pull the fixed header, check version 4 and IHL >= 5 (where 5
is the fixed header size in 32-bit units) - and locate the transport
header at IHL * 4 past the network header.

Add a helper for doing that: it returns the validated header and
the transport header offset, or NULL if truncated or malformed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 include/linux/ip.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index d11c25f5030a0..98012f6d0efb5 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -56,4 +56,28 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
 {
 	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
 }
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  Only the fixed header
+ * is guaranteed linear; callers that need the options or the
+ * transport header must pull further.
+ */
+static inline struct iphdr *ip4_parse(struct sk_buff *skb,
+				      unsigned int nhoff,
+				      unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	return iph;
+}
 #endif	/* _LINUX_IP_H */
-- 
MST

