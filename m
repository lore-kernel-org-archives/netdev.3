Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259571;
	b=J/A6FK2hKzUY4aEdfTbVyewBuxfkej7mtp8yoj6SmJmhq/R8irisTrnCp3RSYNLRWQ7x
	 wLK3bg24HmYbsrQ6/eQZyg1zN+xDErUCIerdBORS7EDeMCODCh967DTb01rQ09JVA5PN8
	 SN1VEjOf9Dxw9HtiDDqoLNug5H97F8zL1z1K4IimPLp+lxXTDsagaca3loAW2GtVjmJls
	 /BJcFA+9mh+6YGa7DB+LbtpLlZ4zS4e1B8jwpudB4rICWmRQXJ2vjaE8pw7UTlkh0GvT6
	 PYljDote5oCWeSLpMDDl3xDtPy2oThSvEDzubOlmwtGhYX1hpws7jWKYLac76Dz2fuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mYFAewWnmLlnSmFI/J087U3neuIVyUNuuHDJ7itW0rQ=;
	b=S6of8E7ezgDVk81Tc/Bdaa8A92vBdxQJak1LeDZkPluADUZ/GZ4wNylB6joyDCrRPnt7
	 U+3JpxxVvd7UZswKRPvGMFHahVQTp1VGnWfhgDrYzrTGaffwXagW1IKxmaZFCOWh4or48
	 LLznmU55+nLzkPfG1tV4fhkZLjkgqVg2A2h7DQFll1ApdGmlcz94l5yxBcmldCdLDEr0S
	 gLY0fLEepgVAIKz0S7FCfA6VQNGkMovXTo7sYJC0rSdT9CzbVdZTJ3PIZYx5zeVcImT3P
	 N/4vf+j6YBdAuWDXJjVczcmf9NmJVz5+KWV1Q0zrMjJid3HxHCZ8FMzN/B5qZttZ5GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=INPfdqb9;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E64606A339
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E64606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=INPfdqb9
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so962128b3a.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259570; x=1794864370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYFAewWnmLlnSmFI/J087U3neuIVyUNuuHDJ7itW0rQ=;
        b=INPfdqb9N6W0tTXlelS2kz/0gwVGjUteFTVSFFxztz2dK659RGllB+srSF9A7dEcrh
         fu4sGpN8l66YeLCXD8gHcc/XFcg5lsxi/VEvzdRVXdlF7CMDDobAiNTxRbki8ZDBy/2z
         FgY0DcI6BjHMZPRZbDbtK6OVUQ6I9Xu7aPAkLszCwSo5N/sDPUM0BySSPV7PsFLVKaQg
         kwAIJxE2MVxJLiU1Gj//I7gCzX0RRtUfVWZ/ub/RIBYEhSHuJ9uxoyrEuX/0/amy/Z2n
         5O+PiOxIprXufx5sjvoktn4Uvs+Ki5DmWU+N6pK+Y3ix2EpqQyMONRVT5HrZDJlx4gDg
         K9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259570; x=1794864370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYFAewWnmLlnSmFI/J087U3neuIVyUNuuHDJ7itW0rQ=;
        b=IV5AzhK+mANMlDrgjB+V14/mCrEGNw6xqKztO1cy2IWjCjQ5ukPc5gN0cgqwgfsZHW
         lhfANPL+Efa73FZiTMmReZ+gKrbGru/IIdihEZdNwe5ZW0q5x/aOIPr9Kc0cXyIGe7Nk
         /FfxH7z8dVTDvP3ayjERh3YFXog95zW8+bnAZHHvD5QhCFF3QTTcqOp3aZF+3nA9b9oc
         jNzPj2pZZCbIcZAN4g4oX4Bb76+rlC1Eztbz6ZBV3NzEq/gd85y0e0WMO6DXvUf1hfGw
         lf2GvWK9kRT9UBd7Ef8SXMgysxW61GVcSKLL9efoqCvdNUJSh3qp0Zo4CaEemLNsw2gq
         s0eA==
X-Gm-Message-State: APuU4Z+f0FjFytkjZR+HcG98qxjHextCNwlnR3Iw/wfK3XsI4BW5zjG3
	sEJM2kAQRnG8uWyKMrylObJEfY1uV8YogEhYgljp371aZ6gQuWue+k+jH0ikGlaeLeuWH7d7qON
	mflYCvws=
