Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743346;
	b=mTo2ZqClQgTNmrufuSjqCtMFizpKg5R30SDRnYfLCY09FAKXug1H5TySgM0ThW2uJuPN
	 +3GGw1Cr7CYeAXG3B3cSJ4xDg6Z851XZInFAuCy1O/zlyvzlQ1Pfpavw7IhX0T8EEKhSu
	 kUL9QklIU7e2FPQ4V1Hn2dBZINUWipK2gNA8dwSsWecd1U1PH4YVKojeu/bBqBdAi5CLq
	 GwKP9EddGK3RYuNFX2OqlId7Ql7iXGrOKBieJ/GA6HmjLCpTiug3SypyH2LZY7jm8BszP
	 oILZbM5Vq0GlS3Uk7MFkfBz190TIKffiFGbOCjnZQipZbe+yXWbcEvtZYaIYnj2OLZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0Q996RswduMpIhVsoVyPA2VHGPwwWWrs+cfGJMYGH0w=;
	b=Mg2XuOzfD6eX/42wNj3kjeWiCyqIr5igaIBLTE1wfbc87yWtMThszk0DmzIlaoNfd265
	 PsQon4LuvU97WqqLl8AZMgxm0b+Fw/ZXMiyWen2Xjst6/n1U9ueATqWPOshwVamBjNbe/
	 CcHbVkRYGpAJqDnudsifImFo9d1yQve7jp+ahK1fkphJUbIKfqlt1ha4XE1tJqhyVVl3u
	 KSdEnJMGcwA4mg9PaP+wH2u7PoewQifuFgIIfvhcyXQYiRFcTT8BGVPitnzWUZAdsnoVq
	 6JykfDs1iIu8uv+j1kLDeycADEBI+/xdc4K789vwfYpFb7tNCFB2ccuXHzMf1yzBmuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aog6qtnP;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487E606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4487E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aog6qtnP
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-369f33df08eso18848eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793743345; x=1794348145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Q996RswduMpIhVsoVyPA2VHGPwwWWrs+cfGJMYGH0w=;
        b=Aog6qtnP0tAl7RfxxsRY+nhBR8Om1wLA7yqodbUGaCnryP65x8QfNoYRuRPx/0/8tH
         n4hz/yfQlbBKdM6+NlsGtakiC3RDeAJ9JQfG8/xJKTWamfBlCIpWTj4PvwddrmR+JYv+
         PgN41rauk0EjgMmaQdxlM77EKsiHubLZJsfwXbYVcTYAZLQ8WBi1aaoRGRlOW3h9Wlnd
         1qVOmUI3ZjZWutQ7MzGSjevagkxa00Qje6nwdRpzeVv9ut9oXmeK567npp1Z3CwOmVWq
         JDfrXXtSk1GVcuqJagWmtLZnFo/MxyiIu1FItEMYZH9NXdGsL4GxAXK+/ioe3zYl1vtQ
         J+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743345; x=1794348145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Q996RswduMpIhVsoVyPA2VHGPwwWWrs+cfGJMYGH0w=;
        b=kMpVMmj0dFX5YfqmCbrt7T3Lnb4yK/W82SGycrzwih2Vsj2GPLjoVD1SBQYh4BqN+w
         9GxPncR6YPi9NXMiRqFNMo7Yk8VIWGa93/JLoFHjed6E4LlSSKfHQ8p8zGj5tz7CNpWF
         +vuZ3y3YJmJzSvDnazMMefmOvArkuFHmS7tKRqt21ScQ7eGb7CYBvF2OrqJuY+/sqCrh
         EThu02UWVAQh53bvSojuAZpsSqZsLkzKSBs6Q98gF8Al9QrPiXzM8rzCZ9rXEjTavRr2
         HaH+pseRq+tOC3BMeRm8YIlrtoYZdHjdt381HHorAuS4IaptlnfCPGR/39wuqPxT0Fmb
         Z2lA==
