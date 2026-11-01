Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551637;
	b=htYkfLXusOSujJIbMuY+F2bm4EDGXVrBiqPeEL9jF1KdEJGoQmGqogifgbOgGSbiCUhK
	 e8m7UXWvP0wCz03EtjK+6dTEOAa6fRRYxweYOmQpHkUZ/AU0tzlqaICvJAEPFDyaTfCPv
	 nJ6msl7FCcOHriMysxZ9k3POtle/MT+bTtrSJmgfis+/ATWYnBJTIdq0dpK+JBFggutN8
	 FdOUN5fd3p9IQ5ga674fCpFlmDtKYUNvNuENM7HngAd5w0l5COjiWKQiKHyqQByrEj0c6
	 26JEM3sHT4m83/0xvqSsuVP0fpWVTdAbdxf/gIBYOmpLrCOe015dtT8zPHgFNrjUe6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VG7KpqUth9C7vUEstwvVTw+ImzZPQG2lv8IyeNq6Cjk=;
	b=nlvnu8vrFXvhyrYRv7E2/VftGfmQXKFH4YsAV4714LRPZYtXhsyr3nRUKtE/xm/2SzjG
	 mU1rGoa9qeasH7Gzn/PeGs3qa0Ek/C8/hK8xYMcQ6QT3LVQSjTGCiwrOklG3DVlOiygWS
	 Krxz153kwZsikkYOHRFF0XIQoz2xCDyYS0pzh0zIKfIoy7e9J4VpzSAunhi5NJd0dtKiB
	 eYRpYjLI92Xni0yWNR422zc1/kvbcpnmz7X0gW0RZvQT4tieHHzSGF5dVKdxQdPSSmSPx
	 HLWSmtoOZzBde59mueXU+C3mjTs3cxMSypyISo6IyGDqr9dp1PWnyW97ntdpDq3JB4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=qHbb8Dnd;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21A60A260C
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F21A60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=qHbb8Dnd
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4682977f9aso270708266b.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551626; x=1794156426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VG7KpqUth9C7vUEstwvVTw+ImzZPQG2lv8IyeNq6Cjk=;
        b=qHbb8DndBNkVx2QJ7r39etzM4CIhvAGCMvh6rxVzQoGgdVYQY6lF1iYcaB4IbUo4l+
         umlbmHPZyVDMH8VXL2wTcsHoEWbh972ZdwHdcsSuU0v7RMxPsJ5XyUY/UGRXLJI9f7BQ
         h7FEc481LzN9aZDCnU5zqghTIVP5jE36Pobc5+G0vSFmq/F/s9p58f6PQxxpzbgd5D4b
         oqxIpXhbwOJY4wEyvyNvg2Nrjhsqtw14938jbp4hDdVEC9WKGvm3A3lKWzUxFbZkV3YN
         PnDJ2upx4J5bIsazOt/bZlN2uhCcl5hXZS/vFtAZWGqZ4FZJf8Irabf6GN+oJcnbBsql
         dRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551626; x=1794156426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VG7KpqUth9C7vUEstwvVTw+ImzZPQG2lv8IyeNq6Cjk=;
        b=FC+kG0z2Epjix+HbcWz9h/pjd8QedSFNZ+m3jS+8e38Em8OTww6BH/HnFCZcBbywQj
         fdqEpnsph2lzLbg8FQIbT/D+MEJT9EVSKnvIYxHalNOZEVVBxtTsvQr+LIFB76xGQHYY
         OnwKSHJRaU2e0FiW+c/m42XInaZRQ7g4NMbA3dxqHZIxWj5rnb0vExE8v9E7/YM09fb6
         Jp9niUMCFSD8n8kmX/itbuIZ1fKE5v6QDpdjiXr6gF36DN6XIxtaUfliGeHSx5Y/AIE6
         4qbbG/izThTtlwcQwqkD5RzdUpIQB0PsdRlJNyTfjoxWei3GWH6LaAgsMT6G5n4cJruC
         bqmw==
