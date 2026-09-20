Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E853D9DD4
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883245; cv=none; b=vCxamy3XZR3tLSg18FNZiajyt1ybEqv/1b6DMZvY8Om6SED7l3sTbREf0cQz1fxFCmxA4V97CJ8tCxuNMZNmJgjVNCm7dbd84Vg25J4p6F2ZpNgfjCs+l68tLvPW6jdI/T7RmaTZ7Y5RB7lWUD1FBrw/VM4GIFSrKUHBy49YXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883245; c=relaxed/simple;
	bh=vGxo+U1sJMCVsq3sDI08zPDza2WpfMA+ZZBuxg0Rgp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM1UvQMj2qE6oWX8ryB5+NSZbX1D6ENWVyBIAqheHt4HOk/gRYBlMR0Wi0d5oAIbiTT9or+Tcrqo24C3Ftx5G4W+3YV4E9BR+C05dazWmaOcMG1c2ml1HSj+H99vlrT7aGq+V9KWJVmy808RoIirf3Q3dkunsoZVzlj7s7N633U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEQulDE3; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEQulDE3"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a805351f5eso162736137.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789883243; x=1790488043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xdh7oWEQ9m8Qy+E3UVjKRIovBOhuQDCeQrchOYtk/I=;
        b=TEQulDE3nl8kiz1wCPMXCgEJbUO+jVTyndy00etcWmK+1D3JdkS8dv3/IvjMzs3lfY
         VtkEiGed3v/fAZ5gLLH5ggs6wtZGQiVPFCf9H9QDczWG4lL/1fIIB5Hpe8SFi/Lq96fs
         JLmz1FKG8Gv88sRHjiWSUiErOmw3ABuS+ExW4v0rC6NojLc/4nK9DJlNDuJJKsjzGePD
         0duUl17ynITUWEZ7jm2jkw6u3pirvUiQ2x+D4Nbimr8rX5FhZ/cCvjjjq5JoCkH/fyfV
         wEvC/uhsHgsxpGVxk5jYYNVRtBo5EFxHd9CTPx29iW/IUkXFC65TrVpkJVh43tsMg1jw
         loUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789883243; x=1790488043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xdh7oWEQ9m8Qy+E3UVjKRIovBOhuQDCeQrchOYtk/I=;
        b=HXfcmZ6nciXnPPYY5IbSU3e3FXQgtMYAAWWXgjLFtMdFBXX0V9Ato/iSU1Fv5iCpy8
         bOxf0qK4fAWGTPCsEBzQK86KB51brKuT7l5RrM2IU6QFgm8C3Rvf0zFAAI50bOoqTw/X
         P7uqsmzACatPIqQGVlrmkGM+oq5RrBiXBgILKOyXV6lZs5WodaaLyLncRAtZj1z7sbhJ
         dlreYo/0oSoEws7WwHVsZpxYpBXahg35SB4mpgTx75q2YSVFpgvelE0Jc8Rxalcuxkai
         WPngYzuznfKMjyOrl2fPcY6ChWlTd4Sxv2GpqMcyRgsZR8ITPq4S1puo184iFmY0gPgd
         HX7g==
X-Forwarded-Encrypted: i=1; AKwUvBz//lzbkGBM+aerBgfwaMHJ2yVLB/m8Q31SLdX/EsUjrPBas8WbFgTWneyas5Ru5yAgn/lfGUk=@vger.kernel.org
X-Gm-Message-State: AFuF++nyfhi52/vwYaoMH/IePD1GjN4l6tC504bN7i3WYncZaq8Sgoiu
	mLAi1N61d3io34LichxgsZpGPeshCzdcdTl+NTD1tUwwYRYVOppVENEz
X-Gm-Gg: AYBFou1VFbfpIYPKL6XPXLfHR80PRyvs5wj/IQhoFSZq1ODYjD9Gn5APfknWeS2PU8c
	ytP2KhtUNortF9u1PUbos6xcrkzEF3h06FvZnNjLYtRTAoQpm4GScma5gbj6x47IO4CUsslaPMD
	iDVoBmqmblJab+S0/lOaAdIup60UmAYuqM0QTBKRIMBiGvYPdXqhc/Cso0pz+n649PYRMyqlMkj
	aT95UyLcDOGLxID9lXiBp/v837u0VWurXMgmzAPRqCEfGquNXf7/mugAnKF1QF3q96bpuSvaFvu
	61s9OwTWY0qCeTpDB+QP7ErsZOpFW1/UjQ5M/QgoAWkthOg2RCjwSgbzi52R9g5Hlta+xMjhqzm
	u89v7CTKn80ie7Yof/MBP50+zY5RBUiycUiutihOs6m/4WMdmFCSJCzi+iJEONWbaNwP/m5MJvt
	0pMX49mxaWk8pRH84Ns2O+S/zSlxET9U1sNw5VqlUv5hpKBC0Zwdq1tOM4qwjOXS0=
X-Received: by 2002:a05:6102:158c:b0:7a5:2427:ecc1 with SMTP id ada2fe7eead31-7a55ce7d127mr3164716137.19.1789883242711;
        Sat, 19 Sep 2026 22:47:22 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6aa41dac0sm4521732137.2.2026.09.19.22.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 22:47:21 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 nf-next 2/3] ipvs: tcp: enable per-connection secure_tcp in state machine
Date: Sun, 20 Sep 2026 02:47:07 -0300
Message-ID: <20260920054708.988867-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260920054708.988867-1-adrianox@gmail.com>
References: <20260920054708.988867-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let set_tcp_state select tcp_states_dos when the connection
carries IP_VS_CONN_F_SECURE_TCP, otherwise keep using the
global pd->tcp_state_table (the netns default / or if nomem).

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
(no changes since v1)

 net/netfilter/ipvs/ip_vs_proto_tcp.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
index fec0e8b47b71..3b9a2c8e9a52 100644
--- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
@@ -451,11 +451,10 @@ static void tcp_timeout_change(struct ip_vs_proto_data *pd, int flags)
 	int on = (flags & 1);		/* secure_tcp */
 
 	/*
-	** FIXME: change secure_tcp to independent sysctl var
-	** or make it per-service or per-app because it is valid
-	** for most if not for all of the applications. Something
-	** like "capabilities" (flags) for each object.
-	*/
+	 * This remains the netns-wide default / global floor (e.g. when
+	 * memory pressure kicks in). Per-service hardening is now carried
+	 * by IP_VS_CONN_F_SECURE_TCP on each connection (set_tcp_state).
+	 */
 	pd->tcp_state_table = (on ? tcp_states_dos : tcp_states);
 }
 
@@ -479,6 +478,7 @@ set_tcp_state(struct ip_vs_proto_data *pd, struct ip_vs_conn *cp,
 	int state_idx;
 	int new_state = IP_VS_TCP_S_CLOSE;
 	int state_off = tcp_state_off[direction];
+	const struct tcp_states_t *table;
 
 	/*
 	 *    Update state offset to INPUT_ONLY if necessary
@@ -496,8 +496,10 @@ set_tcp_state(struct ip_vs_proto_data *pd, struct ip_vs_conn *cp,
 		goto tcp_state_out;
 	}
 
-	new_state =
-		pd->tcp_state_table[state_off+state_idx].next_state[cp->state];
+	table = pd->tcp_state_table;
+	if (cp->flags & IP_VS_CONN_F_SECURE_TCP)
+		table = tcp_states_dos;
+	new_state = table[state_off + state_idx].next_state[cp->state];
 
   tcp_state_out:
 	if (new_state != cp->state) {
-- 
2.51.0

