Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231651CF70
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902054; cv=none; b=unn7nAMd7CEtDaBeSEHMEyX7NZTBzknFIxoOZBOXFN9UTpq1X+RuyQ+1JkK1JpqXa2ckcMWl0Wk2EaNUj4bO+Le3M/v6IGdcGzESy7DuG2rEV59kQpoz8Oy2nN7ud+Fr612WrLtuYurj9i2pd0WwMaEshD2tA+1YC7qwD3PosEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902054; c=relaxed/simple;
	bh=z99O4HmgmdYR+7saknpwmYeWtDYokGLztLTFcJ1I+TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1ReDfIf+MSCPKIh9rKriSV4YlpcGwfterQixfVs9FM3Gowr6B9ICcs9mTctaak6f+6hLWiAYVWIj2TGHb6lMwYSBvwkiyEPq1WwNH1modfxOcA/NCwzA0GOUO1pgFlGI1tBmadWizHF3j72rhl0RK7zI+W1DXp4RMQ0AtQ5qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=b4+Zk0Kw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="b4+Zk0Kw"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so1623307a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791902052; x=1792506852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5WjU0JGGlgVKfK+60iRgslLLmmGxRIYdZTRLsbWhbc=;
        b=b4+Zk0KwPkKrigAh6dW8FmKPwZ6HV1c/Wf6Fu5mMEBWo/dxROSfJIJgHnoS/NKh2wm
         oLT7XBOkzhyamfBL0Tt1K7cVCwvBpW03+JvjtIy720zNVXQ6PbbmO7QrPEYKvITAxFy+
         J1LtRukyHHqDBayljSi/ZDyMtl3PX7habJ4T0103uz4FrQaPYaNgQt7ersnuJcGdQmrx
         TvHZzRhU8QXvRQlacw3aur2lqB31OzVixtmONYMUgyneZi13otDKGwn0xyg6MO7CQSsf
         vRMnUNlGok/4rYbHFM912xDk13WE/cgTe1AwUfpOuk+v7gys98OUCGx6AEjZpj/ahYRR
         vSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902052; x=1792506852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5WjU0JGGlgVKfK+60iRgslLLmmGxRIYdZTRLsbWhbc=;
        b=XCkxjauJUQ8j4APoTjBDUX/BfyvKnYVsn/U0shGozuaVuVIUrbR8NL6czqwuFdl8UY
         SKfxWdBLAxJjpj+WAH/Fb98Cdu5amLe3aBhBFsR+TE2k2JOWqZunn4wPAC835nwXvdJN
         0QnpXhwxAhFsIG7epYbJvXZMRyQY6Jfe5cXmf3lA11ddjcOrO61Qpu57LWMoSle67vI8
         deNaLheW7KfwA0HptUAaOEa7uOQQQz6SKy3xJp3fr1mtMWJ2UE47yqa+s4NZYEnda3oe
         eMt45E0b7cblI8L7nlARCwZAnEZLe64Uloi2WHpmU/Eeiv/BSxqk6afYex897ArtptoL
         lGLg==
X-Gm-Message-State: AFq9FYLuTXCXGhJcLru4N5yVuNiJxp4WrcAm+2FhCmj1KNPMxsnnxupB
	kOx12Rc4WwsTKZspopiyNSaaXmN9iJyzWxBfLOu4MI50x+mGz6VoKYFXcHvJJrRN1lrlXOMlKFU
	QP/PIGe+JIt0=
X-Gm-Gg: AYBFou3TQ5JE9IfZuh1ZqzHdMmn18hzu/HWaR4D42Aneipt8al0Q2c90k1cbJfJDQ2t
	vyUBrY0XcCFtXvaavtTx7xU5478oi3SaExSUf4kO0EXg+zFq0+22ByW+mubDtihw26SZ3XEg/bQ
	zbt896/ErMJTN0jWsCXV3LWtJzFpL9AuSzvMEIPS5tEYSSsmmEWWDzethAz+1poZJ07zN5l88Qt
	jjHJyAloc02Mnypcfkw8CzQFv/2iBQPXe1vuVhALOg0n/AaA/mQhQdym1agNHurPlBqoKliIbf1
	jXXZTc4rv3t1Tf+MpT+BF8/kdUBGDvZygiwMWJ9GXCE9w4CONCotzonbtYDhcfscwAWMWaUvXNp
	X/tPEPmsdADp4KJCWi/CwgiQlJ2xAsSCTQuwYWGCGhlKr8l5TlNIbBoM3rKoruu38JJ/jmZCq4b
	oFVw04Pc8eQOxGJn+gg+qGbiogeNGWxLRs01BUB+vv5j4BAWG34vkjXH1tayDmChokm1jxRMaKs
	mesHLs=
X-Received: by 2002:a17:903:3bc3:b0:2df:9230:9916 with SMTP id d9443c01a7336-2e842e1349dmr116744295ad.36.1791902052498;
        Tue, 13 Oct 2026 07:34:12 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b0aa4sm56336355ad.35.2026.10.13.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:34:12 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] ipmr: validate VIF indexes before offload lookup
Date: Tue, 13 Oct 2026 22:33:57 +0800
Message-ID: <b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791899747.git.zhilinz@nebusec.ai>
References: <cover.1791899747.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_find_vif() can return -1 when a packet races with VIF publication.
ipmr_forward_offloaded() forms pointers into mrt->vif_table before
checking the packet's offload mark, so a negative index is out of bounds.

Validate both VIF indexes before forming pointers into vif_table. Invalid
indexes fall back to the regular software forwarding path.

Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv4/ipmr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c45..bc3263d15a44 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1879,11 +1879,16 @@ static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
 static bool ipmr_forward_offloaded(struct sk_buff *skb, struct mr_table *mrt,
 				   int in_vifi, int out_vifi)
 {
-	struct vif_device *out_vif = &mrt->vif_table[out_vifi];
-	struct vif_device *in_vif = &mrt->vif_table[in_vifi];
+	struct vif_device *out_vif, *in_vif;
 
 	if (!skb->offload_l3_fwd_mark)
 		return false;
+	if (in_vifi < 0 || in_vifi >= MAXVIFS ||
+	    out_vifi < 0 || out_vifi >= MAXVIFS)
+		return false;
+
+	out_vif = &mrt->vif_table[out_vifi];
+	in_vif = &mrt->vif_table[in_vifi];
 	if (!out_vif->dev_parent_id.id_len || !in_vif->dev_parent_id.id_len)
 		return false;
 	return netdev_phys_item_id_same(&out_vif->dev_parent_id,
-- 
2.55.0

