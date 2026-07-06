Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CD2BDC2F
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365404; cv=none; b=LnDXLE3blgq0/kU1A+XmfBHLYrZrJydqjLy9bF7oPIWFzdOGFgS+vUhTsOI5jVDpr7rnHrV1UFUjwFJHmmtu/WHi5bwApu4o8ByT38ObfEbqBzDUfGkO4YG3zS/mRZ1LEjZU0J/7cbREERRH8eRtlMtRebhUBGtd9IA4EqIYf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365404; c=relaxed/simple;
	bh=A+Sr2VynmXdoTXKZwHbUOadCumXVatA01FJJ3sCZ6x0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QDBjtqtvjNlTwUkEEwjhUi+ZVYEZ2zMi6QzRY0824/3CDsDPEzjmGbWD8tkfncEEJBuAG0kH0JaYBYx+3EmffPtPAc7+nrxcSrDnOKfw+Qf1mPmIEm48p95BFZa5zH3UnyL61Xz6IPlOrOo9yULShXUGdKsbHkBA+XPwFwfPOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la8yTxww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la8yTxww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AFD1F00A3A;
	Mon,  6 Jul 2026 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783365403;
	bh=XuI53TKgeRFxh3+8Kup+/6jQDMPPLdn6lqAtSfTOSII=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=la8yTxwwt+BV1f6ZBCB0HgXbAjYn8iWQks9707NTQB6K8WVdQU7TVPohmLxZywL/3
	 1WH7lGV+9qB563iXWiz7tNjwQla0jxfJ2YCTBcZ1pUSaJueDjJsTwnSZHNR2qr8qkS
	 jQbMA/9XYX+8e57ZWK+HTQpVdJXEIhYlQVA9XeR8riHUGFByuWI+7ef31aij4gBDsz
	 uxCrZSt/auDOtZhknzEPbPut/n3GkCCwAL0V2ZruMWfsYqj+KK50klVNUraTZF8E3S
	 II2aS48Q0kpCQTnvYlBuKDayE8Llyng3UfrX6ZlW+NVCXlMsrxKTvFO4DmfTdNRv1a
	 5Ligtels5OrmQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8BA4AF4006A;
	Mon,  6 Jul 2026 15:16:41 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 06 Jul 2026 15:16:41 -0400
X-ME-Sender: <xms:Gf9LanZlMOgbC8DN9KJmgua7uY3zANLPFnP2fc3OuBfVWJQ7CuR91Q>
    <xme:Gf9LahMLGhDc08IFswe2YV1oz-Ixc_3JUXSlOFjjWBZNL7bAWwx7_mDX7em_2Cwik
    vIT-vpCOZfmcPC1dl6xB_kULbsl2lOlMri1HPPFxDRvZ82hLWhVehY>
X-ME-Proxy-Cause: dmFkZTELdIGXvKeHFyBM08bJ5pFSQvjjd5Ldr5RAefSlY32C0PAI+cB4CtkREBHFR2BXtM
    bcOJGPZGeqR43S18Fme5V1nl/P4nzlJJcmJauvo1cS1YOmEJgBayCFUNcuFfLcyBNV3nsZ
    ixa1BcEuPdLpDiUNqHX6LZm6Me/Ui+Fi6x+cP4AOMQgYdbbm/Sl9g5TqwF3E936tlZN4Wy
    yiVbB/T+pDNQP8OI88lR9Zn8TZaeJHOogwxRtm8JeE4ZuznI+4EcRXlEtqgUOHCC0zyXby
    MnUncEJLX4DVtl7jLJQqMNRWaHPcJKV2PzdzObYXSL9uCqT5FKnJ3Ym9oocl8lkAFvgud2
    5PmTrH2O1tMf6wLSMljC1GUZgCVji6LJxslNhvC4Kv5oheyfUetz3pngHjb6sq8mgyckZA
    CLnzUx5qP5kMU7mvDDGjVdw9+WDu/GpU7o/Mvp5B6Y62JC/LM/lY/txmGlH8F/gh5Xffp4
    ZDV8oJFAuNsfWiz3VaP7AjsWD98BLe5BZTxofuTc8joE0jPpD7d5eVX0HYBQO2q4FSNYjS
    jvg3xaUdxLXdD16CGXBJYxdxSDH70cZ4dgpKdwjl+LjJUuDFWI0HRUAASOhxniDvuhL5zE
    qT2JE6L2kwJTe6KNVLvPtqjaHrQ26ZFbhOmg8gPzoj32zPK4uwKQoYRcI16Q
