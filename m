Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297402;
	b=H6uLkW/SOZ4XtVWkgpfbhpMhmzi9+01bgKuO9V6N3OKdwh9NuaeAxNtnjHSqgbmCWP1F
	 +7Wvnk4+OBqGWHOpEaajTF/a8lW9S2jIDwW3+XzUJT3R3fl0BoW7bFuHPTIwRGmGnKCzD
	 iU19D5OUa3vW8PmhN/VCsRPxxLtMAF+LYKIubJbsJEPPlxWL4OKP2s6QvbFv3NWidG5lI
	 bt/Na/fLLZImwtrMRvi3onDJBb1CfqOzIty7uXefIMFIipq9jR90CK24spx1aJmqL4iKf
	 vQ4mKMUI6Gj75eXk4+yW04j3H9jXilrwwPLjBXql9Geae3ogiBxpABeSGwYCbTnLmOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RlQUuYiz1FCtWrnI0FR4amz6PP3ZtOjRWsNP3c3RScw=;
	b=f7dESd/5+/0gOiTZlTn3ct46DAJTsYiAPeCsOn6QA9iyod+cLV/LiugUxVni/jvEGAgl
	 qh4z+/0Cm2UGeGGSoFMmNBjEbL153QYShAEyimD+/pqZcWAle8WCsemzN73HPU54ewB/C
	 9p0+jTHA4ESgeGltSvP5m08zKadR1HivZh7azRb619nz/waPuHQB40pu7+qj4TjTC0gn4
	 5g5NhyL8B9psw9jlEUUdkdVEdRzukhjAb/GuuvKrCSZNUd/IXucyFWepPWwF9F2GxirCd
	 53M4R0aJdi5Nvz1yU+US6rHBHTYZf0yiLw4q2NhKGBUpZqyaH6BkvKqB8MRWtcyIGNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Xg4K3yuf;
	arc=none smtp.remote-ip=74.125.230.201
Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270B60A3816
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5270B60A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Xg4K3yuf
Received: by mail-qk2-f9.google.com with SMTP id af79cd13be357-93f53f29dbfso108482885a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1793297400; x=1793902200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RlQUuYiz1FCtWrnI0FR4amz6PP3ZtOjRWsNP3c3RScw=;
        b=Xg4K3yufJiDKy1nLDLDolUzOXCylFf4dVPixfUWzJM314JVKpNGNgsDXm9hRXOwgtg
         zcTePD+4YKcudndMWVHz7cYAc6e+Qa5LMgRlZpZToTAAW4paAre25wbbrngIJuDwxzHs
         Qce7jr+X5ZqZQWvavz4EzAePVpaRs8uVIjzCpV8jbKD5ge5+eiPq8VEAvddnI7PJHZfu
         9tgB2zK00oTffZsleRejkG0eIT0Zc7lpzsDTG+DPN00zDNIvECvIkYpdlgWemf4yJrN3
         Fm615h+K5RkaZg9p8NU10M4PP+NrwPAVwSKSwiIENJ9OYkHxTtdqbnztIiALdubjE6Yt
         dpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297400; x=1793902200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlQUuYiz1FCtWrnI0FR4amz6PP3ZtOjRWsNP3c3RScw=;
        b=YQTArqAfIhtNEdZcax6z0GtZk8pZqD3p+Dz1gXf0itBziH3QcYrKV7imlFDCAiYh8R
         3XptCE8tycBOkf7gEOz4sXDId1sbqaOhY/87CqFh8pjpclY8EOGcsSR46/yCz9+GrkPI
         yiuW8zg3LmUlUo290np2bwl2I9wAGDmyMaE/65GiUF4/QNjcxjGXWp1GQYnILBGFvMJE
         MymOz9OA9TncH7c58HxB3JD6rhaksTTT9TYfvM+qIlIfcgHPligrPuh92ZjHeXp4lTt1
         snFcDjpfcqtn4voxowxcG7nIPKFLS7J2l2QmxJM0DIzLy/Ftp07iVUpdoiLi275eclQK
         QCEA==
