Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972E3AEF4F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508215; cv=none; b=m/9MX7Q69Di+1ysML9cUr2MKKCpMlLc1xXWVGcFzhbYARz0MO6DW82i+BoQAeByVBaT3XQ4pG1uoRdPoYht3gL1KKz3ylZK9KcfOHy7AdwDit+Y+crF4zOe9cbiaonzmEonAyUMhjMUm9+8Il+B1Gx2RyQJgwuAcFwkJasUswJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508215; c=relaxed/simple;
	bh=Rc6wev/buoJ4W9l6zIwkDRmp+1tphJdrsLhGjHOXaRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJWf58ZgXwiqLaec1KC8vdmGWjbvSpzgiVybsX6cfw6Wez9Fhc2ty5Ju3Jib6fydGGMlwwo1agna1e6bJwFOWv+j1f1c0a31Bub/4WBKw1I8CzuZzYyCnqnxAJl+nodzYKTsA2AjMNNBibhEM73Ro6vFKgNYfSaFWW4TSVGvcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=BCc8k2VM; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="BCc8k2VM"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so246591a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789508213; x=1790113013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YtipX3Rt567KruGiTyZxJt2Rf2P+SwM38OiiEbcgFw=;
        b=BCc8k2VMSuyUvkjktrYXbpfLGrg32VWg9xePsQ2cNATb5eoiLo6YDexVF7+k7N8flR
         wrLxOXyXplmsdpR32qeHCehE1P8HJ8z11+z4EI8+F3l69eAkDG8AyD1368JwW3KYmF4U
         6In+rYoREAhOASVgW+QwHsrSghvmAw/ODpDvTQlP1iok+s6YgOWqpBMIW1DbwnJHSIvU
         d+k+BhbQabUp4KQBjlyU8EvxR4Bb6+fqM8JnRHgYcjddDxXprSEoFW9VUrESrXFnKLjS
         Fr5+G78kFQONmJfo2bd5cW6fBV7MwGbmBP2EYcaJC7PcyzUAW+ysnwEFDv7IyveH9p/V
         ORkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508213; x=1790113013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YtipX3Rt567KruGiTyZxJt2Rf2P+SwM38OiiEbcgFw=;
        b=R7WOZIjlADCSzYr5mQTketEj6nCOyUDyOBi5MQf0Gm5Zyo/1TEr5r5mUvZXEZZlVgt
         IUYxl8/4GImWOdit/fJYY2HP3/VUJ+SMsGQTzgBHFoXYUB0p67/7worZlE4oxFddRJm+
         rdEx7i/mn+Mxx5bpxPugY4u6BGc1cPXtcDRcPFW3VjDU1AFD9jHLE62SofYQbVmLRlzi
         G1Wo0PELQnDOCH6sRT4cW462eZBsuejw8tqO1jcepAz9EJ2F+QY7z2uHRxnR2NeInMjc
         NVh/staWji+2LK82eyj+s2S809ZkZ8egm3ao7hNymLbQgHr1Z2llD2EAM8XIIfEn07b6
         +PCQ==
X-Gm-Message-State: AFuF++mw5vMcCp855CmVNZgIfsthbFiDa4LFgwFGuxaI6ZlgS5EvFBdC
	fyOs7DO+wLiYXMYQkZgt3e7vuiBCXvQXWXPGaoVDLgih1ljDa6mFlNu4nocto5f+6UpHqpF6xH+
	Ig7Kx
X-Gm-Gg: AYBFou3WFKU0+K2OrwVRY47UhQz0rzzKiUV+C3qzQmlCg2CPqsywgDmCxgoRw8OUsFT
	ayfhNJqUlszk7JBVdtAgc4JA9XDT3YsP4sg3IP8Pudx3HcnbSynaerlkuCHXZASQNxSFbjhvB0n
	zZ4ou0MSq4L0cREpczaY4CGDBRltcBfX8mUNWLzXL84/E44I4xTlqltVjBD6jNDYKm7AHhKrLBX
	1/cAj634qbeV8kjOv1G10WahfUytuxZJspiC8eunULt0iNijC2q/x6mhnP9jdHbS0m7GRK2tNOm
	qzAHhryHiFLs3jT0pTBFF9zBLqvU04Css12WXLfjLwiDy2mrq3qgVguasl15qFl09GZ9WhZtNjy
	9hRiS5XBnCu7UdH69R4F6YHCsbtY3gvU/3vlcg3mKC8ITbVxRunCIPms64URMKUOhOEmQdoS3fL
	+TJCf3hb3oJ3A3ZGjy7SiEoc3YqeaLsO19uHFWLYMx9cx4ssLnrNf5B+5u3JWblNDnWkwxv6dtV
	f/gYU/gU+jGCZG9Bx3UtSEQ7jCCXv/IPXYbLA==
X-Received: by 2002:a17:90a:d644:b0:39e:288:80c9 with SMTP id 98e67ed59e1d1-39e1e4d3fd1mr401475a91.19.1789508213519;
        Tue, 15 Sep 2026 14:36:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bc37f58sm608504a91.14.2026.09.15.14.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:36:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 1/3] ss: drop the dead /proc fallback trigger in packet_show_sock()
Date: Tue, 15 Sep 2026 14:36:02 -0700
Message-ID: <20260915213646.116214-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915213646.116214-1-stephen@networkplumber.org>
References: <20260902035633.1978-1-prabhakar.pujeri@dell.com>
 <20260915213646.116214-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a2b31976 ("ss: drop the /proc parsers for packet and netlink
sockets") removed the /proc/net/packet fallback but left behind the
code whose only purpose was to request it:

	/* use /proc/net/packet if all info are not available */
	if (!tb[PACKET_DIAG_MEMINFO])
		return -1;

That -1 used to propagate up so packet_show() would retry via
net_packet_open().  With no fallback left it is returned from an
rtnl_dump_filter() callback, which aborts the dump.  A kernel that
omits PACKET_DIAG_MEMINFO for a socket now silently truncates the
listing at that socket: everything after it is dropped and the exit
status is still 0.

The check is redundant anyway.  The code below already guards the
attribute with "if (tb[PACKET_DIAG_MEMINFO])" and simply leaves
stat.rq at 0 when it is absent, which is how the netlink path treats
every other optional attribute.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 6ca6d406..0b7ba256 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4773,10 +4773,6 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 	parse_rtattr(tb, PACKET_DIAG_MAX, (struct rtattr *)(r+1),
 		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
-	/* use /proc/net/packet if all info are not available */
-	if (!tb[PACKET_DIAG_MEMINFO])
-		return -1;
-
 	stat.type   = r->pdiag_type;
 	stat.prot   = r->pdiag_num;
 	stat.ino    = r->pdiag_ino;
-- 
2.53.0

