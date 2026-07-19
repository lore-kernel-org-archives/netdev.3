Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F317C220
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784451912; cv=none; b=UaTyJglfrQK4o2iiM72LToaIuL40OJAk9+iwxGSm036MdbDJezWpl5h/+MvBkYIr45yxNoH99Ovw0IZu8QLpmqNsN1HOQKKdUN5Xp4xErghPPeJogOWo2zX+3Uho8k5czFmmXEOQoONxhcshnwfN0LCIbSDs9eBa1oKB1otXrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784451912; c=relaxed/simple;
	bh=IvHasztBqatgO6+HWgAhtnOE6HJpktRID4mTRxPYqpw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8vhENlbf67cvKEBE4Ee1wfUO/z3svgVmwsPM/oRhr9z0Cw/WU1YCArrvqaAh5N/FTFPeYGHQ8RXY15cdrAJF23g27jfhOjx3fMlcDU/FNw9UOztNpvjzSoIobtdNIKpvDH60H13l+YgwFkTnKYpK6busGvXDRqwxH3SCwTtrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=OmkuudOq; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="OmkuudOq"
Received: (wp-smtpd smtp.wp.pl 32177 invoked from network); 19 Jul 2026 11:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1784451900; bh=yMi0/MVl/cPWSChXc9e6S3ptAuHAVNZiE1Q+dwVJ/JY=;
          h=From:To:Subject;
          b=OmkuudOqvoGnMDSUg6RId4RmmgJKOMayI7omJEAuDRSB26pwC7q+Qm0zKT7W9fyHV
           rwiOqFR88Ltet/jgDZ3mC+jo0LhqJ/FFHBO/9f5SqxdPD8OKNtIW+XBvnMWqHXUEHk
           sY0SMTrC4xbLQ5JfKe6Dt9/daWmB6EKavQ2odBQ/fF8PNNGdu0auuR2NZFOukp4iwQ
           Q+24uPMw7QoOJslZXRTWV/o2KjpYQ02boabUAmYJF1vgggrkFY9WNJadD+XvTlftXp
           50HTxvz7Hu+SMW8Tu9jYU5XcHqlkxl7BnXXv/T1w91Oq+QG1ppmF+50zF8REqBk2Uq
           zkF78msud8gjA==
Received: from 83.24.141.3.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.141.3])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <danieller@nvidia.com>; 19 Jul 2026 11:05:00 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: danieller@nvidia.com,
	olek2@wp.pl,
	mkubecek@suse.cz,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jbe@pengutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH ethtool-next v3 1/3] sfpid: print all implemented options
Date: Sun, 19 Jul 2026 11:00:35 +0200
Message-ID: <20260719090458.659332-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 18d65b91fd7d1cd4c081158df4aeba23
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [4YJs]                               

SFP modules implement multiple options. Before the “json” option was
introduced, all options were listed. Currently, only the last option
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
$ ethtool -m sfp-wan
...
	Option values                             : 0x00 0x32
	Option                                    : RX_LOS implemented
	Option                                    : TX_DISABLE implemented
	Option                                    : RATE_SELECT implemented
...
$ ethtool --json -m sfp-wan
[ {
...
        "option_values": [ 0,50 ],
        "option": [ "RX_LOS implemented","TX_DISABLE implemented","RATE_SELECT implemented" ],
...
    } ]

Fixes: 4071862f58d8 ("sfpid: Add JSON output handling to --module-info in SFF8079 modules")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
Changes in v3:
 - fix indentation and checkpatch warnings
Changes in v2:
 - fix typo introduced -> introduced
 - rename module_print_array_string() -> module_print_any_array_string_entry()
---
 module-common.c |  8 ++++++++
 module-common.h |  1 +
 sfpid.c         | 35 +++++++++++++++++++----------------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/module-common.c b/module-common.c
index 42fccf6..43ff649 100644
--- a/module-common.c
+++ b/module-common.c
@@ -258,6 +258,14 @@ void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
 		printf("\t%-41s : %s\n", fn, str_value);
 }
 
