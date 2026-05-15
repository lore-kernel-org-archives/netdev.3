Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43D481A8B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853094; cv=none; b=UzU3wLUgc21PMpKrCYx6o/d4etGNSpCEbMO4CX73aF4nQ/BMv56vZK8HbQ550cUufDhsJPcOdkLpjVr3Rgt7PKb7bsyklktQvBpZaEBFVKdOU7+Z8mAaKWnQEs0OBrTteaKEgGHf6LlPkyjJFKhygl3aeDkXPBJFvqbEZHjimHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853094; c=relaxed/simple;
	bh=DyV4DQy9tu8Q9vyqvoJij2JezER1l/LAzJQ2NYIqu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkviNcCd5b2RFV5CdNyOOdy1OwChi61VYmZlIaDsNUlx20uZWHQg/bULrxvkXEIzOaRSTVZ578sdXkTPDMPFA43tN8PnMy/31caHHstbpwDsP+Ly3rTqVG417T5RGvH821SHA8ovEYRW39IkOm+rGn0LX//+JEtcdhx3Xpq0yUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=INrtpoCF; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="INrtpoCF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778853075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IbVwU64Zyg3ZEOkRLIxkQx5wI50F0Afamm94ltWX0v4=;
	b=INrtpoCFFyKNDl19LD6yPpnWSs+tlRA79NZX58jHFZZ/DHaf/3yT7skekN9qvaLyyRAucc
	A7DqJrjnu+45d+PfJxdFbyHLgTkRhoh+3FWvHKHaAYwNl5BHvqsbcBBepX4sVwwZ1K/1I+
	AVTq9DarAbCoPlF9FMr8tsEkYwrT4Co=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Rodolfo Giometti <giometti@enneenne.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next] pps: bump PPS device count
Date: Fri, 15 May 2026 13:50:28 +0000
Message-ID: <20260515135028.2021318-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Modern systems may have more than 16 PPS sources and current hard-coded
limit breaks registration of some devices. Let's bump the limit to 256
in hope it will be enough in foreseen future.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 include/uapi/linux/pps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
index 009ebcd8ced5..1088dea65e12 100644
--- a/include/uapi/linux/pps.h
+++ b/include/uapi/linux/pps.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 
 #define PPS_VERSION		"5.3.6"
-#define PPS_MAX_SOURCES		16		/* should be enough... */
+#define PPS_MAX_SOURCES		256		/* should be enough... */
 
 /* Implementation note: the logical states ``assert'' and ``clear''
  * are implemented in terms of the chip register, i.e. ``assert''
-- 
2.47.3

