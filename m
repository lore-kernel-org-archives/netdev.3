Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394846;
	b=fmRhjI29rqQp3ljX/1FLN72C0zOvz0Q4Hg/Q+fBpFVfUWP+8otiOCZzh2nXgp4Fz+Oso
	 jYiSz29wwCq51DLWTryoM2RHseGtL7Xrcg3lu7HTStc1QpGr0KfjL5uwHB7LKvVRJPVVr
	 rOeTpzxToRvhFEG1t2Eu6W9098MYUKS0LXuv+gKJSg9NbWnr6+A0SkCz7tytiIjDzkpPb
	 9v/8Qx1OtOtm6equq/5r7cc1/Y3gmOlSgQIwqzNZX/wVEZM0CO1P/erFND9JCi5iWBBhF
	 3DWfWfOKGaPdkXHONUzeqPe3XzRCedlYX4Y1pPW2BjsvpAxGDl/AeUFyDk93DtLb9NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394846;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=VE9FP15nXziNfc38hUW7/8pvy2yncMFC7Oe6vk9W/Ko=;
	b=Ehy+ZQh1JNOUyErzQ+9uZ+oxfmtVpqUFZRb910zccvsVs10fEG417N7ZqMSikB56IGJV
	 E8de+olvjcX/Q3uj83SJcfTh2A7UK/Rbe2Q1jpUsk3r4wTbaKSHDHDzqRt7Gv+5e3GLAc
	 5Dz4On9lYC8zNpvBa1Bci8aE30HgOtihsGFITGTEAowcEv8lgaUrdIfBOlUWDRwuap9J8
	 2RHRxevwCJQHvYs5UWCCf4oA4AgxioH+6rR70c7+jNCQvIi3sMhkkdmsTBJ49bYi2nbd9
	 3YxLgsU0V0JCcxkQGemJsg/o65JMsqs+9t3bDYlAUMWPI0uKlOZKfNaJLARX7ZU+/dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NXhdcdE6;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55503606A33A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55503606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NXhdcdE6
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so1696315a91.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394846; x=1793999646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VE9FP15nXziNfc38hUW7/8pvy2yncMFC7Oe6vk9W/Ko=;
        b=l8POZ4xxWW5H0oJKRRX7sVF3IbN8MSsCPx6hDrxZihDVsZmJ5vECNIMeLoq9gU1DeX
         m5FAdeZn5U3eNbmmC3+3G6mAk8RR8IoX0k0aNTo0S0zsr0Hxyxb5krHjlJuKv48chtuW
         Pk2Cwo6ZnF4fSZJPFy4F4SoJ8FMQGioGXMZkcte0dSMor6XFq+ErMLVw5bytw+N9zCQb
         /2LZAv3kQlbWLzqKepyjxrXHQBBfuaxgVW9n1yB4iB036t527eByWsfzaGgk5BIl1QxP
         rAJUZomqrGrhlefazIqOG3f7LJxLG6gEdEf8fEYluYBcurur5TDcuBmrV1Ik8TxjPZBO
         Fqdw==
X-Forwarded-Encrypted: i=1; AKwUvBy9G2Q1qPoPhJEm9MpcHT9Pno2l7sef94cuaqfCLju6U2zbNTnrQMYZHOdTxkJiy+rVjQ/mH6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6p8u18bu75dei6edNMJxca1/hYiKERLvmUddM73jl+Joo9MCF
	e/Y7i+RiQBLr4f+kr+K9A6/yuw38QKOp/YanTpAj/y3zcyKCF/2xFVHxmy3lsEL4MmsqgBiYib7
	DhYjNi4rmh8KHAii1ll4ezyC3uy7Zk2ND1vzWRd8mW9m6cdtLtN9vjPITMv1zLG74/Nv63VeKFg
	KLXQWpmEZR8ZIR6bkDO4eqf15WXMbech6o0ksEnIU/OSLDtIP/JJOo6e1ytQI5aokaCOIaIMw/n
	7r8TRc2rAGz1LRMkG4=
X-Gm-Gg: AYBFou2yd0Apu8AtXoIkYbYA6YGJKfBYeXfkvgOQutIZ0doBM8EiwvrDrFP9bwj5zB6
	xscrDzQEp0W+asfo2b42ITe6rEjfpROigBzQ61n6jUo4dKhPf1FV9xL+SzcozBexeq8ZBGB6vFd
	QZkjs5JONfAvc4/Xduj1Xrj9jG4eeH+falBrCYnQCURN1pKN1Mpdh2mGVsTqls5Eviu1jU5SMdS
	lIQDJ2exN9J2Ed1qEaSbexzKBc99sPnnBDPH8awPIyjDR0TLIRpXtE7ZX6ukjiabLknU+Z/yu/u
	HwdHfq0O5SBt75JzySK2kaiaiv09+gIrR80alXeLZtxsxY4/wPKEBxeSkOWC2WhfDlaX2cK+HTO
	XdXIw64ml38zf0k2Vzi7K9Tq/hpA2VtLvtN2Dp11miC8BlVbQRWd9xhV5SscLVTMFQMRmYJoIM3
	XVVkL7ZRnUt1l5qGW5MRCpa9YLYg+J1Dq5ZYkMa5ok
X-Received: by 2002:a17:90a:f944:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3ae897f57c3mr3051168a91.31.1793394845574;
        Fri, 30 Oct 2026 14:14:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e874b16sm4780758a91.6.2026.10.30.14.14.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3662e7a9299so4276385eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394843; x=1793999643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VE9FP15nXziNfc38hUW7/8pvy2yncMFC7Oe6vk9W/Ko=;
        b=NXhdcdE6/ioUAnSFfeuJl5J14BIirzaIxwUw4JXAkdMx2L0A4aDftOlrioA4PxHn/7
         gqZgf2+wA9p4je5v5JhNtGAkkVFphQzio7n9cY4gbaowF8hH+MjwA5ZP+nClaNMDOGwt
         9gCckfmCW/6lE4Z84z26uNno3cdCJ3fveMUlc=
X-Forwarded-Encrypted: i=1; AKwUvBy2wdGf9+prCq41vEwm4R54CeViHS7Mj717qmiMxi937ZFqWPQe1BlpKyu5OPp/tF/TCYv+jmk=@vger.kernel.org
X-Received: by 2002:a05:7301:7d1a:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-36a42340bd5mr4468279eec.9.1793394843008;
        Fri, 30 Oct 2026 14:14:03 -0700 (PDT)
X-Received: by 2002:a05:7301:7d1a:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-36a42340bd5mr4468231eec.9.1793394842178;
        Fri, 30 Oct 2026 14:14:02 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:14:00 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netde@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	netdev@vger.kernel.org (open list:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 3/8] net: dsa: b53: clear stale state when creating an ARL entry
Date: Fri, 30 Oct 2026 14:13:45 -0700
Message-ID: <20261030211350.287566-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211350.287566-1-florian.fainelli@broadcom.com>
References: <20261030211350.287566-1-florian.fainelli@broadcom.com>
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

