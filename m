Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1273A9628;
	Fri, 15 May 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887006; cv=none; b=H5bBKctDVzxw4HQSVqS9sQvkwLOFq017+qeCCMXmNiPEJoSHRUuAkvjMTVXMGmOY1jPG5zr+DIVrgnutN255eqHwh+NbViPt1tA++BzvlwMfkJkG5Zy2WNcIJGXJxtHu5zha+W6cZqbG8AK1wpTxLQPR+KdkDVUFK6WYijJBjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887006; c=relaxed/simple;
	bh=ZI6fKrmGoJUsCZdVQMq652fJqiGkQ9QqBRTNwO6ylUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEkRN7ESsxQvVpFK4nSA8QCtPBtlB987rpqOCXPdznkEtGy0pIR3M2or2uM3RDfaxC2zJpLsLV7I9LQLktV9tiUNsylSxzRwqHN5jhZHE9pqLPPIPQZzGcsr541JlQjPeaPEtiK8Y+ux5wKgkS/hiwHnZKuDUkFK3SWrFDhkh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3az1tUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3az1tUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E6C2BCFA;
	Fri, 15 May 2026 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778887005;
	bh=ZI6fKrmGoJUsCZdVQMq652fJqiGkQ9QqBRTNwO6ylUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q3az1tUywu3OOK+vqGa9lOF+mXcaWtj52TA6ONOQrh0FIl+WoHalOqq5NjuhzMD0U
	 UpgZbcAocCI4ASHvp+g8oLQM3fcERxWRI8xyGZnwmjOFh2trvTKiqqSRRmcKxHg4Yv
	 f5uFvuAMAR4hpNrXSI9g8Ue1XTxvJ86SfE68Ehkvniz82c+v+izPVUzGA0vmKxJ/ZZ
	 SdiFx5z0CC7Nmg59UfIFCf0YL/VmuoNVC+sQA7UQmG6CHd+enNGpl+vutCEvkbk6SZ
	 +zo0ZKS80RqUsdVTfmA+/H1MM4AP6C3aBVwW6NUya9BatnsxFNwkK1a9zWwwZL0b4l
	 pBHiJBberFi9g==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 16 May 2026 01:16:14 +0200
Subject: [PATCH 2/5] dt-bindings: net: dsa: microchip: Add KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-ks8995-to-ksz8-v1-2-70d0ef4aa5f4@kernel.org>
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
In-Reply-To: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

The KSZ8995XA is just like the KSZ8795 and KSZ8864 a Micrel
product. It was renamed from KS8995XA to KSZ8995XA at some point,
but it has the same properties as the KS8995XA.

Be careful to use the full product name in this new compatible:
there is also KSZ8995MA and KSZ8995E which are not compatible
with the KS8995XA.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 8d4a3a9a33fc..4ed13870ed3a 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -23,6 +23,7 @@ properties:
       - microchip,ksz8864  # 4-port version of KSZ8895 family switch
       - microchip,ksz8873
       - microchip,ksz8895  # 5-port version of KSZ8895 family switch
+      - microchip,ksz8995xa
       - microchip,ksz9477
       - microchip,ksz9897
       - microchip,ksz9896

-- 
2.54.0

