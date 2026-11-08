Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101402;
	b=bJk5rqjTdI+izRU04IIomKx7WSdFGn2w5s1cqjYTi/40gJn/v3v4D9ewlgvi5tJ8r5es
	 AmjSfns4SOSxAPey6aYiDlDDgSMADSegj2ZQZ//o83+lp74Av41g1p7nOWyDMNEEQUBn/
	 CPUZYHQ3rESGbKm1wB5Z7RdMQsQzE76RYrqBg64Z/IQV2VsBtis4b91oy/DQdBLkQzrxY
	 PHHlRXZMcAHZ86DfsTKr+fu5ZMSi4u02CJaoxbYapogxCnQAkCZi/o647R4pLaDWTAdjz
	 x01hxbRuvHQCZNrLRXtCgXnB6oLQB122dmGFrEoPjtV4O3VI+BJocDQczChwraENdVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=621j/uB7EI3DNlS5KJBXHr9OTg+ZzLObUVfSibvev2E=;
	b=NemK7ZFjGDO7wPE6Z5ueSdnQCtVjijQTBBPy9bXNa+Zdb+MGdaTeHI20yRi/5+lYlwIR
	 I6EyQ3YXIOQj4zAhCBvFHiznDLMeqm3D74RF4OlJFRhbRYGp70y4TCbcE0xnA+iHmsXCN
	 vzn1lBs6HqwA+ZgohCrzytjjW0JW4m6g/Cg+hU/WJd7jpWzKLoJKEDU/ebdjIE1Y3k2Fg
	 V6XgzZfWdEfrPTpOvbIR1H5+fnVuUzCdfXAI95D0NJHDj8wy+WSrD0lhKRDY359dK2eVd
	 WhR87nYlU1oK5pqf8DePEcS4zAu6pRdHbgITaWzMdefmTV5uqfqOQo5nKIJJfhL+DeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="SLAf6uS/";
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE188606A326
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 01:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE188606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SLAf6uS/
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdb86c39250so40555a12.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794101401; x=1794706201; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=621j/uB7EI3DNlS5KJBXHr9OTg+ZzLObUVfSibvev2E=;
        b=SLAf6uS/SDu65Q1dgevwOt5fvVCdlW5x8R9p34muHSEnUvhIlaNZsfM40U7mODKRLW
         sHIdCkifJudnHZIhcBU/AWiSFrubESmPqldkP3/M8k2Mk+ub2eseKXFOAULcU3JFQJ44
         bV64dLl7YNtGd1Pa3HTwt8URimcfYM5NrdY4o9iUmctSI5vJ5bMQ+UWQ8IDvCELmtmQB
         pglqsrrgLps2O3LkXsuh6XK+4fZRRWZ8CY8jEOzpI54Fwoi9UXnfv3dxxPd33iKY97d5
         YrFnURPC/cBFrCLpkLabDpPnJc+MwITuw6SZsVquPEUXbUhR3l5/B5r0wl9j6xbPBlhV
         vGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101401; x=1794706201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=621j/uB7EI3DNlS5KJBXHr9OTg+ZzLObUVfSibvev2E=;
        b=fsCU+7OyxF8uF8xkBfoHbostIf5v/x/48ZjHUObgk3WE80fGGp/n6vpV/CR5ewngQy
         np8FVn5kE6cgIh87fhTnU9AZFpqfwJ0tr1gWCOeBiJVZAhUw/Rl74k1JHRQYv31aaQCu
         Zxjsfgv6oxY2AEcT29haCu4hFBqa5mQ8JfrSCnLfJypJJWYc7WR4wY8XytydNLZtlUnG
         r3q1vAQoYGwqDM6SQ3J8h6ipyQVTv/ZCIPalrnJ+/PvfL6TNE+9hqr3D8BRCg5craUOg
         GbivyjCNVUP1eLzIVsl3RnrcRNNkZElh0Af21zqT1oM58BOWNJGLZcya949c4uWTMT/s
         1/nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJVuVY7IPnCmqXFsZSFbNG0Gur25HgpjcFx03WL0ZKMQBQ6UmKBD0HGYiA0kfrF2k14/8fUVg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mc9chzzk3bUDLac2xv0Z9cnsQij+bXMl8qaTaftlClnRq9RuV
	YEp6LEe6ubb8kwoyPlpNmovKIs1+wNOjbDwveCuaEUyfyf1l+QJZj2+k03FAn1KPLkUD8saTPFt
	pt6N0cTxJJqOEshTYBU9Ov302qg==
X-Received: from pgcgn14-n2.prod.google.com ([2002:a05:6a02:6a0e:20b0:cdb:6cc1:5c2d])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:431b:b0:3eb:a3eb:a08a with SMTP id adf61e73a8af0-3eed52d1bcdmr449368637.75.1794101400634;
 Sat, 07 Nov 2026 17:30:00 -0800 (PST)
Date: Sun,  8 Nov 2026 10:29:49 +0900
In-Reply-To: <20261108012949.3943642-1-yuyanghuang@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108012949.3943642-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108012949.3943642-3-yuyanghuang@google.com>
Subject: [PATCH iproute2-next 2/2] ipmaddr: read link-layer multicast
 addresses via netlink
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"ip maddr show" gets the IPv4 and IPv6 entries from RTM_GETMULTICAST
dumps but still parses /proc/net/dev_mcast for the link-layer ones.
The kernel now also dumps the device multicast list (dev->mc) for
RTM_GETMULTICAST requests with ifa_family AF_PACKET, so use it for
those too.

The dump carries every column of /proc/net/dev_mcast: IFA_MULTICAST is
the address, IFA_MC_USERS the reference count and IFA_F_GLOBAL in
IFA_FLAGS the "static" column, set for entries added explicitly, e.g.
by "ip maddr add". The output does not change.

Older kernels reject the AF_PACKET dump with EOPNOTSUPP, in which case
/proc/net/dev_mcast is parsed as before.

Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 ip/ipmaddr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 95b703d2..2df520a3 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -261,6 +261,10 @@ static int accept_maddr(struct nlmsghdr *n, void *arg)
 	ma->addr.bitlen = ma->addr.bytelen << 3;
 	memcpy(ma->addr.data, RTA_DATA(tb[IFA_MULTICAST]), ma->addr.bytelen);
 	ma->users = rta_getattr_u32(tb[IFA_MC_USERS]);
+	/* IFA_F_GLOBAL is the "static" column of /proc/net/dev_mcast */
+	if (ifm->ifa_family == AF_PACKET && tb[IFA_FLAGS] &&
+	    (rta_getattr_u32(tb[IFA_FLAGS]) & IFA_F_GLOBAL))
+		ma->features = "static";
 	maddr_ins(&ctx->list, ma);
 
 	return 0;
@@ -388,8 +392,10 @@ static int multiaddr_list(int argc, char **argv)
 		}
 	}
 
-	if (!filter.family || filter.family == AF_PACKET)
-		read_dev_mcast(&list);
+	if (!filter.family || filter.family == AF_PACKET) {
+		if (read_maddr_netlink(AF_PACKET, &list) < 0)
+			read_dev_mcast(&list);
+	}
 	if (!filter.family || filter.family == AF_INET) {
 		if (read_maddr_netlink(AF_INET, &list) < 0)
 			read_igmp(&list);
-- 
2.56.0.455.g6c5a503b38-goog

