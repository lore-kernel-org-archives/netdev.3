Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88C3446AD;
	Tue, 25 Aug 2026 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687900; cv=none; b=HhZ9DhJ3/S3Ts3W0MUdGv1aUq+3IVaaMX2TVuqiMILeHCs3819YlAcqRljq4DZv5eSnMJ/5X4pGMnacU0Ylxh+wlElh/iTioNn52HsF8TLdJ0aBq0POVbnOPxP5kMAtC+uN8I6pOaoPdw8gfTNg5wfZljk60yo7mquDEjjPeqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687900; c=relaxed/simple;
	bh=Vjj6oayBhOBd5PFC7i7R009f/ucKF+GNdanNAaDGQuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I3/sVXYJWX5cv/of+Ifg/QPZiPyLFUf145mC//A5NRIMSRlEaKHP0VE/Dk4HXa4188Vpp6GPI0WxsUfDDa644D5HVKKwE716NKMdzHWLu18M8sX1Mk9MjHrbHY8sWwf4V6zW8JTYBN+GfG5aWUmSrngTAAgzY20twa8Qll333MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.79.41.14) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 25 Aug
 2026 22:58:04 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Michal Pecio
	<michal.pecio@gmail.com>
Subject: [RFC net-next v2] r8152: simplify loops in generic_ocp_{read,write}()
Date: Tue, 25 Aug 2026 22:57:35 +0300
Message-ID: <20260825195736.56257-1-s.shtylyov@auroraos.dev>
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

In generic_ocp_{read,write}(), the *while* loops look very strange:
the last iteration is implemented differently to the previous ones
(doing some useless assignments before *break*) for no good reason.
Merge the different iterations into one, using the local variables
in the loop bodies...

Found by Linux Verification Center (linuxtesting.org) with the Svace
static analysis tool.

Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
 drivers/net/usb/r8152.c | 55 +++++++++++++----------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..af3d7dcb2f14 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1432,24 +1432,15 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
 		return -EPERM;
 
 	while (size) {
-		if (size > limit) {
-			ret = get_registers(tp, index, type, limit, data);
-			if (ret < 0)
-				break;
-
-			index += limit;
-			data += limit;
-			size -= limit;
-		} else {
-			ret = get_registers(tp, index, type, size, data);
-			if (ret < 0)
-				break;
+		u16 n = min(size, limit);
 
-			index += size;
-			data += size;
-			size = 0;
+		ret = get_registers(tp, index, type, n, data);
+		if (ret < 0)
 			break;
-		}
+
+		index += n;
+		data += n;
+		size -= n;
 	}
 
 	if (ret == -ENODEV)
@@ -1499,28 +1490,16 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
 			size -= 4;
 
 		while (size) {
-			if (size > limit) {
-				ret = set_registers(tp, index,
-						    type | BYTE_EN_DWORD,
-						    limit, data);
-				if (ret < 0)
-					goto error1;
-
-				index += limit;
-				data += limit;
-				size -= limit;
-			} else {
-				ret = set_registers(tp, index,
-						    type | BYTE_EN_DWORD,
-						    size, data);
-				if (ret < 0)
-					goto error1;
-
-				index += size;
-				data += size;
-				size = 0;
-				break;
-			}
+			u16 n = min(size, limit);
+
+			ret = set_registers(tp, index, type | BYTE_EN_DWORD,
+					    n, data);
+			if (ret < 0)
+				goto error1;
+
+			index += n;
+			data += n;
+			size -= n;
 		}
 
 		/* Set the last DWORD */
-- 
2.55.0
