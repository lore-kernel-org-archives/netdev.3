Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52F26E6F3
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783282013; cv=none; b=RqTYXoKeT+yXHmFOmzyI7H8wRQN0x2Y9y/1K5P7vSSCTNbJx6wPl+gNLxIiMNBVgaUcZy8Un/s50xzxg5z+gzVckNyqZcWV4SMOifvdPfFdPK8D7YOvSWNyqhYWEzGjihmbsZ2Or9idj+2q9PHaDEbR4rORkIJaPZkOpHJfQfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783282013; c=relaxed/simple;
	bh=mDWAk8OWYSvqQDbrvsbdBb04cAxwKE0EMAn3ySULZR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pyraftO+zIx8CLw4TbAkTlGTB1yaxEV0v/dgrIp6t4f1/FXSwOrGTZd19Y7X9S7t/rcuLzC2qGUsbIyKkd3Z+MZI5QhcmxdoL1zBlf3299uxVux7NP+Ubgh7X6CxqVekM69jCZR05zipBdcL/SkV29WzGFZ/RB+HTfjbCTeMSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=tJjc3iO+; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="tJjc3iO+"
Received: (wp-smtpd smtp.wp.pl 5346 invoked from network); 5 Jul 2026 22:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1783282002; bh=jY2DCbo888N63fYqRPCWKKk0jovzNFGj7ichvg6XY6E=;
          h=From:To:Cc:Subject;
          b=tJjc3iO+EObnGf3GjT114Rff5KAGrHkam4i3GQiCjmtR7z+FEp7QrwAtKstKI2VRx
           1abPdRUq+JrPPj8RMwg+iBAbDL0UC+G8iJcxwXxazFjTy5KAjpNSq/ixvsYqNxDHDz
           LfNrhD/Nr7Vuo2Fr749FW491DzduLaOLM36tJW5KlNdeu2chL9Cw3IWvvZ9xXvr0hv
           KtYngLF3XxeLdPpj+9/LUljuZSCUkX2OyjVcPWgAXf6eTswrm0kmdi7Vp3ZZnXrgaY
           Sz03pzBGcg1V3RtCHK/9YR+J4JzSK2N+N9QkC7ohJf5jMfIbL5Ma+x0zJJF1xxo/xG
           edKI9j5P5gkDQ==
Received: from 83.5.234.32.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.5.234.32])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <mkubecek@suse.cz>; 5 Jul 2026 22:06:42 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: mkubecek@suse.cz,
	andrew@lunn.ch,
	danieller@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH ethtool-next 1/2] sfpid: print all implemented options
Date: Sun,  5 Jul 2026 22:06:25 +0200
Message-ID: <20260705200637.2092534-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 9b516ebec23e35bd960973a5e5a2e593
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UbO0]                               

SFP modules implement multiple options. Before the “json” option was
instroduced, all options were listed. Currently, only the last option
is listed. This commit fixes this bug. Options are represented as array.

Before:
$ ethtool -m sfp-wan
...
	Option values                             : 0x00 0x32
	Option                                    : RATE_SELECT implemented
...
$ ethtool --json -m sfp-wan
    [ {
    ...
            "option_values": [ 0,50 ],
            "option": "RATE_SELECT implemented",
    ...
        } ]

After:
$ ethtool -m sfp-lan
...
	Option values                             : 0x00 0x32
	Option                                    : RX_LOS implemented
	Option                                    : TX_DISABLE implemented
	Option                                    : RATE_SELECT implemented
...
$ ethtool --json -m sfp-lan
[ {
..
        "option_values": [ 0,50 ],
        "option": [ "RX_LOS implemented","TX_DISABLE implemented","RATE_SELECT implemented" ],
    } ]
..

Fixes: 4071862f58d8 ("sfpid: Add JSON output handling to --module-info in SFF8079 modules")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 module-common.c |  8 ++++++++
 module-common.h |  1 +
 sfpid.c         | 39 +++++++++++++++++++++++----------------
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/module-common.c b/module-common.c
index 42fccf6..d736c7c 100644
--- a/module-common.c
+++ b/module-common.c
@@ -258,6 +258,14 @@ void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
 		printf("\t%-41s : %s\n", fn, str_value);
 }
 
