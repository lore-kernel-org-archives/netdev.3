Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FC3ED5BE
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148280; cv=pass; b=mxepwtzrS5zTP1HogA2FXX3NlanoqeGbB4+TerJhYWkqozLjjQzewdxwvY3du7e6Bg+rSoV+wrzEErky6BXC87XdG9wPK2OHFHg2a9V62WqteBMnd9NIwBMLGimXG8aNJpWT0ZHXG7z0/yknupvoS6KeJYAYU7wuKU0TrodETXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148280; c=relaxed/simple;
	bh=lu7Y/gvpbbxd/QQ2SXd/Nf7LG1P3rOduCehbYO+m0PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL7qM4TlcBi+v6ZXFGzA8xpx3y9fF3c/oeBMppFk2PNnJjiJIabvA5dQFtyKwfFPTVQ/xlsFIgDdcEJOc+dH6nNguYYwvdcKWpM3gEUQ24/fQykUPcBEdebSh0gL9Oi/e0sxItGSs6S/0cj+WiRfy33QA+xrFsk3/hwXIP5/beI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw+f+vJG; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw+f+vJG"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so282045166b.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785148271; cv=none;
        d=google.com; s=arc-20260327;
        b=TS0LB0g3h3AR/07FMv489CsP+dzoHTwpeUZmnamyo5OSM437BiNUzcMul20G/rY5wH
         kRJPDzS8hdRRwcMXHii8CV8GVvHJo3lybD5Zg5SMNhgMu7J7ZUQwZYw0t5gea2dBROQN
         lE9PKHd6RRaPhwSpZgkTtLaQUNNh9UyHXD+SpvQutqzF2w+n5PG/TfPIC4YwUXOax+Ic
         QVOR0wB/vAHBoYcKAzbRaDHqzBql10N8Clr06pnccXyPZWB37tSpZywErkZwlYzYxGjc
         QFOfKePTtSqMIDABJGASz1i08AlSXIK9l62hy3U8j2nIS+fX9KROlYtkWySgNjGtMZgb
         78Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9/iiSMRv1Fz3mnDSedp3QhgJWSYNxGwHe8ZHYDI4+l4=;
        fh=QJ4v168DhtS0LYAKGLfo4PIewEKYKFDMxd+hIKK8cfk=;
        b=H6OagfJHX7u2GzADmb5V0TDBF4JfnWfUD9WBY8/vIEJgKO2YZrkEFu9feadwQy/wWm
         bJKObXfD7MnKfWn1dFcQl0+p2MFLrjEVeidZlbe1j7WvwAudqaBm6s6eyJjXEqn635JL
         ITopT3vkLO2e/RCt65hJ7PaoyrqmNlbyjwtlhpBm86yh1spvPZjT7p08NNykwKjteH5L
         V0KRsgriwEu6EMjLb0b257TKR7JhSPIceJhK4QuwsyMlUmBzJFUeZpPltBJ1YUdR0YBf
         KFyW5GEHqg71RNgZQYCpxFC1jq0Xci1E+aocQFXsUYEPqz3LMTMoARmr9bGOsVYZCbdu
         rWew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785148271; x=1785753071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9/iiSMRv1Fz3mnDSedp3QhgJWSYNxGwHe8ZHYDI4+l4=;
        b=fw+f+vJGMivntnepVgfnJi1pHfuJyNnmEvyxIhoZBJ8AT0/XwVzRESbBX/cr6Rsk0k
         5xBYoQm9EDrjb2xE9Zs/tjLuiaauukJpf8YQW0VdK8WrQQj6Aah5WVthbY0h5xZoi6e9
         V5DNJ1I3Wqs1oEodL61oglMJXPohgf7RzbJZ1Judwpba5331NIfRlXGISp0wOb+U+7Dp
         XGvMF2ByM0WVwdzlO+Xn/nRZKAmegxwogRnqt6FoTZXW3L5jpT4EhWhamsR3ZIK12995
         oZugxiINmjIOjSi3nx3lbihNggyPzHbIVGqhELWZnEfQ5oC6x9lrPEUOb1A80qTUatV4
         +4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785148271; x=1785753071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/iiSMRv1Fz3mnDSedp3QhgJWSYNxGwHe8ZHYDI4+l4=;
        b=ZU/g3MudZEIgjDVZlqAR5WU67X1pPpCvia2TDSFcHF2CIpt6wiL49wEXTW0WQZqM6O
         guQ/Q+VACJSGpvmgO/y6DBew6spluGOHn0858gsMydRenGGOoDI4hf8miXp72Fw4y9YK
         d0RukcBaqgcyqxw6l+aHjuuVI/HDxAK0EOayi3i3zZ2Z1n/MxuA0Q6uPFrXk1OemdARJ
         ZHHWhjtMlIH32ukm9aN42UPb2Pt23vMD4tkdwwcCZ3qYPmqI+RvWoVVuzoIHTMi80n8h
         TMpzCBxB0YuuHewCcvFKmnGHhMfY5tXrh2ATe3vajFH4suBJ5FiRgsGDyplrY08xcAoV
         wckA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6IHYe7aXsPHTyHEB1dxcpYfi+pu3Igp5IdJ/In8Ar+YL/inA1VEwS0GxJ6SvQQFNTamNVKnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNkJS4oVtFSCwMknGJt/kQ+Gg5pBA00lCj22c1aojZozffGth
	eNTbv6CZfjQ34FoUC9fRbUHlfjTUuAA8vXdvpoNd/ttrlyU28somTf3BxOQravkRFEr0J68b9Jr
	zsWRXoQB9HbGr0v0n+zlDDC7nwdRGYnu2g4kps5TwE1SpoHY=
