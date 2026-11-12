Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506634;
	b=xNdn6k2dH3MGwQcDHqPvy2c+IHnabf3ekXbxs2L98argv1JZJqiu4jBwWGUQSLY44VQO
	 Zi1ErFVKbDW/P7VAQ1+5hY0yJDeGZEzUobO6yeUAqTJNw0TRTO2szvLIhqjAR6/iDZZCK
	 zg5senQFQhPiBaybQSWwYkmPULqdzjVh2n5D9xqn0XlHT/0sPMeAaG7zgQCG2/o7eP5RX
	 LdUohMp9UD7YA6at0i66EK6GHY8AYuCFaYpUVdpWTRm9SfVs1IrOMtRrDaCtA+RnZrvgX
	 jfH9pGii718SKG/OTgxOtrDu1vDbdzy2QsmxEgILCEbcRBkiTBRX0/84k6qdYCpAiUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506634;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=F1nWwBgmaBdULC/P07cKbjOH87XcJJ51z/HTXJDp+iE=;
	b=g7EKxhxAB4W/AL9+ngrW9B1g1lxzabfifwg8PFCigsBCYvC46NtNSF3mGv1SuMYM1wIB
	 XCbdxYGuUxU2ZLlBGKKcPYla8MG93vVTma//6FnimTq180wCad827BV7fRalwXwd0Zulc
	 XbNoOWxgMbCJ45NdisTXUFrhvzSl0CVwm7hMN2PjaGXY7iOpyseiOxO317eic0ltLOtkB
	 y75jG+Cp9kPDLW2vYWqA369zT4fxUvUtGNjboK55C+MyTdpO4DZyEbB2WzMKkAETsB915
	 XJkJbxP2LZqSLevh9cYA/s6q7YoEhB3jJ5YDIw7kSmDpL7+VpPDblx/j+OWxzbBmJbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VJfN0ejN;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEC606A89F
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ABEC606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VJfN0ejN
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so34470a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506633; x=1795111433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1nWwBgmaBdULC/P07cKbjOH87XcJJ51z/HTXJDp+iE=;
        b=Q0dkv6trzmr9C59XRyRJwhtwUCM+nvgT39e/yK5krYodqEpA5TZbu3Oxpe2si+kcwx
         l9XP4rarXURCevEfLY/aeD54xMulQ20IRYuokWVDohXLd9wmAcSLjpKzmPDQlGmt5qPT
         q0M85RHnkEpbIuOvX8vqPCT+4b/0mMsZpBIMass0GQ5ZNbPqa1xwAzw2t8GAy/xlzrbK
         xm46jPi2Qe5sNvvNFYTu5TCrgqp8WAS8O+GAVfFYJmWOyuwxW7o0vhqVqDe2fGSlb9XV
         vcOgxixO4Im2O90bKe8mijBJ987DfB6rGC81Oce/o6nQo3FQiVPYICFpn3z1mBzJwWyo
         XPnA==
X-Gm-Message-State: APuU4Z98Hj5wz8YY1JABBohkodwBR8Jg6Dya9SYoCCH2pX4mxNMc/yXw
	E5fSLkZmxAKJWEEqt3XGjk/4X0rqpSO7H9y/7eGw+mVOz3zHkFvNmfXmlwPivdJQ4NVwWVFMXY5
	lM8e4L8o70vrW2qJvo6CWQbYxmK733ihvDAOcP59S1lWcwUAtc7ME0AUaP9P8P87qFKZEEUfqbo
	N3/16dXJTbNoIqoW2kGV0LlvI/qma/k3EG4xGmObyMtD2eiYMIUnjJx+l3GxZ976tpj2AKnfIhc
	+5V7z9jWlNhllAp
X-Gm-Gg: AYBFou2Kx2YAERc6HwjWxF3wgchPkQLGwUF4ojkEZ6umiWVekHOJAUaT3wCd574tCmb
	hcXr9JkNDfVjUxOUI/MbbUjMyntLmPYFBQtAMeRsC+7ynxCqUMMvcwpUIWZDX4hbjvzEnXsHxBa
	RawRVtBkI/9HOp0BsKBqynmErbRdCGRJMycH5IHwxe/DlCRLqRvXEm13g3+NAbkQZr2KDhfO6Ae
	20CPibmzFP/9gjYtk+cmCUcHiw5UvSM6LuTchAZ+yJqe/Fj4PR0n4/hlY7YRmLBnqLHTNCgC1T1
	QgV/WdpH4WyHusg8O+DXomjBDl36xlazMDOq9cXruckaaNDjaLT5ugDO7YcaVYEpK/XjcWSAIfV
	0hj8oez9w0rftoJ9YyjF4fdoeTgxG2fvix9NvA3r2ymvmlq3JcFh+FNlXffn7epQBkuSz5kN3Nh
	uF7j1JGgmI3YXgij24lLviVAM/O7TD2mytjDp+e2GX
X-Received: by 2002:a17:90b:2250:b0:3ac:b2e6:3181 with SMTP id 98e67ed59e1d1-3b182f57211mr6823354a91.37.1794506632816;
        Thu, 12 Nov 2026 10:03:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1ae97e80bsm389674a91.5.2026.11.12.10.03.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:03:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a06da65d92so79063b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506631; x=1795111431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1nWwBgmaBdULC/P07cKbjOH87XcJJ51z/HTXJDp+iE=;
        b=VJfN0ejNQNb8UwpdqxN8f+7hjmMXpMAHLJF4p0fO2DrBOsR3xqxN75znIErrZk48yD
         R9don0LOaX/kOy6hKVccnZRv1sg5cooueCnN+H7Wp5H8gDixR2vmERMW6W7fIrrAtxUn
         mfmJBrymnWBAJY7vHw9Nxicd4MBQPXH+ddQCw=
X-Received: by 2002:a05:6a20:9396:b0:3e2:6e81:27 with SMTP id adf61e73a8af0-3f2fece36f3mr6603620637.70.1794506631131;
        Thu, 12 Nov 2026 10:03:51 -0800 (PST)
X-Received: by 2002:a05:6a20:9396:b0:3e2:6e81:27 with SMTP id adf61e73a8af0-3f2fece36f3mr6603579637.70.1794506630588;
        Thu, 12 Nov 2026 10:03:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:48 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v5 3/8] net: dsa: b53: clear stale state when creating an ARL entry
Date: Thu, 12 Nov 2026 10:01:57 -0800
Message-ID: <20261112180202.324504-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112180202.324504-1-florian.fainelli@broadcom.com>
References: <20261112180202.324504-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When an ARL lookup does not find the requested MAC and VID, b53_arl_read()
returns the first free bin index but leaves the entry populated with the
last bin examined. The multicast add path then ORs the requested port into
that unrelated entry's forwarding bitmap, potentially forwarding packets
to ports which are not members of the multicast group.

Clear the entry before creating a new one. Also return without writing
anything when deleting an entry which is not present, instead of making
a new entry from stale bin contents.

Deleting an entry which is not present now returns -ENOENT, including
when the lookup ran out of space (-ENOSPC), where it previously returned
0 in that case.

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index ca2ba8c157b7..cc42b2a4870a 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2055,9 +2055,13 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 			addr, vid);
 		return is_valid ? ret : 0;
 	case -ENOENT:
+		if (!is_valid)
+			return 0;
+
 		/* We could not find a matching MAC, so reset to a new entry */
 		dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n",
 			addr, vid, idx);
+		memset(&ent, 0, sizeof(ent));
 		break;
 	default:
 		dev_dbg(dev->dev, "{%pM,%.4d} found, using idx: %d\n",
-- 
2.53.0

