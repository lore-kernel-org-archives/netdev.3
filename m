Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65704EFFB5
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859743; cv=none; b=deSAvVSg6SBw0unglnvCBlW7bsy+TueOmRG+IAGubIZZbztZhNOy7SLcMKCW/NUpufubg7Q+8yT+1FKijkd9nnLZdh/BHr9JMz+3I3oZo4tSWH6b9YimPp4CW4VpbYEA0/4v39gCTRRCrs03HfwKMDnVayxlp7s5t154KuerWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859743; c=relaxed/simple;
	bh=uB3M5jhLStvKxEixDqmeyTwelK0qIeNwNu47lsyjOSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/pbcleT9oFT10HYsFeaPr2QaJHcHAEowj9vSO7kJgAmOsVghty1WRRg4RU6E+mSeeiB0HMqG4WXNtrF88Nt4SLKjnuJ8OPzuZsNzGIIL++Uppqk2lUZSe38H4Wfxv35FI/Sse6kD+RHyi0iQGkAITniX3eKEx/1gdFV2ZqJAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=RmHAS6eQ; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="RmHAS6eQ"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b024549a2so1388460f8f.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859739; x=1791464539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuBDExO74epIRwSfRIAR1akFv1FLKuzGN3ASIp3+PmI=;
        b=RmHAS6eQcyoANScauS3xH2fbpnoY+GueCutTXiM7G0knhyQZNR+BjSzej9QuU1h1h4
         yhcvlHSTGjg4eNgs7gIWX+ppGtemkpIU8OnokNmc311ZKwlgDkNwZLIUJ3KYH6J5DGf+
         xeBpsmRlY5NKdok6Xs19iVcIyoO5I8SBJCTYo2aPbNGEbzcN3Ym3O7bHW3oCWpfNlEGe
         BDo9e3Wv4S02npyTWXvcEoBYDadArTKiiEytDo3oPTBIKPxErUki2xXCvvVyitsAUCpR
         YwHo0tLicfPkN2E5PIBSsJyDElwBA+yJYsySAxWxUXOhtcIjW6BCoVnhkafbzXl2N4U/
         hdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859739; x=1791464539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BuBDExO74epIRwSfRIAR1akFv1FLKuzGN3ASIp3+PmI=;
        b=G9z7P+i5DlY3JgW8BNwRT8jlbCROuH9f6Yv/JQ9YWkZjg1WGebJ9RCWA/t13OzGa+p
         JkTU5rLC+CoFKQtZhKSjMNUbNz3K8RQTqFl82RYeSgvuF4dzG6YWHyzho2lZ7ZOiaru/
         zW9ykUzd7eL5zM52iMHFnV5p4WzKJQFlSplSXrn/xH8QePTNIpu/MK2m+VMXN6YCvWaL
         0hsZajdHwgaKeYgT4gElfE+kdLBB8f8dlrqh/qHsmGVsg8i67//8raxkap15++zIol3p
         59JLMOU2qhEAYK3wm9d9Hn2WCuhSMECUmRwoX2X9Ot1JFmeSuRUK8NC96Q1p5tjTAWAz
         NjLg==
X-Forwarded-Encrypted: i=1; AKwUvByBf+eTrXLBBs3Hr6CXgZZropwYT/IHHkFnHm4MW6SJDsXAmstezUIdDxUQvwG5+AVjC8QbW/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzq1A1kTau8mcl4iysfrYa+gOkdcfECY8IfjKH/NiLLOlMyHww
	Lg8HYDeF7en/GNb7te8vLko3kww49hqKfrimGSlSs4iG3o6lL0TsDipaJ/BZCXS2v0I=
