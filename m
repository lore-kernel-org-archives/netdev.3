Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118799;
	b=BaQfWeIJC31QBf68hvjyrKKDidpuLz4l5ebI/oyo7h1tF0uvSf3tGgeP23fj5znclA3a
	 du5qfguqO43GT3s+uz4S8PxqMvAX56DBPM74SzhM4gsfV1vlIvXBl3hT1NqpIKBhlg7KE
	 f0A5ITUH/+EBpVL1DsCQa8yNe/IMe5S7Ma+qLYVOVKiIG9Y2a7jaSjHrlC5o3If2Rb7nX
	 VNP20Dm5KGKRLjLqxa6kAuJl+09aytcw1/aaL8qCcE3D6VHLX20u1W+HK0Cjziui8r2DW
	 x7j/Ty81n8KcnfGK/pwQGkHTY8F/y1F8MR1EPZJ26uecojmN2lMozJpEcWpOzs8kvtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I0iNj3mQ8BtY35+vPtf2TGLh4aOWNpD/xEhhJMSPSv4=;
	b=t3g4V5KD1jF6MoIPCcDKcQTJ/l9ZoMsSLcOA30LTP0zmQzxBa1bpnku5LnzntNsadymR
	 fb1miTsky00W43BF7Xl+RAiHwLTNxDzE2d2RMwEw4Ng6OR+r4PWtAVhoZF2lsz0iwkbXy
	 V0aG7ShgEyR4JfxETOuN4ebHUm+VwiPHyT5L/TerUCsp1sMpjcV573l7qyTrZSnRfr2Ux
	 vCHjPVlB48UYPSohu++MrMgZJNmHy5BoHB0ySrlNkZ1KrMyyR8Z2DsJWKN6/chAmhBG8T
	 0JYV9W1SjhVMvtu9mauKF6aMVeHgkjxpjn7h+nH81FnTaVEnraIMu6FJ84MpprOaCWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XEdAllwd;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB291606A321
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 16:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB291606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XEdAllwd
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c37b612635bso587844466b.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793118797; x=1793723597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I0iNj3mQ8BtY35+vPtf2TGLh4aOWNpD/xEhhJMSPSv4=;
        b=XEdAllwdCkqIgxXu+9bXEkBIi36DzRQwxWRhKQlVdC1xvJN70dwZhU5b18swGOpJj2
         u9raY4q6DL49OdQYfYyO6HehetZT8xrXylxcIQMVXsrGgalnp5RQkHWtq2y/RKPZ1gCT
         GLWye7RpdC5QoTtoU3/XYkaAfnOB3Bbn8RlTN7RhqYoCHB+4ZSSumkvf3bXfb5vkYTvK
         bzCmgsBHCvG9Ghj1JTeuxRpqeRdi0E4AHgiPk7UeyBA4D8Wr01cozDHBPVIzr1epXCI4
         IVEscegJO1EAvD0GX6MvChjumpmJCw6fH4pIQ6iTdu+iWVpXZLyTKoYey+dzynAYI6xe
         EJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118797; x=1793723597;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0iNj3mQ8BtY35+vPtf2TGLh4aOWNpD/xEhhJMSPSv4=;
        b=L5WX80Nbzy4qrkPENKe2+Dq+I+oq6oZ3LylXPvYH3JlQ0ZKT/DJOGOJw94LmREPKcR
         DZI58G/rL5AEuuev0joo+FCO/Lc77U/ZpLIYuoler/yRnm/KBIZUrgICBdGOHP1VdSnp
         ewgyNPDqb9MRmqMzWr+xzVJSQr/ryoFAME60n40gKsv0IPDv012jJFY5RucXwjjqrpao
         VaJMZm8TttKErYwYwC57Z/8WiRPKKauIBcz+vXCTOfbCR6ieFa3H332n+E2mg7Wk6lFL
         EMjjOEl99l22BwpGFWn9t7ZWMFFr+FJrnBuShUpgahFPz32S8JYgqFMXk/nHZhiehEb+
         Nlmg==
X-Forwarded-Encrypted: i=1; AKwUvBw6kysDiYYOPxyHJlx4OddqKVCGBlhCAdYa2eTiBRN0rfgFSm1fvsrrOvf+wwRScTuFHu+Jr/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX1mFJuv5dl6a0SBl7zl1UvouBPv150PO5az7ujYFhRuThMpo/
	MWi9aJR3+CuMsVVlbwZTJY6vvDDByJLY5Ojmd+nU+2kERh6tmnTgYb5q3Nt4oKbw1zj6JRXDOQD
	zdcO+07g=
X-Gm-Gg: AYBFou1q5TJnoPbA/pSv01Vsg/wP9+3aTbgJ9gSwQu14J2CAAFdoi+ZPRTu3eujHn0w
	pOTWJUYE8Io3IRgYk8IsKW6pd1TEC3gQAdjP7d/EA+jTYUHq9Plk5+Tox7+/bA0/kd/2Lxvtfq7
	jbxFUD5LFwOzU1nPVj3m1aLnus2I0Xs/Hxs3djqXbEcsGIXd7MJmYik0vFavtkvcIgqO4vIQZ9C
	wd7IGSV2iV+SHur649UEFSUjJgeVO+z6Vy6a8GXTUCcKfBmm512OxYMh+jGNO8RIcza4XI2Ldoy
	zJKG+j11jtTy/IkjSctx5yLHd7c8MglisFpheNuuIR3K+ySTbUKG+hqb4fsIbJjJV0Lv63ohB/K
	GmIkr3AeZhO2thxzy82x0BqCl3YYlDnlwIBAyo3cedC2cwaomzNPdqignO8oZBL0X8jXknxFkeJ
	e92UazKHx2EAsvcb4XF7XDO92ukSfIFmVVc9EG0ujsQxV1fUoXCyFDDziDq4oSJQ+xSv/aPwZPv
	CLhTb3MwKIRmUHQUVzRsjIel/yb3KZpxG3xgN4ITf4H1qnFhe0OmT8v3uMzXbDpkpA+Zf9oVvAC
	oTYEfEoWbgfT1asdhu43CdAH+Y8fjqpFa5W0OsWU
X-Received: by 2002:a17:906:7314:b0:c42:102f:15e8 with SMTP id a640c23a62f3a-c46bdd68f4emr1061585666b.14.1793118797178;
        Tue, 27 Oct 2026 09:33:17 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:1e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd79b884sm481105066b.75.2026.10.27.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:33:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: phx <phx0fer@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  John Fastabend
 <john.fastabend@gmail.com>,  Jiayuan Chen <jiayuan.chen@linux.dev>,
  Network Development <netdev@vger.kernel.org>,  bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
	(phx's message of "Tue, 27 Oct 2026 13:10:52 +0800")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	<87v76o63qv.fsf@cloudflare.com>
	<CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 27 Oct 2026 17:33:15 +0100
Message-ID: <87pkwv5cj8.fsf@cloudflare.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
> Sorry for the long silence =E2=80=94 my laptop died right after v2 and to=
ok the
> local mail and the working tree with it. Agreed that the ordering fix is
> the right one; please go ahead with the commandeer, Jakub.
>
> I do still have the reproducer (a KCSAN selftest for this race, verified
> in QEMU). Say the word and I will post it, or send it to you to fold into
> your respin.

Feel free to iterate on the patch once you get your dev env restored.

We would also need selftest coverage for the race, if it reproduces
relatively fast. You can take a look at test_race_insert_listen for an
example.

