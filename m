Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282635;
	b=Au73CGNSRyfK3Db/w0C1xkRRb34Oqi/t+el7sruBcuEVCy/yL/9YfW/z7GEz7qd9HNeD
	 BS/KbPmwGTYoI0Iyc/GGC9WhzpToL79GsmTsR7sR7YXQ8ZXupu96n+ZSB5CcxbGw1mE7s
	 EMOVBuBkO2jcGtQ3dVkRF2SytiX8HTCT4QnpdKIjwbKJS2QEsPn3+t6jtw7RCVDTVECxq
	 QernrM8+pNeWyXsB+35uFaCjb+GchtKoTWmkuPGCI3MzLSNHC2RjpkdfFt4QjMc6+Aw5Q
	 gKv+Vuu1Ol5ukq6Qn/oeTcuRgzwi8aLrX1bfiPfaydjAG0Uo1i8q+2NrgclJvB/inYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282635;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=F1nWwBgmaBdULC/P07cKbjOH87XcJJ51z/HTXJDp+iE=;
	b=iCkYH8ZdrYVvVQDx+vjl0glqct0V1ypnTY+XIF0HxOCAyZis8Yj76v3hMCIuc9Bcs6Zn
	 7i7zWHZ2eFuyJzkwBnfKxpfWWej6+Dt1LUJbHkFwq7IM1K0nd+ypDjA0Wz0vanIXUQ/Uz
	 xnzjxHwwO0KCObIzVcdBBgNwWrz+1zzkpW6so3P5SJfDuiPgiJ3Dx+xFrvDeFek0m1igv
	 4xDzBJ+708GyKTJk0qBrZ6eyc9TbtmLllqrjx6Qg+33PJU21K0RVdggpo6Ve6p59exZSt
	 +eo/US91Z7Y9MJ4w/7fUjuZQnY7MIuznmFFOn4OqBtki1CEN8gCiNxoHMJCFv2NBQ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Qd/KyMiW";
	arc=none smtp.remote-ip=209.85.217.99
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDA60A2638
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77DDA60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Qd/KyMiW
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-745497ac8fcso545149137.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282634; x=1794887434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1nWwBgmaBdULC/P07cKbjOH87XcJJ51z/HTXJDp+iE=;
        b=rEGATUQPXgNpm1LzI2ARulLnh0lMhEWn0xOdKqGrw++0EWS6F+g4wgIhR3Id83HEC+
         a0h5DcazhKorf7h22rAOI1eG8bE6DtPrap5HpU5MN3iP4zzqzWU2z34Ytun5SG2hoaw5
         tNwKptofbofgQRzbQ2zVSMXHzrNAtXKo7QZXpPd8NidpduQevhMGHia6mI/MUeTv7uXp
         V/3CGyg1gLrMHEiBS8dzytZAWeSvT86J4K5JKW7FuaI7tfQUXzSZNncfEuZ4/VSmKz6q
         GJ32DpcsgrymaSxBAQzjkRYGcYE4P7sON4cC8SQsVRHaezb/EkNQyMtosR3h4Vih71+I
         lU6w==
X-Gm-Message-State: APuU4Z+aOoxIK7HzyhPP2cb5mZOiOu6NA2ojmEaq24seswxFVuo7fm84
	HafUyeM9/VaFgbBQOB6IVWB2XZvOlxJSCP0Y3y26yOVHK2SThoAJ1Ek+EHhv3Wp6Jq2KJgaUOFd
	ySnvMASTfs+RFJIJClp/8kIdwI6LT6GIUceOxbtsnhtfguwy+ZxVOdyJuOSqQZl9zLJQWZXj4Nd
	kdABMf6VNRuCtUUHh9m+NSvlnP/hCay785BFgYSXMm+6pt1GH92wScX182S8W8aWt9jCY7afoLX
	WK7vgX6rjmXVHVV
X-Gm-Gg: AYBFou1iFYamAILZc77rtGy5ogl67eTMEuPJ7F+X5iziU6bnfVVm66llYVut9ITl76U
	Q2fRHp5oTnRxsFcRfMiBGrM+FNzKn+fomXepgNrSP1RE6Cip8NEn7I9WFZYywFpP7HBM53Ql5Vq
	H3rfgRDHlu++DJX1cpFOnIdBZTK23FOGpzfPNFdlOD5AXtQfqsEGsAOSAMtK+IycmC62zqoEvq+
	kxad6/msHmHjEZWBItmWMdejqYbhioFqQGUpc3c4bqKjTwo6wP6GqRPxLQg38bk5qgWMPCllCY5
	g1SNLspN4ZhSOME/XNrF1xpbgiehCI3JASKlf/2stkSVBnomUR0zsp4xlVz0P4d43cIMHszaSEd
	uwQKuENwX8+un9Th6Z8nnBOqpxCy0901MYDIDGJmND1idtJbpmSeL0EhFlmnozjKw7X/8EFb5Pn
	hdAKhSZSLUBl/6g26hjMrs74KrFzEvSdqaqbKTSd+Q
X-Received: by 2002:a05:6102:1487:b0:7cc:2152:4f79 with SMTP id ada2fe7eead31-7d301bce41cmr466414137.16.1794282634360;
        Mon, 09 Nov 2026 19:50:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99c20381329sm83284241.5.2026.11.09.19.50.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91e987a4099so34925566d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282633; x=1794887433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1nWwBgmaBdULC/P07cKbjOH87XcJJ51z/HTXJDp+iE=;
        b=Qd/KyMiWfVl9rs0UdvjuF98skgddg49fwJEgt3PjKssx+Ic38yqf1AmbtO71H9C0mR
         lPn6dVT3brha8zLJcrSFM7chVsL+pou66pi6aKeIBpIetjeNmKfe09mL0LZ8Q94SbHRO
         pEls+zytdnfPJ7knL/W0/dWKdz2HsPSibZ2Ng=
X-Received: by 2002:ac8:5fce:0:b0:54f:71de:8d2e with SMTP id d75a77b69052e-5552722e6demr24037191cf.23.1794282632848;
        Mon, 09 Nov 2026 19:50:32 -0800 (PST)
X-Received: by 2002:ac8:5fce:0:b0:54f:71de:8d2e with SMTP id d75a77b69052e-5552722e6demr24036911cf.23.1794282632269;
        Mon, 09 Nov 2026 19:50:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:30 -0800 (PST)
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
Subject: [PATCH net v4 3/8] net: dsa: b53: clear stale state when creating an ARL entry
Date: Mon,  9 Nov 2026 19:50:13 -0800
Message-ID: <20261110035018.2169370-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
References: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
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

