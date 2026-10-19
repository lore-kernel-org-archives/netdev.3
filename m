Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442328;
	b=stp8KC0tCw5U2BsJKWO073JJwQ6o6g1a5SFalpUFhxArRgXQ66W5q5QPJyOTc4gfDQlq
	 U/4GtqatI9vttVJh52gU/roKPvF5UEpS+GzPaqGh/D52qmv3h/F/e1AP59W3CjIrmq8jo
	 /SX0PMU6BfFrz8iO3v0jeIOHmBSX0aLM5YwincdiDrtW1p9s3KtUD/owpjUP8YWCQIuyp
	 EAUpZYAlSZ8XEdIMUK4gbp0IXOMJM8Pi2V3zv3uiV5se29Ch9u9ik9e9WgEUCpN+oFYUg
	 WtE9nnBMLiuKWh/tKReH1Vb9nK35LB2yacfNBKeQqdzJ1RYWS+HZkSK4/OYPFkHUP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JoFoVU0d/VDUC7XpCmOuuDDchXjbChBSPG/hca7SqD4=;
	b=FYzCsb4zOs3Vcokp1o5NuJQSKf56DiGtucb3jWnqk2B7blOuKWBAkRyrU4AtzR+oFG97
	 OIhVTl4u603GNODlYFrA9OFi9tHzu4/JNOvzxHe+pQLPH2t+UNvBsRHnBjPs9LK32Jk/g
	 shh6Ysz7ITubuFJxD3/hz92XdHAVYActsTgjJBf2shqGVwqcR2S53hUrntHNICNW0+yoL
	 gZr2S2SsNxO1GZhkIFVvt1hJMr05FIXU4Ta2MWK4I1dUg/QP7hxRy+4eCbKKRfBQqofEv
	 UWp7ThomQa5vyuxe6/EF/nPMLvrjHJAqCXPV2hvoaFFUCH3phtvMjL+ag7PZhGECB2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pxZkFGTE;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE0606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AE0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pxZkFGTE
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35f1f76ea84so4642884eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442327; x=1793047127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoFoVU0d/VDUC7XpCmOuuDDchXjbChBSPG/hca7SqD4=;
        b=pxZkFGTEdkW2OHtd6tylp4R6E+27j2izKk+KkBZk0UGJ8EUd4V7LdJz/ffCYuMULNn
         lc5jgY0HcFsvEh5gwl3IruWNfYfJPuy609YDwFXdD8fQAupxXHdb9+YCZw699/P9HF3n
         b4IoXxg0oNHdmmFSmE51d1DS0fXbI3mFzcNubIQgSKKuH+LHOnFPdi4kM36SfDPnm51D
         pkP7QaiXlITglb32eA1narXYtRagLfndrLwl0SMio5WIK9lg5EshrJh/crDXfSo+vRjb
         Sub1iP3Ja1SpgItkz+4FczeT73twae+areAZcacD39aS18hTqqdXivHWcMvtCaFHyQHt
         xZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442327; x=1793047127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JoFoVU0d/VDUC7XpCmOuuDDchXjbChBSPG/hca7SqD4=;
        b=QgL4tEuuBBuPOo87Asm7M+f3y3XMoyWpUDxqMyD/Gu47HwtL74hMsotFn5/T67ve6z
         jD3RZi3bMpP5hVn9Egm6ny19pRHVzs1XYDM58BMqsXYCFjgJFGENP2Wxdv8hiiN2UTFi
         UPQntoh0Zc8H+OqbTXIy0tIUd+RAMyRf4DJ4+a+ihJ/3byz461sfthI9RpmpHILJR7bw
         IEEwDokOAl6TkwGYUl2HmN4AhUzoTVP+se4/FZfFe9nO5uXmV10GS32nBsD0ZPdbM1FF
         TVB118MWKZkge4urf976SKUsXAlfLwG6uALuhx28M0FvGaKVPYj/ZAoE1jRFt6QEcR8u
         +lJw==
X-Gm-Message-State: AFq9FYIYEsdzjH1Hz+xnzQEcxysVGd4WXA6WuMN6G7pXogD/iu6+7x0V
	km63kp3tsiwE6wqj4woVNqo8jdj/RNgl0WmE1/bT0tUN2NCFAONgpe7Xty1wGw==
X-Gm-Gg: AYBFou1wHaFj7+wjFxmVf+y5NI1rq3wC2BJbFiX3ZmhYJtQddmWoqoVBkNE8CpCkwFt
	eGsiBeyTEQMIeRcZdOr9d+9FT5/+TawHwp+rqlnaG0z5LUz5XH93Bmd0vBrBRtuSi6p8y5dQxvf
	tFr+O2wh21T0RAY4Zwpq6GMGYBezf+0/dbBCVqxgo+nJA+OyGnCd6M21ndGEw3hySr3WGRvSpeb
	AcTGHAuVa4fmYjDc977+D8KDCGwNXKlKPG5X1FJAMA3pGaDOslAMHCyF0WV6mqNqjJZjSgLRI3X
	HPGUN6hpQH3gmIgtKpLyNov1loUS+E27iPr9hnxpGjk3IWedQR9hkFsz7h2aVRjrfonIph9ifuN
	l5OYA0ZHVDYnAmKhFNqtbOnrZYgVnnf/GGzsd7Wa0m7Oxs2qB19+485yDr/Pdch6TYpgdN4F2k+
	i3+oNpQTN7c1vzdns68HOksJyXVUp2dxF9wwNJ5n1eRg11cx1ZjCRzKf44lP51m+F/K/AMGfoCj
	q8T8g4ZAnQRB9JzYqb2q7vc4Bp56F4xUmuQZrS6bnP7s2j+T+sgJP/Yq7BOAnxk6ibNEJqrbZ/E
	bobPHfhB5v8AOFs7jdJGWwmGmQ==
X-Received: by 2002:a05:701b:2058:20b0:165:90af:a25f with SMTP id a92af1059eb24-18515a66a78mr13331298c88.41.1792442326962;
        Mon, 19 Oct 2026 13:38:46 -0700 (PDT)
Received: from l ([2603:8002:ea00:6800:7440:7d9b:b57c:b3ae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm35138806c88.4.2026.10.19.13.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:38:46 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2 v2 1/3] iplink_bond_slave: read ad_partner_oper_port_state as u16
Date: Mon, 19 Oct 2026 13:38:41 -0700
Message-ID: <20261019203843.3127235-2-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
References: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel sends IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE as a u16,
but ip reads it as a u8. On big endian that is the high byte, so the
partner state always prints as 0.

Fixes: 39ac2d2b802b ("iplink: bond: print lacp actor/partner oper states as strings")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 ip/iplink_bond_slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index f4b28fbc..24e73575 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -145,7 +145,7 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 	}
 
 	if (tb[IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE]) {
-		__u16 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE]);
+		__u16 state = rta_getattr_u16(tb[IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE]);
 
 		print_int(PRINT_ANY,
 			  "ad_partner_oper_port_state",
-- 
2.55.0

