Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C13AB496;
	Thu, 10 Sep 2026 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078790; cv=none; b=cydGsiMfm9aRxpDQoz+M53CoqKpFWcDoIVdeoEvF95tTr6qIas9qvnSiDhne2bB3o31cgA7lT7sjxnME/dwtrwJpw4wDywunGqLbBPkAW9Z3rvTO48NRiSfSc8zSyhrX/YFiJRM2Md7Nuzpda73ii7NiMMS5mTKeUwLM9h9yL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078790; c=relaxed/simple;
	bh=wfwCmT8DoKSSUntYp3RrEFWgEP9KlheUfTkbMuIxZTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdUXxI2tQMZZJ9bAoeHcPge3m+JFpme5NSLa8eajYRrY5yoo322dvGuhhFgXVNMP0FQ6eL0LrIUpqsWT3iF2eDVQ9DcE3WKVwrRe5sGDXYmggpxesN7AcznEIz+DGNChESqHIb+P7YHa7T06mYh1ovlP643NeAnaisvitUHUNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=tJDpaA3F; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="tJDpaA3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=wfwCmT8DoKSSUntYp3RrEFWgEP9KlheUfTkbMuIxZTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJDpaA3FkllyflGf/hu3IkoNB/2VeUyZAhg0cua1z3wUA6a6ZXU1ddTZO7jfN4VID
	 GWlueKfdUTwTXt4I8CWYF6XXhLhRl1k/Az8PAJrctPCSrvIa8WOaUE4XWuSe3UXIH+
	 ElgW5Oflk7qBqmYF8zQtPtjfDnrLc/33cvLrxDNN23JDBXmpg+irMprSxlK6cRQIdu
	 oVkYrU+fi6QAcAo/92MsGV19t3SE7ueE2SOuNCYCL07c48JL1S3cysLIytSZscdEf/
	 lqZoAqcUTMJBSYA9QJ7ONckPhhvDSL/VIGcH6cPzikbf5kSDXJBUmWPi0vjcrvJ9K/
	 u4F0hZs9h9Q2Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3F2B260107;
	Thu, 10 Sep 2026 22:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id DCAEE2025B6; Thu, 10 Sep 2026 22:17:39 +0000 (UTC)
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
Subject: [RFC PATCH net-next 8/8] netlink: specs: rt-link: fix netkit-policy names
Date: Thu, 10 Sep 2026 22:17:28 +0000
Message-ID: <20260910221733.1021864-9-ast@fiberby.net>
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
index 6639b7f5677b..fe52d508d607 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -827,10 +827,10 @@ definitions:
     name-prefix: netkit-
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

