Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794070888;
	b=zsfla3JtwvKAdMd8h5HfVamP5zH5X9SLNuSLs/bAxjHW1onay5UbtGOOG6ZimjqjcJSn
	 6qfxTwISKFRk1i+/16ioDPwc9wx4cYXmWSd/Dv6O3kTD2kZtOaur+92DZKFepKcrOgCy3
	 FaKAM77T4dqWfzW/Diq3IBpBdYE160rwCUWG/Lnn/VEf+GQBu5iArPqu4Fp8UnXjyJxBN
	 vxG956fxNOwIDtiGMUVP94D3cFiZQuZHCxPN4+3/9xBO38IEHFRg/mAQN5g6G/W0Gxp34
	 5zoC66LCrl1CYBaXL0GA2/9NjysaBwAjzC/tfbumGjYmy2QBgMMVOIPqnkyK+g9vOxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070888;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=lt4Dg/h02QMbLaK+eVEgXLfNXEwHpnTkDXewtKz3yQA=;
	b=GFMaBCxdGBrNxzK/Ch6W3Kzy7iF6hBsN1pTvvAYOKsz+zdqHR4KWHrBuh/xPMgdmTIKl
	 TFi1C0JHuU6JtydM01eh10DI+IK+5qKlaV0hkR6Z0Xjb8hlUg+TjsBtRTGyzOh0BivPNi
	 fRcNAKe9qJkZ4+/VA7GgxKnuYSgBpe9odunziF8YdbUtNyqv4isUgvhkoMu7OTef1A3Mn
	 fTWXSNC6aAJDQcWSZ2n8o4LH1f4Gna06UsyH0ugzToC/yHkmhuOV3JEd9OStKY/+hV2Ce
	 4KkfZbmKxBq9RDu7y3clVTJodg6KegJWD8BDpPNMHF5HFbH1NwBLYSnl+AKmQGacEPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2l7CDF8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19D606A32C;
	Sat,  7 Nov 2026 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2l7CDF8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794070887;
	b=EjMXZ0LfU5rUq3UZkwI68toAwavZuY5sRMYfagR8Fylc7Gzt6q4pJEWbWMtEFzYpMaxV
	 rgroHwiRF5eXMHBCKed0Xe8Jf9YsqEEQJL88gnvIFRjriy2sfMuYWNC3bo+ZjTTMNbY5Y
	 37Tr75dt38Eugi9hubmxDnuuPecsZraHlZl2fPlbmSPAZrtwVSqgC94RRcudeuNibxVhz
	 LfWzorANUWGIc/Us5nnIYdDMRA/fMoosRFLisokkBeClFkepqgeLvQg/nut0MJIfIL4fh
	 waCHB4380tBW7RTigrRhdLdago1mxF3n5/oJWFU+G9woVkv308lx7/yFaK+ESYpxDMg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794070887;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=lt4Dg/h02QMbLaK+eVEgXLfNXEwHpnTkDXewtKz3yQA=;
	b=b9xzuLJ6aWiuNhlZYJkKkhNB0SrtxscyqbvazdXx4lDswMRxI06bgt4hA5Wu9d6eWgHv
	 jdFk/npCDvne17YDJz2uMoQAvr/WF36MqXnFC+YkMEpuM6Igj/uptFoI8KZHieUl2oTMN
	 q9YgaaZ+KSFam89Icp1v6tMSdDlWmtpD15iEqcHegqZmAmX2g2+0sJ/fdQKhooDcbpo5x
	 GgYqGf39yf+fD/PbSNRbQO5HMoQCdrb3u2xwWrJukpM1ARwXIZ2N+lPLgOrOCqxrYVWPd
	 CAKTp4+BK6O7mI/+K43ynn2yT+LNLgyFUu1oaD9LgzYfdUkgp+XJt9DkEcOYbzfQvqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1ECD31F008A2;
	Sat,  7 Nov 2026 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070887;
	bh=lt4Dg/h02QMbLaK+eVEgXLfNXEwHpnTkDXewtKz3yQA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Y2l7CDF8sqvjZqJbkW8fFFY2MaBZik0TEOYcFkkohU2QkQXgWvfCP/Srz1qW4ETbC
	 vwSTGLFUMOxXRdu5eRBy93n3nFYeyHN2BgbP04PTgjLqW1nwgMBIatu0c/dDkghka4
	 Mdko8mTVkcq/xwEJHspNGGuxgBeGUkFA5qbDG1dRUIfhn31ROjAnIj8fJ38agOPAle
	 1Y8j2ZeRVZDyjb+P0cIlHQqcKdImKtUy+48dqFZgOo7YNcUDWYcM+h8ckFfe1vqbgL
	 yxyB37cYPsVszAA20YAy3bU2QepqTTtgnqNvwCvuugSVPn5487P2na0N6uSKPnH9DI
	 S2tLhiuAdeJOg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6FAD447C89;
	Sat,  7 Nov 2026 17:01:26 +0000 (UTC)
