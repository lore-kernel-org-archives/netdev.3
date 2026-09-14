Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8048167F;
	Mon, 14 Sep 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404063; cv=none; b=H07dGiyA5ayfe/3q/yiPDLclxqYDEdAUiNDApxJqfDs5eiBIYJTWVydRw8i4CvcsrQd+i2glW1V3XNMSRAYUf1viXPgZBuM/XxRu6fMOPbAjPDt9e0yeWU8zNYd12b3VtAISdDg4wnvR8CniLYnvWfZoq+vnc1I8Besa4Fk1xFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404063; c=relaxed/simple;
	bh=wGE2smqVz2Oj4oJkTsgmVmHvoGq7SVA/xQuf5aNBnOI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mTFAdXhcx8pRx5xl6oZU8TNyM10vUwQcCuGMZ9ZLvTcM9f+vRWyAQBEtac9vSd5RjL8+Z7y+9HFvOM96fZR7+WW1ZGdVH6wukMs9j/q2v6nykpApEcL2YGRhoIBCWoLXFzWzeEdmB6dEa6uxBQB6C7wSsrgBc6wXBa6VW1VzRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve7cjbgS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve7cjbgS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8D5AC2BCB8;
	Mon, 14 Sep 2026 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789404061;
	bh=wGE2smqVz2Oj4oJkTsgmVmHvoGq7SVA/xQuf5aNBnOI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ve7cjbgSk75OWdE+BjU0hEAEaMvxfk0mFOWbiaPAGsCiRT0qgEA5QnzHsVQZbJ1hq
	 Eqi7QyMRSbpmKvfrfDlQAFyhPpx4nn4XfwNRollG1vzRKKuGtZq+or9KyDCX/E7YTU
	 oJjFm9jFzPgq6EqFJSQ/KYlUAeqee3qPkfFACEYYjXtX/Bs/mVmGex+ktqGkC79r7z
	 9oXfi0OW3xdJVqf2rhgHFk7mFd+L+8QxLlIggwbDmgIqDyhIyZBKkApNb3m369/KEE
	 UwQB/gUPO1mhROVgzxGCOlrfxIFYeYBhmwQIA/+nx3fwGoG2P+rdlyxeNdAd4q2rkd
	 NlugTDbowzsrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF97BC88E73;
	Mon, 14 Sep 2026 16:41:01 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Subject: [PATCH v4 0/2] net: pcs: rzn1-miic: Fix config array
 initialization
Date: Mon, 14 Sep 2026 09:40:59 -0700
Message-Id: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsjqGoC/33NOw7CMAyA4augzBglaUsoE/dADMF1wFJpkFNVP
 NS7k3aBARh/W/78VImEKant4qmEBk4cuxzlcqHw7LsTATe5ldV2rTemAHl0Bi7MCIFv4EX8HWj
 tqSwri9o4lS+vQnk5q/tD7jOnPsp9fjKYafrfGwwYOFYb9AGxNo52Qi37Y0sYu15im1YYL2qiB
 /vmam2+cxY0FFRrp8uanNN/uOKTs9+5YuKCaxBD8KHyP7hxHF8HYSO9XwEAAA==
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789404061; l=1130;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=wGE2smqVz2Oj4oJkTsgmVmHvoGq7SVA/xQuf5aNBnOI=;
 b=qJaoEOxzsjms0JGj6ZgEwK3qM6Icu3nQnyDcWPwQXrlA9n1GXfAqCd+7YX8BbriCKUNw1717J
 ud8Ah2jEB1HDBlylMu9MtFqmgaXGVKxSnmlNOIZ8cpFO2TU1HGks1j3
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
Fix issues when populating dt_val array from device tree values

Changes in v4:
 * Fix lines longer than 80 char
 * Add of_node_put() before returning

Changes in v3: https://lore.kernel.org/r/20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com
 * Make invalid port number return error
 * Update commit tags

Changes in v2: https://lore.kernel.org/r/20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com
 * Use a more correct array size in memset
 * Ensure that write to dt_val is in range

Link to v1: https://lore.kernel.org/r/20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com

---
Kyle Hendry (2):
      net: pcs: rzn1-miic: Fix config array initialization
      net: pcs: rzn1-miic: Verify port number from dtb

 drivers/net/pcs/pcs-rzn1-miic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
---
base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
change-id: 20260813-rzn1-miic-fix-array-e6ae4452c017

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


