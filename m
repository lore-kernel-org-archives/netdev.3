Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937672931E4;
	Sun,  2 Aug 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688367; cv=none; b=mCv8oc005nGwGcbpm68OKZkO140xrk4/vtwwjiHesiL0PKrCo3aHCa7TZgV97eR6hJycS31/sFLCCnrjQJni9vXqTuGxr+++QN0F0avaS03cvU8xcucxd0MobEQIWVrzXSwmaGBRHTnoDffd0ZOsmkii7LNr+Qumj1tow7XRxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688367; c=relaxed/simple;
	bh=M6kH3QCSEEIgF299jkmBFu99MO+R3RPd+0sy4J70++k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzpdugfnVa7R5XhgKHMSe9L7vn9fmgi0tEb7v/FiEhYDll2t6Clxx2tsPpiNtSkFABnJnt+/P/4QWbArPBTssRZNyv1ZRIGz6vgD2FeDri8wYNjs52CgvqDfo0POaVEBM5Fc45BA1+wdO4BmcHlDoWgkb/fsrPtfZytitnOjqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ONciwd9F; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kUeTzlBN; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ONciwd9F";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kUeTzlBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688362;
	bh=M6kH3QCSEEIgF299jkmBFu99MO+R3RPd+0sy4J70++k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ONciwd9FPHxF8Q2Iv6r6x1Cdz2bb4YghCHnACKIITYiI6gvEWP9ztmPMoeRHWjgLx
	 /RYjLU4982NhC+09k3tCS0XRnDcHycIQ02/o5OGoIdQbDevW7uMNwip2/xUjuFBlHJ
	 yedABwb9o/o8l8CDCDVaP4feJVDV9tXZkbsLqnw7e3dXKupLL65fnQVgChRmVDCSrK
	 zQ6N/3uQcvrYrxbbt+57I3qinvpaCXHgwPUWJkQCf8rJNaerVzEBG0G+PQWJ3itgWr
	 hPkMv5N5B5jcOWppn3Zup8j+L8ns0BNjJHj7jRobR6TfpB/f2JATTPBsZIxK3zgcAd
	 6bHSLXsJ4a/8A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0174249652; Sun,  2 Aug 2026 16:32:42 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688354;
	bh=M6kH3QCSEEIgF299jkmBFu99MO+R3RPd+0sy4J70++k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kUeTzlBNMo5OHc6KoT4UA7Jy/Wv/pdgM+v0Oj9doxWP+KqogrSHxlmPsu+nF/H0Mt
	 PxNUTZN9CUFYTth7+Wu4E/PaY+ug5uImcEW/l1wesG6qcIA8qdOxH0mZnIWAEycek+
	 YRy/+mS9vcI1TQB8Xp4EmxSfwFTHcnRf3rWvK52U6kFz5egRvD03isY4oKeCa4ghP8
	 sHRPrzFfWIMAPQoNYINHZ5qt7rga6b3ySsDqw5irauLMog1BbBhPoPis9J6PrQifxa
	 TNMQpzzbHyPs/enzYzR4jUdJOBfqhVAQc3+aQojmrVAdNQXS398rT4zcXftvaLVAy9
	 cZt63JpnfRnpw==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B80E24949C;
	Sun,  2 Aug 2026 16:32:33 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:03 +0200
Subject: [PATCH net-next v5 05/13] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-5-dcb9fea4acd4@birger-koblitz.de>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
In-Reply-To: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for this EEE enable/disable register and replace the EEE.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index cef2a0131c1e6d60b28c2aab1e020e6b7468bc3c..22c7d1a4501dc052ebb16e06dff86e70c00c8381 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -400,6 +400,8 @@ static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
 	.mac_config = ax88179a_mac_config,
 	.mac_link_down = ax88179a_mac_link_down,
 	.mac_link_up = ax88179a_mac_link_up,
+	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
 };
 
 static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
2.47.3

