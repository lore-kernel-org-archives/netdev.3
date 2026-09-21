Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449A4DB540
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009649; cv=none; b=n/mAUc5MWuU7DTmkssEXuAVct1zAgLlHLRcASrFIFsCxXRU7Ra/o75lVTM3cgYIfgst26bHAmXAVKL+xW5MMxgiZ+3g4lbU4A/ufewVmYA4NEvjy22QMS81aOD8wjVb8RUpGPaHbo4mgq8Y6Qmzt3+tYhX5eAvq8grEYvU7q1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009649; c=relaxed/simple;
	bh=OTCJmDRdeQw+MVudaJiUkwSG/PvC7qpRtAicPLNJlfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MF1MFzo2PuHAh/qqv3JUMiHHFZUahc7Uca5zQHr7oyMUB+FjE241SrhoLA2sRj/FRPYh30HEyEamOEtzd/5fKkKlVRhrwRLUzfNDo6el7XMBvSnY8of0MK/jL2t092HXlENHCi8DQScCWZw6QBNGok3GiPONQCXKQ7KYicbMaug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbhN9N98; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbhN9N98"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c0776592e3so1832711b6e.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790009646; x=1790614446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YhWGvSN0/re+XL27oH8EyakYJ2QqZd3jNzma8F4tE+U=;
        b=kbhN9N9819PPv3PAbwGnvH/NUmlwFiE9f+zEEAmXgfu8JJ2O1g6Q52FE3ed5Z0lqow
         x/kOm1PQm2iojP9RkBG+adN8MGG6d4i/Gm52Stnq/KTgNlsnABR0fZQ1SP5UfNgAvqyZ
         yYKQ4j0KNQjKOWFQY9JE4PQeCABCLU9pLGGn6n4gRj5Io9ADjcexrK1RLzKioLeOgyw6
         Sa+pQEGR8kSTIVkkzX4eibSZgWBdM22bd1eYwC6pb/377lOQIbWVzrFOkKTGfsVB2Egm
         u7R+41nhyyzQPrKXITDV6losM5JvY7J42hEGregq5VdNL6jYiwTVBqPvWXoUwpYkOto9
         to/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009646; x=1790614446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YhWGvSN0/re+XL27oH8EyakYJ2QqZd3jNzma8F4tE+U=;
        b=cOsHRmxw89yOEAwF7w911Rb53E7FrJAYCJUEr8iWCFtKPSCcoYksFt3g3dFSQvNE11
         wEhTfD+6lUe7Hgue7Nj8WfCuV+4gOu5nLQNZD/odd6Us4YN5HqSLFMP0IPNZFh61CIAm
         tUClZGEH+F4hfN1txfZyDKfJxSW10l+NvkWyfLCSp3yHQ5pj47qxDvfupGXXs/4T6hDO
         JJXz3mUoG9PaEmgiyvBhzkCN9h45ht178kB7BjmVPdLYojIMbZ9EcZImwJevdoT1BMbF
         MbesIXXBn+5po4Q6nlosXHfDn4FDlX/86EQxMsExxwceK8wV5KPuVQ/mdq/g0mJL3r+C
         98vQ==
X-Forwarded-Encrypted: i=1; AKwUvBzN5Nm8xvP5ElG+vyWekgSqz5XfjgSe8nR9Fcl17+BZzBIrDayiMVyZzmCg27j7DTB8xMCsqIg=@vger.kernel.org
X-Gm-Message-State: AFuF++kG30zEd/jBIDCDgu233qn2Feg+dbGa9QaMTH5T/2+5nxJZC1Sg
	AJqFmOzn/k9w8uagX9F9iq5DmHn98dbKz32wOMc2HiaRvcTvvXB7nlsU
