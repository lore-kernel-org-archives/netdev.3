Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798F3DA5AE;
	Mon, 31 Aug 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168981; cv=none; b=bWk9saXq3X0nfXykshqfGzjvO9efYkqjds6fzKmeRoiymD+FpJANHFhUTyFE0pzqfGuw4cY932HUB+7+cEhmJCz/XDuHSkh+vZFXajqUZz6cupKgNyWSiOGat0TlAjQ7CGa8ClSTMhXMhAl+zwDq6oACUVyX/rLRR3fELbtaPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168981; c=relaxed/simple;
	bh=kUrfU5F5flpM4Vy5xyitNYLMzCLEj9RTMswK1Nn96D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgOtfzE8BtMrdUr8wc2Z3fkm+skzzCVdDaEQqAg745TXyE+z6QM5M/4v3ObBM2d8F7hpDKqDXvJwvhieZl/NqCIF4R0TIw+41j8WTYFrZvTS4vGMoGBWh75YcNDIoPlmh5YHSXz8CyXXULSw8M182Da2T+CPYUSLFC9J67fo1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZfxjDdyP; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZfxjDdyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1788168969;
	bh=kUrfU5F5flpM4Vy5xyitNYLMzCLEj9RTMswK1Nn96D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfxjDdyPtg2b3Ft/KTVpIB05FQwmddOAul8y5GkRjSB7Y/AgRSulMqiAAH/ahWRkD
	 cQiV13sNnnW5gf/205f5sOfuAYfyIS5UH8O0GMTH3U9fCSjotnBoyhSDuc0FTQzGOM
	 clvOLZ714osaY5IIpToDa7gL7za80NzJVH/DzMiSc/ZN78Cr7GYkGkA17f0JY6xdV3
	 VIgjhyR4gKWnWD+0M5tb9vJx7tzAhyO3Nv0o697VsrkDwR/36UEmmvkWvscw4aJk/v
	 T42itaN6qFwLjjc9b4wXUPj1YMnDkRGxUSIKb1UH9WPdF/AscHzEe3aacQAybqj7F6
	 Fd7pELwUeYR7g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 09BB36000C;
	Mon, 31 Aug 2026 09:35:56 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 2CE49201E45; Mon, 31 Aug 2026 09:35:26 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Gabriel Goller <g.goller@proxmox.com>,
	Patrick Rohr <prohr@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] netlink: specs: rt-link: add accept-ra-min-lft
Date: Mon, 31 Aug 2026 09:34:54 +0000
Message-ID: <20260831093458.472180-3-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831093458.472180-1-ast@fiberby.net>
References: <20260831093458.472180-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add missing enum member accept-ra-min-lft to ipv6-devconf.

In commit 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
the DEVCONF_* enum was extended with DEVCONF_ACCEPT_RA_MIN_RTR_LFT.

It was renamed to DEVCONF_ACCEPT_RA_MIN_LFT in commit 5027d54a9c30
("net: change accept_ra_min_rtr_lft to affect all RA lifetimes").

Shortly thereafter, this spec was introduced in commit b2f63d904e72
("doc/netlink: Add spec for rt link messages").

This pre-existing issue was detected by Sashiko, when reviewing the
first patch in this series.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824103816.40040-1-ast%40fiberby.net
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 00c915031efd..ab677801cde8 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -494,6 +494,8 @@ definitions:
         name: ndisc-evict-nocarrier
       -
         name: accept-untracked-na
+      -
+        name: accept-ra-min-lft
   -
     name: ifla-icmp6-stats
     enum-name:
-- 
2.55.0

