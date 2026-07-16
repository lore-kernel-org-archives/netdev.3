Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8857400981
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210842; cv=none; b=GfFRjOKdM91gzQmSdL2UKW+V0KJmPIsRXYUsVB+HaZexAi2Fzr5qQZJHdQ9+iTVwTBGZm2qV4UFhVJEMYj3LhQRhpzWN+fZMlkO2JDSqetPiA0B8qFlQp33GKWAtwynvyp0pH44WSk1iVNKB9ow3apJnurt5jbi7Kt5xzPjj90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210842; c=relaxed/simple;
	bh=btDASYGmUHm0kbqZqVMslt1hNdAlhelxO4Zl2zjuXKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=idc7wFikSp3VDmi7nWvseTtM3Gh9Ww4U0TR9Fs71wN8Ee+p8rFBIOdaDRJQcYcbTEMUzgrd19i/5j9CX2o36F/rYfSX++/GBSYs8H469K/D/7OjIhZHkvhJGt7BsTo7hLydZR06WsQ0Ibr3p5IJaa+DiA94G6r8euYbKLcOjVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfgnwZPX; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfgnwZPX"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a376ad8fc0so2238534eaf.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784210840; x=1784815640; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DvXtVlllukOnRfih22Iy0sMwC4UQkImczALyzy6unIk=;
        b=hfgnwZPXrRSRZVU1uPiEW/ACEJLJ2FsIfYtmEn1LlbaSCOkArC8t1ROI4enPnkk2oQ
         wQJKY8tf/kC8IiYCe7/PvHhkL95GCajV3OwPHGoNM/oUyvGJofhpCNGfWIXy+6R8II8I
         bBFdt05tiuAOP9Dn/izc7sz2MYeEJbQwNnDwiyau5VMQcT1woPgULithed3CWInDt2Bt
         EW5ORCzxFFjleaX+uge6jF9rP/l8MPZQG9gd5OOSR4dibDUEZXDDvn9ISGO20/TQDAYX
         oLmXOsrWrfIvhS4bpi9qpqKE3j0CJizYAci3AFwfS9zirKEvixfhykn6WBQ2GajDUGU9
         kSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784210840; x=1784815640;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DvXtVlllukOnRfih22Iy0sMwC4UQkImczALyzy6unIk=;
        b=XJHKViCIl13QkXcsmcPldky4GCwBnhkBPMy9Yj9sBtVKuKeEgkQuW4MLvjLVv2BM17
         yNZQ8dFol5b5jGbbDASnKOtXrEq9HVLP61+82AvNrbvFgH3VGxtDn3JsXkFfMIjoCIhj
         rGRWf55EGc3VmcsToznn374Udj5RqC9vAdTC7bcBxgRScueoHc/HWT+jy6jtrWlxMPvP
         wBb5BwgBTn71gx88PaqjB9q+8X0puhApO8SG/8WGcWTS1PSoYJPtZ+jqDka0Fesp5HUS
         1F0GYABLl9JCKfzlME4ELxQ5nQlkAp0D03ob1bB+5omKPL0xO3oZzf52lE8GQDJdovU+
         kRdQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOkQb3/8DXiFf7uiR4wYo1Y+AN3QW5OPL/LMc/FGmzG9IdHN1t5nio7W7m46yzjIPSvTxMvcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQUcVmR2qM9+KighQR0rZXayjKJiifyTXP9uE4n6uf/QRKSkF
	tqJXYVCTOHtiDaE5rVUepL9JG506d4POLsCpoqEvPmIjmcXrYekpuS0q
X-Gm-Gg: AfdE7cmOAyQfLOLvHGjXlkwmvqPlizSWA3a3lsFc3Ra1U/ZQwT/D2WGpgWCCDKHbSkL
	cYMRFG8YNruAvf3N+QEe/2beMmDUDZ/7ADeTsw/4BoRhfwqf1uJovsqoKNxx6jMOXeJVvSmk5y8
	TVtaZxaDksU2Q91rutOdFYAKVPlqigx06GbbhYTqyjwSnfRaEEYUxHstjeaTNdHcdXrMWX2CZd/
	IfNS3RPAkQc4sFhj9zJvskxHebTuHQe4RrgKRxXTtYADKhsV1sHg46c1+s9qIX8s7mXrahEYQyK
	Sr4V2EbTmAPWtnswIGYnGBUz33y6B7aC1ZBWJfieo41dUpKfda7UEU8a3Y+8r4JhIsS++EDChwa
	YSmD0fGWS4IqynqOmCZ4zha85LgEXfp4vt2ZWfZJ1bTavFek/isRguGor1XwyQnkmTl+F9ywdXx
	Y/34Ur
