Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382886;
	b=MpIRQD2ekmZ1JKZsCKmL0NAA3WzTU7T/kByUPnl0u3tvBAUhPeAoGbPdK1M4M1enY2wh
	 n6n8I33VkRDa9rMrsc/cWF/xZ0fc7KGrp8FPzj+9andP6snvsituNhWzxERcBn92xMNtH
	 oqGMqRj/bXHeho1ENx3Xlk7QRxqy3Bdbrk4MIO7oGREWm+A0V95vBrBp2Oht0yXoWN0Yl
	 M7dV9lhXfoRhKcYwpjmYUvXYxZoFd22xY/pcQleucxu5lL3XqEztBb3T0CyNWY2WpHYx3
	 tPlrfO73osPk9lDS1KWPLExqndNTibcnGojXmUgLEJZRwzO+p1hW5fkbXrI4jBVMFRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382886;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=3UfZG3+pcxBGzlDM7p3wxd7lWx3StudQV3isrWC7GYo=;
	b=frJlxDDNumqId2Z9DJ/A33LzVDUYOYoYpKTpvFNe4OGBInLKJudjurhl6KHJFxgfMUzY
	 pUay9muPjAvoHpDPBXks7LcOF3YTZMPHKJKgWPU1BKGnKk78Inz706gqFwzlIuE72uPcX
	 6Xf9acOHGHd+irdmxRUlZ80C6deJ9sQCAsQI9xSk3jzG54mv87BbtEIY3UOdXfFKihxwZ
	 saCCzZrWvXHl2j/nn5tmCmojUlOcDwyze9pAyqzPocEIdUbhV06KeeDP/esoZW7qRowQw
	 pieIVCzZVJyS4DMV1sTFOBYNXNe2XZm54lH10gGNNXbR6480w1Xp7EwAFJmYxUliYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="Ed/AU9Ef";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D7606A330
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C8D7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ed/AU9Ef
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 76FABC49F66;
	Fri, 30 Oct 2026 17:55:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CDC0603C2;
	Fri, 30 Oct 2026 17:54:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2DF2610328D09;
	Fri, 30 Oct 2026 18:54:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793382878; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3UfZG3+pcxBGzlDM7p3wxd7lWx3StudQV3isrWC7GYo=;
	b=Ed/AU9EffaVtc40WEgAfXmqRJd0jQnDRTVE2wED7Hwrq55Rwh+eQG6ovoxUQLGR63U8fC6
	mNRoZWfjywsPPSY81bOYrdXfKxGAA9raI1qMIBNFVwMrEcUK9vzBGfp1DzysTvSECPwCz4
	Uyzksz2eyOXr6Y58PdOzc80JDSedjpZRhdT5lW9zWyJkACFylYsQdz8nusoPcqhL0H18tP
	W7PDks3GpMiEzH8VoxZAnOzpeQUWfu2Rr8PdTRXGNNfXY8AZ5UKkXGbU9Ok933rdtsbQcH
	DauqcFr9/QVIepsN9CTkMlA8Ks/hsLI98uQl8KpqOpD5omSg/BmlA7GazG2uGA==
Message-ID: <701c6f7e-e715-4647-bddf-48a1485afbe2@bootlin.com>
Date: Fri, 30 Oct 2026 18:54:32 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: pause: Skip support tests without
 link autonegotiation
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org
References: <20261030173516.1002250-1-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261030173516.1002250-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/30/26 18:35, Mohsin Bashir wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> Devices without link autonegotiation support may reject both link-setting
> requests in pause_test_support(). On fbnic, all four variants then fail
> in cleanup when the deferred restore of unchanged link settings returns
> EOPNOTSUPP. Removing the restore alone would report PASS without running
> any pause checks.
> 
> Fix this by calling require_link_autoneg() before pause_setup() to skip
> the test when either interface lacks link autonegotiation support. This
> also skips devices that support only forced link configuration.
> 
> The issue was observed in the fbnic CI/CD pipeline. It was reproduced and
> the fix was tested on a local fbnic device.
> 
> Fixes: cbd8a536cd6d ("selftests: drv-net: Introduce a selftest for ethtool flow control")
> Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/pause.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
> index ca4a55e59c30..1537f88e0e77 100755
> --- a/tools/testing/selftests/drivers/net/hw/pause.py
> +++ b/tools/testing/selftests/drivers/net/hw/pause.py
> @@ -466,6 +466,7 @@ def pause_test_support(cfg, pauseparams):
>      supported fields.
>      """
>  
> +    require_link_autoneg(cfg)

This helper checks if the remote supports aneg too, so it's too restrictive.

The goal of this test is to check the local device's behaviour, without too
much dependencies on the remote, so that we can at least have it test some of
the local driver behaviour even when it's connected to a dumb remote or a switch.

Maybe the sane thing to do is to allows the defer() calls in pause_setup() to
fail silently with "fail=False" ?

Or maybe a bit more clever, have a quick check to see if the device accepts
an ethtool -s XXX command ? looks like fbnic will refuse all of'em as it
doesn't have a .set_link_ksettings.

Maxime

