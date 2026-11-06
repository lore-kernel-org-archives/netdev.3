Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955789;
	b=Pqnk6O8+gfLw7QR0Te5CXZD9JYRlUQTF9ZL+DWFKOtJwF6n/wGOz8/0PvQjvFOOKSKnW
	 +D/9sdcvDjJvElq3I/YvPfjtpXVDESFKLxDikfkEoEzGwURJaZJgV/vbtIyFc0eCyj3tO
	 QfrvsBvCCbXVC9grwqu2JI5zvnoWu+l50za9uN97w/IIfnSQI7qbhMhvqUpxxDX5EKkcy
	 Sl+Qv9rWQQeI8KBtOTXtEB/mk+MIh7YjuXV0GiXthQAnk4yzvMm9pJNJgJmtN2XnfX2X8
	 SCJNFbXhhDgtvOye25coPdvVnVT2pOocKV45mK9g8NoO8TLTkefGXQAEPqsEj6+GKAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EXNC/yEXHIj1HlxQV7csoTqtdlBlzm5qOJ21PtIjgSk=;
	b=YAmC8d7QQN41WktvMZ/aOaAtEarxW2e7HKgVOEentZsITMw5HDxbQgDRUgEO53eu9Fg0
	 Hf6SrHnJa5QStZHN40KeIsoLBhxRmDp+qyptlWRVJJbbbd/dGaz1sdLmEzNUEtY/Z5CxZ
	 ME5ZuWqsK1xIPayloZaqCvLyLtwaTw7U99+5nr55FWjXIpwwIYH71NWXsAexsAaqQA0a0
	 McYvdBmloL9GzKX3QhAqok+fvrqEc9AMwa/V9UDONXH30cJdnbU4a3RiFs5U7ByHprml6
	 iuxGX6hAECx6iro28tNeArIv5TZnlOjX2MNZ3GYXrZETAGYGOyA7yQdLQojH6ynPCnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBg0U11K;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501D606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7501D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBg0U11K
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso1970145ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793955789; x=1794560589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXNC/yEXHIj1HlxQV7csoTqtdlBlzm5qOJ21PtIjgSk=;
        b=gBg0U11KTiX0N3F9mHlO7Z/+qgqmr81SkqtKHSUci8lydqxQxZfDEAgszA4UqQcKog
         wruQgI9lRtXHI5eZPgacD+VzcFYUa6+tQHnjnpr9akreRu92jFXt6v/PC0K0kFyj3teb
         b+eb7THPSqAhTIsicdF03t9VzylSf5d3Q7m1QNTEwcc2/vs5gqsHihszh+5LZvXv591/
         muV2FkG9eLe3zs+Qz1nDBpy8cN2tJm0fK8tUt6iKUzJbipm22ajzuTdHby0M8vFNif0p
         jvj+0Pgks/rdzJMkpgKa0sCOnsJJEKETt/StjH5kV5sw4p3xpig0x+k1IcQxWkPE9M24
         eOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793955789; x=1794560589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXNC/yEXHIj1HlxQV7csoTqtdlBlzm5qOJ21PtIjgSk=;
        b=lqFjLhK6M1lL1ccRzKokmT9p5fWjSerNpr4F/FDNuyIo36lZvEoSnZ4zup0i394RKT
         vqdNCpRK5sH56S8pk/XdyfklNf2FryVuxXlcK3aw2WOxJtkKgKAVGDiwtRILvExV82Cw
         12rMJLPIc7gmaurw1ovZY3E2VpAI2rFaGYTHIdbAYFG0dtL50F1zik7jWZLTu/Ky4YhV
         20oD5Hq8DGyzKK7roq1KCXq9NGz6k4Ao2awva57rS6gK+P00+lvcW8sRrLvrb4aOrkiI
         a+LLU/jhBbgbQ7n8ykgE2OXNp6WvdhCkvXDFaP1CEv5m5TDXUArdwlZ7OZWxJfBnkDFR
         fyQw==
X-Forwarded-Encrypted: i=1; AL+hErF33mb/W3ugW6dVkt0JZyOfjB7PsZ4xhmI1CxZH7zic6Ix55MAtIkKlFYU+H0QCp+8Hc0lgwbM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FjtH3zOFUaSSPuKp/18kO/rz57JBzC+KjGp54jopPV1kenhPu
	jyMBVX7Xc1O7hhdum478JQ0dUi5oW5dalKyBwd3vKPcYF+hPCJjPab0h
X-Gm-Gg: AYBFou2stiXQmghwAOVoXVsTtx7dN4h977fCpmYVN9GIs4fxwMyp2G9aP3KulrTuuNU
	32Q3OHpyTLkA+NnShjUWo3RL5So6eD9r2lte/Cnfam07MZvsxvsKV6wWh7VmoZnmLWxh/06KKlI
	qYrpDXB0VeBNL+/aWcL3VVaskZS8c1i/DmEzIQX+hRv7Ar+xJRkrbtJgIKzC6UB4mTWM8r1ujPZ
	JuFNMtESHqSGNcBNlGc+Xu/XiEvxN8Jc3PIIvuLU0VlEr1VSTFAneWHZ5C95mIeui3xQy/b+0Y9
	mMUjRDuonBeuPuDebIH9ukvI7sIFT1vzYwv3GpicN9B2lENANuy4QqSuXhrlziAI/P+VSINfi10
	a/dPKfaj8rsuzRVUJlhPYefR5T1A0vxY9PTsHhTGWEWt/Ft6+QYz/EWYHghsLho3Ba+7QWAxOIv
	HBrtFiyTwOjLXLf+0sPZWlv/K6Fw57b8H9yH85sVXgcVeWDFMgcM43QPxn+5IvoVP57y9aYiVa8
	noKy5CWIh2A3CHdEFzI2zt/2gEcvg8jxCaujG/zoIRpHYA4F78dDBhGEqEGFSqYDL979LcfscwR
	buq3oJVygu/eqJkIDzzR3LIIsR2rEOt702gyKb4mFSxIvE6my2qdH+9JJxUfJOhGOFklqvWiVtV
	G5hgr2PKn08Y/pA==
X-Received: by 2002:a17:902:d507:b0:2e4:4eed:5cc5 with SMTP id d9443c01a7336-2ed40c56037mr25613185ad.38.1793955788271;
        Fri, 06 Nov 2026 01:03:08 -0800 (PST)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d409acsm3435745ad.39.2026.11.06.01.03.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 01:03:07 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shinta.sugimoto@ericsson.com,
	yoshfuji@linux-ipv6.org,
	nakam@linux-ipv6.org,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] xfrm: delete migrated old states before dropping their references
Date: Fri,  6 Nov 2026 17:02:56 +0800
Message-ID: <20261106090300.29203-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
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

From: Jun Yang <junvyyang@tencent.com>

xfrm_migrate_state_find() returns a referenced old state, but
xfrm_migrate() drops the references in x_cur[] before deleting those
states. If an expiry timer or another concurrent deletion has already
removed a state from the table, the put can release its last reference,
leaving xfrm_state_delete() to access a freed state.

Delete the old states before dropping their lookup references, so they
remain alive throughout xfrm_states_delete().

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9ea60c7717ff..5d818c1ec9e4 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4722,8 +4722,8 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 
 	/* Stage 4 - delete old state(s) */
 	if (nx_cur) {
-		xfrm_states_put(x_cur, nx_cur);
 		xfrm_states_delete(x_cur, nx_cur);
+		xfrm_states_put(x_cur, nx_cur);
 	}
 
 	/* Stage 5 - announce */
-- 
2.43.7

