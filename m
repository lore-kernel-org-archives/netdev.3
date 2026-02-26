Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C50337100;
	Thu, 26 Feb 2026 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103821; cv=none; b=hXsLyLbMV4y/t5PSApDOekLBJZ5NVDNc3avlM5rqeWW6g72zlsNYfY1d8SU6Wl6rjZfk+Fo3BfIv1lXiyrYX9h4/46sW9bkPgr6UkEgiCnHsmIKS8rZY6rZhuQy3tYt3Jyh9sgEzkoamQPvnQKOiZJIINt7gwdL8UGFJ0+9J9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103821; c=relaxed/simple;
	bh=7oga6iCNUk9jRhMm4u+2UIsjtpytJlnDqvcuGIHXtRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OI1i8clYzLskxC30mJZPWi+0b/c/LKskRboHEQ17a/cYt5ZX8LSiZ9eZ227Y/zPLq5EMgKRc79e8fTgn944iLhPreZjJgEktQDDKDbaptK+Qlq759VAQa30d8qPsls7njWj4bil7KnwJf1WNPVOInD8TWjMtIB92C8RzATQ40mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvIKm+wo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvIKm+wo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC34C116C6;
	Thu, 26 Feb 2026 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772103820;
	bh=7oga6iCNUk9jRhMm4u+2UIsjtpytJlnDqvcuGIHXtRc=;
	h=From:To:Cc:Subject:Date:From;
	b=TvIKm+woEih2Tes1jsGgTSmm26ThO9+CG/I8T5F1peg2+E6BctWWl3tQBcXY70MUi
	 EOZ/ZYGTc1QvKl89ZLkMFUOXxEl2ipsrwNISkgF+vh+S2/B6p+2YCOeQxh3vkYWYNJ
	 CkQfOoIvurgTN1UEbYV2c5hh8VUC+APmvFX7V7YuhJqq+9qvzHtw+rpAkxQW9elBGV
	 /mZYxqn48JXsoHs7KFNcMZ7fbsg7hS2NVPTq6LT46NgRBYCMwQfVSdkjwE2CgWAF1x
	 p3AaiUzPhK0DITD9wStKzK6D/CyYwpuP9FN7dJNQSNKV6o975BLMa3xim0ptrRWctf
	 zwTpz4QrdHk9Q==
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
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 0/8] macb usrio/tsu patches
Date: Thu, 26 Feb 2026 11:03:15 +0000
Message-ID: <20260226-snowshoe-amusable-6716d4ddea11@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3780; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=UgZEol6xQ2MytN1F7eCnsymp6056llsTw5xmuhOo5f8=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkLNMpe5k09cf7y+pVVPKlbeJ5rehYprjk02SdHsfv0T oEzE+c+7ChlYRDjYpAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBE5JwYGX5tLahvnB1tadM+ 8exuCxWPffpbb5W94GFIrNrbEVj+6x7D/wKVk/bVKfqz3oswxK1jC+Kf1eGw8lbWrOxpYse53y6 K4AIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Hey folks,

After doing some debugging of broken tsu/ptp support on mpfs, I've come
up with some very rfc patches that I'd like opinions on - particularly
because they impact a bunch of platforms that I have no access to at all
and have no idea how they work. The at91 platforms I can just ask
Nicolas about (and he already provided some info directly, so I'm not
super worried at least about the usrio portion there) but the others
my gut says are likely incorrect in the driver at the moment.

These patches are fairly opinionated and not necessarily technically
correct or w/e. The only thing I am confident in saying that they are is
more deliberate than what's being done at the moment.

At the very least, it'd be good of the soc vendor folks could check
their platforms and see if their usrio stuff actually lines up with what
the driver currently calls "macb_default_usrio". Ours didn't and it was
a nasty surprise.

I sent this once before, but got no responses, maybe I'll get some this
time! To that end, I've also dropped the rfc, since noone expressed that
level of passing interest and this does fix a problem on my platform.
I've not marked it net because I don't think there's that level of
urgency, as the usrio default on our platform does what we want, and
we've provided a temporary solution of disabling usrio in our match data
to the reporter and in our downstream tree.

Theo, you added eyeq5 recently. Does it genuinely have the same usrio
bits as the at91 devices? That you send patches dealing with phys makes
it seem to me like it doesn't have the usrio stuff about mii modes..

Cheers,
Conor.

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
CC: Neil Armstrong <narmstrong@baylibre.com>
CC: Dave Stevenson <dave.stevenson@raspberrypi.com>
CC: Sean Anderson <sean.anderson@linux.dev>
CC: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
CC: Abin Joseph <abin.joseph@amd.com>
CC: Théo Lebrun <theo.lebrun@bootlin.com>

Conor Dooley (8):
  riscv: dts: microchip: add tsu clock to macb on mpfs
  net: macb: rename macb_default_usrio to at91_default_usrio as not all
    platforms have mii mode control in usrio
  net: macb: np4 doesn't need a usrio pointer
  dt-bindings: net: macb: add property indicating timer adjust mode
  net: macb: timer adjust mode is not supported
  net: macb: add mpfs specific usrio configuration
  net: macb: warn on pclk use as a tsu_clk fallback
  net: macb: clean up tsu clk rate acquisition

 .../devicetree/bindings/net/cdns,macb.yaml    |  15 ++
 arch/riscv/boot/dts/microchip/Makefile.orig   |  26 ++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |   8 +-
 drivers/net/ethernet/cadence/macb.h           |   3 +
 drivers/net/ethernet/cadence/macb_main.c      | 137 +++++++++++-------
 5 files changed, 131 insertions(+), 58 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/Makefile.orig

-- 
2.51.0