+void module_print_array_string(const char *fn, const char *value)
+{
+	if (is_json_context())
+		print_string(PRINT_JSON, NULL, "%s", value);
+	else
+		printf("\t%-41s : %s\n", fn, value);
+}
+
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit)
diff --git a/module-common.h b/module-common.h
index 4063448..6f9da5f 100644
--- a/module-common.h
+++ b/module-common.h
@@ -281,6 +281,7 @@ void module_print_any_string(const char *fn, const char *value);
 void module_print_any_float(const char *fn, float value, const char *unit);
 void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
 			   const char *str_value);
+void module_print_array_string(const char *fn, const char *value);
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit);
diff --git a/sfpid.c b/sfpid.c
index 74a6f51..d6636ba 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -396,7 +396,6 @@ static void sff8079_show_wavelength_or_copper_compliance(const __u8 *id)
 static void sff8079_show_options(const __u8 *id)
 {
 	static const char *pfx = "Option";
-	char value[64] = "";
 
 	if (is_json_context()) {
 		open_json_array("option_values", "");
@@ -407,35 +406,43 @@ static void sff8079_show_options(const __u8 *id)
 		printf("\t%-41s : 0x%02x 0x%02x\n", "Option values", id[64],
 		       id[65]);
 	}
+
+	if (is_json_context())
+		open_json_array("option", "");
+
 	if (id[65] & (1 << 1))
-		sprintf(value, "%s", "RX_LOS implemented");
+		module_print_array_string(pfx, "RX_LOS implemented");
 	if (id[65] & (1 << 2))
-		sprintf(value, "%s", "RX_LOS implemented, inverted");
+		module_print_array_string(pfx, "RX_LOS implemented, inverted");
 	if (id[65] & (1 << 3))
-		sprintf(value, "%s", "TX_FAULT implemented");
+		module_print_array_string(pfx, "TX_FAULT implemented");
 	if (id[65] & (1 << 4))
-		sprintf(value, "%s", "TX_DISABLE implemented");
+		module_print_array_string(pfx, "TX_DISABLE implemented");
 	if (id[65] & (1 << 5))
-		sprintf(value, "%s", "RATE_SELECT implemented");
+		module_print_array_string(pfx, "RATE_SELECT implemented");
 	if (id[65] & (1 << 6))
-		sprintf(value, "%s", "Tunable transmitter technology");
+		module_print_array_string(pfx,
+			"Tunable transmitter technology");
 	if (id[65] & (1 << 7))
-		sprintf(value, "%s", "Receiver decision threshold implemented");
+		module_print_array_string(pfx,
+			"Receiver decision threshold implemented");
 	if (id[64] & (1 << 0))
-		sprintf(value, "%s", "Linear receiver output implemented");
+		module_print_array_string(pfx,
+			"Linear receiver output implemented");
 	if (id[64] & (1 << 1))
-		sprintf(value, "%s", "Power level 2 requirement");
+		module_print_array_string(pfx, "Power level 2 requirement");
 	if (id[64] & (1 << 2))
-		sprintf(value, "%s", "Cooled transceiver implemented");
+		module_print_array_string(pfx,
+			"Cooled transceiver implemented");
 	if (id[64] & (1 << 3))
-		sprintf(value, "%s", "Retimer or CDR implemented");
+		module_print_array_string(pfx, "Retimer or CDR implemented");
 	if (id[64] & (1 << 4))
-		sprintf(value, "%s", "Paging implemented");
+		module_print_array_string(pfx, "Paging implemented");
 	if (id[64] & (1 << 5))
-		sprintf(value, "%s", "Power level 3 requirement");
+		module_print_array_string(pfx, "Power level 3 requirement");
 
-	if (value[0] != '\0')
-		module_print_any_string(pfx, value);
+	if (is_json_context())
+		close_json_array("");
 }
 
 static void sff8079_show_all_common(const __u8 *id)
-- 
2.53.0

