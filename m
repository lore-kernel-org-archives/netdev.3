Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347A385529;
	Mon,  7 Sep 2026 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810407; cv=none; b=O7T9WghOR1Xucsa+mrioMrMYjmufY2BunVl/I0f5tD9F76G+EvKeADTf5cERav5R6W1jMdIEOQwWGo7HrPSm6Yd9W5lyrnufTE6jWZTNOkah/3Wv/XZS5uwAYnxjmlQBEysI6Vh9h5mZKNeNt/YgK/fCAv30JIskrdpRGHKHSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810407; c=relaxed/simple;
	bh=JNqCcPPEumidimaVvJdFKAg98Bly9gejgVcrh20/d8c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=gaE+z8QBF7jCW14O9o20K3cyR5X4+2ilTUhiHOI6Cdbc8xQJcWjHSbWw0/FzkOETngmcDSdbBXt0zRbPE9MwKqFkE35x6lIM3nd4bEjb2q6Qbq95lNDdCX2EOZTtqj1QiZ0OxQeYYYFVL6CmmF3fLqdDEi1sqO5rgZnf+LADvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.21.186) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 7 Sep 2026
 22:46:32 +0300
Message-ID: <863dac62-89ef-42d7-9108-d4a0600913a4@auroraos.dev>
Date: Mon, 7 Sep 2026 22:46:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Subject: [PATCH net-next v3] r8152: simplify loops in
 generic_ocp_{read,write}()
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Michal Pecio
	<michal.pecio@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Changes in version 3:
- removed [RFC] from the subject;
- added the version log.

Changes in version 2:
- instead of moving the code for the last iteration out of the loop bodies,
  merged the separate iterations into a single one as suggested by Michal
  Pecio (adding the Suggested-by tag), rewrote the description accordingly.

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
