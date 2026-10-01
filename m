Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE034CFDE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887758; cv=none; b=nH6eMToGuXBIjjRYGxlXJoixdl8rwH+LLnQc4dredjctp9wd86v/SoCsuvjyUWMKA6IeDhVzds6Rr3kd1jPkHN0hdgYwr1a8SYY9joh8jJMDjAIyrW79AABjgBkxXb9SXg6CtdPgMMBjZ2/18Z3jxfYCC6SaxV3XDEn06oSR3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887758; c=relaxed/simple;
	bh=0XJw1AkribrZprw43sRQovMIMAVF9isNAWHN5pVcvNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9ZRLYnEDQichVAuS7uMY7uZgCInkwDP/df8vy9UUif/j9fFvcFPumpTtlMTFprQPCW0TDfwzLCosoQ//kjZI61VqTG6Q//reia6vN/PIkWeIRJWOQu+KNDxUl8JBPM/Xy0szbltGtqXU4KxDV9LCchc/HFQBIFrhdSg2lJE2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sw+nWo3M; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sw+nWo3M"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so4677944a91.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790887754; x=1791492554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oksDFv5EfYGEzZP3EAnPpafltHufUup7laAhvHxqCig=;
        b=sw+nWo3M/cIrjV92bvy8Y8e35lEWm8zXZfM3ejYIOZMv4yktFafNutH9eIO1GnHnSo
         DOUORH+sk3+4nKGggTUKLYGueM3Ee/Q3pZfNdIRqaY+enYQrsL7kwW+G8vOx828jLU3j
         wADIOqbU7kJfuXh9g1UI2KD9OmfvRJTMYJl5m1Xrh0BLd0QN3n53T/DjdVIafrdzQjQf
         CeQoCh6z16Nc4J+SpRT9KXrrxo8zL5wYsC0cXc/0RtIibDUn1B0lJUC0YyhisGTeEPs4
         2M0PxV3eoUn9GHquiR3inREiqngNZqLiCz3/EgXwBwNXVKDal+6+ONrGo+mR045MDOl2
         giGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887754; x=1791492554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oksDFv5EfYGEzZP3EAnPpafltHufUup7laAhvHxqCig=;
        b=LR1kLz1aq7m4UqoAn4Mbd6XKuikQPXLG/ik0t2bJQgApFIRpc/65vuZ3YYOqpl4uDb
         D3cnEs/T6ctohKwT9iCNs+i/B+WGp97TYxPMZMrmbinC/ZBLdPotSg+uGzMxGGucWYJc
         PczNqfp3oVJ2iuhrw/fMIOmCc/HyfOmaMouauV7xuynP4oaxopVSx+alWMmVW9egYjZc
         L/VVg7naZyh/wZI7dJTbcCXYmCar6SxPqujYFpnH7rDDxpKipemtolRO0/5NLbEohllp
         2zpX9WQjV2wc5yLKIgsHlOQM+5sdq6UEq1v2g68dVVO680aV9FC2AKyOW//8WJWFaWin
         2LFQ==
X-Gm-Message-State: AFq9FYKO2AaDf0WUqblT+Sz3QA2WqPHMg1+IyGtG03BMObNci/wOugBr
	qn7YWWmRgg2LtOSBsQyRWJeo7QubxgrWPSJl1SrWI3hT1vGO+2ZsOO4VUBeOBhnb
X-Gm-Gg: AYBFou2WK6PiqZ331pZkN1Ff+Wq1XV90eoy5UIM2N6rAYZEcyG00ptZFPntl/lvbPlY
	D4CTcxLFdlbFDwEZbwMmUon3M8uWpn5yowvZsWksb2+PrheOynYHy+uvnj6+ppUHHsaMwP8Or1j
	NO4/KIpJtHkBWOXRb8GxjuQIZ2PFIIMyfHDlKfom4gIT+T+Scd0+I9OXE6SJ3BuEuUex+Zkgsiy
	ivM8PwhvrXjsphYIDoDOIlbE/XjFgvVM9lAVJwASs0tOeOJwMcZ/VNY4pZBNoadammiHVgq252H
	YfcwcKtU9mA8RBZUzEX7VR00pDYZmjx/sawSxe+MHm1tZs8VcMzzT/kGfB99NAh4HRFR9RY25wB
	TIUc3qR4+QRd55LGGEf8GPiD14zRoIdH1qm6MmAQrSJn8Ti9xrm1nKLUTEWPry+oH6cRGhFGckb
	2IAePSANtOfJU0TxNOL9TbIlxRwjBWaIO/82h1WQ3Vl1IlGl1B4dOmZB8NTbWYLMbBGmYONvLQl
	KV53YRprIlLZpGEFRUpvwpmgg==
X-Received: by 2002:a17:90b:1642:b0:3a4:a1f1:fea4 with SMTP id 98e67ed59e1d1-3a6ce761d36mr625284a91.26.1790887753935;
        Thu, 01 Oct 2026 13:49:13 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661e:3050::4d0:26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e9c6sm5658797a91.14.2026.10.01.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:49:12 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/5] net: dsa: motorcomm: Use NSEC_PER_SEC
Date: Fri,  2 Oct 2026 04:48:46 +0800
Message-ID: <20261001204851.2576101-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001204851.2576101-1-mmyangfl@gmail.com>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of magic numbers.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 84abc2ef8b61..0e5f19a39d0c 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -25,14 +25,14 @@ static u32 rate2token(u64 rate, unsigned int slot_ns, int unit, int C)
 {
 	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
 
-	return div_u64(ldexpu64(slot_ns * rate, -e), 1000000000);
+	return div_u64(ldexpu64(slot_ns * rate, -e), NSEC_PER_SEC);
 }
 
 static u64 token2rate(u32 token, unsigned int slot_ns, int unit, int C)
 {
 	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
 
-	return div_u64(ldexpu64(mul_u32_u32(1000000000, token), e), slot_ns);
+	return div_u64(ldexpu64(mul_u32_u32(NSEC_PER_SEC, token), e), slot_ns);
 }
 
 /* burst = 2^C * token * 4^unit */
@@ -83,7 +83,7 @@ yt921x_marker_tfm(struct yt921x_marker *marker, u64 rate, u64 burst,
 	}
 
 	/* Check for matching burst */
-	burst_est = div_u64(slot_ns * rate, 1000000000);
+	burst_est = div_u64(slot_ns * rate, NSEC_PER_SEC);
 	burst_sug = burst_est;
 	if (flags & YT921X_MARKER_PKT_MODE)
 		burst_sug++;
-- 
2.53.0

