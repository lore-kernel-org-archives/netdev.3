Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73DC209F43
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712693; cv=none; b=tDdahdsr0ogWTg0zH0ZFqQAPQyWEfgHkf85orTnLCyJ7/BBt80/SwB1ebs7aHMShxzrSz8YhHoqOePlvqEkXJuaA+DFg2DbXnr4ALkyqUYjuP5gTEyZW8CSinXZAQGHoZu+H7f2N3UDvWkcu1EC7h2n5pu93cBnu1IBnwuxz5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712693; c=relaxed/simple;
	bh=94xkAvnLmMabmgATmJMMNWRzGREe8szbBhLdQ7GGXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PilqV81v5nC8b8gIw1pNiYnY5XDkid6XwhZVdwuHr8qZTiwT5GU6DEZMRsBC8BWEj+naHaAJEz8VNkq/krizMrAFDeUQsy8RKiNhnOU/bzF5SSp9IdSmExYxAdn8Y81hCbLjzseud19QSQoY38lm7mvJ+rhUKJXtlxZO3PEq3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahvBx6aM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahvBx6aM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so663201a91.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787712691; x=1788317491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShK5TyOhCBOCjRuaFcsPnw8HbMZUB4sbslz07TTKocE=;
        b=ahvBx6aMdIKWeri02ar1VLryYA9GMkp3GC0fg4lyiGD4xlhclg81P1zM8M38bJmwng
         QAwEntIwaG0v+k1yZ+6JF9uii6xB7bCNnChg08QBzqP2Nrv3AYVZAJAkZDtBa7jmYhJi
         NBCphE1n7/tWVCfgjAPZg8i1cbWyZIqUYQCZ/7GoqBevsVp9jytD8t4VIuKJOdq7AxzI
         XUkoQk0ms+ikP+ryFUcw7qz5KxWfPDgoQ8ZfHoWnPq3lSLV2d0GRDJ345LbwUc0xGjlC
         /bbhIVCyMN4cUycUf6dsrwsJkRiopjnYgo1BaUpAd8K97dmAXgjlpRq8I18s1aBNMgUm
         /5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787712691; x=1788317491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShK5TyOhCBOCjRuaFcsPnw8HbMZUB4sbslz07TTKocE=;
        b=ci2gMyMLmQbIu4LuFqeRppANwfSNnClQVmMsJyQO3u6jDgZrTPbHNa489aKfs07+p3
         ywxc4DjUGzcIfujdR60m+Qtv7saxOxoBEYOHYMh6j29jBa+b0jp7afBTUcScRI/wwEc1
         sd9qgwuCST4u9P5cI/0ENzFctyDzaYDJfB6fW/dxNqikNm1NYF8PSnOm7Z7ca3h/FGua
         UFXaXxNnYItJxMj76M1w8Qf1BmSozNXAZWxlm60AyBUcWSVeGw5MffZALJVfrLJ7iTpw
         ozdcSLqXPfXR25htGi4CcfNjb1EULbiD2McxAKT0UPsq/DnftwA7Z17liKAa5fmr0ju5
         ooWg==
X-Gm-Message-State: AFuF++lN4syW3X2eppw9JsGAr2+4+B9MLqxUwAuJGwmzqJSXuSnlDi1D
	QCd8vOdtXz5RA1N6Yt/17U9AWN1gTJgHrRKQGmtBU1siJRwvKm8gMcfR4jScNFLGl33rhg==
X-Gm-Gg: AR+sD10FZP5qW3UekimHACuwCgvMdar7RyRc4THZUzF/Y06Z5SHT64RueGWZy8VWiis
	4OKsvJ8XYvmOU5tsmBQk6mLCwgGrXZnH5/lw9bRwf6HFGZqrPw5O6MnIgNfEm5m0VCZXxfqHSvy
	C4JxWifhfhaUkpSJ9bkTie5RlR8Jy6f/PHBpIBwlEyBr8fJ3Ar277zB1I5oEHt/Shuu6QGGmxyA
	bqShjsI090fmfZ/+9lQ6b9bPQX6IfKROb1FQEoo74oEopsJp7WOYOxBQm6IFQHyKCIPy6i5gwYR
	MtH8N3f8pHxtvI+h2uwt0bKL+/gfGx/0Nnsot/SNlYHe1fDylfa66zrZLVr8u9RudnqMC6gnE0S
	8ejuAU+qShwNH+rf/WCu5GgguFr3V/s5znOh4bSwFDCxDD3LgcClVl92bMO9x+BhvpaWzKngx6F
	xYON3XmmH4I5w9ook09jxhN3Oigz0nrw8cw8nA7dWQtpfifk2RsLO60/I2SQV70e7TJvFP/5jbI
	DdNKjB5xEcjLJCeZVAXsrHzK9Ot
X-Received: by 2002:a17:90b:380b:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3966d002fffmr7293811a91.0.1787712691017;
        Tue, 25 Aug 2026 19:51:31 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396686e8e74sm2039520a91.1.2026.08.25.19.51.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 19:51:30 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: cls_flower: validate mask pointer after nla_next()
Date: Wed, 26 Aug 2026 10:51:20 +0800
Message-ID: <20260826025123.62758-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

fl_set_enc_opt() iterates the key's nested tunnel-option attributes
with nla_for_each_attr() while advancing a single mask pointer via
nla_next() at the bottom of each loop, so the mask cursor is driven
by the number of key attributes rather than by the mask's own
attributes.  The nla_ok() added by commit c96adff956191 ("cls_flower:
call nla_ok() before nla_next()") only validates the mask pointer
that was just consumed; the pointer produced by nla_next() is used by
the next iteration (fl_set_geneve_opt() and siblings) without any
validation.

The mask's nested attributes are validated with NL_VALIDATE_LIBERAL,
which merely warns on trailing bytes that do not form a complete
attribute.  A mask carrying one valid attribute plus 1-3 residue
bytes (or a non-aligned attribute length making msk_depth negative)
therefore reaches the next iteration with msk_depth != 0, so neither
the !msk_depth check in fl_set_enc_opt() nor the !depth check in the
per-type helpers fires.  nla_type() then reads past the mask payload
and nla_parse_nested_deprecated() iterates with an nla_len taken
from those bytes, reading well beyond the mask attribute (KASAN:
slab-out-of-bounds read in __nla_validate_parse from fl_change()).

Validate the advanced mask pointer as well: when the mask is not
legitimately exhausted (msk_depth != 0) and the new pointer fails
nla_ok(), reject the filter with -EINVAL.  An exactly exhausted mask
still skips the check, preserving exact-match behaviour for the
remaining key attributes.

Fixes: c96adff95619 ("cls_flower: call nla_ok() before nla_next()")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 net/sched/cls_flower.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 0e275b58151c..1cefea571efd 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1703,6 +1703,11 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			return -EINVAL;
 		}
 		nla_opt_msk = nla_next(nla_opt_msk, &msk_depth);
+
+		if (msk_depth && !nla_ok(nla_opt_msk, msk_depth)) {
+			NL_SET_ERR_MSG(extack, "A mask attribute is invalid");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.43.7

