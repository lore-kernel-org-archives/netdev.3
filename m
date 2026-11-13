Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614267;
	b=PDzt7VSa8uTuVJLNo6rX8dO/JCMsm5JYZDKNCi9TwfnBNnSgVklzWinQ2KBussHR6jXe
	 zpmXcbywCe+gIrU5rT5s7N3GmEZJOPsjm9CSQIbL2EvQQZpXppmqOxcnYAlkR77m/obOL
	 WIT3EKiqoSO83SRyxU3Rs3Svw623RzJQcFNLyrvzLOwanJNwNiXtjsQcUy8rlev/06YVm
	 d0nfWNYhi6xnwV1maSNjDMuNuuky9Snnp5ztUj1m0D1VnBmY3Q8SzClYjJ5ejiRCs9r7b
	 XIvL1AaPN/HrxPLytMCl1SEH/6xzfe7iQ5hmE/cdyilOEq1H90ShECZRlTXoADR4fZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=bh2UNPvOiO8aUnufjFtSOv41iN7jBr7C/TgT2GV+uOM=;
	b=0elz7Fl4dfDl6wIL3Cb7qczYxBHQeGQQBT8GxTu4np0Z1iqbEjOP2nYH+fPZlDnCyn7y
	 rF/YjZn6bCdvXIAgxkp8McfnS8L6aRCCs6soJ1logREYD0wM+nf/K//9+4mnZCeb7ldcY
	 tLe8j4q+tDN41lPFud4atlIqkdL4vQKTV7n/9jEq13uVgBrQSalFbLBrBRTChY94gmBT1
	 /m+UvSKAADgLcNT3lpivlD2l/3mK/3svkDIQO257CFJ1otkV2KRAbw/iwS9c6Hz3Kbrcn
	 o6fh3q7Kwgtomm8rCCcrZyjnQI9tGR+IyCgC4oKr4h0VRP7sDQp/S1EOE1lkQIrNqwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoApEqsl;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554A0606A883
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 554A0606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoApEqsl
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so2828725a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614265; x=1795219065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bh2UNPvOiO8aUnufjFtSOv41iN7jBr7C/TgT2GV+uOM=;
        b=AoApEqsldD33Mzw8Q0Y5Ubdt7meVfWlqgKmEgwh+yPmD0dZrNuAZJeuYvU/ApgoJWP
         mx/WvYqzY9U8Cz9kdiRFhaPSvuAH6lJz1dfduQmEedaSDYFTzhHLUToKDt/4YE8gA4ak
         5UB0ktmFKc7X2WnNQe1vcyZGBGetpaZYXqYaqCWabrhMZ0qHkTBBVRvVo/rUKLUJHj/u
         TC6zNVjANSvjxrHJ5+vbGvQx8ZfkRpXGjQ/zJHA+3eOnmK4mBfWhwAibenzsq2v7CmgZ
         9Pvlgy1LyM9R/Ne9/tqXLZWtSYEFrlMQ2Q66Nz2kg2pZkbXOH611GKGjmh7vCCCJ1k/S
         RWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614265; x=1795219065;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bh2UNPvOiO8aUnufjFtSOv41iN7jBr7C/TgT2GV+uOM=;
        b=NZR+5PRXBtArx6ZL/q9hBWf/+9c/o548TDADHiqlAJ/i+nwH3gKDWCEFGEm/ONeqLJ
         wZ5xhfkYz4aunCziQoZsUprHXF/h7fHaO01sh+N9Joo7d8Hk2ln9J6ZT1aq6xYGUMXmm
         41yby/nU6JRn42ACwRGPtrznBD0hJrcxysNgMXI27Uo5RMpGd3zgIY+w9z6OHxf9sQ3+
         /kMx1PG0OPTGnwYoB+yG/D8QDOeeVXSKRKKZHiZfSW5ndYg6hj98aTzcnaTCRdLk/UxM
         7TBJODP1CGrAZUZE/Ll1+g08bnj1rgvl0heOky0T01CQ09NqBeqH3zcFgZhq8ehbe/ju
         Ei8g==
