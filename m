Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513656;
	b=UyZqxPmI9LRfTfvQIWbGFDdyIZLJP0ZZSS4+D38yfh/j/7keRbgAQcsSk53LC4mgJ42h
	 UDDMcYzJ4+JJrPDZOjKa3yA5MwW3iC4cei9mXmNdzG/oGmaMAnryLkhnYeJWu9JDj4Oeh
	 3vTe9pwoMpYHAzpoCaiY42ej+i7WILRsnxzB4e5WV8ATkTq0Bfxa9jN7fBVJDvyd1NF8V
	 ToOMK0vkmJqJ1731T9ubKwd5Fa0YtavX8ues34m7QZnOC+KNw/RHFyzPAJ9OHnhqLw5qi
	 h5iG1YtIhUAWwC6ydAVnsenGQf3ZfDa4aBGefISD3CdZ61Xt5gxsaVXpfpTFESjtvwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0pYj3bKFMtj7PR16yt0nJIoJWj/HYEwrPCOVrJ7Te0Y=;
	b=RZbwloQoVf8wjZBXvyPnaE7e+n7EM/Ytgyx/FtmVXlse4QnnyMhpJM7DANmnerzpEMhj
	 Jr8JEo962IMS2BoRPALUli6sGqctCw2Ml9hiikPrY7+15wALksuj5TjJhP/OvjUYWa7DW
	 Q6SPUrTC46iX5483yQdEQqw1Spm5sF8iJzc1HcoPRgneKH5tObhHyXM9uPfFwXbOEsDHJ
	 a9nlmVuFUAMN/9J7ogbFVeTu5Ur7/LssZ6JcBW+cV0KjooqPccehi2eBKOEoCU8j6XQfF
	 rj3ZxlOYS1/EZwNSERE8zjzdYX3Ie4aMOR7FsvMQi4qxYgURBcAfGp53b6gtNW49OdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ju9PFt01;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F59606A8A3
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F59606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ju9PFt01
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b18717a193so96688a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513655; x=1795118455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pYj3bKFMtj7PR16yt0nJIoJWj/HYEwrPCOVrJ7Te0Y=;
        b=ju9PFt01/Py1e0+Got6MEL8jiP5b9hmOuRJJj+iss63dKPTduRL9kQmK6c0T6r04E5
         oqQyZNQ4jiYHkADQZlyG7AYAckyYmmsZC8iAZjkv+5SLZGM+tP45gKRUUzvl7L1nPspg
         +iwtPYp6uKWupKBWolZA/DCqXzG8O+64TDcl740mnACdlyaZL1NOeOBPFciSsr88h2iQ
         P2xSXIBt1mb1OF/ofAGT9jtKNDJNsZb0CzzJxdbJJ2RXJOmC53CwlOENAq1Y+YqrSd+5
         k7bn3cR04Fc/MPiJ4TaajQ9zjTlyw+EBrOL3DL4arWf+u5i19YaBaZrLca9nhca4V39V
         0UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513655; x=1795118455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pYj3bKFMtj7PR16yt0nJIoJWj/HYEwrPCOVrJ7Te0Y=;
        b=FW0fLP6xZtHzblxaXgY6QhXm5MfA/Hly1xOqzao7DUpOXtXEMBV6OjLE2TzMioLtuN
         AkKf2h1Y9k/vn+5hn1iP8ZPAXC/+7eI+CLSQfJno8evkcIOFTzj2+Jfj0pu96U4vDPKn
         vIyQpSXOLzSt0flAbc6YxsG9fq59y6DRjSq25OcLM7Msr844Ed008vcBvkvbysQkq98l
         BV/KOmnp5QanuVcA15tx09D74a/8NJ2Uivr9QjOLFbohXz0xRgH/RiR5139FcEGaqRLv
         N4B6Qj5bmu2GvFQYav9qJLJcZB9VW5FEu5KVKjoCDhpKuHEQWeqQ3BURF3lGjxQIebjH
         eK0Q==
X-Gm-Message-State: APuU4Z/4w3u1uL7vYo9Lyhi1IPCj6GENtjfEZAO3/qO4BAKkxKfu5/ct
	AjP9abhHEbMZqynu0ipjpZUk43+Im4Wb91aiGukZN4Lcbb8fJEVEQsi8avcpBYwTgSebc4W8fQP
	W2fQG
X-Gm-Gg: AYBFou1SQ3Nz4rFR9irfo7eHQi9DOICRxUgjiV0vnTIwR+aoM9eqILeti4FJJ6L52g1
	smib4jj6p4VC9dsbH5Qh2dEeq0XyeLCyYqNGygsCT+aiL8Ac9Mrio2kWCMJU26reejy8b8yacD6
	sUnB9HvLMPOWgKW3MgU22zA/71T8U1bWXxw//AOeukXHeqBoqWv+HX6i2qJu1w4ToMjbSNm7+Uf
	ZpmEpO0kEh9XKovd0u936jUYRZM0EtPIVvr2Wv/uppM6vBi2SjNqKrMggnbnKMjDkCKgxvpmdUo
	BFGSsG2tAP+QbDk8YsCfI0hcEN/9b+1awqOn6iSu80kUajqMVZ6SULRgdNkKKPGiM9gUTQtO5L+
	jVUDopkoPFXcL6S0DZRQFKucqNpCTkrwNcSQTkVzxJtfKUXLoeu2eAS0RVZAw5O7zsWSifIyNtY
	zcWWDyddQjm605+rJd2ZakzGlmHUfs4MOZlCgd9iyMtdNBNYbyRbOI25nS5jhY7JiWBHt2sVOU6
	Kah35ZxQXQkIEOXn7Nazo2rwxO1ad8LMLpaDKBCFnR1hKeRq4hBYUlfWOJ/OM3orajvWVNuh4Jg
	K12FSx5DgeutioTIzDaXCFNe2jT1hbM0dlcn+Y/oxMNLiTGXTZfLW+mW4+nQIqdqwh84GAY=
X-Received: by 2002:a17:90b:3c4e:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3b1b0b87f83mr131779a91.58.1794513654979;
        Thu, 12 Nov 2026 12:00:54 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 07/11] ss: fix rpcbind service cache
Date: Thu, 12 Nov 2026 11:59:20 -0800
Message-ID: <20261112200046.2164391-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 2becb852..5ecc5b5c 100644
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

