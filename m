Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209473A7F6D;
	Tue, 28 Jul 2026 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238595; cv=none; b=kmcgtsmZDxyIxKxOIo978zW1s2jwpCOOO/UyphgOLU747J9Z27958lyo0NQQrHl5xyXPj7S5sqdbHvOZxPD4ja/ur39KAnUjoZ0bMibPu/dswmVNqU0oFFgJ7xU7s/JtfuD5U5FscJpNJdjQIrQhiu2p7nAntLRAkGJb2Cu9qX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238595; c=relaxed/simple;
	bh=lU0S04zuwyZ975dUWRkkOiI8kotVmZCbY8hF2rFK4to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNagSTD2fvdrnvkxAhjP+yURAv8s+ffjrvcgoju8z+SG18TXLqy4st8kAyJttmaQORx1NpFq9DZ8ouFnCJw6HgDxN26E84cEt1pKqlOJMdb2EBuVVan452kJU7XO+nr4QCQIfKYH7asqEfKCgf9aSjfUY52qUhwUJnijV+SBLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+GSRIzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+GSRIzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EA1F000E9;
	Tue, 28 Jul 2026 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238593;
	bh=uX3pP76S/qlTRKFBZVbxoy2xc8qbjMlkLp0qhkXmDKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+GSRIzMqHHcvajLyRfyxs/cTin3AHBQyjsRiAKR/iFMi2c7M5rjjZmxFoj6oS450
	 Z8IMiGVgxh8dYNlS/ystcEW7Sr5tXoj+JuzCcOQETGaTgfbjmM+/Byj/2vkMhWA+Ie
	 Y3WI3uoMdpmGgMfMZ2fA3Q1zoMC2e8opztjt64gs87VI0Wa2puTeLLksOR4oDpZ4l5
	 wJXiZK0waQeWI/IexjAEAVVAyU4IwZ99E1igp1uV72tV7GMhtMmIiXvjC84ZLBtdMN
	 RsD89T+wm4EvAOxJ4az4TyC603AKAbjROJJnitOFndsaCmVRoHOXek4OcpIyQOtWx+
	 Yjl4V11OiWhXQ==
From: Yixun Lan <dlan@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] riscv: dts: spacemit: Fix phy id check for the phy
Date: Tue, 28 Jul 2026 11:36:23 +0000
Message-ID: <178523830524.623317.15821976156314944479.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725005804.373698-1-inochiama@gmail.com>
References: <20260725005804.373698-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 25 Jul 2026 08:58:01 +0800, Inochi Amaoto wrote:
> As reported, the phy framework can not detected the phy id correctly
> when reiniting this. So add the phy id compatible string to the
> etherenet phy, so the phy can be reinit successfully.
> 
> Note: separate this patchset as two patch for backport if necessary.
> 
> Inochi Amaoto (2):
>   riscv: dts: spacemit: Fix phy id check for the phy on pico-itx board
>   riscv: dts: spacemit: Fix phy id check for the phy on com260 board
> 
> [...]

Applied, thanks!

[1/2] riscv: dts: spacemit: Fix phy id check for the phy on pico-itx board
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=6d6536c880febe2340d8d388f42660eccff5aa81
[2/2] riscv: dts: spacemit: Fix phy id check for the phy on com260 board
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=9db839d52ccd9af67d460cb9ac893276a74b88e5

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
