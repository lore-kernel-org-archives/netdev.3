Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A85192D97;
	Tue, 17 Mar 2026 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734571; cv=none; b=lbfSG4nEW/qUBHwjymZKSaz6RvbYXrMJKrwyiPGjSOHDIVQoMzfJIVAgNXBlVuKSjsGGr6KwAs3pflKAjF2pFqPRlkkskzfMG6AlZr9SMBQLlUju67fjyQogbh5s7ozHEjo4d7CYDdPaJv1xcXBleQAw6zz/kvJuERQDDi6znnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734571; c=relaxed/simple;
	bh=IZKww2otcBzDR0P97EA0n35AlA4634XqGNY7ER2DOqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDfSnSQRe9NFrI1AQGq+0ApxPALWOwCb3uTZyfW0rBhyKw/koFZOUk6X+a0FOqWQ0z/5QsqWqIIZVGy6aKOLE3VZqgaf263l/sv9EtRAKLZErYkKJG4M1xcS02H2a3E2NpzoLFWNzSwFx7j8OeQ2JaSxQksjF5ou+iKtmR47C6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5758C4CEF7;
	Tue, 17 Mar 2026 08:02:48 +0000 (UTC)
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
Subject: [PATCH v2 0/2] dt-bindings: net: micrel: Fix KSZ8041RNLI dtbs_check warnings
Date: Tue, 17 Mar 2026 09:02:44 +0100
Message-ID: <cover.1773734298.git.geert+renesas@glider.be>
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

Changes compared to v1[1]:
  - Add Reviewed-by, Acked-by,
  - Fix KSZ8041RLNI typo.

Thanks for your comments!

[1] "PATCH 0/2] dt-bindings: net: micrel: Fix KSZ8041RNLI dtbs_check warnings"
    https://lore.kernel.org/cover.1773321267.git.geert+renesas@glider.be

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
