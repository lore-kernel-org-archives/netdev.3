Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468224E4C6
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790468691; cv=none; b=iHrIdvgVu3F6tHdGwbrdZiW0tlehwetLU/KYBnijSAuRqBeWYcc2tXt7mA08nTO2C5HnFuD29FO1nv2x3XMF3UDmt3cg6hRcJL/AEaymqkmfSAQP/YMUudoSbklZxxd3BBkMvs03uFQ2SBsR9p/T34vU6/z3gGYyRZ29/z90rrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790468691; c=relaxed/simple;
	bh=J8Mf3HYZaTmZYQFkYELALEytTws8uvz/goY09yFk2pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV1A+H+alFgHgFGx1lxQZkBupLmCExDuSt6H/wTnmkzSQj75smcAGZsPwYOCx7DwdaCEkchbMzFK+XMG4oaZxypqMawS3O7h34KdKjN9ai1M0KktGwFGs/Y43KbMUjwVLd3ym6hLAo3+43UL2EkpLAYDDvc7Y9hD975YWUI60Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFdf/JV7; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFdf/JV7"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1446567a91.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790468689; x=1791073489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=CFdf/JV7+jF+CBKIz7FEXWGpUX9VGYxIbzZ/OlilwhqDFv9pF6RMhlq1h8k9NRk4XG
         TRPrKKSN3JVKFma9E5pSpvwXD1WwMgcE31oFjMStyH3YK/+nUn11GM60ty7VH/IJV3y3
         6SsTN4ppBhkCVzOxS8EY1qH4KoYb7OTpIq50WYtHRF4bWu6lPE81hLCkRoGTpOi09PFC
         Mvq7g+Ph0qGlqTjfLdUTgdKGmAtvAToNffpVsTKPNh7xU/4dxpoNsUTeJ+Wimc0ZvIrX
         iclIQFQ8FjgWn8NKoDCJn3y+q1LKZOAgVbSx5hbdmKcceQp/t5XA0SmxfxirIa/63oIq
         KWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790468689; x=1791073489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=BISCFE6tSQqN3m/O/BV0I7zmX7eQgI5Xi7cV826cJLiHjJlI0TJZO+FCfV3/dBrGsK
         96MrFpR7oZlTVpDQZ3OXzoA6w5UtYuFi3/+McA7QK86pkSvh5+U+fpL+7HRgYpKd5TTF
         Zg0mX0+pZoRdbHKOGwGxDSclEB0yG0ZoyUJ9QOJeOHu6URBC7png91D2dgtrTt7FhNwi
         2KIMRO8sYO6ybj7G45GhRGD8LOXSKjVDhH9oysPhYjGs14jbHnU4YOe9mQubNhecblqy
         d60fKV8p3WDzEDt6kzmVPVyAV4cCRpcEYqBwB8Zy0W0lPJLHsRZ+sVPXEJXdWaV/4wlO
         tfTA==
X-Forwarded-Encrypted: i=1; AKwUvBzR/V5cGP/+DdspmOexORd6T1BlqoQ0PZ25rpjhS6UqCvnRFMZAW6FRvUDuTSDeKIkRh7kwkFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGooJBcjSDpz26Tl4eotKHkwMgMWf4m9vKTVtZ8ePqb9c2wPCR
	MQuMHUEgbzM4EWwRPZ4os/9iZqJXmpCstQDryuVE/pjo14Oz/nUe4tke
X-Gm-Gg: AYBFou3Qzw3FMRCgVOl8W+w3b4DQFkki1JY7qFIL5coqNQKs7L3AxlxbAtcLDAO3rPT
	ZlbjNteZDfh8ixFJuijMFvVB7cR9+Mc+7wJbCpbCh0t9Z4u2rlxDGSvOonX5G+4TmVHUd42aE+Z
	VgZP3PR9azic/9qlFM19B0yY4n7i/zCbomHUsqYwL6Y31foZgmBjM7qpvHXXzNpw430WVgsyNV0
	u0NMzsYuWKXqJ8TDmaEcn+cKEEeBy+zWkei744praGrUm1KYCG9/cFgICTCCT1HnOSRxlyge5wy
	U/knSYXjuxLBZ5IXh2/O2joECfAruh70QX8ShKeD4XMg3zLdn+5YDgUf2jHdmALkuM9IQ/nN+0b
	FOfjA4vzzrufJSpqGkF7+quCvuuBZGxZ9Ydmib3tFh8XJTAptQsbbZlCREynNnOUfW89gEGXJWf
	59Y8BNpDIqjhu5VmyzsBdXOqCdPzAt+TNmveZ0Sudy0sPkIDOhRhf7b0r/O+l2jlcUx6lBiArI3
	1F5X5/ZXrbKHO4e+FElP4lCYIixXFsFY1nhmfk000rC5k/8lLEnJRn7E9/1
X-Received: by 2002:a17:90b:2645:b0:39e:6c68:c77a with SMTP id 98e67ed59e1d1-3a098e05151mr8205483a91.48.1790468689284;
        Sat, 26 Sep 2026 17:24:49 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:78b6:7bf6:b1de:12ef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c680sm2698224a12.16.2026.09.26.17.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 17:24:48 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v8 1/5] netlink: specs: rt-addr: fix the type of target-netnsid
Date: Sun, 27 Sep 2026 09:24:23 +0900
Message-ID: <20260927002427.4519-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927002427.4519-1-sigefriedhyy@gmail.com>
References: <20260927002427.4519-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel parses IFA_TARGET_NETNSID as NLA_S32 and rt-link.yaml
declares its target-netnsid as s32, but rt-addr.yaml has it as binary.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0ecbd24c890c..17ead2203451 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -119,7 +119,7 @@ attribute-sets:
         type: u32
       -
         name: target-netnsid
-        type: binary
+        type: s32
       -
         name: proto
         type: u8
-- 
2.43.0

