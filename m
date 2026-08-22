Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E373CB91E
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787413992; cv=none; b=p4xw1kFYek84QKrNDn58RShX7hMifBfw5z/+/yh1QLlH5BcFPiltdR62YlR2bJeP49TuoiDpfqLX2/6JQBs10Gd+kAZjspl9ZAg3Rl5adW+rN4hV9xYje8voyPQhnO9VhCOBLvMcv4VSNA8lARcTTQzsaNFak9tjVW64TQhcf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787413992; c=relaxed/simple;
	bh=bwFb8+8zfaie+LAvs8/7XUIsL9MQzN7tXA0AU8G3HCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4BS95q1XXZgXLNfR8mAGvKt2H9bLAoiVjrlz2OcjvWrxbm6rbyDQWDA+suceV9mR36egDDYWoqP0+t2GjalWvmwAal8pa3LT3PqVM9tVGuRlL5joBQT2+jkEeVU2Sk9qu9PutL4i44VKENUOOwJ2kYaJQoDS5y2mU8PEBXAzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=CQsgwUzc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="CQsgwUzc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso3796101a12.2
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787413989; x=1788018789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IThcaUItiGTT1yNVv9ohDD3OMYEp3sYsB42Cn7lxU0E=;
        b=CQsgwUzcWtIsP99cWomQoR75dBMdxvYmegtT1H4M3qROq85FM3Q7oYe6+lIQGfr9WJ
         J+d5z5gbQnXnic4ic/KFVJAyyIhqX6GtUPieOhj/+wSJ8/9WFsQCSzxIG4H23Uej55QL
         ePLDGhrOwoA+qJWdJOSciYGsNqTO+a69Jr9OKiOLZYa0CXz3Ug3qEkHrm5/7vR+YIeqj
         TchKKbRf6ydAxEf0KdcctSz8MGwYHcCNLm9CRT38PGgVnJ1qtvcKxMvPhf7dsgG+1FlS
         P429gCZWA9InGzLkaEdGL866bmC9b+Vv8Q0Eu5nDAM+k/pZjnVgelP3zbeHTFHcrLoiK
         0Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787413989; x=1788018789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IThcaUItiGTT1yNVv9ohDD3OMYEp3sYsB42Cn7lxU0E=;
        b=XZUMV5cKW48b+qR2qINXyAWBo9IZjgbP9+d1UraVHaVLaM+3+5F9YkPyhwx6nNLlOL
         9Ghditr3DZMhcxRWszbwbyz8sOH+dt8c5jt5189obZrkfbmw1e/iQ6311/MOJtPR0KUx
         L0vPMlkHQatUvVMOeiFRh/BD7vpYhiJ8ipcRKxFlaeQexPPckUQ8ApcSKnjwCt6lpuF6
         s7ek2xJySxbyfxXuwofycC5B2nETo247G5q3vaprFehLcjpSzwyydc/V379U2K5ZMhXi
         OV3VdjayUn5bT+XPGTt9JqKyVYO3jN0CY77zKdApOjvpBF5HxUk7iawOHbuAi80d4mYC
         BEBw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5eyeeTXn/5IfE86X1uIbfdG6WZFrWRx4H850Kq7rwM6Spjaqcm3xrixNtx/7k8mNK4C2F59g=@vger.kernel.org
X-Gm-Message-State: AFuF++klST4lPlya2unGzTGiyAQcfRmKEChpcQemwkv0Qwtn5f5W4+v1
	F1Uc/sYrDUjvDlqQ8BxFB9WHOWm361XKt33R0Ae//Bz+vS1GWPentpWtL7XXjlZUXyEqMa18L+o
	01HmmJPQCOg==
