Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84433A9CB;
	Sat, 22 Aug 2026 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430187; cv=none; b=cU32Aob/bD6e7QQtqMB+FABLr4s7N2gGlHuVN+rLDYeNYStcMhJ7D68IFbylqAD7YotIPI94Txu992bPdPdoXPS6YhAvN7hTXGfhQUDQwfGDQbmUoTWtMZXOGOfJ4EMJenE5gyqGkYqG9s+KkFL9OW1bwBWP0SzBhyVAZHGCVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430187; c=relaxed/simple;
	bh=i1/OdJTULeQadISS4NWY/R3kadShy8DLHMx2FwyChZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pD6rUguFEr3vtSZXGMxGhfeLsc4KI2bcTPQjJihCrxdRfXAIrd0EGRqaUJYkE5dwn0lfyBJbx8JzmFU+7tGUXQVj7vernRW5Vvjt6JxG3NLbj3SQ6+vc4q2nPUeGyJg4ltJ4iwOndhjRWCOj0BMFzNn0HeyCqEXEH/sz+seeaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.78.19.215) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sat, 22 Aug
 2026 23:22:52 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Subject: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
Date: Sat, 22 Aug 2026 23:21:54 +0300
Message-ID: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
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
the last iteration is executed differently to the prior ones, doing
some useless assignments before *break*. Move the code for the last
iteration out of the loop bodies, dropping the pointless statements
as well...

Found by Linux Verification Center (linuxtesting.org) with the Svace
static analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
 drivers/net/usb/r8152.c | 67 ++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..de9738bdce85 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1431,27 +1431,19 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
 	if ((u32)index + (u32)size > 0xffff)
 		return -EPERM;
 
-	while (size) {
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
+	while (size > limit) {
+		ret = get_registers(tp, index, type, limit, data);
+		if (ret < 0)
+			goto error1;
 
-			index += size;
-			data += size;
-			size = 0;
-			break;
-		}
+		index += limit;
+		data += limit;
+		size -= limit;
 	}
 
+	ret = get_registers(tp, index, type, size, data);
+
+error1:
 	if (ret == -ENODEV)
 		rtl_set_unplug(tp);
 
@@ -1498,31 +1490,24 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
 		if (byen != BYTE_EN_DWORD)
 			size -= 4;
 
-		while (size) {
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
+		while (size > limit) {
+			ret = set_registers(tp, index, type | BYTE_EN_DWORD,
+					    limit, data);
+			if (ret < 0)
+				goto error1;
+
+			index += limit;
+			data += limit;
+			size -= limit;
 		}
 
+		ret = set_registers(tp, index, type | BYTE_EN_DWORD, size, data);
+		if (ret < 0)
+			goto error1;
+
+		index += size;
+		data += size;
+
 		/* Set the last DWORD */
 		if (byen != BYTE_EN_DWORD)
 			ret = set_registers(tp, index, type | byen, 4, data);
-- 
2.55.0
