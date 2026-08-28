Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E603E49DD
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907392; cv=none; b=BQBKzYaBFCNZOJF9hWsARqvfETivMtKAb1kBCMstmWUogBa0Msmd+GFGDolKDGDwUFn2gZEcoz+FQfLtyy1cZNCgiCRxao/QVhMnTjD7m79SuGO6KH2IXQeRAvS1F1X42gZu2Necu2RdFvSPhi+OM2HM2nq/Pfi/yPrwwP7FBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907392; c=relaxed/simple;
	bh=A2hgjeOh3c/LljnQd3v6NScIdJwHbE8OvR2D3bwTWao=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=CLpTCF1CJlZK4ABu/+onp0bVrttByeAmX+Jnn6klQrwbpN+HPA3LpxEmkNeDQ08zjS6n2Vi0MOTEaEPJLhPnP4qv8J3+Tkfl0IGn8pRk6ylD+W2maAl3SK4PShMS51dmsWgfTlzVpYxFHiEjhjyLYT28D+DINrkGriTIEER7mEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITy7Nviy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITy7Nviy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e7109321dso659623a91.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787907389; x=1788512189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CqYKtog+RGx4sBEIIa/0emlDuhYnBDf992c5lgKQL8=;
        b=ITy7Nviy8nXApuS4UGhKOAQzDv80qj2lezHACB1apdM8n/H+Z5fVeXvKJCApfMshi5
         gIAHe9OP4o5Ce/tkh1dj0D+OfSnz7fAwEBEHG4BUWMT2K6gNNq3+o6nckF/YEPj4VPcI
         ALbp4KvuSvJLA7RvPlLMF9WUcXWsdi53HUnsFvpIZ+9AdRDCh4HD+ZWW8yj3oyv+Nv5Z
         i5NivooRmKfUwl8fokdzHYp5l/0J4cW8nv7XwWdZzmuR5Sk0oFHDiiHnhWOM/Z4ZjaGM
         5sUwNbj+1MDHRXseOjiIjxTQ71ZgMQBckyFV8d5l+H6tkMjeF0rEWBM9y+n4dJj5A2Kq
         dljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907389; x=1788512189;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9CqYKtog+RGx4sBEIIa/0emlDuhYnBDf992c5lgKQL8=;
        b=qC8V9G7OLXjbanKbycWWaFsASG+znUY/EnnBie3S0XOWDgiFrDwoG9sY5PB5NMWyDl
         F16wckffLHwyDxw8uOYiMe4fs+kWpAmhgbos2lybgCzWzfBwjNcQz80EC47MAMNHeR1a
         9eej8gEdr/MxRGqic3ghkZ7bAS2b4U/0Ui+QtRqLva1Ve81Rt/m/suSRYJRKB3wJm3B5
         IAG0oXwif6l3szW9hXEo9PrQnYBpyxDPRILueaGGdsZfcUM2+K6dQ4wly7SW5SK/wUcq
         9dN6Ok4PD1WsV287HVVjlNaAN8QHZ1ILo5nQRORdgtWvItupGunlfP4U2S9CAqV0N5vb
         xXyw==
X-Gm-Message-State: AFuF++ncLyx7tmHJoZv9naf9bpj2l7cVY9a428pZnG6G5s0BCWP7dBsm
	JLP2pscS+p+WFEreW6bw45rmCWlw/CL9vl92a3Cwgrv4t39bzD1yI2J5
X-Gm-Gg: AR+sD11R+3qub6Mgtba+fSv/Q7fD+hW/41fdCRHtRpvwsaMCZiioZ9RJWgJeq2FtH9U
	MnDoYzOBUEWXSoOTMmu42IMlAcxHCL/4jKlFZhtyGoVpJi25EZ9jFEkrNTe1Ty22MrmOHSCOQt9
	5W4iZaNLdISjsj8UVT/qarSZy+Q6SctPZLufUmYS5SsIErPY55f44nrEDqy/MOdOk9lbuLfEnQG
	wNdV3Q7YOwdWWMWMK7mC7s1lCNOvmPnyVGDwb4uWuypNBubfh8XykIuk1GpLamtBiUK7msnI1ar
	ORBq/MYDCdOStbGZ8AmIMfawt4FJj0Yk3Ywp4/kKI1PWIavcsdq46o8nFygSdr9B7KPh0T6T+sh
	2RSe/j9uzFFM/Y+g3krOajsGuHzp0VmNZ/zuioMsjhXmSiKwXZt3Ar3Dby0XgKCXbJbAt/q329M
	gkqQypXPSg0lVFnShIc+AnTFJ/g6jIwkEVryKSrnADYcZYX9jIw2dqVtE4JuhchwkVTkWaLIIwc
	elgqgcF4LH50rDXVS2VwRzKT+agXQWtEasAH+ZHAteIfHawMmuNYF6sAg==
