Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076423;
	b=lDQwunUN9DKv2tQ1ZLmtCppzoqIe9XB5S+bt5DXjz7bJhXR8KTYuNPzbJRkGCivaU9T6
	 WxGj5tPVQWdwUOmDDgziQBY9GZyVRYRiLEwqdOt+QGimzbTIQs8LmqeDCla29IUqo+jDR
	 VjVwzF1PioeNvDdlauBgOXuOasF2sTDXdfKnjbxLE3GAxe6nvp5gzsy/1Se/obDNkIIku
	 hHrCtCh2gqC6vzvndCdCBDtvC+T58iN3LzsxYpl6oEiklCkOzF07CVUJSbcXWoJ4+rYSz
	 l9tbqGiyD5j2sjSBVmEheaBMnTaBEpxTrGoKEqQUP4TEZOHGxeyL7k23Pk68qv9Y8LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WURMcEEiv9km0HuI6txsDrElGgFNRy2mTCX0NtkHLm4=;
	b=N7s+M1xngrkzYPDT7swBEX3KDKRmCUFRWW/lQTMGMf8y/6IRKHFEG4VBKRcIfNrUJh0J
	 pSZK14KDeslXRDlim70uVluQM+L1hUfYze7B/uxsn6+W9VeAE9gNl7yrJbyrQPPL4rAfu
	 F120gIeF8VIZ/lLL2Qjq8+GaOguiNt3FYboonQCDKcG4XpFp83MqD9PtYM/RHKDzTfUyQ
	 bkL9ZUdsHo1C2LedvYM4/fx2pfiCHsYmYz3OfvCtn4sXtGVJrNTx0n2CSSJdMnjYs8Pl8
	 YvtXUmF08A4udt3qOhd7QBPgNFEmCYr1H0o2JYYo++uVmyygjmjCtEUD9JXkHun8oJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=m6bBvmSW;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41628606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41628606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=m6bBvmSW
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-156cbe59622so3073172c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793076421; x=1793681221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WURMcEEiv9km0HuI6txsDrElGgFNRy2mTCX0NtkHLm4=;
        b=m6bBvmSWGHaosFaUuodvNtqp3GmNS1tz0C5ZGlflVDcZ7YcZiKwBrG8N7/58QywOrP
         nGo7Yeek8LM4Ma338xJnPpxzBdoLYWDiucejDkX5D2uOa6sG03WeW4JT7OnCxU6xVf7y
         2dG06cKm+PIISj2kww+AwE7IazcUUQVEBOzazPPoltwZ+K/0j/g+Sh2WJ8MRxKnCVFiS
         qQEJ9GlFgIIyx25iw1VzwoqfOE6Rr2spBipHeoXmiiaT3yAjMa69VJyfh6oFG4kCgXMA
         VWudhOa3qykkzrUObW5XGPe/bPMS98tSM4C6z9jjn6V4bseCwB1tS3XFYJ+YpdxtmlHY
         DrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793076421; x=1793681221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WURMcEEiv9km0HuI6txsDrElGgFNRy2mTCX0NtkHLm4=;
        b=ZFq9NfrvwZsBGUjOdydXi/bqyzmXlddjsDJb+rr7Hbx4odg3iF13aykFqPi2OQqs2U
         EXdZXk+OlFuBJGx0igdctrIpT0VACyM0jJTxEJ8SkYaHnaJovOYDNs+Wg9e4Pbm84vRF
         xePIonDPzUhBvAC3sb5gtjHbDTjpwV0KEyxGSUPBTPifjvOq1228bypcnwPyobcOxzdS
         21DYfdgMxSN85T29K2S8PHeeNeh4L8jQ7GK63f3p2VEAFDcQdGn2eRk3EjtmVhOacB4b
         Y5Vb4QNuGkNSdPmJY0OO/mFm+/MCvPUs1djS72+GW3egaGguAsahDABrsnaTJIlzAhl4
         fpnA==
