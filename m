Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A742DA3D;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276362; cv=none; b=EXkcoQmfFiof36wpupmWzTZFZsXW8dRKY5HwymS3v9cs+1BHJInEDOk+tkXeZDtzeIK3uzEDvHUQy/m4YJBd73RBdjQXl4W02LOcxhMrtNuNhg/lwBPpU0NlOUX83/n2mvObF7nWM17ZfrovekcvEPrtvge4a8Rx1U9bGhaQii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276362; c=relaxed/simple;
	bh=EPJ8RSWJB5URu3++h0cPK6xaFqxgLUn6Sbl44l6V/sQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i+FhLtjDwMJVoXkWmnaNqAUtkZ9TQ5VedxCR2xIzYS0VOSM6RS9zxadtXkCwimZzkvIiI1bhfy9a7F7Rsx6dVe2I0VwXNO6NXXM4uiSYz8mpeRh7TslnDvAX89AyKuYOAASJlO8F37v3eLzIrD5BVKRqxQb6eJTmTlGdLJqyx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/wyDOkm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/wyDOkm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F72AC2BCF4;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788276362;
	bh=EPJ8RSWJB5URu3++h0cPK6xaFqxgLUn6Sbl44l6V/sQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=L/wyDOkmbaEci6BMrVNxEceHI4YfUxB/605n+MuMEoMqk4j55zSaiv2g8dIBehJ9A
	 JnDZMFxSyhPzKJcRt3tDpgbOIUZp2KneyXxHNUMenl1h1UzSmvJu9msQF2SFfDuEV4
	 DBQ2T96OB4aenTDruPfSw/6VqfA8QW1EWolSxc6c/92ojbipJbMODYi8yidClKMHIg
	 ++RB8MPKApdQAs9nRk/0rfgJllcODGgnA2hcUFmy73JSIurgzoxnDXgWBpJoFEFT4U
	 wVyERIQVKxEoRh0vxFsM2H9MwJ5az0yZmtiL4BTkS0RqptZ0XGOeHsbD3suBF39llr
	 nS/2Tjs20E9Ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29576C624D3;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Subject: [PATCH v2 0/2] net: pcs: rzn1-miic: Fix config array
 initialization
Date: Tue, 01 Sep 2026 08:25:12 -0700
Message-Id: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjulmoC/32NSw6CQBBEr2JmbRt65Kcr72FYDG0jncCM6SFEJ
 NzdkQO4fFWpV6uJrMLRXA+rUZ4lSvAJ7PFgqHf+ySCPxMZmtsxqPIN+PMIoQtDJG5yqW4BLx3l
 eWMqwMmn5Uk7lbr03iXuJU9BlP5nxl/73zQgIbVGT64guWPFNeRDXDkzBTxqGeKIwmmbbti/U8
 GtVwQAAAA==
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788276361; l=762;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=EPJ8RSWJB5URu3++h0cPK6xaFqxgLUn6Sbl44l6V/sQ=;
 b=GRVjUws+n7JiTBA1xv1VApzL+tvpJYMGPHb01yIf4+srgprXaovjBiDvePLVijKaXwhp5lkif
 1kV4edyqKvZANoRBQ3mE+xAk1egjvwsFIyMLuH9wgG0sYjL6RhgIHUf
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
Fix issues when populating dt_val array from device tree values

Changes in v2:
 * Use a more correct array size in memset
 * Ensure that write to dt_val is in range

Link to v1: https://lore.kernel.org/r/20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com

---
Kyle Hendry (2):
      net: pcs: rzn1-miic: Fix config array initialization
      net: pcs: rzn1-miic: Verify port number from dtb

 drivers/net/pcs/pcs-rzn1-miic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 1376afc7660bad2a1a5ee0876898312a486cf8bd
change-id: 20260813-rzn1-miic-fix-array-e6ae4452c017

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