X-Gm-Gg: AR+sD13z6a6j29QxNCXgfToxq7+dPBdLaTIr3BaF+ulaTfF03Mi7A71yHdKKA9qWzFk
	kXYBw3pZ0xQN43hcVo20BvjVWyxnLj2+hXMeH75KViAICIuuLCKAwyqq4w76FkSR2LrW3hI/r6k
	BBKat7FfECOPZhmbauiLQ+namzPAeTyYBLfRw2enTtzwAVR1WD615GYiM9ePyn70RVeiwC4O+tc
	qNNFTXeFdue1l990jXeilJk4bTUURIRSKQZPznQZqPh+yVorFcB46pm3sckF1eexzwa/pg2kbNW
	z4FzS9ipYW7ZAXk=
X-Received: by 2002:a17:907:1caa:b0:c05:abc0:dc7c with SMTP id
 a640c23a62f3a-c1f1eecc2d8mr406207466b.40.1785148270735; Mon, 27 Jul 2026
 03:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718092544.785289-1-bestswngs@gmail.com> <20260718092544.785289-2-bestswngs@gmail.com>
 <GV1P189MB1988EC5A7F5CB5DD69F331AEC6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi2hfRO8OebwBFm2f8240DYmqdPYNQtWyQL0VOP8beeSFQ@mail.gmail.com> <GV1P189MB1988CB4E92D2BDFB80894B4BC6C22@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988CB4E92D2BDFB80894B4BC6C22@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 27 Jul 2026 18:30:33 +0800
X-Gm-Features: AUfX_myGExZ2pwin7WRDuaHKT2cwohu5upym1X5uU4LgvhkXYizzCRz-X482kTM
Message-ID: <CANgPUi2bEtnuW3P2epaX+Mat7Szj=Pb6L6o_RL5C8BiHcVkYKg@mail.gmail.com>
Subject: Re: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Xiang Mei <xmei5@asu.edu>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 11:24=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: Re: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_=
up()
> >on empty publication list
> >
> >Hi Tung,
> >
> >I tested this on v7.1-rc5 with the two-node setup (UDP bearers, node-id
> >addressing), as an unprivileged user and as root.
> >The original NULL deref is fixed, and the sashiko findings look addresse=
d.
> >
> >But I found one path the patch misses: tipc_node_cleanup(). It removes a=
 stale
> >node with tipc_node_delete_from_list() directly, without the wake/cancel=
 you
