Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331804D7978
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716695; cv=none; b=PYqIwz5fpgj3raw8AAM5cgtDyucvQkhBomwBOXl2bpiGC+aIRY0q0gUEFGVfQqwmOrhbB1dYZT/MMAWoWRUvmINt/UxpSepkNGQ4mLNiJU5QfNwPN7b8EXEe3jaAv1vnWi/1aADvB5KCGccZz/Cr68cEOqBbasZ17fKnu5GvNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716695; c=relaxed/simple;
	bh=UJPPWhfxM/H63zeM+y34iw9HQ6iKkbHYi3QpEVp4VBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjhSFy/aJY39A9eBfZEc/3nCqzJGrhPQzVHl/+AuxYdERgzMWSczbx2AwpHYuaEcRGSf387OWS+hGQUuGwunEg/DY0MKZCOiSJY3PN1jBzctexlRavGLdn9ngmtY+g7uudEPh94i6dyuGKuTB+6l6RzchOjSAU7+QmsOAwUGUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=K7l+L7zJ; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="K7l+L7zJ"
Received: (wp-smtpd smtp.wp.pl 38592 invoked from network); 29 Sep 2026 23:18:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1790716689; bh=1yvzOqyBbRWLs4ejLPtV1h7DjptO05WKCcTVvk6WbS8=;
          h=From:To:Cc:Subject;
          b=K7l+L7zJgCMo5OgKdya34km4oDIgE7T07W3HoEH34MkRPyQHDBiTTzKiChPttKRF1
           Mjas+F4CG2n0Brsv3yPW6nxGov7/hoUxHQUWlYcNzVjUzu1iQPLH/g/uaCkHkhWjmZ
           92P5vzqCWAclyzItwHzVfLI8cdYsLmk1UU1fEWIjSF+9JSWK/9AG01IDqv2NinwCpl
           ozTO6yfYtdRUQ6cv2KAfwz8y7tD3i5YjahCqX4fXI12H7U++PfjmtyXy+G4w7scBw2
           CZE1eJHvgOOkTTwOCosP82Q93APr6dsZ3ylYbQGI58uavRvaK7Jm17O4zXm9qtRjKh
           L7qHzwNDv/q0g==
Received: from abajkowski.enigma.com.pl (83.5.247.9.ipv4.supernova.orange.pl [83.5.247.9])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <netdev@vger.kernel.org>; 29 Sep 2026 23:18:09 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: netdev@vger.kernel.org,
	mkubecek@suse.cz
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH ethtool-next] sfp: add support for newer SFF-8472 Rate Identifiers
Date: Tue, 29 Sep 2026 23:16:55 +0200
Message-ID: <20260929211806.1279396-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: c2150e70bb2678f37720e947525e27f6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [oYC9]                               

This change adds support for newer rate identifiers defined in
SFF-8472.

Standards for SFF-8472
a) SFF_8472 Rev 12.5a dated Jan 16, 2026

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 sfpid.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sfpid.c b/sfpid.c
index 065ac4c..994da7e 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -331,12 +331,28 @@ static void sff8079_show_rate_identifier(const __u8 *id)
 		sprintf(description, "%s", "8/4/2G Rx Rate_Select only");
 		break;
 	case 0x03:
+	case 0x06:
 		sprintf(description, "%s",
 			"8/4/2G Independent Rx & Tx Rate_Select");
 		break;
 	case 0x04:
 		sprintf(description, "%s", "8/4/2G Tx Rate_Select only");
 		break;
+	case 0x08:
+		sprintf(description, "%s", "16/8/4G Rx Rate_Select only");
+		break;
+	case 0x0a:
+		sprintf(description, "%s",
+			"16/8/4G Independent Rx & Tx Rate_Select");
+		break;
+	case 0x0c:
+		sprintf(description, "%s",
+			"32/16/8G Independent Rx & Tx Rate_Select");
+		break;
+	case 0x10:
+		sprintf(description, "%s",
+			"64/32/16G Independent Rx & Tx Rate_Select");
+		break;
 	default:
 		sprintf(description, "%s", "reserved or unknown");
 		break;
-- 
2.53.0

