Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4334E06C6
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591852; cv=none; b=jgYzV1bC1wOUGbyt9gzcKRX6Grw3dzMfR9GVk4sJx/gdZs8Oy5VUhLR0ML5yCVyB1QuXZynkr6tRtmHjHJY9gnmGS4ouh9pSFShigOShZ6MvSKYvoeyEK+q0YqMg80yr9zBRxSMoxuvAXvG1g4DOyeCI6MJudnVMEt94BZmFLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591852; c=relaxed/simple;
	bh=vGxo+U1sJMCVsq3sDI08zPDza2WpfMA+ZZBuxg0Rgp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9YtZ/WP32WI9XRBd+qI10xtyBiEzGp3RI1HsTMHdF9v7rAyvsa9uU1D7OR6/0TG5mb3nVxK3H6+D75qA9IAhl6bsutk4pMOyhnJ3rhvNvM646g8sQT6wvu38ZsZ6nwRNO0o3DoNep4VLHqObDyv50b9A6XeYaOs6hp2Rg+35zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rF1hUmsI; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rF1hUmsI"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a0477a4a01so58804137.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789591832; x=1790196632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xdh7oWEQ9m8Qy+E3UVjKRIovBOhuQDCeQrchOYtk/I=;
        b=rF1hUmsIT9igjP5btpGYCBgF2a1mg1PwA+mRm9EJo6bGZCYDlfaauCJICTLok1pQI6
         CVczDKxp5D2yAxbN+Fzh+x/xS1YKwrc+RHWnlYTzywaiinQtePqm7Ki4dEhOTzw/wVJH
         HgjNwwl/GPtd3Iji71u1zZXBSavBK0RacrVFxEnwNu+jSkB8ark0r00bEeMk1WZSAgLF
         9GhIPDtJBtUYBx5SdLTVS9G0Fp7C3COCqt3UHm6V+6IF9WzSFNMyqo1/WR61/VcOyX9Y
         tgA5a+EdSnTRGVn5U/DfGpekzYL3CQ/BoEoi+OawtccoFAyhG1dHYySNxRvym1cj4kjr
         c+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789591832; x=1790196632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xdh7oWEQ9m8Qy+E3UVjKRIovBOhuQDCeQrchOYtk/I=;
        b=KGj8jl2AWwr/UTCUJXt8hb+GB4hPjN/SSO5+Pb31LugrBu58C1w+EVz/aTs7tIRLl0
         8bwsIT3djM3BRxX3UrNj8F4GvyXXDBIiqwaMpJ41YIRdXLIE9BZhrBbq/ptoKOnlUFsu
         +wtC74Ov0naKinh04tBOjVqn7ShpBMbPJQGtNWIl5Be1GRSLKE5aA1lZP0uBbj9rEKGM
         U5IXpZVRob/QkrA7a9tIJQ35gCrdCBkbqvuqG4tQ1RBM0ndcy3Y2OAPMiTk6z9ctoS9q
         qHTfd+2RX/7F2TIb+bvxNbAN4WpjWzdtOCXw60oYWc0Rq8H2B3NAkyZYx1bFtkU07DOh
         pyrA==
X-Forwarded-Encrypted: i=1; AKwUvByq1wD+dUjCO4UDqWixUhCzqpgGHDbxKCkYkoBVSXDojvxpnagsVdDdz0Ekx2fYQ3gVKsE/Hfo=@vger.kernel.org
X-Gm-Message-State: AFuF++n/E/Ir9u+jc4RTjnAvt5R3LAQnxqUUOGHSgzajVpzlONLZcDr8
	CNMVGSzmVPDtoFOXw/qJuparbH5hSvM2YjbgPNSO3fnJU9O9zM8oQt4R
X-Gm-Gg: AYBFou3kc0kskdtfTdJ9jWSYHPb50Edkofezp6SKQBMWmHOT8wlaba5h6DWjSnRjAP1
	zjA6FKOJV7QxztDP5BEa6kboM5IHDArmYmodg4M/Hzp2SbNJcohOrdH9qNK6SgI5lGaMGBdYw80
	XgMdwNLIfwn7z5Sxd6SNXFrKWDMktPQq5F9SUnZ5hIahvEJDa9uPHw3PRdmxgXJYfxYAgJ/v6Is
	tZjzgsuo03PaFm9yWH1hHd1jbOjowDd+tGZvrRzLhKwAa47GDNkyUzpe52NOGKuL44I1I2k/VSY
	DsnH0Xs8Lf2ohWxO9K6wKansLnOT1gvQwNqEV83yZlQGunBQzWX/mtsK685Z/Is45K3/hi/BZvr
	kvLkzTFQiz7KkMgGvUT8Kp002swbmr/XHY2OET+NSFsSWLJKh9/jFQuwMC0bI87pW8fsDfybBm6
	euGMnitReGUAiWOc76xOH4IfhtLV859cwSc9H00LwVt7hSbJbB0+D28lza9P0j/ww=
X-Received: by 2002:a67:f095:0:b0:7a0:eb10:76aa with SMTP id ada2fe7eead31-7a0eb108b2amr3649070137.2.1789591832274;
        Wed, 16 Sep 2026 13:50:32 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9832354a8aasm947799241.10.2026.09.16.13.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:50:31 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 nf-next 2/3] ipvs: tcp: enable per-connection secure_tcp in state machine
Date: Wed, 16 Sep 2026 17:50:03 -0300
Message-ID: <20260916205004.647194-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260916205004.647194-1-adrianox@gmail.com>
References: <20260916205004.647194-1-adrianox@gmail.com>
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

