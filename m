Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599189;
	b=WmZvrK/SKAzyIsa3Zr0nPqCLdNjzMsvyz/qxIsBw11JfpiSDL0cvwxbo4Yx71ryVAuoE
	 j0DkJ84BUJjNp7KuvchMl4hCfDOeV1sWXA10YrccMF7HLyxBVS+rMTWO5Yep47ie9cWxn
	 W3m3nTZBWIWN3saQ8Iz/s5EPyPHboskk8Tb1iu0zcXAQVPGlAnMCIJ5vT7DLTxM0usjb0
	 ZIdIyUu/W7bp5dlNdgXeF5gzdZnBnXSIlc8V1EHF5nxEDfcTYxsIJXolGQjDDnzPQV8/0
	 6BUNS1SrCvLEMwlVd2io/TsNYV/t0cf30JoVviyAxt0xD+iir6dRm39pAv+5kDnK14A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bnFbcLg4xPh0sKDXQsE4qpXTpMcLOCkYe6dKlukYuLw=;
	b=0jru49BJhdH2IxHALPq7sT29E/OdifPfRPwCBpUZogLRojgkC+KuGGrXIsi3gktl1xUS
	 9vdakwBccaZ0STKfxOJnjp1Fs23ZAhjkdfMY4tqvdR03vCEtZFJ6FMSOOqbw7MewnM2+y
	 GzoqhFmqV/5NYn5HfDWf5zRCVoozZI10M1D0qJydKz47hJtK0BowTmrx+1EoAYT3q7jtf
	 mnqMVqEp9/bETu4b/URg93He0btWwUgLTUgObzO86XNnFR2PtUU3lYKAdxqoVDcu9ILLO
	 OtPHvC2VVEsoHiHIH8A1GxL5QB0Sdepby0XjVCpzBQPcOCU2wLWS5+43ryJlF7ffRhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=lUXWgwOT;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66313606A337
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66313606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=lUXWgwOT
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b394e2af9cso11106227b3.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794599188; x=1795203988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bnFbcLg4xPh0sKDXQsE4qpXTpMcLOCkYe6dKlukYuLw=;
        b=lUXWgwOT0nkGaNixNWwsujzne4Bek6VhbLEYIq+4/GxurLCI0t0pvTn+G9P2HCpEtg
         B6qcag4rfJHE+G/2dfHYHrLbgLIYX2ybRQW/2X7//qE4a/V30/qIPhwTP2XeZ0kLHREs
         RWgKRrSI6T0hnt6UW0NmSzMdv3sFQx4q0ksmZq79Uuz35PsTDPHgaxQMrT3UvIlEu4Vv
         2PMw86rb6CVcl7CntVwrNeUhIbtOM+akuIo4i0dpB8Br+mwDZhPJoLH8a9kTL1r2cLUo
         jOlFs/nQyuhbxtH7Jh/EaJ3YwPY3Ls9oSJCVPwAmC7PpFr/fM37tKHLd4ZmHPhY2jhSA
         tpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599188; x=1795203988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bnFbcLg4xPh0sKDXQsE4qpXTpMcLOCkYe6dKlukYuLw=;
        b=fwfp87Ozzn/B9AhyNOn9P+4F9Lsnv/KL4o4xGct3Yev+m/1vD0zlMnjDZ+IBD2PGiX
         pFGC7VO0hotMt/moVAbtmBW8K7ZYNcvY7G55c0V2btHUNdZxFNiK0rbCGA2y54t/xwqn
         eVf8+f9Du/AQKJe3C4J0eC+3zcyWT2BCTMjvjM+T7FrEyyWN3JbFU8Stigt5QxHHIw0V
         ecwotuekigqX/5v/ojTlvKQmEgMl6looJwCZK4TzoHpPlDYgkXUFcpjqcrgA0GrnYKDz
         Ar5kZtyF+mFzxd4Eyla52PN5MOSVsbU+w2rGyiXS2ImcVUQmCp71axfWmp3TH33vRGAt
         vdsg==
X-Gm-Message-State: APuU4Z+NpRUBbpOoyfBtMy+jQc9gV0KtBFspXSpWWjLJXK2MUvDpfDuq
	DcXeEevK7qonVni0tgHTGAQUHnLnToJqG/4iqP37+uyUE9/BdwwW6loZJ19Gujl4ds0238S5Vwa
	4FUNZ8gg3Ya35hNtku7aAPsp6CEuLnNHaXuJJgcGvsIeyvDdW/HmWsqja4zHiimSLsMucYYu6IR
	J0pe1u3x+MsDQNMIhWMFLEyQbrjkkkc58LkOCWIrMo
X-Gm-Gg: AYBFou10qMWF9bw9tcwoElkFOYIDDu5UhFSGDzDsrShnfFcJ5o0jo92sGKFXA41sa1s
	2iHeTTOUspfzR7jc3I18dXsiBFIrjRkesHU6dqG5ZAdXSDjEQ0dcBGUR8TLoLxi/6wfr2Pj1K2e
	Fu7Dr4QzuaLUjHBtz+Rur7l2xwr4HY5T1Mg6vmYhIx7qLYOiChEoyLe6Ar6thHmtG6JZR9BFueS
	KDzywDIVYU7ATy5hgQfOlzSRbGtQCR64KS3kr2cEMnvzlkXH/ZCbk/BUFIdpqjN68CCH9Pafp6A
	O6ucj1EUBOGZAqidrj9K7FPTMFSFqiliX5zfd9B7se7372J5k63gwMNGlpok7FH3NgK+cD7Sxw8
	74gThASv0CILwm9H0GrQ4k1AbAUdv8xWz7QcEHgWXEUbAcI/WXpZk0GlDtMH8bqapT+hdLVpc+z
	rec2TBLmFNSfvi4R3UetJnJt/CxDazaf7P4B2VpwkRQTGoZcRJMRo0/AESfTYUxiPF1MKRAaT4K
	jNpMmKO8VcO7WVBsa/5zYT8P+H7Is5V6fwzfJivHRECo0WZRQKifXRGfkpIKa3IrkfTMCrTRAx7
	VhSK/CEv8cG6Mc/PJUn5gOdGpeWZ9n3VCAiDYR4GINoITxnVxswAQHfFbQhbUUHcCSnbeuK7
X-Received: by 2002:a05:690c:c4e6:b0:8b3:2ce6:a3c0 with SMTP id 00721157ae682-8b4aa26fdc4mr21818737b3.26.1794599188303;
        Fri, 13 Nov 2026 11:46:28 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa7f1a0dsm28393167b3.1.2026.11.13.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:46:27 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: fix send() returning success after the TCP send failed
Date: Fri, 13 Nov 2026 14:46:20 -0500
Message-ID: <20261113194620.3830173-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179459891623.2168702.5534679656595552608@kernel.org>
References: <179459891623.2168702.5534679656595552608@kernel.org>
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

Hi,

I found this while comparing the behaviour of different kernel versions:
a send() on a kTLS socket whose TCP socket is in repair mode fails with
EBADMSG on v6.8 but returns the full length on v6.18. Testing
b341ca51d267 and its parent showed the change comes from that commit,
and I then checked the shutdown(SHUT_WR) and reset cases from the
commit message as well.

Thanks,
Hengyu
