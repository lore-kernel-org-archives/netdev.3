Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F189359710;
	Fri, 30 Jan 2026 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793768; cv=none; b=IdDVIxxd59LcT8I9KwKCQVpLKsTaXmNytkBhEjzvNak/X4A71E3kTOBe9zra0st5laF0tHUCPNcrthv5lIWfS5hGBZh5/JELQveQtnkENos/zCedclXENWO0EQ0LpbivxQh7y5Qpm1sJt66w5xRLB3Y7i4jpHDsSXnQX+s7OZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793768; c=relaxed/simple;
	bh=6IsexkEpjd/dpxFx6yAbjOBMYeOwHCgMSGgGXfn9CQM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BT0xcnVlHaS0jKLbdKy37/rOIcf8xdOnoOUixgYRqmKEIhxw2Yck7fXT/Xr2R15180DuNDBPIqPe607vqDqWT0PeFhV7zhDA7RWzK0Mtei6tUfVlaQZonhbq+YATT+mJ/6jrWkWFZuPg10nlbtRqGzxPQeruTN7XOkwoMzyAu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=RWamMXeY; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="RWamMXeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769793757; x=1770052957;
	bh=6IsexkEpjd/dpxFx6yAbjOBMYeOwHCgMSGgGXfn9CQM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RWamMXeYqBHKsrbXiwOuVpNWjJIxfHiElPhlRlrW1tr5VTMVcDd4WcLMq2NK6hxBF
	 bdRBSkiJ+2DS7JBRMLjpuhwDhLh3CvLrc9q/HyHabyuOyCbZCHA6VzQOMn2xw5CfYW
	 5RB5sgxzGdrIobprkKhb4mfv9+x4Ar2opPx7ld57CuiboRHgaJZcAn52MN3kUbYh6Y
	 FVE3GVpgpTKDFWsLozYyPg49WNlMNxE8tFVrdZe8YJoJTjyO7jpS+PoSvlEMh1LP9g
	 1LnUDTgQV/csEWTZo/4rfnNUuFYGizAYzOwJ0XfuKjrzNHrQPWqMJONFGqSLyEwXJP
	 7LoqOcEwg1xEg==
Date: Fri, 30 Jan 2026 17:22:33 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
Message-ID: <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
In-Reply-To: <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 7b528e6ff830b50d937c1b4134436380198bfc88
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes, In net/sched/act_api.c the GETACTION notify path always does alloc_skb=
(NLMSG_GOODSIZE), if tca_get_fill()=20
runs out of tailroom it returns -1 and tcf_get_notify() maps that to -EINVA=
L. So failures are size-dependent=20
and can look intermittent across different action dumps. act_gate might be =
the outlier?

The size is already computed in tca_action_gd() (sum tcf_action_fill_size()=
 then tcf_action_full_attrs_size())=20
and add/del already allocate max(attr_size, NLMSG_GOODSIZE). This patch jus=
t makes GETACTION consistent with=20
that.

On the reproducer: the gatebench test with 100 entries is reasonable.
https://raw.githubusercontent.com/jopamo/gatebench/refs/heads/main/src/self=
tests/test_large_dump.c

I plan to follow this up with another patch for act_gate and believe they b=
oth are integral to fully stabilize=20
act_gate.

Thanks
Paul



On Friday, January 30th, 2026 at 10:05 AM, Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:

>=20
>=20
> On Fri, Jan 30, 2026 at 8:43=E2=80=AFAM Paul Moses p@1g4.org wrote:
>=20
> > tcf_action_fill_size() already computes the required dump size, but
> > RTM_GETACTION replies always allocate NLMSG_GOODSIZE. Large action
> > state can overrun that skb and make dumps fail.
> >=20
> > Use the computed reply size for RTM_GETACTION replies so large actions
> > can be dumped, while still keeping NLMSG_GOODSIZE as a floor.
> >=20
> > Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event mes=
sage size")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses p@1g4.org
> > ---
> > net/sched/act_api.c | 7 ++++---
> > 1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index e1ab0faeb8113..8ab016d352850 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
> > @@ -1685,12 +1685,12 @@ static int tca_get_fill(struct sk_buff *skb, st=
ruct tc_action *actions[],
> >=20
> > static int
> > tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
> > - struct tc_action *actions[], int event,
> > + struct tc_action *actions[], int event, size_t attr_size,
> > struct netlink_ext_ack *extack)
> > {
> > struct sk_buff *skb;
> >=20
> > - skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
> > + skb =3D alloc_skb(max_t(size_t, attr_size, NLMSG_GOODSIZE), GFP_KERNE=
L);
> > if (!skb)
> > return -ENOBUFS;
> > if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
> > @@ -2041,7 +2041,8 @@ tca_action_gd(struct net *net, struct nlattr *nla=
, struct nlmsghdr *n,
> > attr_size =3D tcf_action_full_attrs_size(attr_size);
> >=20
> > if (event =3D=3D RTM_GETACTION)
> > - ret =3D tcf_get_notify(net, portid, n, actions, event, extack);
> > + ret =3D tcf_get_notify(net, portid, n, actions, event,
> > + attr_size, extack);
> > else { /* delete */
> > ret =3D tcf_del_notify(net, n, actions, portid, attr_size, extack);
> > if (ret)
>=20
>=20
> dunno. Is this based on some issue you found? This is a common pattern
> in a lot of places in the stack and has not caused any issues (afaik).
>=20
> cheers,
> jamal