X-Gm-Message-State: APuU4Z+w6dESxxcIfd8oUmaeaxU4TcRxMqaiIvgbY2+ww1AjmiG47n6W
	cYfEDROV6Bv/QunqsjZIq0nwFWwzZ/uXOC5pDZIHwpGW9gugRoYPWOAD
X-Gm-Gg: AYBFou1f5ShNmxdNNMTV9it3izNnWwjjhSoc/aDFUIevwdTtAajS1tphq6+xQRL9cI8
	5IKRVz6ZF2yRa3fC0PS8Dzvs6Y5MGedoko2ltt7/y2tkFrkFLF3k7Fr1OnQG+vfpaPVQfGmaWxP
	wU9qWFvqZpAHOqe/msNivsqfHbugwDwqmq8kHE618UdefSDkpDCUA7Hwd6cKjV/4p58pOLzvB8e
	83zM7jwuppY/84oG+ZDy7BrCpvLEXF+Y3FpGLZJcybA+SBP+AFw+ZKJtAMONY6lqMwO2iNhwJbm
	XodBxRJKVW1I26mH1a4vscMoiUPk4EmSGtoCiLSjgjVrX+ctc6eimfxfgQ3/3OG33DqCK776Tq3
	jmseRgwnZmRUXIo49C7YtkOlCGkVk0k7dx7g0/UPYlmm9ysfkoDd7L9xgeep9NJmtR7aK+EmI2F
	mzZk3uAM70cteMqrQyLB9xz0ciesYJ6M55Z6fl1eEpV+HYiYJ5btLQKlWA1BHSzm7fGOOIIYznR
	59tdpzE1GZJ59h9WuxXktC3Ea/cPWvXKjpLHRInhXzmI562dQA0D2SzU81aix/woL7glNBQX3WE
	0PsDto4rXfQ+gJ+B2jmkFSNl3trZbtNzMjYxNQRq
X-Received: by 2002:a05:6402:565a:b0:6b7:8ace:4bea with SMTP id 4fb4d7f45d1cf-6b7c0bc4f57mr2643744a12.13.1794614265353;
        Fri, 13 Nov 2026 15:57:45 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1a08sm1577698a12.5.2026.11.13.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:57:44 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/6] net: bcm4908_enet: fix the TX ring wrap
Date: Sat, 14 Nov 2026 00:57:42 +0100
Message-ID: <20261113235742.516908-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <179460252768.2199510.4667025168810979943@kernel.org>
References: <179460252768.2199510.4667025168810979943@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Nov 2026 20:42:07 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] net: bcm4908_enet: missing barriers and late write_idx update
>   on TX ring

Both parts are older than this series, and this patch doesn't change
them.

For the barriers, v3 adds a patch in which each side publishes its
index with smp_store_release() and reads the other side's index with
smp_load_acquire() before it touches the slots. It also covers the
bcm4908_enet_poll_tx() issue below.

As for the late write_idx update, start_xmit() has updated write_idx
after kicking the DMA since the driver was added, but that only became
a race when the TX interrupt support moved the TX cleanup out of
start_xmit(). In v3, start_xmit() publishes write_idx right after the
descriptor, before the MMIO write that kicks the DMA, so the window no
longer spans that write. As the review says, though, it can still be
there if the channel is busy with earlier frames and picks up the
descriptor as soon as it sees OWN. I'll look at it separately.

> Pre-existing issues:
> - [High] When the device tree has no "tx" interrupt, TX completions never
>   run, so the queue stop/wake design this patch adds cannot work.

The v1 review found this too. Without the TX interrupt, open() never
enables the TX NAPI, so nothing frees the sent frames and TX stops for
good once the queue is stopped, and stop() hangs in napi_disable().
Every in-tree device tree that uses this driver has the TX interrupt.
Florian, Rafał, would you rather have the driver require it (and the
binding say so), or poll the ring on a timer when it is missing? I'd
send that after this series.

> - [High] bcm4908_enet_poll_tx() reads the producer index without a lock
>   or ordering, then reads descriptor and slot contents with no read…

Covered by the new patch in v3, as above.
