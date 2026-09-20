Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C513ED11D
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789904997; cv=none; b=NaQuwd6PWQY3149HyEn5tYa7NAO84+LqOFD2FQLyx76lFUgr18z2nezMCm8xYmzEkis7tzvVLQxi/1Xji1+t55CjmB2NnjHgGQyntSPgBS1TLxg8dK1/pHHDPVjOPOwq74pDjbaUetM+w3AIwEf+YpkJtleLMfm0136PrLUUR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789904997; c=relaxed/simple;
	bh=KH7FktkdMcieqHaTaKksUq53Yjn6UUlgcItyieml+Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWh+vDUmdWt/FADDnGH7/9RcvIY83kE+h9prHxas4MVQazpjkkjwUvH/GHC5yDEvql8UZXQhVQ5geozmzVDU5SIaQx9rP96xMV5QPFRFJuV9vr+921bmL0c1UUPo4Auq+f0grudvU2Mk/UipZwMtUNd4WB59PAGoyNxyIllKQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G94O5oaz; arc=none smtp.client-ip=95.215.58.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G94O5oaz"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KH7FktkdMcieqHaTaKksUq53Yjn6UUlgcItyieml+Bw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789904993; v=1; x=1790509793;
 b=G94O5oazODqzEhLS39ePq4xBJrSEX8kRWqOTPu6MUhCFbM4PyuazVi7Kye9NmLKGN38M4K4z
 18velkKOdCw0cgl6lWzlsuj77iOF3WgQOrjvCOpJmxITf2TOdCHN/S8L1i8XkxSe3kJo1nSrx5y
 e9irTi8NfJCv8oxP6JtlpM8E=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 897b13857ccdc661;
	Sun, 20 Sep 2026 11:49:52 +0000
X-Mizu-Trace-ID: 897b13857ccdc661
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Kees Cook <kees@kernel.org>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH net] ppp_synctty: remove redundant skb null check in ppp_sync_txmunge()
Date: Sun, 20 Sep 2026 19:49:43 +0800
Message-Id: <20260920114945.2517-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb is already dereferenced before the check. In addition, a TX skb
passed from the generic layer can never be null.

Remove the redundant null check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202609132245.txZXoUxc-lkp@intel.com/
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_synctty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 9e440e110e9f..b90ae0583c84 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -464,7 +464,7 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
 
 	ap->last_xmit = jiffies;
 
-	if (skb && ap->flags & SC_LOG_OUTPKT)
+	if (ap->flags & SC_LOG_OUTPKT)
 		ppp_print_buffer ("send buffer", skb->data, skb->len);
 
 	return skb;
-- 
2.34.1

