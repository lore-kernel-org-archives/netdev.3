Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6D3D16F4;
	Mon, 31 Aug 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180863; cv=none; b=a/0Y5GCm9YJCucmQy5v6lUJXqAyKeMNbAkczc4wuXbSfl0Wq5drp1FkGUe+AwJ6hM8cgkZdWLyzzOA8Bmf0SmCXQpvx1LKdHE3yZu1LEXJZ4S1sr3G7LcLlwuImhzP1y/2FW4ZIWG+cYIs1x97P8EyzSJZ74GtMDyAYWc5O9hxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180863; c=relaxed/simple;
	bh=Frt5Hh9KcskkhS/sRig0EMszAHCPkhQZVvXUPKdifTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OljQ90qCMP0Z8UP+DN39RiTG6M3uzSYkyyz8bZeppASqgIJuJqeL/LzGApkKk7XRz8kiR7RMPnctXeC9d/urq7h3JevmEmSsoVHKfd5JqL2m5jZ3uxkh/z0kkLE33NEwSQ+y/bjkhaNqE5lqZvUBLzUDuyXC060lwzM/O0VrRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=J6xI1nOT; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="J6xI1nOT"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93CD03EE1A;
	Mon, 31 Aug 2026 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788180853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ui9pyM10EMjrpfH3yKSVfnBzByOx8YuZ4Cx80FXpZ7U=;
	b=J6xI1nOT18AOm1ABiYijiOpMs5cbgMPSo9MJTnboVJ/6mDMqBtgjE2QLGyqPpcNXyFiqPQ
	VwFKJnAbQOk8l/f+PfnDyUT2j0buG49OrK8OhL3OXMkM7D1PHstzPRjDrtTY74vRjg/zRZ
	T24HgP/SQE6HO5R9PuKG0m5ONnP5tnVr2/efISyOUKfF7EllHLmVWV8PGbjG4CnlHifUoM
	cOGH8YThRdHMud6MHy1bQjr0UeZ7/dd2HAC9JXaAlwnnkxNoOYf+3to/xQbgvqrNfxcIrz
	PNKRU1jXXq0sOQGPcxUBjyHV3jd3ak8+RjXpyHUZp/HwxZXTz9CbrT0TxiBpAA==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Subject: [PATCH net-next v6 0/3] w5100: restore GPIO-based link detection
Date: Mon, 31 Aug 2026 14:53:33 +0200
Message-Id: <20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE15lWoC/4XPy27DIBAF0F+JWJeIx4BJVvmPqAvMI6FtcATET
 Rv534PdjVVRdTmaO+dqHii7FFxG+80DJTeGHIZYB/myQeas48nhYOuMGGGSKAL4M3xHV/BHiO/
 4dA0D7nbSc2ksBb9D9eyanA/3hTyiORrdvaDXn02+9W/OlFmcs+eQy5C+lvaRLhd/F40UU9xLJ
 r0F3xnTHy46XYZSbnlbk0vFyP5DGCaY99QSozriuWghfI3IBsIrIjizoClwRZoIrBBKGwhUBKz
 wndVKCa1aiFgjvIGIimhTX5WeAVD+G5mm6Qksvs9y5AEAAA==
X-Change-ID: 20260804-wiznet-link-gpio-796f36cd14f9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTGTUgi1PISssyDWY+4F0AtFxb9cmuOSlXTnpb+JjP8icTA4ThsxKCQemnU9dGR5aqaDX5xeqkVGIjZQJwsTEXejsq3mwDGM7/BPYtY2h4o0UkGMTQ9o/PA+AErYDmyIBEVM6NrGyb1iTVfqIER+f+l/8lYGojbirJ7oLK0/CtzMfhVkyTpea80TL0Mu3RctnIgmRQEEEb/XO0xLeqCyHFSqbeGRtcKoRuovvvuQewBMeSVzECN9KeXVv5dLz+l6HUtn+2iceirAOo0fAqmG3IDdlvkHAhQW7NCuxWGoGim+twX5LO1tNoyIHzBEGdfxdGHuPj0bcdZW26RJ3Rw7qKNjHRblbHsqIOmMG4i/fu25NdMDqD5G03JiUAB2S9tXW4D91txhcshQo9YOBXBOrtYnMk3W92/Azo8mY1eL12Re7FX1LH9fcoh+kFTeTVI1Dhop0ZqNVZ6qR7FjeRSCb/g0daeMVwrkB8LTPvbSevwFvJRH5NoZ4L8pPmjakaRKE3uMj/AKHYPIpnmgz4xK0fTsGx4POV+iTq2FDSUMb21k9RUEoQwb9suGZaOjhyXnEPhjnPzXes+AVNXVLnamZ0+9796uFvecivJ1+E94Hjtj88CBecSlA2ZwQn2Zfy5vrJUEVrcWl6OaHglIdd244dVmbdA5xa1BBtrIYY0OB2F2oA
X-GND-State: clean

Hi,

In the previous version of the w5100 driver, the LINKLED pin could be
wired to a GPIO to detect the link status changes via an interrupt.
This only works on w5500 as it is the only one documenting its LINKLED
pin to hold the link status (on w5100 the LINKLED pin is changing with
RX/TX activity).

This series of patches is bringing back the link status detection on
w5500 using the Link Status bit of the PHY Configuration Register.
Additionally, the LINKLED pin can also be wired to detect link status
changes and read the register in the interrupt handler.

Arthur Crepin Leblond

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
- Link to v5: https://patch.msgid.link/20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net
- Link to v4: https://patch.msgid.link/20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net
- Link to v3: https://patch.msgid.link/20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net
- Link to v2: https://patch.msgid.link/20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net
- Link to v1: https://patch.msgid.link/20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net
---
Arthur Crepin Leblond (3):
      dt-bindings: net: wiznet,w5100: convert to DT schema
      dt-bindings: net: wiznet,w5100: add link status interrupt
      w5100: detect carrier state using link status bit and optional interrupt

 .../devicetree/bindings/net/wiznet,w5100.yaml      |  71 ++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ---------
 drivers/net/ethernet/wiznet/w5100.c                | 119 +++++++++++++++++++--
 3 files changed, 179 insertions(+), 61 deletions(-)

