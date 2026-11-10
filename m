Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344750;
	b=xTgc2KU3+gOedNEcp2o7+Gr2wWnXeu1PnQTXX3XkiHn3IpXFuaZD4OQyLWMyEgyw5+8w
	 Oz0vgcoujz8GxjwViCgR+l+6vMp2l63Ud22XtZOERGzY1ui+5jt9wXwfO+pQag3b1ODWN
	 DSG/4YMRZooUENkWFsd3DNMgdPn3yJ6FxjcKUKOaekRaM8KwDQlS9OpS4VChbGZQGj/do
	 VvQhPV0NInVqFF2HpXvWdlPPXqZL7jcz0pBHnRALwYmXk+GJfLH0uO658nJjGZfM80SEo
	 Yr/XCsqQzE01hTz/WK3ux8S9PY6B2L1tVCuWOmsa2lRuToGSBKt8zWKo4/Xl9Fpy4qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SwDFBgR9w23+8ieHzLTaA/3ovrrRYj8PAKqMDU75z7s=;
	b=WNbZrHYMWYr7obv+4kd2RScacXqu+/A+HrH1JoDOQvSElEUdxVJkgJd9qxq5L7i4jAWo
	 ylq85m8ax/3VHhwkr5Vt63YO0aSeQMZC99h9pvzSCR5oPJS2Nng5BxtSVhB3Hya68mx+W
	 zxsTRYrns0cgdu4M3fcXrI0Z6M7zQ/BNvCSDdEw2Mey9peDARwiJAP4EjNXU597t+rKgd
	 N0aR+gZae26GJoEraqsMo/IvRrTWYp6aSWNsLJ4x+lMGScSg6meX2wk5dpzniDD3MlM8D
	 yefMQmw1W9DcY346x3o5sFzUkMY0Tm5bMPhcm8pIYCYl4l3T2QgcasuoDpR/dbSbQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=D1tAHKC0;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE560A3815
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCE560A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=D1tAHKC0
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3894949eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344750; x=1794949550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwDFBgR9w23+8ieHzLTaA/3ovrrRYj8PAKqMDU75z7s=;
        b=D1tAHKC0IcpfnRlj4facq07tJjrhPLEI/8rjFvl1KzNFp3NFZzD7+WePtJUnYgNZSO
         TOvSs9VZK+UmO+bjlMUvF0c0rekZopBBqqUcLY3QB4aKelc1LL+3MmqMCBGejq29ojkY
         sgBHsy2qUnBbAwVIgIAdfv5C2sVtEgsbTbRjPk6WrI3fXxzxiT94dRkyxoHVHXxW0eF8
         S+RAQ5OUwvyZDDUzgsTR3poDerIz3JKIEyOgQRA1ac4x5SKiUvOCHVCUERiC5EtbCdQd
         i0B6I8JUHzjcYw9nguEPeP5sdj6elAoHX52F1194oYL8hR+i1S6q4AszYQbzxyh7dUV4
         o5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344750; x=1794949550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SwDFBgR9w23+8ieHzLTaA/3ovrrRYj8PAKqMDU75z7s=;
        b=ID9duIjZEtqx5dl95c8qGidkziLrkNIOUWNbaRzdynou/OO6Ay9MyHT1hmGBhsCasg
         lsynkfFr4e655JFtQYjEnF5139UD4oy6MGu9ovz0jSrNtWsHlM0nBAabe5UkeDe8jycy
         INEGiX5OmAzuu1pZ7oCcwFkwB74yI2JMeB1FNKY9uaC2KAb0kxJdp/u3ktX4Jawhmkfk
         SwUFoeShe0YpJ9x3WoxnPxucGxUbvEE2z+mDC2yuD+cblhA1bzsvUaCKT3/Ba9bHpQpn
         AKl8fc2q1+wtmpYIdGYdEwP7+IJ15InTbmkQOjh8jrzG+6vLeJnHoD8pfAk8ssUp/l8O
         dE6Q==
X-Gm-Message-State: APuU4Z8CpZwC6waecpxCj37PjtuHo2SGZZ6Fyk/P7hr+4C8ERLc6wt9E
	Hr3PIp0qOcp+gvzo4nhqo/pfbvyLloooS7XA9bqRwaC98Q/sweD765bXYqjicbnKUO0=
X-Gm-Gg: AYBFou2DxONY3XO7OaFaF7Ehj7KJu2l7aJ+R/M3js5IXjsuYFFJgkKTATVvJGzJcARh
	FR4CI6y07ijqWvTcGXboucHRfh51MMks1FkMLmv97jG0rAfryJ9I2pUsvju59ugBv1S7SQlQffh
	+klLwwVZ9WXT5Jjy+rC3Thc0OrUUyOYotiZesHpnn+0Nn64zzm0ptkSuSzi2JXAy4U6AeGI66/T
	QuQSUgY/LcJpNvbHyVFi2oRB3zkR8OUyI0Kht6hRq+a8sfBGMCVDmp2VMXL6qOvDIBURGc0CcrF
	Tg9yXhu/Olot9uGrnkoUWK1HluZWzivKWcjDSfKPNUBUnKsQcGERs0elP+YJBVLnI5o9iOl752m
	LL6Eep2MsEE7udd37XQV4/4fIriDNNC9RJvdpmJTw9/NUbHscvAO0hKULxIFnc4Kg1XzYkJoLft
	w0q7D9v/EXz714FMKSXT1B0cB37CNxhwdpPXmPq41u5wVNmLw0RMZrXNZzGzl8s7nrLOoM6mJsu
	Nlcoc9EHC356CLMH+QnJHLTguJ4l8J+4hgvbsjnQjUdnrXXX1gh2tOIbY6EMfNtEFl5IRmd0hTB
	mgpat9jRF2x3iZQBOijmn4FunpFKAFLyfdhNugJlBOIM1TJBv3+kiq2gPbNUpjPmVcjzSF8=
X-Received: by 2002:a05:7301:5f01:b0:369:fbc1:89c2 with SMTP id 5a478bee46e88-37685a89f74mr970768eec.8.1794344749231;
        Tue, 10 Nov 2026 13:05:49 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:48 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net v7 4/6] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Tue, 10 Nov 2026 21:05:35 +0000
Message-ID: <20261110210538.217936-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110210538.217936-1-omar@blockcast.net>
References: <20261110210538.217936-1-omar@blockcast.net>
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

Triggered while writing a selftest for the AMT IPv6 outer transport:
an iproute2 without the IPv6 attributes put all 16 bytes of
"discovery 2001:db8:a::2" into IFLA_AMT_DISCOVERY_IP. On a stock
kernel the command exited 0 with no error or warning, and the device
came up as an IPv4 gateway with discovery address 32.1.13.184, the
first four bytes. There is no oops or trace; the symptom is the
silently wrong address, which fooled the selftest's capability probe.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 9f59ec6c4..99cce0a14 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3359,9 +3359,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
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
 
-- 
2.43.0

