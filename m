Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210DA3B0587;
	Sun, 11 Oct 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724374; cv=none; b=Q18YPjHwG7gzyECzUoIYUmJPksvlztSSoc7YyIU2/p27rRK65E9aq+4sGamIQ3aioKWKnt+k5XuikktikEzhY+21DPROVBTCYmyDs0uaY5oMU+k9DKzNrdikyTMGROjzAVtPq2lN+1hWRbyCKeLdy3Athn/HesrUPWZWVavFy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724374; c=relaxed/simple;
	bh=+rhbf1TUuMeAIAiZ3OqBQvQEbKTOw8e31SX4gTUCD14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVc6gofM6gnx5u4/5ivHEEJ9keKyvtySyJeAAfcSMyXKdL1sDgTYi81sAQ1XBb+gqjIvHutcDhPFyaVtdgP02N3n6Gu5elGVSqYqFl+WecZg3bPsk5J8iQkUO6GThhWtOnttubAO5nEZ0St9nbyixDU73a6MmVfyPD2nLnbe9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNDOMgB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNDOMgB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827C41F0089B;
	Sun, 11 Oct 2026 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791724371;
	bh=xguvO7Z0rKWV6cXidAMAFxVoApZEw+GahybnuKsVk3A=;
	h=From:To:Cc:Subject:Date;
	b=hNDOMgB+fS0BQfzcrRKQha1hr0RdNXuoKaX3n1NuVpYio9PBOaob4ZfgzcjIcOAv8
	 WmpqVNn0Qo2CwZgKQzz5wz6Y6BC/Ck1gON2Pmxqi20QaG0T/OBa2vlPMzc4ZtX0eNS
	 V8qdEqJ6o/EU3Pgq/dt/p69dZN1SkKU36yn8V5f0htpM3sxcFFsgQ49XYCBAShLYxH
	 HgZqjVeVPN4RqHokaHcAOQwdmoigU/wENvYSZ5dXDzP9aiR+umwtxsuDX6ZEE8cmJb
	 xy6DYwnsCBWcmDbnMGaykI+Zu1q9L1ReOVMBKnz4++w7KLnvh4uojVmh3h0hFoJLhG
	 qSc39T/c7Bqzw==
From: Thorsten Blum <blum@kernel.org>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Blum <blum@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: realtek: Remove unused buffer from struct realtek_priv
Date: Sun, 11 Oct 2026 15:12:10 +0200
Message-ID: <20261011131208.272131-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=559; i=blum@kernel.org; h=from:subject; bh=+rhbf1TUuMeAIAiZ3OqBQvQEbKTOw8e31SX4gTUCD14=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmnuzWmSu99aH3J/teP9T+X8PrLL65n8cjd5LykcZ1/i /x1r4NfOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiZh8YGW4aiIb/cKo7XX+p I+0/Y3vRlHcyU8z0GAR6Dnx3KF1zRp3hvz/zTMvaOP9ZzjPcwxf9CPq0fjf3UYmCGP9lX849/jx PkgMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The buffer has never been used. Remove it.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 6e0148cee8d8..ca3a71876599 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -97,7 +97,6 @@ struct realtek_priv {
 	int			vlan_enabled;
 	int			vlan4k_enabled;
 
-	char			buf[4096];
 	void			*chip_data; /* Per-chip extra variant data */
 };
 
