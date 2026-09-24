Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85623AA9D8
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790293712; cv=none; b=t1LH6Z0S8kUNGez6vNsXWsWwaMkAarVYg0DqDqemLQ6nJNhbzdxyFqIlNe2fdqSYVQmomNWDPAarC1ZqS3nN7qAI2GQsaPEltzas/VzjWpWmbn3XjH+qiquJLXXzUYKncqTHYNIxp2iZAu/nxZad5zygHb2y/SE61PYG2/zGMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790293712; c=relaxed/simple;
	bh=hTYJ14te7p3/8tBxHYBWaHZUm0lfhODe827miPf3xkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKGraM4DXJWZn7pQTLwEYF1gYNC+5FPRmNuBRGH/AVxjjceDAwoJTRbKJg9X1xvePdhk5GBHJaBsPOMT1ZfHa9u9XXu8QvyvAOHQMySCpcgbO3iqXmNeWiCi3EucYwMeOGDl1H2eUdo3DIr8Gka6wTBOmigGGoCqTeDs/SIgO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBVFtLBH; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBVFtLBH"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso37602566b.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790293709; x=1790898509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTYJ14te7p3/8tBxHYBWaHZUm0lfhODe827miPf3xkE=;
        b=qBVFtLBHXgfqQCXXcoxj7qkzhAsEivvXU6kw4vyxa1TKK6wRL79uYkcq+a9EAl7nZI
         K0CaNxnX3fg+uHjmPuWaQXbTdOAi96NkVZ7QZ9ZC2X9Ik1W8qGh4vIpa+DxYQprpCug6
         Ex7gB96zEO5fot+yVby4Gor4bw5nNFpOVAcZm3s63cAV2ZmSpNPtJNS70KLVHozKDwqK
         WpJb4tTNMFAap7Rxtdgj+gx4tTB+iLHgXalyO8duI1sN5kVCOuxy+zcsShp0fBN4oX5d
         leZweJz501CDmXn8Dx+dqW0m8I5vAgg9XzoacPCPvUP3euVyoQ65UJOiXYyRRTdCh1X7
         4Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790293709; x=1790898509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hTYJ14te7p3/8tBxHYBWaHZUm0lfhODe827miPf3xkE=;
        b=WRYlGIGLRPY/ncgIH35xGQ98qaPMY+f5mwLePbz94qLhI5gSZYLCmlzuBQXFx3cPhd
         NlrcGxEuRZmNuNt5foaif+ya7HefLHca/Uuud89+krY1JDoP0BiFhscbFCGgnivYoDWs
         iU9YeYfG+aqln25a/oavoVUF+DSR+b0YFXG7khpoEkGIC0gUBwPbJGbrHKlYGmJICkiF
         +5/zdbO+STnQa9Mdo+1pMGNi+Dl7KX78G94yI+osUKOLd/+AskHuYKwO23/8ZWx4DIja
         s0I3MEyBM4WMplsQhpS8cL6Oicrlj+15mYvWC6WCNx2KpNX3I9q9EMYT+aqgyCp5mAE/
         38jw==
X-Gm-Message-State: AFuF++nk/SlbUdi1Hwg3rgItT2/LFLotOH0AizsUKT10BtiEXa/GNV/V
	9i+KA1FCcmTwFh2ZusuM7/FMUCKX/4XVUq/0iGYCS2fciaDk2v9r5GvT
X-Gm-Gg: AYBFou0t6jU0R+h7HEN/J0Aaj3CV/SZ4FLfs2cPbiUINOG5t9l77gYqx59zMI/HCC7R
	/+p2VpS/3W7yQAUjUEi61mY7UUO8fXy7M5Mjzr4QFeIHVFaiukdngOMWxo0o7Oi5s6hDmLaRbrO
	nR7tVFEM6VpfmVaCtOastd+lopm24dJJ1tfn+HGSyJaRvcwl46Dpc7Xp25C9UlukQN3CiTjW6fq
	aLjkyVWX3QFXs/9pI6NkX7ZfU1ZMQsXWmSMIxJPtnki/Ma4xaxAszgrmS+6ys90TNEAAwWouq7K
	J7oD04mjFbWncsiue8XWeEHX/YELeEmeOkzIzGwMoqsGnR1ikTat7z3GSR2W2u5Nascx2OCduWC
	hntVifsTo0zDoTGSiNWsMiOmmVdWQ5NIAC8HLI6pNWobxv2gAWcEsEFr/Zp9c1w+44+bopA0XzA
	tvfmoDW70Ww7B4m0FtEPjXuOC+TZSH5XD7vI5aglEbjr4XBPpFAAj5yK967IoiQqMus+ktc9CUU
	ifOxvm0JfkXaTzn/LxdNgtpBImbeui9ua3YlfH+NqfH9MNrH8lFu9iI1mYnNPZksCoQyghqB3wH
	DDYVGrccLoH3sS4Di7qv
X-Received: by 2002:a17:907:94cc:b0:c1f:e9d9:64d4 with SMTP id a640c23a62f3a-c2ac24747fbmr368025566b.11.1790293708996;
        Thu, 24 Sep 2026 16:48:28 -0700 (PDT)
Received: from localhost.localdomain (31-208-26-100.cust.bredband2.com. [31.208.26.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm30757766b.33.2026.09.24.16.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:48:28 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Fri, 25 Sep 2026 01:48:14 +0200
Message-ID: <20260924234814.1734-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com> <20260923215858.1653-5-yongzhao.derek@gmail.com> <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

The register 0x14 configuration is in patch 5. For a QCA8337 CPU PHY
marked by patch 4, qca8337_soft_reset() clears SmartSpeed enable and
bypass before the software reset. I should have made that relationship
explicit in patch 4.

I have a local read_status change for QCA8337, which I plan to include
in the next RFC. When autonegotiation is enabled, it reads the resolved
speed and duplex from register 0x11, retaining generic link-partner and
master/slave handling. It holds the link down until those values are
valid; forced mode keeps the generic BMCR handling. Local tests that run
the callback and the PHY state machine against a simulated MDIO bus
pass, including a case where 0x11 reports 100 Mb/s while the generic
path resolves 1 Gb/s. W=1 object builds for x86 and arm64 are clean.

I also tested it on RA74 in an OpenWrt backport on Linux 6.18.52, not
the net-next series itself, with the existing CPU SmartSpeed workaround.
On normal 100 and 1000 Mb/s LAN links the reported speed matched 0x11,
including after renegotiating the 100 Mb/s port and after a warm
reboot. These were normal links; I could not force a downshift, so the
downshifted case is only covered by the simulated test.

The existing at803x downshift tunable cannot be reused directly here.
Its setter calls phy_init_hw() after writing 0x14, which would run
qca8337_soft_reset() and clear a requested enable on the flagged CPU
PHY. This shared-port PHY also has no net_device->phydev through which
ethtool can reach it; ethtool on the conduit or wan addresses a
different PHY. I have left tunable support out of this follow-up.

I don't know whether downshift is broken in general or only in
switch-integrated PHYs. My only data point is the RA74 CPU link
failure, and I have no downshift results from user ports or discrete
at803x PHYs. phydev->is_internal is set for every PHY that qca83xx
matches, since they are all switch-internal, including user ports and
QCA8327, so it cannot select just the CPU link. I have not found a
verified erratum for this switch revision.

Thanks,
Yongzhao Chen
