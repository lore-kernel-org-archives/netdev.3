Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83A3BADA3
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565138; cv=none; b=nXvmfgnxa+01AG3pbrVBuNQCrmeyRKDRt0jKDsSjqih7lckoX0j+3/fLMaNTxijqoC5pGDjG16noJMR8pT7Y3wszAXLJh/0qlfygXiQVzjGz45+h4w5S4CBJOOkmI/ofm71qgZHQEwRrd6NSf/GP22NE5VEX7/AitHRdnbKNfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565138; c=relaxed/simple;
	bh=V8cThIRNCnyo9xKKWRG1mucBjPJoc5uJWaiptO5+CE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKJs2MSV/13b3Hw94RG1LmpoCAieXCR8+V6zuliAUjkv3Q0wKGmc9s3978y2JuMZhwraXnJBMLrPI1mZ1fPKyKXGnV/Vdo3Hj8rwLjc+NdZdpyR8nhC1CDoZtXLbnxyvdMFEgfOPjqxwKORlJwLerI1kHq4tfXt2NUe8acZFL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0hTFdR5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0hTFdR5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-887fb6c0ad1so2371189b3a.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565135; x=1792169935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8HVGg1UwL+foMzId5fbWtScAv0iyZ12Lp0YwhWR+Iw=;
        b=L0hTFdR5coto+rY30vOtrg3PEJ91MD/Xf7PBSKT7ztifTOH2ILTeUE6yNZaP3ZrvPr
         /t4GemLYOpEe8KbPqoOGyhylh3Gp6XIb8I8nv4hSAgfBBN/iWHzo51ZnesfLmX4IZK5d
         2xvF57U+DoyrmB99RK2bxTEp88i6giAVGjDscTzLb1WuL2fVFsQLCao5a1wjmZAvJpe3
         d20OUQiAdVgkPlyjuOBYj0a2DVM4WuOkscy/4jl5nMV9kxF8eYqftFnVxqNJ5S6sCrwh
         3Ms0ef9brYYXZMERS2WXwhwEZysbmVCI8ubGW8fdKMqgXGDV7vJGP4XHFUgduryp422T
         6SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565135; x=1792169935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8HVGg1UwL+foMzId5fbWtScAv0iyZ12Lp0YwhWR+Iw=;
        b=kSh5xmjCUPX1X6uBjkZl9gpPKD9/nAUsIfAHGtDepmieV7O6/YjY6ZDf3eJmb9E+xK
         f5RS1zlNawjfzwYHI9upD3/dnYTgefNHsaK2nJFguM+0rMHKaiVwuxoDi6GpgCxW+okx
         7doWIS9+zckKc+SA/2ntsQ/JodIzKfrwWBPafrns20eoBxvrRFCWj8o04Xe2FW0Rz+49
         hLdFcTHAichPBEbadlZVLTXmKSv1xVb9UZ7QQ9rI69s/TNrGNeYcePmNjvPmweNUeLKx
         aGQM11CMzQISK+/VQeo9hMHZifWjczYPi16rTJKACj5KplebDou9dtA294LyeadMrH+x
         EpKQ==
X-Gm-Message-State: AFuF++kW44IJOK28z8U6Tq7LTo7iPXYkfRTJ8X4PV78ocAeyULpswuab
	QTl/NIYukFljF0kte4XNzr55t744Cgxh2jHkxbv0hyBvrv1RPjTLcBzd79RHoX7M
X-Gm-Gg: AYBFou3CUI2q0bwDmVqJLVDDuq68sDDIW581EnSqqPb4+f6a06VCRZ5s2e1dL2+45FA
	lPDie+fSwwj2MOCN474kHXGofEuxCG2xQx6oeYaVh6M73DuIJKy6OaRHg2NKYVhJkhQnjfaMEdE
	3OYPnS4LOU+EA6/cyhVdF+0c4kJY+ORbyx2PWw8FYx9Z2ZeyVEdk2jM47yOXlU3Lo4Q2BTNEnO3
	TZIFHwvmTD8maKsfnBPUHHD6l8gNNcEyccAagna5bWy9GToYCo4qrUxGVlJoDCYAysEch8PR6Fl
	jcBy1Rs+iy7dAFeyBNOCG4swiXrDkyzJj3RriCCycYEDrtW587rJjdr/22+DuXCfQTPLVwVdIou
	tRulKhsQRtLYhlQDtY9K8aiPK8idEzhZm/F/SGg6MNIAn/avNtbTJleo4HUpzYHmOl9Yzw6OGdo
	CZ0uKUVjRrx+U2ZRGpfdL2UzOTr6KuKbPGRgh7T9iR8R1+YBZUKV7f490bNaQq/UxmDE6UfBBbL
	HYxVBzFD6g+D1zB4O2CAcUSMg==