X-Forwarded-Encrypted: i=1; AKwUvBzDeOVqpim8HHhcNfkdQcUxItUUGNvyfp4bggSVn936PjAhdwBMdwe+7mSv0+1k+SRNIPmc5rM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxkPhg3kZqUG6eJwdeTND5M7GDnI9hpTLRynvAHAzHQMN7r3qv
	NwYV1DVHew824svetrZ8L0YHAuHhVTme/0HJoi4vPNspMcpd01xQdauNyCmqj/5YJjSf
X-Gm-Gg: AYBFou3kEKWDA8h6aJngWrR/+ij/2mGmut1W5S4chTrMtNThnYTGw0N/6ghHHZjTodW
	gloGlwwJIE8Z359t3XbrVM68vrzlnx47z4VDNMSIB7oKd/DtdbCPyTL5K15XxfxP6TurhT1lfyK
	BPkZn4c4SJwqtmPYsluDwzglexBWCByh5dky2e1zKpbb9zeiiurLtp0iRMJwDT2iBOzHgc7OyMv
	hOeUrWZyG1h8fLgaMcJifHWAPO+Cd3jmcd/Vn1Idc/reS6D3Hwx24TaqLQ+KCMSX0Lg9cjmTFPS
	P4QUWjjIBA6dhtctTQlQK/taO0WlkxixEfXaq2sSM1sYKOYRt3ApZxl7VaQmGWZpQPUzJPSYXXZ
	EWVK3Tzh8ghMGoDu20mLnpxmEfRsBXFhtyLxlVT+Yikhn9OUWDYAZZ3XXFTxZAUYLua3uXzSxZz
	aJjWzn1aL4OnfbMQv+WfbAH/fOiSdwrn6F/G15EG2oZUgpYhWM1EEnNLQgEiVCAI8PIiVRdgWV0
	X7zzlYmOcd57IF1qcEFKBhSFNHCKoP15gsV39MNMAaVoL/yVxnktW0rb7EeSbNWs9g7bO6TfyyD
	ypcE58AKxET/LJ3dAox812Stsykxa1WD/Eujf4u3Dg==
X-Received: by 2002:a05:701a:c941:b0:144:fa58:95d8 with SMTP id a92af1059eb24-19935fcbb52mr8965104c88.27.1793076420958;
        Mon, 26 Oct 2026 21:47:00 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:fffe:97d4:c0de:15a1:9c01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm28781261c88.22.2026.10.26.21.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:47:00 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: edumazet@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	jonathon.reinhart@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] tcp: check congestion control restriction first
Date: Tue, 27 Oct 2026 12:46:49 +0800
Message-ID: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
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

tcp_set_default_congestion_control() takes a reference to an algorithm
before checking whether a non-init network namespace may select it. A
rejected request returns -EPERM without dropping the reference.

This affects module-backed algorithms too; BPF is not required. For
example, after root loads tcp_bbr, a user with CAP_NET_ADMIN in a
non-init network namespace can repeatedly request it as the default
although it is not in tcp_allowed_congestion_control. Each rejected
write leaks a module reference. Since module->refcnt is an atomic_t,
2^31 such writes can make it negative; later module_put() calls warn,
and rmmod can hit the BUG_ON() in try_release_module_ref().

Check the namespace restriction before acquiring the reference, as
tcp_set_congestion_control() already does.

Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong to a restricted algo")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
  - Check the namespace restriction before bpf_try_module_get(), following
    tcp_set_congestion_control().
  - Describe the module-backed reference leak and module refcount overflow.

 net/ipv4/tcp_cong.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 8e83ef81fc187..e3f462f161dd6 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -288,12 +288,12 @@ int tcp_set_default_congestion_control(struct net *net, const char *name)
 	ca = tcp_ca_find_autoload(name);
 	if (!ca) {
 		ret = -ENOENT;
-	} else if (!bpf_try_module_get(ca, ca->owner)) {
-		ret = -EBUSY;
 	} else if (!net_eq(net, &init_net) &&
 			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
 		/* Only init netns can set default to a restricted algorithm */
 		ret = -EPERM;
+	} else if (!bpf_try_module_get(ca, ca->owner)) {
+		ret = -EBUSY;
 	} else {
 		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
 		if (prev)
-- 
2.55.0

