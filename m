Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA64B44D2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671127; cv=none; b=UEoQOC5dYY+IJEx72MmKrISk9g4jEQAv/4PY9DQjtTVEEK3xH4l9B9k03YDl2fNPKXqIfapbPbOZ98XlRxYnOMxnVJQLvPSmDGwSgUbIdmpxmd0d1+5Rd+2Evm7TZl+SfhkdroMgBxpJ9cF55VEYtF2k1rcoYbue96KsxbNmjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671127; c=relaxed/simple;
	bh=t2Rh5HicDYfUhDshXxIV+ToBVIxCOdkpflXNAhRUTLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpYI2Px6h1TwSyWry4V/T89r5rOEOAysW7cqbA4up17NcNmtUjYRPwzSM2iTbkcTisV67X0sZ/6i8ZMSX2pCCI9X1eE7yJL3KfSnIJ5NrRnhUqhj8aE1I8804oEXCf/9ndBBH3Z3+Su4rM8XyUubAvYEG1F853KrrtsZFT7/PYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5pxtX+6; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5pxtX+6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db18fe459dso7994135ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671125; x=1790275925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmX2iathH1BothbInV/Ke+WVEC5Ed3SbwmWKrISd/bc=;
        b=T5pxtX+6IDQgsCLgsdHKya62Qy+iLqBixxRGItznFZ2qExnkwK5zPbLPSU97n09kPT
         kwSt6zXMgzK5GW74d2FoX9hiHPPFBOCfGqtFsQsCQpCRZcJMPT0TbJWX+vEuB8ND7gxe
         a5gIp9KfPXyuGLmVfXh0uAxbdWthhDShicbT2vRKYMEmCLx5WFRKkMQv1hvzrF8JRAZT
         mum8WZXoiIihZ4UzF0dOBZtyvPg8RO60tc1APefWtFN1WfhRuCeCzEEVfrWNZZRsK+GP
         DPSEiLZeompA7Ns+0ShqNrFEhhlf98ubFsm1xnX+vjxtlSj+1gmWaZG4nxoTSS9alAVY
         hn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671125; x=1790275925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmX2iathH1BothbInV/Ke+WVEC5Ed3SbwmWKrISd/bc=;
        b=eJobqOVCf1O+sZ0zoD0l15dkHOUwtVgpR/DwUulWkBTi1j+6WwxJmkKFzaLJ/quAYH
         1Px02X7AZOOuW8BN31RyApgu1rjwN/r+/5X02fnUrJO76n1XrTEG4B/0B3xcnZfUP5ht
         Sq4qpRxvLiRC9x4HrcvjMFRAij54ftlcRJWCm5XoN+G2CG3brx0hT9lkayPHLbdNAe9x
         MOdL+Q87CaviCjag2spmXSCQcO2v4Raj4G4Vw3KzBT+WhBKtj4ih/C67jf8IuQqsBks2
         QcDJvxKcBMeJ/VLNk8eWcoAdfl/CIhVsz2NvGbDbgYScBE6GvkhGFQurWnzVi9jD1BTn
         1WiQ==
X-Gm-Message-State: AFuF++k4oLpMeBA2GsX8kCaYhSZIBFlJD+S1RIckeJSQ0WnGbXLwd9Sk
	c2tleKFa00PzZOTKraniY6Ze3XIfc4tf/pVtyEtmhiIbyKZh136E6d9xfcoZEZTn
X-Gm-Gg: AYBFou1wvumpYpS3Ji6SR9ZldViJwf8kzvAl4t5q82SffyljeUg5WakCjRQFkC0tzo0
	lJ471mOo4YBeHdKCaVchDUZVC4Ej2/SrtnaHdNi89jhYW5YmH98+gC9uKxtbEEGLV7x7aqJpuKT
	34cV4wOKoL22nn2qXp2JSraNpNodjYBaSxBQA6HOvwEPJe6ADXUQFQof/HHbFZMHpSiqKznw33R
	os06FQuxUw9WcdRpTH8bCGU7mfr1HyHjd3RS8MtlaW5NL8DpdWuMZxBzZpxr0mHti2fjg8tJh3x
	+/Wt8uairESe9n2vThAlBYqdluMABB1mlupgmLgYTdnbml7JcE8vdgnOF0u/ZC+8osxs8PY5/OV
	VnKY91yEJuK215FFCLDlHKrJK+4njzMt5l042NxabvhLn684lz6zujsuc9aIT8n1uNqzUyCVGM+
	WWICelMbNvErjz7Zuvuc3qw/aZyJhzuhTyYX4QnDulMbZBRFquTVikIWryFIzpHJM0rgXWDGgvV
	h0JBSDlDNIYZ7sN3epK4JtTJg==
X-Received: by 2002:a17:902:d4c4:b0:2d8:d4dd:24c0 with SMTP id d9443c01a7336-2ddb1b97ee1mr2276265ad.21.1789671124852;
        Thu, 17 Sep 2026 11:52:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:04 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/8] net: dsa: motorcomm: Remove YT921X_PORT_MASK_* macros
Date: Fri, 18 Sep 2026 02:49:48 +0800
Message-ID: <20260917185010.3189199-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove YT921X_PORT_MASK_* macros since they are only thin wrappers
around BIT() and GENMASK() and are not used in other places (plain BIT()
and GENMASK() are used there). No functional change.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d663af010f43..5acd7d27ff40 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -108,46 +108,41 @@ struct yt921x_info {
 	u16 external_mask;
 };
 
-#define YT921X_PORT_MASK_INTn(port)	BIT(port)
-#define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
-#define YT921X_PORT_MASK_EXT0		BIT(8)
-#define YT921X_PORT_MASK_EXT1		BIT(9)
-
 static const struct yt921x_info yt921x_infos[] = {
 	{
 		"YT9215SC", YT9215_MAJOR, 1, 0,
-		YT921X_PORT_MASK_INT0_n(5),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(4, 0),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9215S", YT9215_MAJOR, 2, 0,
-		YT921X_PORT_MASK_INT0_n(5),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(4, 0),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9215RB", YT9215_MAJOR, 3, 0,
-		YT921X_PORT_MASK_INT0_n(5),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(4, 0),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9214NB", YT9215_MAJOR, 3, 2,
-		YT921X_PORT_MASK_INTn(1) | YT921X_PORT_MASK_INTn(3),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		BIT(1) | BIT(3),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9213NB", YT9215_MAJOR, 3, 3,
-		YT921X_PORT_MASK_INTn(1) | YT921X_PORT_MASK_INTn(3),
-		YT921X_PORT_MASK_EXT1,
+		BIT(1) | BIT(3),
+		BIT(9),
 	},
 	{
 		"YT9218N", YT9218_MAJOR, 0, 0,
-		YT921X_PORT_MASK_INT0_n(8),
+		GENMASK(7, 0),
 		0,
 	},
 	{
 		"YT9218MB", YT9218_MAJOR, 1, 0,
-		YT921X_PORT_MASK_INT0_n(8),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(7, 0),
+		BIT(8) | BIT(9),
 	},
 	{}
 };
-- 
2.53.0

