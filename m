Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CE33D6F8
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176775; cv=none; b=vCG/baz+it4u886nyuANdFloDezYLJ1OEgGywPVc7Yt4lagyotgcwfTDht+0fNZG26rtiODHrxXROwfigFWLWaqPCkDYRVK//dq/nmbQYrq68ohBkv77xuLMmkNowpHxKUf1x9A2N6UXJfpXHL8VIOD1tILwqoQcpI5zSUq4TOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176775; c=relaxed/simple;
	bh=W3fiDar/lm5WkpMHbhW77gh+6N9tJ47fTMLt8bhssWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQiu3ui64T2xVjOthupLHGNhl1ex3pjO0AiF7SuPzHsjysKJ4knLD7qM4rWIj2Yv+Niz7JP/lrIHhYKc8wfV52iHuzh8ws9uWq8Vsp9wb/w+CAD8xLqHGaTKNXndnTMKLBHNCke/G4KTJIccy5iHCrNQ1ZYwVzJJ9aknFJkpKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC+AW1Hi; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC+AW1Hi"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292faso244057e0c.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789176772; x=1789781572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kO+7YN2IAaySDWCD3o40tVhY4GBw4G0JdF/ryYyBPSg=;
        b=kC+AW1HiZkRNRfJqMHtgTB/1JUQM/kzggxLBNUHtTei4+Y412Z3F8ho/706bnOPYhd
         SbruhTH+XUhfsTE6LpRjZUVx+O5UpsSZ+LYyUOSXv87nLw1jPP8bq+b4gPAN2EHL2hie
         t5c4R0dUk53Lpc5k+1SpMLoU+MHLcChz+dIZrcWx8NsrM9oAt4bbJFtoOwtK1Hqh2X3+
         u9WP4H6rzG/jSWSBJtdDU9oPj2sDc8XjithoqpKKJXcAmwxl0aY2nJfhS8kNMdjv8Ms6
         gQtTIyeCyHWIEf/2DPbNoxVcOkNxibcylo7DUbuGlMEW1WUdV9fbACZ3+67zf3b8Nfj6
         TmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176772; x=1789781572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kO+7YN2IAaySDWCD3o40tVhY4GBw4G0JdF/ryYyBPSg=;
        b=Y8JOw1RvobNZAFNT7wMEvANQTeYRE5VBeZLexE8RZCV4+GMhci0nQbJsGkariGMInc
         0relnuve4axd4x8zd7/jP25AjfEMeZ4uQ8hl0yeNA9RPCPekIkK8ttFeXtQ3x9DmXMDa
         X27LyH7WXlFJ9DRZdoUOBGc9kq18fMUJ/vIR5dhKYVPV7bKBAuGrjxaN6vIkcNBfCe/u
         PtXGchSxoaoDqqxucBOjp3OXDkVdtZcaFqEwFPnSUcFMNlWlDJDQQEhlueD8UozTcP8G
         UwhvSjALSpHyBKousCLfZAz4ochXQXd/Lqegn5KTu+YsPJoZBsM15wBS2Mf5+aIKCqJA
         J8wA==
X-Forwarded-Encrypted: i=1; AKwUvBx/bX8MsmoQ+8hCSb7od8YG/bWwi5J34S5X0+VEm/jDQIvwGNWUWysDx9QyBY7qRceOqKKnaDw=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ9R1a5+ECDwXb6G3J6Qs+n2X28yGJG+wENXYmkdJ7fp3XV+wY
	ge0hxtEr855tUhAQF1kcErJBxXC77OOWqQ05MPaRVRr8x8IbwNRY6Jss5fq3gyz9da8=
X-Gm-Gg: AYBFou3mSzYfp5nNTLQwBIyS/UW0Hslb+jnGuWLK7xOJMyggfFpgkwfiBHSBLh5hv38
	d5z6AFD3cm+oFOtxk/5UDNXGmhzHmQLAmmTUoNFBH25MAIkOHlAi6q9Oie8Hi7RehExDkDT07Uu
	+t0Jo3nJty5xcEFR0lQDUUlJjZEQrq/nShnW1n0MOvAEBcAEKm/F+Y+HMdfsH16ipzEZ92fbq7p
	lT4kZ1dHNmTBxA/cPEUEngVsxF8hEdpvkN9ybuZPt4gCSACBJigTwcxES7cADJlYEaYxQVjN5Ra
	UANLUrnL5ikQm4A2Yw6Kf9JOnOSrmt5LxMtnA5R5y60HJfGqIHTQsErZr/xZqK5wiUAB5pmnf9b
	QcuylTzOr/oQy47GJTxedYT+PATpKDwgTh4Yiy/Iz+t/yVtZMel1YBzedxXO0JL6+PtnTmEzDpY
	JIPPgahR+zENaGsZOjVFh59BWFdB4cq4d3oE+jb+KnocYV2mUL1bxxll7fx2CGFsQ=
X-Received: by 2002:a05:6122:420e:b0:5c5:731b:11d2 with SMTP id 71dfb90a1353d-5c8463028afmr4284498e0c.8.1789176771974;
        Fri, 11 Sep 2026 18:32:51 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm4738262e0c.15.2026.09.11.18.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:32:51 -0700 (PDT)
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
Subject: [PATCH 3/4] ipvs: tcp: enable per-connection secure_tcp in state machine
Date: Fri, 11 Sep 2026 22:32:15 -0300
Message-ID: <20260912013216.588300-4-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260912013216.588300-1-adrianox@gmail.com>
References: <20260912013216.588300-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let set_tcp_state select tcp_states_dos when the connection
carries IP_VS_CONN_F_SECURE_TCP, otherwise it keep using the
global pd->tcp_state_table (the netns default / or if nomem).

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
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

