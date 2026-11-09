Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=145.239.82.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263631;
	b=T1g9YrhLuG4QVBBbJQ42PJv8TUVT/MEHjopUOESkyUGPv8oSWY83hB0UeEJOSD4yKhEb
	 1O2SHdMbYv4dupRAaTQnCoQ2XlH//7Bp5enN43WmNhR9RsQwKRlIbpv9kr198BX22Qt0j
	 EsxjzCF/bDHWCX3NRZfroMcCAKw0PjxD+wf70J1ESJwNtx8AeGcc8AvidmYAJDATa0kcv
	 26ywhO+JUkZXoBqDnJJ25432UeeD1L6g7ztQEQNLv1F4tQfpzAudxuunzKna3ZCASSVj+
	 99rec40UBvnKKxgrRhZlzQoBteM2hDEgNRtOlxHMTVngV9i+l8TZiqcgpb4GiT3gxEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263631;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 Disposition-Notification-To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Sender;
	bh=j6T4azhngLDHnYHxtK5abGg6pXWrKvEZEpN8JEf/eqk=;
	b=PJ36BLBNSUXAxaWC7Nki+/SKtkDLNZVyx0CJxCgjOctCDMpPbAZgoIa7AmyCkO4eDAgt
	 girJZGi7t9x/ultvs5XRE8tHk2P2U8ReUqcQAhwaQtyTKmNma/pQbtjfEe9Oxii1lO9bg
	 5rsCSAzwE/MGHvyCQGVbqxCsZoFPM/xhTTZLdJloa5ZDn+GC++QyZaEQ07vugiCsU/Yyy
	 PMH1VyjrYI+BlMPRCrDfq2iwfOSlJp1ZDuaFWkwWVIVdgjHgMQJiIetqW65PmAppCIwK9
	 YdLAyuTpsyMErKy4lrHH49fbCFdMZC2iAmEW6jVTTkCqsq7DFQ52hW2pZjhf/FLvnkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=maciej.szmigiero.name;
	spf=pass smtp.mailfrom=vps-ovh.mhejs.net;
	arc=none smtp.remote-ip=145.239.82.108
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883A606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 22:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6883A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1xQXvk-00000000W3m-1490;
	Mon, 09 Nov 2026 23:33:36 +0100
Message-ID: <e2684e1d-3f1a-499f-bb09-903e690981c5@maciej.szmigiero.name>
Date: Mon, 9 Nov 2026 23:33:30 +0100
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
Subject: Re: [PATCH net] net: wwan: iosm: Re-bind the driver around system
 suspend too
To: Zev Paneth <zevpaneth@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20261105102009.34534-1-zevpaneth@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <20261105102009.34534-1-zevpaneth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mhej@vps-ovh.mhejs.net

On 5.11.2026 11:20, Zev Paneth wrote:
> On some platforms the modem loses power during suspend-to-idle even
> though the driver keeps the device in D0 and its s2idle resume path
> only sends a wake-up command. After a long enough s2idle cycle (about
> five minutes or more on the test platform) the device comes back in
> its boot ROM stage: resume logs "msg timeout", ModemManager then fails
> to open the ports ("PORT open refused, phase A-ROM", "Failed to find
> primary AT port"), and once userspace has touched the ports the modem
> stays dead until a full reboot. This is the same failure mode that
> commit 0b6f6593aa8c ("net: wwan: iosm: Fix hibernation by re-binding
> the driver around it") addressed for hibernation.
> 
> Extend that approach to system suspend: unbind the driver on
> PM_SUSPEND_PREPARE and re-bind it on PM_POST_SUSPEND, so the device is
> re-initialized from scratch on resume, exactly as it is at boot.
> 
> The cost is a full modem re-enumeration after every suspend (about
> 50 seconds until reconnected on the test platform), also on platforms
> where the modem does survive s2idle. If that is considered too heavy,
> this could instead be gated by a DMI quirk for the affected platforms.
> 
> Tested on a Fibocom L860-GL-16 (Intel XMM7560, 8086:7560) in an
> HP ProBook 450 G10 (BIOS V72 01.13.01) with kernel 7.0: with this
> change the modem survives an 11-minute lid-closed s2idle and
> reconnects automatically; without it, any s2idle longer than roughly
> five minutes left the modem in A-ROM until reboot.
> 
> Signed-off-by: Zev Paneth <zevpaneth@gmail.com>
> ---
>   drivers/net/wwan/iosm/iosm_ipc_pcie.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
To be honest, I'm not sure such "big hammer" is indeed the right
solution.
Maybe the DMI quirk you describe would work as the last resort.

Could you instead try this iosm s2idle patch at [1]?
This already helped one user.
You should see "forced D3 sleep" at the modem device probe time.

[1]:
https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/work_items/992#note_2938256

Thanks,
Maciej

