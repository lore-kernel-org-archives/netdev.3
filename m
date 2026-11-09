Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211421;
	b=luUMdGEDoH/nTxLnEkecw+sq+HlQqSr/l+dA8tv+CAcxlasihgXL/RvYRt3+ONNtx/mG
	 yD4HsXD/S2h+n2fDqmkc2TgidxvsMhdqUCFM93OQ2eYRqXGtPN+wrG/7r/qVPSx4VIyr8
	 +6ITVywmCuszwZ0C4gjofb8+gAD3i9DnxhuBm1cgjlRTo16TzPLDuXstKn+ajqlS36zrQ
	 hKBV21t2D/X/mQYXct69lpE1qTalz5K/5/IA+m05xkiJdPQKnoMROcQ9bU+1BDKv1Ehnd
	 YOWyWV/5xjQBetzmhaAi3i+aKanVvh8BTtZrL/oC9iPJzpc3xd716EtLVWa5n1grclg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211421;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W/ttMtoB/i97cNWzp1xf30hYT65os9u+uzSKFW1eAPQ=;
	b=ve0qPGqzzdY6jaJ4uHTSRy8wcEDmBekQ+5eChMiY+ag3loQBlshC0Xqaeq8r08n6kH7P
	 joNNX08BGGhF1ROaFvJVxJCl4q2yLogwRYelckrXNnhgz85aLpTYiH8pMfsYkM2dwaMK1
	 JLq82XyxQtsCEAldMjqB/oTfcZUcjzclQYHlZVOUKa7U9kGuOaWzL7N0t90YQQDgA3laq
	 GhhgRFnXB0WpjFxepOMI9YZW8yu5/A4PNnQTnPB2qebXVl0Pg6jC3+d1vy1OEiku44GE4
	 Gt+ZOySGNDZCiNltueVVCpWDKeGPkuNhbUojVfNdz1nitjt4cglGkBdfRJvr9MP3d2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=JNBL1KwR;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0781606EE89;
	Mon,  9 Nov 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0781606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=JNBL1KwR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=W/ttMtoB/i97cNWzp1xf30hYT65os9u+uzSKFW1eAPQ=;
	h=From:Message-ID:From;
	b=JNBL1KwR34FvPKixpeJ1ZDwmSQtdvROeZPB8Q6Es0Hj/hx+WVBi3oTyl5lJfZX26p
	 0dRozZ7DXv5r+UqeLDMvOF7GE1y7ArmiTZrpkoijiib+bsGLPe66pIOlcrQ6H1WtCy
	 kRWBq58au3cqFqEYk6x6Hsd2uchmii21cyQ3sEqI=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 26174C095D;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 11/14] docs: security-bugs: explain why directly sent reports add extra work
Date: Mon,  9 Nov 2026 09:02:37 +0100
Message-ID: <20261109080240.29444-12-w@1wt.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261109080240.29444-1-w@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many reporters imagine that contacting a maintainer directly will bring
their report a special attention but it's exactly the opposite because
it breaks the normal workflow, and deprives the maintainer from their
usual tools (CI, reviews etc), and even requires extra care (e.g. use
separate branches, avoid CCing stable etc). Let's just explain this
upfront so that reporters understand that there is a reason for everyone
insisting on public posts.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 280f7f3a94603..69dbc47f54625 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -15,7 +15,14 @@ It is important that most bugs are handled publicly so as to involve the widest
 possible audience and find the best solution.  By nature, bugs that are handled
 in closed discussions between a small set of participants are less likely to
 produce the best possible fix (e.g., risk of missing valid use cases, limited
-testing abilities).
+testing abilities). In addition, dealing with private discussions on patches
+adds much more burden to maintainers who cannot follow their usual process nor
+benefit from their usual tools. For example, many subsystems have CI jobs
+running on publicly posted patches and will not merge a fix before it has been
+validated, and automated review tools such as Sashiko review patches posted to
+the lists. Since the fix will have to be posted publicly anyway, sending it
+privately first only delays it by the time needed to ask for it to be reposted
+publicly, adds extra work, and loses the benefit of early reviews.
 
 It turns out that the majority of the bugs reported via the security team are
 just regular bugs that have been improperly qualified as security bugs due to
-- 
2.52.0

