Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021056;
	b=3QtPF6QaFqen9Ndb2pcsPMuS5LDacnUYhYFnrrBzKFftFHaP+RmIlIShFOUPNwI5yWwA
	 nXnO7j5cX24zdCJKt861VpkCfLtPF1AWOBIvWCEmhXPe6AJr6kt3OHAMfAHwMT79f+O7F
	 AX8TZfQE9wm308oeRExsdmD+vywU6fu0HSuj6bB/x0S79HcNnzqXcqXAJ/s9qXwMInDm2
	 3zhgpLvnxOIXFx6lWph/WM89NGfI2TB8EcTelNHB+lDkqoyVdeTrkb0CN4W0HqbmjGHXS
	 zrT86UxvXl9iPVVNUhtA7MCDElpjmWNlQ+otAaQpegd+SlYLKj8GjGz9+1d3XNWShlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021056;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dz2GP75fsdJzjRcS+ppb/nv5PsFOBkkkZwK0mrTJOM8=;
	b=zsZY5v/V0lHQ91EDvTNoEIylWOtsPEezCMoOSdau8BbK7sdY0Vu6obUSjDhzQZOi6RY0
	 ev4BWPwxdZj1hy9X6i7o32ZvCLzsuRsbl95Atg9Jd8dmYB8vkXkHtHzO4dveqR4zDOs3u
	 bnxgA2V/KX1hpz7/rvzo9+sO8CxcaoWvJtMKGZdDoPpkG0XW+9L6UrxYgUGkxz1fdunOF
	 A/i1IQ40AIthjG30ERgclcVumwkCwgRAucBLyUOc68IHFQ/7DyGkkOu3JgcF50q3Or5ba
	 VUa43HRIB5u+hLq/6VXVIvdSbrg8JDoEYqXf+xrxTJ7P4tM+p0nxVU+rSflPJhY/UAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luixo.me;
	spf=pass smtp.mailfrom=luixo.me;
	arc=none smtp.remote-ip=79.135.106.113
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE0606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62AE0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=luixo.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luixo.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luixo.me;
	s=protonmail3; t=1794021051; x=1794280251;
	bh=dz2GP75fsdJzjRcS+ppb/nv5PsFOBkkkZwK0mrTJOM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T2Ob4dCu2Gupq1Rib0yH8xS8eoLc28e9J/5494R7Ui0++Rlufz9v7GbXneayz+vtJ
	 AasGFroHQg2GbDgqxsuc4ngkBhJ3YRzBHhSuU4KhNmID4ApgfI1rjPqa+P+0K4LRUU
	 s/3B90ZV4EIrcvjFIN/Kmirr+87qLXSxLv4Qph5whGIno/zi0ZYTD8AgKc/4ul97T0
	 kpedKNYRTn26eV0p3etMJGNaeA2sMVD0jwQuqN9ssOM7Ws89kPW/DXRyCTgWK8/Ydb
	 foHIHs/0Uitk5E0HRTylW09rzGwPQt4NUuaHcvFYdaX00jTLLivvq8EquF+M82ZJNt
	 5/Vdq08AvdhoA==
X-Pm-Submission-Id: 4jM1Jk525yz1DFSq
From: Alexey Immoreev <luixo-public@luixo.me>
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yongzhao Chen <yongzhao.derek@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: dsa: qca8k: read each register into its own word over MDIO
Date: Sat,  7 Nov 2026 07:10:04 +0400
Message-ID: <20261107031005.2525-1-luixo-public@luixo.me>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104210757.467964-2-kuncy7@gmail.com>
References: <20261104210757.467964-1-kuncy7@gmail.com> <20261104210757.467964-2-kuncy7@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stanislaw,

While investigating qca8k bulk reads for OpenWrt, I independently
arrived at the same destination-stride fix, with AI assistance.
Your patch contains the identical one-line change.

An AI-assisted host-side regression against current net
(30c71476d842) extracts and executes the actual callback with mocked
transports. The original fails and the fixed callback passes,
covering MDIO-only reads, Ethernet success and fallback, and MDIO
error handling. A separate UBSan run also detects misaligned stores
with the original code and passes with the fix.

These are callback-level tests, not hardware testing of your series.

> last three bytes of a three-register read are never written.

Small wording correction: I believe this should be "last six bytes".
The four-byte stores start at offsets 0, 1 and 2, covering bytes 0-5
of the 12-byte buffer.

Thanks for posting the fix!

Alexey
