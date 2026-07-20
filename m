Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD43D6CC1;
	Mon, 20 Jul 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542404; cv=none; b=iDzXu89JqTUi8e1xQUrkEcsORsUZhwGao8cA9DGQ2JxpiD2/wpDSgGMDPJybc2FOZFbjVCVWrmO8OdqDsTeKHXpU3GD42IhuUQDzMrcsxv50L9ZrKBNtqJLSm/DIXl6rWPPcC/yeuyd/usQStfp+cj5cwo3L7M7/GtiNorhN624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542404; c=relaxed/simple;
	bh=Nq0s0VIC8e5fDh/83Ro9tLfdaVOz/7o4FHKxWSCN1BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iJktJL7mOszaTF5NJXLUd7JOUbcZ350xpwBU9CiYaoRvA0rUWGl9iG93qrrJvvf5dhBnOp4en8dYMC3iMs12vWYSG6OwAmfIuLDMucvicGRiB60l+EwXCEf8U/4ugj8N9MBaU8SzU94BTS1yPTiZ5nrjFuMtkqDizard61OdL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE7B5PXX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE7B5PXX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4476C2BCF7;
	Mon, 20 Jul 2026 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784542402;
	bh=Nq0s0VIC8e5fDh/83Ro9tLfdaVOz/7o4FHKxWSCN1BE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dE7B5PXXy8XVuNhIE7cHK4Y8G88HEDW+9X0vuNHfAtODqWPbemuJgXeTD/PNJJ7Dg
	 nrDtstYFIttec0+xUeOTZhqBn+ADvkHPjsdGAlVVIXB74RhZz6IQXK6uoVoPkmAO6M
	 LKlqfVNtCm95fwxLnCdn4/eqN3JhMktQIrjoa+5y2iRMKP04mAMsAN1qHkdGfELYLp
	 lYAs7wFlSuLKvaJIcNOfv9j+TaGuj5sr0jt/bn/agpeM/ZXP6y65bWHioj02u9SBGj
	 d+gzw51n/gSjFIILF4h0MsysZewWRJ0KQzMkww2rPJ+ISGafaPhR8cfqnnL7VIM9RP
	 BUzSLpeNhbkJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA00AC44515;
	Mon, 20 Jul 2026 10:13:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 20 Jul 2026 12:13:12 +0200
Subject: [PATCH RFC] MAINTAINERS: Add Matrix channel to the NFC subsystem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-nfc-matrix-v1-1-11cc79035472@ixit.cz>
X-B4-Tracking: v=1; b=H4sIALf0XWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMD3by0ZN3cxJKizArdlGQTiySDtGST5BQLJaCGgqLUtMwKsGHRSkF
 uzkqxtbUAQV2oMmEAAAA=
X-Change-ID: 20260720-nfc-matrix-dc48b0fc4cd8
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 oe-linux-nfc@lists.linux.dev, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=xv8y60McnQApKTGnwmwadUYgtutoYQCkFABtlPt2vGs=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqXfTAVwJi1QN2QN9lmm/bnANdhy9LEPAvKab2I
 lNdffYtPdeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCal30wAAKCRBgAj/E00kg
 ct37D/wJBjYoIpklUWWwW9AotU0UPjjIGei3ABhEHZRrDSB7bONMO3m5avW2DU3QIurnNB4tfPV
 n7buVoHkfq3o4DNtUQhknImbzZDjD0S+00EVi9lvGUX2a+rWkooRLTr6xlyCJLTK0SMpQF3F8sx
 IWlLTftKqb3yWdttbDHvkS16hisP+VEIoNoG2Yq/dl67SGbJRk4QLYIa0acdfN/tpenUhvjoT2x
 9YCsAHp685bNVxAYiUNr+aclQaLqV7JvI4sCrF5A79zw/v2ynchEqgzyu+dojTsSauAESaxC/Rp
 3um+FD3FuQVJ8w3Lm9VUq8IoVbgGmAYWewuuuAMrbg9DzT74RHxVmMc/6FKOSRcWILh6/bCEcMD
 toI2ZOgfwYsSFJxavgcVLy/N/+Ddn9dJxCfkV2ZcZpIWtC9H2sL8ot4R6VgcoowhsArMJ9toEpI
 svtMrF/DFQhDi1+3EZrP0FCmYu00XAk0bjGr61o31SD/ptVQAhjnFMytvZznjzjWE8euhVsdeSG
 YEPdSMUc8EbWEkASWonHc+x8NFyuq6rnxjaMfZKOvd76ngk9p+rmbOd053E8/XwrJYzT7OLpPdq
 teqLcKwewXyxLpHWsvn8M2masVmOGcQ3ZgePHBxOlaSncAWB/FNxXg+5znY7evzVmRk/K37KH04
 iPiA6cb5bEAngvA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

We use the Matrix channel already, let's share the information.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
This is the first Matrix channel added, so I'm sending it aside of my
tree to estabilish the format of the channel.

We could have something like

matrix://#linux-nfc:ixit.cz or full URL as we use now.

I would like to hear what you think! :)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52e2c22d533a2..6828127e66078 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19149,16 +19149,17 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/net_failover.rst
 F:	drivers/net/net_failover.c
 F:	include/net/net_failover.h
 
 NFC SUBSYSTEM
 M:	David Heidelberg <david@ixit.cz>
 L:	oe-linux-nfc@lists.linux.dev
+C:	https://matrix.to/#/#linux-nfc:ixit.cz
 S:	Maintained
 T:	git https://codeberg.org/linux-nfc/linux.git
 F:	Documentation/devicetree/bindings/net/nfc/
 F:	drivers/nfc/
 F:	include/net/nfc/
 F:	include/uapi/linux/nfc.h
 F:	net/nfc/
 

---
base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
change-id: 20260720-nfc-matrix-dc48b0fc4cd8

Best regards,
-- 
David Heidelberg <david@ixit.cz>


