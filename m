Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032957;
	b=eI3PLn6iuIeh8kv1g3X53H+VM3RgfQel29jpccI9WYcn5mz5EbBFfwukdMliKIdfKXZY
	 JOO6YoU0d86iLrGZXewMRUs7as3RkkA0RA8fLLboU7wEwSgCrRNwrIRYRDvXMuu5ha1M1
	 t3mtb92VKt47EnjDvWQizK9Z5FBy/gmAut1Gc0JEMIwissuGPta0SzW5q/gcIBoNbJb9x
	 lD9swl5l/cVa3IqJDX8oMO8+3grA3HFs+Ck0iBg5Uixb8KuGD6/mljJzVZ/+gduKkWJHc
	 ZGjJ2vXfWCY1PEG2UaE0P4pPKlf7+uPEaQJ0DNiJ9/kfKVh40uVt3aE7FRv50zYZH4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fMtnBu3iCFV4jSkaCb7AX9yL/4T5RVnlRz0UlmFCWdU=;
	b=k7NqQTsjEt0InIV05CzmKnKSc0Sf8A8vbkqDTLVI+pa3cLfFnx/1PluHLqKqW+VDKN15
	 eKd9drP1mXXBb04r1C7y8O3x4i/zu38KNHOsGOMbkLkufPDgCE+udvG8o8aTBfm7Yj/Cv
	 LKCH9a0+TZBN4Gmq531CKReCCkFi9xuIartcK15LN9O4u5c2/zTX8S9KFpgpp0Fmf86+r
	 j2Ju45l/PEYJqScyqZX9XAdReI/YU3mr6ekP9A+tSdQoow3umXup4iXDM7sd6r3kVNw2o
	 n7xwvb76M1bHCq+dGKAuWe/WOq/x+0Ajxc3lbqOjQnBkpEDgpa8wVzOlFEKlcxMF88Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSVoa1cX;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC911606A32E
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 06:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC911606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSVoa1cX
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so2346854c88.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 22:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032956; x=1794637756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMtnBu3iCFV4jSkaCb7AX9yL/4T5RVnlRz0UlmFCWdU=;
        b=DSVoa1cXqvrAH83f4WObwyl4J3m3E83GNS1XzmhGgssIOExNh+4oFbdYhMuhCnuZ3l
         9oiwxEN5AYYTmTqCtjaZEQdLB8MHAl6y0yNsFkGrXp8ukRsJ+xiTQcJKmJSKVeex/aGG
         IDwxDtebUJOYUdPJ3anGg6XzgYLTTXRZh6iXO4NKEye+Vj40vi9nvgt7Yx+UKTCn2XAg
         NEgnOyWPCvdZHBHPdAUSZAm+YG1UmIDa3f1TpFOY2srRBX8+bRJDh+MoFQyKQkLsiX5w
         pHFFuE78TGveuOY//0RVuJEziYtuuljbaJU50M0rkBHBdJYptHvEh9KwaLR3i46bugU/
         oYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032956; x=1794637756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMtnBu3iCFV4jSkaCb7AX9yL/4T5RVnlRz0UlmFCWdU=;
        b=Jbyaa5ohnz8IHQRTpY2vLC+p34PDqVJ7st9xAOEzMh36uGLo/9VMpoO3kH018/W04y
         VMj/GRve/ZTM/jnTH/4m7+WxTzfwZ0tqP59wKyAOenRoZG1w3FGiR2xb8yn0D/3M5/wt
         MOyEAgksaqTlh+pOdDRRUuy+tLDXQ+3ErYxt4mznWXveljiXu5ashQuK75+96f448rcT
         Ybmy4ci9Npa8U0Q4t/E5SqaaFOGaOSkr/y800AjiJxHBxklCFBKXQe9DjC1Y1HUOhCME
         lgIVeGRXpSnXq+BuxheVLD+TlnsuoOl0PmeDOF4D+X92zNyc/7jcVUp58bL7VeFDeazq
         Nwlw==
