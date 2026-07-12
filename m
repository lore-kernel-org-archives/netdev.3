Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2D17B425
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822426; cv=none; b=egIuVXROQez9axeq3mpIzXbkhJ8+7sPrTulb4/sqWWgoQ9DlGmkoN4K5PdjLvwKpYyvNJ1qKH0CLdAhXmXiVFlggTGNzJdPpN5W1yJNdry0CwPCqISWSwSRJJYGM4HTmeJdtGQ7zimnjrNaX5Kk9zI2Xyjg2sIumyUdgPoP5GFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822426; c=relaxed/simple;
	bh=q9xiPSxQ9DsnzZoQsmyZWGcYCOO4jmGU96xGJ0eTK6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbBtY+T0XhNvnFPRJmPWVdXjyB8VXn9BNyvDJUFTyMFpzYpfv8fLtUZXd8u/1cXiodPmSwYdlxKGTO60PMuYpnj+1yey5oylkN7BYwl2heNFvqY1vyfy5/YvWb41toIOQx/9Q+jcl4MBh4jhv51kvrNbbJR4jYYIGEdprBUV9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66C2DKm1015953;
	Sun, 12 Jul 2026 04:13:26 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Justin Iurman <justin.iurman@6wind.com>,
        Anthony Doeraene <anthony.doeraene@uclouvain.be>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH iproute2-next 2/2] seg6: man: document the lookup attribute for SRv6 encap routes
Date: Sun, 12 Jul 2026 04:11:55 +0200
Message-Id: <20260712021155.7621-3-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
References: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Document the new optional "lookup" attribute for seg6 encap routes. It
selects the FIB table for the post-encap SID route lookup and accepts a
table number or a table name.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 man/man8/ip-route.8.in | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 9f29fd43..fd04432f 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -246,7 +246,9 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .B segs
 .IR SEGMENTS " [ "
 .B hmac
-.IR KEYID " ]"
+.IR KEYID " ] [ "
+.B lookup
+.IR TABLEID " ]"
 
 .ti -8
 .IR ENCAP_SEG6LOCAL " := "
@@ -910,6 +912,18 @@ configuration and dynamic resolution.
 
 .I KEYID
 - Numerical value in decimal representation. See \fBip-sr\fR(8).
+.sp
+
+.B lookup
+.I TABLEID
+- Table for the post-encap SID route lookup, i.e. looking up the
+route for the first SID.
+.I TABLEID
+is either a number or a string from
+.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables
+(has precedence if exists); table id 0 is not a valid value.
+When omitted, this lookup uses the current routing context, e.g. tables
+selected according to the routing policy database.
 .in -2
 .sp
 
-- 
2.20.1