X-Received: by 2002:a05:6a20:431e:b0:3de:3f4d:f2ed with SMTP id adf61e73a8af0-3e16bfcea5bmr2254422637.36.1791565135388;
        Fri, 09 Oct 2026 09:58:55 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c37de994sm1494437b3a.26.2026.10.09.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:58:54 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] net: dsa: motorcomm: Add TC prio support
Date: Sat, 10 Oct 2026 00:58:22 +0800
Message-ID: <20261009165825.359259-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009165825.359259-1-mmyangfl@gmail.com>
References: <20261009165825.359259-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW orders ACL rules by the 9-bit ORD field (512 values, larger
matching first), while TC priorities span 1..U16_MAX with the smallest
meaning the highest. Map them as evenly as possible, and reject others
which do not map onto a hardware order instead of silently colliding
with a neighbouring one.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 35 +++++++++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/tc.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index a302016912b5..3e0f80500f41 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1029,7 +1029,10 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 			       const struct flow_cls_offload *cls, bool ingress,
 			       struct yt921x_priv *priv)
 {
+	const unsigned int scale = (U16_MAX + 1) / YT921X_ACL_ORD_NUM;
 	struct netlink_ext_ack *extack = cls->common.extack;
+	u32 prio = cls->common.prio;
+	u32 ord;
 	int res;
 
 	if (!ingress) {
@@ -1042,6 +1045,36 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 		return -EOPNOTSUPP;
 	}
 
+	/* Lower TC priorities take precedence, while larger orders win in
+	 * hardware. Spread the 512 hardware orders over the TC priority range
+	 * as evenly as possible, retaining the relative order:
+	 *
+	 *   prio 65535 -> ORD 0    catchall filter
+	 *   prio 65408 -> ORD 1    highest mappable TC priority
+	 *   ...
+	 *   prio 49152 -> ORD 128  default value for the first tc flower rule
+	 *   ...
+	 *   prio   128 -> ORD 511
+	 *   prio     0             (invalid TC priority)
+	 *
+	 * The catchall filter always comes with priority 65535; pin it to ORD
+	 * 0, the lowest hardware order, instead of rejecting it.
+	 *
+	 * Prefer explicit rejects over implicit behaviour changes: reject
+	 * the priorities which do not map onto a hardware order instead of
+	 * silently colliding with a neighbouring one.
+	 */
+	if (prio == U16_MAX) {
+		ord = 0;
+	} else if (!(prio % scale)) {
+		ord = YT921X_ACL_ORD_NUM - prio / scale;
+	} else {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Invalid priority %u, must be a multiple of %u or 65535",
+				       prio, scale);
+		return -EOPNOTSUPP;
+	}
+
 	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
 	if (res)
 		return res;
@@ -1049,7 +1082,7 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 	if (res)
 		return res;
 
-	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
+	yt921x_acl_rule_set_ports(&ruleext->r, ord, BIT(port));
 	ruleext->r.tag = cls->cookie;
 	ruleext->r.type = TC_SETUP_CLSFLOWER;
 	return 0;
diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
index 32b53f1f3825..f11136a1c5e2 100644
--- a/drivers/net/dsa/motorcomm/tc.h
+++ b/drivers/net/dsa/motorcomm/tc.h
@@ -331,6 +331,7 @@ enum yt921x_l4_type {
 
 #define YT921X_ACL_ENT_PER_BLK	8
 #define YT921X_ACL_NUM		384
+#define YT921X_ACL_ORD_NUM	512
 
 struct yt921x_acl_entry {
 	u32 key[2];
-- 
2.53.0

