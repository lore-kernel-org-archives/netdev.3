Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619511;
	b=bbGnnCi7XhGkRrDJ302+PbQg7gxmRqDA+MUPJSGak2VVB77YDMrFV86++3jR+4bwH0qk
	 pBBFAJ4mafmwTrsis1LJmi7U7I4eVH1wZXqH/0JvKcXipDDJctHzlY8aD8ER14sV7wEV2
	 hx7xb63Zkg4DAlKUjzKF0muYvKXE4N3kmTI8gc6Da9SEZFULKJjVaNAklDflLUOyYCGxb
	 0UbPKOxOoHdjhJ1rDMaeBZBYYVwwFIHaV9ZWNz69+syo+sBhy+ugAO/OI8DjoHdjheeJH
	 gePwKRhDwthTxy0O9O14SBXp9NX9yRDSZIh7TPQKwdlyfsdmq2egfNsr3yNZP1gDxnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=+WEg+P/B7K/tRZO6VBT025PejOv9QsKePvT7Zn+/aPc=;
	b=QczbMBkF3fJqf53LzbA/XutTJMODrgf+ogQB8/s2S+obwPMFpy0Rw22RsOZ0Wyn25Qza
	 YwaS9yQVq9Lgcl03kkfQ0RFvn1fZXiFXCkUWZhf4ov7z/omRAMzKCIfpTxuW75U9FWyKb
	 dqzUDJ4sb4BMBzJp8Iq64iFmnuJTFnFXgpckvJ4oMq4JDiN0Zf/r3eQIvX2HG9UUlDBY5
	 ryRYT5fT9TdiQF+0SukOBZC63m7RCKDxAU2WYxKPDaWvKgscRgkEixR+WktsHkutmxWXX
	 orLLkEEFqtcv0MVuZVB53FIHGNE6GX0l9vd6NKAxq08zQQltOrb0dDFb52asO4B0geA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNaSqBSg;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9496606A331
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 01:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9496606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNaSqBSg
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so591094a12.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794619510; x=1795224310; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+WEg+P/B7K/tRZO6VBT025PejOv9QsKePvT7Zn+/aPc=;
        b=kNaSqBSgQOoBYpC25L0mxJ627/w06VhGkLDst/2wejGDxe12CydzhoRzGGyfTiFlEb
         CCcYPxSQyT3fQMqF67hxX5+VCr1nEvvg/hrOn8DqOTOPTC9lS2HuczR9m6lEEGWwbNRN
         ml6R/PXdrJryywpbZhEVVzLheZhY1rOtIOG15BtbiKpUg/S4XfDR3DdCeMmTLriii5XC
         o60BPo3+tyIbBPhkYA0Jn8tAzRH643f3WhqDGOUYoWIX7rS41HXWJ5EAWysllKK/mdMr
         IRow0pld4nFSLnmFtyF5sqYpcbP69Ou/5CWpMPAqNabVgP01v8Ju5hBBhkUkRrxM3OTv
         Rfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794619510; x=1795224310;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WEg+P/B7K/tRZO6VBT025PejOv9QsKePvT7Zn+/aPc=;
        b=ZBXxIf+e/D11IEZuLHINp9dz9bAIm2zEf1uQDRvXKp7ZC3+hqGlkzvKOc38JPcO3Kr
         N/MP/dgyGn9k3vydDthY/m9ct3RTn5Mq7kmdNDmhoqIAYEzmeQT9OrETgdPb6PeITPlu
         9g84yGrAww6nUIPWcgRgSWJplwGcxq1r3wv+JIk7gAaDVOmy+CLtxwm0nGqswl6Ob/vk
         n5BENTZTE1WC8kYYb1Kw1pISFovHDyP4/dzI2/nvE6LXcBYQS86s88oWzmCLLJK6WA65
         NSrNdHcjZAGecCIkxu91B1r+DX3kFNxeSibtlxPApBh5tJllOk6UQls5pTTydS7b4Rk4
         t5MQ==
X-Forwarded-Encrypted: i=1; AL+hErGoQj0rZnbMKtzFC9OqnmyrC8RUNqGiI+X8laZ5dQilI8iIZMQyNbF0GWxRUB6gFThTZCka9ag=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VWZKfx94ZpMkwCMWokiA/dTn2oJ9C0zPJrb+Krwgw+crdQzzO
	Gv6UKhgJFD7HMr4f0nfLC3lfsCpnG/parVSIEkrTfSYrvK4QmjoIw9Gh