X-ME-Proxy: <xmx:Gf9Lanu9yY97Z-4W5ZRHpufXFy0vx0S5fde73EdhKBKWyz49XpvxZw>
    <xmx:Gf9LaidNb0WfC0Ddm2hE7f0olnR8ELqAOXhT1TPgmJLdQOrTkw2zUA>
    <xmx:Gf9LahZy56lTxd1GrgUiNZmf6H4o9S1O5ub90g8q0-f8AI5WzGhREw>
    <xmx:Gf9LakZVC2m1tnvyvrCX0rK028CtkLR_OyCqcMxbDdVldtLFMTO1kQ>
    <xmx:Gf9LamKDu7sHTbEFmmTwHFQB4y7bqR1M60lVO8OAGesMeA8QcJ7-VIPK>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AC99780AB5; Mon,  6 Jul 2026 15:16:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZOB0wyakXwF
Date: Mon, 06 Jul 2026 15:16:21 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 davem@davemloft.net, edumazet@google.com, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, netdev@vger.kernel.org
Message-Id: <d036b6fa-4f53-444c-b376-83e122982f1d@app.fastmail.com>
In-Reply-To: <akbdFcQP7oTp_n3s@krikkit>
References: <20260630191551.875664-1-cel@kernel.org>
 <akaoXcfamBp8_mYe@krikkit>
 <0a03d16e-d4ce-422d-9492-3e31d910d8e5@app.fastmail.com>
 <akbdFcQP7oTp_n3s@krikkit>
Subject: Re: [PATCH net] net/tls: Consume empty data records in tls_sw_read_sock()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jul 2, 2026, at 5:50 PM, Sabrina Dubroca wrote:
> 2026-07-02, 15:52:49 -0400, Chuck Lever wrote:
>> 
>> 
>> On Thu, Jul 2, 2026, at 2:05 PM, Sabrina Dubroca wrote:
>> > 2026-06-30, 15:15:51 -0400, Chuck Lever wrote:
>> >> A peer may send a zero-length TLS application_data record; TLS 1.3
>> >> explicitly permits these as a traffic-analysis countermeasure (RFC
>> >> 8446, Section 5.1). After decryption such a record has full_len ==
>> >> 0. tls_sw_read_sock() hands it to the read_actor, which has no
>> >> payload to consume and returns zero. The loop treats a zero return
>> >> as backpressure (used <= 0), requeues the skb at the head of
>> >> rx_list, and stops. rx_list is serviced head-first on the next
>> >> call, so the empty record is dequeued, fails the same way, and is
>> >> requeued again; every later record on the connection is blocked
>> >> behind it.
>> >> 
>> >> tls_sw_recvmsg() does not stall on this: a zero-length data record
>> >> copies nothing and falls through to consume_skb(). Mirror that in
>> >> the read_sock() path by recognizing an empty data record before
>> >> the actor runs, consuming it, and continuing.
>> >> 
>> >> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
>> >> Signed-off-by: Chuck Lever <cel@kernel.org>
>> >> ---
>> >>  net/tls/tls_sw.c | 11 +++++++++++
>> >>  1 file changed, 11 insertions(+)
>> >
>> > Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
>> >
>> > I think tls_sw_splice_read() suffers from a similar issue (returning 0
>> > even though more data may be available). Sashiko agrees, and also
>> > found a few more pre-existing issues.
>> 
>> Do you want a v2 series with those issues addressed?
>
> I'd be ok with this patch going in on its own, and the other issues
> being addressed separately. If you have time to look into those,
> that'd be great.

patchwork shows this patch continues to be marked as "New". Is there
something I need to do to help move it forward?


-- 
Chuck Lever
