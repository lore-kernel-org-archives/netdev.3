Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC23A6F0F
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790414391; cv=none; b=bomuhg1jlIuFntrVMfW6bxjeRbvcTVnx13b2GXzWfanZaKSjYHYiyw3YbtBdeq/XaFi25oyiZ1Rg6aNywwW7L6VSf2ny9mMSIYGNoHau2U8XgA4GxFECB7NefE7I/kQbVMbjPxiIqoNC/ysrE9vy+HSBqQ024hVCTENSW5cGI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790414391; c=relaxed/simple;
	bh=3oJrG+KK6unBTLoJtFXe07dihlxSNwyhwcS72hSP3kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo3k9P3uR3exoDHBak9d9eabzYT9ibG5mThtSRJcGxKs41Xe0snfXt4cCvgzhnW7YY/NNcTQv9la6NtwfKPNhnDLvfADNwjAE8JNJrlapXI0+Vow5HPUsopfcRRIHJweo71XQQwiPxD3hTOT3Iwj5fEUVqt+8bK9ynsA9LSLyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=TbIrQL80; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="TbIrQL80"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc433d52421so601990a12.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790414389; x=1791019189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4+KNC5/TI/+Z5H9Ooz4zVdgMKXm2ndwqcVaNLf23zWI=;
        b=TbIrQL80pkd4yLDmWFQGMgP1KaW/KRBsliqW6ZJ/iLwtrVwDUtVEl06m3/irs5xhDc
         3TaFqRQmGkE4JAnuR24JklBfpCUGsb0QgTO40l/bNkKcXn8uUNIl8EKQy5aQjGntuoC5
         4syte6D77CW2wq14qKg2dwbn5sJmLwepZw8a7enOad/ZTKhvwAEyK3UvB48YA6o4BKXA
         q5shjdrXZZmi1EgcDhNlvYxPxMIwqBEdD4KfzhVa3cogBXB0riLFyMo/YRZ+RqDTVk5F
         v6o9N6MGki6yRROJAGQEQbcPEz6VWWK9X2duzv31Xq5V8YQ8BNDMCCCi1v0ZC6uXudLG
         WPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790414389; x=1791019189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+KNC5/TI/+Z5H9Ooz4zVdgMKXm2ndwqcVaNLf23zWI=;
        b=w4w3+520B6Jun+SkF3l2L6oKFwAb3szHJfPbaw8DVrBW2sWBLr7BEchBiJr8cMN4Pi
         6BOVr5Z5cRP8ojraCqTrBpuOzUMw1ZXtQUFevJFxfMmkc3FJSXFmrdsh7k26e0rfJffl
         cJwOsQ8q1xw+JU+AAyLfu7gw0Gb9ftxhJ3rGnwDqz/HhV1ANL5JFnH1aw47U5sD+Foqm
         Asuot5ZIGdDhL+ADmEP0arBN6Fn+ahnvR40La54AFTpb6sK3AZKtvzZ7W4cIhjUh6TVe
         b2u57cuxUYW6Z7L5nc/Db4Fn/xMR6rQA7TLKFuYio+eWeU+loFdd1vbqsyboZe82fJj/
         8uew==
X-Forwarded-Encrypted: i=1; AKwUvBytBG7qQPtLhdnVfU1eUqb0CCr5+RKaqH9FB1PVMTEuxG8EQuQ/hPaeuNTFXdbcD2IwpClzI8I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDzMleyyQHLK2Pof8gs4SUgmL7gziD3KYoNDjW5KN6lZqf2WJj
	RO5vdllXBHjYnajxKZWhxtP1u/nEw0oePPuPFWX0Ri7q34acAZLY9Sr1+dfKjLVOmEgf
X-Gm-Gg: AYBFou3jd8WxgFrHkTP4fFZFWu/dM/00DvpYd86tjqLx4DIyrp6cXJdoLmYwFuTedBr
	4O2e0sYwD0P1dpB6zOEF8YfeKk2jKKHT/D/c49WyrBK5oLiQnbK7Q73XkNLlDMR44Sb2LbC4pIM
	Wh7m5yatA4OBpmRZm6VfjLOq6wyRxMvPV9OG+hZjfIZ1Lqcmz+ykRYiUHYiS1VUxXwlafNhhq/U
	ko57uuu7GHSEhj55geVtMZQwZkFp5AEpUovn/E6HK/odugoKlMoNimzYW8QfErrGPYftM8T2jvn
	41iXU4Z1ACWgl0hIzk8xB2kTjIFfyNznDXNlWn0ONdKW4IXlLwidOYzqWduG9hZ6wQUIVQvtUY/
	VcAQWCxdfOl14fprdj6jDV/q4LHouxy4MfYIkSkExA3w6811TD+vQ6KNeq6Fdd+9macwa8lE2V8
	KvSd3L11SyYM9GRs2giBp4EEhpft1x06pP+V6VPJ+kdtq4cyCwqbvLJ5pGCtIeuOz59v2kG621L
	M1ZM/oEQ/EUJ3FUTkWaM/8rzAaGlA==
X-Received: by 2002:a17:90b:3c86:b0:39e:6c69:f472 with SMTP id 98e67ed59e1d1-3a098cf4a4amr7044911a91.49.1790414384207;
        Sat, 26 Sep 2026 02:19:44 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f5f917sm3553567a91.1.2026.09.26.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 02:19:43 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de,
	pablo@netfilter.org,
	phil@nwl.cc,
	netdev@vger.kernel.org,
	zihanx@nebusec.ai,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH nf v4 1/1] netfilter: nf_dup: reject TEE and IPv4/IPv6/netdev nft dup in userns