X-Gm-Gg: AYBFou0c65r+JEwGXAvKYegnAD+JmYm0KDLqa9i7X2NrcRypqQdi+WH8EWjEXPTcRSO
	QqoELcZwh1Sq2PPbhkzdTEApiuMa40SpAkB+ZyLtBrcUjWjoifN7V4zl4jTFfWfWO5stVX2o+6L
	QvZUQOzJmzEn4d6i/lNXAz5ixX1fBAFjpNuLr+qbMPVO+GxvFbNAv5tCAwjK5sGxEfqMgAbxn2m
	fSSeT0Y8JgLUs/Tv0yjHmsaAJOtke5AYffpPcbNr37y8IiGQjv65G9itNjLp3lyYhHuA1UemUlb
	Pbk0TmkqjWTZsgbHg3u0v7RoZC6ZDjdOGA0xlU28hsbN4QtP3ROdj6Uxg15NexX0U9H1Lp1eecO
	ANpdz+7JZerMl6Nslb8QmfxePS8polxrs3MZara3QDXGjHwE3Kn4uFJws2Tj2BD6U2Y3+Slk6so
	n6lwvQFzCjfTmtpXXPRzDY/UGx9idzHEXlbC8gfrk4qvGT5I3rfg==
X-Received: by 2002:a05:6000:29c3:b0:48b:10af:f85a with SMTP id ffacd0b85a97d-48b10b000e3mr1098553f8f.42.1790859738771;
        Thu, 01 Oct 2026 06:02:18 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2cd0fsm5568155f8f.30.2026.10.01.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:02:18 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 3/3] net: dsa: let user ports wait for a PHY that probes late
Date: Thu,  1 Oct 2026 16:02:08 +0300
Message-ID: <20261001130208.105558-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130208.105558-1-f@lex.la>
References: <20261001130208.105558-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A user port connects its PHY once, when the switch sets up its ports.
If that PHY needs firmware from the host and its driver is a module not
loaded yet, the port gets no working PHY for the rest of the uptime.

Let a switch driver opt its user ports in to phylink waiting for such a
PHY, and opt in mt7530. Until the PHY attaches, .port_enable sees a NULL
phy, so the opt-in is per driver: qca8k dereferences that argument, and
gswip programs the PHY address from it at open, so a late attach leaves
it wrong until the next open. mt7530 does not use it. Shared ports are
left out.

Found on a Keenetic KN-1012 (MT7981B with an MT7531 switch), where the
EN8811H behind lan4 has its driver on the root filesystem and lan4 was
lost for the uptime.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
New in v5.

 drivers/net/dsa/mt7530.c | 1 +
 include/net/dsa.h        | 5 +++++
 net/dsa/user.c           | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7781a63b4e6f..e4c155605e27 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3548,6 +3548,7 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	priv->ds->priv = priv;
 	priv->ds->ops = &mt7530_switch_ops;
 	priv->ds->phylink_mac_ops = &mt753x_phylink_mac_ops;
+	priv->ds->phy_may_probe_late = true;
 	mutex_init(&priv->reg_mutex);
 	spin_lock_init(&priv->stats_lock);
 	INIT_DELAYED_WORK(&priv->stats_work, mt7530_stats_poll);
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f..f7e78c3a123d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -455,6 +455,11 @@ struct dsa_switch {
 	 */
 	u32			dscp_prio_mapping_is_global:1;
 
+	/* Drivers whose .port_enable copes with a NULL phy may set this to
+	 * let user ports wait for a PHY that needs host firmware.
+	 */
+	u32			phy_may_probe_late:1;
+
 	/* Listener for switch fabric events */
 	struct notifier_block	nb;
 
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..41075bb74193 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2661,6 +2661,7 @@ static int dsa_user_phy_setup(struct net_device *user_dev)
 
 	dp->pl_config.dev = &user_dev->dev;
 	dp->pl_config.type = PHYLINK_NETDEV;
+	dp->pl_config.phy_may_probe_late = ds->phy_may_probe_late;
 
 	/* The get_fixed_state callback takes precedence over polling the
 	 * link GPIO in PHYLINK (see phylink_get_fixed_state).  Only set
-- 
2.53.0

