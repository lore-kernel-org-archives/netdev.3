Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792000;
	b=EfDyMR7tTvoO94eqrXk40GApMfhrSZR51YHcg5PV4eZzM1s/pSJrcfiT3GQqdMHdI+0j
	 IQIGPzLDYKh4wRuiivDP7A8U0lr6K94zL/1fca/QCkYGZlHHwnHaGt0wxa0wyWCrq1ayw
	 x7x2K7B/AquRqEU0tS5iieJmQV3xq3r1TrX4TrBzwajsC/icpBq5UWWPujOIJdojLpC4b
	 Qcf/WROd9HIYBHXL1+1yjuLMZqX9FiuWAp58ls15xgM15rHKfFrTZyVnxyCgO6ClVF0je
	 ibdx6WOK7TK4Fc6PgV9HZKgFX7l1FOTI66zt7aMiUfSelmdTShBUihiJ8keHkNdgNtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8rhGEQa9xaIZEf6U7gJZbtVGjC0KSaXMvun2v2qd0Z4=;
	b=3GmB5Lt2VmjNAxIosxSY9m84aQsDpkCbMUITneOIR/G3CqPDbA0QjmlpRiX0Pp47PftN
	 t7fECEyMUkW/bWJEonlll8UIhi6RLbhhbYMPAyIwhSiBQIN1A3zm0WadX4yHPwT9+/M0l
	 hzj1EwXwoKhWwtI/DBQg4TzMBZX/amdsNb5P6n9koNC6k/u1W8LBSrr3YAafV6MvHB1mN
	 MsDPqNa/ZdsYYh1Ilkvj0xfPR+X9eAvvDkz7q9FXRl2zO26sbu9m6fwF7MG+c2N7NtoVm
	 RMS2UFmLVeTOmukTOjnbRbEfW2k++KRnt8jSeAAshWJ05xZdvX+1KYPpESRnz+5ZnhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KOlkAnkN;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E5606A338
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76E5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KOlkAnkN
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dee593f18so441330f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793791998; x=1794396798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rhGEQa9xaIZEf6U7gJZbtVGjC0KSaXMvun2v2qd0Z4=;
        b=KOlkAnkNigdTdThArflofqaZ8p/tKVPp2LZ/kM0Fsp/1xAKmB5HskiZAv8U4QyQ5v5
         iBJVVBpg1XFGQt5xmq3Z6pFRH1vdTOKjWpKwQuHy+iHR49B1omBV76XDiqDX+wEo7r/4
         a4cO0CW5rufsg2iLob9B9MUQwqkCs4/a4VQIZgFIrSWJ2T2NsHglYFzcmRSRAnJeayjp
         irp9pE9EO8ZEpleRQC2hdCdfk1wFgBlll5ZbicT6+1bCH1bJsoLmPDaHLAZtC3ETMUK+
         6Vljf+yIwa6pVQptxbtoSGMqLrUyetjFlNH4nCYrMOPIitprJbxvRNH92uGnNwrEmHzi
         GylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793791998; x=1794396798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rhGEQa9xaIZEf6U7gJZbtVGjC0KSaXMvun2v2qd0Z4=;
        b=i3O+nFZW5nuB4xi58N8LTWrlwCspCCW5Wu3UsWSKhZOC1rpdxDN3a+SQSG8v5SiN3j
         oIrF+rN2KubWoqBZTG+rWEK+2MzfroBmxNu63UOlcSckKFzJDMZtQp4BNH2v+xnHzLet
         /CFO4uqF9J91Gy/uvp+nMBHcGRPnm1xmL1RMO5CeKpNz2P6JQL88nmxFzLXCW1i0Y2EO
         8vTvuquxef8zRG4YHtOtHNAzDWJ3N6edfoDKjLArtqo5Wq8Wci+Tt4lm8gz8e1zWf+is
         /SsJ+SqED7Y18Uo67a6Jk2/5GjNcNYyzUzsuW5nLINeWSvMXjIq/K/ZUKkEBFtMuG1dQ
         mWcg==