X-Gm-Message-State: APuU4Z9uMTIobjpq3UtXa80759qqK5hWdKl1Rj5JkGWLtnwMPigVxwby
	ThOempL6LrBpXjb/HgvOjpowwWCTk9jpfcxU7reroW+HU/CpBtiFpQIZ4kjMfg==
X-Gm-Gg: AYBFou0agiPwoutIl4RZmN9aCgZufMrlbT9SfPd6q329lxF+iETHItMCldqUw3ti/cZ
	EjY10W62L2c9xRqtfBZFgMCSaYXEIXUHnxVf+JULv1af+CsH0E/IQEBvCjXmIPfev/Is/vjMFTY
	pKIUoSEevixpzRTzAaIT7g48JuTYFRK1WWER9nTDins3F+hbO4ShrkVlWEnsOb+yVT5xQk6Yg70
	bjYK+MYR788bXm4B4bHn85K6oMlHhk+pKHwabCvSwBVBDwHdKpmz/Dq9UTSNYsPTD32uZZayPBl
	bNqdRgkqbXhbbochHYBU3rwGeSWOa2TAauoLc0zj5ynhAnDfZ5z0NxpMPNBFE7ti0O7JvrOe9bM
	IjbMbOiU1JOo0pXH9TEAMC9u1uzBJAGfWnkYmQPDxecvqApwBhxX/4GIhV1yD/ruE+QzK/X9KlY
	Tao5TbMSN2kVZGXfHSBQGTVrxa1JNIQttGBqH7/5EKq48tNd3kcofxek99/MBpF8WN4W5k11AG9
	5xQa5gKsdRnPr5Ig7cY6nceQ7Iq1OTkX4HqTEul/e3RN0y+w6wM1FOZy9NjVWx0VEIYYR4zT/v3
	oXWNPo+2wB3PgVwsQU9uJmNSg2dR+A==
X-Received: by 2002:a05:7300:3b0c:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a4244276cmr30366729eec.37.1793743345194;
        Tue, 03 Nov 2026 14:02:25 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39c5f0csm808541eec.29.2026.11.03.14.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:02:24 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH iproute2-main] libnetlink: handle failed time seeds and sequence wrap
Date: Tue,  3 Nov 2026 13:59:32 -0800
Message-ID: <20261103215932.1191741-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A 32-bit time_t overflows when the board clock is beyond 2038. time()
returns -1, and the first request then has sequence zero. The sequence
range check underflows and discards the valid reply, leaving ip blocked
in recvmsg(). The same range check also fails on a normal counter wrap.

Use zero as a fallback seed when time() fails. Compare the unsigned
sequence distance against the number of requests, allowing wraparound
and rejecting the sequence immediately before the first request.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 lib/libnetlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index edf3a8ba7ce0..5bc7c43245fb 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -194,6 +194,7 @@ int rtnl_open_byproto(struct rtnl_handle *rth, unsigned int subscriptions,
 		      int protocol)
 {
 	socklen_t addr_len;
+	time_t now;
 	int sndbuf = 32768;
 	int one = 1;
 
@@ -246,7 +247,8 @@ int rtnl_open_byproto(struct rtnl_handle *rth, unsigned int subscriptions,
 			rth->local.nl_family);
 		goto err;
 	}
-	rth->seq = time(NULL);
+	now = time(NULL);
+	rth->seq = now == (time_t)-1 ? 0 : (__u32)now;
 	return 0;
 err:
 	rtnl_close(rth);
@@ -1092,7 +1094,7 @@ next:
 
 			if (nladdr.nl_pid != 0 ||
 			    h->nlmsg_pid != rtnl->local.nl_pid ||
-			    h->nlmsg_seq > seq || h->nlmsg_seq < seq - iovlen) {
+			    (unsigned int)(seq - h->nlmsg_seq) >= iovlen) {
 				/* Don't forget to skip that message. */
 				status -= NLMSG_ALIGN(len);
 				h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
-- 
2.53.0

