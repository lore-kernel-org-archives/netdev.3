Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196532DB79F
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047183; cv=none; b=u/6XXEbZ4SAs6CX0CK2V2GIjAevzQywByjVrHA5rO2ntfgKCD43uuqkhchTcPkTAQZN62uZop+c14ItNcuUmgJjh5E+5KPfhMXcoa/gjiY0R43YjMiGl4COg/r3KVv4gdYXeK5fsVU0brluhSzLODRG6kSp+TXyRcOFm5DfyIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047183; c=relaxed/simple;
	bh=U6rtLcsMd+bW6cgkNVoXqC0rvV2EUY2DJnWwFEigjMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehEuMWQYgfMnT+GBuTYezJbFPeZseMlJEIppGlVqGat4Wx+jrIKaIXZQH2WN7f8jMWiuUHbyP7kVFIDZ3YhozltoC9g3H56K9x4+7bRxixsiuuNhnP8vLSoLY7t5CFUgzwfTCR+qK9PdTd+o+uH2d6R16mjhY+vqgHS+98YkVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev; spf=pass smtp.mailfrom=corvaglia.dev; dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b=o8QBoOMC; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b="o8QBoOMC"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6aaf69d55ccso385559eaf.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corvaglia.dev; s=google; t=1785047181; x=1785651981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8BWHXjMiQy9uqWLmDCLbC9R8ot89mFYPDtLgVnTx4Nc=;
        b=o8QBoOMCyuczCMkXOv0oIt8ZgtVFCd/t2BNokYIQk5A59mFzdHH6PIzjMWuMWVHWtf
         RtFSYfCWc8KxH1jpe/uv1P1ezhY+Sq8gpLvQzY/lTUTIqd7mLuKvr20lWPWAvfX6zCUy
         4Wa24WGj2WVukscjhL0UAzdNNzH/O3Z9vB2wTyLdm3oUrlh1JDiHRd6wVai9J08j0uyl
         CpFaDWU2NaZAkVo/icvuxF7vdvJGqRNQrjvhzRdLskH68EBzmm2Piwv7XpPp1hALk1Dm
         shnH8fI+fw9wy3EEmXs22D5ODqKEU4q4gyPqUNprNV4xYea+oIhV+/Abnrc5DPy1vBUw
         83gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047181; x=1785651981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BWHXjMiQy9uqWLmDCLbC9R8ot89mFYPDtLgVnTx4Nc=;
        b=INqlxGgURpcBHqETRjRveFoXzxlW6X+obAPT/m2GG55WOIPc4W88UmX6ZBM3Xj+KeS
         Che64P4X5/R8QH9eMgBA5oU9T7gen3iYmEIHLEa++fJyqwW1Hf/kghyTC8Zzr5bZ82M3
         gP3Rzza99B88pmfWv8tjNEOlgiri3V3+6P9LlYeV6OUxWzulN5PEqnVZHbjbBVxOA7rG
         e/32TDG+GwcacpsLok0Bewq7zrm88KqiiaSJyI0EbWbMPw8ZVyn90TcA6JbfjU5t0XNQ
         NBqqxMdeWx4H5IF6RbrJAYm0Iw/yVl6BgiXRDovQHEnsYNZY78Jd7v+i9Reu2z+g/nbc
         r91Q==
X-Forwarded-Encrypted: i=1; AHgh+RpbvlPWnBxvTlZ5tKNb0F9fb6+JDlcsD3qcSL/RrHnkgCHwb2eJ07O6KyMkBAWJZA7ac4r0EWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUj7ZB4CH059xhTloi03lSRSsBroXe8Ta3iSLEwWo6I/0IaVC
	K2CcmJnmPxJ1PE4zfU1o5ainK8XqSNufN3a+zv53cguELfuw0U6BDGjMsPhG9k0yQHO3
X-Gm-Gg: AR+sD13rQ8vDPf9bx3+f2ahsm8Qm+oMIf3haiABS3Bgqb6iWVyNoOXlTafy+Wx3DqMU
	MGHXvdhq/9y5hpu8xcLpM104kFbfED5lnksmh5MYuvys/Xhq5aTgiVLJy7AIoPfAG4/sEp9tjIZ
	GZAAGpBvlXbs3Qnj3Fe3aolJLvsnvqN7e/fW5IcP3WwhCqT4bG4G4GnJTHyOsC/e7byyKDuFUNo
	AIm5x7qUzWJg4+T6nfbrG5uj9ADjrEmWRefuz7Kne/2ssLO/ZbwJt7DGdJXAhFqh2aoUwfaOuIA
	Mg33edF8CCtzgd+lf5+tCDHeJraF448WYmZuarLKW5lh9eR8BZRKUABSmnkShsChiJJXXoICn1q
	9hRHlEmLPCU9TiMFFIWD65g5QNay+QYiTOMGV8BQEjvB0ojynzGZdkiY5xPTI6+V9
X-Received: by 2002:a05:6820:4dc7:b0:6a1:9a59:5c5f with SMTP id 006d021491bc7-6aaff9a5a80mr3020723eaf.46.1785047180881;
        Sat, 25 Jul 2026 23:26:20 -0700 (PDT)
Received: from dev ([47.160.132.81])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf92d0109sm3073215eaf.3.2026.07.25.23.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 23:26:19 -0700 (PDT)
From: David Corvaglia <david@corvaglia.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Corvaglia <david@corvaglia.dev>
Subject: [PATCH net v2] net: bridge: mrp: fix Option TLV length in MRP_Test frames
Date: Sun, 26 Jul 2026 06:26:05 +0000
Message-ID: <20260726062605.2746-1-david@corvaglia.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

oui is a pointer, so sizeof(oui) is the pointer size. The MRA
Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
causing misparsing of the frame on peers. Fix is to replace
with sizeof(*oui).

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Signed-off-by: David Corvaglia <david@corvaglia.dev>
---
v2: target net and add Fixes header
v1: https://lore.kernel.org/bridge/20260724051202.61946-1-david@corvaglia.dev/
---
 net/bridge/br_mrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 3f7126a7d720..179d2470b724 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -215,7 +215,7 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 		struct br_mrp_oui_hdr *oui = NULL;
 		u8 length;
 
-		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
+		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(*oui) +
 			MRP_OPT_PADDING;
 		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
 
-- 
2.55.0

