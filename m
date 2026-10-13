Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E67530DEF
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914063; cv=none; b=jvJzFneKyRd6qS+D+Wi3adsYhpfPziM5ICwvWryjz6J4nqDloGCoHHJQnlzzK/TeL+QCESizy/JTohzLRWmnpBh1scAz0oqTDq11ANGpZyeIypbgvW1mV9c6C2LarvcFDCPsznm4/IfPs/8iAsPcBPSZCU0ROp6BjE73r6k6yWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914063; c=relaxed/simple;
	bh=P/a8Mvl764NSz7iF4abK1Cz9izZjaQxlZybxUGojouA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed+s3K6AtQZ46ngSD+67YvPE2xayIVQv7Q6E+cCPrfKRv1a+ljInFwHE2sn/4RxD/eXY+alvUQ4L4P5I5lV7EaQdZtNaT7yZmRTP8EM9vXq/vSlEBnuBzoW3JJQSlmlZkiXCS7Ahmq5ka+vKlBak+0gogcWwKv6YQUrD/+bUJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=QWP2LWEV; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="QWP2LWEV"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35834f72d94so5852171eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791914060; x=1792518860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5Ro1Z81q5awGttuyy3gvfhLZByumBAvxg5zmNNwGEA=;
        b=QWP2LWEVY+R7xsJpGcMBwWZZz4X9ggKN0Nhq2ThN1L+P6R9AhjBcDqzwz6DO+kA3DE
         jwd9fYOEovs2Iy8hJ5vR5mOIhi/L0lo7AcgUHAipIhF/R/DbPPDeKyC/GMsR/bwCAv3H
         slXmzJjsdIcm7xm6Pqy8ZeMDRs9Ig38OjKbGR6uHbXlnUyxvHumP0ME98gMYGz3jNJuY
         ORloNsndCBapK0k6zc6qhEEBuPleBsVu7hnSOKrOoo8odaj3k50PvauAuZkyTTvHQHKM
         fVLewsTolWZIQnpoB9jGFsTnE9k7mJs+oWiAqDEXP+pS8D6xwobw+8fNJWKJudZOrqR9
         pupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914060; x=1792518860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n5Ro1Z81q5awGttuyy3gvfhLZByumBAvxg5zmNNwGEA=;
        b=EFoktXMHFU6nGEypMcvTgfzqr5mtO2QUMbVotpqC2yWveIslDHGwL5IEzZjzh1c8OR
         QO996QtK81quR/mYDf4MqaqxpjuYM5yb7WXrLmKVu07h4yHzuPDvJ450z5XDyOhFna2q
         yiSPBymaF2dtOqK285Mg+49ZpK9C7sxdEbjdlDGaKvVOxbbxbTk7UpFmtuA9OlwFmT/r
         6VU/pNZkxV3hTMEfcwyg0jQd5RIQK7VWM3pEQGSdNo0d4OzPZRa5QP+VTTJdnOO67lhE
         kmi8YfMpUuIR72cVA7SoQpzUAYbZd/yRmFMG7tm+rmdUxEz74h0mtm630tiPgc//eymI
         Ncig==
X-Gm-Message-State: AFq9FYIoHR//g2ljrbljX94hKFfmXpNvDc6vvTUhZe/fDLm5iZkLUySZ
	FbzIGJYbXLgHY1lljlmG0/Iua8awC3CmU674oNOGE/LyI2B3Ern7ulaKQTARFCsUbu4=
X-Gm-Gg: AYBFou37U+ENGPgnmFN4cw7jES8kf8SnDZgC+CB7LKmpP1fdA6XrTxZ1d82qkVtjxeo
	+PsNyrNKQplAxoqFxEP88s/qGd7lzgL4ML12kNO3ll4ckmZJuRlpqYO5xWh8FQS3pmOYNY+br45
	pLLXyVVoGP1au2HHvaoPdsiTXecq2+Ce3CG6MarCzh6GQeWo0FSqqxyPKZJpoU8brlddfhuNFDf
	oCuJpL1nzQGNxgdMa0hPPXvBEvsxNYLZd/okp10jhI4yUoIj96+EwU93XsMnKnR7+H3St3ElS/M
	pfqwM6gVWOtSYEMSt64jUiBbHdGKX2syrshWP93juAGQj25V6FAdmF3wdPgCAgqGqvWI97esMUW
	POQKdVYVvL8fK/XQcP+8G6OFvTXFHU103g11BwQH/123l0EiB/71fsjz2/AljSOPkY9EUpyvNnm
	+2zMZHFLlE6rkKomcVqnxqio4FlrNiqe2OOLP1ECUKj6onIfy0/LHVyLamU6tVl62DtIApYMGtk
	gEvhVizX6DX6jsv2q1t2r8HZAAcZkUUwCHFp4lgzTL+K+1rumhv7e7QQV13lzdyiv9VLqlJVPw=
X-Received: by 2002:a05:7300:22de:b0:351:595f:a941 with SMTP id 5a478bee46e88-3537df5139dmr20334948eec.8.1791914060289;
        Tue, 13 Oct 2026 10:54:20 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm50183362eec.17.2026.10.13.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:54:19 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 3/5] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Tue, 13 Oct 2026 17:54:05 +0000
Message-ID: <20261013175407.947606-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013175407.947606-1-omar@blockcast.net>
References: <20261013175407.947606-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netlink policy for IFLA_AMT_LOCAL_IP and IFLA_AMT_DISCOVERY_IP is an
untyped entry with .len set to the size of an IPv4 address, which netlink
validation treats as a minimum length only.  Any longer payload passes,
and nla_get_in_addr() then reads just its first four bytes: an iproute2
that puts a 16-byte IPv6 literal in one of these IPv4 attributes turns
"2001:db8::" into 32.1.13.184, and the device is created with an address
the user never asked for.

Use NLA_POLICY_EXACT_LEN(sizeof(__be32)) for both, so every payload that
is not exactly four bytes long is refused with a standard extack instead
of being truncated.  The range check this expands to fails the attribute
even under the liberal parsing rtnetlink applies to IFLA_INFO_DATA.
amt_get_size() and amt_fill_info() already emit exactly four bytes for
these attributes.  IFLA_AMT_REMOTE_IP is only ever reported, never read
from a request, so it is left unchanged.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index e9b1a45..e466cf8 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3201,9 +3201,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_RELAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_GATEWAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_LINK]		= { .type = NLA_U32 },
-	[IFLA_AMT_LOCAL_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_LOCAL_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_REMOTE_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
-	[IFLA_AMT_DISCOVERY_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_DISCOVERY_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
 };
 
