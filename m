Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793630313;
	b=fUs2oqPZSfmiwNpInxMJ6n5ixMhDkaVWEZ5PGChMqarg/L2AfjYsRnRl2SFuyD+wepeF
	 JsoKTL4sVGMGclAbIKW5O+4hKVcUwEOcr22WcFjgG4c7UBp0u6exNbbHiiG8XAro6pHtq
	 +SJk4YadFLJjVwfhA4uPwA2+BZbnCFJ0WDnP7NjnIQ7mchP6UeQmjaHwLxjGZ9nWbDQOv
	 U7QTevMxANjG8wsHSfajOh85CmN2xvgFQJx4duyZMKI6HNiCo7COlUdJDneUhI5t1HOfa
	 sbhbp/npH4clNqoVcWrvjqb63LT3UThA00jnHgzVRLjVP7wKqWoMR9ngjrZGd8FBAqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kdpMoDfxV/kxyd283/cgxJ9yYcL9JRHgCdJXPdOv5hk=;
	b=r/8GivEzonw94udD5BXPU9m+FJmWn3xrkNic86gJMRWpCiudNR8ndAozOD+hBCiJdTpd
	 BeHgi6OafVs3cW6V+wt9/nGZFkApcNQyaBexnCq2NsGadC7ZIwkqevZRIgWhpX71CUezh
	 TCbfvbk9okUy0E/CV7En0vdN2I0Slwht5DWFITs3oTa59oC9OhIFVy9nRw1HQ0S6+XZUL
	 IfDcoudUKc8Ef5WAf9FJ5DMvJFbcCOs5CTkquf0Z/t8XlKCPey2SazLPgcsFdaCLIj2Gq
	 zUF2pkQtp1C9KNZQu+1DDt4IMGJroJ+PuQG+k89T1VCzS9lv6CcwKHgxJAudLmeX3oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzqFWStZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DF606E005
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 866DF606E005
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzqFWStZ
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bfc32574e7so1525130e87.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 06:38:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793630312; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfMJHCofVX27tlEDQwAja8VshUGLZkZYc2v3OFh6b+lf0Mbh7btWYwLxRY7qDn7Id5
         ATiO3w/uevru99/DTLMRu3wtDL9+uncqp2I25ECDwAzbLYjA64jdpcElsF5IFwbCz+tE
         GfSbYre6ul5Ia2xVVtu5kiNq4IkXLmvbPHfaHxTsvhmPawRf5OzoPihoQc/PoMYBr+MW
         dceKhZOARyGN8q93QXM1ZqX247DkpnqYs6pVrEjZQ2fv0f1nsVbBA+puI/QeMDNncGbG
         smqrtepSx9Y9EFHies+ddik71UPlByP9zey9I8rHbVf8LIK7f7tiOArhmpIMEN2BR9+c
         p+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdpMoDfxV/kxyd283/cgxJ9yYcL9JRHgCdJXPdOv5hk=;
        fh=a6kuEAM2ZBzwvjyaJGGzlYYIAS5lsqjFgUwGibpVneY=;
        b=VJfvDGxLn9vAQBE8WGQf9t/PR/vdqf499Nxu64mXmBpQPnnV0mlPYkXevitw1HA8Y3
         D8X9kiOE0aO3LBuSfi9vbX51NnyIBoanUngaOppISYeEVBUnJBoOAXTD0ffrO52tTNSf
         bRbO/ZGILdb5JQjXA0u2WNvVt14EQAL2t/wZ1mbehj8X/bpXHVIAR3EHU8vrLjZo9t4o
         kgYR2LrgesrpToKdOdbolz7gOHOBu6SkJ8X9xO2qMZyDn7c9hRci/PYcTiL2G2oC2+IZ
         kpC5wNST0bfoqKde7Gop1sDDMvGwBq5r1Ttpi3jRLmKY8pBdcMqN/fz+HdWHvZw5Sr09
         pk7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630312; x=1794235112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdpMoDfxV/kxyd283/cgxJ9yYcL9JRHgCdJXPdOv5hk=;
        b=bzqFWStZlSeo6uMCrFePWnp49xkQBYilAyy9LG/r319JXqVCyWI5UM2KooV+Qkx68L
         GDF9MvxzYgoLTcs/3gL2ZUqls62clkJSA0tLMlWsbVjvJPIAb46PE28fcqgTdC8YATlI
         faIVsn+HOXE40PiVvTuXP99QSueInGhnte46U7HHioMk1yNvtvjtEavGj/p0Vgdx87Sd
         JzTvavWsUumMt7hlV806pAQNRCp/ZQFvljrHNBoG8N8/CwyLAOf6BuSgHuUgPTqCR080
         OwVhRaURsC1+QFeiYMjyFxmJuYIixGxBPYI8k0e3mPtsRN8EOjAuWANotfDSMOdTw3YO
         eUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630312; x=1794235112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdpMoDfxV/kxyd283/cgxJ9yYcL9JRHgCdJXPdOv5hk=;
        b=wCLLugphQEEqp+A/50RFerIvPWxXLWYRaZ2WXqe3TH5XJgQU1mRuqhkfgJDPmDi2+c
         KwCbCqHOVCj0bza6S5E6bpkCiUcMm/coEEsfBDe5UZpTwhqaNVh8g60Ikj90PfGm1Wm6
         0idNDslAnc1lpR5J8vTM8aKhZKjcN8xyM0jFHvzQCs8BY58zei9ISbRcqB7EgPhwaIrm
         dgK/9b7BGkg38s17GA8tsx9KzOif6QmI5Wmay/PDCE+WYNtzV03eiDXmHUW3n97G9zLZ
         Szkcfvf32TZFy2QHj4MIUMjx7ixW1mjBbeonWHs6V71xtSS6d6mdN5bN+/MasuaIaOq4
         pKEw==
