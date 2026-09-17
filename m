Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74D5A9866
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662888; cv=none; b=GZKv7EojGuFt/lLfWDSWHJz/l2awLQtj6k8+H8BNA1N+Od2rr8Hvj7Q5LrMNYG5DZB6dQoC8eDd2HhMKiQfKxBooDJuScdQRusWHqzHySYxKS9dEWkOS028gQ9C/bS+QF+UhJWML8zYSK7aGgqR+emTz/9w0RpaqucGfDbHw49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662888; c=relaxed/simple;
	bh=7o9JwuldElGWG7RmBJcaqaaX2Cx85WG6qiS9aJ1Bxv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DT2ceZFjwmLJMOQ6IarlTyxh6A/mgESI+hCCIWSfakMZMFRluRx+NUF5rwG4lrTJrrbNBae//fpGHblUdH9TR8YPRkOwQAyJk8FPICn3YhRbLDx0WEiN1dSALBczDHKr4+BJkev40hyQRUROCYlf7mbmSRwbjnpbppFX0yoXdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NiPNIRpm; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NiPNIRpm"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35601so690712b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789662885; x=1790267685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auNP+ct9RIw9lrR/ZAwJ+MIFmWOSTqiGaQWeBWzAEDs=;
        b=NiPNIRpmy3fr4EnuReKP56AVFuh1edOGtGFYDgK7WXJ3VGM56aFoe31SAhvqgmI+tw
         3BMH3Hf28leJ31rTH+JAwTkg6H8Ag9pz4zlv1BAG73RKHfmWfbd/tIxWJ2H4SRJ0ncEX
         7bv+pXIa3t9XVI9BM2VWaVZYW+ZKLXtI3naYGmzj9hHm6Jj/jDfcioj+lkLJuf4HAzag
         sNAuRg5pua4ax48EYC5mPwDePRezv5Oat9SodfhUaL8hYNd45Pa9XrKVAXUdV/xgV8c6
         qxKd2t1vN2CvKSjk8LvMMgaOX9MvE0fXHiCw/P/lQmaL+RlGrYeuxS3LeVoffw8K3XGr
         XxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662885; x=1790267685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=auNP+ct9RIw9lrR/ZAwJ+MIFmWOSTqiGaQWeBWzAEDs=;
        b=0RrnIALXbNtJv8pZjo6vAQIMiQn+EDBeqrovUTy5sIrLKTRjludczeuJonk6dndG7o
         PYwPCj8B6uM/DF2xu27f2bSERtS6LfPNDoQklU33hqnyvH/45cMJDTyvSdcOf4pHcJJa
         unU0ruLqIUrdYHPufXpxJQTghXiGs75FI7zUy/0gsW8TjqvjduvZ2us+agGt1034qrI3
         fcTS1bURsquD/haoDACfkmXSO+nI0Xc3KD5/LnwtwCdRuJt13GzSbVPjsf2/nv1f7MHd
         rTs342RVo4YS8v6Hk2Uh2xJkAFwVkjeqQgy0WNko3LiNLxni3YbY8GrG7Ru8MInfYEWk
         oMRw==
X-Forwarded-Encrypted: i=1; AKwUvByfq+CJ/pwjq+fKAnExPuxXLqs1JM9xQh57nSOIHs7yBbQC9/XqEeqIM4tq02Kgu6HAjd2YuYw=@vger.kernel.org
X-Gm-Message-State: AFuF++myQJSnqvi9w87JUiJMpO4MXIlDqv/roOf8ET0zYhalToXRErSo
	IOd/9ezyB7IJAGCX7IlHUA25xyg5ZEIm/JpbRqj/t06eDrdp56yMdMooVtYPcqnvhCfW
