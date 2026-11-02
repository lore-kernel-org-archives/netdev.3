Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578312;
	b=5kjMUmN/1juunUrGO0alKGGNjknhzjg8hG80ZQo+JnGb+dYwa9tCByqse/iYmOcIyU8S
	 rQVADAOHvu8a4K5q6oU6nZoBJzdWZm+lbIYHaNJAyEkyBHYW4fwMcQqCD5VSETikB/EcX
	 P5hm+81ZrVnLnOOj78wdJA0wk3b9ibLWnsmKvC9Sz8KdFxcK6wpdBRAXEyjtIGP5q+/A1
	 FJ6tUbCz13S+LJFs2+maB0aQ2B63UXGiZQAOWyyVd3dRhE1UGCQy5ILnbM8ZJ7EpZqfTn
	 l05QyqGE35iRACiEml25Bf/GMz929+5pRHsdds4H8krL/DjyaiN4geEUSXSXm0fnGhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:User-Agent:References:In-Reply-To:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=ifbkEfOfGkwf2nAJmeGFkDxBlo+BIDgfvJBi0fIliC8=;
	b=3JZqHJ40vgxah5/ZKxfbTE180wemK9GwvneTJLxtiP9+EzV6nviadg0716P8v8/i7rNd
	 nWIRLc3ufPqDoE/EV9ryXzdM3JQinT5eaF8TjvX9Uw++3BfcOS6l5Wu8bDAleI6+eHDoQ
	 U/Jjy2LszcN6YTAbdA4nDlW1IozqoKVMMtrpsahPyI/7FbI+CzPXrwZixbPfE5reQp8bD
	 ldF8X08UJdytRyUVsC/g70CBDFzGMmxel4WdfpPS17NZ8sh4j7tfKsClpIlcSpI24Z3au
	 JrMh9J6dzs+u23kGmMBItklseH0f8kX0xmmh29N4wIl2NUs8DcCs7NSgJlRzEc5iwyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDruYsbN;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C1D606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C1D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDruYsbN
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a07025cce4so1184059b3a.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 16:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578311; x=1794183111; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ifbkEfOfGkwf2nAJmeGFkDxBlo+BIDgfvJBi0fIliC8=;
        b=cDruYsbN+M4Pbz8MbaDC9paPhXi59DF71NzDC0dPkivx3ORZ40TEQJ9cAfQ6s6DEo/
         F+wFj9M27i0BbWXnUm2Lh7/p/iaW+CHodSvr8LfcfWmyYaGkdfqPyona5+ymvpkGADP0
         K+P4WdDxnz7PgKF9D4A+PP7USrmh8TMV2AS/FBdjimsL344OB8RZu156IPtD+OVOBN3H
         lGlcFPGCDMRZZ4hgxT83yJnXkmCP35g5JplykUspgb/4xf0cN6UlNgeTUQU5dptlC15A
         q4yNoCbYK0KeIqZIyx57GkRWqRkRjdx7JzLsSIriDjHxv2kMxmWyxbC96d05IFXyExwz
         dmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578311; x=1794183111;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifbkEfOfGkwf2nAJmeGFkDxBlo+BIDgfvJBi0fIliC8=;
        b=ILiU0338mPmWLsBOawaSE6EaM/4Or1fnnPDobV5B0vAoH8y6j2BeHKonXHy/jBq6Fn
         kA8oxSxHHyUxAwvWCEkHoHy7liJjB9ZFoo5SrOMAfYRB8tr8ap0Xc7aPZuyuqujISieL
         2MRJSOvQxsIZd75fdjq0r8VyUqwxEdTr1Hz5UpLNgOJ7i9rHDUhluDQyPtNcdz1VNJJq
         MjrwQhztQiBXqe78/AbbUTK034q8MadouZmZeL+5HLCn6iYpe57GRznU9V9OqkyYDN33
         WbgiIOjhveTE0RziCj59cCZ/FFJX2je3g+ZijNqZyEqbt15NQPwHQnPy2s5joCpKH4WS
         IXng==
X-Gm-Message-State: AFq9FYL529R0ov5MQZSDmY6g7qF5LX/B1uszMB3ic5lqLvPiE3WjeWel
	io8i+BxgRUSVtP+1zCbbcmJMrZr4AlYQzwfVwuHaMWkdGMsymVVT2IiSJBxaeQ==
