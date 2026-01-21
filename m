Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch [79.135.106.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B9466B4D
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001673; cv=none; b=KPhkmJJd7Yr3i+hD2YTdZnhAFV7E2KNSk9Gig9rk+iJTfdVtSS/vogE2/u0197cUgf3jWq3R23VtD8OQH8lNH4UwMN8ji3yI4MfWa+183W01Sa8HLK8m8kKeCw08yHcSdzj0kYGAabKpXBjBvrMbiPhI+FYQVYBx8STxdgksS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001673; c=relaxed/simple;
	bh=/n6viW2cIV8LYeCmJQypGF6fqiDa/c1MK40py9z2tfU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ftm1DUWzrFV2mexEBkvJXi4O7ZFfRmyEOT80WI9KvrOlUoBdCWjH7p8NViTMWhziXpMpcfkQNuX+R/Gtkeg3dGB4aZjV1mNRM1X6XgRDlwmRtVlxEL+QMTSjqS1SN7G8jhuNP4D1aXh9P3bdKRPRD5JIn9B8gtDnmLx3+orGIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=mauM2t60; arc=none smtp.client-ip=79.135.106.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="mauM2t60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001667; x=1769260867;
	bh=HIKw1+wqe+XvmTdmySUfDBlg9ZDTRrTVJ1eruFyu27M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mauM2t60zXNLdv2Xg0TMv888hzxTB+ybh/oihFakJZBA7xe7Ztgeojbb5X3n7ZBo/
	 G+GsbXjYaHqiCxZWnFIN5XHejQBGviCzfQDKB+DE21B0JQRTS76Gc3IyDjOJt2zweL
	 8gLOGprs5o0+g7MLYlllSuUb2JSgfyxATaprwkvB3zYQ6dZ3SyN1/bovwmDtN34uAF
	 OFDcKIjIYNFTd4/Vxng01iZmV/7T1C+AtdPldvHTm4zU6P+UmKjcZ/YKEEByFdsn0a
	 WvPu9Dj98FJfHWs3gNmZPVRdBS9tzD4fBZME+W8zCcv+pm+xPh7qC0iwlaBOPYwEVM
	 OrXAZFXAmEa6g==
Date: Wed, 21 Jan 2026 13:21:03 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 7/7] net/sched: act_gate: guard NULL params in accessors
Message-ID: <20260121131954.2710459-8-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 6856574e11b1bd9d0c7295a64c4cb9c34798e67f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Guard NULL params in accessors/dump/timer paths to avoid crashes during
teardown or failed initialization. Other actions already guard params befor=
e
RCU cleanup (act_pedit, commit 52cf89f78c01bf; act_vlan, commits 4c5b9d9642=
c859
and 1edf8abe04090c), so act_gate should tolerate NULL in reader paths too.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Signed-off-by: Paul Moses <p@1g4.org>
Cc: stable@vger.kernel.org
---
 include/net/tc_act/tc_gate.h | 30 ++++++++++++++++++++----------
 net/sched/act_gate.c         | 13 ++++++++++++-
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index 9587d9e9fa38f..8c3309b0dd779 100644
--- a/include/net/tc_act/tc_gate.h
+++ b/include/net/tc_act/tc_gate.h
@@ -54,12 +54,13 @@ struct tcf_gate {
=20
 static inline s32 tcf_gate_prio(const struct tc_action *a)
 {
-=09s32 tcfg_prio;
+=09s32 tcfg_prio =3D 0;
 =09struct tcf_gate_params *p;
=20
 =09rcu_read_lock();
 =09p =3D rcu_dereference(to_gate(a)->param);
-=09tcfg_prio =3D p->tcfg_priority;
+=09if (p)
+=09=09tcfg_prio =3D p->tcfg_priority;
 =09rcu_read_unlock();
=20
 =09return tcfg_prio;
@@ -67,12 +68,13 @@ static inline s32 tcf_gate_prio(const struct tc_action =
*a)
=20
 static inline u64 tcf_gate_basetime(const struct tc_action *a)
 {
-=09u64 tcfg_basetime;
+=09u64 tcfg_basetime =3D 0;
 =09struct tcf_gate_params *p;
=20
 =09rcu_read_lock();
 =09p =3D rcu_dereference(to_gate(a)->param);
-=09tcfg_basetime =3D p->tcfg_basetime;
+=09if (p)
+=09=09tcfg_basetime =3D p->tcfg_basetime;
 =09rcu_read_unlock();
=20
 =09return tcfg_basetime;
@@ -80,12 +82,13 @@ static inline u64 tcf_gate_basetime(const struct tc_act=
ion *a)
=20
 static inline u64 tcf_gate_cycletime(const struct tc_action *a)
 {
-=09u64 tcfg_cycletime;
+=09u64 tcfg_cycletime =3D 0;
 =09struct tcf_gate_params *p;
=20
 =09rcu_read_lock();
 =09p =3D rcu_dereference(to_gate(a)->param);
-=09tcfg_cycletime =3D p->tcfg_cycletime;
+=09if (p)
+=09=09tcfg_cycletime =3D p->tcfg_cycletime;
 =09rcu_read_unlock();
=20
 =09return tcfg_cycletime;
@@ -93,12 +96,13 @@ static inline u64 tcf_gate_cycletime(const struct tc_ac=
tion *a)
=20
 static inline u64 tcf_gate_cycletimeext(const struct tc_action *a)
 {
-=09u64 tcfg_cycletimeext;
+=09u64 tcfg_cycletimeext =3D 0;
 =09struct tcf_gate_params *p;
=20
 =09rcu_read_lock();
 =09p =3D rcu_dereference(to_gate(a)->param);
-=09tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
+=09if (p)
+=09=09tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
 =09rcu_read_unlock();
=20
 =09return tcfg_cycletimeext;
@@ -106,12 +110,13 @@ static inline u64 tcf_gate_cycletimeext(const struct =
tc_action *a)
=20
 static inline u32 tcf_gate_num_entries(const struct tc_action *a)
 {
-=09u32 num_entries;
+=09u32 num_entries =3D 0;
 =09struct tcf_gate_params *p;
=20
 =09rcu_read_lock();
 =09p =3D rcu_dereference(to_gate(a)->param);
-=09num_entries =3D p->num_entries;
+=09if (p)
+=09=09num_entries =3D p->num_entries;
 =09rcu_read_unlock();
=20
 =09return num_entries;
@@ -128,6 +133,11 @@ static inline struct action_gate_entry
=20
 =09rcu_read_lock();
 =09p =3D rcu_dereference(to_gate(a)->param);
+=09if (!p) {
+=09=09rcu_read_unlock();
+=09=09return NULL;
+=09}
+
 =09num_entries =3D p->num_entries;
=20
 =09list_for_each_entry(entry, &p->entries, list)
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index e4134b9a4a314..65b53cbf37e67 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -82,7 +82,11 @@ static enum hrtimer_restart gate_timer_func(struct hrtim=
er *timer)
=20
 =09p =3D rcu_dereference_protected(gact->param,
 =09=09=09=09      lockdep_is_held(&gact->tcf_lock));
+=09if (!p)
+=09=09goto out_unlock;
 =09next =3D gact->next_entry;
+=09if (!next)
+=09=09goto out_unlock;
=20
 =09/* cycle start, clear pending bit, clear total octets */
 =09gact->current_gate_status =3D next->gate_state ? GATE_ACT_GATE_OPEN : 0=
;
@@ -119,6 +123,11 @@ static enum hrtimer_restart gate_timer_func(struct hrt=
imer *timer)
 =09spin_unlock(&gact->tcf_lock);
=20
 =09return HRTIMER_RESTART;
+
+out_unlock:
+=09spin_unlock(&gact->tcf_lock);
+
+=09return HRTIMER_NORESTART;
 }
=20
 TC_INDIRECT_SCOPE int tcf_gate_act(struct sk_buff *skb,
@@ -584,8 +593,8 @@ static void tcf_gate_cleanup(struct tc_action *a)
 =09struct tcf_gate *gact =3D to_gate(a);
 =09struct tcf_gate_params *p;
=20
-=09p =3D rcu_replace_pointer(gact->param, NULL, lockdep_rtnl_is_held());
 =09hrtimer_cancel(&gact->hitimer);
+=09p =3D rcu_replace_pointer(gact->param, NULL, lockdep_rtnl_is_held());
 =09if (p)
 =09=09call_rcu(&p->rcu, tcf_gate_params_free_rcu);
 }
@@ -643,6 +652,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc=
_action *a,
=20
 =09rcu_read_lock();
 =09p =3D rcu_dereference(gact->param);
+=09if (!p)
+=09=09goto nla_put_failure_rcu;
=20
 =09if (nla_put_u64_64bit(skb, TCA_GATE_BASE_TIME,
 =09=09=09      p->tcfg_basetime, TCA_GATE_PAD))
--=20
2.52.GIT


