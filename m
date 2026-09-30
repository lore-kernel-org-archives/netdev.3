Received: from mail-qk2-f27.google.com (mail-qk2-f27.google.com [74.125.230.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA033A6F7
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753481; cv=none; b=skJxCAdfClKsUIWFKGUCmu2M7BjGEoO19IdcWxGlsbIxki3H1HbQC2TusBAgsXeqRxIMMvmmfWnivtmiOY4sL9t4zR7SY/IqPchIT0nLLQvVn5jIBtGbhiM5yQTd4mE+s5naSc97J6KNoZf6ylyQNazdS04Y8/KYTQ9t0zt2/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753481; c=relaxed/simple;
	bh=aluq6XDX77di7kfn43swR2cM2XeDL6dQliyhlLnI1Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDoh8bUWGsap/O1qb+d9plZhayKAwxFnsM1RdGtTCDbWr2q0f+9mJ88jRuIksMpX7UsJTWleZayaL/q5C22CONcRbXj0SCL70y7y5uwih4a4pzLq19il0AKS79duLtuyg/mrcjiXpSJM0JzLsUBy5KlUf9MdakDPA3p9WrwXZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=hRBsyt43; arc=none smtp.client-ip=74.125.230.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="hRBsyt43"
Received: by mail-qk2-f27.google.com with SMTP id af79cd13be357-939ca12ab70so621160085a.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790753478; x=1791358278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R9i+4Nh+hm2eKyiJR0k0Xb2So8Jv28e3f/mMEot2DDY=;
        b=hRBsyt43Y5GR1842RI0Vpm5mhMmPtZelsPovzhGBvHDPmrkJmwMLwyFRKxq0XxD/T3
         KcHjBEtvcwVGKsWd/puACt3KdKoh1/mCdg/2wGvjo22nfme58njEoBZqiNBaTnUFgubg
         +E2o1nhixWNCpw9AVGDGVzs2yLo4CsrCy/ul0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790753478; x=1791358278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9i+4Nh+hm2eKyiJR0k0Xb2So8Jv28e3f/mMEot2DDY=;
        b=G5U6biTWukaQ/nihmfF/ld5fGUbcwOHI+Xqt9mTpXE/vr4jCiFOHp4BDiBxHw8Nywa
         4qYKtYe0VeOWYGOAAQ0dr2JqFgx1QBh2pS7xXUePa3rTyC5r5eOOJ5kBmxsq45sA1bga
         mKYpc8DmRLWAKQ0WnUzNayeRg15/wei+StvGdEzCFF3ZgcNRK8PvShYYY2JCV31HrpOM
         KN/38uOYolOPD6ikKzi7FN9agfZb2qZN99y6UIv9YtleJ4mi47mLJ/W3+G/CaGoiTK13
         JMijI4BxAN5ty6RAjSkyHX4bb6ZnQSgBgWKvG0rUeFEb0jdE9A/LBzZcOrahqqRXg7Oy
         xWzw==
X-Gm-Message-State: AFuF++mPaclDApOnFbwy/i2DF3Ultl3OVIT7qHcNMaXwMPNYQ01eiF17
	cMm8YqK/vmUQ91mACYDMsUeOy+zhayxjjJPpnIARkl9qNPkQfZT5kfU/j3Xkw8RO6qzpYA5+Opo
	+KzSuoA==
X-Gm-Gg: AYBFou0hqcXjHJa3omJZqqTEFkY5sCDRj1DbUS8cXlpfCgMWE7a5eZY36E3l+hrw6KY
	6m/TuL7oZmoVZmy4BfO0wKxuLd358UYltj1De2ETTjo4iaev6rHhHbmlUpAXOdKNe6YKT97dHvy
	prM7dm+zMLJGSx5WWm2oLbADetsWBdNp1PD/gQjfI+78Hfqw5hh5e3BqteLn5ddFNbVivCYE9+9
	Tn+0IG1PxXOgjBG5QAJd1gCY79cXT8m/mpWPErxt5I8cS9ss4ZGD93GLxVp6a9ekXN/T3XPDsU4
	FfUpl4mhmGxAUYKAGLJWfdjSosfg4iF/izcPSASc0nPrwC53dJDDcnrV5+mrZu7YBRhwJciHzoT
	w9tK8ciwk3II2rWfjqz2QeurYJKaHNjpR20QaAWj8wKD/DWuuD7fTnS4pQlNqirqd1ykD5IEvPE
	5B5w66qHpf6iAE7e5FCpHpgyP0mHC+xUy4WL9Q2Nko+BIeltSVL9PAzZNKWZWrGxrl2uJGHhUBP
	HCHhlEfA/vjgosZ5BLczPXaPXNHRXkoBrYeGzvUzgQUsFsivw==
X-Received: by 2002:a05:620a:4713:b0:939:6132:62cc with SMTP id af79cd13be357-93ca96c72f7mr82625885a.27.1790753477544;
        Wed, 30 Sep 2026 00:31:17 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ca82ea561sm55706785a.33.2026.09.30.00.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:31:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Thomas Graf <tgraf@suug.ch>,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: em_text: reject unterminated algo before autoload
Date: Wed, 30 Sep 2026 03:31:02 -0400
Message-Id: <QDISC-2DIU.v1.20260929183844@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This is a follow-up to commit 9c572a83037a ("net/sched: fix potential
stack infoleak in em_text_dump()"), which zero-initialised the dump-side
struct. Sashiko pointed at a pre-existing bug that exposed the change-side
input-validation gap open.

em_text_change() casts the raw netlink attribute payload to struct
tcf_em_text and passes conf->algo, a 16-byte array with no enforced NUL
terminator, to textsearch_prepare().  On the TS_AUTOLOAD retry
textsearch_prepare() calls request_module("ts_%s", algo); vsnprintf()
walks %s until it finds a NUL, so an algo[] with no NUL reads past the
array into the adjacent struct fields and payload and feeds those bytes
to the usermode helper command line.  This is an out-of-bounds read and
a kernel memory disclosure.

Reject the attribute when no NUL exists within TC_EM_TEXT_ALGOSIZ bytes,
matching the check xt_string has had since 3ab720881b6e.

Conditions to recreate the bug:
- CAP_NET_ADMIN on the target netns (namespace-local via unshare -Urn
  is enough)
- install clsact on an interface, then add a basic filter with one text
  ematch whose algo[] is 16 bytes with no NUL (e.g. "A"*16) and
  pattern_len at least 1
- the add fails with -ENOENT and the kernel invokes modprobe with a
  module name made of "ts_" plus the 16 bytes and the adjacent payload

Fixes: d675c989ed2d4 ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260918133953.12494-1-bernard.ladenthin%40gmail.com
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/em_text.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 4132f8c3c5fc..bc45edb8c03b 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -58,6 +58,9 @@ static int em_text_change(struct net *net, void *data, int len,
 	if (len < sizeof(*conf) || len < (sizeof(*conf) + conf->pattern_len))
 		return -EINVAL;
 
+	if (!memchr(conf->algo, '\0', sizeof(conf->algo)))
+		return -EINVAL;
+
 	if (conf->from_layer > conf->to_layer)
 		return -EINVAL;
 
-- 
2.43.0