X-Gm-Gg: AYBFou1zxgDigE+CEoWwNolDl4Nqc6c80eSQzv7xIVKWN41vywIH9XzqCnd/n5X82o6
	baDflR3sIc0x88NIlT/AEjNM73ycpnjoEFFIlYKoyveFXZfK0st+fttYolGsp33X7pCdrIXp8gr
	wcChgNYgspr2nV9GECOFtxqY8QxthRQaGJASQyyNwxiQPLS5X7/AWx9cMeKGXvG0xrd2LGSCA/W
	lwwT1ww1E24grrx9RXm6RJoq26bsZbQwysquQMrI9YECvG9WSTPWlIkBgNUi+0CYgrP2b1FDtiP
	XamFsv0NW/RwALOldb5Nn+erLs7oyCXtm4es7we5A7/pC6iB+C5cF+ahkYZNqOiO27y4qnRq6Fw
	C2WrxwbcVzca3BUrjDKbMABpSd4OcCBDDyJN39cs6zUhDthyXkYKGBnY8Zf1T3IQ2i8nw4XVqYE
	g6pDV4iKnpTDpD14JKe/OoH2AI1lf5XczBJHbg6ZZDIlxQnDOl2h1hB+Im+GZyrUbvJNtSrqJ+J
	ZHYPrZYxTGHmMIZhYOKb5np3bx6fEx8GPicAG2JYg+OcwfA3n7A9BIEKVqemZ9YrJl4LG8ZxZaN
	MNN2yxVVKXBShbR5vIciFqNugyLwX8yTazb2s9YuSKB03gb9gp8VfOKqNPwnPEsI37NV5+bMpAI
	inoafGiPNcWiUtb7paIZ7lHyDU6yjszDKmA==
X-Received: by 2002:a17:90b:3886:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b1b0a1904amr3746072a91.24.1794619509952;
        Fri, 13 Nov 2026 17:25:09 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm3010430a91.1.2026.11.13.17.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:25:09 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 01:25:08 +0000
Message-Id: <DMUJISP1U0SF.2VE8F3IUBU0F0@gmail.com>
Cc: "Rongguang Wei" <clementwei90@163.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>,
 <jasowangio@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 "Rongguang Wei" <weirongguang@kylinos.cn>, "Willem de Bruijn"
 <willemb@google.com>
Subject: Re: [PATCH net v10 1/2] tun: keep a kernel copy of the socket
 filter program
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
In-Reply-To: <20261113162751.309d3544@kernel.org>
References: <20261109023848.59575-1-clementwei90@163.com> <20261109023848.59575-2-clementwei90@163.com> <20261113162751.309d3544@kernel.org>
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

On Fri, Nov 13, 2026 at 04:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
> Alexei, would you mind glancing over this one?
> Nothing stands out but the net/core/filter.c changes deserve a BPF ack.
> (Or feel free to take it via bpf if you prefer.)

Ohh. Thanks for flagging. I completely missed it,
since it was '[PATCH net] tun: ..' I didn't notice that it touches key sk_filter pieces.

And, yeah, I don't like it.
It exports too much bpf internal stuff into tun device.
Here is an alternative that my bot came up with and
imo it's much better.
Especially the part where EXPORT_SYMBOLs are removed.

pw-bot: cr