X-Gm-Gg: AYBFou3ga0nHHAh0/lv+kxSXO+8N3SeDXZEch6GS5WxKlEm84BhVGm3bniWe573qNma
	8jV1EmrEzAew/eJNv4C7ONV+MuPmG7lp2Aedr5kH6CJeZfDsL8b+rO2wAiUwHf4dM+bTny0UK84
	Kh9PSSSEYxqJ6/ap1p7Bm8nVXQdc9miacuKy/DdS+CWPYMYlIrYpH3xEJweOs/kNrJyLKT2VFCN
	apcWwANPqxFggNhXfppo/wX6qeiFd4srp/Oiow0sZh2mG4DaWN8hVh8R6b3rQj/Q0IDU7MWzTIc
	/a7a55f6H5SJvd8zCkUM7Vqb7ebgYmBykVGwUYf+AUj4AJkprH+nNKCQM/yAhpNrA0oJAnPSe+E
	i3J2aHjl6Q7ArPgOGB27DgYoYL652vdPJMtqPBaCb4LqgaV3HHfN5o+9tVH17Q6eVhoYclSepFa
	PtAUiT81bpjf8iNs5gB9oJlRf83/IhVkxf4QKKXytomG4K5tum6PHGjWWuWESF83tddp9sEuJo7
	ykXgExjE6j4bE6lVnEay5Ra8Lr3TAr+ZEWNS63sdWUUsQQwdIFlaQroFdKd6H/FRW5aT+0dv+4B
	JWkT+iyPv5SAbHXPBOmQzMgZCPuwImn4KuqocktgWba0grHFHfvE+QFNYxkiVITR/BSBW+n81Ti
	gBlGe0o62j6gKKN3AZwj+mg==
X-Received: by 2002:a05:6820:61a:b0:6b7:8415:d785 with SMTP id 006d021491bc7-6ca9c9551efmr10448335eaf.48.1790009645716;
        Mon, 21 Sep 2026 09:54:05 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d145bc40e6sm510481eaf.5.2026.09.21.09.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:54:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 21 Sep 2026 10:54:02 -0600
Subject: [PATCH net 1/3] net: phylink: allow stopping a suspended instance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-submit-stmmac-reset-fixes-v1-v1-1-87a4e431ee00@gmail.com>
References: <20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com>
In-Reply-To: <20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2

A MAC which cannot restore its hardware after system sleep may need to
close the network device instead of calling phylink_resume(). Without MAC
Wake-on-LAN, phylink_suspend() has already stopped the PHY and PCS, so
another phylink_stop() repeats their shutdown. With MAC Wake-on-LAN, the
saved link-up state still needs a matching mac_link_down(), and leaving
PHYLINK_DISABLE_MAC_WOL set prevents a subsequent start from resolving
the link.

Allow phylink_stop() to finish shutdown directly from either suspended
state. Leave an already stopped instance alone. For MAC Wake-on-LAN,
stop resolution, drain pending resolve work, complete the deferred
link-down and clear the WoL disable bit while retaining the stopped bit.
This does not restart the PHY, reconfigure the MAC or bring its link up.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a1458da8111b..8f9278112623 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2495,11 +2495,17 @@ EXPORT_SYMBOL_GPL(phylink_start);
  *
  * This will synchronously bring down the link if the link is not already
  * down (in other words, it will trigger a mac_link_down() method call.)
+ * It may also be called after phylink_suspend() if the MAC cannot resume
+ * and the network device must be closed instead.
  */
 void phylink_stop(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	/* phylink_suspend() already stops the link without MAC WoL. */
+	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
+		return;
+
 	if (pl->sfp_bus)
 		sfp_upstream_stop(pl->sfp_bus);
 	if (pl->phydev)
@@ -2512,6 +2518,16 @@ void phylink_stop(struct phylink *pl)
 
 	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
 
+	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
+		/* Finish the link-down deferred by MAC WoL, without restarting. */
+		flush_work(&pl->resolve);
+		mutex_lock(&pl->state_mutex);
+		if (pl->suspend_link_up)
+			phylink_link_down(pl);
+		__clear_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
+		mutex_unlock(&pl->state_mutex);
+	}
+
 	pl->pcs_state = PCS_STATE_DOWN;
 
 	phylink_pcs_disable(pl->pcs);

-- 
2.53.0

