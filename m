Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589173;
	b=ssr4PFuNfY69QyjFfNvUYnwkcJldNzoUsviMNmJUsTF3MUe/MpT7jzm0buVdrrHbl6/X
	 IEL3lONkBJErwkIBDQ9xhbvLXbBVXxtd0Y/fKaIgaS3l1gEedjOAdwMsUvT3OqSLBNu/b
	 1c/7iq/3RVkmq1EtouQTpGVFQycrqU0AA0HyQXu+p+AgzfmfEg2i7Q0btZ+Pu+1Xsl2Fe
	 x/xQI7hPgl2tS2w8YmyxsU6/FJIzJPGqbL8VAteLi5uhybja/E85FQ1jtVI223zgFrRz4
	 vbFNkv6Y7fC1JFfehRyTF3mVX7kFFiZea8QRJoe6GAqYOqM8YqhR2d2NlCYxypZBBzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589173;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U8Zgap9n9exkhoIyI7R2rZH5S9LLBlFPRSVvfmp1tjc=;
	b=up34Yq+Lz7mebLQCNYdx3ijucSNuLmynPtSSp4S04hTWlhnmKlRl3DlSsmAnCSyO0+eU
	 5n64ITEdovUxdW1EzDFBpDL738CUFx19FpvpvAUr/kaU81fZkxBuFEaze/k2zMrcsFMn5
	 z1T+r66C+HddoHYGySUQcenMc38nkCpWWhu/ZHOzpxMrH1QRtx3z++eMho0xfrdtAEBCP
	 M8MYHa46YN5HR9benW5OXfQUhyg4msgOiNoHh4z/e1bJnlQ2Yr7+0SZaI5j3Sm9YFx2ve
	 MbtMZiKOIDKVX0MphT9ZPppJQAYwGrZitrF4yLRx0jSpTYUC8ztpNkCvPgaqsyOvGhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jc4HAclq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA860A2625;
	Fri, 13 Nov 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jc4HAclq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589173;
	b=sPA3gWg63iYOx2Jtr+Ov6s1oKEp/iXkyLNSXNH3FQVwfSLhpiidEKrfvTJZ1kcFDook5
	 ihaneEm9Ita55YUWEgL/5HfD3wwkyoaTwcxHMzx29g7lq1HBj5XOV2Wuw7c84CUNey4Uh
	 QmUXRrwttfYR28xn9n9ysJxGpDLMiPtWClmQYHEDzj92aShW9csmoc0bE4pM946xQvmhS
	 vM+JDDviXLmilW9t5vVCx+QfyUdmxpS8iAtoXGThxvEDSns5Jadt58RoO6s+qAo9FDE6N
	 KmiR0whkcqs19rDVRxKVMDrrBHiTHbu4FA11DeU9MBf6eaqLbzoDK9vNm+s8YI69WxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589173;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U8Zgap9n9exkhoIyI7R2rZH5S9LLBlFPRSVvfmp1tjc=;
	b=2dALE/WrfszdXWYyw3/O81JrSV0L0kLU3doL/Tmw+JR1rHxRLIvglfAAO2vA5TyhX3BG
	 vG6KSRj1Pp0b3K82IwG0OeoGABFugS3tj5Aec74TKipetL5yJIn11lRsG4nkhe2bssrZf
	 Jue/g1mY5XJYQ+Rexgk1frCPOaqDE9ROjkiaAgGhMzUL6w8Va/dN1UXRdjHVQiX6jiCso
	 VR5y4Xk54EEckcL0l/PLNbBOSdQkt50vE1+O6xOZ2oDQqQvA4B+SmdyfQeVlFMJVpyIIu
	 1XHDwRxW1dok06WFCUyZJX5l1Lyig4NuGT0ipdZrp/BgaizMdu0Ty5VKWvjqkYpDa6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D8CED1F000CD;
	Fri, 13 Nov 2026 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589173;
	bh=U8Zgap9n9exkhoIyI7R2rZH5S9LLBlFPRSVvfmp1tjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Jc4HAclqOaX81p5yMCB7uN1LOf1BmwpaodkBjhdbqQQMBTYrEsKsE0lzSzeuOEUnz
	 sd+Ndnw5BJj/Sm4NNrRm4ZfF5KS49xdmygvdcK3D5IfRrMHYCie1Iy+FneNwCtu1Ts
	 8NTi3SfUOUacbInzQ1yjehMKcrxvXb4lZd8LaOsrirdR9ZDBXbvRaRuwWI9JzqqHMl
	 GFUpuRys6yCcHWLxshKg7+i8g3Sdi1/ZN91JFqpi3bSasWhFUNRWk3Rq0TcTmVRw9x
	 j0eXrzeYUv6rFEW++w+0wZFTH2wPmepRm4YmJWr1tuZJI68adjlN+xtCpB59mLtz1U
	 kgSFPjXcof2XA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E5D949A23;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:25 -0800
Subject: [PATCH net-next v11 06/14] net: ethernet: adi: adin1140: Depends
 on PTP_1588_CLOCK_OPTIONAL
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
Message-Id: <20261113-s2500-mac-phy-support-v11-6-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=885;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=dJOynGT8LQS7gZHpVrO5NMdXlp4FfgcoOR3HZGXbf9w=;
 b=CNL6HGGXOBlo0G8aV2zul7ivTTECNWbhxMJSKwvNM4B1AmpUwAJT9UxhqyZ/mBol3jue1Qme9
 dcuxCiItFoeAjJgi1OrYgQUeJOdleqjv7acofS4/4j9AW3JOKrMdfQa
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add the PTP_1588_CLOCK_OPTIONAL dependency to ADIN1140. A following
patch makes OA_TC6 depend on it, but "select" ignores that, so
ADIN1140 built in with PTP_1588_CLOCK=m would link-fail on
ptp_clock_register().

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Moved the vendor changes into its own patch.
  - New patch in v11.
---
 drivers/net/ethernet/adi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
index bdb8ff7d15da..120a52e6b283 100644
--- a/drivers/net/ethernet/adi/Kconfig
+++ b/drivers/net/ethernet/adi/Kconfig
@@ -29,6 +29,7 @@ config ADIN1110
 config ADIN1140
 	tristate "Analog Devices ADIN1140 MAC-PHY"
 	depends on SPI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select ADIN1140_PHY
 	select OA_TC6
 	help

-- 
2.43.0


