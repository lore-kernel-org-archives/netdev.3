Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD53AB26E
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788605891; cv=pass; b=VshpHKcYlNpT+kkYCqkJB0tS5SSGKDfZ1YFJ6Ry1keBSh5qZcsBYLWz8wyDzRTdOu0StmVBQAC8BfRYrYEzEB9H3kbekiy9w3H7qGdtVt576qLabJm+vJAHuI+3kPg4+DEjZHpU8xIUAnWv52euNhLk2sGbaNTDsanc/YyMaDGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788605891; c=relaxed/simple;
	bh=8/LRCf2d/Vb8yj1T6vOnmEEE07PqtOSZJGPqAQuSuiQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RaSmIaBaDiBdpfSv2Rk4WjTqn16HtoOvGvtZZ+79/7FADImgCeAjWNo4WOTxBY1Lyb6vV1+2RfAl1sM6TnPy1q9zPNU4aAik9I8C9q5SLODbZGrut5JcKmSVQjSosOXT+NyFK2NKoU8OKlepWduV8RxyZPWHWP203aGCHdGceAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HYWzlH6+; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HYWzlH6+"
Received: from fauth-c2-smtp.messagingengine.com (fauth-c2-smtp.messagingengine.com [204.75.18.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hcVfx2BCRz49Pyr;
	Sat, 05 Sep 2026 13:58:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788605881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGf3EGNvMC+tCJO1atmXj/XjW6IrJkfyCoTSb8aqIhk=;
	b=HYWzlH6+MHc6+3PGPG+9sJY3nAm0jfsXPo+47Wr4aJu8uY126/z0ciJQaOBC7LRjQukRTQ
	HJGRT/a6gwNG6fojm7wmTDAeBmzlzmym155FO8NxUwxZ/swya+yimzbDn15XVGRabaj+cm
	AFRMih8VEeJQGA7LJi1+V6+Eb+Q5kg8Hq0J0JH9974dG1GusdnwYm6aozg3vpG5J3CcypZ
	9MiJ9EmjuN6Zj+NStnKOUq87FW3Mw++X08IkBmxZJexsiceQqJ9rxyzzZhkChZx++vUZbP
	ipI6HRV1W8XL2DBSjvqe/Fyuz6/iHzptzo5SiWT7keIZiW4Op4uPtT+nhACSQg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788605881;
	b=ZjjDbWq9/7mr7iddIORnntABIxn3Ba9GS9H5n87fB7KdIWCSs4V9/uBhAfyHWWBW8QKRVt
	k+OMRz+FQDSOI0RZTzU5710COs/IFszyePVdYjFG6b3GQFAeN3GbWoVmf7RVkKEnd8BLu6
	6eFIgsCpaqhGNy5hz+1XuCSzf/yav7XNJwt5rjAwE4gneCeIacPja0FpWNnkZSP+DrZ6MY
	+nyirYmagYExWT+L6oWB6G7WBwWONg7DtCg1fg8L+WUCoKzEJNFHgtEexgNG6c3Qwf6NK7
	1LaB7AfXDpXp1NE78DuZDg1vVDuWEg6fTRIucMMBOlZNen02I9VOi1Djd+CJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788605881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGf3EGNvMC+tCJO1atmXj/XjW6IrJkfyCoTSb8aqIhk=;
	b=Vgrx63nIdoqc8zKWGi8crUmgkfcHrJEkSBWLWuENRoawLbmGilDyOGGpFIkrzkxs6d6+LF
	rWNmOE7NyKOo+hmXJtc7JzqsOBjGt5ajUNyH++/tlPBeIc6SBNe3l1RC9J26eD8s7rRm8v
	vQ+nqbgSE6HpRyutrwrqqJhB5TfIlK64YqvTzn/QaHp6Q5J5jsiCQ4D73/yeMSmNGtWiwL
	Kkg+vL1S85dPgUe2mn7IITx5ONVjPvWVXtQ7EbqKADMlDxDm1aSLu382UyHURlIVbKLY2o
	KHzqpYfYqNIQK0yzNv9WWJbUDOndBghN9rMQ1gnhMlhGs1lWP29Pn+QIKz67sQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 65FAD198005C;
	Sat,  5 Sep 2026 06:58:00 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Sat, 05 Sep 2026 06:58:00 -0400
X-ME-Sender: <xms:tfWbah5TQKB-Q050Xvn_LROh9Yc8w52AZAVvShIfr_av3nmO5oN5kg>
    <xme:tfWbapsrR4UUjK9IvN5y_dgOz889aeYtLr_YFn4YGhsqRhmXRO7zxj1Nf5GFKpqP_
    xqe1O0snu9rdOlg14bjmXZjcwYZ9N2oZO-_Cq00oJTe4rgSTBEhC5WF>
X-ME-Proxy-Cause: dmFkZTELQ3SQvWgUATuEy9cPGDpMSwyORhxHL5EyoGz4mQ0tjQ2VPPRI6D26AhuGC/0AlV
    PTPBEW281iUHFAgAuTVVxwrMqFHVCaSkNf6L9X9DVaqneok3ZOj4gmKcKzzSYV0zwsCQK4
    0N6ZNJAKd9220k8PgxwyxGgq+k4BSZ6tkjoq9r4I19hOpZH/YaX/bmNv968AAL1ZEazzQR
    +IJajjO7UQ8nxqioRXnLoRC1ZEK45qIefKf9Ip/e3CZi3nusUN+EDKAmXLAGl3lOfBjeBX
    wWBJvIvI0XW85xldtqP8CuySRyaOv3HcXLCl5cP2hscci3cpL2plESjUb7vzGPdYhPYFTx
    YsAKLuxNXqufHJVULMh+mZLF1XqVh5ZvkcCe9hyc/m2CJuuKsYeayV0nrKkgVnqgIKAE2P
    9LIgaoYcrpULe9pdHKC9pNJ9JkJzG/07we+ME8tFz5SGgTGM8RN8DzTK12BQtfe8QeNQIh
    PDCPJAozcP+QnALOm/FakGthLxFq1rUyMTWOwy4UIvcFwMvd6g+jn5hf7OSKRb1BjuFwiV
    MhN+yYtqJ7iTgUgzcAAFFugSVFwQlC9xJp6+2uS7pjvtwHClDtgGrez3iXEy/VyMdPEWWV
    JJuqURugfQ84mhYBud1YZgJ4y5jnkddqafsYjlGfZERcakTQoJkJTTrjnxNA
X-ME-Proxy: <xmx:uPWbarlFvTiNKzKyU7_YbABY3FgBrPbj1Ux2wT4SfLUvMT6iJCes7g>
    <xmx:uPWbatUjTckt8OLHq_AR6bJcvib65sm9Xmwm44VUhLG3w4hAognx1A>
    <xmx:uPWbaoe7YThptqpQ-GxxnXfsWnEQuVJM48SlgiuuDkPK8wttGFdCRw>
    <xmx:uPWbajlu8pOVaDvDHAstuMT1LiVTEVBiFhVkcesroMDA4sEluUTmlA>
    <xmx:uPWbaiBiy6eKwjQm9U55aZnbvOdluy1tzwAJ6qOwYbpnaQ1b8uSf0Hy7>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 997CFF80083; Sat,  5 Sep 2026 06:57:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWdxuz6OZDWw
Date: Sat, 05 Sep 2026 13:55:43 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "David Laight" <david.laight.linux@gmail.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, linux-arm-msm@vger.kernel.org,
 "Manivannan Sadhasivam" <mani@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Simon Horman" <horms@kernel.org>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Andy Gross" <agross@kernel.org>,
 "Mihai Moldovan" <ionic@ionic.de>, "Denis Kenzior" <denkenz@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <4531eba0-e44c-462d-8fcc-b189f6df1f31@app.fastmail.com>
In-Reply-To: <20260905110727.0ff502e4@pumpkin>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
 <20260901131934.225991-14-juha-matti.tilli@iki.fi>
 <20260904184038.5c1e673a@kernel.org>
 <0cc80b04-1bf0-419a-809c-e16be3f6a933@app.fastmail.com>
 <20260905110727.0ff502e4@pumpkin>
Subject: Re: [PATCH v6 13/15] net: qrtr: limit endpoint range to 16 bits on 32-bit
 machines
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Sep 5, 2026, at 13:07, David Laight wrote:
> On Sat, 05 Sep 2026 07:21:33 +0300
> "Juha-Matti Tilli" <juha-matti.tilli@iki.fi> wrote:
> > Indeed, I will later post a new version with UINT16_MAX replaced by
> > 65535.
> 
> Makes more sense anyway because it is an arbitrary bound (rather than
> ensuring the result will fit in 16 bits.
> Indeed, it might be better to use a different limit.

Well, on that I might disagree. As of this commit, the code will have to 
cram that into 16 bits on 32-bit platforms. Only the later commit will 
remove the restriction that lookups are limited to 32 bits total.

Node ids are 32-bit by definition, so 32+16=48 > 32, so u16 won't help.

Of course, there's the possibility that if the later commit is what we
want, that this will be squashed with the later commit.

I looked at most XA_LIMIT users and they seem to follow the policy that 
allocations are limited to usually 16, 31 or 32 bits. And I found
USHRT_MAX -- that's what I was looking for instead of UINT16_MAX.

So I still think that "limited by kernel memory" is the best here. While 
I can't envision a system with more than 65534 QRTR endpoints, I'm still
uncomfortable with setting the limit to a low value.

So, the next patchset will have USHRT_MAX. Soon my patchset of actually
having multiple ath11k/ath12k is ready for review so I'll post that too.
It fixes the memory leak in Mihai's original set.

BR, Juha-Matti
