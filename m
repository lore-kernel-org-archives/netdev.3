Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286646;
	b=d99SyoVQe8u9ektcH6kthCuQxpQIpOdWiH2eszyUSMqDJVmasF7DHVw2bdRmSMAPGnWl
	 J8k4cvmmHEIf715r0S3h88oizL8dAqaZmtBDtNIeXv54IKmFezwbI2GLAUkS97CGgL4A8
	 ovWqrhU+7xgzcYDuJb81K2KcDGoFUqFTFVk72VZSuwmHC1wuaid03W6sR55M/J9591xR+
	 XM2ogIJYs8/1iWoxpvq01S0M/3MZOrdERE1aX3CnlhXZL9vjbu0KQmLkRiTq1E5KD/BWE
	 451AZycMOuFnFIj8F0HL8AWO3ZKPmXqWrhdd6HIlMdfe9BVcNSPgfwSvuAvB01DbXGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
	b=xVdF3H/d49xdpmFimOvqA3dhbg2zTxQqms/9CsnzcRHhqhmteetQLHFMxRsOVLUZ7slb
	 rFW1VawPCxnoDR2i/tbA0G6kJ5Ae7OINTcFlcivETEy3sLzsesSj72S9bJdBz5xvPoZsL
	 zmlUdIboPifenwuMmoz2fuF4qzu0VXDDuXY6w2gE8RjQQhuJjMeECGr8jE/7yw+bTlTnx
	 8FMleZwrwWfk2ZSntoYEE8cHP1CCzB+lZyLms+6E6R5KOFb9jRkMkvcz/8S0XZ5GWMA6S
	 4P9+EYXo5fXdVlAO87X/nRrBhLh3VP7HWa7lFnjPM0dxefJ6ZZfIT0uHk5fuVMG43dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Pmo0rHrZ;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43795606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43795606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Pmo0rHrZ
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d28f75d62so210841766b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794286645; x=1794891445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
        b=Pmo0rHrZ8xzQ4pc9jzGRDfzTjtLd1IRAVVjXk3M8DK+x5lpVtGm+3Dl6uTtb4GPmpW
         /kKBYz2hrc2Rm+Kxx9p9Y1rOYhYETA+uur0JgwJCQfbRVDCqGAQvJaSqLr/CAtouJUUp
         4EI8JGlE4+HOHQpjKg7Wj36ghxkdR1iij2T5AfQs54lGgGxXfNWJBpU3fu6uYaxmp0iE
         h03+ZFTJVKcxuVU+h2Ajxu9vjISLloWpvzjtjz8V+N8eqRtKz/j204rfu5i68WzK5U7n
         uni6yfWdBejSU4Gl6uBoPfx8AeyMtwsNevJKn7zLq80NHgCRRKv4vWsIOySGtv3QDvth
         obtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286645; x=1794891445;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
        b=sTmjnoqNJgbDjIJbDBhg1UpCZTpH4CTrzTaMm5FPj3g9ixvwgY4M17fqrCMkKfYpOs
         kZQIOzWLONZ3rauERLXoC3GLK7U0WF+sFcZ/6IUA4UXHfoq678DgVDBeoMsYzYJ5zzIR
         5DgjtFj+fI8MnpEV9KEJdvG/2vt7Vl4CXlw8zO4A3JGMy4zbNLR1TzB3LzE27MeAYAfE
         KlDk+041biaIfBmOjVSBM2H4oo+pgkQwqDAdEcanp6JVPFDDzVrJ3KCHwoPRPtPIpAO+
         CRCLsdQoPIW2MbFmZPXp2MoZULykfw8gNnkY/q0VMJ6h8EJTPBseoecmIWNVfuT7LDLR
         1Gtg==
X-Forwarded-Encrypted: i=1; AL+hErH9gQex4tSven7sXnb7whPTATwJSTw9PejAglZcgEfQfL2a9AjxHER1avORbShmy7aavL5aRwA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HI4eIJiMRYT73k6gNynioyq0OLeMG9/HfMprt9pnYou1VFoPN
	NnOgtixVWH6jORREKw9JMV7tevAb+RKmx7eYmn3Wqq9z5YztZFKg33hoziQuabnjM6w=
X-Gm-Gg: AYBFou37rEwniyg/PvZYSY+r4IaRnfhwlxW8BoYzhCSVhNuPxcaWn5duRVXXMrL6XfF
	vmYMUEYW6f8LDpuHgNjAFkRYMZ3hN8lHSOIbeCvYr7z5WT9qeYfwJrucOZoWGVBDyXzBL6QQzZ6
	D+4DtWj7c2f1r4j2aVWYA01OkS5nwhbb+M0A1PTJv5jL8xLBtXIMhKd/df0wGvZmioCvxd5XLmV
	2MG0adK1kYdYGEBErHa0OTuhtp8ZEab5H4ldlcaRNSjSDLDmL0jSKQC0aK7TaHbVZmqoUj8pznp
	5/z7kTI8rQrNP76BYkrwSDa0DT3gNOqdXTX+a3CWBTbBB7foEDNh8XAGEnkWu17LzbNxQ2jWUO2
	sRrNbTqVoYLxpfWFwd0YaGFkjgziHSD5hm8R9Hizbz4boP1NtIgPDZPl8PGvPy5jCjzX1OWC5JG
	5Eglkprn+T+Ik8WWNNaSfu3RWdtXVzpBR+ccqq/Rawvgu2vEqdzOiPV34l8lpq0eP35b+Trz3Cv
	Pn57gm1JGei5PfS1m8WUcO5Y1rqnEZf8iCdwz3Mjhx9LH02avGptNCfhvhTt2X9ocLR5woMxzLb
	80lLaYtKo0B52d+e0y7P4fqWZe7AsaVir41p3skDZ4duXUzkC/0BmVwHHlFRl9s=
X-Received: by 2002:a17:907:c13:b0:c49:9632:9280 with SMTP id a640c23a62f3a-c5049713306mr110969466b.46.1794286644790;
        Mon, 09 Nov 2026 20:57:24 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56c721sm61278266b.23.2026.11.09.20.57.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:57:23 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values when XDP runs on an skb
Date: Tue, 10 Nov 2026 04:57:20 +0000
Message-ID: <20261110045720.77278-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-206173@kernel.org>
References: <cover.1794281983.git.tianyi@cloudflare.com> <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com> <sashiko-outbox-206173@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi,

On Tue, Nov 10, 2026 at 04:10:19AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Critical]
> This problem wasn't introduced by this patch, but can veth_disable_xdp()
> unregister rq->xdp_rxq [1] while veth_xdp_rcv_skb() or
> veth_xdp_rcv_one() is still using it?

[ ... ]

The list [2] and I [3] are aware of this problem. If it is still not
fixed in a week, I will send a fix to net.

[2] https://lore.kernel.org/all/20260917185814.0f944e78@kernel.org/
[3] https://lore.kernel.org/all/20261105143356.17062-1-tianyi@cloudflare.com/

Cheers,
Tianyi
