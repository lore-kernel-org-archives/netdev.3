Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7473A7F57
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478795; cv=none; b=KYoCux0Y4Su1Ip52E4W/MICcq6Q2G2cps/PxlPq5yXptmiqJnbq/JUvm/RZAB+QWDTgLH3S3M7M2oWlW2XiE+/enfbHSulOLLihADkd4ixkzVHufl50K/2FEJ2jk0LeYNgHJK19Z1o+e26zcEyRJvz2S6vsEBmkQVfZkfg0wdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478795; c=relaxed/simple;
	bh=1Eq2OLCklqhMHL30tdiX3UqMQZsrvHo8KrdQiyNe6Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3rLBYRgOSmEWGsWHfkT3TNbUxmXFs1hNwUjplUJlz7INh54e7Pr9nQgxjXBtMhTKmYQm4o79PHl5KSCOx1dbK7TewFEVPThWCLMMEMDxm6VaOE1sgX1uQHaiZMp5ViFyPMDhSzRr+jVLOnUKRM0jzATtk9LDl0pPSdc7nbt2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=PsQJZJoj; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="PsQJZJoj"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6768403e9bbso3531571d50.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791478793; x=1792083593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaahY5VyppYhjMzovhM4CJ1QxD6C1zY7gTyA5F8TsPA=;
        b=PsQJZJojHk4c8zvt2ewAF2WkgJ1sOXcy6xF0MdWkrWGF1SzodLWtDRLbPJzPET3n2z
         Psct42TAgk+AkIXVHc2O6ORIJ8ffwaug/t0Qnfxq6XwzUzP+dBu/yEKllVrFEo4zUY/d
         GnP6XNYUAGaVUSfv52v5GuHYNYCJjqHXINfSncw9TB5Qej6gTLJICNfE1xee6uy+8Txg
         FzsBxmeVm+Mbo40A/PWpSecDn+CIK8EdZ7WqzQ6wAKuHJaYtEm8BPYeHZwosMIvI9J4A
         1jtG7QDHVVMgRDJjyl3+oFU6KNIUwIgqAUgBImSIFLMK5F3RX2I5gffGFR7PTypOg0bk
         HsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478793; x=1792083593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RaahY5VyppYhjMzovhM4CJ1QxD6C1zY7gTyA5F8TsPA=;
        b=sotvoKsNGZYcg6VT421oFyDFs+5kTZP2OtdHuqw04cKD0hfricqJJxvFOTrF/Kc4Py
         6eCi0JKSkKy2Nsvw7eAKr1HTPB3wzaWzw9ndCdG8MXZhaTQJp0f5yMLs7TBGJt2fVJ/K
         oHbF81MMjK95mra5NzUUQ6kBba6FuGsCkBm6cdRgxfBCYCE5fmOd5DZhinOCqHN303PX
         vcgFUPqztqG3s/iuLJiE+LGtt/hpI957/bNENf+pfaZtgTF9c7wbgaEP7rvo0hTUKiQD
         Wm8ML9HxVHd5gk4AefVIv4nTmWCH6SN/numtE/GnwVl6Xx5VBwad0fan7HM4ybFss3pu
         hh6A==
X-Gm-Message-State: AFq9FYJSUzUylUbVYoKnJ1pxC9giSOB6Udh1i80Nr6zP/Hld+lkAVJsK
	f7KfljBBB6E6lV6KBdAHsWDOe/qfM13bS/DuzF5WmPESXIzY1Gnfz3j3njQLAv7rJOwpwoqcoKz
	szedEjUI8I0U=
X-Gm-Gg: AYBFou1Cqv4ICkYUqfjehNvPkEdT4JHfuxBB4ptVlEcjrjpgQYy1fo+GV5knzY/bWO9
	qH+F2JAuhJn5BNLgdUZj2aOrFJMBbs5UfP5ih0aN1x4PZLGqxS8WTD4zQQ7mcdHHomghYPKz57w
	zt3pd5osXW8byo9DDtUy9uXXG0/1sy4PtlcZgyDmcmkAVKfUkjtSPGdznoc1HDX6TK5gMd6LRoO
	txxJeJ2ISlcnHvvLPbpA2P2zAcerLGtzbUzS1fqTBa6S0RfJnwlW1rve0NpUXEl1ko/seYxs/cr
	9BC1jzKMT9jeBXx89UxV8DCEWsB2a7gYPqd6OnSZpZzI+k1pUGNbMGw/6ZNDRbXWvG+VoPmBQzQ
	olkrDoOhhtoxywlMuAgVlu+PSUDylqMbE2SP5aG4REJJk/5kaVI7ygvic5oKuvzsXVSsbWrw+ew
	jtY7mHKChKiSiZL77ZAm3VDyqFyocBFm4uqGFfc4SgUU2MkPzacRLrNEikiHbn4FDb2HRPj02K3
	VK2RCvM
X-Received: by 2002:a05:690e:4381:b0:676:83a0:c3d4 with SMTP id 956f58d0204a3-6790a088a8amr2163247d50.27.1791478791828;
        Thu, 08 Oct 2026 09:59:51 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791b26486asm1537965d50.24.2026.10.08.09.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:59:51 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	zirajs7@gmail.com,
	fmancera@suse.de,
	leon.hwang@linux.dev,
	luoxuanqiang@kylinos.cn,
	posk@google.com,
	ast@kernel.org,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: lwt_bpf: preserve encap header across skb head realloc
Date: Fri,  9 Oct 2026 00:59:35 +0800
Message-ID: <68db88ada2fd01fc03f17dc7d54a705aa245ddea.1791433504.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791433504.git.rakukuip@gmail.com>
References: <cover.1791433504.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

The BPF verifier permits an skb-backed bpf_dynptr_slice() pointer to
satisfy the helper's ARG_PTR_TO_MEM | MEM_RDONLY header argument.

In bpf_lwt_push_ip_encap(), skb_cow_head() is called to expand headroom.
If the skb headroom is insufficient or the skb is cloned,
skb_cow_head() invokes pskb_expand_head(), which allocates a new head
buffer and frees the old one. If the encapsulation header pointer hdr
points into the skb head, it becomes stale after reallocation.
Subsequent reads of iph and hdr in skb_postpush_rcsum(), UDP tunnel
header handling, and memcpy() lead to a use-after-free read.

Fix this by copying the encapsulation header into a local buffer if
hdr points into the skb head, preserving it across skb_cow_head().

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Closes: https://bugtracker.nebusec.ai/f/11304
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/core/lwt_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..15b753a67452 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -604,6 +604,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
 
 int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 {
+	u8 hdr_buf[LWT_BPF_MAX_HEADROOM];
 	bool is_udp_tunnel;
 	struct iphdr *iph;
 	bool ipv4;
@@ -612,6 +613,11 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	if (unlikely(len < sizeof(struct iphdr) || len > LWT_BPF_MAX_HEADROOM))
 		return -EINVAL;
 
+	if ((u8 *)hdr >= skb->head && (u8 *)hdr < skb_end_pointer(skb)) {
+		memcpy(hdr_buf, hdr, len);
+		hdr = hdr_buf;
+	}
+
 	/* validate protocol and length */
 	iph = (struct iphdr *)hdr;
 	if (iph->version == 4) {
-- 
2.43.0