X-Gm-Message-State: APuU4Z+eSWdxTbyodQpvINUsH4uZUe0aSF14ZNhyRrxcmFrw6MGo5XlT
	l9Yg24agmI+6TVIsDAsMqUDiu+0QCRWebxNcGCnQVOFN/vAUWA5eJroH6Zop80x0cvTC+2MAPm/
	chBpGvWEXi0ghgZmj25ugJ3EdMltsIKNm1OqC
X-Gm-Gg: AYBFou3R+j9ZQI5Lu/LABmd8TD+wbEEUrccP8IYSkmq6iACpwL7DTZWLzeQ2MOgjn6f
	0R35XV3X2oIdbN9KDJlTd44eLPuVn1MTPrUvvFvH1OsdeUapy8xO38iRdjho4UYIS6TrYRXX6B4
	TVapg9cRhdXMXf3P/BpQbQUxOl4C77SV0nSPJZiqCNJCJ+iqEA8BwBQkonUIZmP/StV4sQmyUrS
	Dy7rK3h2aG4N/xbpdXvf6q0W2kww6/ehX403J0qmTUbAft/hHX7ZdJw7PCg2lh4Lxo2S6Z81uKz
	gabbzQv6dE+aA8wHANzHwistSIC5dctRPfmCk+TfsoCEpnWaZ21NL9fXh66BgCPcTLHxky3RHij
	W3T9CgL0qtOwpNn224r9eP34nxsl6QTp8HE/yHrTg+Ozm450mQkKF8W96uQ==
X-Received: by 2002:a05:6512:2383:b0:5bf:d2ab:2db with SMTP id
 2adb3069b0e04-5bfd95885fbmr2739757e87.21.1793630311537; Mon, 02 Nov 2026
 06:38:31 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101101347.3910654-1-anilkaushikwireless@gmail.com> <20261101101347.3910654-3-anilkaushikwireless@gmail.com>
In-Reply-To: <20261101101347.3910654-3-anilkaushikwireless@gmail.com>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Mon, 2 Nov 2026 20:08:19 +0530
X-Gm-Features: AclHuK8he1-L7JBcr8o_ziZkt640nJt1wti4Tfznt5AttnipuCK3bK_mDbQ9j3U
Message-ID: <CAG0Mgm8Of6wqcBjZbbZ4+moVbPYShBifLsMedC74q8b_j3Tehw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] netlink: Check a group again if it was
 released while joining it
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Florian Westphal <fw@strlen.de>, Mat Martineau <martineau@kernel.org>, 
	XingWang Xiang <v3rdant.xiang@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Medium is identified correctly, v4 will fix it.

The deadlock already exists without this patch, I have sent a separate patc=
h.
https://lore.kernel.org/netdev/20261102120929.4077030-1-anilkaushikwireless=
@gmail.com/