X-Received: by 2002:a17:90b:3c08:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-396d0f9ad1fmr11555024a91.15.1787907389017;
        Fri, 28 Aug 2026 01:56:29 -0700 (PDT)
Received: from manush ([2406:7400:94:7a79:ddde:713d:7785:c4a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm8407712c88.14.2026.08.28.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:56:28 -0700 (PDT)
Message-ID: <6a914d3c.018c0331.f1305.be74@mx.google.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch
Date: 28 Aug 2026 14:26:27 +0530
Subject: [PATCH v2] net: ethernet: ti: netcp_core: use
 for_each_available_child_of_node_scoped() in netcp_probe()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rework the interfaces loop in netcp_probe() around=0D=0Afor_each_=
available_child_of_node_scoped() instead of adding a manual=0D=0A=
of_node_put(child) at the probe_quit_interface error label, so th=
e=0D=0Areference on the current child node is released automatica=
lly on=0D=0Aevery exit path from the loop, including the early go=
to on a=0D=0Anetcp_create_interface() failure. child is never use=
d outside the=0D=0Aloop, so the now-unused outer child declaratio=
n is dropped along=0D=0Awith it; no extra of_node_get() is needed=
.=0D=0A=0D=0ASuggested-by: Andrew Lunn <andrew@lunn.ch>=0D=0ASign=
ed-off-by: Manush Prajwal <manushprajwal555@gmail.com>=0D=0A---=0D=0A=
v2: Rework around for_each_available_child_of_node_scoped() inste=
ad=0D=0A    of the manual of_node_put(child) from v1, per Andrew =
Lunn's=0D=0A    review.=0D=0A---=0D=0A drivers/net/ethernet/ti/ne=
tcp_core.c | 4 ++--=0D=0A 1 file changed, 2 insertions(+), 2 dele=
tions(-)=0D=0A=0D=0Adiff --git a/drivers/net/ethernet/ti/netcp_co=
re.c b/drivers/net/ethernet/ti/netcp_core.c=0D=0Aindex eb8fc2e..f=
bc011f 100644=0D=0A--- a/drivers/net/ethernet/ti/netcp_core.c=0D=0A=
+++ b/drivers/net/ethernet/ti/netcp_core.c=0D=0A@@ -2204,7 +2204,=
7 @@ static int netcp_probe(struct platform_device *pdev)=0D=0A {=
=0D=0A 	struct device_node *node =3D pdev->dev.of_node;=0D=0A 	st=
ruct netcp_intf *netcp_intf, *netcp_tmp;=0D=0A-	struct device_nod=
e *child, *interfaces;=0D=0A+	struct device_node *interfaces;=0D=0A=
 	struct netcp_device *netcp_device;=0D=0A 	struct device *dev =3D=
 &pdev->dev;=0D=0A 	struct netcp_module *module;=0D=0A@@ -2246,7 =
+2246,7 @@ static int netcp_probe(struct platform_device *pdev)=0D=0A=
 		goto probe_quit;=0D=0A 	}=0D=0A=0D=0A-	for_each_available_chil=
d_of_node(interfaces, child) {=0D=0A+	for_each_available_child_of=
_node_scoped(interfaces, child) {=0D=0A 		ret =3D netcp_create_in=
terface(netcp_device, child);=0D=0A 		if (ret) {=0D=0A 			dev_err=
(dev, "could not create interface(%pOFn)\n",=0D=0A--=0D=0A2.46.2.=
windows.1