X-Gm-Gg: AYBFou16eRpc9dswxg9HzAFWAGThiynrQyaDMc41OP274MdzMo1erltK98p4b1qUJpk
	Sf7KEYeFXI7TdR3vnoMINUt9TU9dcKIO0ABRujtdzuIF7b23laUBYzTS7nzU+YJJBblRiOv/emi
	yjIKqSYeq/bdT5L6EpZvAAyyCNfW8SVvrr++jnkXo4+1SvFKm2nBuLKs23tG3GYTMSPQkIo9zVw
	NZ2ZeXlDBkA5DYiHt6uKmnzvZ4EfkpyxadqMosdJnZvoS0BAxd1R0YSALs5y/6l2pM0t1JH76dv
	URtiKOqUqI7hH80pq78jgqBBg4uN/VQxFwckuTLRleBCDfKsfymtcIMWzyvEUfHMLmSzup9WDjc
	K0nBEhZWpDkBJsS00MFlLv6ac3BSw5HDJF4m+TjCZvpyqybSN0X933VbpkeY2zyRACuEUMVJYD0
	8u5xvStlmF2K5rJpCvPE+LI3G31taYhSmnqhqCvfBe7DDXveEJU1y+4b/xgv3wn6HafeOhR44XH
	IkdVtTir3R7/FUnEhIKn1DsvRGcEOOiel/a6ao43cKQgMxMfLWNDxJnRYzoXAXvdO/dw2tvB704
	grBE7Ucj1EAf39Qn14O2NSyAJQIo7ExZ5AtrKoqCKrotxGPX0YHx4zZtyLr2D07eWTN9
X-Received: by 2002:a05:6a00:2451:b0:899:67fe:3c52 with SMTP id d2e1a72fcca58-8ba860ce232mr1014193b3a.15.1794259569926;
        Mon, 09 Nov 2026 13:26:09 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 07/11] ss: fix rpcbind service cache
Date: Mon,  9 Nov 2026 13:25:23 -0800
Message-ID: <20261109212559.39661-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109212559.39661-1-stephen@networkplumber.org>
References: <20261109212559.39661-1-stephen@networkplumber.org>
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

init_service_resolver() left the name of an entry uninitialized
when the program was not in the rpc database, so ss -r could crash
using it. It also leaked an entry on every skipped mapping and
accepted a partly parsed address.

Parse the mapping before allocating, and name unknown programs by
number.

Reported-by: Anthropic OSS scanner (ANT-2026-M2GWD3L5)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index e0b26586..74cb3be1 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1559,37 +1559,45 @@ static void init_service_resolver(void)
 		return;
 
 	for (; rhead; rhead = rhead->rpcb_next) {
-		char prog[128] = "rpc.";
+		const char *proto;
+		char prog[128];
 		struct scache *c;
-		int hport, lport, ok;
+		int hport, lport;
 
-		c = malloc(sizeof(*c));
-		if (!c)
+		if (sscanf(rhead->rpcb_map.r_addr, "::.%d.%d",
+			   &hport, &lport) != 2 &&
+		    sscanf(rhead->rpcb_map.r_addr, "0.0.0.0.%d.%d",
+			   &hport, &lport) != 2)
 			continue;
 
-		ok = sscanf(rhead->rpcb_map.r_addr, "::.%d.%d", &hport, &lport);
-		if (!ok)
-			ok = sscanf(rhead->rpcb_map.r_addr, "0.0.0.0.%d.%d",
-				    &hport, &lport);
-		if (!ok)
-			continue;
-		c->port = hport << 8 | lport;
-
 		if (strcmp(rhead->rpcb_map.r_netid, TCP_PROTO) == 0 ||
 		    strcmp(rhead->rpcb_map.r_netid, TCP6_PROTO) == 0)
-			c->proto = TCP_PROTO;
+			proto = TCP_PROTO;
 		else if (strcmp(rhead->rpcb_map.r_netid, UDP_PROTO) == 0 ||
 			 strcmp(rhead->rpcb_map.r_netid, UDP6_PROTO) == 0)
-			c->proto = UDP_PROTO;
+			proto = UDP_PROTO;
 		else if (strcmp(rhead->rpcb_map.r_netid, SCTP_PROTO) == 0)
-			c->proto = SCTP_PROTO;
+			proto = SCTP_PROTO;
 		else
 			continue;
 
 		rpc = getrpcbynumber(rhead->rpcb_map.r_prog);
-		if (rpc) {
-			strncat(prog, rpc->r_name, 128 - strlen(prog));
-			c->name = strdup(prog);
+		if (rpc)
+			snprintf(prog, sizeof(prog), "rpc.%s", rpc->r_name);
+		else
+			snprintf(prog, sizeof(prog), "rpc.%lu",
+				 (unsigned long)rhead->rpcb_map.r_prog);
+
+		c = malloc(sizeof(*c));
+		if (!c)
+			continue;
+
+		c->port = hport << 8 | lport;
+		c->proto = proto;
+		c->name = strdup(prog);
+		if (!c->name) {
+			free(c);
+			continue;
 		}
 
 		c->next = rlist;
-- 
2.53.0

