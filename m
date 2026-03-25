Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0B313545;
	Wed, 25 Mar 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456130; cv=none; b=DvdkrF5bZtHi7xKNec9+bMYVMpKdN1PiwDkkLcNNvid2BJAD1JZQJPqOgcHYJxShmElyVsR5OSQsu9MyL7PARrzqwUNIUqMf1ZLAgAPN5Do27ZNaAVYuIXQhoZ5zEKIhW9FbpgNlHKIZB2TBVTxkz7SlWIkbtEoM3jk6bSoxFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456130; c=relaxed/simple;
	bh=WNZw/U2oAU4OJgjB6cQyLDNDoaTNtsOZD/HEuVp7Pbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i/ngvODDgYBoJwJ3tJqOV21YRYb6VlaGw/zr/DsqRoql44OXFqrGvGNRWpC4o0TqkQSdvYMYGvAXCt6FDGwb4d2Xlmqd46tqCzd4C7St/dPpRp181fO5zA4qIg34JenD91ZOLgQKPpuYWI82mRnKpU/AjKz7byiDD8M6z1gG3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMKrcgGa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMKrcgGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C4EC4CEF7;
	Wed, 25 Mar 2026 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456130;
	bh=WNZw/U2oAU4OJgjB6cQyLDNDoaTNtsOZD/HEuVp7Pbg=;
	h=From:To:Cc:Subject:Date:From;
	b=uMKrcgGaSeQelsRUAZyRupsU/0sDVUnoYKyXghFybejtUT7kmuR8QC5S8FYhYt6Ha
	 UzebkfnfGQy7goGDYwTxTce/sELGBItC5a/x23ug59n7I+gOnizw9bpxoBEOGnsSd3
	 y/xQG1kIaCGJBlIrfOSXIfaD7aOi/mvLC2BPx7C13lEq2kDzvs6cRcXRhA12G+RTIx
	 zzUney5Ia8mH2+tkFayK7g+16QyVAZFXt5uzcVtEzWHXwu0MLn56Yy7hvvoaOOtNgM
	 DPgYbq/3QnOywhxv5IKvKvD6ZMNqWidtKKKjQsmW9MXpFyZO33oH+rlYm1xNk9kUjB
	 DqkSo0to6t89A==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 00/14] macb usrio/tsu patches
Date: Wed, 25 Mar 2026 16:28:04 +0000
Message-ID: <20260325-unsterile-flail-4c7729750dc4@spud>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5hpAVVar6EkPWWk4KHTwXKK+B0QHyBaC3geYzz7Ou/8=; b=kA0DAAoWeLQxh6CCYtIByyZiAGnEDRuhaR9JXeci/JTJe64cbKNvK3MidPDXlfqb8tM0zwQJO oh1BAAWCgAdFiEEYduOhBqv/ES4Q4zteLQxh6CCYtIFAmnEDRsACgkQeLQxh6CCYtLP0AD9EHMJ WLBuCuRRdOGegE5UsqxhTzQGypqZxpzLluDWJ+gBAKrF1vYL4b44YQx+jeawhi2N1KBVnLftH3v lv6ZVLvAB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Hey folks,

At the very least, it'd be good of the soc vendor folks could check
their platforms and see if their usrio stuff actually lines up with what
the driver currently calls "macb_default_usrio". Ours didn't and it was
a nasty surprise.

Ryan and I figured out that the sama7g5 stuff is not actually using the
same usrio bits as earlier devices, so there's now more patches in this
series to split them apart. I've not tested the split or the new
property due to lack of hardware, but Ryan has.

Marking this stuff net-next, because although they're fixes I don't see
any particular urgency, and it avoids creating some dependencies between
cleanup items and the fixes.

Cheers,
Conor.

v5:
- rebase on net-next
- revert one of the commits that landed in net-next in the meantime

v4:
- deprecate instead of remove existing devicetree property
- pick up Theo's patches

v3:
- reorder patches
- fix smatch issue reported by Simon
- add patches reworking usrio handling of clken/refclk (and remove the
  issue the llm reported in the process)
- add a new devicetree property for refclk selection, replacing the
  existing one.
- drop the dts patch

CC: Valentina.FernandezAlanis@microchip.com
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Paul Walmsley <pjw@kernel.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Alexandre Ghiti <alex@ghiti.fr>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: Richard Cochran <richardcochran@gmail.com>
CC: Samuel Holland <samuel.holland@sifive.com>
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: Dave Stevenson <dave.stevenson@raspberrypi.com>
CC: Sean Anderson <sean.anderson@linux.dev>
CC: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
CC: Abin Joseph <abin.joseph@amd.com>
CC: Théo Lebrun <theo.lebrun@bootlin.com>
CC: Ryan.Wanner@microchip.com
CC: Kevin Hao <haokexin@gmail.com>

Conor Dooley (11):
  Revert "net: macb: Clean up the .usrio settings in macb_config
    instances"
  net: macb: rename macb_default_usrio to at91_default_usrio as not all
    platforms have mii mode control in usrio
  net: macb: split USRIO_HAS_CLKEN capability in two
  dt-bindings: net: cdns,macb: replace cdns,refclk-ext with
    cdns,refclk-source
  net: macb: rework usrio refclk selection code
  net: macb: np4 doesn't need a usrio pointer
  net: macb: add mpfs specific usrio configuration
  net: macb: warn on pclk use as a tsu_clk fallback
  net: macb: clean up tsu clk rate acquisition
  dt-bindings: net: macb: add property indicating timer adjust mode
  net: macb: timer adjust mode is not supported

Théo Lebrun (3):
  net: macb: runtime detect MACB_CAPS_USRIO_DISABLED
  net: macb: set MACB_CAPS_USRIO_DISABLED if no usrio config is provided
  net: macb: drop usrio pointer on EyeQ5 config

 .../devicetree/bindings/net/cdns,macb.yaml    |  71 ++++++-
 drivers/net/ethernet/cadence/macb.h           |   8 +
 drivers/net/ethernet/cadence/macb_main.c      | 187 +++++++++++++-----
 3 files changed, 212 insertions(+), 54 deletions(-)

-- 
2.53.0

