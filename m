Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFD3932F9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759368; cv=none; b=oy8g43PjdJneUePYgpYl/VxRUSriZ9EpWIonqyRm8e0tot+XD7BCLKqdrZZmuPqy+QQbhUg1/xP6RKi8wLaUs38rd9KeR9jBw6LMbFk+d/wi7JLPondfFEPr+CQt2+usuQlF1mvb3AE4wCeBWQJuRBP2uaekh9QT31NPMrf20rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759368; c=relaxed/simple;
	bh=eGJP5JpZ7NVynKsatncjx+ngzI7UgZglI/sW87qWUfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKeuRj34zItNi9MXBl51WVO531ojB0ExK8vG0s7ZQcQFBfhPoGe9fDtADPoVRzj/0GgaLrPn0U29vD9yX2jzYnhdT7THD0d3FJo734zUCST4yt+nV24JkZeMkHBo9iVvptTcPjPNa9a1qG7DoVS9z8o6+Z+x014ief3lsPPOU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=I77Pdct3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="I77Pdct3"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52b6543169fso7996311cf.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785759363; x=1786364163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GkOKniZRC1idBdL8qT7wVf89hPYa4Ml27SMbxT6diJc=;
        b=I77Pdct3f4tQxu56Y/eY5BIuQKuNzGEL5CH1Ue//hEXgY9fpFRzFPNCd/HjDuMtbTt
         L4ugulpFm//iDU+ixP6HLQ2I5qPWGeZcex6AlLF22ZZNIXIk9jVAlDIaNsp6r+qqdLK1
         nBk+h93shiGk2Jst1/p1HWB2TfGn4xomWyFvblaAwjP52UNmEscsnFN7sujEU17DPAL/
         0/VNcwtFTJTprCJOMc8lpIPwXUO0hs1bcQ8VjZi3QsqiRYrfyGPI8JuvsSyJDeQEkae1
         0BqrhMibSs4HMUjwQGi7lsJxpzLXlNej81Ztk0hJgM2+3uNxNULfe+lnuK7yUswJuaQa
         w5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759363; x=1786364163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GkOKniZRC1idBdL8qT7wVf89hPYa4Ml27SMbxT6diJc=;
        b=j7NqKYZwNWaR+NksgM0eH4ibuONp3BDnxAu5IiWocB3/UqCfxPNF7nLnPU9b/uyQCs
         1Z7RAv7rIvvELc+SFYA2pmQOfL5wFZ1ogd7I/Kh+HsV1sGnr6nfT+cCgS2SBTvbcb07r
         B4NbNGpwLN25H4WIn6ElhKcXm5ESW+6XMoId5M0SfMq0Ag/izTpJhvgFBjBF8t/Llazb
         YwiA1MuGJPH4fZnvCJ0X0ydqMSg/3ihFHYqeoKDUoqtMRuMg0NutW7CoKMs+cKgsMYrb
         yPNX4Jax63+bt/XAtldaAxZ2hN2AdUyIcoBeVgFoSBPK7RhTbAYJ3IFirtzLqK8EwWhr
         pDhQ==
X-Gm-Message-State: AOJu0Yy6xJlr4W/9W384Hvw+vIz8rKngB6h44FL+pkmSbyLWkNibBVi+
	CyTUxDBpkr6R59iq4bJlP8spQN6oRMH0j/lJX4FQPDcw8RG3NzaUeZPNB2yzMkM0XIBolp9s4lz
	MSejlP69nWBvfgQ==
X-Gm-Gg: AR+sD11dCUEzyYaKOYJmuOVXwK0uoUPkd4mmbXCH4RMWfwl7cQi/iahJEhnXYOLC8Hy
	TQbbzjUzX9IQMkLRHhgFbe5PiVaMxz2vopCmcQVr7x4cPE1ykC7Rcn1AZkkWGmXo1RRTzFeOoVl
	CQ6imRT+K0yeNmjD+CFg9kTBIgJKOB5JGtwtWT0s5sKVFVwVkiqedg9EMKfjG3f3SeW/Qv3qHRm
	xTFsJcYhRpy7pZ0H4wchZZFkOWD3IaDgR6K82SF5mEwxNIXVZKncrdvLEyjRyDqDyQTgnv1Dr4R
	Eto9CwrQ3uGPWJvwrAIbk5gxf+qovBVv4YXUI/FxjEdhj2ARz04CsLmsbMIRu4+XZRPm2IH+iPV
	hgoNY2Q4uoQ9GK4ospd9NM5A2LkGzsBZoXnHsQf9lC8tCUICUyh2nyi0OR18v68t6YCbwRXoReg
	liz27GYOIom8LtRA9FgSb8htosd3JtQn65phGv/tL9mC+LVTQvR91V0iizm45FlsUGzAm+Bu7rF
	K1wLXHQOi5Ogdo=
X-Received: by 2002:a05:622a:1e0e:b0:528:3c2c:5c72 with SMTP id d75a77b69052e-52b5679527amr193003071cf.32.1785759362991;
        Mon, 03 Aug 2026 05:16:02 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e7ee1b7sm59323971cf.5.2026.08.03.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:16:02 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	liuhangbin@gmail.com,
	kafai@fb.com,
	toke@redhat.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] xdp: reject clones that overrun skb_shared_info tailroom
Date: Mon,  3 Aug 2026 20:15:32 +0800
Message-ID: <6b2afef5d1738763c6965e8e466eb16e43e4f956.1785757386.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785757386.git.zhilinz@nebusec.ai>
References: <cover.1785757386.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdpf_clone() clones broadcast copies into a single page and sets
frame_sz to PAGE_SIZE. __xdp_build_skb_from_frame() later treats that
page like a normal XDP frame and expects the usual skb_shared_info
tailroom at the end of the buffer.

The current check only rejects frames whose linear xdp_frame header,
headroom, and packet data exceed PAGE_SIZE. A source frame backed by a
larger allocation can still satisfy that check while extending into the
clone's required shared-info area. When such a clone is converted back
into an skb, build_skb_around() places skb_shared_info over live packet
bytes and later writes can corrupt XDP return metadata.

Reject clones unless their linear area fits inside
SKB_WITH_OVERHEAD(PAGE_SIZE), matching the tailroom requirement already
enforced by the XDP-to-skb conversion path.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..0194e69da339a 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -871,7 +871,7 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
 	headroom = xdpf->headroom + sizeof(*xdpf);
 	totalsize = headroom + xdpf->len;
 
-	if (unlikely(totalsize > PAGE_SIZE))
+	if (unlikely(totalsize > SKB_WITH_OVERHEAD(PAGE_SIZE)))
 		return NULL;
 	page = dev_alloc_page();
 	if (!page)
-- 
2.43.0

