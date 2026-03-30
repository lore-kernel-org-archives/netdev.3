Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650053B6C0D;
	Mon, 30 Mar 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866385; cv=none; b=TRKnGSWySTT+8C5UGMW+oBevf/zwQGOf30RY6SDGhkHs8gvURQdSjY7SANCi9S3m3Ho/DW5v6wSKbM/7vMOFO+rsAyLX7b0BEYuxeXIUeBrGTBA+S6wDH70JvoxZ9g3jbxnlD+5Ov/7svjR1f3eCYeZScdIFVljmxPh0E0JzAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866385; c=relaxed/simple;
	bh=lQozGgkB1im2A4LBkKcxJTZ33wzUKUdn9keHFK9AWfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZiah1tc/VKpOQGP0w9swkzIzSQo+pqP1kg6cHEzmcyU1JtkFFgMnX49ByJxFkBhxPkaBPqj32bBSDjo+x1p3p1eZBGPRQrakTjPsUxCUbH6gVyZf8UIe6XJIHEB52Awo6ALHemjVhk476EaqTjddLTPtErk/tBe74GOHK6hWXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtGcA+Q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtGcA+Q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25590C2BC9E;
	Mon, 30 Mar 2026 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774866385;
	bh=lQozGgkB1im2A4LBkKcxJTZ33wzUKUdn9keHFK9AWfI=;
	h=From:To:Cc:Subject:Date:From;
	b=TtGcA+Q9yNYYN6y1wK3PXJafadrjimAk5L7OFyU2p4r4RiIabv+1Ma//27xdGaKG/
	 MxVZmMcdcD+5xFK4JK/MAt4HhGyzSfvaNYTO8xcq1wqbtXAwcDIsRcsjp8ynkMgTut
	 8ms11r4eFJKF5nZz7KlWnl/MzU4Ry0Xsfe6Jb5ZAYI4gGjaWpU5k3Z6s+lPnZBPwrA
	 iJ5AzwCJ+9ssabw/C5346z/x3+xiZxudyn6nwOifLlztYVhLwy9r8Z2gp4Pph9N0RC
	 CReqcDkLqojLWN01/C8axejsn8YQRjq4QiR5F5BNyp0pdK4NSK96w2kpIcWT9S02JF
	 5UvI9ykjUwc8w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79p8-000000070qm-3sVp;
	Mon, 30 Mar 2026 12:26:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] net: refactor USB endpoint lookups
Date: Mon, 30 Mar 2026 12:26:09 +0200
Message-ID: <20260330102611.1671546-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helpers for looking up bulk and interrupt endpoints
instead of open coding.

Johan


Johan Hovold (2):
  net: hso: refactor endpoint lookup
  net: ipeth: refactor endpoint lookup

 drivers/net/usb/hso.c    | 65 +++++++++++-----------------------------
 drivers/net/usb/ipheth.c | 18 +++++------
 2 files changed, 24 insertions(+), 59 deletions(-)

-- 
2.52.0

