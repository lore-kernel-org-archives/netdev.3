Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71A51355E;
	Wed, 16 Sep 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572341; cv=none; b=gTcVl03hRYSWJECssn2gsuv1OHYfP8jwmGOmxKXe2ktYHOn8UP9ijC6ceqyiFrHLOqx9aCFo2BqsevoVwMMIC+bOpteFFiirOVq93c3BMnjOj9w2Rk7YDM7bMdOG2j5yK1bkP0DH7hwBP55hJdQh8e/oB4JacaVcqjmLRW6vRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572341; c=relaxed/simple;
	bh=bnAgSC1IhR3Ovn4jHLpHG7PeyCv1e6VhYqsMw5Pvcqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F25bg5w9jm9pFrrmUhisoRDw6iwatixextA/ris4pV5nSsePaMtQYiPCx9syI9Xqtx/8RilyR76+vi/If7khv+i1DjYzr9hRGSJ1kDttG3YsrkO18Ub3X8LJXEsaJd5z16M3fVdnP48zR6F2SKrlyGB+Qcr/4IBQNHJiN8JPm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=B63q/HcJ; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="B63q/HcJ"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [186.210.28.117])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 871731202B5;
	Wed, 16 Sep 2026 12:25:20 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789572323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QPexylYTpsjYKaaoSH0N4Gq0n8TUavrpvGI0O52dZzc=;
	b=B63q/HcJd7/bEjixYGkjRF05yDMUhtJtR+8BU5mAxJlgbpp7kspGRvhOmKUnAgZCF5Xu/e
	G643voAtKhDGqpnW0MoOhqciElP7+oTgbR0QofG5+6uNGrXTYFTBGwcJ0znwK71C4F/K3b
	BLysX7TKkC3EEQFsq2dkOKlIwDACk957oBfRGMygSWb8+b6YXGGQyWSW62tZh2rSu33+3u
	/JIAIjbDaFVy/CqMlVRVQBb9/uhBpOVfwxGb18JUv54niqHd7W+xWvQjAmQc0+uhjJObfU
	wxms0/VTeQSJHiNj5TZp0+vdaLALEmafpkPZvlpNMX4q1jotsRXH43wPc6LHsw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH net-next 0/3] r8169: handle firmware application errors
Date: Wed, 16 Sep 2026 12:24:41 -0300
Message-ID: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate PHY read/write errors through the firmware interpreter and
release loaded firmware if application fails.

This resolves the existing TODO in r8169_apply_firmware().

Matheus Alves de Almeida (3):
  r8169: propagate errors from PHY write operations
  r8169: propagate firmware access errors
  r8169: release firmware on application failure

 drivers/net/ethernet/realtek/r8169_firmware.c | 15 ++++--
 drivers/net/ethernet/realtek/r8169_firmware.h |  4 +-
 drivers/net/ethernet/realtek/r8169_main.c     | 50 +++++++++++--------
 3 files changed, 43 insertions(+), 26 deletions(-)


base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.43.0

