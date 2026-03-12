Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F23238C1B;
	Thu, 12 Mar 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322063; cv=none; b=AOYkOSn/EXQ9IIHfGwOneiGYdNTgHPEw+6e9kNGWJS0qn8VJwFIqdGwB6SFN/VUTl+tU9gv4EBSRxo4yTCWHugPBr4XIbALjeCvjeHQmFwKgDyK1k6HoWbq8eTzfBGLlFrr2s/f+NQ4Ew+zmZ+6699XH5AvQxGv96YInlYeurLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322063; c=relaxed/simple;
	bh=Fk3SurwGUN+jgIYQeLRRYUGd/wZxa5s7LHDzmEnFBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9imos3knmaLQB1t60wC35IOcG8YhUutch7ISBw8qeOH4mpeIKNgfP/t69TyaEYNGSZCtqIhJRQlEoFRc4MTdVL7XUx3txQ5Ee3g1/Q20bJEEBIYJuHBu2AZWglYvEzwJjLBzeI3YuNDG9KHfa1qaGyCEJ5RWsvZME+I2Iz+lY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D67BC4CEF7;
	Thu, 12 Mar 2026 13:27:40 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Stefan Eichenberger <eichest@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] dt-bindings: net: micrel: Fix KSZ8041RNLI dtbs_check warnings
Date: Thu, 12 Mar 2026 14:27:34 +0100
Message-ID: <cover.1773321267.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

"make dtbs_check" reports several warnings due to some KSZ8041RNLI PHY
nodes having the "micrel,led-mode" property, while the DT bindings
prohibit this.

Apparently the DT bindings are incorrect, so this patch series fixes
that, after a customary cleanup.

Thanks for your comments!

Geert Uytterhoeven (2):
  dt-bindings: net: micrel: Sort lists
  dt-bindings: net: micrel: KSZ8041RNLI supports LED mode

 Documentation/devicetree/bindings/net/micrel.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
