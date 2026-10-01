Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162B5221DE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869418; cv=none; b=ZrG1WDOE2uqoMeoDiItHw/xLumJXycqGK4oOw085vWqsl8KbYZd4yPw+/UeV6psvzAjCvJyizUmq1L7EOJh0+EfKMthHny+5HqsR1SttzSISnxmMwgw3NCAEDGSe/SfK9L4FcjTHrPNR6p9TB8mVBjbGzgU+nwPXxjlyakILFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869418; c=relaxed/simple;
	bh=OQJZv9acOTk42vjwuLnraI5dhRhpupiz0zjKA4s/M3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2Jz4Wwvy50H5+OtZI01GSzity2yGgLMr3CqXEPGWQem30kmWMugEWxNTwUNgaJsgWZlDhFvLH8dUjGS0J9j10Ct5mvzUcDkOF7wVJmYeDztvKCrnXM2E60vnn5PDksytXY5En5QeAJ1Ygh30XeVoi8U92JtYbn3HZ3s+g/AUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhMGZUTL; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhMGZUTL"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so962808f8f.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869414; x=1791474214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSWSFoiqnHbSZUG5Pf7Vf3OD9TAVESMC/aG0LA9oLno=;
        b=bhMGZUTLxJm9W3h9q+gFQe8whvaARZ7e0ZqmudarlrWHOok7vfQE1SzFYKCANCSry+
         GyTzIY6jhuYjjlL8KkoTQfgIpjd1+tp5r85XYpdU3rvavhWIDj8Ym5W1l2pBk5vJnEBr
         XcrPsMFF7DLcw2O+O1oCSYP6dBNowfHEMzLB06XvoBM0L7ZSABEtwzvbgwXG2irhbYEs
         Jv4h9BZlkQa6vmkE25fGug218r6qZqULHdfHiKlqo0iZZQmxQDYkF6L1Tej3y1IKoCI4
         lQpHyETrJxqXVM86iiNGUn0TuQcr81JkaL20BvA1dEOgJi0Sz+Q4D1HM581g/eXn/twX
         epnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869414; x=1791474214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mSWSFoiqnHbSZUG5Pf7Vf3OD9TAVESMC/aG0LA9oLno=;
        b=lHH/NaoJdFWLc6iFrU1d60ucZi8KNRbmtSh3SsDlvmGohSwTcrMdKj8MmIvJALna75
         WpfYtNuiMnGNSJ4NEfT1OWSuWU1cx26/6FyJ75raL9pWpDJNJQuKUkXBV/s2psmgKf5J
         /K0YVOJzpBjdUlPte/MpOQlZqiRqfmwZ5nR4b6BMCdJ4i9tPu9dv8vRXAtO+rB6845NW
         2pB2EBhmdULTBSUiwoz6bTu0xOwYJj85XREzR1+59AIwA9Xpfq3c11tLMZGHezqSiMJ2
         d2seTtUAHB+caGxt7rHIy5pXYeX7yvWyno3iTKrA/UzeYs44d4p9a1QvCi4HBvesxsog
         MkkA==
X-Forwarded-Encrypted: i=1; AKwUvBx4D/qiUQKtCBYlxPdFNtOq2n08/KuF6KcHLyAH19xzrAz71U582sDeV3MpqaTRri/Csgiht/8=@vger.kernel.org
X-Gm-Message-State: AFuF++mCL0MMc8RMzCXU1ev7LmvJZfA26x6mMPRAmy2T2036rS77D4Z/
	JZYPFtonRohQz2Ud99Ff0Sk7wtmyxvZ+ZyrBZjSTy869x+rP5GlpE4w+
X-Gm-Gg: AYBFou1zfCmuxKdz6ZbJhZ/h5y1r7QRE20OvN9Gl9aCrE2gLq2jZoessoPZ/4PLQLqF
	md2fLwkGFFnb1yxIHrMotnBVcGUCh48H+XVbtvKkySsh0pvR5BidU9k+fI/xMFlmDf/fLbmTXSk
	KizEpf9lh8FXQi3EhLMM9LvJVFEJT4wF1wUxN1PnQlwcAXy0qnYxlXV+0vR0rpPnYIHoNwEZnpu
	dr7vMjwH2AkWZzanjwgvVcE/dEScuR2Mc1YSk7cp0lB3j+kqp9ghfgf3oZqa040viZhimPrgBEV
	talazNPqXeWgogvelot2XS/hpHeNBxHKVshLfzRCrYBGN5s1/nLB/vpJE7fKVQmqzwBeNnSsIwI
	PW7JyYxqfINeXmfjAIcdyUGrpdJ9dy8LIsduxBYPhDbhurm9AJQzgcbgj+m9Y0Dixk8HfJpZZxm
	4F4DAM5VTUfQjZfM4Pgw5tmmJ93mrTca7zwTgKJhTQG04inCwbmpAeA9f3MXoZoDg1ahGKXxe+c
	PDqD2QxOiF8kx/k+8PsW9ClrRDlSfJ+NbVOhFcSnwBimjzr9x+njvja++0v+/dQCUa1BRAQLuh4
	Hwe/csmtTv0BtfcnUELDLohg7+TADg==
X-Received: by 2002:a05:600c:1e24:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4a0275507d7mr448335e9.11.1790869414072;
        Thu, 01 Oct 2026 08:43:34 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:33 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 01/12] net: dsa: tag_rzn1_a5psw: Drop redundant ETH_P_DSA_A5PSW definition
Date: Thu,  1 Oct 2026 16:43:14 +0100
Message-ID: <20261001154326.754314-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove the locally defined ETH_P_DSA_A5PSW protocol value from
tag_rzn1_a5psw.c. The macro is already provided by <linux/if_ether.h>,
which is included by this file, making the local definition redundant.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v1->v2:
- Added RB tag
---
 net/dsa/tag_rzn1_a5psw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/dsa/tag_rzn1_a5psw.c b/net/dsa/tag_rzn1_a5psw.c
index 734910156dc3..aab0ec143c77 100644
--- a/net/dsa/tag_rzn1_a5psw.c
+++ b/net/dsa/tag_rzn1_a5psw.c
@@ -24,7 +24,6 @@
 
 #define A5PSW_NAME			"a5psw"
 
-#define ETH_P_DSA_A5PSW			0xE001
 #define A5PSW_TAG_LEN			8
 #define A5PSW_CTRL_DATA_FORCE_FORWARD	BIT(0)
 /* This is both used for xmit tag and rcv tagging */
-- 
2.55.0

