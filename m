Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792440212;
	b=Z60BpvDofxoAmMMyML5xMX9sybcWuXqpQVAFx5eaSbSAOYx4ncq+s5g5M1jqyq+cVS0L
	 gHLL65UQDNbVN64bBFAmePoaLpzIxPRw1xDxstP8U1u+vlnEBdN6Asgt5jLB9r+xLfXTt
	 siENI+bGRhFkFblNb7fF96lwyheKjV6RXZAwvc+9WZaEbfK3rp/IzfTVjIJrPjug9HKgg
	 BphmGAkovQNPxOiKqzF51T/TDsx3d4LT10wfy0SPHH6LMgkya/LYRkR63WrWKX/73mpS7
	 IRlBILUZHPtTfqOT8kG0e3QHt4/+fQVFe+jj96FbIcIHCzCnU6I+aqtfvvW9vZt0xHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440212;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i8MNxol060O6EW3B3WyFVJdha1qRJwS9VM/FovGS3EM=;
	b=r+MmdR1kCwuMherM7bjFqmRrNHWex816bHYe5o030b+nlhXmfN0n3ilevsop3y75fKFF
	 09pY17fHhgsYLhC+9Ijr/M2gZ5EqrrF22n4Yzep1f3y7X65H+ai0jwi/uS0TpHx2Bk2+e
	 MbEMTDYEhLxxQBrX/x0zEU/dA1GitcRs3+WoyNkj9PmK4shmlMLiN6GA4imErK1xDIMsI
	 M9LjclXhxyMRJrkO//UhS1aG4WR8/geEOYtiVU+zDN4wQWLeYOiAeAKesx87DGpCol7eO
	 /MPgl5VUCRTwJyrg87JCXxy5gjUaFjz/OVZmRVwlVmCv3n1RfPhnHAqdTDx36+WqxQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8sWZu4l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4406606A31A;
	Mon, 19 Oct 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8sWZu4l
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792440211;
	b=buWFXOVBRqN52T5/OzeBqg+g9RUXkkS7WuxfQHL8VQV3emQf3PbKo9SnBPO5Kat0C5YQ
	 Wqvjjhv+SuMlVolAn1BEa0xRNvsarexGLH7FPwjd16JtIxoRUpY8gNfBDxQ48eFN2JTsb
	 N36tiQlSmBW1qwcnZVLp45NGlL4BO3Ll4W8EO2zduOXN4hWVJ68Usc83gJH8AKaR/FUYb
	 n/3YmDG6N3eHgStUYhqkTFYhaB3s/MRrMr+XxasoUMkwHSmlPaSGTuvFI9rEHdTyq3fGw
	 R3Y8w+zqEVnc6QRZbJcLjTC5s0P24EYPXKgaAZwrte/mzEwqM6M0AdC1Tsd3mqWWfOQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792440211;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i8MNxol060O6EW3B3WyFVJdha1qRJwS9VM/FovGS3EM=;
	b=0AzWiSbjbZEN3uI2S3WX48UH+50l7D1WNR76Uhoe5hLg00gR25ZGYu5zCWf24esDohIW
	 5Y9xMC7kH7U+0g6B65RT/Kn2p84y6EkwNEtuuGKTVuKw/0ymynK2/9vZYYuh0sipfmTbb
	 Fqri9TwfKuW/GA+ggF/06NOKBPr8I6NOnaT8LAlQFatI+j44+Qr+Ag6N/1mKGUQsQ/TOn
	 EujNbiPYPnOWMKinj4ybTjHXAChtrz7lTTGK3IA1EGjaVs7j2LOkDMsoCGFQxC4di/c2M
	 YoARsLekuF7lVJvL/CKwJ1hkr8lqAxank04w/xuoMaW5zIV/bSAkC+OfCR1UyPATV/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BF7BD1F000C4;
	Mon, 19 Oct 2026 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440211;
	bh=i8MNxol060O6EW3B3WyFVJdha1qRJwS9VM/FovGS3EM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=V8sWZu4lAwFcg6J5u7cVBbe+vuiGLEV77Q4tDgu1x30K93qo3uE0fuonzrZXuEX0G
	 kWDSAbNcgo5ZB63yItcJIz2jatqtAafBF/m8L8JEMHo1KUoanpClUr9Q8lPnJsMyFb
	 AN3vK8LqED85ZdJHmEOvMQypjqaCtb/ccHdl3k47U9vPUZ08+35zO8AmUUch4BoeIW
	 9XfVFjdhRJLy9i7Ld6wiGzQlivnyuBActp/sMcovPFIdDwZzJcLD0GZ+jRBFwSktOh
	 nvYRK8ox9I7yqswndWG6F9e8iqffFfhG8mnM3SV4SabC1mIb3WMAEe9ZyQgc2ShQD8
	 klp7eagakAofQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5018B400AB;
	Mon, 19 Oct 2026 20:03:30 +0000 (UTC)
