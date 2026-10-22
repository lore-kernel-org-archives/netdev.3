Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694887;
	b=dmGlypd5/4H0XdZqH5S7W77OXYDoPFzxY7hdQjKGmuMk9CyaT9clRXTvHyI8y4i9fIBI
	 AHSyX3Jvw6pG896vheXw3qq7Ikb550SRzFBdxj1ySgUYc0cDnesvFLS0WHlhieou9sEP+
	 HxGXefZL1iGECo9DKLbTq1UigdXXLksPup7YCj8YKvns6+qZrAYHbM4Io3Deq+Y7JIW43
	 StH+eM0a9v6H3O20OpqZ7BsXFwR9ScfTsgcjnz8sz/qS6Uv1Z6Jtlig4cLWJheF33Aiws
	 uU8fQQ/Trw3j4KbhV535rxxoGbOlqSJrNVgLt1plj1hIMPiZKOndEfmpUT3goV2jcQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/i7oA0ZbhJvFpmRCZyySA3uGusRVwEcLuRTZir6rLz4=;
	b=vOQLmiujIffBPyXt+DoDuqKFKkjeRyIHdF8FFHWFRx3lke4sv6zVAST1u20WqjYmo9Xe
	 gqV4PFirD4XpY/udRL2zz8w515P3tj79OvmcbZZuFQBEd7gEyflGJq3LRwrdUutt7aucy
	 vvQ7wIsqkYQmxIegqzzmJ7c3HOzGrPqJTL9S1XF+IHLKyHdTnIjZRLkRh27ctUN1hZMex
	 GXU+PSPu0rH+AKtxYY1aGh3h8X9CwD6E49fgfntNVX7z88Ya6fhXoiR+x6gz231oOT0n0
	 CauuoKZe0fo4AvZ45DmaUvLYAbIR50vgOl3+V6042s2fwRafrbTPdmT45Ig6Fm4ZZ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=hkOV4dY0;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1A606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A1A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=hkOV4dY0
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e831e86ebfso320745ad.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792694886; x=1793299686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/i7oA0ZbhJvFpmRCZyySA3uGusRVwEcLuRTZir6rLz4=;
        b=hkOV4dY0tuSp8pNz6i5ASX2dsqej5gCpp2O7NJ2RvI9m3LU0aYd2BSU3uXCtfr9VCf
         6aS6rQqLzq9fGF+YOSR5oRXO/14ghmIsFwwvxIzwMhTlWrcKe6ceNAqg2k/p+5JDqN+2
         DdYBDaQtB9A4Br93HYwguLeweMmsKsTq9H00UpFV0cjk0AfoBfCw+RdBRTvPIAtWxmkJ
         QlfrzgSo/0o4YGn1FYCwv2en7Ju4XKHWm0K1Tp+rxbUePUXNMF2ygGRhAXfVIqZ4h9xX
         SKH9eDw26Tk3XbF7D5SH3fFRj3VX7Wli1pddMc1WxrvvuW9aG0Kxkbei6qA/mxDQA7vg
         cexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694886; x=1793299686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/i7oA0ZbhJvFpmRCZyySA3uGusRVwEcLuRTZir6rLz4=;
        b=eLegyZuQNdgEPXNT/QuTOzaOwq36q0bUmf6Z1z+j+T/pu9ZY9qsD3jv2jKjmSNqNF/
         Iaz/tGII+3CxFC8VWapPFWfIQj6jyTKmXL/aU/XDcAsaN/Vl52Kxef3/g3qncCKeCYPk
         9x0XK0fO/YDH3/cYAW5sfqYxKqpwvS5twwLDywsgYEr2UwfChtayrVEB5BWHCXn9HqDN
         1drF1wp2YozwDErlHPzWObRIq/HH8ZEoRV0/HlbGwfMPavSyWyUDNCwe0nG1udPqhW4d
         qEOtZ7GF9jQ56uW9mMlQygf7vpfqDcsrW58ieQx7Tw3pb1k5A8BFTmCnal0EBbMgfulM
         CN6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxEi0TK5vjLFqnGtd1xo6XIjdhNTP6hOfn59quZy/jLVwZ5jyaJbQy4kDM3II4EFqJmUrP+f48=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwZK4Mu3/3/hdvjEi6dt4Yz0axN8sxlmEk7zFReU5sxz36rksz
	y/jJoWcjFaAc7t14Rko8IHF3EQptn3qPCruWRkEYpc0z3pTMNo5T4FUpYpOEmNcdYAV8
X-Gm-Gg: AYBFou2RUwUGy6qsuGS2mdsCRwUF8pZ0CfEzZN5PWekR+V+pru55ccXAf8JEc0EO3O/
	Kt+zSsJYqslOUPvjOx1CATh83tUOnRCbhRPrrr89IM4BCYhq7IDbLTXsMq8pmmBPAnvJoSX059Y
	L7XahrmJkq9Mjj4DZ+BuIXfIYGW5SuZOddhG9dq7YSm4OoyLHRpXop5Pyd15FW7FXVfXup1roiK
	I9++Y8Ui84p8vjJT7HavwcyijDnGZMqptPPb79Sv3GEeJ0+wU0Dk5P1lXeAdyUeF67jojIUwO+B
	EANlj0gW+wiQf8a4ZlTNwypCGCCNty2T3dxcwa49G1OdhIk8iObNmLjtNsLqfanEndsafc8zSl+
	oIgwTwRHKjHERVcEXYLMP3pym+n+r96ZroRbwkwR9+6tLc3Tov1Q/4U0CYWJ5Jv9B6Fj870f6Gv
	gf55+9tpIyWepJreLZ1BlAkgd5FaJtsMXgdhoDrHWfCY6XjPjZvYvTMXbzNZ+zVVmpUpc7H3AE5
	t+l3vTvM4EMAQLTQM5aJWaIcVSkQLFO7eSfgxUAz9vLd30/5fZvdtwZlfr9k1GvE12D
X-Received: by 2002:a17:903:288:b0:2e9:723a:cf41 with SMTP id d9443c01a7336-2ea7d0ca8famr1103565ad.15.1792694886383;
        Thu, 22 Oct 2026 11:48:06 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:ffab:2834:5ac2:f726:a005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b3b01a6sm2052405ad.44.2026.10.22.11.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:48:05 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] rxrpc: fix null-security challenge leak
Date: Fri, 23 Oct 2026 02:47:46 +0800
Message-ID: <fddc48d58ac6f1fe0c8a71d3ab4d7ecd214b24ae.1792694708.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792694708.git.zhilinz@nebusec.ai>
References: <cover.1792694708.git.zhilinz@nebusec.ai>
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

none_validate_challenge() aborts a null-security connection but returns
true. rxrpc_input_conn_packet() then queues the CHALLENGE and takes an
extra connection reference. When the connection worker handles the
packet, rxrpc_process_event() sees the aborted state and returns before
releasing that reference.

Return false after aborting the connection so the CHALLENGE is not
queued and the extra reference is not taken.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/rxrpc/insecure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 0b39046bdc616..48e5db748ade2 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -44,7 +44,7 @@ static bool none_validate_challenge(struct rxrpc_connection *conn,
 {
 	rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
 			 rxrpc_eproto_rxnull_challenge);
-	return true;
+	return false;
 }
 
 static int none_sendmsg_respond_to_challenge(struct sk_buff *challenge,
-- 
2.55.0

