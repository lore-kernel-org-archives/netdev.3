Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2E4D4868
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077861; cv=none; b=l5mpufyGcb2cC+LCr2lJalvcYk3+19cUzMkdnp8wOewQbCSRpTEtLP3UOOyDLvb0Uk9eTfV7Q6zyT9ng3PcotHmV+81N641NkdKZyNOYJRHKwabBxESVquilyzVKVNZkuq77KWb0frhO8M/lOHaDCLMa/ypC1IuUTxd4ectrDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077861; c=relaxed/simple;
	bh=9Z0/S6ZmABrK+l27B5I2Z8yd1uEctVo+Rmj2z6kxKM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y1kmjm1E3TzeC1kz9Vrk2LFYHh5QJ5tfM/7SozWqIgEDy7YChm5ThHG+H2jhai6mDU3e8TtuDMpBYrZvNK2rKxKjKowmu6ytkKeetiTr2rgjLMzZYSOv7aEci1Bbw8dWwxu4H7ohxySAAw0f3CUaT7FZ7YobpDGHySOjeaqdCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fAZI3SPP; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="fAZI3SPP"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5311edbc154so33106181cf.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790077859; x=1790682659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0saLHrvWxSfUHEQ01OMjuyvbZ8NuQR40GLYKRy9/kyQ=;
        b=fAZI3SPPERHKxgQmI/DGUMQH1VuMotPv+gSaFIhp5ZVzHOKJC1pQI4ws5VLRZEbNYz
         Q2UZrnhQFiRCmbx9FFMEkswIkggUl0M4SyEjB8paYTGQc2BRvXVB6GaFOZaecf/K6MiP
         MsihZJszrKZkDTh7QL9KcdE3Acl5xQgiei/aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077859; x=1790682659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0saLHrvWxSfUHEQ01OMjuyvbZ8NuQR40GLYKRy9/kyQ=;
        b=p+KF+OachiBZM4SJoL9ZdypGHXgVyBFUlEc+bMDFxkf+w97/IeiTtxNr5OtUYZ3xuo
         ulGlORgO3HbHgIY6uNDuY1UL4uC3jbvrzDGe7W4en07ovftni2E40CyCwK8QMmRqbaok
         Lk3wX8ngRNtWXIMqP97ESEW+H0vc07Qy/pIZ878lfiw0E8SgA/cJeVt1mNUW5BK+fkub
         kApLdDxIYWCurnrYKHJM/mbPFAFnjvSSJXOQFeOlDe0bKPz9qBdllBHmTOcEzi+YbQO8
         ZuYvhMkO76yEukvDwKYQ8OdK816ju+IjJ5y4t+9TeV0KF8HPg/PoUuK//s3RA/odRW27
         ByFg==
X-Gm-Message-State: AFuF++nAVxoTWfWhGBv83+7tA4mVO+wb7II5pofXqCXlS5S1ugxZ8SDx
	NwYXe1UdktZsHTg+zCTPCd6j9c17z012xjJQUkq5N3HCo7lqTodW/aHGUC/wZxX+W0eFrRhkRlU
	wYKQVrg==
X-Gm-Gg: AYBFou3MLmlfDnSkKotMdyJU/76VJ11cyh9M4GtkBY8Sj8LEWaW69RZ2Pj2AtVYa2uM
	KfpxjjpkpK/voWUuCXYch6cC/wWov+SwtcsWWntP3ljlB7Ss8FDAODA4ZaQBow7jbwhMkQzVomk
	QCL7PAX927Y6xh8mQk5HMu7gzipIdkyM2wDtz5JIu8tWEl0hiHmvzGea9wmQf/tH+WZ0jm4G4eb
	PMRpKd8oy8NnNk6r5sz+qsoNJx+kY47aJTQsS9jcNh2lAFQWHVBXP+dtF5ZszXn2RWK3nttvkA1
	KJ+2NVPpS75jL7fNiokiE4UC6G86yp/0u5oIlmiMTUBK91+8MJaV/R8ew44xXKZ03t++WrZ8V6e
	jEDdd+Q0cQyjLhub4dOP6DRCaRbrlsNHrPKegc6I2ip/YCnQtv2DZ5CdOgUVdjcFHzTe0NYGoBI
	tZkBnYHWKfZON1Ocwpd3ex0+NmOBBUF0ehJlcA/xy0YUZgenQhbhpasz04S1cETCvQilFLasbA2
	hM/DKHveKHrJpF+Kd+VMnlurOnRashdjL9ArehonWpGVFdqUv2BjsOduuCUyspTtz0EqVoibzcC
	pMLrRVM/8r8HBYe3oQ1laDM=
X-Received: by 2002:a05:622a:259b:b0:530:f9e4:a0eb with SMTP id d75a77b69052e-532d8d21d97mr50658031cf.18.1790077858801;
        Tue, 22 Sep 2026 04:50:58 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e1903c5fsm10927391cf.16.2026.09.22.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:50:57 -0700 (PDT)
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
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 1/2] net/sched: act_api: reject duplicate actions in a batch
Date: Tue, 22 Sep 2026 07:50:54 -0400
Message-Id: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
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
Tested-by: hybris <hybris@mojatatu.ai>
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

