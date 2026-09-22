Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52272531AE5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119684; cv=none; b=bOBdhPDa2bao2e36a7O7QaOo1iN0eddOXJV02uThAgHBo/fjQXXG0i1FIfgU6BL1iWEf3EKbNaqHyYvrauuJ8zCC373o7oPEbjL5MafDod8nkCJO1GDjhPdr3RWPHWwLffzJOqw36nlGioF5JhjlevWQWtlQEJ2zKF7Xw+UWy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119684; c=relaxed/simple;
	bh=WXvjNDGT5fIJ4+hQrMbJuJmFLYmSKGyYuzOMTm701Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYKHYINn3/rXej1ODsqnUC1qqkT1DTXuDqJci2c6peudelMnI5167Caofj2fqwBOTMBcjGAdpUit+/eroiscHnOVMMZGrS0F9RgbTzOIFm30PbUlyNJeYhp+VdynuYRinN+xHV0svVcQKNzIemfqeYGtuD9T2UOMCZvO1dnB988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZRTZXQk; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZRTZXQk"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-804f7045f3eso235243a34.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790119667; x=1790724467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8++WyG12SZPVqlwFfWjIZRV+ikQ2NXn6irkLz76Dxw=;
        b=YZRTZXQk93/XTcsVd3JwZlVnKtfidiAOoq/j1gfSZfrdvg1Y5X7gNJaO+3aAcOJaoQ
         OTU2CRWHefdahBXLeY1f4/42/koVJx9N4XvUtnB3gqoGL7icCRkxUU8a72UMd5R69iaK
         tQpQrwxZI8uCY5hSJ/mqDhOkpm1WJf8+Z7bjU0qGNfVwjrfag5CIgOUQGdaXCKFo7kg9
         3os5t/5rOAWcnyhGJfxfDxlzDbnjA0YEV1Oy9g1DFbeO+ZQKTgP/7FBqm1YRBy3bTOqG
         s3VcHx+yIJHHrGEX1+0jl3fGp9LteoPu9J8Br3ukLvOX7W2xIHTqUc/RS5ba2CxzZpwR
         acVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119667; x=1790724467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8++WyG12SZPVqlwFfWjIZRV+ikQ2NXn6irkLz76Dxw=;
        b=JxMY5nghYAVfv7ejk3rCBY9dBnsrtO2RCby6W76NLzIqZES089omRTr/sJWPxjXqxu
         p3Gi190nHSxkmeY/w8oS/aHQbLUSbBAhbFbX0GSRtM2UrjziNaBJkl4pTs2R/Af9KgUv
         jf3NR5bT4691coyGVIe58A4IFe64zEAkypjAPvT/Zalj0ZJGqqoBSCZwzPtK/3fu+rkb
         UD3xTvnB1sHcFWKbl7eniJZMYHp73JyeAU9hyJ3uEWmaot3zo4CRaPksKpqV3MTh8UGh
         ok+JwEudY/d55WYfsdHOtEcbEGosk3KQg7mBh8YlzccSuZ3c6o7C5GmZsZpcQl7sJZUM
         dIZw==
X-Forwarded-Encrypted: i=1; AKwUvBzQXuvjtH6dCftX0a1D7RNhNUekuHeGrf+3Ml3CnO4vKESqtGS/m27f1Rx+OU7RTINffFnchu4=@vger.kernel.org
X-Gm-Message-State: AFuF++kl0ueU+KijybnU8Qe6I0u41zr7EJd69gW20mXgDMC2UdRh2M6b
	n99gRCwodJWnxHB0MUo8bkx8FqshqpberlZgRkyhTDcPIoqZRlkPErvH
X-Gm-Gg: AYBFou1qCVzBbq92DJMtD6R80P3C++dlrUYoV7Qxtscqei/rULkuG9sFzGbBMjdw+oT
	7yTvk+JyReKbC/ah2KAnxQdB2fbaPa2FG1I8YM6hRhLzEoVmnZrC28uXJzBtphVPyfrDns4JeHf
	gjfanWHNNl489YaZfCIDFhAPlCTELYLHCnfpwgu+zKb89Zflr3/LT+uWArjuZBWX/Pvj6eRSLPq
	/xIBMA2m1xTbiiaZC8g3kXS1E2q7WW9JijGO8PriQWC5dBeZ5VsSJiBpO2mnFF5ZQzo7DD2i2/e
	00Ua9hecUSrL4bWrK652Ux3Q9nHthhDV0pXvh0CjohSPCQ/TjvTXpL+rzBj7JwA1dAQGAmnAnfD
	79BZE+u48a8DdFkHXLTv3quTFJ6yxlGTMIvtUalVPJOe/huMpQxwmortx6Pn357wZmOJiEF8VMe
	v8ZxFwlcPkaXoVMWuqD5U6CWQ4qv5fG6IzTrNDQWMQX+7ozoFfQL7ODhWpmlmGuojZsRYcm8Rt6
	Q5M7dxgHkJfHuVCE3mTcHf7IlNJV4sdHBo1xXRIkzFC6Um2EVQF6RsERbdi20TYgTI1IS6qy0mf
	sIF6lLBfYeHZd2iFDkMMhxpRfoXWaH5SgiSBdbJVWBSWIB9S4mTs/dvKmieE9uzfPNAvd4/1yXQ
	QlUE9C88INfQADNYjhLYQWw==
X-Received: by 2002:a05:6830:4ac5:b0:802:68c:1b51 with SMTP id 46e09a7af769-815ef299a60mr1161319a34.11.1790119667060;
        Tue, 22 Sep 2026 16:27:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603fc87cdsm1243053a34.13.2026.09.22.16.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:27:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 22 Sep 2026 17:27:40 -0600
Subject: [PATCH net v2 1/2] net: phylink: allow stopping a suspended
 instance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-submit-stmmac-reset-fixes-v1-v2-1-d92e609be996@gmail.com>
References: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
In-Reply-To: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
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
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

If a network driver's system resume fails before phylink_resume(), the
network device can remain administratively up with phylink suspended.
Closing the interface then needs to terminate that suspended instance.
Calling phylink_resume() merely to make phylink_stop() work is not a safe
substitute: resume reconfigures the MAC and restarts link resolution,
although the driver has not successfully restored the MAC.

This is a missing suspend-to-stop transition, independent of the reason
hardware restoration failed. No MAC recovery policy belongs in phylink;
the driver still decides whether to retry resume or wait for an ordinary
administrative down/up cycle.

Without MAC Wake-on-LAN, phylink_suspend() has already called
phylink_stop(). Leave that stopped instance alone instead of repeating
PHY, SFP and PCS shutdown. With MAC Wake-on-LAN, suspend deliberately
defers mac_link_down() and sets PHYLINK_DISABLE_MAC_WOL. Finish that
deferred link-down, drain resolution work and clear the WoL disable bit
while retaining PHYLINK_DISABLE_STOPPED. Otherwise a subsequent start
cannot resolve the link.

Document that a suspended instance can be stopped directly. This neither
resumes the PHY nor reconfigures or brings up the MAC.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a1458da8111b..df520d77fded 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2495,11 +2495,18 @@ EXPORT_SYMBOL_GPL(phylink_start);
  *
  * This will synchronously bring down the link if the link is not already
  * down (in other words, it will trigger a mac_link_down() method call.)
+ * A suspended instance may be stopped without first calling phylink_resume().
+ * In particular, closing a device after a failed resume must not restart the
+ * link or reconfigure the MAC just to finish shutting it down.
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
@@ -2512,6 +2519,16 @@ void phylink_stop(struct phylink *pl)
 
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

