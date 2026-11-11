Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409669;
	b=RC/0ZEy6cWq3YCzdsDJUtxDMY9Tftp+3/PCCc6queVb6GpyIH0xvQM6uwtMsj4QYo+B5
	 JZf1zMc+SLA028DQziP6PewjMETLSGRBx3Nn0ksZDV8BpF8HiCsXDiegR6L/lhFEbG06D
	 BHjMamWS7dCKM7lSIi5CoB7IcufX/C8dj1rmtyaVVTnHoKlPj9DNiZkalUOziaYh6HebL
	 TP17s878h/jmNYNEhRtEyq7dTgIOy9oxyAtNnX9CM6/chDt4huxHprKZESCdgdW2u/DAP
	 dgTGCvXBn9hb0sTRgXAA9rKmeF+Dfw524uFmdWQV9+uzzmrabaHfFuaglVARx928jQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409669;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gjvqY0q2VNdgY/BezYO3dMK8jTxu6he+reKzNpDAnFs=;
	b=KMnftMVcc+1G8WxGG/WKiYgiMYIrLRuU6g1OqBA5yItd06Br/17kHmpgop5jZ3d+z7ji
	 7IhXS/iFz76EKiuzldKK/ALadzW2pGynKQEPFM9l3TMreyXbh87SDVPekki0uCuOmzFl6
	 hH2t93bYQeGIZrAiT5QpHtbudFrA5RfnXDwxZ1cz0xg2Ry4fvjYsJ+4+yxI0RGTPlIfC7
	 PNZ5yppdYfv29QR1v9jGoglMs6i/nd9ZrvyN3xeAYnhgvW5DLemDsO43sq+PF0YfuPFdJ
	 /LuTqKEMb5QlUsDjnXbt9BAQ6QUUoTuZkKS5Dx+8Jdp4DDd2GUqdzRTpL+opQkijvSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/tjUy+W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31489606A8BE;
	Wed, 11 Nov 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/tjUy+W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794409669;
	b=rv8uUqYLgoXlxXxt/EIHczRhXAQTvxZQWjaN4w2WPZulE2VnMDmJh+cmsPGBR5DnJy4o
	 IR/EgXaYYW4LDmroNnHl6ML+6u5XO/m3L0wnqj+/X+Tmib/h5cAhGc4u/7b8rMpW3Gnu6
	 mrlBtg7alfecvo6dQj+fWrCN1c9Cvy9Q3AMTfY82q8fG423ZqGHBobMDlSz+Fa2m7abq/
	 uTY+5itAAJUyYSaAuaobFXS7StBiv7f06bUuxxddggjrOj1eAmwDnfmw/QiBQEZ9Fr5Rw
	 sgB6/HsCaLCTSdTNrUw8VkuH9i8zmJPxHcioi2zxjF+pohA1v8vY/CoXm4oD4a5xiMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794409669;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gjvqY0q2VNdgY/BezYO3dMK8jTxu6he+reKzNpDAnFs=;
	b=WU9hOz2db3ka8GDCINUl4onHsTAKSm/IAo+QJcWaNWETh5LCNKTQdZONJxstWpomepYs
	 nt2cqStEuRTTMsZBsab1het1ntIGydI0wx45a+lN/nUdM2BH/V2+2hQF+UhLOO1aJQ/EJ
	 l8y+jBeqyMPvqzzR7aXn5HVY28ly3ygnZ1GQwrYV4jtqvONID5UUUXnCxulenUWHKU7Rd
	 Y5OcZCOKSLWRp9CmBqPtXygOokBV+XmN9BNcOrkAsrGodRmnerMm7EYs6/aFiw+Gdrgq9
	 Sho3OkUGbLYq0KXTKdyuKc4BDFtIIiB7Fz+5skCEQr1cgH5yzovf9R8LJDiSgem+X+A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B94CC1F00A07;
	Wed, 11 Nov 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409668;
	bh=gjvqY0q2VNdgY/BezYO3dMK8jTxu6he+reKzNpDAnFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=M/tjUy+WkTZqVZWOSkesI9r0vv7HyL/LSZBWb8AysyKfKfpO2E7zE7U71xcF6q2ks
	 Bcd5tq0HFI/vOzrXDEcsHnFnBoMJkzmEiHlKlAW7paZdst6a6BW1D470hTPyGTcnUy
	 u4MrCbLRBk+XN6BTuUWzhifBa6CnRAfaWUvXL5/d+d8fQ39D8+r5AAFFYdx1XnpX17
	 avD888iu7X5yALdTYjk/JKobT1ZIr+f8+W9da6ViNoUwS+lyz/u6iey1hdgengU9qo
	 euyXXDUFfszAsSbaxir1Fu8U1D/CkRkDxx+VmG9CATipv8dzsMrqqAA8zVtNabVqW/
	 0x8daSKZss/iA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F13D48FEB;
	Wed, 11 Nov 2026 15:07:47 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:07:46 +0200
Subject: [PATCH v2 2/4] dt-bindings: net: nfc: samsung,s3fwrn5: Add
 pvdd-supply
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-m52xq-dts-v2-2-063289405882@gmail.com>
References: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
In-Reply-To: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 netdev@vger.kernel.org, Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794409665; l=1265;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=L3UEvXwsJbgHO/GEznzm7PXr2KKeR3S/1EqK+t4yPzU=;
 b=i0VR4iGhTSmc8cV5jr++3UqpOeZRMViCIAaivmXMGkhdgtI+u2HPgQhzQswBXn7Dz15sO62pB
 lickrXv8lNWBNSZZFYbcRqO1ZgargNK/UNPevQYGO4fCJ0q4VcFw4bb
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com
Content-Transfer-Encoding: 7bit

From: Asdlerto Korry <korryasdlerto@gmail.com>

The PVDD pin of the S3FWRN5 has to be powered before the chip is
enabled. On some boards, like the Samsung Galaxy M52 5G, this supply
is switched by a SoC GPIO. Document it, so that the regulator can be
handed to the driver instead of being kept always on.

Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
---
 Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
index 12baee45752c..3c5a579a7108 100644
--- a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
@@ -34,6 +34,10 @@ properties:
     description:
       Output GPIO pin used to enter firmware mode and sleep/wakeup control
 
+  pvdd-supply:
+    description:
+      Power supply of the PVDD pin
+
   s3fwrn5,en-gpios:
     maxItems: 1
     deprecated: true
@@ -84,6 +88,7 @@ examples:
             wake-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
 
             clocks = <&rpmcc 20>;
+            pvdd-supply = <&nfc_pvdd>;
         };
     };
   # UART example on Raspberry Pi

-- 
2.25.1