X-Gm-Message-State: APuU4Z+ww0MgJenPZMRYV/OJFNzDXflPUt+evdZisnZQ+yFa7PaDWAwa
	l6/R6eNZshbdXCqCctMt7tceoenAgpn/wbltalmck4GaIWCo2zy5qfPC
X-Gm-Gg: AYBFou22SwomSNGloFZH2c7zbQ7nwgViE13EJpeSx4EUGfp78zJsvPYnMEy6KBPCmMH
	JAFKYbpnh0bkooWp3pCJ+j6yqdd4UkghxeN/n7Ktz1o3es8d8V03Gjz2U+a47VsvzNN4vfhTO3p
	gYEKTylfGoYSFoONVwuAH3vgtDdB6ivk4zG4KojIJfzvadSj2lucP9M0X8fTDIveJR2eDwDXVsb
	0+BjPQtDVBNeHjJnWb4Ua01Vv2ldhGpDXbPj5A+7or3YNJ+j1K7htq+TzE3BMca8K8eJYxJSG5T
	Lmd+wP0gw55nRUI4f30fdMrq82saznDPyzmVGaBTq8NHM2R+U9yqoGcSMYfBnsJ9YK+VCeCvcYr
	4fnFpCJEH6iBz1AwMxa4ijXe81u1vbDu5c2VFEWY4Ri0XDM9ouaISoKXDbSOvGE4IzgkYroZngw
	buZSuVYld6Ddr6HrteJo9KWde6P8i92Uqsbu8FuvLVQA+vpHo5q4gaGVWZaY+WTRtgHEY/fXLsS
	5S4L5KD8sZYJngKU457zCu9r0ZeH0Yju/j9EJTMrHuyQPwXJF2GA2Xu8R+JYL8L8PbiZ+u4+bPe
	asG8pHrFhT/NtCzqmZSyvN4dpv0rKaVHviqix2gc/JPoWCtoqV1M5UVo8IFIPvHCXQ+ek9YlscU
	lg9fLJTDoo3+J1XA2b+y7HgNq3izoF8IP0/HTcauZKvvzOqIPRPA3cIQgLbHyMtQ6JlwxyMnhsm
	Te85tHLJn9pVUu4d9IBRT1aQav36U7fkzxIXoeyXPSHx15t7o31SRf2AY=
X-Received: by 2002:a05:6000:4559:b0:48e:752b:9f90 with SMTP id ffacd0b85a97d-48e752ba019mr21401003f8f.38.1793791997784;
        Wed, 04 Nov 2026 03:33:17 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-d09e-6586-7547-87ae.ipv6.o2.cz. [2a00:1028:8388:a84e:d09e:6586:7547:87ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feea5d4e4sm3319889f8f.57.2026.11.04.03.33.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 03:33:17 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/5] net: mvneta: fix the TX queue arbitration and the mqprio offload
Date: Wed,  4 Nov 2026 12:33:10 +0100
Message-ID: <20261104113310.90408-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <862976ab-e80e-4d6b-9657-ad9bba2d020b@bootlin.com>
References: <20261103125021.70845-1-pepe.schlehofer@gmail.com> <862976ab-e80e-4d6b-9657-ad9bba2d020b@bootlin.com>
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

Hi Maxime,

On 11/3/26 19:56, Maxime Chevallier wrote:
> Wouldn't this break mqprio offload ? It's no longer priorising then ?
>
> That behaviour of the high-prio queue potentially starving the other
> is likely what mqprio users actually need, so maybe we need to setup
> prio-based queue selection when adding an mqprio qdisc, and switch back
> to WRR when its removed ?

You're right, it does. In v3 I switch the queues back to fixed priority
while an mqprio offload is set up, and to WRR when it is removed, as
you suggest.

I tested it on the Omnia. With the offload, the higher traffic class
still takes the whole link (94 vs 0.2 Mbit/s). Without it, the busy
queues share the link equally.

For patch 2 I added one thing to the commit message: if taprio replaces
the offload under a new handle, it ends up without traffic classes and
sends nothing, like after a software mqprio. The code is the same, so I
kept your Reviewed-by. Hope that's OK.

I'd like to send v3 later today. Thanks for the reviews!

Josef

pw-bot: cr
