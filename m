Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415434;
	b=01nW/FZFNd7DitC30QqipCUlTp13o5Byj+e4Ct12uos/LCBph3G/ZToihGbgWxnltSwQ
	 B1gdEyHHKk8jIpKySXXBS/1xiOhT5Scc78046FCCFOr19pAf1h29mI7wAlDto3PX5Xy38
	 jZpKF47ULwxp2mpRwxWANw5sVPAusplQuxp5cNnZFD+5jcChjRpWrWqtcLBRNACQlfDlC
	 FD4ZIIEj2AMKmzjmgFdq2SXEYp7pF1EWsYnpO+GJ0J6dSUJnr6OqRk6SE0nzorbShCFzg
	 JLCsW/1/wsStcMquB/nyLektxp7yFuGynSJFm8LGD+5r5dioegZKWaaZ9bIIWmMLNGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415434;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=32zGssUEvJ3DhM4umYQny6PIrqpB5bwtNYfrOgNVlA0=;
	b=RIQHQXjlOHCYmJm3e/6XKs1vAd373rYaiOro+h1pWkM4xVyAYYsCVNFI5batzu9CCHlh
	 4uKtkNHe6XFser5jpumdsYARjzAuuL8b+UjLdXNa//nlCJMtNfO3cCl8mT5lepOe5nWY1
	 PCKXiVNamvVXaKtdoe8et0S4qyCPlxvAPYQMSZfMBBkHVe6qICpkwgcE0KozXEETJ86qg
	 v6aOim3IhiByQqkqcznj0iPrYKtRQN4n2bJFOjEY6cQ6F/atSTqVFguxCPgXOd3t5cUad
	 dAqob+PrsCGOP0oMwcJU7XMo1Pt6mpEsue+Nuoc/ZpLfIg+lGnFqOhDYlr2IM+4N9ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLS50MZ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24B606A8B1
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLS50MZ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CFA1F00A0E;
	Wed, 11 Nov 2026 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415434;
	bh=32zGssUEvJ3DhM4umYQny6PIrqpB5bwtNYfrOgNVlA0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DLS50MZ2z494AvCFXcgO49Z28DKePHSI51aN6UOT17extFmfY5e17gs3nXlwtft44
	 7PIo1k/uxCB676H39utUrp8P7hemd7UKmUqVP/VPoQELQMRwyHja4tFmi0SfjcjMNL
	 q6zDB3401g9MgMAbPvwbRV8pNpFPOAfRMP8BZ5MYa2Ejx7iaH3uMTt35hKRYSAU4vq
	 2lsIdRxoQu8uEcJc6faqLzw84JfW6ipLeH4OGK8CsV73xFqPVtGNKMmqdsKFH/kVGj
	 WDl5NzyK4OI968JaCuv+n9sY1Jvyra7TgUDBMCG9ysLWc1Pbeyk4THqiRtWYvDbS+/
	 SV8Xo7mbyJPlA==
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfauth.ams.internal (Postfix) with ESMTP id 76C01198003A;
	Wed, 11 Nov 2026 11:43:51 -0500 (EST)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Wed, 11 Nov 2026 11:43:51 -0500
X-ME-Sender: <xms:RZv0alPOP-mOidsSoToW7jwDKcrN-YVX7FCV9mjqsjh0nG0xNTapsg>
    <xme:RZv0aiw_nK2Go7B8gtM_1AaNXmNQmbJHP5BjWbJ3fFwsO3VZT249F6CbAJ7iH6m-m
    wYxUAhD4t5H9sKkaoDb3FvU44IxStlllwMHwnlqcY6GKtTFn23m7FcA>
