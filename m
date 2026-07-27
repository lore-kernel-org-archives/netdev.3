Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5643A5438;
	Mon, 27 Jul 2026 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124775; cv=none; b=ZsFNY/hkJSu55aEhQORRXolHw/eovXGqm6WFzRcZKMGabeGoZ70AN9oQ++8wjaKDxXCuHt6NIfDJ4P423kIst296EjzlUAuz7kOm6e59ZyUnQKra+2PERT/mKIMNoFgvol8w3jkOyOY/BkZtDapUj4nri4Uk3+Da0exN7ng8FrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124775; c=relaxed/simple;
	bh=wyVRpKVcf+XB7voTkZjG9MpFHe+9jsE9D3Wb2w8Lo30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tl0zC0SHohSDwisxbk1spxkS/a7Q8F/BqWxKCPNj7ni/qLm7niKDSAdgS71pJ2XIjKDwygxSad/EWtpzuY6k5Vn6AahMcUVIBSWwoRAOkVQzbwIfFnnN/5nFVacKmhx624PmJ+gPrIlbHDQE4NjqP97CkOE65cJ6vuvoMprAqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=jgstiFUA; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="jgstiFUA"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id B87086227B;
	Sun, 26 Jul 2026 23:59:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785124771; bh=4FFzM1PpdKEvcNV7aDQstwGYZvh1TrOB80vyX7LTwNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jgstiFUAvFLcFazDIEXTfxKGFhtWYu/qmoPPVrME6o9PrgSRx/kl2/vNcwSD3I3eA
	 F5fGq+Do1jcZF8DMFZiH3DEx+BLCezGc36lbSpk52492MSvZQuy09XwUj8XHaDxgzG
	 b+PNC/ZVPXAK1zsW3ysEMDxJSd/PyY5UH0iOEl0UlXzWn0269n698ZETC7xxjTixTh
	 d3rqQi+r7U7s3u0dRqzpbBd+GurWSSZKAN/7E0eE4KmL9cUJn6k76uMmxOOq9BKbkx
	 srgLb8D9adPnZwMQmkgW8qmyX3n9HC/O1HHAEZJHAddJZYgqSECdWTaM59BnXvzGfQ
	 Uemyr3gEfpDEA==
From: Luke Howard <lukeh@padl.com>
Date: Mon, 27 Jul 2026 13:59:12 +1000
Subject: [PATCH net-next v4 1/5] net: dsa: mv88e6xxx: only time stamp PTPv2
 frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mv88e6xxx-ptp-fixes-v4-1-10b4020155fc@padl.com>
References: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
In-Reply-To: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785124760; l=903;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=wyVRpKVcf+XB7voTkZjG9MpFHe+9jsE9D3Wb2w8Lo30=;
 b=hZYHHc2EdwGhLtuJSU7X475AUTWfbNwdwEeCGxKf6EAZxSbM1TMy9phyRTFxFssQQqIUY9evl
 q7zxDowYGaEDEAgZAe46S0Y/7YHZ9baXTmg5rQL4cblo3jj9sR0g5mJ
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Marvell switches only document support for IEEE 1588v2, not for PTPv1
(IEEE 1588-2022). Reject PTPv1 frames in mv88e6xxx_should_tstamp().

Assisted-by: Claude:claude-opus-5
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 6e6472a3b75ad..e4326165e1896 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -216,6 +216,10 @@ static struct ptp_header *mv88e6xxx_should_tstamp(struct mv88e6xxx_chip *chip,
 	if (!chip->info->ptp_support)
 		return NULL;
 
+	/* Marvell switches do not support IEEE 1588-2002 (PTPv1). */
+	if ((type & PTP_CLASS_VMASK) != PTP_CLASS_V2)
+		return NULL;
+
 	hdr = ptp_parse_header(skb, type);
 	if (!hdr)
 		return NULL;

-- 
2.43.0

