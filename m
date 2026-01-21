Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C248B367;
	Wed, 21 Jan 2026 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001668; cv=none; b=HNIkPXn8AFeg3Rv/NaqtpV9A6h5xR8eu38a8dnL8cQDCQSKK8CA4NsFksFqvNiJOqqqQu2pdxhyBHcruQYuf9QXZLjJO76vRIb/v02K0tgBL0am+dFyuLwJB5OplDA/P5zGUoYo5Y3WayJPhaRtjvSZLH1Q3NB6Q35EiPb9CcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001668; c=relaxed/simple;
	bh=TPdEcIfJbqvoBHnoEwlBnlyJ+FPShZCQQ5uzsnJd7n0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT9KqxpwyoeYuFcqqMopeOvHS+hgWeXLs8Ou5BNE4/hUfu0L2L6r8SbhwMus73B3J8QQJG5e4PyC/kfYuImJie3gBSyimBr2cPpuPNAfdPgh7GyP62Ztf6K892cMxT2XzPHZDqNDhjEmdZIC8XYRk9/5ly0ijck3+NwKiAxNVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=g4k6poje; arc=none smtp.client-ip=185.70.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="g4k6poje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001661; x=1769260861;
	bh=TPdEcIfJbqvoBHnoEwlBnlyJ+FPShZCQQ5uzsnJd7n0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g4k6pojemtv1avJcQjJOb12NGsD6P71kYNK1XyAxg9oY0Tjg4ToGwCKXiev89NqdB
	 jPqx2+zxqxTUWaWv9pMrJ7Btw+WlPtQlww7UMZfwynEV4JIPvpVa58UuUmcgjmD3dr
	 pE6jdAAwrmT4XtelenZlaTXa0oFoE4cho7aLTZz3hjxXSyMCpp9hZi9kiNFQs/PT6j
	 valIqdHgjCqt91gMRlP2ng2R3tjekZRpPU3wxLPyMi9RDG5Zl+IMzGfNLdcOuKGbMX
	 K1T1CfrirRzuejchmKGHqltLwfQbN6uEGDyKy1RgOT7HMtI3OFDu+sbKmzI6OIhqBu
	 9K3k9fWTINlIQ==
Date: Wed, 21 Jan 2026 13:20:59 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
Message-ID: <20260121131954.2710459-7-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 7d60970e1245a4f9269fc3b9069c5a4c9c5c7552
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reject empty schedules (num_entries =3D=3D 0) so next_entry is always valid=
 and
RCU readers/timer logic never walk an empty list. taprio enforces the same
constraint on schedules (sch_taprio.c, commit 09dbdf28f9f9fa).

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Signed-off-by: Paul Moses <p@1g4.org>
Cc: stable@vger.kernel.org
---
 net/sched/act_gate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 48ff378bb051a..e4134b9a4a314 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -509,6 +509,12 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
 =09=09cycletime_ext =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
 =09p->tcfg_cycletime_ext =3D cycletime_ext;
=20
+=09if (p->num_entries =3D=3D 0) {
+=09=09NL_SET_ERR_MSG(extack, "The entry list is empty");
+=09=09err =3D -EINVAL;
+=09=09goto release_mem;
+=09}
+
 =09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
 =09if (err < 0)
 =09=09goto release_mem;
--=20
2.52.GIT


