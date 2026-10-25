Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792891159;
	b=4lQzgvU4hjQy8naI318f4sVVdOILXkP10pHOxJOlbDXA+8hcuU+DLt1kzGjHWJW3xpSe
	 HlU6xvxIq5NFDoU7F++WKw4Fof2tLSFWWdoZksRqwjI6Uqv4ngQZp1hjX0GHeMyPD8KZr
	 mBxMr5MY3GinwUIzyIxtUU5bByvmvs70Bt/i4uFBwsygvBXQKBha/NbCeVNenBXnD7hau
	 Qpw7EbYGAq6gbncl8p6e9Tn1sxK0jjAPrv4BNiFkp79kpH2p+p/Hiv8bce+n98b0Zyh+F
	 4/LGM4VTO/TGrmS0UECBl13rsdxYTu+sZocsyP/ocpv4iG4pBnKoEz7H0mOA5ppnqnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792891159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
	b=cqq1Gs36M976uCPHg0KQKpRS5oS4GroaYZYDbvmpXrSquI17e/zgaG5+A8QuH+/mcTaR
	 J2V2KyJNR/+kzeZjHRWRNSyVCOo7nQobWL1unopf0TATQC2Sa7OkW/R4q0w/bmYgrJgUG
	 K1IOgdvPAS8sExRDXvtzYYP+GquV+RK8l9YFtKuzgpvw/mBvZJ19ARpnOgHY4sWtAcwI0
	 HWhjFIhpn9VPrhzFTnkoJdaStre7gZi9oAXyFp8u+HzeYK1+OHaJQuFnAwGqDubria8Iu
	 k1fqOguIQfAcDZll2TRE7xlUThur+iTPAysZEGtyZgaclgFGedTGSfWrvtry3urZFGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nyUFwVcj;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8205606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 01:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8205606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nyUFwVcj
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1645966a91.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 18:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792891158; x=1793495958; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
        b=nyUFwVcjgd6g3xuNlSD/rMAoH+5rhnVhKVDNLCsK4WeHGC6W0qiL1ts8cv2tR1rrUV
         25HBD5SR+xxXKkJEZAgiBcwUwzFB/8BmOaZyQfXgksIEQPAA7hzt77jyYLP8tiOFUItI
         W9iZBfz9LCduMPMN5NGg4KhetNlKWFha5VYkZea131wCfXvhV3PdR6ebjUC9EoVAVyn2
         AH/Evm6Z7YrF7QQ6sOLK36AH4Sy4N30imPWThuGRMJQXCQD/m6QVbiS8UFrPoTvwbgoy
         C5oM7nXa3UKdOZ8ZAuZnhUnSXyuO1smqDpTLCqvs//S/k1X8Fb5g6Tk/wRdQk1gvuJ9F
         qGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792891158; x=1793495958;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
        b=2TkAxtDqcWLTBi2kJK9BItdZ7Y90EumC2nIq5BPO1+XyCAoREg/H/rU+N23jUYOaQ6
         6lcP3KH02eL2sF7Tdx+Z652h/M4JRKIi5lmjv4LL8l55m25PZaUA+EKTUyy1FW9jKGW6
         pIkmbeDsEeeNAbG8crBE2Sl0bBzi+7Vp2F+9s3EuDPgPx1SWgAVeaKCXFETbCDRtnIGu
         ReX6zlauQlJnSFQoaXHttKYOWVYgF5ycQqt0qftwYL1iucji5aYrauwGJ06QSNolEwvi
         cDRwjq2qnU4vEhgpQOecxCM2Yl1KyRq769Or60nlxv1FT2ZgIU/R0gQ5r7pG6MFvoH7x
         ZS2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxa1ai39Q//ZBA0N6+4/WLO/WM7TjPAJfn8PL9hRymKbfw253gKYi0Kvlri68L2eOE5qyg+wqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJFVwlncMKxplwvX9Jftvk/IiubnJE+b/fVGTdGfQ6FHM3gCZ9
	tPsuVD70Weul9Dtf0lW3orxCKgyszRe46ImZ9I8dl5Sp4ywjNfYlcqCE
X-Gm-Gg: AYBFou03vLq8GITWIKymi5DUjHZnWpGz3eu/7/yvwWnKGV9cbbPTjkO7XriJqrIkXEP
	fUhzbJOmUWMGVhW9lqnB8pQzzfaCUpQYtdCle4NM1baA9x4ovlICCcHmfX5ywQNkv/4O6hZwk87
	oYNbKEA97pXS3T8GB1Xk+4PZht/jsqiRRZWVdxP7vz24vDAnkXI6LoVYIf4j0c8q3LQyNaneqK7
	Yxfj8VmZ1vDXGJZy1+jx8+EBg7PoZxS8jbbMEmq377/gwqFAMUbX5jc/H2KSzVdZPGaM35/H1GA
	rmIU+2Z4lRK2Os0BBzACilMhSHhxrId6w39LIXHIIdlmr1j99MppLhQ9IvTt/LNOMjrIKGWNQUi
	R6URJssCV6kZ+eMCooWK97ygOXwb/STO58PAYfejzRot0YxwIhl9YaX6E6EgYxwFNCn4vX4tLEf
	0/TfG3Q+tkF5JfwIkYib5j6rzALSr/wuCf7QyD3FoGuXj/SnQQClmzTh7J1y+MYRoQqq6yTkas+
	xQJtm9WqVjc7VXLs0FS0JDgUnd9QJTCAbFcng6C+DSFCTRL5Kw9yAqnszMUe11NahlmhSbAH+iW
	zVdmAFrxBY00qZigbS3cQjLHESSnjTwhKhb1p41K7sjUNNy/Gpz7NW9CnCQE
