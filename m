Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347A391846;
	Thu, 10 Sep 2026 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078789; cv=none; b=Y0iiGn7QHK/0UOHIvgdxIRcaojStQCfGPP2OwUJk/KMd4WIZock/bVeoPkxDHiSS5bjsNE+qEkxoT8BVv3meUU6v+xJG55ol/WxG2hQDrRkYnREF3qbLq4gFRM9Hmy2IrrhBkr/9s0oPoc7qMtoUFzcQTMUq0HjrDXZAE0lMfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078789; c=relaxed/simple;
	bh=5SVbkqIRTJ6vFBojUaOqULhwVzhidmNYRFGSJ1RSPZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riD+6Y3aHBocV2yM3+mEZU2aGYOSj/4nAEw0LYQiE/XW13r5Bm/KfCy/skvHXy6+iIc8SKYp9M5ldH04kZ6Og+vJS1/MUVrod24ERhXZKZyZTJIEU2Bl0Lh9NQxi63ARsTG8sP6rNbMl2ucamW0sCrxgd4qwww8+rpSUIzTEUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=JYr9dWnk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="JYr9dWnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=5SVbkqIRTJ6vFBojUaOqULhwVzhidmNYRFGSJ1RSPZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYr9dWnkkntyKQp9kW8/kMvsgyBo34DoixPCEvWvW1LWUyUcSJzN4KyIAW+Oy0Elq
	 4SSTPCrm+dkRZIddIsDLAeTRp4TEjxSqMdSn/88jNmKttWkoy4+Ia4yBp84845ny4r
	 UtNoTKDk8+TWKXlRK5y2F8lnU82m81XsWK2shfP92ORX2GQ/Psv64aDhkPmuIHD2su
	 eH9l2Av5qIfXbh9NFpm3WjaAfHVNehKvgbE4YOTjQcnAkNS+JQ5hs6EPyT2fWDNwtp
	 VCU+aPGqCacyIxdwCawWo4ZSoECltHrbyrvpZFdgqQCglG09767n73BnWsaywVDTbQ
	 IqWnAB/XuOLDA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2D2F2600FC;
	Thu, 10 Sep 2026 22:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id DAFC9201FE5; Thu, 10 Sep 2026 22:17:35 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
	"Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Heng Guo <heng.guo@windriver.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/8] netlink: specs: conntrack: add uapi-header
Date: Thu, 10 Sep 2026 22:17:22 +0000
Message-ID: <20260910221733.1021864-3-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910221733.1021864-1-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define uAPI header, as needed for C code gen.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/conntrack.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index b1eb102ab843..543dcddb0464 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -2,6 +2,7 @@
 ---
 name: conntrack
 protocol: netlink-raw
+uapi-header: linux/netfilter/nf_conntrack_common.h
 protonum: 12
 
 doc: >-
-- 
2.55.0

