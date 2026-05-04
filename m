Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449E3C2782
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908763; cv=none; b=nGMsrcx4HVZINDilmJh9yQdLtndGWzdxrg0lwiQe+Zv1PhJ72TfuBwVQGLswJslEebMheFI/MQajKOaY5NyxZ2e3PyEuLXyczPfmz6DO55633WF1HDpeUyZo9R1ll2CXCjd61SqTXkbaS8FWb9x4kkTKqXpZbeO8WszLJiKlZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908763; c=relaxed/simple;
	bh=gab0qtlvfknerI/pBhkJBoBSMb610TfLqUBMn+lcgdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI1tLy5dI+MxqSi0MROwR613SLQR+p8UxsH8BcAEEml9a7HYg5zY9KYjs37ZIJk2JKBwGpEv+Cnz3Xx5OpxbmY+r2IJnMG5Fo94Avu5sFE7OKAhCeUlJJCyKSGE56Ht25BgkePtPO9rVbGJz4L+OMoRwsMFo30vhk6iA5unyQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2j4RLyS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2j4RLyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96817C2BCB8;
	Mon,  4 May 2026 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908762;
	bh=gab0qtlvfknerI/pBhkJBoBSMb610TfLqUBMn+lcgdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2j4RLySl89Hh5YZx3YdNqoSQUyXJbJwD7iojtOZIVHWtbeMjO9lV25dfU27QBge0
	 FQVbcK/sAbHIC4XefKPbysOkPw4/Imsq1QNr6Z3WSvLssX18VbM7GNZYIE1vWIyLVh
	 FPGVmqzMTfbAGy/v7OpLGxGzwlBEXgqI/zLiwFpCzUfDtLM7vVYjvfD80xczOyAwZx
	 ZvQxjzHsH99aiwN/yos3v1gC1Au1kND/btbEtFl3qHN18EtjnhuvPhTkuNLbAUXa0e
	 Cb8WA64kv1qz51Kc9mCz2vBQT6OOO5BXwaTzJNTV+84m6dX+RvUTSEe9c9l8DfDHKv
	 RsDpgTgFhLXXQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org,
	Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 4/5] net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
Date: Mon,  4 May 2026 17:32:26 +0200
Message-ID: <20260504153227.1390546-5-kabel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504153227.1390546-1-kabel@kernel.org>
References: <20260504153227.1390546-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 9e5baf9b3636 ("net: dsa: mv88e6xxx: add RMU disable op") did not
add the .rmu_disable() method for the 6320 family. Add it now.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b55a9d4a1ee1..09da154f80d7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5195,6 +5195,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
@@ -5248,6 +5249,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
-- 
2.53.0

