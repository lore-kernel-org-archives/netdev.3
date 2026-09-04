Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE644B690;
	Fri,  4 Sep 2026 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552124; cv=none; b=APMc6452MTbu+kUPc/in8mz2cTm10hmw38pNB97GJfu1AcHHFG1dHMwwTZ2UvrfzpBnETlFwsUL35l7gzLhLTrwFbwt2Fu8pLWp6KeWiwbx43CTOxtBcUMn6UXt9btQsVQrZAol6OMeYOMWnzFgUFy1ccf6Ri5adNsgCmbNo/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552124; c=relaxed/simple;
	bh=GMttbLMZHaxjxIzvEjAdSa2PRg3Se4QS4NCwM0pGe+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qv8l6g5Rj1R1uRdv+ne8lbFPozQ2BG1QGHer+8EWSC92+aYBXZ/xrcRYByVW5S/9geDSW7qFDtxqbnesrp7gjQYPtHPga4FTG2lUKwKjDuSYUlu2k3U1NHIagZxwGpVpU5dxvKwFambuouBOjhEYu5w99P7v+ssKDhobyZupPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.79.14.11) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 4 Sep 2026
 23:01:53 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Matthew Garrett
	<mjg59@srcf.ucam.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net RFT] ch9200: do return USB errors from control_write()
Date: Fri, 4 Sep 2026 23:01:07 +0300
Message-ID: <20260904200108.85165-1-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.55.0
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

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
 drivers/net/usb/ch9200.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index a206ffa76f1b..3a81e9e96fd3 100644
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
