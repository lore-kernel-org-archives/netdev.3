Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093248;
	b=nXK3AKXPN9+csaTrML2Ej1CVTiLTbefykU97/UFzVrCfETHq9klcl3gAYIXPbm3KRXsJ
	 IupeYyXyNTtN3/hNZaSUFWK9mgAAa2bCjuJfDtlzQkZuH+N0EdMi0DJTrXyGXkvZm8es1
	 Cd86Gui0srIdDCEl+R/LJOcjxRiO5iO3e/ekRvDqwvwRCM0EattYxYy9DhclaloyghgvT
	 q7yB8p2UbGVnLKWQ1P6xxr5BxO9j4FNNGQ1Oft/EA+m796C0E0mZttBUee4+4UR2/Lt15
	 /v0+aGEPdDEIaJRuwgWK3QIYCT9OP6bWMCHVAio8gaAAScAf3648O3HMxGnGOIw21RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NO/PULJuoH8GueUl87hWZsGj557aWTq0iq+P8FZEMew=;
	b=CmGeS09EQ8Rj8mv/9yqa6Bo7ZsiYKu1CApA1cKHkeFS5bpiK4w/pIuLtcg/DG/QJnky8
	 fbSnGpm7Ukwa2X7rDtWBOsmEUq8iGZea3CUCl4AqFbHziI53/9H/HBCTQ1HObQa39J0+L
	 cjNYzfnVkGAOy0UybayytqW52DrIqyhevGzt1rHJxKafSj7fmWl2bj3yNpxlAI9DPuUp5
	 iBRBlgzALqQHokyKS2zrv/Ps/t0dL41Khr/3eP97nxk0VuKmJ0zcdfjAEg7wrFuoKI6KB
	 fzpdw0kEjJJFM62pGp0UZQQN+jYqz6px+GIAAoFXH5CHBnBUg1kcCEanK6KIUttmVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rtA7yWz/";
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34683606A328
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34683606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rtA7yWz/
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c46d41f6af3so311663866b.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793093246; x=1793698046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NO/PULJuoH8GueUl87hWZsGj557aWTq0iq+P8FZEMew=;
        b=rtA7yWz/OJQELSB1HmzDG3zKW06pzYRIBoQhVr9HylKEpl/8BpK2yi87g1x16ip+Pi
         fL7L7LTZU/P+LP6tqSBF2kn+T3PkbIfav6AB+p7jJfqohB07r1R3PbJj+iHSDOfA2lkC
         Zo98+IGjED3QcvcZfTPyx9AkDAhssqZbALgRPWpyzhQ5XfYz/54hiiM5bcbgRREcz91j
         r1fmiKeQgLmKHQGkRW90lyoG1oL9Fby0BbWxiRMH8PoasiIzLMc5HTazYLRzyjMDVEYa
         m4F2fy6M9vyjirx33RfXRrSwve2RUm0QyLdHG+qFq6/zklsWGKJZJvNL6FZccBRQL9up
         L6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793093246; x=1793698046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NO/PULJuoH8GueUl87hWZsGj557aWTq0iq+P8FZEMew=;
        b=thLy3jh0aqWTfRCIGDFKsxr82CvP+jqcVRLXW09e4vdFEsh1zNF74SuVln6ikrQufz
         3Pvb0kS7wEz6OtsrNAq2AoKHJtF9ZgX6YihBnPZVTtp0FI+UW4h6ZWzn3EWYPIlObYdt
         27TDHn1geUiTvUTMvV6+m94TA3HiQEPCjuOO0y7Sxg/plTTY09olEF5UdbdSdmtPwick
         RZRTb2VF0uXeMPz6KlnhtImcy4Ac6PXIwJBigngiT7rF9ffglKJCizRmkpe1wRUVuDNo
         qvAa41/rTiDur0VhvV2fGu1dYBtuhTVIz1H+e34/q/HsXszGECP/J+kSmoWiLhUO5GXo
         lSIg==
X-Gm-Message-State: AFq9FYIzRV/+U+7QHkg5mmA8lDDN9BPnwh1gZpENbtUCApNddxAJpahE
	Lo31GIxHpXwu3YRG2ES5irrolJoeGSHKSHjBMgtKGIpF4bVWnc7OdWVu
X-Gm-Gg: AYBFou0fvPhlOdNqbvchX6OtcddS5cWy1jDv0AFyCm8JeAtSk3vPuCzDtautGx/TwtR
	9npVSqll4a2RWu34yrcNtTClHFVNqpKikyLQNsBcieD92yB+tNEhcd6/ZAbl0gT7ozqkCCWxdj9
	mv7Yo5kg1DVYrcGh6OadJtU3XEd3tI53Z+LqzQWux5IQlLV2e5RAmpln/c5+Fzj6wEi5M0Av5+S
	+YVfoToiLxLhYPjp2+3vEmauKMzrklVYW7aEAKQpj/Bp+1onvPVCAPpYtRij9Y5P+EFTiiGdZ/p
	yNPT2kJSO59l5rjHYvxIlYD81j/yvdIKc1VHHadSzGmECCM5cWh3BOd+HDe21CCF3N1Fy8wjqhq
	Ov9HPNVVCWuwIePPS0A1+rdqXntEGcGSgu37CTRet8lc4zrA+KgLqOLpiBqm9kQmz3kWnurorKJ
	qUGV4TP/CDSd6AO2IOpI1mBX9vPqzwOHkkC90ATqUzxiiIHhzj6jfIskHJSxF5p7DD1KXlbFyJn
	rPP6bXyST+GoaKJqffItLivkXKeG3QVHTNEiyXluwBwbha6UG9YobIi3egR2Dr79YnoDdqxo6FU
	7KbW+VSfyNqOYK+foUNAV5DftqBw8wLmCdd5HJYmACzMkuFaio1tMzuNUPfic0tbtBXKrmAP6YB
	jhkMWiw==
X-Received: by 2002:a17:907:3fa6:b0:c41:f29:72b1 with SMTP id a640c23a62f3a-c46bdeba202mr1042190766b.47.1793093246326;
        Tue, 27 Oct 2026 02:27:26 -0700 (PDT)
Received: from CCM-PC (83-233-221-133.cust.bredband2.com. [83.233.221.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7984f5sm417942766b.77.2026.10.27.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:27:25 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH net v7] net: dsa: qca8k: preserve port state across MTU changes
Date: Tue, 27 Oct 2026 10:27:18 +0100
Message-ID: <20261027092718.266370-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <179268501671.3290.6623232109527554630@kernel.org>
References: <20261022155837.760-1-yongzhao.derek@gmail.com> <179268501671.3290.6623232109527554630@kernel.org>
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

On Thu, 22 Oct 2026 16:03:36 +0000 netdev-bot+sinfo@kernel.org wrote:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The original problem was found during development, not in production.
While preparing the net-next RFC v2 [1], which extended the CPU MAC
pause in qca8k_port_change_mtu() to internal CPU ports, I asked an LLM
agent for an adversarial review of that change. The review found that
the existing sequence re-enables the port 0 and 6 MACs after phylink
has taken the link down, and that phylink callbacks can run during the
update.

The problems fixed in v6 and v7 were reported by Sashiko on v5 and v6.
I reproduced them, and the original problem with the unpatched code,
in a userspace harness that compiles the driver and DSA MTU functions
with mocked register access. None of them has been reproduced on
hardware, and v7 has not been tested on hardware.

Sashiko's review of v7 is a separate question and is still open.

[1] https://lore.kernel.org/netdev/20260922202653.1153-1-yongzhao.derek@gmail.com/

Thanks,
Yongzhao Chen
