Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.126.200.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777784;
	b=feY6iFB0eCzK0R0ei9z5NkciG5hkFbwpNGRTs3ufNclBA1Ws1R0yhHlOVVHVAdfPWLpS
	 2f4zzcgaGiyA1zAcnF7zc/Ag9zVxPxd2x1WE6f2QT3HpFk80M3xfP7YenzR5JW4JdB0q1
	 kvRa7/M2OKQZOmF2o4nS/dtL+eoi8Z6CBSwmmkNSV18P/db7uEbYXo2L/YoNU2y4Inu2D
	 cpZ1up76/ct02VzaGSc3/9qpOuybF5RlHIyD/Qpznnh29+iNO+LsYqrzctIut0A8rZDq9
	 M5Q0YjnCpILiunI6o+iikJl7OB+wM5Nz8AzaHs1jLy6rY8h9akHyum2rs8GH20aMG6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777784;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender;
	bh=piawIPJSSl/F907OEGJSt7FanPvuAFriXN0VKuHIOSI=;
	b=hhNc0lCscypChSgx0A2ZBXuavQgtyKrXzpwcly79Sn/l2TpkytprolWoTaRFKhkcjPD0
	 k62pkYqxQ+uvO5vgG/WJV6T2no2Lw70M29VN4whjraHGkR71x6UIGgAx3qQUXvtWxJn0l
	 TjIzH3K624eol2ReBDs2hJ5ydolO0luW5knLkOiaftGSHmOYlazcVoNqGWtIovkkqxsEm
	 7JCAGixjZUeZMSKh+a31zINz7Zpn9wneUf1esGgPCUSCQtkEmqTNyOXFejmV2Bw+XFgUW
	 SOaxLyw4HQEYfF66hc0jBrIjmhMMmVAFnjRO1T3DDSuEPp5TE+CARfyBXAIrNcLxTNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=davidmestre.net;
	spf=pass smtp.mailfrom=davidmestre.net;
	dkim=pass header.d=davidmestre.net header.i=@davidmestre.net header.a=rsa-sha256 header.s=default header.b=qSQdTNgm;
	arc=none smtp.remote-ip=194.126.200.66
Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227B606A32A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 17:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E227B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidmestre.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidmestre.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=davidmestre.net header.i=@davidmestre.net header.a=rsa-sha256 header.s=default header.b=qSQdTNgm
Received: from s143.cyon.net ([149.126.4.152])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <dev@davidmestre.net>)
	id 1xKJOX-00CsvH-2C
	for netdev@vger.kernel.org;
	Fri, 23 Oct 2026 19:49:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=davidmestre.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description; bh=piawIPJSSl/F907OEGJSt7FanPvuAFriXN0VKuHIOSI=; b=qSQdT
	NgmRxXQKzwqGWdA1AdSk8I7n0neuU+TaMLXdOCrjtxyDJ9g7V9LOpIqSH6tI3vUrorZNWXKFgf1+/
	EuJIi3mjMRJsD138YqHPkUookEFr0FYHK9AFhK6ZLpDRMApdSbrVNzWB8chb7OcJ2xBfGQFq4WaDP
	UI6RKHeKCFghpQYGd84Jll5w7kj7DizGpNwldoy5hLPJOMakx/z7R69E2TEwIuxK0eT+dsxXHiYiG
	pLdfeLOJiYbujZKNbc1VPo5g6jflmCPJtZFC6dWn0omlMzLVLrrt4mkvbGykmNAxV1NgyPuzkyO5a
	P/dAAEJZHjAwKGI4auhCkzNdcVy5w==;
Received: from [10.20.10.54] (port=45134 helo=mail.cyon.ch)
	by s143.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <dev@davidmestre.net>)
	id 1xKJOU-00000000GFy-1M7h;
	Fri, 23 Oct 2026 19:49:28 +0200
Message-ID: <e0137c6e-7ecb-4b45-8108-70058f9906e1@davidmestre.net>
Date: Fri, 23 Oct 2026 19:49:29 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk
From: David Mestre <dev@davidmestre.net>
Subject: [RFC net-next] net: sfp: add quirk for OEM SFP-2.5G-T-C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s143.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - davidmestre.net
X-Get-Message-Sender-Via: s143.cyon.net: authenticated_id: dev@davidmestre.net
X-Authenticated-Sender: s143.cyon.net: dev@davidmestre.net

The OEM SFP-2.5G-T-C module needs the same fixed 2500BASE-X host link
as the existing OEM SFP-2.5G-T entry. On a ZBT Z8803BE (MT7988),
the module has no carrier with in-band autonegotiation enabled.
Forcing 2500 Mbit/s, full duplex and autonegotiation off restores
the link.

The existing OEM SFP-2.5G-T entry requires an exact part-name match,
so it does not match the -C variant. Reuse its quirk for the exact
additional part name.

Signed-off-by: David Mestre <dev@davidmestre.net>
---
  drivers/net/phy/sfp.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 85e57a1..ef87687 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -631,6 +631,7 @@ static const struct sfp_quirk sfp_quirks[] = {
  
  	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
  	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-T-C", sfp_quirk_oem_2_5g),
  	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
  	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
  	SFP_QUIRK_S("OEM", "SFP-2.5G-LH03-B", sfp_quirk_2500basex),
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0.windows.1

