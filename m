Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793889253;
	b=szLxoEsHblqM0RF2LXJwxHONMGY3Sn7zNuzB2s5JNnv6fViaTciCiUVlSVEQtEslfMzo
	 PybHclBqgwPjbFkyzQFM4JhG93eCo+2ilHTkbwah0eFvcBmutYXV88UcpaoIrnwhu/lEd
	 G2fV44iLzKcot5Tx1dflYGFYhjsYAvpAJ3tdf3/SqHF97E0ihfvvZjFxvVytpjM48Nt2q
	 QCBbvlIGqSA9VmlfVvEpy1HM1DcKcU4RRfeIRXzr0rLl9dMbnBn5FITVrfB32WcHzAqa3
	 Bg08Uy3tD+ACY9z9wytQ18a3uuhAf7bctVphNjI3wf+V2pBr/PrqlQcgPzyBrcVlAig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=eBSMLq0Cu1SynJnQjT0GgdGhFl16/3YHv9z0J8QstiI=;
	b=1nqeR2fmignJrIEAsatt5aplYNOrDEDiU6HCePpDv5yCBYhYt0otZ/knVg/eaL/kqBnA
	 JRv2oOS2OQsNpfIWwKPMmyy5J9tX/nE6vdV0nB/pnTvrCs+PlCDr0wnJksWkcs+Og+eT7
	 xXthIyyDQqGcIKhtxaR5y565FG5Df8wbj5aw9HqlUV4HmzjBVW63R0jZWBoJ/d5nJM4UV
	 P+qkdDDYv/Zl0B/la+ZMSgkmuKgGdLySD1bxAZSQaZtI6kjn5vJ2EO2rp/BfBdUKr5jQy
	 56EzgbqgULPYp8TQkE43DwtJIi/6IP5huunOjZl4gbckdchDHpzvIyVCwpjsUHspcqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn+U5J+q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F0606A33A
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 124F0606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn+U5J+q
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so92984166b.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:34:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793889251; cv=none;
        d=google.com; s=arc-20260327;
        b=cNqFf+OHGecyzzJGLdL3QYqUELFmng6LYpGXZWURHqoXkKIQffUZC54UtUqdcGMnZE
         8ddFQyk6viHCTMJQUJ+zrGRSUNcjAajUxSjVIA67n3+dCC23agHm3Lvp0yeFr0CaF8Ul
         IBn85RbLc9tSWaozoT+J0sljDqxG1h3r4p2ptgK6swlevmOlBCMQ5XCpcOD5nvq+DjgC
         Gr6dp/utKvyhvuuT3NQEZTsokmqbTg1upqYc7Dd3kA0unz2YfAlDeFOHaRMQpVaU1c5B
         bXBmUGt+pUYiTmdAKjXKkgCl/8F1x98BIcrCFTUUAHtg+gUCUWQuMtWEnpJS9ojL6xh5
         1qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eBSMLq0Cu1SynJnQjT0GgdGhFl16/3YHv9z0J8QstiI=;
        fh=wdEPV9dg75m6qyBTETayN+Zizl1Gv1BUo3SQI8J21tY=;
        b=JWSak998qhOWY0r5Oklj0p4om09TI9e7oOl9TuVUeFi1EfewI57PlRdkY8ahCKBwqG
         bep/INcNf2QNkpIEnUjz0n76bh8kIhnBN3uYofMBW2hfogATVdvyhI5MYDhTzLcQTHTw
         MkHCyxMKWtrQSeSrOHxVgKit1GOwP3+WY6i4CdKelW7C5T6X8n+vB3ZEPOBb5ru7K0AW
         3zhdwo2SuT6WmoeWAa5EYqqFRVvi9hKRka6OpNA14RwRV2p6ug9v/t/O7tneJK5nDxwY
         Iksiw4slos3B4mZA0j6/u6hpnnboNsgZXpQtCkQXiuYXypsTmV+zZW9kdCE4vtoF+MO0
         LZEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793889251; x=1794494051; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eBSMLq0Cu1SynJnQjT0GgdGhFl16/3YHv9z0J8QstiI=;
        b=Fn+U5J+qza0f0zVWfDQpvwHfL7j9SJ4qtGbgBjH6baz+DktXPUSGubXFFXYLc7pA6h
         rlyqwf4kuZg40wM9eB6JhjaW3lOTIAEOE+bg+4s3+PjsSeVlQDXEq1Bk9Kb4Upurd6Gh
         fm9G4pdwkPb6g1KtBas36NcDQZAx3CILZK4n2AmuIEcAArbdGvVhvtciL7h1gzzR+1qr
         Hghgim7FvlxncFLfcJx0Qhr6d8cZvSnR2sp5jbB4Pl5feXIT9c6iiYBrvOpD60SCBYTE
         6ozzOnhhpOusmRc/tR0lj+xhgMsysIz9IU2Xl0OR4KztVscyWuN3nCyb+zEC1YMnmjZd
         0JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889251; x=1794494051;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eBSMLq0Cu1SynJnQjT0GgdGhFl16/3YHv9z0J8QstiI=;
        b=TVgBF7tII4mxraSq9g/ew9PDMSzaDs+3L8x2L38wKVqbleRWtybYqBe0ptsUoyJewx
         fEQMLKE4NIuCroA/4PgUQDuvaFxMp2yJbNHNH9Y4NJA7GSCyTFoJY4kTXfLqEeJw56Ew
         ziFQ9VKwl55eE/4SeVCus0f6U52By59PpumRZ6sp7RjXEZLLQFvx+01OhvS704YzMEef
         awnuccroNFS3B+F1OVmMDvHYvAeKZ3ISq0N2V1Xmnxbz0hyd1Rl1fmy//JbB4P66R9ZA
         g5iQi3seh4xgkjp77Dd/EagExNheFTYYW77rSp4HgirwEo8zWvEYPZL4ppKk4G4WM6+z
         /u7A==