X-Gm-Gg: AR+sD1102txP8wmcq5XNl6ZHoL4QEBJzBuEJNMQvUe+poCs/PrMP3TzE8SvEd/xmVAt
	T/T6TAwyTdXY3ODfXmjUTSXVL/hx4LhRip7W65aZfFbdsWbvKWzUKlZJDgNDG+4e0PgeTIz/rWY
	0F7PcazZ3f4fbq1AmroBEixtgvpISeDDlFeRpYz7/ThUP6ciwpmHQZO3tcSNbdTUEYKCcWbV9AM
	kESuE0acDmaN2Yoww3iQIBzGAREImmsfFGTSIZhjxp4tEhJkvKQvIv51C3SeYsKFczzrlG9qbrd
	tgV4zA6Munx4jaYup5BZC1Vs8fxTSwcouO31pGxT6jkuJkqJGqtl9spqrXtYN5N9gBfVI4KEdI9
	rhXMjgSlsd7UmZKi41FEmLv8VBQRrJbt1c5y/hZdiRfqZH+q6d+aIUfVuSzZcogIxrIhLkLYOAF
	4ckjAO7sflw3drS+IlRLH7JbZmAB+RTc8hSIQD6bs1Xwc21hzt7LCTB4BpgmSSh0zVw0JLUg==
X-Received: by 2002:a05:6402:444a:b0:698:351c:979c with SMTP id 4fb4d7f45d1cf-6a42f16f016mr17302770a12.2.1787413988818;
        Sat, 22 Aug 2026 08:53:08 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c546sm12396250a12.21.2026.08.22.08.53.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 08:53:08 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next 1/3] net: phylink: unwind the PHY binding when bringup fails late
Date: Sat, 22 Aug 2026 18:52:57 +0300
Message-ID: <20260822155259.87146-2-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822155259.87146-1-f@lex.la>
References: <20260822155259.87146-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_bringup_phy() records the PHY in pl->phydev before its last
fallible step: on a MAC whose phylink ops implement LPI,
phy_eee_rx_clock_stop() can fail with a real MDIO error. The callers
unwind with phy_detach(), which knows nothing about pl->phydev, so a
pointer to a PHY that is no longer attached outlives the failed
connect.

What that costs depends on how the caller got here.
phylink_connect_phy() and the SFP path go through
phylink_attach_phy(), which refuses to attach while pl->phydev is set
and turns a transient MDIO error into a permanent -EBUSY.
phylink_fwnode_phy_connect() has no such check, so a later connect
overwrites the stale pointer and hides the problem. A disconnect does
not: phylink_disconnect_phy() hands that pointer to phy_disconnect(),
and the second phy_detach() on the same PHY drops a device reference
and two module references that were only ever taken once.

Clear the binding on the failure path, the same three fields
phylink_disconnect_phy() clears, under the same locks. The PHY-side
fields are left to phy_detach(), which every caller already runs on
this path.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Reachability

The failing step needs pl->mac_supports_eee_ops, i.e. a MAC whose
phylink ops implement the LPI callbacks; mt7530 is one, and on the
board I tested ethtool --show-eee returns -EOPNOTSUPP, which is what
phylink reports when mac_supports_eee_ops is set and mac_supports_eee
is not, so that tail runs on every bringup there. The error itself is
an MDIO transaction failure inside phy_eee_rx_clock_stop(), which
cannot be produced deliberately, so this patch is compile-tested and
the series it belongs to ran on hardware with it in place.

The double-detach path needs a port that outlives a failed connect,
which is what patch 3 introduces; before that, DSA destroyed the port
immediately and the stale pointer went with it.
 drivers/net/phy/phylink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5b8e95690..9d403ff1b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2197,6 +2197,18 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	if (ret == 0 && phy_interrupt_is_valid(phy))
 		phy_request_interrupt(phy);
 
+	if (ret) {
+		mutex_lock(&pl->phydev_mutex);
+		mutex_lock(&phy->lock);
+		mutex_lock(&pl->state_mutex);
+		pl->phydev = NULL;
+		pl->phy_enable_tx_lpi = false;
+		pl->mac_tx_clk_stop = false;
+		mutex_unlock(&pl->state_mutex);
+		mutex_unlock(&phy->lock);
+		mutex_unlock(&pl->phydev_mutex);
+	}
+
 	return ret;
 }
 
-- 
2.43.0