X-Gm-Gg: AYBFou2e5f/tcxphRJezDvt4XNwfd2MKyLdtcLxYUUVC49B4Cv86je5HpTuPnDgVeAN
	WtzzdifdeaQSbojawkBQopWDGfX5ie3jmLPOGYLj3YEnVw/QN8+Y1bBUnZPDf+FqL+xkQ7X1a3j
	JLo3/5/+lMNSIKBBmZNOELIg8O4WcyA6C95AeIH9yKPS/eAcA0BKhRh3wi1JLLYN8b488ffkwGf
	0N2iQ8hMXbvPQRw6mbPuvyrS38lsD8CZ+Rk6l5vfCSJVAUPJ8M5Lc5bNYlC6KqBP91Kb4ZBMWJE
	+HkEH6xPe/CuV9PO1bsrEN82DIhi02F7abHSW9taGgOPwPJ1Du0rJD1VA2DDSBcpTIyX3OLh2vM
	YGdounLQWfVaM+9lZRXCKO7P74HRQTeRrpGxC1JYxagr+qc0B9ukpf9hvXD67NnZ4CFZsLVAoz2
	S7UDduagqmh90U6uyRSy7A5nsXQUIMqcBar481zFHB4tUowjLjWktK8GNe+Awd68zwDbscmSGMr
	G/pK6ZdcntG41EU7f+j
X-Received: by 2002:a05:6a00:6caa:b0:856:30dd:91ba with SMTP id d2e1a72fcca58-87236ae8236mr15335218b3a.2.1789662884910;
        Thu, 17 Sep 2026 09:34:44 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872024e6a39sm3240251b3a.56.2026.09.17.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:34:44 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	m.xhonneux@gmail.com,
	dlebrun@google.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 1/1] bpf: fix TOCTOU in IPv6 SRH encapsulation
Date: Fri, 18 Sep 2026 00:33:51 +0800
Message-ID: <20260917163408.252431-1-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789646866.git.rakukuip@gmail.com>
References: <cover.1789646866.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

BPF helper SRH arguments may reference shared array-map values.
bpf_push_seg6_encap() validates the buffer using the constant
verifier-approved length, but target functions later reread hdrlen
and first_segment without snapshotting the validated bytes.

Another CPU or userspace can update the array-map value concurrently
between validation and use, changing hdrlen to request up to 2048 bytes
from a much smaller map allocation or changing the segment index.
The resulting memcpy and segment access can read beyond the map bounds,
potentially leaking adjacent kernel memory into transmitted packets or
triggering a kernel panic.

Fix this by duplicating the user-supplied SRH into a private buffer
with kmemdup() before validation and encapsulation, ensuring that
concurrent map updates cannot alter the header while in use, and
freeing the buffer on all return paths.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/core/filter.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 11bb0d236822..3587f4ba0511 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6706,16 +6706,22 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
 static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
 {
-	int err;
-	struct ipv6_sr_hdr *srh = (struct ipv6_sr_hdr *)hdr;
+	struct ipv6_sr_hdr *srh;
+	int err = -EINVAL;
+
+	srh = kmemdup(hdr, len, GFP_ATOMIC);
+	if (!srh)
+		return -ENOMEM;
 
 	if (!seg6_validate_srh(srh, len, false))
-		return -EINVAL;
+		goto out;
 
 	switch (type) {
 	case BPF_LWT_ENCAP_SEG6_INLINE:
-		if (skb->protocol != htons(ETH_P_IPV6))
-			return -EBADMSG;
+		if (skb->protocol != htons(ETH_P_IPV6)) {
+			err = -EBADMSG;
+			goto out;
+		}
 
 		err = seg6_do_srh_inline(skb, srh);
 		break;
@@ -6725,16 +6731,19 @@ static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len
 		err = seg6_do_srh_encap(skb, srh, IPPROTO_IPV6);
 		break;
 	default:
-		return -EINVAL;
+		goto out;
 	}
 
 	bpf_compute_data_pointers(skb);
 	if (err)
-		return err;
+		goto out;
 
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	return seg6_lookup_nexthop(skb, NULL, 0);
+	err = seg6_lookup_nexthop(skb, NULL, 0);
+out:
+	kfree(srh);
+	return err;
 }
 #endif /* CONFIG_IPV6_SEG6_BPF */
 
-- 
2.43.0