X-Forwarded-Encrypted: i=1; AKwUvBwZOQVRESSrxdURJeTLADdlZZJrW0DVdU/j6a/bBe/jPdtJRXR6SOJFXfHJgWvJxeuIAH4T+Kk=@vger.kernel.org
X-Gm-Message-State: APuU4Z84igo7FBNyZxjngDflO9LP75tp4AEPO9tGG66hOOaymY6jhsRo
	LLDQYd0Cu4+xDbkzA5NtR/xmJ83BF/AGo38Ht35M8wl9y8hyzi5yiOY4
X-Gm-Gg: AYBFou2Nuj7ZyhoniBFIAOCcGUzeQYY/4bRMDw41SqnzVfYMO51s2qQUOtrI7gBkzPT
	dxY5hPWW9WYZ9uX1zpuNUM0Nh12UVoN/JfggPqCY5awzcZy2M/PpkGes+LMVkpeVH7225EOHu3S
	4EWAAqQeyvjFsVt7EyS79npjlQrcYZng+PV2o1AZCGIOn+4O8Sm1ThR04q2QgcCi6jw8GNRDIcp
	LkLr9QVHfAs63bI8y2YJXQuFA0WnhJE3jDrqUQ4ugMKlijDpEaRSoETGXT96qK2n3lrldxlb/yW
	QEoIjIh6fgJgqff4YF3FiUVfp8L8RXE5+fl3Z4lmfdIEfBYREo5UnM9mQ3SdZ5bZ8UFbFod+C3+
	EqayaQTWG0FM+3Dwr1yh37DOCn4U1KWfA1CjgqTzmmynHBytxSozQitCVHBr6l5RQ5zwR3wC4QI
	D/ud/EXAPfP8v7F/xYJc1I+WB3k85g21Pd+b/i2M10IcCXJg6MN8goIUfkT7R5r4Eo4ghBYLovv
	LejR04BDRtsf2jVOiZNwlucQSOqM+Huq+VCFRyII0KxAsA/Ryfn6uy3YU2FGsoAMNAKrRIcC/78
	4lUKTENGuFXL7mrjKlJIUCphH3e0hG8vI49CFhP1ZvcxGambxmf4D5wfOys=
X-Received: by 2002:a05:7022:7e07:b0:18d:96e8:b913 with SMTP id a92af1059eb24-1b25d38ef3emr7391109c88.47.1794032955809;
        Fri, 06 Nov 2026 22:29:15 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b269316725sm4004414c88.16.2026.11.06.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:29:15 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemb@google.com
Cc: Kalpesh Solanki <skalpesh942@gmail.com>,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via TUNSETLINK
Date: Sat,  7 Nov 2026 11:57:55 +0530
Message-ID: <20261107062755.23145-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Nov 07, 2026 at 01:51, Willem de Bruijn wrote:
> One exception is if this has never worked. If this was a NULL ptr
> exception from the start, then clearly no userspace can depend on it.

Right, this has never worked.

TUN devices only have tun_netdev_ops and never allocate dev->ieee802154_ptr
or register with wpan_phy. Setting ARPHRD_IEEE802154 via TUNSETLINK was only
handled in tun_get_addr_len() to set addr_len, but any actual use (like
dumping interfaces, llsec keys, or opening an IEEE 802.15.4 socket) immediately
triggers a NULL pointer dereference. Real virtual wpan devices are created
with mac802154_hwsim. So blocking it won't break any working userspace setup.

> Apparently a similar issue affects ARPHRD_6LOWPAN.

Yes, good catch. Setting ARPHRD_6LOWPAN has the same issue: lowpan_dev(dev)
assumes netdev_priv(dev) is struct lowpan_dev, but on TUN it's struct
tun_struct. On events like NETDEV_DOWN, lowpan_device_event() writes to
lowpan_dev(dev)->ctx.table flags, which corrupts tun's private memory.

Should I block ARPHRD_6LOWPAN in the same patch, or would you prefer that
in a separate fix?

> If blocking this proves safe, prefer as little unrelated code churn as
> possible.

Understood. I'll drop the USHRT_MAX check and avoid touching tun_get_addr_len
or the include header in v3, keeping the patch strictly to checking the
rejected types in TUNSETLINK.

Thanks,
Kalpesh