X-Gm-Message-State: APuU4Z87xxBC+P019rwxU73058r84hHAZxPYQjfCXPNmx657s1zOYQex
	d+oiLlzvJ9AMCz7daIdidXrCboiXzf9LiXkMAK3fAC2/MS9uUpf/KRZkYaSTp+LE+4CLzGiTC7j
	TaNEbI5ZbOYKn7w5xkpwYOMl0gAYE+i4=
X-Gm-Gg: AYBFou3iKyprKtrsiqD857ADDlqwNicf42KXjHFGKSkDLDyStfaAUB67mjnZ9zpmCPw
	jG/AXbuRYfdvEyCIZHgoKieHHOC5stdySNDa08nlHaRgKtcP+KYT1o5OpSx6EMoJh1Fjo3BB8An
	Bbua7lNnpW1T0QwBsvmOrvu7Bd5sLB9sf/EXpDgf5kAGMgP/Pc2huwJYUJDOhcQznavJUr6qpwq
	/kdO8h+i7zyoRe/O12lrCpADJIV02rqEtwwMIctKLKUBpIDoQS4iJLypgdsY2z1NpJgiU50xcR2
	JPXo1xtLAmuJRqFok/NMdOlMGM3ClcBm7zarPpP53ZjB/Q/ofPzdTekTA8NEOY2hCUufWdCx5O8
	qdPy1/nL8UgQgmeWy5y0LN/qVq8yjhIvPEB5stqZXXNsVbC7JNqdPltg9
X-Received: by 2002:a17:907:a08c:b0:c49:cd37:177e with SMTP id
 a640c23a62f3a-c4ca7ae9ea5mr1685184166b.48.1793889251247; Thu, 05 Nov 2026
 06:34:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102132903.713908-1-tommy.shih92@gmail.com> <7e1ac14e-b306-4921-84fa-8266b3263f2d@lunn.ch>
In-Reply-To: <7e1ac14e-b306-4921-84fa-8266b3263f2d@lunn.ch>
From: tommy shih <tommy.shih92@gmail.com>
Date: Thu, 5 Nov 2026 22:33:59 +0800
X-Gm-Features: AclHuK-34GTXXDn6VAAgsncXcgyq2On88P1RdV4SufAnBSG2fIKBHz6EgP79Iqo
Message-ID: <CABXpiCoUqhq_Jt8AWcZRQWue-pTvoYSGxNkbz7e5MLvw0Mjh2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: air_an8801: add WAKE_PHY Wake-on-LAN support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Daniel Golle <daniel@makrotopia.org>, "Lucien . Jheng" <lucienzx159@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 03, 2026 at 09:29:14PM +0800, Andrew Lunn wrote:
> This is an interesting definition of WAKE_PHY.
>
> Are there any other drivers which use change in link to trigger a
> wake?

Not really among the PHY drivers. mxl-gpy enables the link state
change interrupt (PHY_IMASK_LSTC) in set_wol() when WAKE_PHY is
requested, but it does not register the PHY as a wakeup source
itself.

> How are you using it? Is your device plugged into a manages switch and
> you are making the managed switch down/up the link?

I don't have a concrete use case for it. Waking on link change does
not seem to be a common way to wake a system over Ethernet; magic
packet is the usual method.

> Is the hardware capable of waking just on link up? Is there any point
> waking up if the link goes down?

No, the AN8801R only has a single link change wake event, which
triggers on both link up and link down, so it cannot be limited to
link up. I agree that waking up on link down is of little use.

Thanks,
Tommy
