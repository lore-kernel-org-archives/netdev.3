Received: from a9-25.smtp-out.amazonses.com (a9-25.smtp-out.amazonses.com [54.240.9.25])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420D3B19A9;
	Wed, 10 Jun 2026 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080886; cv=none; b=rSBi5As1gDnv7quz71g3KuSCIKJwOGqhOG11+si3r2O2uaqASmAg4XJcrZihlB8SoaVe80qAlB7cJ6b2rBCRnIN+DUhjS5DEI3fT6UEhKZ5SivSSL2hFhTUrDspzyOm77QkouTBQE0lh6RqjknRghFThLpubQxG6rChlvbZuXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080886; c=relaxed/simple;
	bh=mK3nrvsi7feMTvtPODs1gZ8VpHN+s4738hCZ/Exe8P4=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=OTmEC/UsFf5s0CNeIM1fqrCZquC9wbpYi/WKuMu63mVPg7lqyoaQXhpSsmESs1OHVHuYtuLJ2gsbwdLRDdBE0w86vCmChNvfsDj926pufhJyG9UFFffrMax6vPen6dUqMcij1/4XFVKs74zHnOwZWKck7hRD5tHAemNpwiZkcpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=SSJw5Z6H; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YMn8znt/; arc=none smtp.client-ip=54.240.9.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="SSJw5Z6H";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YMn8znt/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781080884;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=mK3nrvsi7feMTvtPODs1gZ8VpHN+s4738hCZ/Exe8P4=;
	b=SSJw5Z6HIUL7WSqB6dxqpSTUn1fqiAB5qw+9p92699OQE9XcdKn3YQcRauYw2vZX
	hL7wOu7rfNBYhUxMxr5L5HHG/STPpvgM9FyCmA+61GYoZyaro+du1GcvKEl1rtonHBn
	oqkdAwwNRM/VtdBRz7RLCGRsyAxfzNgL2n6MsXjE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781080884;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=mK3nrvsi7feMTvtPODs1gZ8VpHN+s4738hCZ/Exe8P4=;
	b=YMn8znt/4EGarH9it/GIluPOqnrfFxW8DHxt3R4ddx2xd7YSR/eR3tOcJE97Khrg
	ocP4MtPh+7uRf1EIpqRR0QeUMuPr2BZuveXsXOmHprPV9wpPBdjw8hxYyyittOoPOXe
	x2vUzTkzFbiN/lS/WXomFw1bcp96vSMbwpxjXUYw=
X-Mailer: git-send-email 2.54.0
From: Johan Alvarado <contact@c127.dev>
To: netdev@vger.kernel.org
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, contact@c127.dev
Subject: [PATCH net-next v2 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
Message-ID: <0100019eb0b1822e-ffc5626c-1b9f-4c8a-8a1a-759a9e665f4f-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Jun 2026 08:41:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.10-54.240.9.25

The RTL8367S is a 5+2 port switch from the same family as the
RTL8365MB-VC already supported by this driver. Its chip info table
entry declares SGMII and HSGMII on external interface 1, but the
driver so far only implements RGMII, leaving boards that wire the
switch to the CPU over the SerDes without a working CPU port.

This series implements both modes. The configuration sequence and the
SerDes tuning parameters are derived from the GPL-licensed Realtek
rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
drop. The SerDes bring-up requires firmware running on the switch's
embedded DW8051 microcontroller; the firmware blob from the vendor
driver will be submitted to linux-firmware separately as
realtek/rtl8367s-sgmii.bin, and is loaded via the firmware API.

Patch 1 adds the SerDes indirect access helpers, the DW8051 firmware
loading and SGMII (1 Gbps) support. Patch 2 extends this to HSGMII
(2.5 Gbps), which phylink represents as 2500base-x.

Tested on a Mercusys MR80X v2.20 (RTL8367S connected to the SoC via
the SerDes), in both SGMII and HSGMII modes, with a fixed-link device
tree description.

v2: no code changes. Resending the entire series because the SMTP
provider used for v1 corrupted the mails and patch 1/2 never reached
the list, leaving an incomplete series. Apologies for the noise.

Johan Alvarado (2):
  net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
  net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S

 drivers/net/dsa/realtek/rtl8365mb.c | 394 +++++++++++++++++++++++++++-
 1 file changed, 390 insertions(+), 4 deletions(-)

-- 
2.54.0