On Sun, Nov 1, 2026 at 3:44=E2=80=AFPM Anil Kaushik
<anilkaushikwireless@gmail.com> wrote:
>
> genl_bind() checks a group under cb_lock, but netlink_setsockopt() and
> netlink_bind() set the membership bit only after it returns and the lock
> is dropped. If the family is unregistered in between, its members are
> cleared before this socket is one. The socket then becomes a member of a
> group ID that no family owns, or that a family registered in the
> meantime got, and the GENL_MCAST_CAP_* flags of that family are never
> checked for it.
>
> Count per group in the netlink table how many times its members were
> cleared, which genetlink does when it frees the group IDs of a family.
> Read the count before ->netlink_bind() and again once the table is
> grabbed. If it changed, the group was released, so check it again
> against its current owner. ->netlink_unbind() is not called for it: the
> family that ->netlink_bind() checked it against is gone.
>
> bind() can then fail after it gave the socket its port ID. This only
> happens when a family is unregistered meanwhile.
>
> genl_bind() was added, with its first capability check, in the commit
> in the Fixes tag.
>
> Link: https://lore.kernel.org/netdev/179340003139.3131.112747177689286427=
24@kernel.org/
> Fixes: 4d54cc32112d ("mptcp: avoid lock_fast usage in accept path")
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
> ---
>  net/netlink/af_netlink.c | 61 +++++++++++++++++++++++++++++++++++++++-
>  net/netlink/af_netlink.h |  1 +
>  2 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index fec2879c497d..e1af3ac4bf6d 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -780,6 +780,8 @@ static int netlink_release(struct socket *sock)
>                         old =3D nl_deref_protected(nl_table[sk->sk_protoc=
ol].listeners);
>                         RCU_INIT_POINTER(nl_table[sk->sk_protocol].listen=
ers, NULL);
>                         kfree_rcu(old, rcu);
> +                       kfree(nl_table[sk->sk_protocol].mc_gen);
> +                       nl_table[sk->sk_protocol].mc_gen =3D NULL;
>                         nl_table[sk->sk_protocol].module =3D NULL;
>                         nl_table[sk->sk_protocol].bind =3D NULL;
>                         nl_table[sk->sk_protocol].unbind =3D NULL;
> @@ -990,6 +992,8 @@ static int netlink_bind(struct socket *sock, struct s=
ockaddr_unsized *addr,
>         struct net *net =3D sock_net(sk);
>         struct netlink_sock *nlk =3D nlk_sk(sk);
>         struct sockaddr_nl *nladdr =3D (struct sockaddr_nl *)addr;
> +       struct netlink_table *tbl =3D &nl_table[sk->sk_protocol];
> +       unsigned int gen[BITS_PER_TYPE(u32)];
>         int err =3D 0;
>         unsigned long groups;
>         bool bound;
> @@ -1023,9 +1027,14 @@ static int netlink_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>                         return -EINVAL;
>         }
>
> +retry:
>         if (nlk->netlink_bind && groups) {
>                 int group;
>
> +               netlink_lock_table();
> +               memcpy(gen, tbl->mc_gen, sizeof(gen));
> +               netlink_unlock_table();
> +
>                 /* nl_groups is a u32, so cap the maximum groups we can b=
ind */
>                 for (group =3D 0; group < BITS_PER_TYPE(u32); group++) {
>                         if (!test_bit(group, &groups))
> @@ -1057,6 +1066,22 @@ static int netlink_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>         netlink_unlock_table();
>
>         netlink_table_grab();
> +       if (nlk->netlink_bind && groups) {
> +               unsigned long released =3D 0;
> +               int group;
> +
> +               for_each_set_bit(group, &groups, BITS_PER_TYPE(u32))
> +                       if (gen[group] !=3D tbl->mc_gen[group])
> +                               __set_bit(group, &released);
> +               /* see netlink_setsockopt(), undo the others and retry al=
l */
> +               if (released) {
> +                       netlink_table_ungrab();
> +                       netlink_undo_bind(BITS_PER_TYPE(u32), groups & ~r=
eleased,
> +                                         sk);
> +                       bound =3D true;
> +                       goto retry;
> +               }
> +       }
>         netlink_update_subscriptions(sk, nlk->subscriptions +
>                                          hweight32(groups) -
>                                          hweight32(nlk->groups[0]));
> @@ -1686,6 +1711,8 @@ static int netlink_setsockopt(struct socket *sock, =
int level, int optname,
>                 break;
>         case NETLINK_ADD_MEMBERSHIP:
>         case NETLINK_DROP_MEMBERSHIP: {
> +               struct netlink_table *tbl =3D &nl_table[sk->sk_protocol];
> +               unsigned int gen =3D 0;
>                 int err;
>
>                 if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
> @@ -1695,12 +1722,25 @@ static int netlink_setsockopt(struct socket *sock=
, int level, int optname,
>                         return err;
>                 if (!val || val - 1 >=3D nlk->ngroups)
>                         return -EINVAL;
> +retry:
>                 if (optname =3D=3D NETLINK_ADD_MEMBERSHIP && nlk->netlink=
_bind) {
> +                       netlink_lock_table();
> +                       gen =3D tbl->mc_gen[val - 1];
> +                       netlink_unlock_table();
>                         err =3D nlk->netlink_bind(sock_net(sk), val);
>                         if (err)
>                                 return err;
>                 }
>                 netlink_table_grab();
> +               /* The group was released after ->netlink_bind() checked =
it, and
> +                * may have a new owner now. The old one is gone, so chec=
k the
> +                * group again without ->netlink_unbind().
> +                */
> +               if (optname =3D=3D NETLINK_ADD_MEMBERSHIP && nlk->netlink=
_bind &&
> +                   gen !=3D tbl->mc_gen[val - 1]) {
> +                       netlink_table_ungrab();
> +                       goto retry;
> +               }
>                 netlink_update_socket_mc(nlk, val,
>                                          optname =3D=3D NETLINK_ADD_MEMBE=
RSHIP);
>                 netlink_table_ungrab();
> @@ -2031,6 +2071,7 @@ __netlink_kernel_create(struct net *net, int unit, =
struct module *module,
>         struct sock *sk;
>         struct netlink_sock *nlk;
>         struct listeners *listeners =3D NULL;
> +       unsigned int *mc_gen =3D NULL;
>         unsigned int groups;
>
>         BUG_ON(!nl_table);
> @@ -2052,7 +2093,8 @@ __netlink_kernel_create(struct net *net, int unit, =
struct module *module,
>                 groups =3D cfg->groups;
>
>         listeners =3D kzalloc(sizeof(*listeners) + NLGRPSZ(groups), GFP_K=
ERNEL);
> -       if (!listeners)
> +       mc_gen =3D kcalloc(groups, sizeof(*mc_gen), GFP_KERNEL);
> +       if (!listeners || !mc_gen)
>                 goto out_sock_release;
>
>         sk->sk_data_ready =3D netlink_data_ready;
> @@ -2069,6 +2111,7 @@ __netlink_kernel_create(struct net *net, int unit, =
struct module *module,
>         if (!nl_table[unit].registered) {
>                 nl_table[unit].groups =3D groups;
>                 rcu_assign_pointer(nl_table[unit].listeners, listeners);
> +               nl_table[unit].mc_gen =3D mc_gen;
>                 nl_table[unit].module =3D module;
>                 if (cfg) {
>                         nl_table[unit].bind =3D cfg->bind;
> @@ -2079,6 +2122,7 @@ __netlink_kernel_create(struct net *net, int unit, =
struct module *module,
>                 nl_table[unit].registered =3D 1;
>         } else {
>                 kfree(listeners);
> +               kfree(mc_gen);
>                 nl_table[unit].registered++;
>         }
>         netlink_table_ungrab();
> @@ -2086,6 +2130,7 @@ __netlink_kernel_create(struct net *net, int unit, =
struct module *module,
>
>  out_sock_release:
>         kfree(listeners);
> +       kfree(mc_gen);
>         netlink_kernel_release(sk);
>         return NULL;
>
> @@ -2113,6 +2158,17 @@ int __netlink_change_ngroups(struct sock *sk, unsi=
gned int groups)
>         if (groups < 32)
>                 groups =3D 32;
>
> +       if (tbl->groups < groups) {
> +               unsigned int *mc_gen;
> +
> +               mc_gen =3D kcalloc(groups, sizeof(*mc_gen), GFP_ATOMIC);
> +               if (!mc_gen)
> +                       return -ENOMEM;
> +               memcpy(mc_gen, tbl->mc_gen, tbl->groups * sizeof(*mc_gen)=
);
> +               kfree(tbl->mc_gen);
> +               tbl->mc_gen =3D mc_gen;
> +       }
> +
>         if (NLGRPSZ(tbl->groups) < NLGRPSZ(groups)) {
>                 new =3D kzalloc(sizeof(*new) + NLGRPSZ(groups), GFP_ATOMI=
C);
>                 if (!new)
> @@ -2157,6 +2213,9 @@ void __netlink_clear_multicast_users(struct sock *k=
sk, unsigned int group)
>         struct netlink_table *tbl =3D &nl_table[ksk->sk_protocol];
>         struct hlist_node *tmp;
>
> +       /* the group can be given to another user, see netlink_setsockopt=
() */
> +       tbl->mc_gen[group - 1]++;
> +
>         sk_for_each_bound_safe(sk, tmp, &tbl->mc_list) {
>                 /* bitmap predates the group, can't be a member */
>                 if (group - 1 >=3D nlk_sk(sk)->ngroups)
> diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
> index 778a3809361f..d5e2e404fd11 100644
> --- a/net/netlink/af_netlink.h
> +++ b/net/netlink/af_netlink.h
> @@ -64,6 +64,7 @@ struct netlink_table {
>         struct listeners __rcu  *listeners;
>         unsigned int            flags;
>         unsigned int            groups;
> +       unsigned int            *mc_gen;
>         struct mutex            *cb_mutex;
>         struct module           *module;
>         int                     (*bind)(struct net *net, int group);
> --
> 2.25.1
>

pw-bot: cr