From: Travis Howard via B4 Relay <devnull+thoward.lafayetteinstrument.com@kernel.org>
Date: Mon, 19 Oct 2026 20:03:10 +0000
Subject: [PATCH net] tg3: Add Datto SIRIS 5 1U Server to restart AER quirk
 table
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
Message-Id: <20261019-tg3-datto-aer-quirk-v1-1-f0eccfb2ab5d@lafayetteinstrument.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrB1IDEjtVUoXIfm1QyHqJEohe
 PcGl9/ivUoZKsj07CopTsmypgbbdxQ+Pi1gic00mGG0xk5cFsfRl7Kyh/J+iH7ZBvcwcJNDGKm
 Vm2KW3319UUKh93X9AT5jtKFqAAAA
X-Change-ID: 20261019-tg3-datto-aer-quirk-1c380e393ec6
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Travis Howard <thoward@lafayetteinstrument.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792440210; l=1864;
 i=thoward@lafayetteinstrument.com; s=20261019; h=from:subject:message-id;
 bh=FQAa09JcOMIFgEiW9Oki1Yij0dC7wNyid9KU2wn2HgE=;
 b=kwubS8wgB9x8wOWlt3wML8AyxENUtJiqe2UyVQnlXbOrY99ByBcGu4WttrdIZ+yg0sKqXNGYI
 VHordkMzvsNCM2L7ye3M719/4m6Svo+lIqNrBAuESWBWz8/CxWsqvcY
X-Developer-Key: i=thoward@lafayetteinstrument.com; a=ed25519;
 pk=rtL9URAe9ViV6WvIEtBEMb/2i9C1CKXa5RwTxC6I6Vw=
X-Endpoint-Received: by B4 Relay for
 thoward@lafayetteinstrument.com/20261019 with auth_id=1243
X-Original-From: Travis Howard <thoward@lafayetteinstrument.com>
Reply-To: thoward@lafayetteinstrument.com
Content-Transfer-Encoding: 7bit

From: Travis Howard <thoward@lafayetteinstrument.com>

The Datto SIRIS 5 1U Server is a Dell OEMR XL R640 (Dell's OEM-ready
variant of the PowerEdge R640) sold under Datto's identity. Its DMI
strings report sys_vendor "datto" and product_name "SIRIS 5 1U Server",
so it does not match the existing "PowerEdge R640" entry in
tg3_restart_aer_quirk_table.

As on the PowerEdge R640, a system restart triggers a fatal PCIe AER
on the BCM5720 during ACPI _PTS for S5, which the iDRAC logs as
PCI1318 and which hangs the reboot. Power off is unaffected.

Clearing the same PCI_EXP_DEVCTL error-reporting bits on both BCM5720
functions from userspace immediately before restart allows the system
to reboot normally, confirming the quirk applies to this platform.

Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")
Signed-off-by: Travis Howard <thoward@lafayetteinstrument.com>
---
Tested on the affected system (Ubuntu 26.04, 7.0.0-38-generic) with
this change applied to tg3: reboot completes and no PCI1318 is logged.
Without it, every restart hangs with PCI1318 logged against the BCM5720.
---
 drivers/net/ethernet/broadcom/tg3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 8b6806a79edf..b6aa10f2bdf7 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18229,6 +18229,12 @@ static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "datto"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SIRIS 5 1U Server"),
+		},
+	},
 	{}
 };
 

---
base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
change-id: 20261019-tg3-datto-aer-quirk-1c380e393ec6

Best regards,
-- 
Travis Howard <thoward@lafayetteinstrument.com>


