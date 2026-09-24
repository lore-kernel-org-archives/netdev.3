Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB023164BB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212568; cv=none; b=IRWToFN/JztN93XBh6LHUMixFLRoavNyi6uju6rhE/kHxQIshbU0soGtc6/VO9BwyYXOAYPhGf3HclE/AY62w9JpPj9t2xJZ6BxhzPsw4Ug2gxDhHrOLvaaPTdpAXVR85XcylbpVmcfjLTmGwO1s3PAkERt8wLE/bw/IBPVFwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212568; c=relaxed/simple;
	bh=J8Mf3HYZaTmZYQFkYELALEytTws8uvz/goY09yFk2pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOOEDrS9PdlA9UysT0JjAGFOqYg40ZulhGuCzq59ViLDZpc2qI0/gRtR/WlQx94nXtajZPllixYHS3U7GLzB2lJa9o/zm8SgRNhAg7fCDraKR1AHeajkIR+7ud54jdpcAmMZHy3w5cEZbfqP/ffK0QxarQQVTmqzL3zmFAUiwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyEk4hV2; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyEk4hV2"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-868cfc5c244so563896b3a.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790212566; x=1790817366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=cyEk4hV2qa0spkaYxZIwWESxomqDUjloyvE8GAcfU41Z8AUznq1Hl+VDkFSm39LFL4
         rxfs1vL5qdDWAO2QoZ4HWLWkJZSgAnFVjaGm+1BwuY9qZGT9f2A5kfA0qddxuWsAf0tj
         q67joE6K64mWvH8pNJt+HxNpxMuMEAN+VgYDkKSVJqhEDm3g0ohC5YFzTz1tkTU8AWlG
         l6vbOiwuZIcA1pvKFVxY5meBQq+60W+b7TIyFihz1pMCKqNGYTNvjmiTlsUEtzCnDUpX
         kN2ud4IkGIS01HC7v/5IWOfYxuLXrVxLcUVapCs/Cm9yd5KrEhtI+1G0vgsFlNIHqoEF
         pGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790212566; x=1790817366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=iHWiE75BKhsBovBKjFdVSCiDlrw1hYlb8hi/EgL6utapcRqjIu8HW1/La/hHUtTmEv
         K3MbpteUi8TbdlvWplW/SIxFpdBVkVSJ9mFpK/RVeyMG2lsLcZFspuFgNDkJm5UXhp++
         qwqcBHQo39Xtbo6uAmu6HQTHVatlxdSJT1UvF8rz3TLcMkDMMpxNF+DLI2Y7+fdjjrl9
         avJojNfPzWTfeoXvIRbMfoWkKQppJGcVPwCrCKkSUMSLIAzitBE+Ix1ftLUt6TPPP3yv
         JcC/ROspcVDibYnOR3gVDi7YuSiMTasKWU+etPEmEoCuUuA6hjLXw44gDoMQXqgN+PZX
         LTMA==
X-Forwarded-Encrypted: i=1; AKwUvBxLbv7srO4YbNAxFJA25V4qFkq6Q0fWP/bLwoI0F5wQb7t6LLBVn+uDY/jsa5wdM6VT26YrNpA=@vger.kernel.org
X-Gm-Message-State: AFuF++nWkNrCn8ElI8ugDWd9zJd+nfjpzDh0gqAoiyaDEOKbXfbWTkti
	OZ+wBj5rtc9A1eGxQVc5fsOzakIWGWhLrqfPqvF/0cmzqBwFoY76kDOdecB2nQI2
X-Gm-Gg: AYBFou3e7AUGtxTz7HSgSmYboqCf2miQXT5HBBBWb/1imfIU5zQGryZu/eeFCqZAY1t
	0kgdnpwOeOZ5ob1g/SGzenHbfdO3a4Emq3I4/j4oqVlUp5ENOar/HFKHtR7fbT2p5jF4e/jpC0v
	HVvP9zXsz/OWBMBxHX3V8aspYXblRTLotBF/VDeHGUI5kGJAG+0kYvX/PYgSUYqdfTby/cIJUJ3
	IGzclLzhUmnLkq+xJQAFHGXrNhdFek6b5Np7DFWeDH3K2yzCBFgkSRG/VO6C4p50M0V6+uqPc08
	/WiGdLZm0qOMjSQswWiioUEvmLXb60PIgLCkqQVHpx7Q9NFeIz8pW1z4tjumEerkHemCqFen8Hq
	mUy2nxrr9ltUHGbMxCiEYi99TEs00yfJsQp1VSR6iuMW3NNPAtoH3zcNEA/Aascj+/kZHwpflXO
	kBCBsxp11p21I5d9EMKGpu7xi3RU2hNZ2HV9jPi5Ic/J5SHDksaZ/MvkpzfiwT5nfINj4kp1RIY
	Vey6o2tOkyOuOGdsJ/46QnvHdBsD0teMaHas8mfZDcfUgOKfU6AYPTlLOpCdYs2wJrRyRECX2ao
	qxPbHcHyrqM=
X-Received: by 2002:a05:6a20:160c:b0:3dd:a196:3098 with SMTP id adf61e73a8af0-3de0e976432mr797444637.72.1790212566305;
        Wed, 23 Sep 2026 18:16:06 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3d5794sm1741392a12.14.2026.09.23.18.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:16:05 -0700 (PDT)
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
Subject: [PATCH net-next v7 1/5] netlink: specs: rt-addr: fix the type of target-netnsid
Date: Thu, 24 Sep 2026 10:15:50 +0900
Message-ID: <20260924011554.3494-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924011554.3494-1-sigefriedhyy@gmail.com>
References: <20260924011554.3494-1-sigefriedhyy@gmail.com>
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

