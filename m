Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C112E9730
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774140666; cv=none; b=B2AdDFwdNcZTYTV5z4lf4endN8+NIOk3d7cUGeQWuAsLC+U0QcHGL9p4Kgax5sThanFo5EGjogGHiOAtQ4Ok1PddyY+yXwQriZxXzyQL1ad5V9GuokgH0hbNPnX4KLYL31WL64qRkzWY230Ln2HG0N2RibbTM6aohQnx62MQ048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774140666; c=relaxed/simple;
	bh=rOckUp+DTgULh7PL73V1Afk8ffCgYCMm3r6TdnxaVl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ni0wGEj8eFTRX+p22oIIRZDM7rUzDWgldYij49qtQyEcLRXR5nq+K2kfijRDd0E2evqEIMRy7RMrgzPCYMnBP/6rwbCiHYOj4EvweCb2rO1sJ8w0eAUts5b4wpz0yphDF2a7vdwlJ+3gADzuZhKH+RErPbk9/dawe7uW9NYycpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M0oi8F021661;
	Sun, 22 Mar 2026 01:50:51 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC PATCH iproute2-next 4/4] seg6: man: document srl2 link type in ip-link man page
Date: Sun, 22 Mar 2026 01:50:21 +0100
Message-Id: <20260322005021.12770-5-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
References: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Document the srl2 link type in the ip-link(8) man page. Add srl2
to the list of supported link types and describe its segs parameter
and basic usage.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 man/man8/ip-link.8.in | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index ef45fe08..7971a10c 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -253,6 +253,7 @@ ip-link \- network device configuration
 .BR pfcp " |"
 .BR rmnet " |"
 .BR sit " |"
+.BR srl2 " |"
 .BR vcan " | "
 .BR veth " | "
 .BR virt_wifi " |"
@@ -402,6 +403,9 @@ Link types:
 .BR sit
 - Virtual tunnel interface IPv6 over IPv4
 .sp
+.BR srl2
+- SRv6 L2 tunnel device
+.sp
 .B vcan
 - Virtual Controller Area Network interface
 .sp
@@ -1529,6 +1533,25 @@ When
 is "ipv4", this allows the tunnel to also handle IPv6. This option is disabled
 by default.
 
+.TP
+SRL2 Type Support
+For a link of type
+.I SRL2
+the following additional arguments are supported:
+
+.BI "ip link add " DEVICE
+.BI type " srl2 " segs " SEG1,SEG2,...,SEGn"
+
+.in +8
+.sp
+.BI segs " SEG1,SEG2,...,SEGn"
+- specifies the SRv6 segment list for encapsulation. The segments
+are IPv6 addresses separated by commas. Each L2 frame transmitted
+through the device is encapsulated in an IPv6 header with a Segment
+Routing Header (SRH) containing the specified segment list.
+
+.in -8
+
 .TP
 AMT Type Support
 For a link of type
-- 
2.20.1

