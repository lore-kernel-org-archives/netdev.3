Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554CB43B3F6
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807156; cv=none; b=Pa95xfnvTjH+2z16q3Cc2spRMsEMjBr0z1Q54qvig43wZt3iqFqnfKQ7ZIbhMMa40vgRTbNqoVBZMz28fOn/AJOagGCcUNyz3UMAt4FOAy/VMpMVtnqRAF2F/b7lWQNvhhPU+JkXYdBF/HHUh1QsHNSXXlVvhSbL5Gs3BcEd7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807156; c=relaxed/simple;
	bh=rWTCDK7Lu98+d3mkrV0MN4YOesMUBm1C1YFvlmoJwjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U79ZJIhPlEn18APCd6MrmTjPqROy+MYEQr0jriEG6e64vQACMGVSQf9/bfsaRME2GnSYafjt4Zf2oWwGs4MIJTzrj3uUXMvZygRr3B5d1HxAwmVt/fzPfbKjLhb7wVB+0yf4nzeR0aK0RVa3oKhG2mTTqxj43MeTdysjzMeOujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bkyOp910; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bkyOp910"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so43310805e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807152; x=1791411952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=bkyOp9107L890D0G5Ur/Pny6NN/6bG1EPgwZ4LSfmVgrmaR+Cy+i7SvLwr5O6gnlTV
         /gHPQO1P+o7XMARNibv1AvPpj6AAE9m5RV2WkkKc68l0/7RTct0YDAuQqBFks1sdhEYt
         xU8XAQgFPhuRy4RJgso+0L9YdrmMYj9x52a9WtihRPLnLlt5GKChZFCZ54W+anX8TBc1
         jZG8ZfaWM99hO3qhdYnqmsAtJjqxxyZ+H/SXfw2Jrmn437Jb1Trm1PQaTGhOsnIkBBgo
         hbhypq/maWTiHLt2/8+i4s8iRALpN3m+O2qzCqAYoaV68BWocWkBBK2nLm0X6SpuHf+M
         SuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807152; x=1791411952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=KPG4Pcw6L7vc7YEDhL74Yi4QH3br+rmZJTMjj+Eh7jNy53DgcfFiOy5ikcMm/ZX+j8
         b/zO4WUND0OQmrL4pErL39wYyUvqkEKvYasexg60VKHQZo10XCrcfsd3GVGCEBgXDnAC
         042H8p7AvrUi/gK4RMzb/X0yQJRP5QeR3SJ7/VIxwJvJRy476PruduZhXsOhoc/94EGS
         ButI7q1NyKMv+ab/hF2MjS6//TFofeetHZchfcQ7dJMFlbKHepUC9gY6oySamk8e8Qq3
         nRx5yXd9AsNrlDbBSo2ybMPssV1IGD2bAsSpyiFp2Wv3jBEkLKuo64HBWSWeKqbqBGIr
         svOA==
X-Gm-Message-State: AFuF++lPIWMJDKWeYJMMOxubbwZXYq6BSlOJdyseIo4XgJuG5vROZ5wt
	iqfa/vD2lQaA45Vp9M86dnJKEHHUSe8MJLgroujaZc0EpKsktgDtn61JsssdS6ChKJLyRpQdhSR
	HL0bT43U/pfo9+sBJylTCL4olCWsuBHqlWSrsKEiEd39HYCv0d29UV5d7XBtMnR0fDvI=
X-Gm-Gg: AYBFou1Ea/u+mJGNBEZrvz5y7Ek4D2YAkl9iChrlD/cMo0af1MfKSRCeEzkjyyt8jYE
	4pe6J3SSYjS/5MrFViuEfEmeK/n8V4CmNYKdwviCCnPyJjS5PXbSJvDHzwGumkVECbcGlLK/g+n
	BZpMtEhSw4H6KdhgNJjHqouldY3A+twnQPRewfTaeDcnL9prrS5Ic8StkdqLMnfqAsxhUJYewM9
	OcNp7uxKavNcIi5fA4s+2rTQgqAYHWxAiOBqUBjYRm5J/GLq5PwYgRhUqOo55rEp+Jm+ISUN7IU
	M9J7UOFwII2e5+nHnS69KEGVFUI/CIvgrpPw9M85Ms8MZaPitP2KNTjYwznfU//9Zqbz/dLGzK/
	nlxUm08CaljVJQPeVcmkzDLwlo5iW+7/g4aYzqlrtKdohncNAZCIOZ54jr7oGBxaShLRBLW2c5d
	RrSOTKXAnXEAHTSLh8YiULS74si0vfxiW1atxpWiK7S7W+5CQnQNgvtIGlKB0j78kjpV8wdQTJy
	F0iAyd9duY=
X-Received: by 2002:a05:600c:6814:b0:49f:bd3c:bc1f with SMTP id 5b1f17b1804b1-4a01b124858mr48155915e9.26.1790807152556;
        Wed, 30 Sep 2026 15:25:52 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:25:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/7] ovpn: remove unused work field from struct ovpn_socket
Date: Thu,  1 Oct 2026 00:25:36 +0200
Message-ID: <20260930222542.3839327-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930222542.3839327-1-antonio@openvpn.net>
References: <20260930222542.3839327-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

work in struct ovpn_socket was introduced but never used.

Remove it.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 4afcec71040d..5c87392ecd30 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -24,7 +24,6 @@ struct ovpn_peer;
  * @peer: unique peer transmitting over this socket (TCP only)
  * @sk: the low level sock object
  * @refcount: amount of contexts currently referencing this object
- * @work: member used to schedule release routine (it may block)
  * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  */
 struct ovpn_socket {
@@ -38,7 +37,6 @@ struct ovpn_socket {
 
 	struct sock *sk;
 	struct kref refcount;
-	struct work_struct work;
 	struct work_struct tcp_tx_work;
 };
 
-- 
2.55.0