X-Gm-Gg: AYBFou1vtSyEqjuRFq8rLYv91uOjKVZQEzPRPqbJPHNFkr/ukKkFH+Cze0kDlZDqFQL
	erXL2xmueDRavqMiKmrTaKrV8kQ+AHpko4arBofqI5KL7sfZk7fR0ZcdQZJnxkcFP8GT9tb9iXu
	b6vxLMuGJyszTzA80GiCky2vTzWU/g8vC2RnUYtCHzCCsnwddsdsR9novVRRV9OO0WFmw11HyBd
	FyF02/GT3Z/XIdQ85nQeUxNBMvaCdIOTg38GG2/y0onQseCg6Oa9oGJaYStHJO9VMEap1Ue2p5q
	+2AU++sb6RzurcDQaFqali11KioYuWI/ZJEaz3cx6M8E8RChyqOx+2mvt1zP+Ii7fQmfzCB5g7b
	P/YMx0l4bNbetqFxDU5DNZNqvQIWb2deHQPRkyx92oZosfTcPyhOxM/ou5HafLqHTAmLu4sQkCj
	Zl2ClVvwKl0v2lCF/UGDDA0tAL/gfSG3TMHfeK+LI/QJUqG1MAALrhnchDud+vsfMY9Wf/RKFIe
	9dvZxl2h3xNaCxKN3zc/Q0RxftBBKwIW19J4I6n8SGQFQ+D611N+JUGwSNOc/fQPqhb540TiTXm
	4dI3BwEq3PoRCsdBYttzUD7iHIgnRDfdhjpYZXQTDnUTl+J0cYFBv/i7ReYS2sFUiFkN8h+88YK
	EuzLbvp2wBSPLgA==
X-Received: by 2002:a05:6a21:4cc6:b0:3e0:b71b:a8ed with SMTP id adf61e73a8af0-3e92892ea1cmr7430023637.13.1793578311373;
        Sun, 01 Nov 2026 16:11:51 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fdb34sm1381803b3a.5.2026.11.01.16.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:11:50 -0800 (PST)
Date: Sun, 01 Nov 2026 17:05:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org, Knox Hutchinson <KnoxHutchinson@ProStaking.onmicrosoft.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC] bnxt_en: BCM57416 P4 AF_XDP zero-copy results and upstream direction
User-Agent: meli/0.9.0
References: <LV8PR16MB6422A76A84B5F2E45AE86702EB6B2@LV8PR16MB6422.namprd16.prod.outlook.com>
In-Reply-To: <LV8PR16MB6422A76A84B5F2E45AE86702EB6B2@LV8PR16MB6422.namprd16.prod.outlook.com>
Message-ID: <tnulvp.3bw49b6y59iob@gmail.com>
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
Content-Type: text/plain; charset="utf-8"

On Sun, 01 Nov 2026 16:33, Knox Hutchinson <KnoxHutchinson@ProStaking.onmicrosoft.com> wrote:
>Michael, Pavan, and netdev,
>
>At ProStaking, we have been testing AF_XDP zero-copy with 2 KiB UMEM frames on BCM57416 P4 hardware for Firedancer. We would like to contribute the work and get your guidance on the right upstream approach.

I just picked this up reading mailing list so I don't have any specific
background on the BCM* part.

But, we are looking at AF_XDP. Did you need to change anything on core
side or just driver changes?

>
>Our prototype derives from Broadcom’s out-of-tree bnxt_en 239.1.170.0 source, not current net-next. We tested PCI 14e4:16d8 revision 01, firmware 220.0.59.0/package 220.0.83.0, and Ubuntu kernel 6.8.0-138-generic. A separate Firedancer change publishes reserved FILL buffers before bind while preserving disjoint buffer ownership.

So first step from netdev side would be to get it working on the in-tree
driver and push an RFC or patches. Then we can review them.

>
>A one-hour Solana testnet voting run produced 361/361 caught-up observations, median slot lag 2 and maximum 6, with no increases in monitored driver drop/error counters.
>
>Later restarts exposed an ENOBUFS rejection in our candidate: the RX producer had advanced to 525 before a post-open check compared it with ring size 511. We corrected this by recording initial allocation success before packet processing starts, while retaining partial-fill rejection. Three corrected ordinary start/traffic/stop cycles passed.
>
>The measured hour used the earlier compile-time Firedancer opt-in. The later corrected candidate uses the default-off runtime option net.xdp.experimental_prebind_fill; we have not repeated the hour on that combination. Boot-image payload is verified, but persistent-voter reboot and exceptional firmware-reset/device-loss/DMA teardown remain unqualified.
>
>Source, patches, configurations, licensing and checkpoint-specific evidence:
>https://github.com/ProStaking/af-xdp/tree/627be0b7325501c8e24dce74f29746c42877ae88/bnxt-p4
>
>Which upstream direction would you recommend for this 2 KiB use case? We saw Björn Töpel’s October 2 page-pool memory-provider RFC mentioning bnxt with aligned 4 KiB chunks:
>https://lore.kernel.org/netdev/20261002190018.696925-1-bjorn@kernel.org/

Just port the code to upstream and push it RFC its easier to review.

>
>We would welcome guidance on coordination and P4 resource-lifetime requirements. Our target net-next comparison and pending-series review remain incomplete. Generally applicable fixes would need independent verification on that target, separate from feature enablement.

Does the p4 resource lifetime matter from kernel side? I would expect p4
updates are run through p4 compilers and then firmware is
flashed/restarted?

>
>Implementation, tests, review and this report used substantial AI assistance. This is an engineering-results/design RFC, not a merge-ready patch or production-support claim.

Can you provide a perf update I guess from above this improved
performance for some tests? Was it netperf based, some hardware setup? I
at least am not familiar with your test infra so understanding what was
tested and how it looks would help.

.John
