Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8E4A4EF0;
	Fri, 11 Sep 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162970; cv=none; b=Mqz84Mjos6+OaE3Pkiut7JOjAxMeQdB52gQfy/Xea9+tz2zwQK1VhZ95DC3qWNyea+loHGDLcuOomvaNu3v5DZUurYGS9AYUyoTngOB1XprGmoWTs4Ty1oe1mdQQymBKBbS6+raX+HDivQ7hrY3coB5FTQA9yQr3Q5fB00+aFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162970; c=relaxed/simple;
	bh=eV8+uLJ/px2YX1XMlG+v/ks9tLDf1qdbcoN2V3Xl9Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSqZuvSb68yzKfzd5WYrHHBeC0R9UJZ30yxE9zP+ty4HlMW/dqxOU/fgxtV3hZA83nwUijzgW3DO0yve/WFn7omFu/jLvyF0Vg/08W01lQZUSiT1QdfCU9szAuttj8+SmvD+guy0D34+Ci0H/Feck1z4nfJYKPKEXeGgyVjwSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OF2N5TQU; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OF2N5TQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162963;
	bh=eV8+uLJ/px2YX1XMlG+v/ks9tLDf1qdbcoN2V3Xl9Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OF2N5TQUCWdN1Bcrhcro31ySmrQyTyJCfAebdqBRd7dFGqpmhuGiowsSTz8O7rcYK
	 mVRdkHY9TAJVUsfRtU2WinROdoR8X0IbZORx5uIHLMWRLaSQwedVA0lsWfOv7HOBnC
	 Zc/3xXth5W0GUnie47iMy7T9w0W67PjdiGQSZQXB6UDDD48+AjOGDp1v+WIUKp2ova
	 6s6PHKkJ1BvjPhq0c3Wn20i+qbftGyzKxoMB2OG83WK3RP7cVpHsSikz2FzMHcYkxz
	 J7eaprQTzLOMYDyKOXaPp7iagQWuYhiBkenQXRpUocJYB54a5nx6tRP2miYsfvGtEi
	 a5X5nM1j5aLAw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2070C600FF;
	Fri, 11 Sep 2026 21:42:42 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8B144201FE5; Fri, 11 Sep 2026 21:42:01 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/10] netlink: specs: rt-link: fix netkit-policy names
Date: Fri, 11 Sep 2026 21:41:30 +0000
Message-ID: <20260911214148.1184806-5-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911214148.1184806-1-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct the names of these `enum netkit_action` constants:

- NETKIT_PASS is 0, so "pass", not "forward".
- NETKIT_DROP is 2, so "drop", not "blackhole".

Note, the other enum members are not used in netlink, and
are not allowed by netkit_check_policy().

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index ac2084d14f22..e8af962c8064 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -812,10 +812,10 @@ definitions:
     enum-name:
     entries:
       -
-        name: forward
+        name: pass
         value: 0
       -
-        name: blackhole
+        name: drop
         value: 2
   -
     name: netkit-mode
-- 
2.55.0