X-Received: by 2002:a05:6820:1849:b0:6a1:5b81:6168 with SMTP id 006d021491bc7-6a3d9ff3481mr4711592eaf.43.1784210839559;
        Thu, 16 Jul 2026 07:07:19 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:3:3a49:ef75:fe4d:f2de])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4561f2680d8sm6165821fac.14.2026.07.16.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:07:18 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Thu, 16 Jul 2026 19:37:10 +0530
Subject: [PATCH nf-next] ipvs: use type-safe allocation helpers in
 ip_vs_rht_alloc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-nf-next-ipvs-deprecated-v1-1-4aad24f87cb8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI3lWGoC/x2MQQqAMAwEvyI5G9BYqvgV8VBs1FxqaUWE0r8bP
 A47OwUyJ+EMc1Mg8SNZrqDQtw1spwsHo3hloI5sN/YGw46B3xslPhk9x8Sbu9kjDWStCuQnA/r
 WYZf3Ly9rrR8ddPZwaQAAAA==
To: Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, linux-kernel@vger.kernel.org, 
 Subasri S <subasris1210@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784210833; l=2187;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=btDASYGmUHm0kbqZqVMslt1hNdAlhelxO4Zl2zjuXKk=;
 b=Fb9gx7V7iND+52cndnRympWJA22Qo7oksacuKyuXDHMsdPX/+C7HGQ88QkqJD9Q/eI1afbFxL
 GkGcJvV3flGDbgun621aJoYoJuwKoscppT+00QUbKBOSMu+PWtfuMKZ
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

As per Documentation/process/deprecated.rst, open-coded kmalloc
assignments for struct objects are deprecated. Replace
kzalloc(sizeof(*ptr), GFP_KERNEL) with kzalloc_obj() and
kvmalloc_array(n, sizeof(*ptr), GFP_KERNEL) with kvmalloc_objs()
in ip_vs_rht_alloc().

Compile tested with CONFIG_IP_VS=y and runtime tested using
tools/testing/selftests/net/netfilter/ipvs.sh on x86_64/QEMU.

Signed-off-by: Subasri S <subasris1210@gmail.com>
---
 net/netfilter/ipvs/ip_vs_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 35cbe821c259..74047bf1e32d 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -176,7 +176,7 @@ void ip_vs_rht_rcu_free(struct rcu_head *head)
 
 struct ip_vs_rht *ip_vs_rht_alloc(int buckets, int scounts, int locks)
 {
-	struct ip_vs_rht *t = kzalloc(sizeof(*t), GFP_KERNEL);
+	struct ip_vs_rht *t = kzalloc_obj(*t);
 	int i;
 
 	if (!t)
@@ -186,7 +186,7 @@ struct ip_vs_rht *ip_vs_rht_alloc(int buckets, int scounts, int locks)
 
 		scounts = min(scounts, buckets);
 		scounts = min(scounts, ml);
-		t->seqc = kvmalloc_array(scounts, sizeof(*t->seqc), GFP_KERNEL);
+		t->seqc = kvmalloc_objs(*t->seqc, scounts);
 		if (!t->seqc)
 			goto err;
 		for (i = 0; i < scounts; i++)
@@ -194,8 +194,7 @@ struct ip_vs_rht *ip_vs_rht_alloc(int buckets, int scounts, int locks)
 
 		if (locks) {
 			locks = min(locks, scounts);
-			t->lock = kvmalloc_array(locks, sizeof(*t->lock),
-						 GFP_KERNEL);
+			t->lock = kvmalloc_objs(*t->lock, locks);
 			if (!t->lock)
 				goto err;
 			for (i = 0; i < locks; i++)
@@ -203,7 +202,7 @@ struct ip_vs_rht *ip_vs_rht_alloc(int buckets, int scounts, int locks)
 		}
 	}
 
-	t->buckets = kvmalloc_array(buckets, sizeof(*t->buckets), GFP_KERNEL);
+	t->buckets = kvmalloc_objs(*t->buckets, buckets);
 	if (!t->buckets)
 		goto err;
 	for (i = 0; i < buckets; i++)

---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260714-nf-next-ipvs-deprecated-232667142d84

Best regards,
-- 
Subasri S <subasris1210@gmail.com>

