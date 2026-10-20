Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792535284;
	b=3XFklc7VeBhElMyZ242uYv+fJUJ+mOYaau0PNKelwxbjhwcAVHQYqard2FN/Yrd1O894
	 xdic/X4F39BwYsX/SFlLHPaQ87DHsvYTGIIedqc8okNTEVdlvSKvGhKhpUx7vThStOpQu
	 wX+M3XqrBUHIoBWkIUilzaSMMG5C75VK8JLmAjEulJKggweYE9APKRgTILKk6/Mw6M8bR
	 2sWTMA7XCTRl2eMc6JUb5mrckkI2fR4hEADN1VW1ma1bthnhja+9ZPgdNF9hAD5jmxy9u
	 XIeaAZgnLhA4dqW9zurWyxVCHDw93d3/UnHUSjIarhgNyGm8ls6yFa5T/hBlcINNVTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
	b=g5/gt/pazVZlVlchCnA97OEx00UZobfn/w2/VfQ9CusyK4VQQrUpriwaMLUdaZj3zflm
	 LbrFk1W70y7qwFPBiOVAToXvG1O+mhwzKtMp7Uc4Q2FOyq6Fw48GQuG/ih1+BXUT1TifF
	 jeWMmhQQ31/WlHTMKb2E8xBH3kQ3TZ4TDnYW1wuP1apJJVdN+CXjEKTaVYK46zzE8JZAP
	 9K6yBjf5U44wGQ79LhSp7Rw59GFyATdoO8Or+cb8/CEHBVp9ccZimh6MhHSJ62P1lAtrb
	 XHlAgsQDhwLDodiMT3Hud/1wIRTR6zrVrZGQICerUzMS2myatw3N59sv5V8JBh9gM0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rmfEpk+f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D3606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1D3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rmfEpk+f
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2258a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792535283; cv=none;
        d=google.com; s=arc-20260327;
        b=ddBKJz50O81wW9H8CPiucFpusXZUis3++TmdPbZVIvcNbQ7+Ida6qquYyUjdraq1eY
         gNe0Ntsa7TzGtiNYeJi+pcSsud704ZQMw0Z9vsodO4yi1YO2icTJXux0Gd8z+743OXqd
         YKE2GiDVUJFc20/wYFTTiuCvujAKykDZx4iTkf5hz4P6+YVJ2A+DE+vOwvhAIRATPcx3
         pHWer4dt7bOf1mETa2Yfq82REVfr1IDOgm39J96elkw6356CRvUZdsNRyoLSSh71U1cS
         7Jn7uakxEDsvMcTa2brnbug7o4fAeDqoKZ0xjoxoB4wHRvLTbK9SPVoVsS/XHSbMZzL1
         19jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
        fh=a+2blElt4Ng83Xe7yAp6laeaEUodRGodqHM/drYT8fg=;
        b=sn9jv1j7EsZIfjwSbGMJdAn0QQa8an9KWmKGY4HGVPdn3kWKxit3hVQQrUg9GZC7E3
         o3AQcaPhEe3r+cKBJW21CMafslbojTUrxVux0UT+OLZ9tYRNWhMAHm5JT981LyDpvsNl
         LI0+eS06HNoLuajD2qhNo3dO0eUKxrwpGmlCHU37Cs+0M93e0t2Y+qnQ/GRoi6+rvEPb
         +ky0nMzbSeSJPLxK31HxJcwY73vuQIEtPe4L3bnevR3ROj4y7RmC0So3NnkGTFsJoDrY
         P/i2l4zVYNm3YjiAyMnggzoMD4tdRPog0GCkqnNI8c3Rf04QQoxLJgrXJsnJBSUAvAs9
         IJpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792535283; x=1793140083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
        b=rmfEpk+fCkZv/kL89pFPui7fFmGk1n8reU/QsXYE74PD0EFucUW0hMf+IS4aStL0Q8
         nG8UsAS92tQv9D9ZQHsaoESspRJ/Zb/tLj8EXkHtFpS/b+Yv1XiiogGOoQF3SNlGVDbi
         VjAnWBFpIEg3G+6ql6HnSMNEeatAVsqUGblKkp4VLsG3Vl5mPo6Qjfzp7VqRcZCtcixG
         ZID0xGN14VQRGASeikykGdy6GBWJ9A0V6AFkxpNoT6/e09Wv+fXGPPohwmNppGmv7pGS
         v5JICbY+ElGsHORRCVuJuVcDfeCBoIeo53TU2c1aTQ4ePKBBopr0CzBIg003ZmACaLP1
         mCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535283; x=1793140083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
        b=WNcNT60V5ySe8GGtntd1nq9dinsFwlTkkYvydsfpg6W0mybpsTO1zEjPHiUpwvao+A
         P12zsRjyooWDUVWHDuGBxU/TtbmYM73K9y1XzRBven7ON1kRR4xDdv9r2lo1F8on7mVf
         uJ8mDrKYsHwjNs15oj8E/VlAvjahaugnrox+RLm7+43dtVhpi33a2r1NYgApM2t+O2li
         SUtjlGiLm36an/yo2LUgEoqCW4IPmB1zgoratys6x3u9qia/Cw4Z2XWPiVBe3B0r9E8S
         cxZvwUc0TWOsyvfRAI3QDClYFL+qFoqdXvi3KWvqjfJHyKFSlJvHm9/4JRMV54vnNa5j
         CO+g==
