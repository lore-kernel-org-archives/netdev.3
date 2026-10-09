Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C144F4D0E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576904; cv=none; b=eiCIgGHMt5tz+z+D48Jtj4YFYLQMu8PuhtNpKijAttnX8BaxeuxGdccJqgvqU5kYWLW1o2PVerPgjr3FplyJ2ep9gRl4Vem6VYe4rkqx78j/5AedfEOEM1izZY2EYyBErosp+6Z5crIb5+t+BIziBxcxVqsYa1XIuyYGOimJjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576904; c=relaxed/simple;
	bh=kNBf+ftP2Tqguds+Mgj0EosLQnLqkOf8LbI3dUWJaUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq8R7mO540aLSt8yC0rK4+R1ajxBRtiTOSVAsIFchUpMdjTY1lq55G3guR760tkTTklfHAHGj4Z/rwUQP3mef+QKL8Sa4kIHsqmw/JJGzuuJAiHZe1xNmKRw5qcL9ClkLcQGK9cQpd5PT3jwpAjxZZxhAN9nO7+4YFEkOD0aYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=rIDPfw3J; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="rIDPfw3J"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so221804eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791576902; x=1792181702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T66HUfdZ8C06QFjZdP+bRAcI+QSu4rBnjpUxu2GeV9U=;
        b=rIDPfw3J4AqoaErlK+QzDX9Ke61r6vfXdjIcEnByXjAlZmePKPMYj9yZikzCgy3xvU
         Y7AuNXcGzSm/U3OP1AeXPjRFqlzSKJYErXlYi9Ea74+gw9mkgwrbGuQnvOsZ8Uf9dmkd
         eeYhcCW1cd5MZzMC2nNMPia5cs0XCbvRB0QHRw1NvBTR0wq/VDT2us3ZURsq5K2NSJaI
         sKEiC/90KGgyXIOuaMfS701dEBGF8IY7UAWKE7OCZDSBUEI8Z/+mmwLyxAJ9snqJBwum
         M+7aczzBESffeneQHziwe2wkPSuHRFqkv59spbD+uh+oANDinj1UAX7REyWk03Vo/coQ
         XU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576902; x=1792181702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T66HUfdZ8C06QFjZdP+bRAcI+QSu4rBnjpUxu2GeV9U=;
        b=1CKIG6jfxW5ipEv0J3RQgl/1BCtUIibrMBJb6hvLqd/p5tSAxEtvfi82HA2Wy5ITZE
         qBFzdj3rHC44Za4gvvnKcTO+MzBV3Xycp2DvfRGGArMLiWg0FaapW7G2/8uwIgWPFqxx
         wk8bD7edHnMoEpt8Mg6JdfoDkwBDeY0gB3iVZ+jCykNEVV7M9QCvbiQN/RH0EpxzeCSt
         stMxFuEshjMHhEpIHh6uHe2wzAdAlTE8/dUtu1WJZx7+M22xoZzs+Pt1dZE1v80A6FzB
         UIaZ8wPq6oIjwNVh12/zV1vR8898mSijuSbkmFq8mhn8HORwushse+OmpVipPMWNjd7C
         CMkw==
X-Gm-Message-State: AFq9FYIY4gaCtAKgbzADXVvXdkPKDDTOx9pStg3Gia1cf/GFBQu0unoL
	a+sp7vhpWQFruLSqE1g8IDvkmD1482Ilkr93dd0+JT1aH2VgkXpMz/owo6bXlMHUJXs=
X-Gm-Gg: AYBFou0t72498KADZws9mxVvkRN2NX1bJ1lExy+oWWr3vDuIjDVVzrrJ5D2CkGUmyDJ
	PiL0/ng/wKHHCcJjXrAyT6awM+giNFDwMKMkQgo4c+hpx9Q0yQsexr1lvLVsOGJcNvDUoAZNpDu
	/fqi+PmfJp9mZV+8PquxN7W3K2vdseUiokkaFwO2VrnjTDfcfgmUGo8qckld1m1OlIp5WVc0Uij
	whkYgg0O455D9LHmmnibOPM1ZuV+an4KU/Gp8ie302lTJmUTdxXXVswAQaiOXKtDlVJjownjiC0
	8OXFucPAsi6AE8YOSuYlGLEOLf175FL2BtC72cQ5VY2CABpJ30t6xHwDQ4/IOGYp5fTgsldNMwe
	dNlZYfnd8L+NLz4OtDtRC2ccEWlhkOrHwWCfXMiztiBv1mQE2OaGdgbvIe84dAwPhu8Gb3uTZKB
	jERBbLG2Ee/ko5taoFRjQP8bHkL/5GUMfmBWYPD5glHEdsD//cKaJuphfZY/tMLe2MjTcgegqyE
	2stGCLY0D/r5el3U9xI45YvQDBBaZEItvhPyE4glpCOkh4b6B8=
X-Received: by 2002:a05:693c:41cb:10b0:351:679e:ba2a with SMTP id 5a478bee46e88-3537e0065cemr4039475eec.23.1791576901810;
        Fri, 09 Oct 2026 13:15:01 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm8994643eec.5.2026.10.09.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:15:00 -0700 (PDT)
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
Subject: [PATCH net v2 2/3] amt: make pre-query report drops visible
Date: Fri,  9 Oct 2026 20:14:53 +0000
Message-ID: <20261009201455.1904698-3-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009201455.1904698-1-omar@blockcast.net>
References: <20261009201455.1904698-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family. The query supplies the nonce and
interval echoed by the Membership Update, so dropping an early report is
required, but doing so silently leaves operators with a dark multicast path
and no indication why the join never happened.

Emit a family-specific debug message before taking the existing drop path.
That path already increments tx_dropped, so each discarded report is
accounted exactly once.

Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index ed82f8fac3f..492d450fdb5 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1249,9 +1249,17 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Gateway only passes IGMP/MLD packets */
 		if (!report)
 			goto free;
+		/* A validated report can only be forwarded after the relay's
+		 * family-specific Membership Query supplies the state echoed
+		 * by the Membership Update. Log this readiness failure before
+		 * the shared drop path accounts it.
+		 */
 		if ((!v6 && !READ_ONCE(amt->ready4)) ||
-		    (v6 && !READ_ONCE(amt->ready6)))
+		    (v6 && !READ_ONCE(amt->ready6))) {
+			netdev_dbg(dev, "drop %s report: no Membership Query for this family yet\n",
+				   v6 ? "MLD" : "IGMP");
 			goto free;
+		}
 		if (amt_send_membership_update(amt, skb,  v6))
 			goto free;
 		goto unlock;
-- 
2.47.3

