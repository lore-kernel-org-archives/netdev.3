Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616801;
	b=QtM2sQDyTf8DJs7S7ZZQQvmi/1+l81mqUs+ikawaKf5xAYQwjQZwMDZMSYJMMeRvB8kH
	 O5NrVOLY7xjU65azW0epZZYkVfN9As0efZ8GKEAQJZuv3UQLoE4pDk9f5QHV8/IJ0nGkq
	 p+dKgO2xHU+ptd2vHfH72sYbtaY2rAbvLGNrnvmac+aZzKry4N/B/04gMnOtqSPO3vKwp
	 WzEk9JkFVNJyk8oqX0Rjd7c1mf3vgFCWW73v694hqwVhxl4ge+2SzS/8LW7fIpP734SMr
	 OO1+BrNv/wvhe/CN82o4Uqu/nD4RAQPnQ06SRHKj2pOAPlogNKWESYpPJyRiQx3YZ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616801;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T4y4qHErCUjizAzkD5FVGa7UziyW70K01/ZD4UHFGlQ=;
	b=poe0KZZb1zFHP1QOqSMGNUUeyS+toFXTAW/5MHJ1eONQvF7Czg3VLMSOqR/Zv9Xn8ug8
	 a2t5XVZOH3jO0LLeU9XBqMx/DgZzxkQrceo4zSp2Fu8Ufo+W3Zcrs4Z+eA66FpYveO5xF
	 44acK7nXOrRpGV9L9H2b6YpQkny/RQtcwhC8ME7iUMa0n1wJoob7JZSPKdmui7HYfyi6o
	 9cgBpJm8zrKcp0ESqgELYxrn9zg3xp23ndNOpGNtXEKU2aNwXe4q3NIJ/bMP8NCtzC+aa
	 tTXxfKS1eOsHnIFm4+vl1+9t1JB6c9huXc/WxXf6XWSCo1V6g6Ccw/9MSJYSAhUBPBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=VCiSjpfR;
	arc=none smtp.remote-ip=115.124.28.171
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0A606A326;
	Mon,  2 Nov 2026 10:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED0A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=VCiSjpfR
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793616790; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=T4y4qHErCUjizAzkD5FVGa7UziyW70K01/ZD4UHFGlQ=;
	b=VCiSjpfR0xAcQRFTMfZiHH7n0kTZJL7pb7PVhAHbg/4cvzFiy7QHlBf8oJ+2K4IFoGWApZieKjOVOBKipbvrB5THoBCDP3lLn3I7xqW2d3mchEDjo66Cs6pQqlyOgSOSoFtmPWN9A7NeXlWJ40wR7l6vxpYJcLcj5gKdleB/uBc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06373121|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.037735-0.0024049-0.95986;FP=10386311332249785874|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jumRy2H_1793616787;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jumRy2H_1793616787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 18:53:09 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] net: wwan: iosm: fix potential skb leak in MUX DL decode
Date: Mon,  2 Nov 2026 18:53:07 +0800
Message-ID: <20261102105307.11263-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAFEp6-1JqRXuXQgaoCRDivHyu668d-5Sb-gY+rWbn1aEBqTV3w@mail.gmail.com>
References: <CAFEp6-1JqRXuXQgaoCRDivHyu668d-5Sb-gY+rWbn1aEBqTV3w@mail.gmail.com>
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

Hi Loic,

You're right, skb->data cannot be NULL in this path. I traced both the
allocation side and the RX path that feeds ipc_mux_dl_decode(), and the
check can never trigger.

Allocation chain:

  ipc_pcie_alloc_skb()
    +-- ipc_pcie_alloc_local_skb()
          +-- __netdev_alloc_skb()

On success skb->data points into a valid linear buffer; skb_reserve()
only advances skb->data within that buffer and never clears the
pointer. Allocation or DMA mapping failure returns a NULL skb.

The RX path is:

  ipc_imem_dl_pipe_process()
    +-- ipc_protocol_dl_td_process()
    +-- ipc_imem_dl_skb_process()
          +-- if (!skb) return;
          +-- ipc_mux_dl_decode()

The skb is allocated and queued on the DL pipe by
ipc_protocol_dl_td_prepare(). It stores the skb in skbr_start[] only
after a successful allocation; on failure it returns without advancing
the head or publishing the descriptor.

On the RX path, ipc_protocol_dl_td_process() either returns a valid skb
or frees it and returns NULL. ipc_imem_dl_skb_process() checks for NULL
before calling ipc_mux_dl_decode().

The later skb_put() only updates skb->len and the tail; it does not
touch skb->data. DMA writes to the mapped data buffer, not to the skb
metadata.

I couldn't find any code in the IOSM driver that assigns skb->data to
NULL either.

So the check is unreachable: the skb that reaches ipc_mux_dl_decode()
always has a valid data pointer. I'll send a cleanup patch that removes
the redundant check instead.

Thanks.

Fang Xieyan