X-Forwarded-Encrypted: i=1; AKwUvBzAvxs/uEd0hnZGjr8f9NIjGchPxfrE/WccupwraeYS7qdjM4R3O4eaxDW+H/z0wBNdz8jkZk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVZz5BDhVX8wDh6ztH9bpcZh2lP1EKBOOi8XD5VGMkTkdF7lrn
	TFCq6UACkmMuo+PT8E470eWYsxhJr5mXwXRoykxGU9/LHWiKyplaqVHTNP4w0kII0Qc=
X-Gm-Gg: AYBFou2lf+c+lcvqyMC2atrPVzyibfaTSwAn6TH0Aw7+kjYySeAzqZYocpmOlFvJfd1
	NHIBokewOpRp9zXh4Wlv11Kw9jMGo7ztvsns3/L+Rzn+2ADQA+X+JVk5muz35OmP068VsaJWhoB
	nyZYU3UFs8FMgc9VduQwdYbsXyyVWRbPLZWNHTkBcfOFCdO/wVLJXlblSgvhhDUFahQg9M3il2a
	MCYtAdRv1nLSQNx+GNXpirAc8Qo62sF2J+v99BAJzu19JIYJZ++FmQoh/qXrhfXOnNcds9m7Ikw
	xBkcoULkdRH6LJkcAtGXZFz7rZ5fFMgejplroNEoZiTSZsP/jPafDEI/f16dQnfH6cwPB/tEN9X
	Ys+REUyIa6IB1pUOvh23XRvAX5bxLM0whP/aEONroIiuQb3Rbn3EoLjLMrU7ukrNoEIbfPzniEC
	vB7XflvGwmgTj7vYiBNPp3bFOQIvegG336cHvlrBUXD/y6iLnEdhub4I1IiEt5IHPQfFwme5LfK
	L+l+f5T1YdrcGzVnzg9RliAnDey10CplXeIv15/7QS8Q2I4qIOk4XV5/XQVjq1TZrRLt3z21ul4
	q3QEnuZPwVklZgCdQXfyEabCI94CUgC+Xnu/rY3IRK7mvgvcLmypOkIL2Zj4h5Ag0LcV7exd+Ms
	YzETYsdnbrk5+4Bq/OZNfqy5mQwLFRzSQFaVe
X-Received: by 2002:a05:620a:a0cd:20b0:944:12d5:fd45 with SMTP id af79cd13be357-94412d5fd66mr399408385a.70.1793297400257;
        Thu, 29 Oct 2026 11:10:00 -0700 (PDT)
Received: from localhost ([2600:4040:2047:3600:64c0:68e:df43:40e2])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9442120c8d6sm6925185a.21.2026.10.29.11.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 11:09:59 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/sched: sch_qfq: prevent aggregate self-replacement
Date: Thu, 29 Oct 2026 14:09:57 -0400
Message-ID: <20261029180957.43015-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.54.0
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

From: Kyle Zeng <kylebot@openai.com>

qfq_change_class() snapshots the current aggregate settings while
holding the qdisc tree lock, but drops the lock before selecting the
destination aggregate. During that gap, qfq_enqueue() can move the
class to an aggregate matching the requested settings.

When qfq_change_class() resumes, qfq_find_agg() then returns cl->agg.
If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
before qfq_add_to_agg() immediately accesses the same pointer, causing
a use-after-free.

While holding the tree lock, skip the replacement when the destination
is already the current aggregate. Any estimator replacement has already
completed, so the class change can finish normally.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Link: https://lore.kernel.org/netdev/20260731140533.566493-1-david.lee@trailofbits.com/
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add the net tree prefix to the subject.
- Restore attribution.
- Remove Assisted-by and add stable to Cc.

v1: https://lore.kernel.org/netdev/20260731140533.566493-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

 net/sched/sch_qfq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6f3b7273c..e900890e9 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		sch_tree_lock(sch);
 		qfq_init_agg(q, new_agg, lmax, weight);
 	}
+	if (existing && new_agg == cl->agg)
+		goto unlock;
 	if (existing)
 		qfq_deact_rm_from_agg(q, cl);
 	else
 		qdisc_class_hash_insert(&q->clhash, &cl->common);
 	qfq_add_to_agg(q, new_agg, cl);
+unlock:
 	sch_tree_unlock(sch);
 	qdisc_class_hash_grow(sch, &q->clhash);
 
-- 
2.53.0