X-ME-Proxy-Cause: dmFkZTFhKeywdxFUybg3R93iAsV3S9GBFaER7M6TJB4qVMyW+v+16t6mvpPYG4HiqMqxRT
    cqWdwPPcxHFvMt6Z7tOYJsO2ffMZdUuIpMbegUJCuxqkQPdNfo98LIwA1lITK5/YdOCceD
    cE4OEQ65yPsrNXO3Lo8YZxDH5rU+HHCC1u46y8kLXmPwieDvuogqaLJI8UYKlqwhJImb3w
    4bEJZASI+oAtPf3P6MMYg+F5cPeNN9rC2/bCvcZshflSTcUWDoZL57h3N+Gc7BqBkxcerl
    bH5RgzOHM4PII8m2R0Anf7d/mwLOhitjpd3Vtfbxjv87EBV0rBb4PaVEhrzbXl8qQssALs
    FqWyNPqgLx4b9iS7I2TpS8X0RmgaCetGsianw+vZSc7fFnHacdsYOSYOBwu+x0INsPDhKe
    eG2vmBL02kxoPcQjjIsbaUBdWWXnRnk/GhyYIDjpqObFBxChTnI472GXZ7LLPvlABPPseA
    ce2DnG730pE1RMg8q/L2T61C/W+6+5u0fO6tuIQJR70hn0dL8+t2dYVFt0y+d9eCyizFbv
    b4NJU6TtmwCi27Xi8I9+Nn08kfm0cBPmDHuXCCrn4SRmZewMLCfd2zPKwbcVARjuDfvn9i
    VkSTTY4B5BLOGhKTKchfiTxGfw+B38VBpEEiFgmJvZ5SF1nHPVlHIuyi7OiQ
X-ME-Proxy: <xmx:R5v0auh2PrcqNPNlDwQeeHF8yNeKtlE1ukRRctJfJooCRH6Yb3YT4w>
    <xmx:R5v0apAuNmcxpc9wCF_h8vquAYdGQbE0VTKkcGrA1hXivTXuYsH8hQ>
    <xmx:R5v0asvB5ZTT_MjWAKCml1dfKmdLG0roCQlfmBA6eV90VLbQW43ixg>
    <xmx:R5v0alfjy2MHipvg5bszL0xwUgyfnhUOtMsvuhMkJtRwLXliAe-TBw>
    <xmx:R5v0ap9GBzUnqR5ibEF7fjMTh4G2t5o-2qulV0urDWMXigfn_f_vJAf5>
Feedback-ID: ia3204a8f:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A8AD12F8005A; Wed, 11 Nov 2026 11:43:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: APqG7cBtEf9F
Date: Wed, 11 Nov 2026 17:42:44 +0100
From: "Imre Kaloz" <kaloz@kernel.org>
To: "Elad Nachman" <enachman@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Oleksandr Mazur" <oleksandr.mazur@plvision.eu>
Message-Id: <02e94b70-d446-4518-8f7a-c0f710e3b572@app.fastmail.com>
In-Reply-To: 
 <BL1PPFB0715B38BE2E57548F95CCBDFCAF7DB712@BL1PPFB0715B38B.namprd18.prod.outlook.com>
References: <20261111101521.9878-1-kaloz@kernel.org>
 <BL1PPFB0715B38BE2E57548F95CCBDFCAF7DB712@BL1PPFB0715B38B.namprd18.prod.outlook.com>
Subject: Re: [EXTERNAL] [PATCH net] net: marvell: prestera: disable port before
 changing its MAC mode
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026, at 15:39, Elad Nachman wrote:

<snip>

>> +     /* Firmware may not report link up after the mode or inband set=
ting of
>> +      * an enabled port changes until the port is disabled and re-en=
abled.
>> +      */
>> +     if (old.admin && (old.mode !=3D cfg_mac.mode ||
>> +                       old.inband !=3D cfg_mac.inband)) {
>> +             old.admin =3D false;
>> +             err =3D prestera_port_cfg_mac_write(port, &old);
>> +             if (err)
>> +                     return err;
>> +     }
>=20
> From my experience, if you take the port down, it takes time for the f=
irmware
> state machine to act accordingly, so you need some significant delay h=
ere
> (1-3 seconds) before you write the new configuration.

Thanks Elad. I found this bringing up the SFP+ ports on a Delta TN48M
(98DX3265) with firmware 4.1.0. With an S-RJ01 module in sfp-52,
the port came up in 30 of 30 boots with this patch, about 2.1 s after
link up, and in 21 of 30 without it. The disable write waits for the
firmware=E2=80=99s acknowledgement, and I saw no failures without a dela=
y.

Is the delay needed on particular firmware versions or devices? This
path runs under rtnl when an SFP module changes the mode, so I would
rather not sleep for seconds there. If the firmware reports when the
port is really down, I can wait for that instead, with a bounded
timeout.


Thanks,
Imre