From: Hleb Shauchenka via B4 Relay <devnull+me.marleb.org@kernel.org>
Subject: [PATCH net-next v2 0/3] net: phy: realtek: register hwmon thermal
 zones
Date: Sat, 07 Nov 2026 18:00:44 +0100
Message-Id: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOTQ6CMBCFr2Jm7agtUcSV9zAs2jrCqLRmWhEl3
 F3Atcv39+X1EEmYIhwWPQi1HDn4UejlAlxtfEXI51GD3uidUpsMhcw90Q3rVxM8pg8WW53lptD
 KXgoYZw+hC3cz8gSeEnrqEpS/JD7tlVyaiFPXmkhoxXhXT1YQrtivG8N+SmuOKch7/taqmff/R
 qtQIe1ynevMbffOHhsjd7KrIBWUwzB8AWPgrAnrAAAA
X-Change-ID: 20261103-realtek-hwmon-tz-95237a921bf9
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hleb Shauchenka <me@marleb.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=me@marleb.org;
 h=from:subject:message-id;
 bh=jAz7L+bhgd/IVWN5dn7Smhib0FoZG3Ky40jagdvleSc=;
 b=owJ4nJvAy8zAJTZJnM368y8lXsbTakkMWe8jU3kmRdpLp007m2Ck1bXiqMS8m4L/ThcZqO2pn
 qXpdG3NVcuOUhYGMS4GWTFFlk3NRaJPV0a/da3ekwUzh5UJZAgDF6cATORrC8M/zeSla5JvOp/d
 ovrp5t0Psl9uTAi5u/Xj6/Ld/Mln/+k5fmdkmOM5heWJuyPjJY6V39Xmy6UtC3Oek3fqYJPO7Ow
 7K3mtuQCvbEpo
X-Developer-Key: i=me@marleb.org; a=openpgp;
 fpr=B2837215E5A95BED457BBC6A9217063BF3FA220D
X-Endpoint-Received: by B4 Relay for me@marleb.org/default with
 auth_id=1394
X-Original-From: Hleb Shauchenka <me@marleb.org>
Reply-To: me@marleb.org

Let device-tree thermal zones use the temperature sensor of Realtek
PHYs. Patch 1 allows #thermal-sensor-cells in PHY nodes, patch 2 stops
failed MDIO reads from being reported as temperatures, and patch 3
registers the sensor with the thermal framework.

This series was prepared with AI assistance; each patch says how.

---
Changes in v2:
- Add #thermal-sensor-cells to the ethernet-phy binding (patch 1).
- Return MDIO read errors from the hwmon read (patch 2).
- Patch 3: name the mainline PHYs it affects and say that the RTL8261N
  test relied on OpenWrt's out-of-tree support. Code unchanged, so I
  kept Andrew's Reviewed-by.
- Link to v1: https://patch.msgid.link/20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org

---
Hleb Shauchenka (3):
      dt-bindings: net: ethernet-phy: add property #thermal-sensor-cells
      net: phy: realtek: return MDIO read errors from hwmon
      net: phy: realtek: register hwmon thermal zones

 Documentation/devicetree/bindings/net/ethernet-phy.yaml |  6 ++++++
 drivers/net/phy/realtek/realtek_hwmon.c                 | 13 +++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)
---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261103-realtek-hwmon-tz-95237a921bf9

Best regards,
--  
Hleb Shauchenka <me@marleb.org>


