Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952A51C33F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081487; cv=none; b=fvT/Jk/WBWHKZhdOBH77pu50EWYD1WWC8Lb1uIuv0sP5pZqnKpFsgTL5L66VMraebqvURjGhDYCsN8qFaEVmrBjlnP1EZI1vE+plXI/d7/23PRqetNThaC63iqJDiDHURdC5JptBxW3Qu1DD9mz+Uf/HmAygxwGzMZIAcsQnoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081487; c=relaxed/simple;
	bh=1kHbxrDHDoV9Gp60u40KYuFmL3SJ83etztT12QoTrqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQYbpF8AlfZa6WWLl2H0OkxOtV0QRyY1U46+pLQQ6lovY8/mahvUvdeDXIHd6wYBYGuk+moR4XhG6ZJo5erf8y6Fcnr9jIyi3cl+ScOEXv5dBRAIJ24Ti8XrCidNXjPYC4OHUQP40FWwsvVHR/C8ntW+BMosKWT+2X0/GFQ0iM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rmIJxAwj; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rmIJxAwj"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so4848212a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790081484; x=1790686284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeLYcx3Gh4T3X/EaL6eH6T1aKZ2rWDMD/NMdqi5KPPc=;
        b=rmIJxAwjZbp1FAQiAxMMdS6POa26n7tjmKVGS6jEHw+edXVF1sHmvTKH5o6s4m69Oi
         FdI87YhpON3WtCu1V56tgBnSBsKUTDKjcdQQ1jZcoqHg4CAPBH4re0TfxjYk095zKz0s
         6xbVVZibE68eirahXlTpNNgQ+fs/QGfNCZeHk8M3BNcX0Bhu3iDp8SX8SMHMuZ262y0p
         amHcdh3iNf/g2nHXujRvgdf8E8+UNic55WTOtNamTRe0dcvG1UCxYoE4GR1jIu6ceq+V
         gahzkfqB5SFfrKmzUvZtp7dhofe7E15ksp7BRXtOKFMD92XFfxZPjRDM1ZVzyjn9Han7
         rE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081484; x=1790686284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeLYcx3Gh4T3X/EaL6eH6T1aKZ2rWDMD/NMdqi5KPPc=;
        b=lc765FHzka4vcK0VaNIjIAzYKVaFdd0iOxFznKo3Nru01eHtyHJgLxjcaqqSsc4d5+
         k4yvgiiXdHW8rDNhdkbiYKkAzdnwDRLQjtUpH9mXqOy10WQjxiH22Dr8ao2nboh5xUc2
         BEXYJ042sW4WhSkMHcRqvDQQvFpqrsEF3nBYNzSTX5quAz4JNX7kryJIY+jX6i2lXDO0
         c/HaNUplNnYhRKGe/KX6R0tit5yz5lLeJEdb1haD6OIy80ZGdgmJj7PsOBPArxT9OW3W
         xS253p3P51MBvaQHsxrCLedCBYRh7Nw5pltYcJbc9XaH6wfn1fppGlA+YEOjRLv176g5
         55xQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOjIwJ/kHe9Qez6FW/wZW9eHXce1RyoJhYzmrmZmvI1RLhVFFuMDh4Kfgxmb05om3Paa/JJ+0=@vger.kernel.org
X-Gm-Message-State: AFuF++layqwoyNPj2wgb9zT/p0JoXOe0RJLc2O0RAIWNCO2Nacn39xZ6
	+rOwhK1RUE6sbQ9lkIUc3cFMftitEF/8Hg8FGIvjDcX2IcfP+81MHwx644qmH57rd2w=
X-Gm-Gg: AYBFou3U0Qj+ams5ZPuaF4h3hKkYzR394SwqeEglXbEvHTVW6MYzQDSE5jdTRNtADss
	t7kRLXhNjaDmhy+bue7gI5dsH+wsTKyiRgS5HGLR56GPAjDcxjjGRRlPBCBlNcGgnsAGYbI00MS
	s4f2b645cFz/NcQYpULluWky2VNKYLYUMcMLDfmGLOeRsgLGk7uDrTq+msPbCi80zvUOvLK82QW
	urcypvpK+6NbPgaNCctKOqfnJYM/T/wX9vqlWaJyE7LIo9rjn0mXby27hyh6qL/uuoqHg7/G2jo
	jw1jscHHlt+2hU075R1e40x0CiMYqGO6pDcuFiPvtQxaMlTvrkZfYi7fZhFWshaOpoUTlXTp+Aj
	C15KhDCG11J33Oz+Jf8vE9hfMX/65H8DnqiW5Uvh/k0qmnKY5h+lo7iyJ0c8KJ/5b/PRbM2AcGW
	+y6F0dNg6O/sKghKkJLDd4IHYnW9IMgkOMq8OdvLvXTk7i3jIQ0zv9L/6Wx3O5wsv6CZ3/TS4s1
	LfGcOThsomMgO0Rig+Z6bAHqCevVXirSEm/iyu+kC9yOPCVvHnOgyFBALcR+3eldQhQEoMyIAU4
	NmmTLv2kQI/PViW6bMi0w7CIecetPtX8LDfa31w=
X-Received: by 2002:a05:6402:23cb:b0:6a9:a628:1402 with SMTP id 4fb4d7f45d1cf-6aa545f2154mr9706503a12.6.1790081483728;
        Tue, 22 Sep 2026 05:51:23 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-14-163.xnet.hr. [88.207.14.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa44d1aa9sm989196a12.10.2026.09.22.05.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:51:23 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: lan969x: correct RGMII port mapping index
Date: Tue, 22 Sep 2026 14:50:37 +0200
Message-ID: <20260922125112.2111256-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the lan969x_port_dev_mapping does not check for RGMII ports
and just returns the physical port index.

However, this does not work for RGMII ports as they have dedicated DEVRGMII
register space with an dedicated instance per RGMII port.

So, check if requested port index is an RGMII port and return the correct
DEVRGMII index.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index f3a9c71bea36a..bf5320c7a6ca8 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -142,6 +142,15 @@ static u32 lan969x_get_dev_mode_bit(struct sparx5 *sparx5, int port)
 
 static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int port)
 {
+	if (lan969x_port_is_rgmii(port)) {
+		switch (port) {
+		case 28:
+			return 0;
+		case 29:
+			return 1;
+		}
+	}
+
 	if (lan969x_port_is_5g(port)) {
 		switch (port) {
 		case 9:
-- 
2.55.0

