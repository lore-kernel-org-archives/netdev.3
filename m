Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F4378D94
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975513; cv=none; b=dQbh50SMhL9rtPU4G31a199RmCJ9h4so6L2wlvNuw0zB+4pNVOrJFUPZW/wo1DQMgoeduSOO5VZRJBjXYJcXS0CCZF0FXUGEbknwC7Z0JYwcgmKeFSzJ0wxSSXMCdPgwhTq/9S+vsSQyWg1HUMCbzCvD131ouPP1/vKg0ItN7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975513; c=relaxed/simple;
	bh=nrI4GPIQhcNLCr47tkvvICyrs3LEYA/CiiaxMuRCSAw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MtUTusdJyh9KJiRCWnQ8oiK1V+xi/G93Ln3wbRnHwULBd7xgjACt0eAcjPSDmzjHG0cfcHi69r+v5WlNys2BOoj1o1rpDn2UMVuoF623BEbbSS1mAQ/lT29YI/j/gLPHF9YI8mUl3eOBwqN2Ac6Y1I6tyLcT0RG4/wQBZrRpmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=R1cMNfpE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sePm/wAz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="R1cMNfpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sePm/wAz"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 423B6EC0077;
	Wed,  9 Sep 2026 13:38:29 -0400 (EDT)
Received: from ams-imap-09 ([10.64.2.29])
  by ams-compute-01.internal (MEProxy); Wed, 09 Sep 2026 13:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788975508;
	 x=1789061908; bh=+OlHwml09KbQAHZfavRDO602tceew8eMar5iOF7IKLE=; b=
	R1cMNfpEJItjOJ2ZOP4i2YRdEjCL9Yfx+l9eScXoK9RD2KIAR9AmBfZlsP74TUox
	iRUl0PK2U2f2Zjki0mifm7991HDpMIT4mA0NKMzPKhBOgsC0ICTR7h+7szvaFHwX
	rvbicD/IYh4uDhgNzo5ulGXq7zLGExus/i2x11cMXOXveAhmwfr1VffEL6vVyd5v
	WuJqlsBgvIxuIDL3WCotxf30YAjNPDAO9g+Z4u8dHgzKbEJmhgnqJqmldGdDyfv9
	BPQyzO4GSlNrF9743RseqVx22lFh0Xixlk1rNs+D12jOxIoiziDeO40AcccJ8442
	0kfPasSQSpZiZrkkKyWpow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975508; x=
	1789061908; bh=+OlHwml09KbQAHZfavRDO602tceew8eMar5iOF7IKLE=; b=s
	ePm/wAzxLP7uYwcYrG2sS/Xq+goXbUtR4p/nbw53491ojHHQoLSI3+kMAFxToS7A
	zgmSQ/EZXxSHLuI5urdkuEOAALo6ghcMKyqx5Ro0Tmgk8NnvjMJ7u7gV/eOP3TSe
	HofoFIaHpR5urmRym/uAbAeUWgXt3/LKYD/FfGOeYh39MM6CVvTToTB2ieUGlHOX
	xRRcv3HKt9NC+oPbJ/1ldsQcyu/fK2GAY8z5BQwV4ybvlBCE8ccFpm/vntMdvf7r
	Yw4aOOEqvu+bAhu6+39UdQJNYKA93DaViyKiA0wY5yhhKGHesLkQ4ko27EuFgw7O
	n70WDCqZEHQ2EdXF6OVjQ==
X-ME-Sender: <xms:jpmhahAcgLhJxLSvRgj9ed6CbwbhaN60G3mUUA650IIjBkRFovCG5A>
    <xme:jpmhaqUmEUKCzx8ji482nxcLnrMf5_T79d6F5Z4xWvPnOuvekq2zFkK_hZO-AJnlM
    lQ6b64L3l_yS2x8jnldq43nP7f0VSxadzry-JqLK9lkinLkltIxV_wQ>
