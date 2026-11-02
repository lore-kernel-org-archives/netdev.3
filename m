Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585049;
	b=Jp6ySNy4jKGhh5cABNyJ5Kgwyo5fNsH1O2ncpj0LR/fxJjLqJTzTxi7uJIgPlyevjqjz
	 6L1UKi2Sm2MqAVHoQ6o6yrITe5hmnEoKkbunnX8Gq4yzF1Iu/U6VOGl4k3Bd2t6hJiJne
	 AX3wB2Y5VOszbQZNXPaSnlGD4ZnmQWFrGbrJVrYg43rni+AheMi9gJRr0xcz7znjammDz
	 CqU+bPa/xXMQ/+dfUuPEGD8C9S1ppbWIBWbSZpgZIRiLK1qx/bDUVo3wPqNkOL1jU+keY
	 Zk++WEqvo+ZgUHFSO0Iz7BRerY3Z++UFQU5vq8JBXhHUpuMPvouD27qNb13SDKqwm9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585049;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EEbpi7PJ+4q9acxRxZPPipTgrTyR2mdkDd/Q2MjCxUI=;
	b=hIPYSf5F56IKLXFF+qZc92XOK22keY9UGbbJj9VGe5o0M10huEyDozzbqPJdb1LW2unQ
	 TNyys52d7RUJd32dRhsrzX2+AvQ+/ox07YDGZlOMk8HtT9FWw7QhabCSaZ3AWAeiEQjn3
	 sx7wMrXapD0qNK0f+6rMaeMRe90e5+DjHuWojGjSVaQGDP9OGMpmiNWweBeHRP8H7cp5+
	 oVOVIDebKjMj1u868H1Hqme/8t3qjr4W3mI8dZxtzIHPB9ocT3ftI14dRSIon4zPYrw/l
	 ijsIFzArVxElZvj1VquVtiAYnPOTMrBQsxkXmTNGtjxwKzicWKCOmxnEsfo6A5bmExQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ikpr1yP/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B9606A326;
	Mon,  2 Nov 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikpr1yP/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E3C1F000C1;
	Mon,  2 Nov 2026 02:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585048;
	bh=EEbpi7PJ+4q9acxRxZPPipTgrTyR2mdkDd/Q2MjCxUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ikpr1yP/BDH+G/tY5bVXVH762hJ0j/qXhMh4OLtbq2Jrn35JaxyXC96D6sLsjmrE4
	 KPbVzJJC+FosJYbfIowK+k57ZRWBuOKbPrYlDbhGAXM4cgtwz9V26qPqPX10VnvMYU
	 i4UO1TQEjtEIhP4CYVBehDL8o9qxd/8wlU1umuQsgHwFKmphFgiliuWIl/96jYOaBj
	 VwzHHcQ088BatZNotNpgFGjQvf9uZEuCR6La2nMBhwHEt1DwlncQ2C5otlcnTc+zjr
	 BtJsCRdyVuqnKMumA54qEtXwIAIWpPxCEksi9NDtf9dGgbiCxySewoIhiBk99wG3rY
	 Oc9RvZ0f3GYoQ==
From: Brian Masney <masneyb@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Stefan Wahren <wahrenst@gmx.net>, Phil Elwell <phil@raspberrypi.com>, 
 netdev@vger.kernel.org, James Clark <jjc@jclark.com>
In-Reply-To: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
Subject: Re: (subset) [PATCH 0/3] clk: bcm2835: describe the BCM2711 GISB
 clock for the GENET MDIO controller
Message-Id: <179358503716.355577.9187303706042543606.b4-ty@b4>
Date: Sun, 01 Nov 2026 21:03:57 -0500
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-5d8fe
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=jTkvZ/L7zswWdeg8kLhuRySRfybPm2VPf54LiwO8r88=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLKev59w/eKliCdHdSStvmwWPsgaJXbK/eeLpokJ3fzFX
 KsYJAWVO0pZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZjItBkM/1O/vdGbIfTsxdZ5
 Xybucvh/+nWaJe/TeVXnTx05Os/618uzjAzPZDOsm0wfL/v4ZCmn3M3XunJfhV7Lr5TcsPwqz1/
 5Y0c5AQ==
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Tue, 20 Oct 2026 16:58:08 +0200, Nicolai Buchwitz wrote:
> clk: bcm2835: describe the BCM2711 GISB clock for the GENET MDIO controller
> 
> The timestamped MDIO write series [1] needs the reference clock the
> GENET MDIO controller divides its MDC from. On BCM2711 that clock is
> not described anywhere, so 5/5 of that series hardcodes 200 MHz behind
> a compatible match, and mdio-bcm-unimac's clock-frequency handling
> assumes the 250 MHz of the STB chips.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: bcm2835: add the BCM2711 GISB clock
      https://git.kernel.org/clk/linux/c/af7994af5228
[2/3] clk: bcm2835: register the BCM2711 GISB clock
      https://git.kernel.org/clk/linux/c/ab94dbf30233

Best regards,
-- 
Brian Masney <masneyb@kernel.org>