The diff is on top of bpf-next. It builds, and that is as far as I took it.

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec731..324acba 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -142,6 +142,7 @@ struct tun_file {
 	struct napi_struct napi;
 	bool napi_enabled;
 	bool napi_frags_enabled;
+	bool nofilter;			/* attached with IFF_NOFILTER */
 	struct mutex napi_mutex;	/* Protects access to the above napi */
 	struct list_head next;
 	struct tun_struct *detached;
@@ -176,7 +177,7 @@ struct tun_prog {
 };

 /* Since the socket were moved to tun_file, to preserve the behavior of persist
- * device, socket filter, sndbuf and vnet header size were restore when the
+ * device, sndbuf and vnet header size were restore when the
  * file were attached to a persist device.
  */
 struct tun_struct {
@@ -197,8 +198,6 @@ struct tun_struct {
 	int			sndbuf;
 	struct tap_filter	txflt;
 	struct sock_fprog	fprog;
-	/* protected by rtnl lock */
-	bool			filter_attached;
 	u32			msg_enable;
 	spinlock_t lock;
 	struct hlist_head flows[TUN_NUM_FLOW_ENTRIES];
@@ -213,6 +212,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
+	struct tun_prog __rcu *cbpf_prog;
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -756,15 +756,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;

 	err = 0;
-
-	/* Re-attach the filter to persist device */
-	if (!skip_filter && (tun->filter_attached == true)) {
-		lock_sock(tfile->socket.sk);
-		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-		if (!err)
-			goto out;
-	}
+	tfile->nofilter = skip_filter;

 	if (!tfile->detached &&
 	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
@@ -1071,6 +1063,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	int txq = skb->queue_mapping;
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
+	struct tun_prog *prog;
 	int len = skb->len;
 	int ret;

@@ -1096,10 +1089,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}

-	if (tfile->socket.sk->sk_filter) {
-		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
-		if (drop_reason)
+	prog = rcu_dereference(tun->cbpf_prog);
+	if (prog && !READ_ONCE(tfile->nofilter)) {
+		len = bpf_prog_run_clear_cb(prog->prog, skb);
+		if (len == 0 || pskb_trim(skb, len)) {
+			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 			goto drop;
+		}
 	}

 	len = run_ebpf_filter(tun, skb, len);
@@ -2410,6 +2406,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	__tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
 }

 static void tun_setup(struct net_device *dev)
@@ -2964,7 +2961,6 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		tun->vnet_hdr_sz = sizeof(struct virtio_net_hdr);

 		tun->align = NET_SKB_PAD;
-		tun->filter_attached = false;
 		tun->sndbuf = tfile->socket.sk->sk_sndbuf;
 		tun->rx_batched = 0;
 		RCU_INIT_POINTER(tun->steering_prog, NULL);
@@ -3068,39 +3064,34 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 	return 0;
 }

-static void tun_detach_filter(struct tun_struct *tun, int n)
+static int tun_attach_filter(struct tun_struct *tun, void __user *data)
 {
-	int i;
+	struct sock_fprog fprog;
 	struct tun_file *tfile;
+	struct bpf_prog *prog;
+	int i, ret;

-	for (i = 0; i < n; i++) {
-		tfile = rtnl_dereference(tun->tfiles[i]);
-		lock_sock(tfile->socket.sk);
-		sk_detach_filter(tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-	}
+	if (copy_from_user(&fprog, data, sizeof(fprog)))
+		return -EFAULT;

-	tun->filter_attached = false;
-}
+	ret = bpf_prog_create_from_user(&prog, &fprog, NULL, false);
+	if (ret)
+		return ret;

-static int tun_attach_filter(struct tun_struct *tun)
-{
-	int i, ret = 0;
-	struct tun_file *tfile;
+	ret = __tun_set_ebpf(tun, &tun->cbpf_prog, prog);
+	if (ret) {
+		bpf_prog_destroy(prog);
+		return ret;
+	}

 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
-		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-		if (ret) {
-			tun_detach_filter(tun, i);
-			return ret;
-		}
+		WRITE_ONCE(tfile->nofilter, false);
 	}

-	tun->filter_attached = true;
-	return ret;
+	/* Only TUNGETFILTER reads it */
+	tun->fprog = fprog;
+	return 0;
 }

 static void tun_set_sndbuf(struct tun_struct *tun)
@@ -3296,7 +3287,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,

 		if (tfile->detached)
 			ifr.ifr_flags |= IFF_DETACH_QUEUE;
-		if (!tfile->socket.sk->sk_filter)
+		if (tfile->nofilter || !rcu_access_pointer(tun->cbpf_prog))
 			ifr.ifr_flags |= IFF_NOFILTER;

 		if (copy_to_user(argp, &ifr, ifreq_len))
@@ -3439,11 +3430,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = -EFAULT;
-		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
-			break;
-
-		ret = tun_attach_filter(tun);
+		ret = tun_attach_filter(tun, argp);
 		break;

 	case TUNDETACHFILTER:
@@ -3451,8 +3438,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = 0;
-		tun_detach_filter(tun, tun->numqueues);
+		ret = __tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
 		break;

 	case TUNGETFILTER:
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009..1c742f2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1565,7 +1565,6 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)

 	return 0;
 }
-EXPORT_SYMBOL_GPL(sk_attach_filter);

 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 {
@@ -11779,7 +11778,6 @@ int sk_detach_filter(struct sock *sk)

 	return ret;
 }
-EXPORT_SYMBOL_GPL(sk_detach_filter);

 int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