X-ME-Proxy-Cause: dmFkZTEV4+WjRKM3cQ/9YbgICPxWVMYRnIBLN5LjH81Dk2B1KXC8T1sEmU9Cr6Yp1x78FH
    Q19bv5vhacnjv0X8hZoeAWFHfc2f05iB4HyED4HB0IWs/nSeTqk3lg0nVGAt6ZK36HJum8
    mopKGvEu7ES/ulAncv0ZpXcxtwt9ywMaAcpz8UJ5U67zoRHIwnhck9CuWbnp3NasgHpwpM
    H0au4s4v7b75X7nMPHag2J/IEkOw74i9R0/q5sHv+bSEkEeB2MP7ShO/SlGQ2TAu9G16CN
    0MlKNgS1WEVQHP6p9y8gARwLhwclC3noXtg7K0Saz9MLQw2ETaCswsKFOXBS+S9PijxLJj
    qteh+Wg6Xvm32WxFEhH2FcKNwDkYWcErMF3cjnyZ1DfXu/iTjmWYBBAOcLv3rYcPm/uLLR
    XSRlcXIsoAN2kEEqNMc64e7iqEYr+CPCX4hQ294Va7XTRDLGh/5wCCeJ6bx0GF8tiIfxd+
    P5IWAGm2FSzqL6Wa3HDQL25qUXlGaE30bP9DltWPMzLAUh3ujINo15SRmQ5Jg67H93alVE
    uNMgQSYodN+z0bsQz03eJRe1RzqoiCwcI2PqQR9iUmJD1zGUSBG/Gr6Loex0ZBaD6M+Z+n
    qB/F7uIiYbVaydEoIly71gEAifSS8aAOB4cFf7rt4YIlMBEn/wS7wFSXx7FQ
X-ME-Proxy: <xmx:kZmhahTXEeEUxM94UUzcSZE8Z72KrqdeMVLzpcF90SN0H9-UcrKAGg>
    <xmx:kZmhalKgeQG75LEA9blNhGQbpR7xDRM-C0NhkshK7c-JJOuYTpLiSg>
    <xmx:kZmhas-OMXuW3CA6I4keFhBuOrIiltW6ye1FMWDh49DAjNRtleQxgg>
    <xmx:kZmhakLsoj7PIIH0EBckB2x3gZAzUaJpvZXrFCzoGAEVigSl_BBgnA>
    <xmx:lJmhameuF-NY0sYbM6QW04lqWVDKlyAuWiAK8eS8d7RirFE5gMFWUhDx>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B7AC7180087; Wed,  9 Sep 2026 13:38:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArITeD_9vPCs
Date: Wed, 09 Sep 2026 20:37:48 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: netdev-bot+sashiko@kernel.org, "Paolo Abeni" <pabeni@redhat.com>,
 "Jakub Kicinski" <kuba@kernel.org>
Cc: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>,
 "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>,
 "Willem de Bruijn" <willemb@google.com>
Message-Id: <d61e1918-7234-4be5-8520-7932e62de962@app.fastmail.com>
In-Reply-To: <178851946040.4131868.4350633164754043676@kernel.org>
References: <20260901195714.673548-4-alice.kernel@fastmail.im>
 <178851946040.4131868.4350633164754043676@kernel.org>
Subject: Re: [PATCH net v5 3/4] selftests: net: Test UDP length overflow with PMTU
 discover and big MTU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026, at 13:57, netdev-bot+sashiko@kernel.org wrote:
>> +    for filename, method in [
>> +        ('/proc/config.gz', gzip.open),
>> +        (f'/boot/config-{os.uname().release}', open),
>> +    ]:
>> +        try:
>> +            with method(filename, 'rt') as config:
>> +                for line in config:
>> +                    if line.rstrip() =3D=3D f'{option}=3Dy':
>> +                        return True
>> +                return False
>> +        except OSError:
>> +            continue
>> +        return None
>
> [Severity: Low]
> Is this return None reachable?  It sits at the end of the for body, bu=
t the
> try block always returns (True on match, False once the file is exhaus=
ted)
> and the only other path is "except OSError: continue", which restarts =
the
> loop.  The documented "Returns None if the config is not found" behavi=
our
> comes from falling off the end of the loop after both candidates raise
> OSError.

I'd like to fix this tiny thing =E2=80=94 should I send a patch to net o=
r net-
next (after it's synced)? return None was supposed to be outside the for
loop =E2=80=94 I added it to address pylint's warnings. It doesn't affec=
t the
behavior, because it's unreachable as is, so maybe not worth sending to
net as a fix.
