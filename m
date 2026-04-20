Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394122D8DC2
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673708; cv=none; b=RZupK2ln1WEiB4jPrnhpGHxHJ4gsMayPVt5Xflh3j7qRileb6vACpOCWGWIj2VMQj4hlDs7gXpYjmheHC8cSMwv6pVqWuANadqfiJvrLzQMjmg/KKp0ngmyxMyJzUuXRlzkEiwIM6r2s3G4ZolP9QWd5Jv/RvGR8nDrCWGyDQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673708; c=relaxed/simple;
	bh=Cvvjm0yH7SEWdSbA/V4V21FYKnwO3nANSdaN7O63PD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iV4zNIdqXn0Z5/pwTHoIlNfQ2MNXLCJWHn//CVigO/Y7+lb5vJAY1yIGp12KjG+X31Pysi/ETQeTPQg0DBAKq7PaQJPXRakWZiB1QEc6rVTemEVAZEdiKV3k6hC3W36L0yr9hV+WirjGITuzH9ouOFtwotGny9OYolMTAeCFedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0+d9Vh6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0+d9Vh6"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76b6abdb73so1798707a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673707; x=1777278507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSM0BVOFkueVMpsmzi5JOfyOZXvNk2/s23CDbm7ov/4=;
        b=h0+d9Vh6Hj0dxSbU5/dR/pKKnvrdbsfC5wON9tRH8NnWXmlvB8FG2pYmd/58YuINDz
         dNatXwisPKxfSmL6O+RhWpODFqrrGZ4Kp9pvvbHPcxgAXEcquzvhM7BRdfzeDuJKDKqj
         h+DtqCBFX5pT/b4E2S3yuB6IKddWIccUA24xmo8EwDP7Z1xXPwRjpf/ONe/ngNmXiT3u
         xwWNLgMeijegbIUdzTQTQWyvQJXeu0zypHutGFdMSs9T2w8Gco/tQAKWm77tNB9YL5p0
         f1v4P/SPiBAG6HksbZ2gSxpIv/413F7T06lNfYQ1Z/owQeDuLSn2mUrWx4rvZaz4/gn/
         yt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673707; x=1777278507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSM0BVOFkueVMpsmzi5JOfyOZXvNk2/s23CDbm7ov/4=;
        b=HQQkKpQJ1ghA1CD3DkSntSRB55ivUcw8VRZWJ8SRnKDZpu9ax9z9I6R9WaJYUMpUV7
         G9yBC6x5YJVxOpE7mu0p4Q5q79FtLlU+v7z5D7xeO0aO0EIG16SIMZgU1BelgUzKSSzz
         yxYPMr3BzIY7OebuSuD47yKkOB9M5R9OTMFr2xbe9QI1GB4cd1API6suVTXynt7VXi+W
         q/kE+NX81ae4ixhu606qbwJBbfDmmaXuqIFVoccR+izrG8UPjL66DLxSjPfYVDwrsctt
         woOylSA74q8ZKHswuaedyywB1sgAf6iLvjCePaDIsb+tlslLXn99mouNrudYJTE/iI44
         CNZA==
X-Forwarded-Encrypted: i=1; AFNElJ96KxJ30W7pgTyZKqoux1RkWK7KXDGSG2sQMEL3zlcDEPLXfSau3nKP/MSXVvzGHBrL3jDicg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGlgjroj8Q6aZKtanJog72S9hgq0zNDCsCGELCBOkutTc4PQsv
	SSPGSpKj6m9AhQmRg8B3ZLWm6Pxa1UszCZZwCFUQl4iLVh+c34Lw+k0I
X-Gm-Gg: AeBDievhHo2Rm4LwhXAu1Q6TrcvmcZkyUCx5Rg7F9XC7b1PLwr9/mGVDo3VBxQsalQV
	mQR17FpFlW2g/9Ri+obvsy2TD9CmUo4AGAfP5y8JTNAwXCyXXOrUnz5+47tyYlNoJORi6yZbM3+
	ewCl7deQoJGQWd7AaPu2ZPdb2zaPZI/3FKVv3wkilXUcZ+KwkTB6sFrsyVaj6Uzt1lgFDIhsOhq
	56ryM5zBvtrGx9W7XKgo6X7gN55G36gmDk6QJThnnF6/E6+/lVHxYvgbV7gqTyIFqFd4Y2ZsZ9t
	yDD2fz/AT/ri5VsLNLegACCHEkd5r3YeRLvK62xGMaf9njW0bLXVyxevTohsulGPMjpop3tyyvJ
	WAfBaeIIlhDyScxLyJGzklZLZKqOSwf2zYqgmGDhLqNO/uRB99D0HCUCVW8/ctwJG+LyFv8GWwy
	R7rHI1WCBvD82mhEuMRcncpuYMq6RDil+BHFQhD+OtR9sJYS6WvTN1dFArPaYOFeoNBACi/1Tf/
	NApbJKd
X-Received: by 2002:a05:6a20:432a:b0:39f:a42:9251 with SMTP id adf61e73a8af0-3a08d76d8e6mr13761570637.22.1776673706562;
        Mon, 20 Apr 2026 01:28:26 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:25 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 2/8] xsk: handle NULL dereference of the skb without frags issue
Date: Mon, 20 Apr 2026 16:27:59 +0800
Message-Id: <20260420082805.14844-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
EOVERFLOW handler unconditionally dereferences xs->skb via
xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
pointer dereference.

In this series, the skb is already freed by kfree_skb() inside
xsk_build_skb_zerocopy for the first-descriptor case, so we only need
to do the bookkeeping: cancel the one reserved CQ slot and account for
the single invalid descriptor.

Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
xs->skb check (for the continuation case), and add an else branch
for the first-descriptor case that manually cancels the CQ slot and
increments invalid_descs by one.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..6521604f8d42 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -893,9 +893,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
-		xsk_drop_skb(xs->skb);
+		if (xs->skb) {
+			/* Drop the packet */
+			xsk_inc_num_desc(xs->skb);
+			xsk_drop_skb(xs->skb);
+		} else {
+			xsk_cq_cancel_locked(xs->pool, 1);
+			xs->tx->invalid_descs++;
+		}
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-- 
2.41.3

