Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45E4A68A5
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102022; cv=none; b=hUugFlfIc2yAEO6UqyN/YQY721mTP2v6KNBxqO8MkSjB0cpmJsJl6AlxQDsqW9ANPOVsuHMm8nleupXcTy1fYm8VQTXK3UzvB1w7Yiaer9Lek1hfxoI9NszaHIoPUlER8WQacNLJSOcZDgFVUjeRBT8ITs2Q+Eq3mJJwHJesokM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102022; c=relaxed/simple;
	bh=0TLXT0OQaGddhmq4Gd3x446wYMRH9OmcF0gTIv1Vmk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odcaFdTe6HV5kZYBGVVxJsAuHL0dv2Uo5JF7sNbAy6Z69xJVNi6oJWFO5GnHgbYfNb7UldnabfmBuhu8vsT2m/4ScfoSu/EyisHtY3a8Qrhx0iEp1/P6ivVyob1fbyhSZ633pHFz43C1iiOF1rFItTNcg5mssXrbr4OcY/qe5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=ZwkfPD34; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="ZwkfPD34"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso10171985eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792102020; x=1792706820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yH525jot8RHAGlZ1Vpz4ynWXS0sEFIDidEzQ+hLZKbM=;
        b=ZwkfPD346vkZ5WRHGaUeVjHus6L50fYMq30aPPyHQRMVXMoRqJ1re66Ps3BZTx6Gpw
         8yr76UhcdQLR3Pgi8FqMzbKB20DtBS7FEH/d1rPFNUh60wAxLJdIRlVXwQQvpBCb1rP3
         2FIPrlu/W7Ewc0Lfe3TjNB/9jr/8tTqhvk6KkBHLT2KlU9HG6RloTDdGXgi597LWzwks
         RCD+wCHrHDZ7pTPTq5qDIQquNyTLxARGHegaiW94fLeZzHFRytLb/VLCrYQQAru+bv95
         NjlGIlIlNP2hdzFh97db+0aKAYHDK5eE1oJo+fmukftVnMNyQ4uiXqEZIb7Pw5GNIQRG
         Glhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102020; x=1792706820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yH525jot8RHAGlZ1Vpz4ynWXS0sEFIDidEzQ+hLZKbM=;
        b=LVqUJFToHu8OJZ8CcX7RNZmRPPzmI1q2Vfo04TFwxFwPw6Cu8pSgZA/y9GLxPbA0GK
         WdwLVneGQ8Z34kG0aoahrrJd9BtbzNNoZ+dJW6P/YAF5WgS7jtsgEA4r47ao4oMD7Lva
         m6Gsfr9EANeYIrzDhtZEla/XieawL+KlEj1TmMxHJNq9x0zvibGoGLiaXlYGA0HMce/k
         YlK+HM0tWG3+ePDwDbOhGK9itMSEa2N+amY4LMxLHubT9DrrK/7a9dx2gTy3vB8Giz2L
         XaZ0GNp81NcRoRIYCEvdzWe1y5u7QiyfVM7uXqEF/WYbZI25TqXQZD+xBhUeW5Th1BqN
         ZhTA==
X-Gm-Message-State: AFq9FYIyPy7OsYsfMgDnF/CT4foybdAwv5SZhV28I+q8oSoydwNMBSzn
	J0N5vHtvG3tr4yy0sSPvy0ml8QlAJd9NctQe4N0s+66a0KlzxjBUJClECWl6zrUcTUQ=
X-Gm-Gg: AYBFou1XHASAgb2fUs0X3UZTWYQ76K1DP0bw8WmF7V3DAYMj32XcumXZGrS7/IrYuge
	esbtxUwQ/pXWPYSl5/enaQL3DNyBEXh5rmQcKqReqGQ+bOZmmohTMPf9hbvdvd3INPwiP6eZKt2
	8JUJBbAP31ZGa9zBOWPmfMgWxElcxkdY/iWiTlRlmAa9KcQTQFAI1eFfqgDlI4/+CIv57/Ehuqa
	DIpopAYkXm6OveiZ8rED9D8/Ej5I9EODLWn60dOW6dxovGluf5K/aSTCOSlRMUJtxqHUBdyvTAw
	V4R2LA/WjIMdXIopW9trnHEAHcTFjpV9SCS5FqjCCuuuS10vldQCy37s8MiLpSFDdNQKuYil6Fj
	N5AjL7aPTYy04uTWFrUpZA9l4dIm8MU+eOuhcV8vq/QxQvP5erUE0J8loW2T2etRcd6gfaJB3az
	hO2rASXygeWQQPIICRWgFFJ9AVeDPCzDuSCZC5gg3B0p/MGYlV/3EjDJ3F9G0teU7M85xMvM8Re
	2IXLBGLU0IPOxnphFJK/vKgCW17w/s8cPq9Yl0j
X-Received: by 2002:a05:7301:298:b0:358:bbb7:88da with SMTP id 5a478bee46e88-358bbb793e2mr23668153eec.32.1792102020397;
        Thu, 15 Oct 2026 15:07:00 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm1016445eec.3.2026.10.15.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 15:06:58 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 3/5] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Thu, 15 Oct 2026 22:06:46 +0000
Message-ID: <20261015220648.1545576-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015220648.1545576-1-omar@blockcast.net>
References: <20261015220648.1545576-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netlink policy for IFLA_AMT_LOCAL_IP and IFLA_AMT_DISCOVERY_IP is an
untyped entry with .len set to the size of an IPv4 address, which netlink
validation treats as a minimum length only.  Any longer payload passes,
and nla_get_in_addr() then reads just its first four bytes: an iproute2
that puts a 16-byte IPv6 literal in one of these IPv4 attributes turns
"2001:db8::" into 32.1.13.184, and the device is created with an address
the user never asked for.

Use NLA_POLICY_EXACT_LEN(sizeof(__be32)) for both, so every payload that
is not exactly four bytes long is refused with a standard extack instead
of being truncated.  The range check this expands to fails the attribute
even under the liberal parsing rtnetlink applies to IFLA_INFO_DATA.
amt_get_size() and amt_fill_info() already emit exactly four bytes for
these attributes.  IFLA_AMT_REMOTE_IP is only ever reported, never read
from a request, so it is left unchanged.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 2e0d3aa..470dbbd 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3230,9 +3230,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_RELAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_GATEWAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_LINK]		= { .type = NLA_U32 },
-	[IFLA_AMT_LOCAL_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_LOCAL_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_REMOTE_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
-	[IFLA_AMT_DISCOVERY_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_DISCOVERY_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
 };
 
-- 
2.43.0