X-Received: by 2002:a17:90b:1a92:b0:3a0:bbd8:5ba7 with SMTP id 98e67ed59e1d1-3adeafd7770mr2867415a91.62.1792891158057;
        Sat, 24 Oct 2026 18:19:18 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32f70sm3963081a91.1.2026.10.24.18.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 18:19:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 01:19:16 +0000
Message-Id: <DMDIVEW7P9QN.1TB58XDPD7V3A@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Hangbin Liu"
 <liuhangbin@gmail.com>, "Martin Karsten" <mkarsten@uwaterloo.ca>, "Masashi
 Honma" <masashi.honma@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261024153608.58569-3-leon.hwang@linux.dev>
References: <20261024153608.58569-1-leon.hwang@linux.dev> <20261024153608.58569-3-leon.hwang@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 24, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> Instead of passing bpf log or extack to bpf_xdp_link_attach(), pass an
> errmsg pointer to receive the kstrdup() error msg, because

[...]

> 2) passing extack will access underlying driver string out of dev_put()
>    guard, which will crash kernel when the device is unloaded
>    concurrently.

Netlink does exactly that.
rtnl_setlink() looks up the dev with __dev_get_by_index(), so no refcnt,
do_setlink() -> dev_change_xdp_fd(dev, extack, ...) calls into the same
drivers that set the same strings, rtnl is unlocked, and only then
netlink_rcv_skb() -> netlink_ack() does strlen(extack->_msg).
All extack users work this way. kstrdup() in one of them fixes nothing.

Instead of patches 1 and 2:

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442..6f7fec2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4440,7 +4440,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);

-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			struct netlink_ext_ack *extack);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 90bc723..0ce75ee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5862,8 +5862,12 @@ err_put:
 }

 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
-static int link_create(union bpf_attr *attr, bpfptr_t uattr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
+		       bpfptr_t uattr_common, u32 size_common)
 {
+	struct netlink_ext_ack extack = {};
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
 	int ret;

@@ -5873,14 +5877,24 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (attr->link_create.attach_type == BPF_STRUCT_OPS)
 		return bpf_struct_ops_link_create(attr);

+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
 	prog = bpf_prog_get(attr->link_create.prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if (IS_ERR(prog)) {
+		bpf_log(log, "Invalid prog_fd.\n");
+		ret = PTR_ERR(prog);
+		prog = NULL;
+		goto out;
+	}

 	ret = bpf_prog_attach_check_attach_type(prog,
 						attr->link_create.attach_type);
-	if (ret)
+	if (ret) {
+		bpf_log(log, "Invalid attach_type.\n");
 		goto out;
+	}

 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
@@ -5931,7 +5945,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
-		ret = bpf_xdp_link_attach(attr, prog);
+		ret = bpf_xdp_link_attach(attr, prog, &extack);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
@@ -5959,12 +5973,22 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
+		bpf_log(log, "Invalid prog type.\n");
 		ret = -EINVAL;
 	}

 out:
-	if (ret < 0)
-		bpf_prog_put(prog);
+	if (ret < 0) {
+		int err;
+
+		if (extack._msg)
+			bpf_log(log, "%s\n", extack._msg);
+		err = bpf_log_attr_finalize(&attr_log, log);
+		ret = err ? err : ret;
+		if (prog)
+			bpf_prog_put(prog);
+	}
+	kfree(log);
 	return ret;
 }

@@ -6536,7 +6560,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr, uattr);
+		err = link_create(&attr, uattr, &attr_common, uattr_common, size_common);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e78..4aa5525 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10882,11 +10882,11 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 	.update_prog = bpf_xdp_link_update,
 };

-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			struct netlink_ext_ack *extack)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
-	struct netlink_ext_ack extack = {};
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
 	int err, fd;
@@ -10895,6 +10895,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
 		rtnl_unlock();
+		NL_SET_ERR_MSG(extack, "Invalid target_ifindex.");
 		return -EINVAL;
 	}

@@ -10916,14 +10917,14 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	}

 	netdev_lock_ops(dev);
-	err = dev_xdp_attach_link(dev, &extack, link);
+	err = dev_xdp_attach_link(dev, extack, link);
 	netdev_unlock_ops(dev);
 	rtnl_unlock();

 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
-		trace_bpf_xdp_link_attach_failed(extack._msg);
+		trace_bpf_xdp_link_attach_failed(extack->_msg);
 		goto out_put_dev;
 	}

I'm think I gave this suggestion earlier. Why did you go with strdup()?

pw-bot: cr
