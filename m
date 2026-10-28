Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222603;
	b=DtR7EvsHyRW0AGv176qe6Jxk0O9e7Y9VZTBLjPtmojW579dqtvYdKRCnfA45456wAHPV
	 GUM2PEec2SV3IdK3GdMycPc3xJT2P8tNpKjVODeluSQqSCmoOFH5knMLIxIqsjAINJcgW
	 FjtBQcM8ytFooOEEPx79s2rWWq2LiVHVTH/hVluEAsTS2xfRTKULlCD3Tk2rM6ueiQOl3
	 rmiE/p41WnpyIOi5TVSjpWQdOlaqJXeKhZON52gyXLCd2hGvcwq39eU0pxIKLGAWpMXNn
	 H9saFGsSrvhnU3q6X0eaphgfAFH6gOT84L0HUu1UFFnOMTKDx/xXIhgUAc5133sLNZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222603;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=+xDDnub/USlGbljxL+HoXgFuI6ZBllmiitewcex2qwc=;
	b=eeaRrHkGl/4UZqH/9d4cnqfpToXqtR8V4CG2IZpt1q+hLY5dvVgm5kpy/W7hKjvv0nOo
	 20iX0d/DzBOxnYmsAfChursm0i8k7IZthpX7C3q7e29ygPpVNKc5E3KTJbefRsZTOfe5R
	 EEoEjlwVWCEkC1hGj0dpZ9MzoBpGjzl0Yoe13LFmUQYqIYtk06h2fvzUme4PMEClN891k
	 msNTBbqCzemgMN1jcmpI3SXJFw/Ph4oyb4UYBQDtpYTUBmZUwb5xiEpvAoTBaDU1Ed+JB
	 94e563TEPPExmCes3vydYkexw0NiLRssd4aMV4HQTE4tHYxum39LeNjUx5qfVZV2XNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UR4L+JyL;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE9606A32E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99AE9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UR4L+JyL
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso840265a91.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222602; x=1793827402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xDDnub/USlGbljxL+HoXgFuI6ZBllmiitewcex2qwc=;
        b=yKG8l3DTn2rpMJB3dReHjpfDWkFJ7iERAwwSepeB7d1/FXRys5e794eCPEkar19zKm
         5aCxknfhz52ZuPQHxOi9XYWg7NB6Bk6U0KFQIClD+rBQKgyq8+KrnrA8mLHAdt7Pd41L
         hg7yt3/owcC3+e0E0TuWkOXvHAVROCm9h5itownZzFFOenvUDfFC/zA8M24IyKGlDf/y
         nz0o6jy7yorb9VrCQYth/XFcYlcofxecquX5RiTL92qS0UEWZYNAhfTZwPMgQqovYrtF
         ZQ/IfHPBRGEDweBS5nqWHsOSDVbDYGv2evLJlDwVn9UiPnZRiCfxTZE/uB5hh0I616/P
         BygA==
X-Gm-Message-State: AFq9FYJogYXnJQWPIBrAw2pcDDKHUgQ7tMCAAjIK57ZJI1eCcIkpYgC5
	SgzORePUoYn/cbE8eNdvFW5JTkkUEpF17GQq+YWInTK/aM9xCC+fN4SAz+5LPm/VgV0RvX0mJGa
	zv6AE5/+NLZ3v5VDquh+OAOGEk2Ia/MC7+50P8+hTWkLPT8LKQV6fs9CvjW1EW00Nn/j6iXwBwc
	9rJIwr6aK0O38/VTgey1vHX6hSHvjcwi7IHjAoQwwe+JTW6AGjdPV06bdnGYfs2FC+KjYcwrzCn
	88HoEY+yFg8cDkm
X-Gm-Gg: AYBFou2r81YrWPFjyCg6a6mZmSoNQb1KwdACL4tf+tuRkMXkH4eKR47+QChy57qgPio
	0ZL31ltAZh1l4e09DmtyrnZlYJO4v4f5cHlypXn2fka6ZU0sIpmFqtTiruZr0Teev144be9ZM1V
	afMxPVhS4yZ8tQLnEYept16t/YO3hfov+e0m1K0eBaZdNwtXpbn6WTffiDtqWm3mDJ8FowT/y8+
	OUs0Q34TzQy2AnjgLSK/6nERrx0uIZCQ0aQaL6m5dxjO6N1KjNEzbgOOr4Z4IiZohc30NDIme8p
	059xBzwPKMeqWlEFqNxjQkutKCmkZynF3IgJ0iUEzq7BknXQECDqFntQzljGQpHmbLPTEKcM49q
	bDb6Kn6Dq2YjJOCiA5XDbdaDYc8nv2mlQoHPldLWgbjM7E1bdMk2+TgclRiPIy+tvYKEQ7U1YI1
	u3HrydSlpBMgFXbbKl6B8hULqBPdWWnCPkPsXkE3DZ
X-Received: by 2002:a17:90b:5290:b0:3ac:d39d:ee4f with SMTP id 98e67ed59e1d1-3ae5817ea0emr2266003a91.44.1793222601898;
        Wed, 28 Oct 2026 14:23:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e1fb921sm546922a91.0.2026.10.28.14.23.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:23:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-535131e4c25so38104661cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793222601; x=1793827401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xDDnub/USlGbljxL+HoXgFuI6ZBllmiitewcex2qwc=;
        b=UR4L+JyL/2WTAbqHQ07zi4mFZ4nP2VYNBOaYbKP5uwiqFfirZljBCesPH+Qv1nk1Qw
         7NeAu/hiZaxNSTPc9KMs687Q+Ze9625IjVXCfSNp/US6srr2SWGp9jXjDuoeofIUlczi
         WJO72citZeVNhPAHXJkT66JQmJjQIxP72c+nM=
X-Received: by 2002:a05:620a:28d6:b0:93f:d27:c89e with SMTP id af79cd13be357-94408ccbc8dmr598684085a.75.1793222600660;
        Wed, 28 Oct 2026 14:23:20 -0700 (PDT)
X-Received: by 2002:a05:620a:28d6:b0:93f:d27:c89e with SMTP id af79cd13be357-94408ccbc8dmr598678785a.75.1793222600215;
        Wed, 28 Oct 2026 14:23:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669112sm1368755185a.10.2026.10.28.14.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:23:19 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 3/5] net: dsa: b53: clear stale state when creating an ARL entry
Date: Wed, 28 Oct 2026 14:23:08 -0700
Message-ID: <20261028212310.3847553-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
References: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
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

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 559d4b360c82..c38e8c5838bd 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1990,11 +1990,15 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	case -ENOSPC:
 		dev_dbg(dev->dev, "{%pM,%.4d} no space left in ARL\n",
 			addr, vid);
-		return is_valid ? ret : 0;
+		return is_valid ? ret : -ENOENT;
 	case -ENOENT:
+		if (!is_valid)
+			return ret;
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

