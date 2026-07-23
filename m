Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA63054E4;
	Thu, 23 Jul 2026 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848156; cv=none; b=RTheGNizZiJaA4ZMjyer5vuJ9iccYOAogipQMgoMQ2wxfIqxhWtgCVzPyfkT3h2gzSzNUFb3Jij0arnjfDrYOs3gPWmDU92tSh9+fjlFSSLfO58LtZl0XQe4fabQoMyeqv1LB7HPa+i8cUrb9d/NKtUhuE6SNR8flP7LsnSYDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848156; c=relaxed/simple;
	bh=p1gRB2PzlwcRqzmDrRYk7SlcM/ROTsU5ElkcPRvh02Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fRj56X4T6qJHrUHWmL3DMnCzpi9OfvAtDKKNTrxq9KCTF5ivJTQH9L5rqo7Dc/TbIT3rPx6+SqQnzx0FeQWt56kMwveWYnAuzFSj0Q0yv/gydZGQ7/BFHrcAN/ggSJm4kFgdL82FG7h+al8EVVCCjylym/eWKQ6NE2vxrEG4LmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7P/Kyvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7P/Kyvt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CE48C2BCB8;
	Thu, 23 Jul 2026 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784848156;
	bh=p1gRB2PzlwcRqzmDrRYk7SlcM/ROTsU5ElkcPRvh02Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d7P/KyvtKj8BbNIOJkrRZ4supkAnYxr7hOYjN67xnusMJdba/MlAI+8sd168My28X
	 QLVRqYz82KovZby7Ji9peKnUDK5ZgbXymXj/s/twwTuTqQi3m3f3B29k2k861VNEcZ
	 GFDTMSOX2RIBkIxS1lU1KnVWy78kIsm0JVhlQ6kW6fCU9lgyFia6IxCwolgX9XCtvJ
	 sE9n0d6GYhVAoRoKuK/KFUJnw1ISOK/gwqgTszwXiUYffG8JX+DmzRW6XsxsPWfseX
	 VppYdE+ryvpd+/4c1HWsPRbd7FhxNI3bhPv1YsIrMgzDQPsZJJDpjn/TvwiZya5fuE
	 5XfPsbRgg5VZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB40C531D0;
	Thu, 23 Jul 2026 23:09:15 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH 0/2] dpll: zl3073x: add Microchip ZL30643 support
Date: Fri, 24 Jul 2026 01:09:11 +0200
Message-Id: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABefYmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMT3bT8It3SguKSotTEXN2qHGMDMxNjXYskI2MjM/MkS3OTNCWg1oK
 i1LTMCrCx0bG1tQAMf9AAZgAAAA==
To: Ivan Vecera <ivecera@redhat.com>, 
 Prathosh Satish <Prathosh.Satish@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784848154; l=1025;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=p1gRB2PzlwcRqzmDrRYk7SlcM/ROTsU5ElkcPRvh02Q=;
 b=z5cIm8kz02Naw4qoK+Ply0iQLput0QY6Q7kNGR9pPAe7gSj9tcAuVItTh/KYOiH7Vqehfb804
 uUVJC+KzSr0BSZCQE7e5ch65EuhKH7E9wFxuMMyhtvZYlBB5u5vPUby
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

The Microchip ZL30643 (chip ID 0x0E3B) is a 3 DPLL channel member
of the ZL3073x family.

Patch 1 adds the binding.
Patch 2 registers the chip in the driver: the chip-info table and the
I2C, SPI and OF device-ID match tables.

It was tested on an LX2160A board with a ZL30733 and a ZL30643, both
are probed and they expose their DPLL channels.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Vincent Jardin (2):
      dt-bindings: dpll: zl3073x: add ZL30643 compatible
      dpll: zl3073x: add ZL30643 chip support

 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml | 1 +
 drivers/dpll/zl3073x/core.c                                   | 1 +
 drivers/dpll/zl3073x/i2c.c                                    | 2 ++
 drivers/dpll/zl3073x/spi.c                                    | 2 ++
 4 files changed, 6 insertions(+)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260724-for-upstream-zl30643-8b23267b974f

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


