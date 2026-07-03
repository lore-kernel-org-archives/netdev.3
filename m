Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B2C37DEA4;
	Fri,  3 Jul 2026 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060996; cv=none; b=sJbBK/wiscyQlm8MT5KmN2G3egvfvqCmDZf8m3mrUJYtwyLympWVb6kb4ODb6yQu8P9LMPet3WThAGajVrpqzs2roT1BCHjdYTqxvb3RWuhkVcffwm6Ra5fyjxzSZKhkxvgakSCr+n2ksR1PbqmuvLvn6D/tzU/OS9FleNWtDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060996; c=relaxed/simple;
	bh=c9uf0pu6UF7qvElQMOsdcLzQ5NtMp7huDoIEjoaG0Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6kyOE1iFHSORoUr/3SgAItF64kJPmxMgNI2KzI76ME0l3kTgibttuho4KP609mUzIco9k3HJUES2nt2lCpDVDs0nB8mtphUUrO8ASmUh+f33mqb4hfwUawq9Ys4thI1Ch/U2crifjQ/RtLBGvsLB65w0Z9LVr63VVg7wwv358w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=IHdv5FzI; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="IHdv5FzI"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 1A27960D44;
	Fri,  3 Jul 2026 02:43:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783060993; bh=wqKtKtpaqZQnbkh9Y0smahooXHfeCJZ9/llRvSIvbDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IHdv5FzIzszmvNN7W/vnAL6OJReRlev2nb1SkXsPU0X4fyBvL8fxmOmmTqelsCHw7
	 hGADFOaOYt3/dksEbdrt6RiBqu1cL+HKeEMOkL0CbJQrtZIB0B3e0cZ0Xk05fnQ8+C
	 vLVzox86QAjWAx/ELG5/DjlT0R0G5WVKd/k+GaWXgs51UMIUoeD4DiUeSRRgcDzUxf
	 Me5lacX+atnDsdJvrXyLptINQEKMUvq+mJPBbfPpYzIzvCdX9buYzQVVdCtRiUqmWH
	 Ej9SuxSQP0HNfFhLlCXmJxozXYYoZj+ERlhsTDSF4qJziXNCCX7E/q6gbIHxB/GCgr
	 koH72ekyv4vnw==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:42:56 +1000
Subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: use direct ATU hash on
 88E6141/6341
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6x41-fixes-v1-2-fbd3a1bf8965@padl.com>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
In-Reply-To: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783060981; l=2155;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=c9uf0pu6UF7qvElQMOsdcLzQ5NtMp7huDoIEjoaG0Bo=;
 b=yUdQrAaCqsYXsjTYMNIxCCsTJ35y3DNAxYbZlYuskAQSv2FLRnpjjnBCdWcAxCIgP4PrkXvem
 cOn6uU76plhBHRlpX1gApRastUKji9LG6E2iJfkJGqVd17ZOdA/9uij
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

The default 88E6341/88E6141 ATU hash algorithm appears to result
in frequent collisions, evicting permanent registrations (including
the broadcast address) out of the ATU.

This workaround disables hasing in the ATU control register. It may
have a performance impact (the data sheet notes this is for testing
only), but it also enables correctness, at least in local testing.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 12 ++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 60d46680fb50e..53ed2b9e30979 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1699,6 +1699,18 @@ static int mv88e6xxx_atu_setup(struct mv88e6xxx_chip *chip)
 {
 	int err;
 
+	/* Avoid collisions on the 6341 family by disabling hashing. */
+	if (chip->info->family == MV88E6XXX_FAMILY_6341 &&
+	    chip->info->ops->atu_set_hash) {
+		u8 hash = MV88E6161_G1_ATU_CTL_HASH_DIRECT;
+
+		err = chip->info->ops->atu_set_hash(chip, hash);
+		if (err)
+			return err;
+
+		dev_info(chip->dev, "ATU hash mode set to 0x%x\n", hash);
+	}
+
 	err = mv88e6xxx_g1_atu_flush(chip, 0, true);
 	if (err)
 		return err;
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 3dbb7a1b8fe11..e2a54eac64832 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -112,7 +112,11 @@
 /* Offset 0x0A: ATU Control Register */
 #define MV88E6XXX_G1_ATU_CTL		0x0a
 #define MV88E6XXX_G1_ATU_CTL_LEARN2ALL	0x0008
-#define MV88E6161_G1_ATU_CTL_HASH_MASK	0x0003
+#define MV88E6161_G1_ATU_CTL_HASH_MASK		0x0003
+#define MV88E6161_G1_ATU_CTL_HASH_RESERVED_0	0x0000
+#define MV88E6161_G1_ATU_CTL_HASH_DEFAULT	0x0001
+#define MV88E6161_G1_ATU_CTL_HASH_RESERVED_1	0x0002
+#define MV88E6161_G1_ATU_CTL_HASH_DIRECT	0x0003
 
 /* Offset 0x0B: ATU Operation Register */
 #define MV88E6XXX_G1_ATU_OP				0x0b

-- 
2.43.0

