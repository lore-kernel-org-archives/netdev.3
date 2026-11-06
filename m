Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950732;
	b=aVc09DZNUWK06otRfW68HQuJVD8uEH2rPXeExu/Q8yd1LaIPx9RogRyRHnj1qFKH3kEB
	 POE2KzJUlTl/xwUluO2zT9ZbaKfuiEU+URY+R/1m/yykq5H97eDdAItijTKX+y5UiClvC
	 3Z5wBg4EODOoTUeeGWbddS0aFlEhGmrV6SyLY5waOCQX8Zvl2szzCSJOO6FaxwNITeeiT
	 axm/c51XHqKmweik4mL0mtD8JyMXomkYdINxIT/NxSjajKRVdEhaWEDrnJD9xXIt6v0zp
	 2SlJmG1TxMK/mceOQmQvw0p8IYfC5diXlM3vcGtfgRCViOS7CTy6q7TM2bpwnFqzbqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jHE3vz7ikpP7qewD4PpZ2JFR+MDb2MgvZURmQJe0rMo=;
	b=XQLp3YC3ZLiqkW6OLkPshvkm/loTAsgx0yDJGMTB+ZTPVmldROdW45PJekZDDRCS5ql+
	 YZKsuwyUl13UACgQS200hKdt3n5Q3mSFdjE5+qNtNaFlpMOb/HcOnRN5vRX7+d+cBh4CC
	 C65RRxuRtH3Yt5YKUN2ER5HblMHY7opY6fo55R0oD6ejtB1mbz5WVqWnAHx1X+EqFAe7z
	 VdWa/MzWTWAocx3v9Xp6RUSw5/Zdd5yVgmo/0+L1AnEZdw+WljVDth8x+TyoUVzwXXj9A
	 u9GZfDNrAZO3tzc9AHUxQDsFM1X7HqHNLUadG59sV05ufNJbNckabJAdH0rkSivbYYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NlNe/frr";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CA606A330
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E75CA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NlNe/frr
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so223356b3a.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 23:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793950731; x=1794555531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jHE3vz7ikpP7qewD4PpZ2JFR+MDb2MgvZURmQJe0rMo=;
        b=NlNe/frrtlcja4ikQ6zCLaiq3LV/AVqKJVisxf8JrVlcEse+/QA0BrfzW2o7FLuIau
         5S+l9WISDC/r0FT+E9KasPbxy3ZN6MeHSdva5bkibt/ezw0h+PwEjCvtiC0A3x2X6Uij
         GvZefyQciriMPFvB+hirOSwBXIkFeyE+LqyvUgObE2fMSrPNyBRxkHDxGEbk4/+KitrX
         X5oQ/X3XScvH0ioGiQ5QPSF+71Oy8b0ce9HpQ9o+KzcNdZYyoW/IdJK6OKYli3zXKrso
         K7hpoTYx9S1XlCSwtq83nsMBU5ZVW/lseEUm+6k3L4SXxetZe6dyBasQdbinso7qJrJr
         QEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950731; x=1794555531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jHE3vz7ikpP7qewD4PpZ2JFR+MDb2MgvZURmQJe0rMo=;
        b=I3q1gO75lfDLwaIkX7+UoxKwun2LlWP4HHPsCzX5pOyZd0bynckpOVbH06ImJNG7UV
         RcCZOQ5VKr4XZQWgUc0zgDYuSc+sNlbAdPZc9L9d/bcmYHjfIRdrgDMjsjLrF8p+WN58
         becc0v0JHr0HR/ZO6XYRVfFTn22FqAMgOyiYDlV4wPMBAMRnhDCpQ3LaRkgxVPIm+HC1
         uLV83EfrBy7w9Kh505CAXZk/9rC4bNGFeUY/acLil02pAu9xmSDiXZZ/mUHbYhOF98HH
         U8602TeH0dtih1BD8ymjN0xZqHY5E8/X9lx2+7B/3c+W/4DTTfyKpgpQkPw2o4+77kti
         2PEg==
X-Gm-Message-State: APuU4Z8jm48yf6PnOaxNvx2wtwJ6IaaKYjRQ4xhvXTGCK+xiWg5L6NHz
	wUPxzoTTNdijCo39pA4epCZrfi4o10O50X9Of0H6eVq/vcQA28ijGfb1XCdNmP92
X-Gm-Gg: AYBFou3X85Dd5JAZKN2NZNdBYbAiywsEQwftgUAwmpN6F01zT5afghfI0Xq3prRsVaW
	zdot6dJjrQrKnURAeNNhYLRJe26CYpYWNc+cCGgSrQDdW0hO3c2ToGFma/8/2aE1HsmCdKWrr2s
	joWopP0yGLDaUn90CDWZm/HD3yzW9TYJsrfpmOyu7D6MVYKIzoaOUBCegawp50f6yzelSWrd13z
	3JXFcrfHvqIzTs1EGlro3urHksXZniE0c99bWJROyuA1+zQ7Y2k/D97ikFIU32aHu/38MUMW/Jq
	Mvv5k5SL5Y4hvCaZXQxqzg6v68mFjvM73F6gdjAasNWz+j/HffPpTFxHCSw4IIDtW+9JfL4fgIV
	LA1vNTPEifJAYPNlKQ8PPpAz1zA126kTw2TEHovnjhhKaPA5ND0OANdwJSMtyqlEsxSB3IqnKx2
	NIf/WIZdky4CuyIdM/AAoS7gWNpbmco3X3je4YhiYgzxqnaeQqIMZ/0yWoYkB9zTBDs9In+Tkc1
	odU0Gfw6gek7IzpXHE9rcK+Dz5VRdXAWA8ZnFJJxg5dU4IFqjNYnWQpiHN1hJ9GD0oTAF2/Ns4U
	ViAc5Oc8BH9fYTm9bJVuKr4Fye6IaqrvTh60TD9pB1JrxASYf3RrZGB86OvWm5r2NiXdpAiJ6w=
	=
X-Received: by 2002:a05:6a00:10d1:b0:89a:19ae:10e9 with SMTP id d2e1a72fcca58-8b37bc58291mr1552546b3a.38.1793950731077;
        Thu, 05 Nov 2026 23:38:51 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597efd53sm373484b3a.23.2026.11.05.23.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 23:38:50 -0800 (PST)
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
Subject: [PATCH net v3 1/3] net: dsa: motorcomm: Fix extack message on unsupported TC actions
Date: Fri,  6 Nov 2026 15:38:00 +0800
Message-ID: <20261106073806.112122-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106073806.112122-1-mmyangfl@gmail.com>
References: <20261106073806.112122-1-mmyangfl@gmail.com>
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

No extack reasons were given to unsupported TC actions. Set a reason on
the default path before falling back, and drop the now-redundant
initializer of `reason`, so the compiler warns on any future path that
uses it without assigning one.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 9dbd61e48fee..90b017a11a1b 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1034,8 +1034,8 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 	const struct flow_action_entry *act;
 	u32 *action = ruleext->r.action;
 	bool seen_priority = false;
-	const char *reason = NULL;
 	bool seen_police = false;
+	const char *reason;
 	unsigned int i;
 	int res;
 
@@ -1122,6 +1122,7 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 			break;
 		}
 		default:
+			reason = "Unsupported by HW";
 fallback:
 			if (cls->common.skip_sw) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-- 
2.53.0