> >added in tipc_node_delete(). If a deferred worker is still parked when t=
he stale
> >timer fires, the node is removed from the list while the worker is sleep=
ing in
> >wait_var_event(). Since the node is off the list, the wake in tipc_node_=
delete()
> >can no longer reach it. The worker stays in D state and keeps its node
> >reference, so the node struct leaks as well.
> >
> >This state is reachable from userspace without any kernel change:
> >filling local_publ_count to TIPC_MAX_PUBL with node-scope binds makes
> >tipc_net_finalize()'s publish fail, and the work_rescheduled retry then =
keeps
> >finalized at 0, so the link-up defers the worker for as long as the tabl=
e stays full.
> >(The retry also=E4=B9=9F=E9=87=8D=E8=AF=95 busy-loops, printing "tipc: B=
ind failed, max limit 65535
> >reached" each round.) Bringing the link down makes the peer node go stal=
e
> >NODE_CLEANUP_AFTER (300s) later, with the worker still parked.
> >The hung task watchdog flags it:
> >
> >```
> >     [  370.440401] INFO: task kworker/0:0:9 blocked for more than 245 s=
econds.
> >     [  370.441580] Workqueue: events tipc_node_dist_bulk
> >     [  370.442803] Call Trace:
> >     [  370.443151]  __schedule+0x18bf/0x4680
> >     [  370.444293]  tipc_named_dist_cluster_scope+0x1a0/0x220
> >     [  370.446076]  tipc_node_dist_bulk+0x6d/0x1b0
> >     [  370.446218]  process_one_work+0x845/0x1a60 ```
> >
> >With a test-only marker printk in tipc_node_cleanup() I can see the stal=
e timer
> >remove both nodes at ~368s and ~375s, i.e. while the workers above are s=
till
> >parked. Nothing wakes them on that path; in this run they only exit beca=
use
> >killing the reproducer closes the bind sockets, so the next retry's publ=
ish
> >succeeds. With a persistent failure source (e.g. memory
> >pressure) the worker would stay parked across the netns teardown as well=
.
> >
> >
> >```
> >[  247.560544] INFO: task kworker/0:0:9 blocked for more than 122 second=
s.
> >     [  247.568089] INFO: task kworker/0:2:67 blocked for more than 122
> >seconds.
> >
> >     [  370.440401] INFO: task kworker/0:0:9 blocked for more than 245 s=
econds.
> >     [  370.441580] Workqueue: events tipc_node_dist_bulk
> >     [  370.442803] Call Trace:
> >     [  370.443151]  __schedule+0x18bf/0x4680
> >     [  370.444293]  tipc_named_dist_cluster_scope+0x1a0/0x220     =E2=
=86=90
> >wait_var_event =E7=9D=A1=E7=9C=A0=E7=82=B9
> >     [  370.446076]  tipc_node_dist_bulk+0x6d/0x1b0
> >     [  370.446218]  process_one_work+0x845/0x1a60
> >
> >```
> >
> >
> >The Configs and reproducer =EF=BC=9A
> >```
> >CONFIG_TIPC=3Dy,
> >CONFIG_TIPC_MEDIA_UDP=3Dy, CONFIG_USER_NS=3Dy, CONFIG_NET_NS=3Dy,
> >CONFIG_KASAN=3Dy (crash on the unpatched kernel),
> >CONFIG_DETECT_HUNG_TASK=3Dy ```
> >
> >```c
> >#define _GNU_SOURCE
> >#include <stdio.h>
> >#include <stdlib.h>
> >#include <string.h>
> >#include <unistd.h>
> >#include <errno.h>
> >#include <sched.h>
> >#include <fcntl.h>
> >#include <signal.h>
> >#include <sys/types.h>
> >#include <sys/wait.h>
> >#include <sys/socket.h>
> >#include <arpa/inet.h>
> >#include <net/if.h>
> >#include <linux/netlink.h>
> >#include <linux/rtnetlink.h>
> >#include <linux/genetlink.h>
> >#include <linux/if_link.h>
> >#include <linux/veth.h>
> >#include <linux/tipc.h>
> >
> >#ifndef AF_TIPC
> >#define AF_TIPC 30
> >#endif
> >#ifndef SOCK_RDM
> >#define SOCK_RDM 4
> >#endif
> >
> >#ifndef VETH_INFO_PEER
> >#define VETH_INFO_PEER 1
> >#endif
> >
> >#define TIPC_GENL_V2_NAME "TIPCv2"
> >
> >enum {
> >        TIPC_NL_UNSPEC,
> >        TIPC_NL_LEGACY,
> >        TIPC_NL_BEARER_DISABLE,
> >        TIPC_NL_BEARER_ENABLE,
> >        TIPC_NL_BEARER_GET,
> >        TIPC_NL_BEARER_SET,
> >        TIPC_NL_SOCK_GET,
> >        TIPC_NL_PUBL_GET,
> >        TIPC_NL_LINK_GET,
> >        TIPC_NL_LINK_SET,
> >        TIPC_NL_LINK_RESET_STATS,
> >        TIPC_NL_MEDIA_GET,
> >        TIPC_NL_MEDIA_SET,
> >        TIPC_NL_NODE_GET,
> >        TIPC_NL_NET_GET,
> >        TIPC_NL_NET_SET,
> >};
> >
> >enum {
> >        TIPC_NLA_UNSPEC,
> >        TIPC_NLA_BEARER,
> >        TIPC_NLA_SOCK,
> >        TIPC_NLA_PUBL,
> >        TIPC_NLA_LINK,
> >        TIPC_NLA_MEDIA,
> >        TIPC_NLA_NODE,
> >        TIPC_NLA_NET,
> >};
> >
> >enum {
> >        TIPC_NLA_BEARER_UNSPEC,
> >        TIPC_NLA_BEARER_NAME,
> >        TIPC_NLA_BEARER_PROP,
> >        TIPC_NLA_BEARER_DOMAIN,
> >        TIPC_NLA_BEARER_UDP_OPTS,
> >};
> >
> >enum {
> >        TIPC_NLA_UDP_UNSPEC,
> >        TIPC_NLA_UDP_LOCAL,
> >        TIPC_NLA_UDP_REMOTE,
> >        TIPC_NLA_UDP_MULTI_REMOTEIP,
> >};
> >
> >enum {
> >        TIPC_NLA_NET_UNSPEC,
> >        TIPC_NLA_NET_ID,
> >        TIPC_NLA_NET_ADDR,
> >        TIPC_NLA_NET_NODEID,
> >        TIPC_NLA_NET_NODEID_W1,
> >};
> >
> >#define TIPC_UDP_PORT 6118
> >#define NLA_ALIGNTO 4
> >#define MY_NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO -
> >1))
> >
> >static int tipc_family;
> >
> >static int nl_open(int protocol)
> >{
> >        int fd =3D socket(AF_NETLINK, SOCK_RAW, protocol);
> >        if (fd < 0) { perror("socket(NETLINK)"); exit(1); }
> >        struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
> >        if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
> >                perror("bind(NETLINK)"); exit(1);
> >        }
> >        return fd;
> >}
> >
> >static void *nla_put(char *buf, int *off, int type, const void *data, in=
t len) {
> >        struct nlattr *a =3D (struct nlattr *)(buf + *off);
> >        a->nla_type =3D type;
> >        a->nla_len =3D NLA_HDRLEN + len;
> >        if (len)
> >                memcpy((char *)a + NLA_HDRLEN, data, len);
> >        *off +=3D MY_NLA_ALIGN(a->nla_len);
> >        return a;
> >}
> >
> >static struct nlattr *nla_nest_start(char *buf, int *off, int type) {
> >        struct nlattr *a =3D (struct nlattr *)(buf + *off);
> >        a->nla_type =3D type | NLA_F_NESTED;
> >        *off +=3D NLA_HDRLEN;
> >        return a;
> >}
> >
> >static void nla_nest_end(char *buf, int *off, struct nlattr *start) {
> >        start->nla_len =3D (buf + *off) - (char *)start; }
> >
> >static int genl_resolve_family(int fd, const char *name) {
> >        char buf[1024];
> >        memset(buf, 0, sizeof(buf));
> >        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
> >        struct genlmsghdrgenlmsghdr *gh =3D (struct genlmsghdrgenlmsghdr
> >*)NLMSG_DATA(nlh);
> >        int off =3D NLMSG_HDRLEN + GENL_HDRLEN;
> >
> >        nlh->nlmsg_type =3D GENL_ID_CTRL;
> >        nlh->nlmsg_flags =3D NLM_F_REQUEST;
> >        nlh->nlmsg_seq =3D 1;
> >        gh->cmd =3D CTRL_CMD_GETFAMILY;
> >        gh->version =3D 1;
> >        nla_put(buf, &off, CTRL_ATTR_FAMILY_NAME, name, strlen(name) + 1=
);
> >        nlh->nlmsg_len =3D off;
> >
> >        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send genl re=
solve");
> >exit(1); }
> >
> >        char rbuf[4096];
> >        int n =3D recv(fd, rbuf, sizeof(rbuf), 0);
> >        if (n < 0) { perror("recv genl resolve"); exit(1); }
> >
> >        struct nlmsghdr *rh =3D (struct nlmsghdr *)rbuf;
> >        if (rh->nlmsg_type =3D=3D NLMSG_ERROR)
> >                return -1;
> >        struct nlattr *a =3D (struct nlattr *)((char *)NLMSG_DATA(rh) +
> >GENL_HDRLEN);
> >        int alen=E9=98=BF=E4=BC=A6 =3D rh->nlmsg_len - NLMSG_HDRLEN - GE=
NL_HDRLEN;
> >        while (alen > 0) {
> >                if (a->nla_type =3D=3D CTRL_ATTR_FAMILY_ID)
> >                        return *(uint16_t *)((char *)a + NLA_HDRLEN);
> >                int step =3D MY_NLA_ALIGN(a->nla_len);
> >                alen -=3D step;
> >                a =3D (struct nlattr *)((char *)a + step);
> >        }
> >        return -1;
> >}
> >
> >static int nl_recv_ack(int fd, const char *what) {
> >        char rbuf[8192];
> >        int n =3D recv(fd, rbuf, sizeof(rbuf), 0);
> >        if (n < 0) { fprintf(stderr, "recv ack (%s): %s\n", what, strerr=
or(errno));
> >return -1; }
> >        struct nlmsghdr *rh =3D (struct nlmsghdr *)rbuf;
> >        if (rh->nlmsg_type =3D=3D NLMSG_ERROR) {
> >                struct nlmsgerr *e =3D NLMSG_DATA(rh);
> >                if (e->error !=3D 0)
> >                        fprintf(stderr, "[%s] netlink error: %d (%s)\n",=
 what, e->error,
> >strerror(-e->error));
> >                return e->error;
> >        }
> >        return 0;
> >}
> >
> >static void *rta_put(char *buf, int *off, int type, const void *data, in=
t len) {
> >        struct rtattr *a =3D (struct rtattr *)(buf + *off);
> >        a->rta_type =3D type;
> >        a->rta_len =3D RTA_LENGTH(len);
> >        if (len) memcpy(RTA_DATA(a), data, len);
> >        *off +=3D RTA_ALIGN(a->rta_len);
> >        return a;
> >}
> >
> >static struct rtattr *rta_nest(char *buf, int *off, int type) {
> >        struct rtattr *a =3D (struct rtattr *)(buf + *off);
> >        a->rta_type =3D type | NLA_F_NESTED;
> >        *off +=3D RTA_LENGTH(0);
> >        return a;
> >}
> >
> >static void rta_nest_end(char *buf, int *off, struct rtattr *start) {
> >        start->rta_len =3D (buf + *off) - (char *)start; }
> >
> >static void create_veth(int fd, const char *n0, const char *n1, int peer=
_nsfd) {
> >        char buf[2048];
> >        memset(buf, 0, sizeof(buf));
> >        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
> >        struct ifinfomsg *ifi =3D NLMSG_DATA(nlh);
> >        int off =3D NLMSG_HDRLEN + sizeof(*ifi);
> >
> >        nlh->nlmsg_type =3D RTM_NEWLINK;
> >        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
> >NLM_F_EXCL;
> >        nlh->nlmsg_seq =3D 10;
> >        ifi->ifi_family =3D AF_UNSPEC;
> >
> >        rta_put(buf, &off, IFLA_IFNAME, n0, strlen(n0) + 1);
> >        struct rtattr *linfo =3D rta_nest(buf, &off, IFLA_LINKINFO);
> >        rta_put(buf, &off, IFLA_INFO_KIND, "veth", 5);
> >        struct rtattr *idata =3D rta_nest(buf, &off, IFLA_INFO_DATA);
> >        struct rtattr *peer =3D rta_nest(buf, &off, VETH_INFO_PEER);
> >        struct ifinfomsg *pifi =3D (struct ifinfomsg *)(buf + off);
> >        memset(pifi, 0, sizeof(*pifi));
> >        off +=3D sizeof(*pifi);
> >        rta_put(buf, &off, IFLA_IFNAME, n1, strlen(n1) + 1);
> >        rta_put(buf, &off, IFLA_NET_NS_FD, &peer_nsfd, sizeof(peer_nsfd)=
);
> >        rta_nest_end(buf, &off, peer);
> >        rta_nest_end(buf, &off, idata);
> >        rta_nest_end(buf, &off, linfo);
> >        nlh->nlmsg_len =3D off;
> >
> >        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send veth");=
 exit(1); }
> >        int e =3D nl_recv_ack(fd, "create_veth");
> >        if (e && e !=3D -EEXIST) { fprintf(stderr, "veth create failed:
> >%d\n", e); exit(1); }
> >}
> >
> >static void set_if_up(int fd, const char *name) {
> >        char buf[512];
> >        memset(buf, 0, sizeof(buf));
> >        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
> >        struct ifinfomsg *ifi =3D NLMSG_DATA(nlh);
> >        int off =3D NLMSG_HDRLEN + sizeof(*ifi);
> >        nlh->nlmsg_type =3D RTM_NEWLINK;
> >        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> >        nlh->nlmsg_seq =3D 20;
> >        ifi->ifi_family =3D AF_UNSPEC;
> >        ifi->ifi_index =3D if_nametoindex(name);
> >        ifi->ifi_flags =3D IFF_UP;
> >        ifi->ifi_change =3D IFF_UP;
> >        nlh->nlmsg_len =3D off;
> >        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send up"); e=
xit(1); }
> >        nl_recv_ack(fd, "set_if_up");
> >}
> >
> >static void add_ipv4(int fd, const char *name, const char *ip, int prefi=
x) {
> >        char buf[512];
> >        memset(buf, 0, sizeof(buf));
> >        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
> >        struct ifaddrmsg *ifa =3D NLMSG_DATA(nlh);
> >        int off =3D NLMSG_HDRLEN + sizeof(*ifa);
> >        nlh->nlmsg_type =3D RTM_NEWADDR;
> >        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
> >NLM_F_REPLACE;
> >        nlh->nlmsg_seq =3D 30;
> >        ifa->ifa_family =3D AF_INET;
> >        ifa->ifa_prefixlen =3D prefix;
> >        ifa->ifa_scope =3D 0;
> >        ifa->ifa_index =3D if_nametoindex(name);
> >
> >        struct in_addr a;
> >        inet_pton(AF_INET, ip, &a);
> >        rta_put(buf, &off, IFA_LOCAL, &a, 4);
> >        rta_put(buf, &off, IFA_ADDRESS, &a, 4);
> >        nlh->nlmsg_len =3D off;
> >        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send addr");=
 exit(1); }
> >        nl_recv_ack(fd, "add_ipv4");
> >}
> >
> >static void tipc_set_node_id(int fd, uint64_t w0, uint64_t w1) {
> >        char buf[1024];
> >        memset(buf, 0, sizeof(buf));
> >        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
> >        struct genlmsghdrgenlmsghdr *gh =3D (struct genlmsghdrgenlmsghdr
> >*)NLMSG_DATA(nlh);
> >        int off =3D NLMSG_HDRLEN + GENL_HDRLEN;
> >        nlh->nlmsg_type =3D tipc_family;
> >        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> >        nlh->nlmsg_seq =3D 40;
> >        gh->cmd =3D TIPC_NL_NET_SET;
> >        gh->version =3D 1;
> >
> >        struct nlattr *net =3D nla_nest_start(buf, &off, TIPC_NLA_NET);
> >        nla_put(buf, &off, TIPC_NLA_NET_NODEID, &w0, sizeof(w0));
> >        nla_put(buf, &off, TIPC_NLA_NET_NODEID_W1, &w1, sizeof(w1));
> >        nla_nest_end(buf, &off, net);
> >        nlh->nlmsg_len =3D off;
> >
> >        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send net_set=
"); exit(1); }
> >        int e =3D nl_recv_ack(fd, "tipc_set_node_id");
> >        if (e) fprintf(stderr, "net_set(nodeid) returned %d\n", e); }
> >
> >static void put_sockaddr_storage_v4(char *buf, int *off, int type, const=
 char *ip,
> >int port) {
> >        struct sockaddr_storage ss;
> >        memset(&ss, 0, sizeof(ss));
> >        struct sockaddr_in *sin =3D (struct sockaddr_in *)&ss;
> >        sin->sin_family =3D AF_INET;
> >        sin->sin_port =3D htons(port);
> >        inet_pton(AF_INET, ip, &sin->sin_addr);
> >        nla_put(buf, off, type, &ss, sizeof(ss)); }
> >
> >static void tipc_udp_bearer(int fd, int cmd, const char *bname,
> >                            const char *local_ip, const char *remote_ip)=
 {
> >        char buf[2048];
> >        memset(buf, 0, sizeof(buf));
> >        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
> >        struct genlmsghdrgenlmsghdr *gh =3D (struct genlmsghdrgenlmsghdr
> >*)NLMSG_DATA(nlh);
> >        int off =3D NLMSG_HDRLEN + GENL_HDRLEN;
> >        nlh->nlmsg_type =3D tipc_family;
> >        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> >        nlh->nlmsg_seq =3D 50;
> >        gh->cmd =3D cmd;
> >        gh->version =3D 1;
> >
> >        struct nlattr *bearer =3D nla_nest_start(buf, &off, TIPC_NLA_BEA=
RER);
> >        nla_put(buf, &off, TIPC_NLA_BEARER_NAME, bname=E5=90=8D=E7=A7=B0=
,
> >strlen(bname=E5=90=8D=E7=A7=B0) + 1);
> >        if (cmd =3D=3D TIPC_NL_BEARER_ENABLE) {
> >                struct nlattr *udp =3D nla_nest_start(buf, &off,
> >TIPC_NLA_BEARER_UDP_OPTS);
> >                put_sockaddr_storage_v4(buf, &off, TIPC_NLA_UDP_LOCAL, l=
ocal_ip,
> >TIPC_UDP_PORT);
> >                put_sockaddr_storage_v4(buf, &off, TIPC_NLA_UDP_REMOTE,
> >remote_ip, TIPC_UDP_PORT);
> >                nla_nest_end(buf, &off, udp);
> >        }
> >        nla_nest_end(buf, &off, bearer);
> >        nlh->nlmsg_len =3D off;
> >
> >        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send bearer"=
); exit(1); }
> >        int e =3D nl_recv_ack(fd, "tipc_udp_bearer");
> >        if (e) fprintf(stderr, "bearer cmd %d (%s) returned %d\n", cmd,
> >bname=E5=90=8D=E7=A7=B0, e); }
> >
> >static int write_file(const char *path, const char *val) {
> >        int fd =3D open(path, O_WRONLY);
> >        if (fd < 0) return -1;
> >        int r =3D write(fd, val, strlen(val));
> >        close(fd);
> >        return r;
> >}
> >
> >static int bindfill_node_scope(int target) {
> >        int fd =3D socket(AF_TIPC, SOCK_RDM, 0);
> >        if (fd < 0) { perror("socket(AF_TIPC)"); exit(1); }
> >        int ok =3D 0, fail =3D 0;
> >        for (int i =3D 0; i < target + 1000; i++) {
> >                struct sockaddr_tipc sa;
> >                memset(&sa, 0, sizeof(sa));
> >                sa.family =3D AF_TIPC;
> >                sa.addrtype =3D TIPC_SERVICE_ADDR;
> >                sa.scope =3D TIPC_NODE_SCOPE;
> >                sa.addr.nameseq.type =3D 100000 + i;
> >                sa.addr.nameseq.lower =3D 100000 + i;
> >                sa.addr.nameseq.upper =3D 100000 + i;
> >                if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) =3D=3D =
0) {
> >                        ok++;
> >                        fail =3D 0;
> >                } else if (++fail > 100) {
> >                        break;
> >                }
> >        }
> >        fprintf(stderr, "[*] bound %d node-scope publications (cap reach=
ed)\n",
> >ok);
> >        if (ok < 65000) { fprintf(stderr, "bindfill shortfall\n"); exit(=
1); }
> >        return fd;
> >}
> >
> >static void child_main(int sync_rd, int sync_wr) {
> >        char c;
> >        write(sync_wr, "R", 1);
> >        if (read(sync_rd, &c, 1) !=3D 1) _exit(1);
> >
> >        int rfd =3D nl_open(NETLINK_ROUTE);
> >        set_if_up(rfd, "lo");
> >        set_if_up(rfd, "veth1");
> >        add_ipv4(rfd, "veth1", "10.0.0.2", 24);
> >
> >        int gfd =3D nl_open(NETLINK_GENERIC);
> >        tipc_family =3D genl_resolve_family(gfd, TIPC_GENL_V2_NAME);
> >        if (tipc_family < 0) _exit(1);
> >
> >        int bfd =3D bindfill_node_scope(65535);
> >        tipc_set_node_id(gfd, 0x2222222222222222ULL,
> >0x2222222222222222ULL);
> >        tipc_udp_bearer(gfd, TIPC_NL_BEARER_ENABLE, "udp:b1", "10.0.0.2"=
,
> >"10.0.0.1");
> >        write(sync_wr, "C", 1);
> >
> >        sleep(35);
> >        tipc_udp_bearer(gfd, TIPC_NL_BEARER_DISABLE, "udp:b1", NULL, NUL=
L);
> >        fprintf(stderr, "[child] b1 disabled, keeping it down\n");
> >        (void)bfd;
> >        for (;;) pause();
> >}
> >
> >int main(void)
> >{
> >        setvbuf(stdout, NULL, _IONBF, 0);
> >        setvbuf(stderr, NULL, _IONBF, 0);
> >
> >        uid_t uid =3D getuid();
> >        gid_t gid =3D getgid();
> >
> >        if (unshare(CLONE_NEWUSER | CLONE_NEWNET) =3D=3D 0) {
> >                write_file("/proc/self/setgroups", "deny");
> >                char m[64];
> >                snprintf(m, sizeof(m), "0 %d 1", uid);
> >                write_file("/proc/self/uid_map", m);
> >                snprintf(m, sizeof(m), "0 %d 1", gid);
> >                write_file("/proc/self/gid_map", m);
> >        } else if (unshare(CLONE_NEWNET) < 0) {
> >                perror("unshare");
> >                return 1;
> >        }
> >
> >        int p2c[2], c2p[2];
> >        if (pipe(p2c) < 0 || pipe(c2p) < 0) { perror("pipe"); return 1; =
}
> >
> >        pid_t pid =3D fork();
> >        if (pid =3D=3D 0) {
> >                close(p2c[1]);
> >                close(c2p[0]);
> >                if (unshare(CLONE_NEWNET) < 0) _exit(1);
> >                child_main(p2c[0], c2p[1]);
> >                _exit(0);
> >        }
> >        close(p2c[0]);
> >        close(c2p[1]);
> >
> >        char c;
> >        if (read(c2p[0], &c, 1) !=3D 1) { fprintf(stderr, "child not rea=
dy\n"); return 1; }
> >
> >        char nspath[64];
> >        snprintf(nspath, sizeof(nspath), "/proc/%d/ns/net", pid);
> >        int nsfd =3D open(nspath, O_RDONLY);
> >        if (nsfd < 0) { perror("open ns"); return 1; }
> >
> >        int rfd =3D nl_open(NETLINK_ROUTE);
> >        create_veth(rfd, "veth0", "veth1", nsfd);
> >        close(nsfd);
> >        set_if_up(rfd, "lo");
> >        set_if_up(rfd, "veth0");
> >        add_ipv4(rfd, "veth0", "10.0.0.1", 24);
> >        write(p2c[1], "G", 1);
> >
> >        int gfd =3D nl_open(NETLINK_GENERIC);
> >        tipc_family =3D genl_resolve_family(gfd, TIPC_GENL_V2_NAME);
> >        if (tipc_family < 0) return 1;
> >        int bfd =3D bindfill_node_scope(65535);
> >        tipc_set_node_id(gfd, 0x1111111111111111ULL,
> >0x1111111111111111ULL);
> >
> >        if (read(c2p[0], &c, 1) !=3D 1)
> >                fprintf(stderr, "child config sync missed\n");
> >        tipc_udp_bearer(gfd, TIPC_NL_BEARER_ENABLE, "udp:b0", "10.0.0.1"=
,
> >"10.0.0.2");
> >
> >        fprintf(stderr, "[*] nodes configured; waiting for stale cleanup=
\n");
> >        (void)bfd;
> >        sleep(400);
> >        kill(pid, SIGKILL);
> >        waitpid(pid, NULL, 0);
> >        fprintf(stderr, "[*] done\n");
> >        return 0;
> >}
> >
> >```
> >
> >
> >Do you think tipc_node_cleanup() should go through the same wake logic a=
s
> >tipc_node_delete()? Happy to test the next version.
>
> Thanks for your test report and reproducer. It will look into the reprodu=
cer to fix outstanding issues.
>
> >
> >Thanks,
> >Weiming

Hi Tung,

Just following up on the issue. Let me know if you need any help from
my side with testing or validation.

Thanks,
Weiming
