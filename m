Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4F3C5526;
	Thu, 13 Aug 2026 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622694; cv=pass; b=NM/JAIl3tddkR6vIt8e+CV2bN/8KsP3ryb+oCum0uE++9Bssm0YUDyJZ6BHJd93QlPP/n0xDVDscT9Ad0MqrQnR2OtZKAqUR9PqkNnSiZuHYK7TedOmAG2J75RydYXI9E2wpaEBLMAqTfFAbONd5mVpr7+Oks/bgOejiqRjN4Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622694; c=relaxed/simple;
	bh=+2IVcWkaY7KyMY/HLdEH7iCFCQtG4yKe5HjwWsqj6a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoQUC3ow5YOh3afLL82sCJj3ng1YTVKPWmnLhbGb9ND/8c8eP0+HX5bAE3cfZN9Zrub2U9Rrl0JPWupVh6rO83BmH7rjaIOxNEZASSsMZ7xYj4bnF6TP0sIdJqwkiTB6wFu86YRouk+tKk5A5i9IIO00L+FsPZTwO24Ja7HBaOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qqr0LTp4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6wvpP7Am; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qqr0LTp4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6wvpP7Am"
ARC-Seal: i=1; a=rsa-sha256; t=1786622502; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XSnZukvFOEpILOciXBBByilFT/bpjnSXsAk3xP5z2X0LFtW08scjx/nFTk/0Qw7msJ
    8i8qQYhjC1SnCDidPMldHBZ0ieBPPzFJOn6sQnAz0urCPZ6oWH+LYjJxoZ0BOSNDz/SM
    Bf1ZTwU57fDbKqQX6Jzve5F9DNtqy2CVY3IJqHak9kOYujtQAjHAKNZoUzwZ3t5x9BCV
    GAF6C4bMhUJEGZvodOtcqguCr6QpNu5JzyKzQ4nOAqMCpEsxDgVVrW6oj6HtMDlcCY6t
    wuziFdCzzYXlKnqqaboopfcj103Di0KvIvD04QikX//MRaJf6z9/dDjs5Vu0pAWugU8a
    6Okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786622502;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RTcVkqtj+ZzuKqkzflCf0W648zoY7byAeauUzQlxVrk=;
    b=M816gMw4e/AzVczHRgaAX7owPIZZSjXxHkUHu02HjYGvoC/0xQ3tSayg+pQFKpQcal
    +bpxXvdTw5VKB2o1AT0Q7W3Fhts8wpE4HJUidT17cW/CYdvPSEQiPod55h+FMd9+eB7K
    mGF11y/Rb/VpkkxaWeXiqSbK5kKGMBcbmyxIrKNe7o9FusUeZuPEUW2Ghm+qDrCSo2J6
    gWjPnggVplskXoszLR2uBCTKrJ9hgy4xy1Y4N6EZBsSQVP7Z1XrCFoEbQRs2iziSGzlR
    jlUAf3a5KqGnbgmnIrPnTMTM2uHYlGZyOSl2By9SJhn5PgPsW5cmQVr/lCtxhngDWtIE
    uEaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786622502;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RTcVkqtj+ZzuKqkzflCf0W648zoY7byAeauUzQlxVrk=;
    b=qqr0LTp46ZsEdiObb+8/Rp1lJfTDLBog2wJilkw18Z1JIupMFKKKNGICreSvEOeteU
    o3vUTAzclqypWG7TQPxPZViPN74ojMB1X6HqRnXKSzxu+SbtaQxKWew0EtzUIqcWriTp
    4eU6T352nbwB31RxmrMWQC3Oiur/rqIQIEJ6y/hnWI0XQvenu+g3N0hV+EAki8eRkjOA
    q/HMe0ZtbSNzoYRJWHIMreS3VxswQ3MaKd2h2o23Dd8VGlFU7v+lA/KeGfW65hznj8CV
    cAUjDXYQssvOIqD4yKAu9ecO8mI2hC6ByYem3an6yMAFykvdL1evt60VFW8DsFbifz7g
    jczw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786622502;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RTcVkqtj+ZzuKqkzflCf0W648zoY7byAeauUzQlxVrk=;
    b=6wvpP7Ami0cWM+2FInuaKPZ1YAoT9KUDjEYYiouo6Esq16uGATqV3Q+CX+r2jc+VGU
    ZdPITbPPLQgfvy0WwpCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id K5281927DC1fizf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 13 Aug 2026 14:01:41 +0200 (CEST)
Message-ID: <7cd9991f-57d8-47e4-83bc-2dfeb8a844ff@hartkopp.net>
Date: Thu, 13 Aug 2026 14:01:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] team: reject ARPHRD_CAN devices in team_port_add
To: jiale yao <19888972804@163.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723040032.2094322-1-yaojiale02@163.com>
 <20260727182447.114f9fc5@kernel.org>
 <6be0ce2c.3d2b.19fa728cd87.Coremail.19888972804@163.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <6be0ce2c.3d2b.19fa728cd87.Coremail.19888972804@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 28.07.26 07:18, jiale yao wrote:
> Hi
> 
> Sure, I will check, and send v2 patch if there are any others.

I've seen no follow-ups on this.

Did you check on other similarities between team and bonding drivers 
according to reject ARPHRD_IEEE802154, ARPHRD_CAN and others?

Best regards,
Oliver

> 
> Jiale Yao
> 
> At 2026-07-28 09:24:47, "Jakub Kicinski" <kuba@kernel.org> wrote:
>> On Thu, 23 Jul 2026 12:00:32 +0800 Jiale Yao wrote:
>>> Enslaving a CAN device (e.g. vxcan) to a team master triggers a
>>> NULL pointer dereference in can_rx_unregister() inside
>>> net/can/af_can.c.
>>
>> Gemini review says that similar issue is possible with
>> ARPHRD_IEEE802154 devices, could you double check that,
>> see if there are any others, and all these in a single
>> patch?
>> -- 
>> pw-bot: cr