+void module_print_any_array_string_entry(const char *fn, const char *value)
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
index 4063448..f3baf2a 100644
--- a/module-common.h
+++ b/module-common.h
@@ -281,6 +281,7 @@ void module_print_any_string(const char *fn, const char *value);
 void module_print_any_float(const char *fn, float value, const char *unit);
 void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
 			   const char *str_value);
+void module_print_any_array_string_entry(const char *fn, const char *value);
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit);
diff --git a/sfpid.c b/sfpid.c
index 74a6f51..5899f8c 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -396,7 +396,6 @@ static void sff8079_show_wavelength_or_copper_compliance(const __u8 *id)
 static void sff8079_show_options(const __u8 *id)
 {
 	static const char *pfx = "Option";
-	char value[64] = "";
 
 	if (is_json_context()) {
 		open_json_array("option_values", "");
@@ -407,35 +406,39 @@ static void sff8079_show_options(const __u8 *id)
 		printf("\t%-41s : 0x%02x 0x%02x\n", "Option values", id[64],
 		       id[65]);
 	}
+
+	if (is_json_context())
+		open_json_array("option", "");
+
 	if (id[65] & (1 << 1))
-		sprintf(value, "%s", "RX_LOS implemented");
+		module_print_any_array_string_entry(pfx, "RX_LOS implemented");
 	if (id[65] & (1 << 2))
-		sprintf(value, "%s", "RX_LOS implemented, inverted");
+		module_print_any_array_string_entry(pfx, "RX_LOS implemented, inverted");
 	if (id[65] & (1 << 3))
-		sprintf(value, "%s", "TX_FAULT implemented");
+		module_print_any_array_string_entry(pfx, "TX_FAULT implemented");
 	if (id[65] & (1 << 4))
-		sprintf(value, "%s", "TX_DISABLE implemented");
+		module_print_any_array_string_entry(pfx, "TX_DISABLE implemented");
 	if (id[65] & (1 << 5))
-		sprintf(value, "%s", "RATE_SELECT implemented");
+		module_print_any_array_string_entry(pfx, "RATE_SELECT implemented");
 	if (id[65] & (1 << 6))
-		sprintf(value, "%s", "Tunable transmitter technology");
+		module_print_any_array_string_entry(pfx, "Tunable transmitter technology");
 	if (id[65] & (1 << 7))
-		sprintf(value, "%s", "Receiver decision threshold implemented");
+		module_print_any_array_string_entry(pfx, "Receiver decision threshold implemented");
 	if (id[64] & (1 << 0))
-		sprintf(value, "%s", "Linear receiver output implemented");
+		module_print_any_array_string_entry(pfx, "Linear receiver output implemented");
 	if (id[64] & (1 << 1))
-		sprintf(value, "%s", "Power level 2 requirement");
+		module_print_any_array_string_entry(pfx, "Power level 2 requirement");
 	if (id[64] & (1 << 2))
-		sprintf(value, "%s", "Cooled transceiver implemented");
+		module_print_any_array_string_entry(pfx, "Cooled transceiver implemented");
 	if (id[64] & (1 << 3))
-		sprintf(value, "%s", "Retimer or CDR implemented");
+		module_print_any_array_string_entry(pfx, "Retimer or CDR implemented");
 	if (id[64] & (1 << 4))
-		sprintf(value, "%s", "Paging implemented");
+		module_print_any_array_string_entry(pfx, "Paging implemented");
 	if (id[64] & (1 << 5))
-		sprintf(value, "%s", "Power level 3 requirement");
+		module_print_any_array_string_entry(pfx, "Power level 3 requirement");
 
-	if (value[0] != '\0')
-		module_print_any_string(pfx, value);
+	if (is_json_context())
+		close_json_array("");
 }
 
 static void sff8079_show_all_common(const __u8 *id)
-- 
2.53.0