X-Gm-Message-State: AFq9FYI9WJD7EuMy/T0TnrIFA1FQgXAwtMuS8dFYi+pPMwvyvKNdKlGM
	Raoa/1IEcATTBh9uGJ89SYY0iUJwpvO0sud/JrA7Fj9qpsDq5DJ9kys/eNRu3CHqpA==
X-Gm-Gg: AYBFou2l/5+k5BLQCCQdSkVigUARzsSH2LX4ozNE8BUf89sjuvfMv3mqdvVFe6iYWMg
	MhUULdCW4WA7v7HYTv7whr6oFFR/YkzNhUOhpePAHdt/eYlgvf4fEGsJRVsn4wsQlavNURObKzo
	RgMQzrQXXmdJeSTT4M7a+tdyVVxaX6goUjbT3mUZzIh14CgtBbbtZmPvznoAKa394oESpgpjvRQ
	VQC7DYq8FaBv5/eNxUFO3Ecn3OxuxDFpcke0AQCssY1zHy7OPPlxMlnBJOlZkxUhHlfoZHodEEI
	85oSA6jymYiNMueJvI+4bYd+SLz+++j0B2Y5YEdYxhRPXwAuoizvUbu9GdoBpSCeqyM7Xryjbe7
	BfMF9fLWfPusTTqYsu4N71gMMHQ3YwyxVzlQkml9uC6cC5Xo3XHt66i0gbH01XhpXmEdCjvUktU
	yhulkkZgI0OQWyeMnfDXOFi96dVbpgBsqNDvYkSvuBH/CCNQZdtO960IJHMGOOROKIIiZkzWctn
	nqnvR27/i+LeILYn72F6jLMpClPhrbTc4LtnQScnT07dqkcoyb8AkqwyBwmmL4xWfzYQUhQNtU2
	TU3In9l5I0kYrGwQ2Rg44OMlcwpj+CMo6k4gKeaT34I/AF9PcKiRNM9P1SUrpuW+LWn18Fq6n0j
	KaDoFAlIu3ZPk19k9vah6HtYgn+UfozezDYNE4rwjWtJdJt2xwihStU2yJFUn33Xj7h9n21+0DH
	WjnjYmS+hSHomFAvO4bO92+c7FDeZqS3ho9nKyy5pETgCRR/X8jm8ENGV3ElhMTP+JTaYFbyO/r
	ZwlepnX+N1BfdX5lfYF8v5Mde4znp2svDjldUJFw1Z2HLci59Ep/M9FowzLlNTqNvRjVt5GHh7b
	gGRJFrwzuvQJ35auBc8=
X-Received: by 2002:a17:907:9341:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c4ca7a09978mr643941066b.17.1793551625975;
        Sun, 01 Nov 2026 08:47:05 -0800 (PST)
Received: from Desktop (p54aff790.dip0.t-ipconnect.de. [84.175.247.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe1002asm296061966b.45.2026.11.01.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:47:05 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 4/4] ipmr: do not drop GSO packets that fit the MTU after segmentation
Date: Sun,  1 Nov 2026 17:47:04 +0100
Message-ID: <20261101164704.302087-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179241583068.3135.17027966387414517090@kernel.org>
References: <179241583068.3135.17027966387414517090@kernel.org>
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

> Should the inner UDP header length be accounted for in the
> skb->encapsulation branch of skb_gso_transport_seglen()?

Agreed. v4 adds patch 2, which counts the inner UDP header for
SKB_GSO_UDP_L4 in that branch. With UDP_SEGMENT over VXLAN with DF and
1404-byte outer segments, a route with MTU 1400 forwarded all 1000
segments at 1404 bytes, both through ip_forward() and through an MFC
entry; with patch 2 none leave and FragFails counts them.

pw-bot: cr
