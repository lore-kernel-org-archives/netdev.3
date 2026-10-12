Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006964ABBD8
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828575; cv=none; b=gr1IablPCYISCveMBeJw6sCZEj7KugdRS8hfFDJcxFi/VCwGydbbVubu5UdHo6BrWQ1zugMd1NBzcSIJfYH72WIX9Yyv7GSUTxUZ10DxEKu6FTd8H8/7XaZEaQ+sxrfRCmbqFP1/8thYkvaEONmqVUZGKVaxYAs2AqFTFIHYS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828575; c=relaxed/simple;
	bh=LWL2mpu5aKq/KWBeDWwk7AH+dZECoiTwjCRx9zv3wlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0RmA/LVuJsdEXZwE0745cRNFoRXSkOIikzChUJZhsY9MBmcWG87hCgu1VfV/SJvdrw+fjdLuhzYhNnPTDJVY0qGKULa3EExPgCaQAFAkH6EUqBvK4swB2XBYvocWogT7InKCewziWbF+PWXqNctB1B6OV+wzstZ9jCWYgorggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LfZ8CQ5Z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="LfZ8CQ5Z"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93cc1ab5f6cso270704285a.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791828573; x=1792433373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNeW7Vd7tIlOnNM3yD+vQZMp3opWNzf3Bnh6aL6k2qI=;
        b=LfZ8CQ5ZoATgOxbOdHVgfN5nyVJBecP0rSQBYS3vJ1TgNQtYWpo1EtqWriQpruYDY8
         MTe7/Ijc2Z2PWZ7HJrHtmXFC9hK8jOuQscqMkUexjHkutF0Oqst7B7L13ryY9inoK20n
         imWaQ5dx6EVEwC0vpqX8OsJ5SMMKHXNtCxw/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828573; x=1792433373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNeW7Vd7tIlOnNM3yD+vQZMp3opWNzf3Bnh6aL6k2qI=;
        b=tlhywMIcq5G5MtY7X/xI6eKxzflLf6vrtUGX00k2u8yYLhwDYYFhFMnxEUIOzU42cu
         VUlQM52oAe9H0cCkhuZ1SZ1XZJJ93rE0FjZm5OuOA9SBmp17LglMPMVPeuS5jrx0mKzJ
         9s8twEmxpkZg0EaHW7Mqv7ScOwHynGtXq1ShgKdGs5Uz1jDF03z9cQwEBIXLFDrxC6gF
         NsfrOei5i2fR7mA/DfADLbco3F/vNtMMIL0DZ1AMGkXDbzRDRNmIoHG2jqgcSGvg8/WV
         eNKjIfC30aFOGCQ01VINpOkQMgz3reclRLAlbvDpFiSNoewvZ4zPaWdia7CbRemolJSN
         ruQg==
X-Gm-Message-State: AFq9FYKIgYgnzuZhwL1LBj8rkMuEtDQ9PqAXjkdQGmLaT7+Ngi7Cueth
	7Vii47JSlXDQyoX6gijp2Ss3gj1gn7vHR8ZX+1gzwYHIxiEAegQD+Q6GPmDEUMfY8Kr4E8h4zn6
	+vTo=
X-Gm-Gg: AYBFou1/ZYNjpDn9wnnyhdHTVFGCLjv1FHsvl6zH9ecLYMOFhPGI6epjGmIMvOUDDQV
	Tt4l8Ex2R6P4Cp23k7vpo2UtJR3LqxybilRNupwZmnl4CrdNj/Cq/0w2UVYoMoPEyEIlxJsmim/
	WUYGwJ3Kwwwx8rQuSF/gcFmd5K8ZkHrq2N3Mpq72dHndTyQKoawVqlFL0SDm6UdKp4OfI9u+nUP
	HKnBRPiS9VxKu6oDGxwRhKTOEvm6VSem56qVqvkkIP6KO2BzSNz97k2kLZP8Rbw4XBX6HWVYD4y
	ozARkunD0RFyBO/0p+1heDyKmLjyqqvQc487xk4T+bulRGCKivv652SSL8yAKBTGprYA//mwK1u
	b/iqfGLuqOiBPW/aXEjiWrXSZ4/84XDrxvOxLP0GVwHxaROYA9uODmrehE8/WGSa2QnptR2K9QA
	mkHM/P8y7UoV4nZ9yFYX4LenzJ66HKzNtXkDYx4P1czYEanNKxx/gA1urIIk4dfUetFe63pGjU0
	kn2FtS2MoGUolMeNrWrGEz8r1l/wT8+GZVyQLWadbyQ
X-Received: by 2002:a05:620a:2713:b0:93e:c12c:fbb8 with SMTP id af79cd13be357-93ec12d0844mr1837379085a.69.1791828572875;
        Mon, 12 Oct 2026 11:09:32 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm43794885a.37.2026.10.12.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:09:30 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Buslov <vladbu@mellanox.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net 1/2 repost3] net/sched: act_api: reject duplicate actions in a batch
Date: Mon, 12 Oct 2026 14:09:25 -0400
Message-Id: <QDISC-K1TH.v1.r3.20261012134653-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tca_action_gd() builds actions[] with one tcf_action_get_1() per nested
TCA_ACT_TAB entry.  Each successful lookup takes its own reference to the
resolved action, so repeated TCA_ACT_INDEX entries in one request yield
the same pointer in multiple slots.

For RTM_DELACTION, tcf_action_delete() then consumes two references per
slot: one in tcf_action_put() and one in tcf_idr_delete_index().  A
duplicate therefore drives the refcount to zero mid-walk -- the delete
frees the action and removes its IDR slot -- and the next slot calls
tcf_action_put() on the freed action:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:87 at refcount_dec_not_one
   refcount_dec_and_mutex_lock
   __tcf_action_put
   tca_action_gd

Three duplicate entries are enough.  Reject a repeated action while a
delete batch is built, dropping the reference the extra lookup took, and
return -EINVAL.  RTM_GETACTION balances its own references and keeps
accepting duplicate entries.

Conditions to recreate the bug:
  tc actions add action gact index 100
  tc actions delete action gact index 100 action gact index 100 \
                     action gact index 100

Fixes: 16af6067392c ("net: sched: implement reference counted action release")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e45a63be397c..a9323c42a69a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -2026,7 +2026,7 @@ static int
 tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 	      u32 portid, int event, struct netlink_ext_ack *extack)
 {
-	int i, ret;
+	int i, j, ret;
 	struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
 	struct tc_action *act;
 	size_t attr_size = 0;
@@ -2051,6 +2051,25 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 			ret = PTR_ERR(act);
 			goto err;
 		}
+
+		/* A delete consumes two references per slot (tcf_action_put()
+		 * and tcf_idr_delete_index()) but each entry takes one, so a
+		 * repeated action would hit zero mid-walk.  GET balances its
+		 * own references and keeps accepting duplicates.
+		 */
+		if (event == RTM_DELACTION) {
+			for (j = 0; j < i - 1; j++) {
+				if (actions[j] != act)
+					continue;
+
+				tcf_action_put(act);
+				NL_SET_ERR_MSG(extack,
+					       "Duplicate TC action in a delete batch");
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+
 		attr_size += tcf_action_fill_size(act);
 		actions[i - 1] = act;
 	}
-- 
2.43.0

