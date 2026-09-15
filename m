Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C32469847
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508217; cv=none; b=OMVWnPdUAfLMrL7OHCk505aqNkd7lCJyKVp/vvAP+dilW5MaazBWqibJmt9IddUYsYJmYLGZPhjL0x5wtAEkIuwp7dtA67bN2ztpGbRs3YQDvEeql9taFVywCjep37iJECY5FlybHN6+6zztTKgzgNXCP1Q9eiu6YF7OEuCbevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508217; c=relaxed/simple;
	bh=ipnX1BwF5LF1et9MZijR8J2Qc1OQ8pdKNvi0KTM66uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZgCMlF0rhxVqDI4CFIArxq7+g7AuXvMLy0Bl7GrAYvWHQVT2BPkaSOp8M2QIdt0hXUhSZW0acQ9BpdK9seC+fFB2JwiLUhAe4WMDtPdg6nwNesQsAhVPjCeJorNEA1gV0gIQoafa4dQkr7DjyEYdm2GNJTVdbA8f/wPdM4TXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=w9tR2VPe; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="w9tR2VPe"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb65437so158411a91.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789508215; x=1790113015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9etofct+GParLNnJVcjLss/XIfB1EgI5AUk1cxrTNck=;
        b=w9tR2VPe1wkCXjpK4uHDJZDRdGI00B311QXEQw45pTLQsg2RmD6lkwWwDF9LaTtJG9
         oh3qvW+NnKFahG/sLjVUP4WU16vo3uGVsKYyBHlHqxbrjPL6MAZQuSqdVcZEQDia14L/
         kgQWFWgFkZRZxwQkyabhm78zOWL7RIcL7KytB73H92eNCo8nWjDiawe7WeyoZiaaszxD
         2wEZ6ZkYar0vJjMP2H40n6ri+jLq1lvqM/5Y7CmMSzqsu+YxzSaTLi8MufMUKvdh+YJ0
         L8OY18oezdQKoUVJDDL5JBblW2fe69F0AiLUAYyBffVMJ/1VzJfvBCWWSTACbzhI+LS0
         7Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508215; x=1790113015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9etofct+GParLNnJVcjLss/XIfB1EgI5AUk1cxrTNck=;
        b=x0EHx0qoJRrSk+JeXBx8SXZk6FGJvrlSFRnAyTpbtU4N/a0ocrJmB1t+kcVpB+iyue
         wsoZ4Q0A6C2XXk4ft+k+h3nUW4rWYYrIZxP2wE69l1RgaJlRhcAn6pfVEBx6c68QVmbX
         NtVSLXTiyaMp65I9c7vTgqrJOjGmqn7rlkXtHsyjFMCu3IVmtMSLCkcwP251tzPXK5Q2
         G5/K6tcFF2092Mcyufg3G61oQDwpceh8I7J3Q/0IIfuDmjAznPtxIN4go+eTXD1pTqhm
         XIzfQnO/oEN/idwQ+bnA3JgvfWh3RTBMie/25asqYmNY/hbsjfTRxYxS2dGmQF+fW5z9
         fr5g==
X-Gm-Message-State: AFuF++loIXx2ahJfN3wR7K66M+dhwAXEzqxsoMcp0OIrvfU6BF3MLfCt
	S0VSeSji2oWnzAy5d0LAkiDOWwYmYOcwVelvB0baQ2aZM0r7I9xi1cj3EcvucZoJ2n3vsICzrUw
	Y2UHfBJJ8mg==
X-Gm-Gg: AYBFou1t7MDUEc8FdziW7PI29hol7fZhbZvhDCkskct81akuCF/2PHC9iX2deNO4RYv
	++V+FDORGK8MvevJ76aeeCdLUTlpW9swMqEuuqBUl6jSxrkVQtRms2Z1LBN2GxDjtFIda8E8Q2G
	+QLlei39fa1DkRQ8c7e2BZkQ+yiLqUewxhcVWa180gla0ielOYtH7jInSvsoOkdi4dlY37dzOYW
	JktTha7CpHt/xS4yd9JNuJPh0xtQVpLdHCszoI+mXxEZlktkU+Tpy4f21G5it45nB4uOeqGFted
	vKYKeH/lTjMLEjv4YNvctkr3OYgWNd7bV5EJ2Z3oYq0qhgGuYmMuX+7/XAuUTnd+B1/EgLjyDDR
	ZB8DAufbBpvc+QUml4lcORSqtzu7wcqcAnw0f/wxlcvE6KJJKqcKW1DdMnawpsfI/fmaK1zEOUu
	UROeLqMKEeDvnN3vagBo9EXO7TU2hA7kpAG90zxOwHMbSSNJ5hzRUJKi+4yDH/tXEr0G/D/4u1y
	STa2/hEpcTF+indu7SB3w72fmV40yz7YSomBA==
X-Received: by 2002:a17:90b:3c11:b0:39d:efa9:cd1a with SMTP id 98e67ed59e1d1-39e1e2655e6mr486443a91.4.1789508215382;
        Tue, 15 Sep 2026 14:36:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bc37f58sm608504a91.14.2026.09.15.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:36:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 2/3] ss: warn when packet socket diag is unavailable
Date: Tue, 15 Sep 2026 14:36:03 -0700
Message-ID: <20260915213646.116214-3-stephen@networkplumber.org>
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

Since the /proc/net/packet fallback went away, "ss -0" on a kernel
built without CONFIG_PACKET_DIAG prints a header and nothing else,
with no indication that anything went wrong.

AF_PACKET sockets are present on essentially every system, so an
empty listing reads as "no sockets" rather than "ss could not ask".
That is unlike tipc or vsock, where an empty result is unremarkable.

rtnl_dump_error() deliberately returns ENOENT and EOPNOTSUPP silently
for NETLINK_SOCK_DIAG, precisely because callers used to fall back to
/proc.  With no fallback left, report those two at the call site.
Every other netlink error already gets perror("RTNETLINK answers"),
and rtnl_open_byproto() reports its own failures, so this does not
double up.

Only the diagnostic on stderr is new; the exit status is unchanged.

netlink_show() is left alone: CONFIG_NETLINK_DIAG is genuinely
optional and "ss -A netlink" is rarely the only thing a user asked
for.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 0b7ba256..7ec72c04 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4913,7 +4913,17 @@ static int packet_show(struct filter *f)
 	if (!filter_af_get(f, AF_PACKET) || !(f->states & (1 << SS_CLOSE)))
 		return 0;
 
-	return packet_show_netlink(f);
+	if (packet_show_netlink(f)) {
+		/*
+		 * rtnl_dump_error() swallows these two silently for
+		 * NETLINK_SOCK_DIAG; anything else already perror'd.
+		 */
+		if (errno == ENOENT || errno == EOPNOTSUPP)
+			fprintf(stderr, "ss: no packet socket information available, kernel may lack CONFIG_PACKET_DIAG\n");
+		return -1;
+	}
+
+	return 0;
 }
 
 static int xdp_stats_print(struct sockstat *s, const struct filter *f)
-- 
2.53.0

