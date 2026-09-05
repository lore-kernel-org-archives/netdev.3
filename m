Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66D284B4F;
	Sat,  5 Sep 2026 04:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788582135; cv=pass; b=P4loAe1iyOJid2L94eJ4+94F/2gScvgCw1bVDmya2BkWhopYIDBzMzYcX2qKJqR1RHfgBEqoxtJSA4LB9WhFBM9DoSNXRNR2XiL7GwmoE8hFz64DPBY6CCYt1Ul0dME/1LC1quC+Rr8I1xkrwv5bef20JDdxHwVwW1tNw/KSLRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788582135; c=relaxed/simple;
	bh=g+C84RLk8fAVr0FAD/3eGHy3iHfn5lM+pPwezj8cgeA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uw8wBE8kKFhkMvhrxRILKZzYRMPW9QYI4dAO+bqNmu6BIhgVvillk7mz5O+AN4+lXT+rgLeJMB8xJawncH204I3ll7PlOGHDEfGsOHy60fyVm3jEhOnSCEoKMEOc8e3htrWC+OnmjJe6BWnHwO0CzvpzSHZXshF0xzFQwbXrnMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Uk56HlTR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Uk56HlTR"
Received: from fauth-c2-smtp.messagingengine.com (fauth-c2-smtp.messagingengine.com [204.75.18.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hcKsy6DGMzyQZ;
	Sat, 05 Sep 2026 07:21:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788582119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3uwQYhWWHu/wXddzFOmjJgjqHenok1Flg+cIe9gNoc=;
	b=Uk56HlTR8wK4D/lDls4bECAlHpHe4D4OOJ60ZOCTkRpFQDQE4cjAsVPfzJTxfELbijSCkV
	Jc7DGmcOG5YJ3wXA3Z04LmJyjSr02xTZTRrW8HSD40i46y+4zquoEIQQY9Mii2hcgHnHQH
	WucWLp0ghwq/9xgLBrCl4l+F4EvTu1o=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788582119;
	b=O5LqXldh02WrDNdfZgndC0C6JHuuKruhZeff8oi1zV6C6WJqBbT5Y/QQZZF3BMTalZSxSU
	OzzppoLdgPhHOCwBcplwryrGPatg4rTpRmgcyYr5UB1uhgIyEMZf+uOGgzY82iW4LNuA+M
	K+EhG3cHqDgOoOL4SIgnYVEu/Eg147A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788582119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3uwQYhWWHu/wXddzFOmjJgjqHenok1Flg+cIe9gNoc=;
	b=w3s1/sWdjdtlBp90blsBaKov32/HyC9Y9L0VBpL98ZVA92t4/BOkf9/zcpOwysYc5ilOQr
	A+7WVzNSiqpRRrbDbThWiuGwENUs0CE5dtzOrVlkb3Lseh/1iR1RygTH2BFFx4IZRAU6pM
	prLnue942Zf2aKwuaiCkm2Lh+VZdKQY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id D1776198006E;
	Sat,  5 Sep 2026 00:21:57 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Sat, 05 Sep 2026 00:21:57 -0400
X-ME-Sender: <xms:45ibaoQddBuqZTXNYUhi583YWnz41jhPsvLFN43v87NQ8PJJuiCs5A>
    <xme:45ibagn9M4yGmu-Uid_tbN8Gs6-0iO9-rNyZc4awMlkV24KGV_RFffHAM86OmUPy8
    4wqlNt5nbF4mTIdDxOE0CCwr9vDooUHevCqCd1lPL2khODTxk4q3_M>
X-ME-Proxy-Cause: dmFkZTGoFIH3WITUQMH9wWS9ETTwWD3+gSemNpKRVvzkQC1ebGQhg56hbbZ58t6gSLllbl
    GjkRcBKvgO9sIYW5ScfUiR2nqTwRuOOAdTOyPlNDAuAj9CNoyoI+5tQ5rmyOcWm8D1oUi+
    QTD6fp4jKtwuuiCXywcTKguAh/YuhPSw4ax/bqSY8msvgSyR7EA4nUxPUTX9SO4GpbDwBa
    e8b4mAWVFrPxtgaR2BSoUYmW4me53zgAaruWmBkkWiWXE1FrzvNc/s8Bdlb46FRg2hF/65
    bEtTWZiBnnkjfwglSeCsNJpe7oa0tTXW55ePRzJMsxrgHiJJIrIfPk89Ro1fE1KdCsXNgA
    UR/PSBXJe/mrkw1ZOBOS8He1J0AkpB3cNE/OCifxSFwR47/pm/EbS+JXJNgZb8HmVjzgdC
    93UjIsoVvzFO0giv7jL4kXm9WQZEd46sUpZAKu8SQt9h3Jfge4UyyTFR/XoKmorKx9thys
    TFvSlQdVMTQL4Djf5VZy79F46jvk4lwbtvqJUaR9/+elbQqHA8c9jj1idTnZosp67r1J4a
    2YDZi+RQmQUf3Vo27tX1ykU5wOMLtjSnOPiGUz3JB3QL8GmYwxeiVlajfxw2YcCm2rTT2W
    hxOvtb1OKizLEX7vFJ/DpVMq/WtwOedW1x4GMKTMbTFbDTYet/bwE0cnONog
X-ME-Proxy: <xmx:5ZibasWXBqGcIYiBvStlhat0eJCRMFo16Xo74UBxP_QsVx0PAmNOvw>
    <xmx:5ZibahAQcG-4Zr9jn6be9XPJMZO5oPb-0s5AxF2zEnkw6kPp1Hiqfg>
    <xmx:5ZibagKnyDCO02nGwGWTJIyhXdUGNnc1_K8tVr8tMV_9jHAw26fUsg>
    <xmx:5Zibanu35BPNaZurdNGMvOJmMWrnnVWNe5fAqcdJDUCET8u3GLLHkw>
    <xmx:5ZibagWsSd_VLD63S3qMWc0u2I8gd24ZR5pAXnOzkLvXoGhMomDb9GKw>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 27CC2F80082; Sat,  5 Sep 2026 00:21:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWdxuz6OZDWw
Date: Sat, 05 Sep 2026 07:21:33 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, "Manivannan Sadhasivam" <mani@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Simon Horman" <horms@kernel.org>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Andy Gross" <agross@kernel.org>,
 "Mihai Moldovan" <ionic@ionic.de>, "Denis Kenzior" <denkenz@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <0cc80b04-1bf0-419a-809c-e16be3f6a933@app.fastmail.com>
In-Reply-To: <20260904184038.5c1e673a@kernel.org>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
 <20260901131934.225991-14-juha-matti.tilli@iki.fi>
 <20260904184038.5c1e673a@kernel.org>
Subject: Re: [PATCH v6 13/15] net: qrtr: limit endpoint range to 16 bits on 32-bit
 machines
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Sep 5, 2026, at 04:40, Jakub Kicinski wrote:
> On Tue,  1 Sep 2026 16:19:32 +0300 Juha-Matti Tilli wrote:
> > On 64-bit machines, use the full range for endpoint ids, but on 32-b=
it
> > machines, use only 16 bits. This gives plenty of endpoints, 65534 to
> > be specific, apart from the invalid zero value and the local endpoin=
t.
> >=20
> > [snip]
>=20
> Doesn't build on 32bit x86:
>=20
> ../net/qrtr/af_qrtr.c: In function =E2=80=98qrtr_endpoint_register=E2=80=
=99:
> ../net/qrtr/af_qrtr.c:28:58: error: =E2=80=98UINT16_MAX=E2=80=99 undec=
lared (first use in this function)
>    28 | #define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, UINT1=
6_MAX)
> [snip]

Indeed, I will later post a new version with UINT16_MAX replaced by
65535.

I thought I was careful testing these, but now I recall that the
individual patches were test-compiled on 64-bit and only the branch
head with all patches was tested on 32-bit.

Thanks for noticing!

BR, Juha-Matti
