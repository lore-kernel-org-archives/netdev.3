Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4340855
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744984; cv=none; b=TRI4kxA0ggjl7aVoSCEZijfNoItA6EMIj33Jw7SHRPH9jXbBAsnDJIw0LsywDq72ozwciwl9xcXI+sLMc6v6CCPvbHVseeHhVqkxnA0ulmD0kZylUZ4d6Yer6FH1POFsuwhIWDck/Y0EY7XNXaetE1Sbvh9VDvVu0TPq50uy1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744984; c=relaxed/simple;
	bh=U1AQkn2NSW0/E55azKf41H8bUZHAT9bADW/kDDeogDs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REM8JjAUpas+oLu98/xxS9jkz3rS0/ZQmWLqkTseQKPMYWUBrRNM+cgijDBviHUpHZ3ww7DXUn6EyHQmFpeyHZXnrvAOXjpF7/LJfgU9Lu3uY4sK4mEideUvVOaT9iHg7VMK3itmU2rsauYizbALSkQSdAi3vNPrcM2smmeAA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=ow41/+gr; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="ow41/+gr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1791744978; x=1792004178;
	bh=u/LnDdqBZ3eFCtVsAQzUJx3ZTIVQ9CfLx2SsZaR5Ys8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ow41/+grHWWm8n25kU+vLe29jM+V3SmYcARpiwmJaB1+ASj8pA62BWPzqAxsin2ww
	 FlBHMpRZhMQZd7OTCAi/HFf1mw3axlzkBwhuE+jKxzS6xZatoqmqzB2gRSd+cnvauv
	 1c7H53rErdw0IIlUoCBHrkCCv0BUBuVXHMlbpalcyslNq58ao+N74IiziIeqR/ReNU
	 1sSgUTSq1tEi65XwlCeWxFuU2lNPyyMaTSKp0AYIA1iMzmuCa81f8I2tvt7DsENtoN
	 OmsarrFNsDLU5Fs6hcOJD4qpMdCQt8kPPsKghbTQAboN+EHNbGwLsb3dTkLRRD5XhX
	 UIIQOzIqpozLg==
Date: Sun, 11 Oct 2026 18:56:11 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: jhs@mojatatu.com, netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, olteanv@gmail.com, vladimir.oltean@nxp.com, eadavis@qq.com, dcaratti@redhat.com, dsahern@kernel.org, stephen@networkplumber.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] net/sched: act_gate: cap the number of scheduling entries
Message-ID: <vPFrhbkwAui8zFPcGQTUDazQfsFDlr5GYuaYQ5BxJcrDiT6x1EljEze4cYadHqbeUW2ivLdpa8eC_cXC6ceACswgb-lW47aSVkHvHjhn_X8=@1g4.org>
In-Reply-To: <179171627521.434549.2707902365679392275@kernel.org>
References: <QDISC-H19Z.v2.20261007062551-3@mojatatu.com> <179171627521.434549.2707902365679392275@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 86b88bcce5dc15ea9e7460589780a269a837466e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> [Severity: Medium]
> This sizes the cap against the u16 nla_len of the nest. Should it also be
> sized against the largest dump skb?
>=20
> netlink_recvmsg() limits the dump buffer size:
>=20
> net/netlink/af_netlink.c:netlink_recvmsg() {
>     ...
> =09max_recvmsg_len =3D min_t(size_t, max_recvmsg_len,
> =09=09=09=09SKB_WITH_OVERHEAD(32768));
>     ...
> }
>=20
> For RTM_GETACTION dumps, netlink_dump() allocates at most about 32.4 KB.
> dumping_entry() emits 36 or 40 bytes per entry. A gate with more than abo=
ut
> 810-900 entries therefore cannot be dumped, and the new cap still accepts
> it.
>=20
> When this happens, tcf_dump_walker() trims the action and returns without
> an error:
>=20
> net/sched/act_api.c:tcf_dump_walker() {
>     ...
> =09=09if (err < 0) {
> =09=09=09index--;
> =09=09=09nlmsg_trim(skb, nest);
> =09=09=09goto done;
> =09=09}
>     ...
> }
>=20
> If the gate is the first action in the skb, n_i is 0. tc_dump_action()
> then returns a skb->len of 0, and netlink_dump() sends NLMSG_DONE with
> success. If earlier actions fit, the next callback restarts at the gate's
> index and ends the same way.
>=20
> The result is that the gate and every later action in the IDR are missing
> from "tc actions ls", and userspace gets no error.
>=20
> The commit message lists this truncation first under "The bugs:". The
> Caveat Emptor section then says the cap does not prevent it.
>=20
> Should the cap be small enough that a single gate fits in a dump skb? If
> not, should the commit message stop listing this truncation as something
> the cap fixes?
>=20

This is the one I encountered, not that the cap should be smaller or that
this type of dump needs to work, it's confusing that it returns 0 and stops=
.

This needs more review with regard to other callers but to give you an idea=
.

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e45a63be397c..4dfc050c48c4 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -589,18 +589,13 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinf=
o, struct sk_buff *skb,
                tcf_action_update_hw_stats(p);
=20
                nest =3D nla_nest_start_noflag(skb, n_i);
-               if (!nest) {
-                       index--;
+               if (!nest)
                        goto nla_put_failure;
-               }
                err =3D (act_flags & TCA_ACT_FLAG_TERSE_DUMP) ?
                        tcf_action_dump_terse(skb, p, true) :
                        tcf_action_dump_1(skb, p, 0, 0);
-               if (err < 0) {
-                       index--;
-                       nlmsg_trim(skb, nest);
-                       goto done;
-               }
+               if (err < 0)
+                       goto nla_put_failure;
                nla_nest_end(skb, nest);
                n_i++;
                if (!(act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON) &&
@@ -616,10 +611,15 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinf=
o, struct sk_buff *skb,
                if (act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON)
                        cb->args[1] =3D n_i;
        }
-       return n_i;
+       return n_i ?: err;
=20
 nla_put_failure:
+       index--;
        nla_nest_cancel(skb, nest);
+       err =3D -EMSGSIZE;
+       if (!n_i)
+               NL_SET_ERR_MSG(cb->extack,
+                              "TC action is too large for the dump buffer"=
);
        goto done;
 }
=20
@@ -2260,6 +2260,7 @@ static int tc_dump_action(struct sk_buff *skb, struct=
 netlink_callback *cb)
                msecs_since =3D nla_get_u32(tb[TCA_ROOT_TIME_DELTA]);
        }
=20
+       ret =3D -EMSGSIZE;
        nlh =3D nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_s=
eq,
                        cb->nlh->nlmsg_type, sizeof(*t), 0);
        if (!nlh)
@@ -2303,7 +2304,7 @@ static int tc_dump_action(struct sk_buff *skb, struct=
 netlink_callback *cb)
 out_module_put:
        module_put(a_o->owner);
        nlmsg_trim(skb, b);
-       return skb->len;
+       return ret;
 }
=20
 static const struct rtnl_msg_handler tc_action_rtnl_msg_handlers[] __initc=
onst =3D {