Date: Sat, 26 Sep 2026 09:19:27 +0000
Message-ID: <f802b45414041d7a722f98810142c691e3718cba.1790408011.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790408011.git.zihanx@nebusec.ai>
References: <cover.1790408011.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TEE and the IPv4, IPv6, and netdev nft dup expressions allow packet
duplication in network namespaces owned by non-initial user
namespaces. No use case for these features in such namespaces has
been identified.

Reject these targets and expressions with -EPERM during rule or
expression setup. Keep packet-processing fast paths unchanged.

This restricts duplication only in non-initial-userns-owned network
namespaces. It does not change the existing asynchronous recursion
behavior in init_user_ns-owned network namespaces.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Fixes: d877f07112f1 ("netfilter: nf_tables: add nft_dup expression")
Fixes: 502061f81d3e ("netfilter: nf_tables: add packet duplication to the netdev family")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v4:
  - correct Fixes attribution for the TEE, IPv4/IPv6 nft dup, and netdev
    nft dup frontends; fcd53c51d037 only added a synchronous guard
  - clarify that this restricts non-initial user namespaces and does not
    fix asynchronous recursion in init_user_ns-owned network namespaces
  - state explicitly that the netdev loop was not runtime-reproduced
  - v3 Link:
    https://lore.kernel.org/all/cover.1790042930.git.zihanx@nebusec.ai/
changes in v3:
  - reroll the fix against the latest nf.git main after no follow-up on v2
  - add the Co-developed-by trailer and matching Signed-off-by
  - v2 Link:
    https://lore.kernel.org/all/cover.1788425393.git.zihanx@nebusec.ai/
changes in v2:
  - drop the persistent struct sk_buff::nf_duplicated field and nf_copy()
    change from v1
  - disable IPv4/IPv6 duplication in non-initial user namespaces
  - v1 Link:
    https://lore.kernel.org/all/cover.1787903722.git.zihanx@nebusec.ai/
---
 net/ipv4/netfilter/nft_dup_ipv4.c | 4 ++++
 net/ipv6/netfilter/nft_dup_ipv6.c | 4 ++++
 net/netfilter/nft_dup_netdev.c    | 4 ++++
 net/netfilter/xt_TEE.c            | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/net/ipv4/netfilter/nft_dup_ipv4.c b/net/ipv4/netfilter/nft_dup_ipv4.c
index d53a65ddbd7b..db62e30456e4 100644
--- a/net/ipv4/netfilter/nft_dup_ipv4.c
+++ b/net/ipv4/netfilter/nft_dup_ipv4.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
+#include <linux/user_namespace.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
@@ -37,6 +38,9 @@ static int nft_dup_ipv4_init(const struct nft_ctx *ctx,
 	struct nft_dup_ipv4 *priv = nft_expr_priv(expr);
 	int err;
 
+	if (ctx->net->user_ns != &init_user_ns)
+		return -EPERM;
+
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
diff --git a/net/ipv6/netfilter/nft_dup_ipv6.c b/net/ipv6/netfilter/nft_dup_ipv6.c
index 95ec27b3971c..6219ef57633e 100644
--- a/net/ipv6/netfilter/nft_dup_ipv6.c
+++ b/net/ipv6/netfilter/nft_dup_ipv6.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
+#include <linux/user_namespace.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
@@ -35,6 +36,9 @@ static int nft_dup_ipv6_init(const struct nft_ctx *ctx,
 	struct nft_dup_ipv6 *priv = nft_expr_priv(expr);
 	int err;
 
+	if (ctx->net->user_ns != &init_user_ns)
+		return -EPERM;
+
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
diff --git a/net/netfilter/nft_dup_netdev.c b/net/netfilter/nft_dup_netdev.c
index 06866799e946..8d9dfd18475c 100644
--- a/net/netfilter/nft_dup_netdev.c
+++ b/net/netfilter/nft_dup_netdev.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
+#include <linux/user_namespace.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
@@ -37,6 +38,9 @@ static int nft_dup_netdev_init(const struct nft_ctx *ctx,
 {
 	struct nft_dup_netdev *priv = nft_expr_priv(expr);
 
+	if (ctx->net->user_ns != &init_user_ns)
+		return -EPERM;
+
 	if (tb[NFTA_DUP_SREG_DEV] == NULL)
 		return -EINVAL;
 
diff --git a/net/netfilter/xt_TEE.c b/net/netfilter/xt_TEE.c
index 5d34ceb893ed..51c643987526 100644
--- a/net/netfilter/xt_TEE.c
+++ b/net/netfilter/xt_TEE.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/route.h>
+#include <linux/user_namespace.h>
 #include <linux/netfilter/x_tables.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
@@ -95,6 +96,9 @@ static int tee_tg_check(const struct xt_tgchk_param *par)
 	struct xt_tee_tginfo *info = par->targinfo;
 	struct xt_tee_priv *priv;
 
+	if (par->net->user_ns != &init_user_ns)
+		return -EPERM;
+
 	/* 0.0.0.0 and :: not allowed */
 	if (memcmp(&info->gw, &tee_zero_address,
 		   sizeof(tee_zero_address)) == 0)
-- 
2.43.0

