Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02546C4CD
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518477; cv=none; b=Q92tO4CgdnG+RGxdiHdR6ZXdk9mzej55LlWW0xfvnKb/GYlSCtvO6E5pKVoHtRJoWt5z+TrhrA55hzk1PL6KkN3OOgRVtuqS4njCHRyRT3fw6/PYsuA95U054UhUNH/Xw+KkxNeJAA6jXGYRAbt5m8DVs0maRoKDYxBjCOGFeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518477; c=relaxed/simple;
	bh=qAMoU5VvG2ycHMCA+HEkihysJRjSyeGeDWWh2V1vMLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au8h2t9ApdGEXaUHNCwTdJqzyIasuh3aGZB0tX2svulqgHoKZdp6OUjU4iskgQaEYBTTEBcasSp/xzOKVYV26pgO988817UctestNPCf8Zc15Kq/aOx2qINZVU8XN9l6pQFrwJ21bfb1XNE91Y3dkBqxnHXYsaAz1+fUCMqP3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqBrispl; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqBrispl"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b7b4b08d78so227351eaf.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518474; x=1789123274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbHB8X3TB8UIpQ4SSGqqJDBBoeCerCEXcuSI+3sPA2w=;
        b=eqBrispl160N8iH/69nDEq4Qg0RirTM3xPN/SEH+4Kmi+1Ceq/jLO2IjhHh7qhO5Oi
         3nW8ev3vbb+3l4X2fNR8F++Z3sybrD81+eXyX0rTbnXLN5G5fl9XuNvK04niCi767ky3
         jmOo0VtSqi78xpfcfyJdhUP121BgvWXMqthFfof2oROLxeFPL8kE4ItOnj3+pxHW3Mi9
         dGX8AJo0IKyp5rGxG4IsLCoveVxFv1SKx6m7TMnlQHFeLOg8caVvkxjh9qoeVuv9h5EO
         /Fqb7uIKwepuEIdBKKUcHrfqef6p1ykknYMirqSgRdgZzDQNSZPakL3JWY9dyoUK2aAI
         pP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518474; x=1789123274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gbHB8X3TB8UIpQ4SSGqqJDBBoeCerCEXcuSI+3sPA2w=;
        b=RKSYdyw0LUdzPjVVVCUvxqyTxE7kDNF+qRUl5TnVenXhz+tkgm/wvXz3e7ahLPzCtF
         uPsd1tbTNoWTfkIybfDWqxEmWjsEphP1t+HxexP4EGNNtQWgdqS+IZKjHCoyowpXo5Wu
         UMzadkEP4xLVZpkRCCHu1cU7u0rmNcJUSNBRN6Vxa3ywjNKYDLSd/1ptuA/PRmWTpc6Y
         iN/56ZCODztXkuzScyNz+K/QFiNuCovqmxYSFIAzGWhvxaaf701k4gwz8xwBROts/8pr
         9Hgjz2SX85ngiAI3r5F8S0xBq+yhtuEBd1cJQRGKzhgQkkANsjK6V9VlohYtTNhVz6oR
         W7tg==
X-Forwarded-Encrypted: i=1; AKwUvBxD/yhFspyFzMgYj5rNNa3T3AMuJQll6FogRoYWRPvmS/rPi6jGThI1VVQMgIpbDw4La6NxLd4=@vger.kernel.org
X-Gm-Message-State: AFuF++lNWH3a5kO18y+ULXPD6YCZA1ujm0Mje17SuxlygVEhPt8RLpXq
	6IUm/0/rQxwCBxlnlq+oE/r79mTi0huVOOCoNObHA3J3EW7VRA0zfJ7s
X-Gm-Gg: AYBFou2JBwQSjo2ZWuwC0smB223c16QWkC7K+F44KC88/nUKZ7U6KffdCprM0b9SRJA
	8yBzNLYtm1MHyZxxJdtWP36E4tueTsvf7qZnIFV/PKGLOIKvkIxqU2o66HfXEdr+m2I1AZP7JvK
	i3FgfDAM+rY/FZ7SeB2BRHDscoviX6cqb6U7ecqZTfE8higqakQ89CUU1BZ+WWKqELKyxNSKJss
	wJg/UVnE3w+WnUFJan3IRBQblmBvlH3e8oMwTh5MxSdmkp0TJ8EDCgyD7x5QCdx6cCDRZIhQxuJ
	RFCrzSiSUivsdap3KfX+m31t+tR0vmr62nWIFyN2nVeFoX3u4CEtXd0+e28B0Gc6e1iIAoXgULn
	GEK0l8tVLFnktQ7t6B0boIjNO2aWDMoUWLlFyt41ob6jt4VRih1ZZlgVxYyeRONl0w+ljzvvMn+
	uacAHDeLaCD7C/FDLOmQmZ1abUgpfSQI4GJ+157pXyQq+aLj1vR4DdRnjeqoZQlAhLrCKTZlkqJ
	YJO1fzyzkNUFcN4qjqSk5gTS7YcREC4ERXP7A==
X-Received: by 2002:a05:6820:4c09:b0:6b7:83c5:fdf4 with SMTP id 006d021491bc7-6b783c603ccmr1048794eaf.53.1788518473912;
        Fri, 04 Sep 2026 03:41:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm5319267c88.3.2026.09.04.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:41:13 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] mdio-mux: fix typo "framwork" in comment
Date: Fri,  4 Sep 2026 16:11:04 +0530
Message-ID: <20260904104107.12832-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904104107.12832-1-hemanth.selam@gmail.com>
References: <20260904104107.12832-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "framwork" to "framework", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/linux/mdio-mux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mdio-mux.h b/include/linux/mdio-mux.h
index a5d58f221939..e2af9cb8e017 100644
--- a/include/linux/mdio-mux.h
+++ b/include/linux/mdio-mux.h
@@ -1,5 +1,5 @@
 /*
- * MDIO bus multiplexer framwork.
+ * MDIO bus multiplexer framework.
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
-- 
2.48.1

