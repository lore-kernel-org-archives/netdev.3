Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897173254BB
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772135; cv=none; b=RHHnG20PHERzQB8HUjQapUxa297Oekz9AcYvjWqTyKdDS0J+sdfbGK5TqQGGHOOApwkaRxTF9aRYfCW2CAUREPUJ8PZV+VF4bLa0GL7+BmXsxu8UxsMUJTAxGOSB00uY2jW3jFyR2MMmeLuEhQ61YlhyO2xb/6QfZqy0RH+ECQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772135; c=relaxed/simple;
	bh=UNarCqOBjIHmjt76KQoQwHuh0wmWGP9s3jZ6gDZi2Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fY827rrhbchqx63CXl9FKY9aeaU34+Z9JMW80WunOEA1ac34PSRe+54cMO8Xc4UbQdS0Dfjn2Vu4DMKiuQ/RITlKkOeNoKFo0BCgDakqkVtnFVR7N2971tRRBtJX1F1JZcPzoGzwPmbqAt736qznLV3MEPNPTA1KVD+GAJHWN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 65534)
	id 1281B1003C513C; Tue, 17 Mar 2026 19:22:46 +0100 (CET)
X-Spam-Level: 
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:202:600a::a4])
	by a3.inai.de (Postfix) with ESMTP id E953A1003C5101;
	Tue, 17 Mar 2026 19:22:45 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iproute2] ss: print IPv6 zone identifier within the square backets
Date: Tue, 17 Mar 2026 19:22:11 +0100
Message-ID: <20260317182245.87996-1-jengelh@inai.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ss was printing the zone identifier in the wrong place.
The zone identifier belongs to the address [1][2][3], and should thus
be enclosed within the square brackets, not outside of it.

[1] glibc (since about 2000) accepts "fe80::1%eth0" as an input to
    the `getaddrinfo` function.
[2] Zone architecture specification (drafted 2003; released 2005):
    RFC 4007 §4: "The scope of an address is encoded as part of the
    address".
[3] RFC 6874 §2 pg. 4: ABNF syntax showing where zones go in
    relation to square brackets.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 misc/ss.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index b3566f6b..f242d761 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1484,10 +1484,23 @@ static void sock_details_print(struct sockstat *s)
 static void sock_addr_print(const char *addr, char *delim, const char *port,
 		const char *ifname)
 {
-	if (ifname)
-		out("%s" "%%" "%s%s", addr, ifname, delim);
-	else
-		out("%s%s", addr, delim);
+	/*
+	 * Numeric IPv6 addresses should be bracketed.
+	 * Come to think of it, any address with a port delimiter character
+	 * should be bracketed; otherwise, it would be impossible to tell if
+	 * ":N" is the port or part of the address.
+	 */
+	if (strpbrk(addr, delim) != NULL) {
+		if (ifname)
+			out("[%s" "%%" "%s]%s", addr, ifname, delim);
+		else
+			out("[%s]%s", addr, delim);
+	} else {
+		if (ifname)
+			out("%s" "%%" "%s%s", addr, ifname, delim);
+		else
+			out("%s%s", addr, delim);
+	}
 
 	field_next();
 	out("%s", port);
@@ -1725,13 +1738,6 @@ static void inet_addr_print(const inet_prefix *a, int port,
 			buf[1] = 0;
 		} else {
 			ap = format_host(a->family, 16, a->data);
-
-			/* Numeric IPv6 addresses should be bracketed */
-			if (strchr(ap, ':')) {
-				snprintf(buf, sizeof(buf),
-					 "[%s]", ap);
-				ap = buf;
-			}
 		}
 	}
 
-- 
2.53.0

