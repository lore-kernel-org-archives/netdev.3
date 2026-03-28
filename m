Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60EC32B981
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722436; cv=none; b=I6AKYARJkHtuiXbgFNB8T/xFA+KIkcIf3Vw1+l7HKp/3u6AcQAkB770N/1ohTNRWe/3JN3avrm9VnDtEEtwpkFok1EbhwlJFntTlb1Pqp3z4PjIxZb6FlCHQrUMxbC4w9UDu6E++4SrRtHgmf3VOCrqguGuvbuq5ErTo23M7Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722436; c=relaxed/simple;
	bh=vWCfbKgDOXVscJfwBqXChvteOFc6ZwrasQG1CoVEBTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DS7HCefyktxQ9ipGRxtDt+DnKLcPnOos4437w3nYpeVhxF923kldsRBxo8OFgKVv6JGZPlaSLWSKY6xiM4lswNTBO1gnfa9aVhE3o/mzZjE5FbW7Nq1TUwop+2G+D22OhLwCwhkdrI/7zLLh8mcRApEMhCDZZoahLvbRHJCEz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=k8Z+62NJ; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="k8Z+62NJ"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1273349c56bso3905327c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722434; x=1775327234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCK1rFFgz2ldDJe6Gnfaq2WnJMurplt2wHwwl/GRb+o=;
        b=k8Z+62NJSoD3oHmbSCQyQObl4Es+LS1FcK/1w5impBCBNAelvOBIqf/6tpQOzcTpI3
         TKqv77Gj+LNXbaOWUeYebqWi1Gsvogs5LMdjSFO7MgS7NIFuPpCa7RGUPvkOklddQaam
         H/oxc0XxwjpKCU5fbni541/rstZA8NMHW15Z7iilaiQgfvbE4xOrbIcm9YTL4VNDGvh1
         Pfi8F0ioeNPbvNyhE0H6xJKfrRSPrcvTeOwKX6oBJmJ30v4+LYmJleJ1pKORzZkLQhnj
         30YmjdKBkrP016XtYFVJEF0UIxAf9K78YmT+R2UAz5E5F6HPAv5QXqrTbwu4vLuNPHFl
         KRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722434; x=1775327234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCK1rFFgz2ldDJe6Gnfaq2WnJMurplt2wHwwl/GRb+o=;
        b=fBdGnZxP9jfb5Ypuokglr84EN/cThiMH2evSipdikv++MsTdtm9ij+7/IwAzMzFSW0
         IIqUXjPjDth3Y8FbGvaAmwnN8I4h18aDbiMentegKZ9mSH2Y+7na+daVjTUkiFnjeySL
         SdVtphswQBqGq6f67dU4oMzsnkmodKQGVhQnpRgF4w5cHqN/jkvvGAL0+Txn/9E95kvl
         0c/7WunsQpLwi2wskl3j9JFonMXvjAWH6yM+GX2JwqYPHf2xXfl02050at4kKLwDIOPd
         jkz5JyJDBwItzYsS8WrIOk2p48G1odf9dEIDznMqVPOeIk+yjPTtN5us1vwbtR85j2Vv
         W72A==
X-Gm-Message-State: AOJu0Yz10LkOVGoKx57t324Z56MDgtfjS5fwXP2SemNFW5N+coKpRInz
	Oldvs9wRaEagFF90JpKcDOr/RocKvXyKn0t4q4d5MG74n5R3xg9yVAy9RZlnzcSqDClayWAuwO8
	gyoNU
X-Gm-Gg: ATEYQzxruQKnKK1S6hxJYlTnQ9eTXdlIC0+dVT/QxQXOVMzihUv0rtvW0uFnCp9UwEC
	f+Rr0BbHN+I15n2eTs/CRwGzUNLnxhnaSOSiuC3+mcatougxuX3gultHxbRAzuaVb/fr1QmT1wV
	AQ0Mh/OAOCWKRagpX/Rtegp/lidMJidiYwh4ttRYELSWtmXzR5Al1xM/eiNPwKj73piJDmUha4Y
	CEN4iszP6ZCPVRf6K4pf5BjcnJjFV4rcE0PBuTHxKDLCceslCdVuSMYi6oeeDm2TNl/8aNXnx0p
	x++4xoJhb85/mx7I3aQu6vUDjP0d21eDlNAaAiMyuPK5nJqdvu6Va+iPiT2fubg2l1TgPVpYtMy
	h0k0WbfPuDaHiLKKub0eU3GNGHQThIDW7FhiHVk3N1L5aYbRUiLuWujaa+q/vmNOTrKw6luGqKO
	HpkoFedrJ/TVJ7Z53xg5/OCmarvej8ttHO
X-Received: by 2002:a05:7022:2387:b0:128:d29a:3d45 with SMTP id a92af1059eb24-12ab28e9a8dmr3856988c88.22.1774722433886;
        Sat, 28 Mar 2026 11:27:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm3909263c88.3.2026.03.28.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:27:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 5/6] net/sched: netem: remove useless VERSION
Date: Sat, 28 Mar 2026 11:26:06 -0700
Message-ID: <20260328182704.456993-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182704.456993-1-stephen@networkplumber.org>
References: <20260328182704.456993-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The version printed was never updated and kernel version is
better indication of what is fixed or not.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 87caf1b9a4a7..26fc68e34b91 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -27,8 +27,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -1379,16 +1377,15 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("netem");
 
-
 static int __init netem_module_init(void)
 {
-	pr_info("netem: version " VERSION "\n");
 	return register_qdisc(&netem_qdisc_ops);
 }
 static void __exit netem_module_exit(void)
 {
 	unregister_qdisc(&netem_qdisc_ops);
 }
+
 module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
-- 
2.53.0

