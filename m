Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220511;
	b=iV+NHlGEW47Epp4nZbO/SQ8SNo18D8wSY/vtYiInwMvGIZGdNagZG91HmH4VVWd5Gvp3
	 p4Q4jlnSyCvefDdasOhtkf66RcCAC5lW2zwccOdV5S4cee3Ikh2e1bQYSMBxjBDGD2tN1
	 M8MguUYo7fmazlick8VbLkjOQDFs5KHxaJ+KGKm7fj0SFoiluJeHZaOTstkUz4U002YJa
	 TPV8XzVyWi83C031KmbUNxDjZAUNCwcHlaLHIjqV5OB5yFy/URQ1ujE+VmaHtvETNt1Tl
	 JOAziF3BmAGfTkxs/eBg6q9m7wAf6kJSlSCjhff+TFBumRyGRoE1w6vWDl9GnsM+Hrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8Hb0sYmcLHQnhtWzS9j1woOF2kw5P/sRWChZAP1XD0M=;
	b=p+ff1uY25f2rgp0bK0BFDyF3cW7eV4hJjebtdwBSYBf88+dFc9nBPZVA7I4xYbY3Eng2
	 OocJ01CSELD5ycAn/V5Xf2aQdWNLhP7breR0eMEMRQIFfSR3puKJMVzDWY65Ce5sDopn0
	 FW9sRAFMUvfBIG+9DhS4r9BCHl62qq5SEsL461pCSB/ehhiYgel5otOlm38ZoxRnpvf9l
	 o4rvfyjJZ/K4PDGoSepxSoctidsZEgFh3bL4qP04pqSiz3PhX7G+VSb1iSwblCg8PpHsh
	 ybd7cDUXWh8E9xNS807DVFE/BglH1AoHgREh82mKw7piV9CqW2BJh7or8qV95MXy05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g49MWb5/";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C24606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0C24606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g49MWb5/
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so346853a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220510; x=1794825310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Hb0sYmcLHQnhtWzS9j1woOF2kw5P/sRWChZAP1XD0M=;
        b=g49MWb5/yifGNXK9v3uJRzMXvdGfHYwVnDsvkvqEbUJ6QN0jlYqr1ebA6azfClAOT/
         RK/UbwGDRf1IqGGk6TL2Kwi5PkpKUg9C6hmiS1LVRsH41VSiAS/nlk7H4cp+5AJtbbC8
         GSnqjaXUhNuWEVSqFtLKFOu6cE/WcQjuIWQRH2P92DD+wRfV4wAR2aVxlEVHt2SgG/pJ
         srvU7WjvoR/jsUrFzj+vQ8Yl48XoC7MhyKTF1Rap8WKCzascASo+RhvYPclJepG/G00W
         7VgpYVYilAtvFTbNuW/FfaxsImmKv8evAU/LZm2cwA0Xxmi5Lv4IJeerouQbo+5r+rWa
         gWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220510; x=1794825310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Hb0sYmcLHQnhtWzS9j1woOF2kw5P/sRWChZAP1XD0M=;
        b=EABuWllmM0pY1pMNyZzVD+gKpr4IHX+dR44l0L72GOVOfeh1i9xQ1zS9CzA/8f1qYY
         0U+rfEvU0sxkGHT6vscVZVSwyt2V+Ny8ucPfquccwGcskjEblmtxxfOiDTkT80Bd11jU
         OTde/0yDlusonygzdpjzEiNj0pWmGnLtUvn+4JhOQt7RovYW6cSTvo53KraqqcNnno6a
         o6feOntzj2WfB6Bqud5myc25UGmI+Mhs6EEq8y7DT0hF6GuXN6N091syBam806td5s11
         Tks/y4kmUiFUNVoPHm2JypiDu10nfJhSXlReuw2f+SbGfufTVO7k4O8o9gBgncGfVM8Y
         B7Rg==
X-Forwarded-Encrypted: i=1; AL+hErG6B+wyfDPsSSuX0BrIMKQNG0qIPUmlpdj5ZzvQrrGNPXZVNTBS3Hou6Ee1LuMRjwTTzFr59VM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DJ3yzMnMcxG/zNsS60Wa7NjkgpE6DGDvCOwC58DOaFEpH+lu0
	ZuCGHb5Nb15k7+QjcJpKtJseIRHDm7G8JMckbHd7BDhIhhNaNFEMd4yL
X-Gm-Gg: AYBFou2hnLtPhyh+ncEzHY8TmftwYzyLVe8AQym+L5STBvnPYhOo1miFCQsTa4Bc32S
	Xl8MB9FYtEJ0OY+FaNDXFAoC03hYa+VohbPJafLqP3KXRmWhHPtxl8DZIoPcq5KE23pQnR/yOu8
	1G9XxPpc6tKFA+SRly91OxacZbkQMqWPHqfOf6xQTfEQdjyW7PVlF4TeYekeEQwGB+IRkE/rmmm
	qsGamDEWLpNUvOfYj0lAXW0oo8FnbuYjNfVrmsMVkR8rgDvACxjOEa1VyA8VuM4j8UO5Y5+I2yX
	5L1MtQdey4sgQ4BmwRYHMqYppsCm90ly+oRL7+kJO3szLai6YgHJ5oizKcGQnmg78sHkEs/EIgg
	k0Ts6Mgd7rMXH1UUVJywYLzjWYaB19qdyz/pJCNUcFZMOK8LTM15LzlEZiN+PGg/jJdOItgQoJj
	V3ex7ZdDzC9+miq4ROsVEtbMX0mhAXaj+/XVDrF/W8hN0SkZepTheBHO6NkqO7yZj4elpZdD8iE
	eJFtqpSdb7JE3XJDzTX6VAiDRq65islH14dTokyXsIqB9AQKE9UB1ov9JY8J/kcFAbdg/LEDZSZ
	yx2+k8Rh8vqVgWm/0zkbhefDmjMFwRsb8g09p/lYN/dD8w7Sv0qqVkdOwMYcKk58YRpecwndl4Y
	G
X-Received: by 2002:a17:90b:530c:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3b12d49b258mr2971323a91.50.1794220509924;
        Mon, 09 Nov 2026 02:35:09 -0800 (PST)
Received: from LDYT9Q2G2M ([2a09:bac1:7680:450::1c:35f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d3310sm10379457a91.15.2026.11.09.02.35.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 02:35:09 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Finke Lennart <lfinke@student.ethz.ch>,
	netfilter-devel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] lib/ts_fsm: preserve patterns across tc dump and restore
Date: Mon,  9 Nov 2026 18:34:54 +0800
Message-ID: <20261109103454.50617-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261101081736.51803-1-zhiqizhangg@gmail.com>
References: <20261101081736.51803-1-zhiqizhangg@gmail.com>
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

Hi Andrew and all,

A gentle ping on this series, sent on November 1:

https://lore.kernel.org/all/20261101081736.51803-1-zhiqizhangg@gmail.com/

v2 describes the tc dump/restore impact, adds the exported-pattern
equality assertion, and splits the fix from the KUnit tests, with
Cc: stable on the fix.

Could you please advise whether this series should go through Andrew's
tree, or whether another tree should handle it?

The netdev CI also flagged the new lib/tests/textsearch_fsm_kunit.c file
as lacking specific MAINTAINERS coverage. How should that file be
covered, in light of the dedicated textsearch entry discussed in the
v1 review? I would appreciate guidance on the intended maintainer and
coverage before preparing an update.

Please let me know if any further changes are needed.

Thanks,
Zhiqi
