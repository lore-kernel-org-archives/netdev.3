Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90903CF21D;
	Mon, 31 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168980; cv=none; b=jWdhBB64EhNnOJIEX69IjC7WrmpeLFGlGgBb+Q9wApa2E5WZOwnwg5ru3UpIGPpo1TO6nWRkvy9mX1tA2okNQGttruKFPy1K6o/ujCS7lfVb/4xLFhL6lPAIRd5RGTzX3DXeNE2Fkb/xFDBROh/FVxPxUUe4z7VPWqkkqYAz4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168980; c=relaxed/simple;
	bh=0y9SYeJbQS6ps3heZr3eahrgdU0qiRAeZE0dDp2kUfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwAhalo/JdMRQjjcX9tb7L485dTkfqZY0WcogZZWCUQUOpzes/mt5xhAkaV24/NeUQFEI+k0aup9twewGaJwCdowGdr0V9grBt9xSqMQX7cKYNYPjaUQdbRyp06Jz5b8BniinYxREYr4Pws8hIQS6GxYDVK3QCUTBVuffFcOcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=jv2M2GhQ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="jv2M2GhQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1788168969;
	bh=0y9SYeJbQS6ps3heZr3eahrgdU0qiRAeZE0dDp2kUfM=;
	h=From:To:Cc:Subject:Date:From;
	b=jv2M2GhQSgrThEx3K+IJFxa8sj9ubeXNcEVGSplUuGgVaLf/8fiIAgDIuIb99Vb8L
	 nSCwES0wbbE68KrEQioAPMdViPkoeW24b5Qs9J6Bnw6+m7RAThLNZMla0r3Zcxg/tR
	 TKe8W7XLVSJ+BW2FnNsw9HjmDyaLRrTJbbAApe8xFIQlYIz7J69utUtI4cRAVrzuGh
	 oDGaT6m/K/CItC2t/8H+igijPTQvUKuzjgw2VmJWaUIc8O1wVt74L9StQRdre1Z9p9
	 6Rlaze6ps95jJzidOBwB2REnCSL5TjzSYrNASfiWUEegucukErNk1VhyN1/+H9GjMg
	 r61uwqzzFgfAQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id B0068600C1;
	Mon, 31 Aug 2026 09:35:56 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id C62072014E6; Mon, 31 Aug 2026 09:35:07 +0000 (UTC)
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
Subject: [PATCH net-next v2 0/3] netlink: specs: rt-link: ipv6 devconf updates
Date: Mon, 31 Aug 2026 09:34:52 +0000
Message-ID: <20260831093458.472180-1-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series updates the doc-string for ifla-inet6-conf, and adds
two missing ipv6-devconf enum values as identified by Sashiko
during review of v1.

Changes:
v2:
 - Update commit message for net-next, and renamed from
   "netlink: specs: rt-link: fix ipv6 devconf doc"
 - Add Reviewed-by from Fernando (Thanks).
 - Sashiko comments:
   - Added missing enum members accept-ra-min-lft and force-forwarding
     as patch #2 and #3.
   - Re: data types: as Jakub wrote in the original commit 720447bd0b24
     ("netlink: specs: rt-link: remove implicit structs from devconf"):
     "u32 is probably best we can do right now", as the reality is that
     the sub-type varies per value.
v1: https://lore.kernel.org/20260824103816.40040-1-ast@fiberby.net

Asbjørn Sloth Tønnesen (3):
  netlink: specs: rt-link: update ipv6 devconf doc
  netlink: specs: rt-link: add accept-ra-min-lft
  netlink: specs: rt-link: add force-forwarding

 Documentation/netlink/specs/rt-link.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
-- 
2.55.0

