Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D44718D7;
	Thu, 10 Sep 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078793; cv=none; b=YFprpOkFbsgC8U+8l/EX+n0nwdl5iqVIBU0CvVMTXhEQRgMFxD1ddywggzyePrWSld2+Ku6yf5XRuLSoIU5+UVg5yk2hiysbwVo06st15sviowsJRCZchvIeXzQuDeyNjtKDqniXuKto+yoBc/merNN00szNuUAcQIc+R/TICdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078793; c=relaxed/simple;
	bh=s+hOzkSuye3kU3kpk94W1+7penkRt7gxI4zAAVQeNLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XV90LV3k6VZuwa0/1Y74LK9VwyfapCy6DGkOBRuDvfWUmqUHCwJ5q3pfNH8QIDmBKp+lukXQc/wHZDpaDOtQcxmcAjOoqnapT7u+IsNKDxfdzJugvEjMvOy+rDZUTdl9z1/+UuuCODWJBWbIRCPIYZj51umy/6nZy9tQAAXljVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=iTLmFyb3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="iTLmFyb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=s+hOzkSuye3kU3kpk94W1+7penkRt7gxI4zAAVQeNLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTLmFyb3hVpMkawhgWEa68ONsJaWPNcNx984HoWKKBpDvitTY0HwLYcLu3Vnh5jER
	 LRKC5cAAAQI/d6Uxvk+TUda/thCd7RU84bBuhyABoR2a9q0zEqigWQtvYt15kyF/5m
	 a9NG75APPwNWAEGQpPkwGICisMBXMwFolyz5lsH0a8t2C1J5hTI8q688YUIMekpAvT
	 NwEYQTuAFZYj9wI90kw34YCMk62tzEWvRg0jciabCVBXMtObz9ADC6ORaJRt33rOQF
	 tplG5CyLcYhoYnAiYHAQniZLyV/xFVOEfwA5Fg29mCEoHmNobZ0yo5zAXKz3s9JtU8
	 GxWM3YBiKudFA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5685060114;
	Thu, 10 Sep 2026 22:19:38 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 57E3C201E22; Thu, 10 Sep 2026 22:17:35 +0000 (UTC)
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
Subject: [RFC PATCH net-next 1/8] netlink: specs: nftables: add uapi-header
Date: Thu, 10 Sep 2026 22:17:21 +0000
Message-ID: <20260910221733.1021864-2-ast@fiberby.net>
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
 Documentation/netlink/specs/nftables.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index 21edf3d25f34..76f69ed82a24 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -2,6 +2,7 @@
 ---
 name: nftables
 protocol: netlink-raw
+uapi-header: linux/netfilter/nf_tables.h
 protonum: 12
 
 doc: >-
-- 
2.55.0

