Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93857C72A;
	Wed, 23 Sep 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194550; cv=none; b=VZOFwkqYZRNSyjhnwZLidWG8JC82+xNYgczw1bmSi5f3pG23yiqqUcJqITVhJmXhXKtRT7mHvcIBC4Sau0/Wx0ECPghK7VgDxfcxxorWeZd62lJRigSWy1dQlpLrgd0rorCmNIa2KR3ozfCfIYV7HhmvixrRIT6S5lCsWko77bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194550; c=relaxed/simple;
	bh=ebHjExt4i0RcqMUAW2XsFIK69pjmIXZ8PqKkqc1dSNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQShuoRqDmXaAFjMDpO5bQ9uAHi3PvlU1WZG/V9t2vy9HBPMktzooXQvN3PQsToqV14mbxPi4PfQfyPP/1OBXX3x61A5zjgT6eq6hdYAMUiT1JujQ07N7yupGGBCBXkCpE+4lsYIF+r1pkPBwS4oOO2O5+vUxzWNm2khPb7QlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.78.46.39) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 23 Sep
 2026 23:15:28 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 2/2] ch9200: do return USB errors from control_write()
Date: Wed, 23 Sep 2026 23:14:39 +0300
Message-ID: <20260923201440.36966-3-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923201440.36966-1-s.shtylyov@auroraos.dev>
References: <20260923201440.36966-1-s.shtylyov@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

Compared with control_read(), control_write() looks really strange:
it ignores any errors returned by usb_control_msg(), always returning
0 instead, despite overriding a positive result of usb_control_msg()
(indicating short transfer) to -EINVAL before doing that. Drop that
dubious *return* and propagate USB errors to the callers...

Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
Changes in version 2:
- dropped the Fixes tag, retargeting the patch to the net-next.git repo;
- dropped [RFT] from the subject.

 drivers/net/usb/ch9200.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index ab3cd3902ed7..5cd825f26420 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -168,8 +168,6 @@ static int control_write(struct usbnet *dev, unsigned char request,
 		err = -EINVAL;
 	kfree(buf);
 
-	return 0;
-
 err_out:
 	return err;
 }
-- 
2.55.0
