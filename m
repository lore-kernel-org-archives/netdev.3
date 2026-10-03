Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED11A9FA0
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021302; cv=none; b=WdIQqJwLGy/w5zKdgeLC0DmT3HBI1ITmUt093yS+KAp41sjhVGFeKQhqenvRajjokcGU4fUnb6nKA49gIb15r2jPJ7FVhbJDRuSMJXrmt2XT1Zx5jQqNYDV92CHPhu1xf+C/QMwIMFwhTKKdq/rNbt+Ims2NkITHtd3xvDVcTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021302; c=relaxed/simple;
	bh=LWL2mpu5aKq/KWBeDWwk7AH+dZECoiTwjCRx9zv3wlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umCkboRxyLQux2AiT0PIdgBI3bTWFilb07eyln57YTtJxVJodrZJpB3gwXwoTJEJZxB7PKcxZU3HvJKH45bB0ISUr9sqwPtEg4oRRXKTXJZnRzdRWPdmchYr6q4a0vTvQ0iBx13IQ2mVWMXiwJSETuoV+cOvQPYOdoG+tv8aGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=UKez3Ijo; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="UKez3Ijo"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca17so1351981cf.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791021300; x=1791626100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNeW7Vd7tIlOnNM3yD+vQZMp3opWNzf3Bnh6aL6k2qI=;
        b=UKez3Ijo/ujA7dJTUFD7JUhCtO4ZpDrVGpzQ0FG4MF6PXwmzjrdg+L7LAgX3+ufz3z
         Qn+qEB12+KI0Wwjy0DqsDdiQON+gOZ+55gJwLn6SeuQ1KFpVMiB1Om7rU9XH/Ijf1gv4
         f/c889fdAdzx08ay8SryNXdQ4y7aLtlCkvY1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021300; x=1791626100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNeW7Vd7tIlOnNM3yD+vQZMp3opWNzf3Bnh6aL6k2qI=;
        b=pZ6Io98LjhBLxHzxgXscS+MY3i28AR5wlH6UbcpA/7fJlY77MzQcbhJjXY1urM8TWP
         ofPXnQNdy+5vWiDvNrVzEBtJIBgkpvuBE2YaMrSkQrMKc7wl0rJ/D2iRPlLRwOcjwsJf
         6ZSRJokITwURnNnhMzEGkmEL32D2Zxfl2FdEnLcSYp3LhPpuXo/0ouI45GvpXnBL5hU1
         n1onwRonZjWS9YwnNZ7596Oos6GanSYznHbhxnSI9NPq81ln4p1DYE7SXe91nkvXL1FB
         ddQM7aPxUXRnToB+Ti5hCtXKMCKtneqXpka+m7ttnfVa103yLpXoHYT6CUFsuBjvxgJZ
         ICeQ==
X-Gm-Message-State: AFuF++lQ81TbRzUiOd46ErnlYWSS0KNF/+O4Z2wtk6HOi229H0Rw3Hax
	I4AZQj6nRWck0U2WfbmMhmMt+9At002ZWhEj85Fk0qzxudBLeyCAQ5vXpQ02h49tzvWNgNwtx3t
	17AM=
X-Gm-Gg: AYBFou2mq2G/PImPZbmdlLoeAujCikBd+sGSYoWOLocIu1p65AQ7FypBxLXDEXPl0Cx
	bhAjkxBTkuIxbSmGyWN1gyIiJvtqq09L8DRbAmJZKXY2P18bmJHF9+Mgalu1ir7cpoaVdAxccqu
	B4oasiphuyqIOXX21icpHNnvAZqdzxFxNoVp4vdgQfh2RcVFrUlbPDWi9VbNs8dO/d2Nmzvy9nv
	qI6G0jMbIbzLKsKwSLX4kGQKqjLvmZ/IJ6g7uaC+EbI6ug1QkU53MfV7dWPYt27tOy45/oL5dKj
	AoFjN2Brrl2NqfrAeJHUStOd1yqBzkOzhpn4Hou0QKN3TbqczpSJ6HVMkzFjWH4X+SscB10YMgK
	FZhJjFI1C7tFLmrCXVuafeLg8nMJDRv6vYXwxoB7r6ytG+Li2ObqoI51oWwT+EPLmPwgDzB9+9u
	oiV6/zb/YW63GZNh4BO4dTcYP0bDblQur7izSlg6kEWphRAk0/SGysElyjNoNN8s63ImxfD88/f
	WgWZgcWbi+wO/edaAN9l7yu0h4eIe4eY5SFTYAOVhWXqtvIwD9OPbzWxhjI
X-Received: by 2002:a05:622a:610c:b0:533:8900:4eae with SMTP id d75a77b69052e-533cba1ae1emr103536221cf.13.1791021299729;
        Sat, 03 Oct 2026 02:54:59 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c3e2bdsm40853956d6.49.2026.10.03.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:54:59 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 1/2 repost2] net/sched: act_api: reject duplicate actions in a batch
Date: Sat,  3 Oct 2026 05:54:53 -0400
Message-ID: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20261003095453.4jiXbPK5mkXck0VOLiLu3sM9l-NGfDiZ4G96YKNDV-0@z>

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

