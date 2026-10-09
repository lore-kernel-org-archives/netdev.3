Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32C368D71;
	Fri,  9 Oct 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561313; cv=none; b=qpEUTTbi4L4/ghxeLl0BJTrnjCkibrJodVugTEGweLnqYNJgtqVcrNjUdDPNdgQ98nmXiAcLWTkcqK+mgt0g2agoFkpiXtrteXcczpvsNln6RMJijapIZ91tjEUPbA9/qcVRIWMUhYeD1UK9B/Tfe57Z4dh0/PNw/IcGwwfMppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561313; c=relaxed/simple;
	bh=5Xo/Q9YcHbdKiLUxXn9YkSs2HM6yLiHz+e2N8LuszlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TA+Co8S1jhptQnzkDK5ZEIu4+tCZL4ZTIorUmFfKibIzA6bHdXpwKeNSriF2xjQAKSjVG/gxPaSUH0L2WIru2n2cDh2mDnug6/Ln/9PwvtTokHcjVPeDnoasVY/ldFNQtrCTZVq4FA0k+evPjaJLMw0ATJJ30KRsQ8EaNG3Xl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diwjtE5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diwjtE5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B97D1F000FF;
	Fri,  9 Oct 2026 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791561311;
	bh=ETarWNoz0EPGWaPCNCrNvq8ZNMRzdWiPlsOZpjXQ1tc=;
	h=From:To:Cc:Subject:Date;
	b=diwjtE5Jda7yJ3Epkdal6wt5/dMIj80UR3mQGjtpaOlwYp2yH32Ro45QNkjLJOA56
	 cMXOqPzySdKrb034P5D35M3RHzGC7+OEMX3Osu/STtvFI4Pol6AoMRgFQKfyYt4wTu
	 lqYH+0n1EwyuxwJpqDH1PvFZnFJxWnAY1U7Qtz2/k0Fwna3eAp7/PVKOrFDdML+L9L
	 B3AN83xrgHwEog+8r68vfWJYpDQE3fJObEAVHveUWCxo/XDQfHDnsKMd7ER/1X3GkT
	 uuVZIAiN9By2FWIK0DYVs6Wfy5Nl4WpV5XDn+mNfTPLoCGdeBLFOeCTtMPi+HtTybg
	 G91RiraFUlz8g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: ethernet-controller: Allow "ethernet-N" node names
Date: Fri,  9 Oct 2026 10:54:45 -0500
Message-ID: <20261009155444.2347045-2-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HiSilicon hisilicon,hns-nic-v2 binding uses "ethernet-N" node names
as there is no "reg" property and multiple instances. Add support for
this pattern which is a common pattern on other node names.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 1bafd687dcb1..30b2a335116e 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 properties:
   $nodename:
-    pattern: "^ethernet(@.*)?$"
+    pattern: "^ethernet(@.+|-[0-9]+)?$"
 
   label:
     description: Human readable label on a port of a box.
-- 
2.53.0

