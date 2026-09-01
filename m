Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C73C0A02
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264483; cv=none; b=MyHvp4uKdEGlaL39d6JNryKuBvqH+42Fy8uuvu/l0N9LbVIhra75B8et7zjxGT10fn6kOw67Q9/x9ZOMeOdb9KjnkwkgjT2CPpRxp+4xHEE9kJOz2ViuTMldAR6PTZ4v56k2+VFatxGeyh4rhOUGA+v4OSENX1YThfeuG4ofNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264483; c=relaxed/simple;
	bh=0MxeVaPX+VtYHYLIfWJuakpriIgNaFhZQH5yt5XofQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daq+VsoWLsizRRqpcN2dCmq0zq750V+hySLj9TJEqJeFZ81YgL+Y6Xr4A3COPboty3HoBrSh3lEFu5E4HG1+n2OMUDgA6d6SJmU8vw1jHVsP5ssxN5SR3fcg+/GZ4YoICKfMrtzVchLND1fNjBpiCg+Z1Moq8ktJ7D1OJxueoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aLb3gEAD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aLb3gEAD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so55901155e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264479; x=1788869279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=aLb3gEADMpF6I9bjpqDAPymz2c7H7+KSf5t+mbYvdCqq29y2k3kHWMDQe2jbibZ71H
         5YMao84Ms3+MDBr170ILefNCHB4e+anNsLkwEpiOIOlC0aABeKwZwEVUVcJyUsTH/VOp
         XPmaqAsFuAQEK+0DgACKuLcQrXdKmBh8gw0LqL3th3Bx+5yIXvgM3rtl8T+AAUof8dMr
         bU6qs03GuN6ImUdhDFssV18DMsg/2Z16v36kETCRtRKLocLMaeH5UT8Q8tQxXIfnlS4q
         gLMaCAVXjAogURiQZswyqFrW7CPi1OwosAEfjMHXKrDEdr2Ihjuct/CJ3CpphFdtIe8f
         +uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264479; x=1788869279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1RePcB2PV85iRGG6QHEJIV9lhGnKs9EHteVDOYprXQ=;
        b=c//+/wrYfUXDEagDRxjGLyWrZhAO8bGOMqVHQQbbIDX+5J7JV3dU8GS0eOhfF8CmJv
         wBFT6+3OxvJr7MBno/8J8MXWvdz24IoF+0fuTih+a3pEhuti5NGd4qY1wQI+rrMruBV2
         k7loe27lrKUhPHteCLHY2XmDYbyqixjGY/nEuiJ7UDXYQcNLEKYcOEauPBawAni9lAI+
         K+83EKYfFtFXVat81SRjj0H2neUnguB5Z8mTsDv75xaU9rRLViQ3CV30W8fZxP8qr/bR
         QFVpHpDSg/A7CUo2/bCEokXfxYzuCM2waPzA+PbofpHzErFRc69Ls2jeCLDb0xAnzqEH
         zj8Q==
X-Gm-Message-State: AFuF++kFXEEkf1lIlrqjhk/WEczBK5u5gNMN2PyoKN66bckk0WfGXnsu
	xBQTli8XGJqbNfieeBEOXS1wqhU3I281KjxM2ffHna5gcuqARenQwvT+3mdtHCItYdlfav+Z363
	yx2hW828NxA==
X-Gm-Gg: AYBFou0tD7v2ywsxo0FxRlTwtp40RFR2qu8ewRDIjNkd6JJTDKnXfB1fMxC7SpGnOJp
	Obq7zcsOOflRLCWDWYIsyXZ8lBdyg70+tm9CiDBI0hZH+fzhUNe0VouTzst4iZzpVp2g+8r6tFk
	TlKkfcRAcQ3YF+fFM0yA0q6kPc+U+fQ3rE73ZqSj34sdtrQdxYYv68wL9XWHT3zLxpPaudvuHTm
	w4dLlxE7ymrJqlQ+CRipaUt89v+G5UpNFr6sh7OujYcG5TMD6eTpsv62p45z7kllSbIDP0cIMiD
	7JTbbmwuHkumIp5fl2XGQD0noajdKQwcVyBaf+EWyJspt1igmBmXQDusV/+obQEAt0zVK8ffjkz
	WXLByjB3dcfXb9soPzoAyUANlsaED0tdW//kGsNggB55oHE2pS8xOMj8yEyiwq8xKt5U3DBpEqr
	GlLR7l5nnNw9FhGTw6cUL4xT8D+pvLSmhKOArH7AwYlhOCKJUz6mZEsN6gjwVY6DAEOuHQeTUum
	5ZDa9NGUuk=
X-Received: by 2002:a05:6000:4910:b0:482:a8b1:aa6d with SMTP id ffacd0b85a97d-482f79c1923mr53183309f8f.10.1788264456451;
        Tue, 01 Sep 2026 05:07:36 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d781bcsm4239998f8f.26.2026.09.01.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:35 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 1/9] net: bridge: vlan: drop legacy memory barriers
Date: Tue,  1 Sep 2026 15:07:13 +0300
Message-ID: <20260901120721.747908-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These memory barriers are legacy code from the old vlan implementation
that is not needed anymore. They're also affecting the fast-path.
The pvid is changed under lock and is read with rcu only in the fast-path
there is no need for a barrier, nothing to commit prior to changing it nor
invalidate prior to reading.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 1 -
 net/bridge/br_vlan.c    | 2 --
 2 files changed, 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d337b1cfb980..5b2c22ad669e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1687,7 +1687,6 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
 	if (!vg)
 		return 0;
 
-	smp_rmb();
 	return vg->pvid;
 }
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1e0e436629ec..2ae6ffb23399 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -40,7 +40,6 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 	if (vg->pvid == v->vid)
 		return;
 
-	smp_wmb();
 	br_vlan_set_pvid_state(vg, v->state);
 	vg->pvid = v->vid;
 }
@@ -50,7 +49,6 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 	if (vg->pvid != vid)
 		return;
 
-	smp_wmb();
 	vg->pvid = 0;
 }
 
-- 
2.47.3