X-Forwarded-Encrypted: i=1; AKwUvBwtHOjvqVmxiU+3+QdpZJlndaI8Hb7T7XV6kZ3JQZ82xVH93jWSXHn5Ha6KXWpRMj5/j8rQpQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwuypofHQ5f1g4ccNeIwTKkZgPbq9r3ICLbb5rGuopyAPbrHQA
	MpZEDKNGCCne9mHzeHvbMx+Vcc9WjffgAADy2cX6WBOuOQGLfQUQXRLE9LCU5npgSsB//j4uYhD
	UqZ6nvRYAXlSLFp5mHppKInn51sSI8ev5u9K6ONHa
X-Gm-Gg: AYBFou11mtMzSE/SzZj6GIVQ3rTaOR/InyauZT68vPGvdikQrAkFtnFF1Oz1tvqXPMN
	Ihlu5+2YeuakgeWfpNVR8dbQHMO+s31rqBqIkJo3xiyCWxY6h1CVEQ+kvXGyQikjtQ+Td26xPWJ
	xdZqIEZqcJks1Kax9k+lC4YvpXiTJ7F92ZCECrFozkQ5bD1YuEjNfo2qWKFCjEPbngBuVEYvevw
	w8weNzwWS8ptmg+o2syCT3N4uKZwCfBYnlpPtjJcy54QnB0zIj8dqCaZSzEEDt53cD+bEVW+5Zd
	zTJAmI9UMpmsQS4v1h4/I9a3vsct1FOxPCCoEcIoyB7YkmSQmL5RCA2+hBhjQg0=
X-Received: by 2002:a05:6402:a593:10b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b3e59e5999mr93600a12.4.1792535282334; Tue, 20 Oct 2026
 15:28:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014173945.373295-1-almasrymina@google.com>
 <179249101026.3632927.6502845375265155678.git-patchwork-notify@kernel.org>
 <CAHS8izMRSU3AyVf+sP5uXShiSKuLumZwT=fsgW+bhJz47UoPRQ@mail.gmail.com>
 <20261020150307.258b00e9@kernel.org> <CAHS8izPZ18v_1CnRkaAAA=d94wutJhoOZdOFO_1CEXSexd_=EQ@mail.gmail.com>
 <20261020151352.794bf03b@kernel.org>
In-Reply-To: <20261020151352.794bf03b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 15:27:50 -0700
X-Gm-Features: AclHuK9dUEuy9FSTZ5UcXIu_nwM1X5COPAnL8H94zeKVggsnQ3YuXniy9SKSJgk
Message-ID: <CAHS8izPOqgG-LffZtN8rmuEt0dS1YZOmWALM9Le8F+rLbVA-sA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] net: unify symmetric netmem and page_pool refcounting
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 15:10:03 -0700 Mina Almasry wrote:
> > > You should have followed more modern naming patterns tho
> > > get_netmem() is pretty bad IMO. PP naming is object_action()
> > > so netmem_ref() or netmem_inc_ref() would be better, no?
> >
> > Ah, I didn't know about the modern naming. I made get_netmem mirror
> > get_page. I now notice it's folio_get not get_folio. I can follow up
> > with a cleanup when net-next reopens. I assume that will not be a lot
> > of code churn. I was also going to try to look into deleting and
> > consolidating some of the now-redundant ref-ing functions anyway.
>
> If you do it soon I think we can try to squeeze it into this merge
> window to avoid unnecessary burden for backports.
>

Let me try to get it on net-next in the next hour or 2.

> > I can also make it one of the design pricnciple in the page_pool docs
> > so that the LLMs pick up good naming practices moving forward.
>
> I don't think it's needed. I mean, if at all we should perhaps
> think about naming guidelines for all of netdev, but no time for that
> right now..

Yep, honestly, maybe even just general guidelines in an even more
global place like linux/agents. One thing that has been working well
for me is coding rules or designs in Markdown; agents inevitably pick
them up and try to code in accordance with these rules. Just spit
balling ideas, nothing concrete right now.

--
Thanks,
Mina
