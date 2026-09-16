Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FF4E56CB;
	Wed, 16 Sep 2026 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562223; cv=none; b=ofUI9N1RSWghD7XUvcKrntNayrxFnHGzIWGeYYRMSkAWYJeen1f44GWCJ2Vze2OvBgouOXw1BFXWEbT7ykfpKuMcheNKARXmQvytMIhwJcUgvUB38zZr056o7N/WSSAV/934FCdj5tS3JSU8/8pYrBW5t961HVQYZDvlEeW6uUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562223; c=relaxed/simple;
	bh=z2X3IWvxcIovq+DhIej610/YZKXjKmzE2HYwb5mcwOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+dwQrudWyt/XH6tFjyxbB4dTumj2Fwyc3EDoW0bURRm6yBktEEJy7cIAXQ6ugmu4j2BqjdI18Kk4mv4MjeAgL7vAamChbWeQ6Ac3Ls46hiE0aRF0YrZyimnaEnapPBFSJnjrQf6kA18HKJ6ZHDtnqOaFk8yWK0xmoKMgYL1Gdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VEDWqV4W; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=prn3Udg9; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VEDWqV4W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="prn3Udg9"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hlJKx6YXCzKmyp;
	Wed, 16 Sep 2026 14:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789562213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+hxp5i4/rxB1qypgVpYvutTN8n+adlKnfsbE41Eeec=;
	b=VEDWqV4Wae6lZZ8rXS0nKEAbxZnOD+zOM2dvOlXbfTUUQU6UUPSU1P5zxYgF8JDmMYN+z/
	UgndONINQR061AuKEB+V89EbVBQ2r3yUTjC08RNKit2WvlLvB+npmHS/SKEqXD3itZYVTU
	Wc25zJuiMhewqiqmLnurM3eidHuNoYYbTztZGMOUlqBHzngQEbuDp26xxBnNXqEVJraRbb
	oei8pfHUw840aSFhzoahEogTdtizL8TttniNR7Gl2rgIpxiU3SRwdfhSmsLNWMHQC9wV75
	WEAoDBNcndjA9oSMpPuO3cEaCz/dUVUx5xh7MXXyEPr08rjtPXXjrEsS+yFxSw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789562212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+hxp5i4/rxB1qypgVpYvutTN8n+adlKnfsbE41Eeec=;
	b=prn3Udg9449as0Cuyvdrj9cQEUOwv1iHnM2CQO+jrrvi+6mrq/mZ2xxZUQhggoqg47Dwia
	lZAjG8pCb+YgjHltDTryuwawc0+z+jr6zTriKpArcJ/vhT6ztkNB0OIFtAwXv+OOMNvwsh
	yVaUQHV5TGHq8HFm/KZjI9ImhiEAWxYOyyUcECLjfa6IpcUvsplp14Q1bPXZpN66EYOaqn
	oIZMLi7HqDXCewfoi/KtzAY6jabaHnccKtR3LQl/gXECng5McvpNE1M62YjDnmqDnqw0Qx
	xi8Yeu+6MTC+Asf+GBbj12GITCSLbbsNMJxG8fzY9mjxNWBkvNYEChwls0MXtw==
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ethtool: Fix bracket
Date: Wed, 16 Sep 2026 14:34:55 +0200
Message-ID: <20260916123458.314458-5-manuelebnerli@mailbox.org>
In-Reply-To: <20260916123458.314458-2-manuelebnerli@mailbox.org>
References: <20260916123458.314458-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cc0b2efbb7da47b9edf
X-MBO-RS-META: yq7uqemmxoqmwgyz9u7m3kxdknhmfci3

Add missing ')' to sentence.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/networking/ethtool-netlink.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index e92abf45f..393f2b6d3 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -131,7 +131,7 @@ For compact form, ``ETHTOOL_A_BITSET_SIZE`` and ``ETHTOOL_A_BITSET_VALUE`` are
 mandatory. ``ETHTOOL_A_BITSET_MASK`` attribute is mandatory if
 ``ETHTOOL_A_BITSET_NOMASK`` is not set (bitset represents a value/mask pair);
 if ``ETHTOOL_A_BITSET_NOMASK`` is not set, ``ETHTOOL_A_BITSET_MASK`` is not
-allowed (bitset represents a single bitmap.
+allowed (bitset represents a single bitmap).
 
 Kernel bit set length may differ from userspace length if older application is
 used on newer kernel or vice versa. If userspace bitmap is longer, an error is
-- 
2.55.0

