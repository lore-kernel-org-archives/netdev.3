Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455965;
	b=tl2Az42cWES92BYcynzQdWLYFtIHQFrSgsb/vewNs0S6uN04mMMV+y2eQYrkb0j3ZOnT
	 eWaYBiFjqZFnwulxxa4M8UiZ/t9sNfP0JpU1uJEYN9axbyQFnWHeQCqds4edcDAdIAyej
	 cVhxYPC6fjRmKj8lRS2gxNryru8IMXfcqRhhFzrgyfPMlVnlHp9pIkdXlkw4qjVVhK54o
	 BBgMEdNeI0Yv2kIWUIB/+J/rIw7jO2+Cubz1sXMLrCUWCD8aKd/9TmPPIiitY71qgjMzg
	 NUZXskhsEQ58WluzA7NKVJnNJuYDN2AEE1Dm+jKcz9KxC8MisWMdI8ve77PoMcufaWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a5q3lkHcSL+HrNegIAKI6k5+0KqgQFhtqH1AxUHFIJM=;
	b=aYz9rH7t+MiNPI1e/U9Od3JqD/+VpAIg8Jrws8eGJUnjScJHuHxYoHpE9qxWeNAEkr7W
	 9SFG3pnYb+OxDnW2SvZjuFYF+eSloazgJ0BSpVxRbzta6bJPxgNabb5eSGNlK/xifwkXD
	 9F+OwxFFf0SGjDCjiRak1q8rtu3jCNCY5iTWew9CMQh8uEMAqYk7/o4x5Pr7s4DRaUOrC
	 LX4I0nEYCz2DB/9HaIV/OMxWEk+bRIbBPnzVMAxVbuXE/y1eJAqOvKa9k8aAV7FlpfBwK
	 d8NilwVoKWWPWFPc/W1/uYiOjG4rbY5JtHNrxJWfJhtTncMZqS3yS7sirE7ZBxp/UpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=KO1GSmGP;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C5606A33A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 012C5606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=KO1GSmGP
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so4567622eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792455964; x=1793060764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5q3lkHcSL+HrNegIAKI6k5+0KqgQFhtqH1AxUHFIJM=;
        b=KO1GSmGPVO/Khh+Zk4RgGmkxvoqvUXRT/JWUf0FnmLdh8y4GAF1lLpwfjFFOb+rdFZ
         f3Ypf3hejXtFM/hAEuUNo3fXtZtbQEEfn2wDPFWr6YgdJRwh8tkFXzqJDKqD8iUl/k45
         lkg/HnfnW4DOoeiu192dIzxPVoGSFxRWGZ0uSmKQxjuAakgM0xrucQyiUNCcpPLDiWdS
         nXzqIRSJefNRF0kIPEDS57wt4ZEUMwpTUIdtdchhXDrVcVusmjJCsK2zqbNJfnN8b6oW
         mjamY6bHej2o5OnZTx5qtXBblbjyh8HSrEMm2C+fy0TopRuMJfArp6COVOhvUR9hTNSv
         +/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455964; x=1793060764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5q3lkHcSL+HrNegIAKI6k5+0KqgQFhtqH1AxUHFIJM=;
        b=n3dD9g6OUe2W/AHt/TzNNgAD7UmobSaNEOK+Zf6eGndPe+R4CXYFf7KnYfHUWd7BEE
         g5rUQi7YGwy9kdhqLSk0/Rh0Dh4eEA+GGEAj2vSkKMN35KOzSQsaRu7C4P2uh5JA860P
         nrOb+eA+I4IcGgKfVRMy5vCemyFaKb+/eGaRzQJiD2k0CBNWC5oKj/YptDAne2BWjcWr
         thnaKzQVu6XEIJL+mygMzwD0Pbjos3f6f4tbWK2DqMr4cme/A0SNo84cS4KIvISrpvjz
         hh9iR8iRMaamCkPpyb6qC/rM4CG9VCWHE3BNlVmsOFaKuXiM8REZx4Eow7F+M2ZI3HGF
         WRig==
X-Gm-Message-State: AFq9FYJlI8U1r4gMYyMUYtP/w3Xiu9BdMMpiCqXSj7oOLBq7PeCT35/O
	zmF7B1HPIYKM9np/+NFsoCR7Pt6ri19qAcuqJ4QyuDSqfjK8QlIxZJnNkhs2I/c8aoM=
X-Gm-Gg: AYBFou3OiTemz6PI0kKoUipSNkSHtV4lfqBNMrjKedrz83r8E/0UaKwh/OpEcK2NpCB
	0g3Xki+d5HVr+wpegiBZ9IvMWwkfAVYxeoRHG5BcVU4CEKARqU+RbQsV+h2MWTLR0nhDmVuBFlz
	iYnndEBwPzR0R7SJKjVLhGAxJdbZAAvGmXDMHaUS84m/jPHGY6J1K3Ql2fVNnu2XKoUSpvh1SUS
	eqq2AKpQsP75v0yrRRzhpC4Ex+7sViM1QT3I0EVI6m/r74AAoT+sekaMPJnNS7AJM5aKCJZt8qx
	VIHn8ughOTY8TFcyjjf43mbCG+C2tTWO1Bq1tRt2nSnlOHEVLw00qXo1lFhbGtlUxazxIxcRAD0
	b4koZavVPorR9nevlWpP0XtSo2K6kEbYnyY0dcRutLQd7Myf/jKxuNslzo+3L+rYjukcKqG/wj2
	NXz1MQkB0Aooghf+KbDLq4qG1/hwyv7I2n0JBaCj/Lz4uoBXHQOojW17luKAjo6k4jlHs/nqnpH
	nmHp3Uo3n2/RAynrT79NbleogWvhKLqSvvo0H6Zak5EthuBaeA/MPvLd2V8hwfwc+eR068/mWA=
X-Received: by 2002:a05:7301:424a:b0:35b:a6b8:482b with SMTP id 5a478bee46e88-361a1f50600mr12221732eec.14.1792455964090;
        Mon, 19 Oct 2026 17:26:04 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm44748072eec.20.2026.10.19.17.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:26:03 -0700 (PDT)
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
Date: Tue, 20 Oct 2026 00:25:55 +0000
Message-ID: <20261020002557.3984927-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020002557.3984927-1-omar@blockcast.net>
References: <20261020002557.3984927-1-omar@blockcast.net>
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

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
---
 drivers/net/amt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index c19e67a..960a08d 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3298,9 +3298,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
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
 
