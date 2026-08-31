Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90103A7F7A;
	Mon, 31 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168981; cv=none; b=QCKU9XsAeI5VxnXNOvSDac5oZ8fEjO9mexG4tzST9RWWDR6yP5WBYlVV+SDQqJvYH+vL1UGWv9ToEWxNd+9eQe7Yi3H3XC3NUsdHYdsEuJKn029V8Mw/pHACEeFw8GTDV9KiBpshFKoMKtlk718nddaC5e6c95Z2ltlQqP4CJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168981; c=relaxed/simple;
	bh=UvRgcT/OPw+gHUkrCJqWGI3xRb1ZOVjluHGpT6Ut4Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni1YCX6C5isDvo1Zk9m4k3mkhdlu/tuwfi6EAd4djyvnkghBtHBhe9wSeUjeZ8J54tAe8Qex1Mda4Q2QskhC7OxOnIHeEMXXuA6SqHDcVhV/NqOEaDZ726ZUj/lXXKqP+n1t735J7sJZVnZIXp3e7sd6qXmq0rl+WymRleAlTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OehNvAAG; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OehNvAAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1788168969;
	bh=UvRgcT/OPw+gHUkrCJqWGI3xRb1ZOVjluHGpT6Ut4Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OehNvAAGBIN8F5mH5ZCTcQxMkOQah7TM6KdbDuG6YbG9LAjmv14in9XgBZhUFIajw
	 gDhlmiQa9sWUHr+tMfLzaHxKgmSew/b2IZVPV3PXegVdkBbA0+KQ/Yu518ZzbCDdKw
	 Hq3g8n/FcHPE56/+8FszZbdV/AqxwntMEoIoszZnJYkZwakr2ic49PGSeE+mErNhS/
	 u3dr4rUnC3718KLWiSNDfup1LsQL9UORSSNXl2EEUa2meC05SN5UBUIVNNteyPT1ts
	 9ZUNK1m4mFeaVI/fC6TliHMsNuRk6MaAbcWC2+lhHd2EWMQAFqOQZK/ZmYT2uQ4gpa
	 +hyvQI2v/vDAw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 40383600BF;
	Mon, 31 Aug 2026 09:35:56 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BBA8C204668; Mon, 31 Aug 2026 09:35:26 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/3] netlink: specs: rt-link: add force-forwarding
Date: Mon, 31 Aug 2026 09:34:55 +0000
Message-ID: <20260831093458.472180-4-ast@fiberby.net>
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

Add missing enum member force-forwarding to ipv6-devconf.

In commit f24987ef6959 ("ipv6: add `force_forwarding` sysctl to
enable per-interface forwarding"), the DEVCONF_* enum was extended
with DEVCONF_FORCE_FORWARDING, however Gabriel forgot to add it
to the spec.

This pre-existing issue was detected by Sashiko, when reviewing the
first patch in this series.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824103816.40040-1-ast%40fiberby.net
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index ab677801cde8..61ebb9a2bad5 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -496,6 +496,8 @@ definitions:
         name: accept-untracked-na
       -
         name: accept-ra-min-lft
+      -
+        name: force-forwarding
   -
     name: ifla-icmp6-stats
     enum-name:
-- 
2.55.0

