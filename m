Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F583E834D
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336334; cv=none; b=ckDjcTyJDM4noxsM5aaP6s34nr6DkrJ0wlkv93/M8BUzy+87B3CBAoAJhurg2r2ZAJvajjU8XfHWgFEd/AFvH8AGJVZfTMc30kgDk7eZNoMBdG7OsVMSjNsBijJluqas9GgNduTqVF+m77HW9kGK9Hn35CebFhA14JvLztLQ50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336334; c=relaxed/simple;
	bh=itnWdfTO7rPTGSzm2C6vlZj2LyTW+V62TosmP2CtgTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU+uBlIk5DkevCl21hC8X+3h9mp7SIfst9FKHZKjF6CORgweCKu31exACTR02vL0Gu9IQP6fuUmmxyAXxhM4TS4rAgecK9AgNPqqsJmQpLb19m3EN3Zd5wWr1DRfWql58kLCq+WO4uRg6jZKWylX4AnrUkMPELC7yERXT0BK/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=RsKOUk+e; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="RsKOUk+e"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so6562385e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336331; x=1788941131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ODrjT6kBXUsW+2D292UeajaaIrcYqKeGJo03Hcn0Jc=;
        b=RsKOUk+eCIVoLXIEkrvcp5bFSs69wkyJyQdm6hX147S5MQumP3jVXnMO/vTs4CgnBk
         vDU+BBdqpVhI9R1E1fDOlzWEDlpj5ZH7NNwyybW04xiVDo9y1zLR9Ug0S0EmsCp52z3M
         GqCO8YOgMOWepxdkg4LIYJBWNs+i1lN4xefIJpP1BoZHWKa0cu/LxKtmsXsIUb0jL0Sq
         FwcFGyZ0b3iKYa4vBRgUcZMiAzA6n8t+j+yM/CWE3MLIlcWVGyn/ucHB+2pckitiRick
         iu5s497lzvJJLAE9nZsEvd+A/gQBNl/RfwNVwssPhbb2RJV2eFUJ/VTvQN67RH7aM933
         JVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336331; x=1788941131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ODrjT6kBXUsW+2D292UeajaaIrcYqKeGJo03Hcn0Jc=;
        b=UxLd7V8T8oLKi3JyEbsCchQi+dXyc825pE66AHapjZJCZbppRqb2gxCPg5wOtCR4MZ
         A6Qp/XqCJI0gYIODOA4/ffGwnh7w99K1urFAkUM2qxrs86PQFyYitrk1945VdFbHKvgt
         EiGzo2+sy0VgbxPW8BqC3Gu6PIgFs5ougapaKe5Dsj7K01WU0B2JH4n+Yk4vJBXasW4E
         MVgdeT4T5rMSsMD7+1ixJsWoJtcU5O9jFzqaH1Lg/HF4qWkQO+FRn0MqslFq/Aj7KuMS
         nfzGJzaEG4XTBVxXMrGPChzm12gOkOFsRHMEVQkCaMxfl5vdJVpt2WBgkpo9rf1Onyqi
         Ekcw==
X-Forwarded-Encrypted: i=1; AHgh+RqgA5Fx9R8fCCf8eSoJ6LNq3YeEM/A9PMiNglfZZcfODjXzSUMd3lCeyrlHhZySMatAP1k1wy8=@vger.kernel.org
X-Gm-Message-State: AFuF++mDbvo4iuzRdHJ0Yy7lsoPdN7fj3TUQaRQsk8i5LzbDPcHaEMRw
	TFAF17VIwu5OtJMjy35+X1vgqk2IMGuAUWgxbfq/4+JCMPcr9dnBzkIHjgMtmtu6Q2w=
X-Gm-Gg: AR+sD13/qPNOHQuxErDo3WfnPzuvCSgn6QRc2eC5zvu8aaLWYMAa0jn6++S0NbgGp8k
	FWzZuoIvUDQsb4F3eBbm5hOYBM1Gd5yVLYyWTjvOtuIzLdJjsv3kMTuZMl9QyNCEwYJCSC4o/49
	y14skHbFvXLg8pXhSVLiWEvXAI47vmSMK1i0zcfyy8KR7mdLLG7jx/L0824Rxmd5CIUHB/j2JII
	+czwr7FfpK0BVxAxQDXlhvx3kFVy2dRzVAHqBrSgbgiaIP10scaGftKYEbkMq83ULMtZYzMXc92
	pcAdH3laRn91C0ddxSuIFH23vr1xUbNckC8BG81h47BUUGSJSJyWqnuMVWUmWsNhce61pww4a7v
	8f5Ss/uozMi652rpLU2fabimLZn7Xb02d5sXIgo0CPKrVODVMjHoNrge3uYjum054IPDhwsX1o1
	3jAM5YtqCl9R9yehxmn4YzsGJETG6r+tYm6N+HjLM=
X-Received: by 2002:a05:600c:1d11:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49ce582a54amr49962495e9.14.1788336331049;
        Wed, 02 Sep 2026 01:05:31 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7dd5154sm17766875e9.2.2026.09.02.01.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:30 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Th\u00e9o Lebrun" <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: macb: zero the link settings taprio reads back
Date: Wed,  2 Sep 2026 08:05:27 +0000
Message-ID: <20260902080528.2211468-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902080528.2211468-1-f@lex.la>
References: <20260902080528.2211468-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_ethtool_ksettings_get() fills only what the current link mode
provides. With no PHY attached it writes port and supported; on a fixed
or in-band link it also writes speed and duplex, but only if
base.rate_matching already reads RATE_MATCH_NONE, a field it never
writes itself and so takes from the caller. The ethtool core zeroes the
structure on every path into the op, so its callers never notice; the
taprio path passes a stack variable and reads a speed nobody wrote.

Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f506033..a43855db1e45 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4297,7 +4297,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	struct macb_queue_enst_config *enst_queue;
 	struct tc_taprio_sched_entry *entry;
 	struct macb *bp = netdev_priv(netdev);
-	struct ethtool_link_ksettings kset;
+	struct ethtool_link_ksettings kset = {};
 	struct macb_queue *queue;
 	u32 queue_mask;
 	u8 queue_id;
-- 
2.53.0

