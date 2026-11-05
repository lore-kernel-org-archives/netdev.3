Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883018;
	b=NksaVmZFDYj7sS3xg96s/O8apQOJV7ah7ZpE/9Cr0GBqcP0pv1YWysn4vYwUa6L2wxag
	 z/O52jFMSzuvghPR3gl97cuVAEl2LBpKVGdJ8zrrhzAvZ/ii8fxDacw00T7Yj0paCe5j+
	 nyzB/adQ6YnmPDje7Y9TIomA2MjruWtYXUVe6Z+2c5qW8I7orzMiUKQBPgJhUVJbpXMZQ
	 PXf4BXcx8IepneYWU2s7Kb1D7yYS/sapzqC3BlhcPjfdjGYjG87vGE+gPd29fkb+SSU6/
	 PtgqWTQlu4agi2SCJ/pXaRV7KybodAHDJX46WUbiw+DOd8WNB4NADsqveUw62RdeGIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RdyiRLv7e1N7dBqCXNkMCcJEXQWJI7RZIXVTawyjL7E=;
	b=GB1GWTdklmQPQjFWFHXwtXlHxQUgmdyK/oQiLlZh7mC1VdzgzoRNew1/EcrA1WE0H40s
	 JNw8hLqteIQt83uedD7GLUJpnTPMQM7/X/PJCsXB3XQww0i8S4hOp1RzICUnjyqzCUHIT
	 Z4vmen4ZDTaOmvWZPLJcZ/Sr7BaOMlie0Cvk+qkfvnYLMokenhYJFiwyrqxUdNIt8qPtV
	 optGCGqK2qgZBFa3R3DCVwHc44Sowwmjfn57IT/dixIJPcH7m6XBhckoTFkTj8zLlBZiW
	 EQ1rFBCqsk7TMsPgtEcjR5XeZmsnJlfbpj6nUrAkn4S41oD6/IpI+StGEJlNn5Qx52w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Ct4lTTvn;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A895606D820
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A895606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Ct4lTTvn
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a315ed211so727686eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883018; x=1794487818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdyiRLv7e1N7dBqCXNkMCcJEXQWJI7RZIXVTawyjL7E=;
        b=Ct4lTTvnmx+AhocEeH92uMHCCd5cp/yt3zz94xDx4WFdFEW2po1ZlJAWgUoVTj10xW
         IjoywvAejIzq3vQ81pw5FviPJaJ4loJ7sZeMfN4StXhLJ28zCvL3Wf6Y356LMHV0kFEI
         zaamoC+fpt9gnkpw12cGDCLI66Ha1Oc500Xix3tecIJAEERAwgfHFPAVu3V4txQYJkr/
         fbVpp5mjfTlMyYEM1xxCawiiPTgFJ1LSk+j24PpRVL8f8+AlgRKZcH04ykvjrWF0V4c4
         DtOHcUBBSAcCODEEt/xJqghpxeApjA/VmAWUJNzvmWTr9ATN26fcIhZVfMNAksQCN6hQ
         sv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883018; x=1794487818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RdyiRLv7e1N7dBqCXNkMCcJEXQWJI7RZIXVTawyjL7E=;
        b=b4cR4RObL258PhMSNy3NG8JKgMVor1OA21GHerkm3+mD8OJ+rOUva3JYwvdKBoFb8+
         JHtJt9br1zX/POSDS0vn8R5Cl96LknVKlQm/t0m6uoFoU9TVEBhNvm+hcUOMeXYe2fOS
         pKNrQDq2Mfphf6/RLx3ZVdFdr3l8ETMeab1JAtkiO+Be4jnfLx9iXSXTIC9y2WxlCBLg
         w0s2LSgPHFMzynDK3plyWjbHDU24XxSrQyaDBKPQYxDCe2YuxvYV3Rdev6CAQ5qRjjiA
         6csIiSbcmNIIVsbnBDGgqiIWp1+RUODaYhX2PlaiFKAcsJRRyHe9kV/k0bWJG7NRmUSv
         Wb2A==
X-Gm-Message-State: APuU4Z/BqeYTABF1Q/LdL3cRnvh2TlYdQz30zLfI8Ns8mm4+AIneDeYR
	QZH1ONjxhOWt+Icab0bmxaj89zVxr/NDC4KpH++RhVxYrLP+/25TMLPkWRldZeDOGJE=
X-Gm-Gg: AYBFou1UnOh4i+0C63Ha7Y6/HLsNvRnRTVJ1gZwMu2WOjz3m8lM3voMa1BkO8oM/P8t
	Nwd1veU9dw9dhkqWUZmdgETPsUMOSuJJXoleTr4ci3LYI8ra1G12EUHvbQQyap8oVI3YYAZcfHr
	CWfwBsj0fmQcouF7Hg103RSDoqOcYHc5z1MVVJRk0Kk3eNh1OMveriFTU0b64HnSChfp+QK28Rp
	T+yzoh5yFfbARX4Wm7q0aj2F9kA9CISSR0CHrLjpi6/mtUHSP2Tp2N5ajEuPakw9A/ymoHxAvtX
	ybWCWa7z0kO5zWdepTfZ9sB6RXRXx1YL89uleuuDgav5heqsccNzfUuOvL4zLTbIZeexHhWy1S1
	b/OmRp5TX2ia4xM1cXC9Zlr27fEAope+jgpYkwZLb3uSRiHYhA6bsG/6SUs3mHNPQebiD8aZUJ1
	tmIULwLWr3rfBiNuBWmuQtUCsSB42kUJKRT04kNAlFaoawvnwHwkM2W2CgbBmBTf1FmVzu4KK3K
	YMJJ0q8awUtjnfhiy6tVhznS5zVpfQG+eapYHCPQi4IhWkj2k5n6cTrGR7at82KvkfdZ69hC/Fj
	6zWp6/PG+xmcoo0WHgj4vUhUCrnS9ZaPDD2trpoPLXGiXtnrgwrTO1NjmoSqZ78oW+/e06Y=
X-Received: by 2002:a05:7300:8a99:b0:36d:dcdb:70c5 with SMTP id 5a478bee46e88-36de713aa2cmr3426944eec.20.1793883017458;
        Thu, 05 Nov 2026 04:50:17 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:16 -0800 (PST)
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
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 3/5] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Thu,  5 Nov 2026 12:50:08 +0000
Message-ID: <20261105125010.1107546-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125010.1107546-1-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
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
index dacfd5524..68f08f5f6 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3307,9 +3307,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
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
2.47.3

