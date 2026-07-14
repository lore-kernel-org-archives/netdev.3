Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2243F4DB;
	Tue, 14 Jul 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071807; cv=none; b=gvMiY9Y9LMe+DqL87x3nWiKlu8DOwFTNZb/MFAW4mpwBsdd01emV9TE9aTdYyEGFv0RJwf1gjYQOIjT/Ga3gSq78sQdzmtG6OLrGj8EJS0tc6IZ0ogHdhWPuENjJPAnUsOG6cDD5qAihhw1HixqOv4eWdCpnU2506G/8R4trV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071807; c=relaxed/simple;
	bh=YOlXV4yx2JgouGFWLyMebwKdmLLgwS+W0jBg6q1zBP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCWOS7UBtCq78QpbXmdyajjFrzzkJwA+E2+D+OUIwQ7Rf5XTuciHdlp1x+fcjp7xA+lVMEgY3CCYGjJDMND92Fhe5OgSu9AlbIqhrq6oH0dctj0LaPieGSvtmClrAdqYeIatn2nMTxozPyruzlsSinY+ZJCzG9NvXv4R0ez7ySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=N0oMd47p; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="N0oMd47p"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 93BA9621FE;
	Tue, 14 Jul 2026 19:30:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784071804; bh=+j9TA7tndJOPgp/THSU1/hZJYBAHL0/MzIuEuvLGtzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N0oMd47pvl1y/V6ex0vbmtOxtywfz4hCEOJTuNPKEBd4MmUR8SSqe/XWTzEpBnRbi
	 o+p5fmtjVQr4s3Sd3gZXWvELUor48GafixK+B1Ykl0vdmmjjSmW7NBElT8JSGfMT86
	 NjslXqHEhlHe5RzX+EZmoqyHDpNr4WNSWqqZb0wBkIFmPUiaxQGLcigvlqhrxgz3HE
	 NnqhhVbEjH1h8REz0qFCrGRnZHl1W4LMv8Fsbg+IYo5dC6Tp+2l1KKgPTV+DYR7Ld8
	 kWg8qFUT+IK+Ow4afjpPi8Y91zeD9ZIlFW9Szl3Vn9QwoPdcTdGpGpm8q36t8poErp
	 wYDcSn9Ob0OOA==
From: Luke Howard <lukeh@padl.com>
Date: Wed, 15 Jul 2026 09:29:43 +1000
Subject: [PATCH net v3 3/3] net: dsa: mv88e6xxx: don't clip ATU Move ToPort
 delete sentinel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mv88e6x41-fixes-v3-3-9a8702b27ecc@padl.com>
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
In-Reply-To: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784071787; l=1857;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=YOlXV4yx2JgouGFWLyMebwKdmLLgwS+W0jBg6q1zBP4=;
 b=EqB59wGrl90LmAVRMClpJSs1f5mszE4+xB71AIy/bX+Bm1yhNnxyaJbEYN1Uj3mdMIvZg0yxK
 IlwaI8Wi3iaBmoaMOUKOJfrjf185EdtHlXVHmb7Xgo8Zv2CPhdYj5T2
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

mv88e6xxx_g1_atu_data_write() masked the port vector, which is correct
for a load operation (where portvec is a bitmap) but wrong for a move,
where the portvec encodes a ToPort/FromPort pair.

An all-ones ToPort value is the sentinel used to delete an entry. Chips
with fewer than eight ports (e.g. 88E6141) clipped this value, turning a
delete into a move (to port 3 on the 6141/6341). Other chips such as
the 7-port 88E6352 were unaffected by chance.

Fix this by moving the mv88e6xxx_port_mask() mask into
mv88e6xxx_g1_atu_loadpurge(), where the portvec always represents a
bitmap; the move path then writes its ToPort/FromPort pair unmasked.

Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index 522978f638e2f..6bee943c83575 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -239,7 +239,7 @@ static int mv88e6xxx_g1_atu_data_write(struct mv88e6xxx_chip *chip,
 		if (entry->trunk)
 			data |= MV88E6XXX_G1_ATU_DATA_TRUNK;
 
-		data |= (entry->portvec & mv88e6xxx_port_mask(chip)) << 4;
+		data |= entry->portvec << 4;
 	}
 
 	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_DATA, data);
@@ -326,6 +326,11 @@ int mv88e6xxx_g1_atu_loadpurge(struct mv88e6xxx_chip *chip, u16 fid,
 	if (err)
 		return err;
 
+	/* Mask portvec to a chip's real ports so they cannot spill into
+	 * adjacent ATU Data register fields.
+	 */
+	entry->portvec &= mv88e6xxx_port_mask(chip);
+
 	err = mv88e6xxx_g1_atu_data_write(chip, entry);
 	if (err)
 		return err;

-- 
2.43.0

