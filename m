Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D03DD503;
	Mon, 27 Jul 2026 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124791; cv=none; b=oWRO3ArWsFHjBMY5QswhrNI8gf5o82KhCqOrHnhKKshMKeI5TyotLNI9lug5GbcWRst0OfDkmSOCDpx5Jjwf5KyoBO77lYYZPWrqzHhbHKIj40XPM1Gi0HvXP0jvFAIMbHaNUBhIgMOmiwLUWObwDD+vO2Qec4Zb6+kvLvE5APg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124791; c=relaxed/simple;
	bh=LSdkfeMvMw+slHVwimMQ7yZQ6hfL6ka4eJuJU/neNaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDh1M8GKo5utS2/bOiuQU/BDo4HPjVsB5vmXsuNuhf0Eki1u2/Bo8QEbG5ChGDYzz6ENOQB2apAU7qZMILM8vCfNS2SIP8uWhcbqkCikL8SMB/XhixsYylMtM80xr7uUZ5dNZUtDpSDMeqNca8uUj5yw2AGUSJvwo8s56saL71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=N/X1BdX1; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="N/X1BdX1"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id B26FE62281;
	Sun, 26 Jul 2026 23:59:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785124788; bh=vywjJXeG67uN9GmNy/A4BHdJ0NLFWgXHikyJQuuuDDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N/X1BdX17tiLFLGcPDFelNsuaebByPqYlyHZgy+NVAgTmzus9fTI+1Vqbk6derMy9
	 QvD3TmRrIRdepIp1y4Owkp03SkCm/HLlPOs6y2K9869Wryh1wdTkbm9J3IvVlCGRGp
	 hAf+whZkzaS4XYQjxybNtfLzOV1uAckut48rAwOD+sFSASX15VJ6tx2j5g9V984C93
	 BRdBArU3WSwHT2Uz6piiq2Sxvrcd4JUXc/x/kyxWyeIgZlEl9UH6CpeVCRdqC7MrlD
	 15NNRd891XArD9xDFVsBdmiB5LQ0NQxkUma4aOsg+bM8qVrMt2gVTeAG47Yje2tndF
	 ndZdc5kGsGq7g==
From: Luke Howard <lukeh@padl.com>
Date: Mon, 27 Jul 2026 13:59:15 +1000
Subject: [PATCH net-next v4 4/5] dt-bindings: net: dsa: add EDSA
 arrival-timestamp tag protocol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mv88e6xxx-ptp-fixes-v4-4-10b4020155fc@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785124760; l=1003;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=LSdkfeMvMw+slHVwimMQ7yZQ6hfL6ka4eJuJU/neNaI=;
 b=TQmN9d79WhxO26CveBdxma2NLLOLmmvmKYb8iPQnOJWteTCQh+dFLdyhnOUJgEgk/8Y/DqwvK
 wfoy/Z91g9ICYRHIYQrlzLTlCbdXGoL88iJJSOEfxPvBpp/fv9bphye
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Add edsa-ptp-reserved2-ts to the dsa-tag-protocol enum. This
EDSA-derived protocol lets a board select in-frame embedding of the PTP
arrival timestamp, which the switch writes over the reserved2 field of
the PTP common header, on switches that support it. Giving it its own
identifier keeps the wire format discoverable via dsa/tagging.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 Documentation/devicetree/bindings/net/dsa/dsa-port.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
index 4801204699534..8d12c8f1bd51e 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
@@ -53,6 +53,7 @@ properties:
     enum:
       - dsa
       - edsa
+      - edsa-ptp-reserved2-ts
       - ocelot
       - ocelot-8021q
       - rtl8_4

-- 
2.43.0

