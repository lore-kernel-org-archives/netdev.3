Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8403BBFB4
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549283; cv=none; b=VsQaHad9UpEXPZUpQ5+0NzUZoWJEE0kxWZKbG3By70M57IhBiwHoqn4nSU99rgr7mI04Ca8T8xJKii+5oh9F2HJkZdoyS5CrFb/GlNTaFuN5nlkNHMJPzvxaFPRcFrmUHGfTmBRrxiu5XXiYNWksppFrAsjPMHYYp0n1eCc1LEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549283; c=relaxed/simple;
	bh=8QPT7tVCW2vifRwIwEdAbjqcq6EuBgD6GGA5TZCBK6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoXlrohJwnImG6uskXGdxDuZoAhCAd28NuKuMZSslJMz5EqMXO1qafQjpSjVHjomejdeUOwid/jQ3LXmxiQHzj90lMAj/7znW9WEp4YTDFU/UgAnjZq2m199LPLgAxPaGCT9UbF4AXshZvGbPTDOtvs9eJiUYFxhxS2RUdlJn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ92asBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ92asBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9588E1F00A3D;
	Fri,  4 Sep 2026 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549277;
	bh=5gur8ifhE43bsqlC5mEaGFU3hZJvN9uCf94rNuzNwRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZ92asBCUhUCtYBYjo+b0ciC/sGC3USDXJSaUrgb0F+cEmtCIXyQo3JUaPGaQWLM9
	 8qqLC4w2xjpCXUJHRzdx0G4BH853RauQU8Hn5xXPZmsQHjAF3EPdEbPP31a9QY2GTH
	 dYOc5hXMtT5WF9lLKyqApQUC/lSzPYBIZ3j3HofHIuSIyalPcyYke/MKz7PJPorlNL
	 RC0eMzJ/lhz4SXGrchTiAmINgFnF1cXH/BNVpRsjkbVsXvetAcfP+4xsW6P1qmoELc
	 MejH3cPEopsp9m498tjr2jFn7FdCg8+U8DTjslDV9SIBRisfypO5eoeNrQ62aQvvwd
	 ZS/rPMgJ1NjcA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] netlink: specs: fou: add af to the shared attribute list
Date: Fri,  4 Sep 2026 12:14:10 -0700
Message-ID: <20260904191412.3872344-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904191412.3872344-1-kuba@kernel.org>
References: <20260904191412.3872344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_nl_config() is the only place the address family is chosen: it
defaults cfg->udp_config.family to AF_INET and only switches to
AF_INET6 when FOU_ATTR_AF is present. The &all_attrs anchor - the add
request, and the get do and dump reply - does not list af, so a ynl
generated client has no fou_add_req_set_af() and can never create an
IPv6 FOU port; the local-v6 / peer-v6 attributes it does list are read
by nothing. On the reply side fou_fill_info() puts FOU_ATTR_AF
unconditionally, and struct fou_get_rsp has no member for it.

kernel-policy is global, so fou_nl_ops[] carries no per-op attribute
list and af is already in fou_nl_policy through &select_attrs - only
the user space codegen and the rendered docs change, ynl-regen.sh
produces no diff.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/fou.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 331f1b342b3a..32d34be1dc63 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -90,6 +90,7 @@ kernel-policy: global
         request: &all_attrs
           attributes:
             - port
+            - af
             - ipproto
             - type
             - remcsum-nopartial
-- 
2.55.0

