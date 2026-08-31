Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4739D6C8
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212873; cv=none; b=Jced8FhqsD8qpS8cM08peMbP6HwG7iPkkul5ImFijVagq9qNobIxz0OU2nBeDN5nnmGLpH2qg0N80+HrDlm3HuWFxty9tDkeAGigjJxlQUEavV7B435IHqg6zs+rDf90qg+Ry1fCHqx0zZhAgFFCyja8qcQHxdOVDLIrozf5oOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212873; c=relaxed/simple;
	bh=ynypFeeMcVFHMmyNNm3Ko2CgLlcEE/Akeh1XxvChmQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJUkJU8IuwVPOauf9Epy5CAc44LGuvLQZPe/F0vhTvCDrdBTJb1MdnITMfTa8ooC6GFa39zXORneCGhkL8JZfq1H919tHxjx4auG3lhQAIgOVsh0Sx9Lark5uKCKu9bxdZAZyx382CjGwuiUJTb7TQU1DIIwYFmRKCOKOvkMNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxdnpo+V; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxdnpo+V"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c953950dfso40668661fa.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788212867; x=1788817667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HR5w4wu2d/AdbodPVdlLXgyYzkKXoBfBxxBtTecxISQ=;
        b=nxdnpo+Vjak8AQiAgFi4numunHqmLzcIH3ThaNDlmAuvcu6UpFx5Za6MaKngv24yaO
         9/6P/Um1Qi9ZLxlxjIISUXTph6BdqZOZCFMNsvFf/4zBK5VSAj0ovmebbqCXLQ5j5S/D
         pGt29061RqOuhShQaynnn+qmE6UwBLR5PeWoU9fdvUVnneziiHFVkyGvsZ7SgmIH4V+l
         YHu36H/OmW63lOckPiEVBIPLmWjKw1Cm4WO2snhVIHH9q/W5mfRKX3Ke9Qu+OxUKoRBC
         f6j9xSpZteWwVAcoSsM2bxAXm9Ym3VmDzvOzwLEpmtX2cxlTo+g0IIPVIUUZTyBK6hDK
         +IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788212867; x=1788817667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HR5w4wu2d/AdbodPVdlLXgyYzkKXoBfBxxBtTecxISQ=;
        b=bThRNs4HQ9y8+8Sz6CaUiAyPECKGOmh9lkgn6CXamx/R7hsUhtm05N7BQjNtzoYhgv
         M20rIQG6+tOfmLUUJeSDfK0b8mpctfdijd6wIWo+4YxKcwelwQckbEnJ6RMhd64mHbI8
         CTtQSQkJRN/EIxAYzDceX/T9aTBUrLmDx4IM6UC/HIpluHiKJUoWmNjFg0uDOBHadrio
         TzmJDKYIVZ5aaOOSupA8OOwM/MLcFkdoEBqP+s0zkarKMbmXY852lzLXg6TBjPLKGAJc
         qXKnTmb3lspb/RHE3cgwtksKAfANKOBVKCvm3WjlUYJpYaXAhiX9G5GbQknF5ISGITeF
         iG5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxu43vtW96FCaIkePX2s9pjF3Hnw45577JCT5aoBogtlL29Mm1Zmedd1d8n3JM3erEgHzBK2Y8=@vger.kernel.org
X-Gm-Message-State: AFuF++nKAFrrtMWG54X5bCIicOOFVX24qXy92U7oRmRciEgD+Lv9mmDX
	FXBnbIQViGoGUDb1koGDLovraJ4V8R+VfIJ9tkT1sYRY9SJb8BgVkSE=
X-Gm-Gg: AYBFou0sAMMJWyzpE14N2MWma/cM04iZLeo7XeEO34+ssYcI+pnqh/Br9224Qz3v6Lw
	dNFjdELpqr0uH8uwVrBxv8JcrotL4lozXS7H88VAVombxV+QWizlFeMoYJHWtPQmgbN75eq6B3S
	CsY1Xpw8tWm9zqo2KQsDlh2IqoLGsCwRRK7pu8BXwzaCxgPPPTqNb/PawL8zuCwYBOpHWEJuDPO
	TdHlewBz9O3T8cz2loF19fUQckE9eOYKEXNKRPUL3c/Dwp+qThPaDYkCJukmtZeVDMRu4BG6nOy
	sFy5OMxjNt0U9IhP+YI3zWCDS1OCQcWEC1UOaomLpoW9t+0xvQdRW+M67qyvyn7WGLR7AACS6A1
	thRW2WH1t/cB2T+uZlHcNmJgT28OQ2gfYBe1WSlJU9mk8sHGPsxs8ExiRQOZS15rIsmPzcxyP3H
	oLFTBVfKfHYjkxVmbafIKqoeK3WmAH2zMfhFj5zaCxUGdhQkQkZQ==
X-Received: by 2002:a05:651c:30c9:b0:3a1:ab57:ea2c with SMTP id 38308e7fff4ca-3a33948c4e0mr10050771fa.2.1788212866759;
        Mon, 31 Aug 2026 14:47:46 -0700 (PDT)
Received: from fedora ([92.36.9.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a31550cefbsm18299201fa.9.2026.08.31.14.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:47:46 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net v2 3/3] net: airoha: grow the small RX rings
Date: Tue,  1 Sep 2026 00:47:01 +0100
Message-ID: <20260831234701.206021-4-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831234701.206021-1-sochnev.v.74@gmail.com>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
 <20260831234701.206021-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raise the RX_DSCP_NUM() fallback from 16 to 32, the vendor SDK default,
and give ring 4 the 128 descriptors already used for rings 2/11/15.

Ring 4 is the shared "force to CPU" ring that airoha_fe_vip_setup()
routes BOOTP, PPPoE Discovery, PPP LCP/IPCP/CHAP/PAP/IPv6CP, ISAKMP,
DHCPv6, SIP and LLDP onto, so it sees the same bursty non-hashed traffic
as the rings already on 128 while sitting on the smallest allowance.

At 16 descriptors the completion stall handled by the previous patch is
readily reachable: on a Nokia XG-040G-MF the recovery fires roughly every
35 s under repeated PPPoE dial-up, and negotiation never completes. At
128 it did not trigger once across 500 forced PPPoE reconnects over 20 h.

Ring 4 and the VIP classification feeding it are shared driver-wide, with
no DT or hardware property distinguishing one variant's ring 4 from
another's, so this is not scoped to a particular SoC.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index c195dad5ed58..0b7c90940272 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -41,9 +41,10 @@
 #define TX_DSCP_NUM			1024
 #define RX_DSCP_NUM(_n)			\
 	((_n) ==  2 ? 128 :		\
+	 (_n) ==  4 ? 128 :		\
 	 (_n) == 11 ? 128 :		\
 	 (_n) == 15 ? 128 :		\
-	 (_n) ==  0 ? 1024 : 16)
+	 (_n) ==  0 ? 1024 : 32)
 
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
-- 
2.55.0

