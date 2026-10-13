Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE723AB87
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883336; cv=pass; b=tVI722uUm3wqghd8B2Jyaynvhf+lnFT83kTxS+D48BdsfAWFziVnTiGTJy55lTWamEXRaVRqSHAtRSSyhRVvyQB67dA+r+UB+jH2oG33vExM7xnMIN5uwpAPV6sQ0z4qpyKADgXFI+22dK6GedITIsmYpqFNmTU6OopjaS1btOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883336; c=relaxed/simple;
	bh=wC750oiUHZAaqH0orFuVMNoPZ9RHOAY6kRL304Fr5Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6togQiGKukQlXbhxZ1DdEgqDKGj4bNpL4YNERDAWT4cyNDZRSjOb7UiLplT3Kbmu9OkHec1Ojm0fZcIsALrEqBLeSusnXAG5sGcDru4uh1/B5VyImQs52/GpvluRFMdM/Jo3S54Cxwok6fV6p4YqgjmoK81kd/TP9HJU8e8kFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hjNX3erm; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1jVK4ehQ; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hjNX3erm";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1jVK4ehQ"
ARC-Seal: i=1; a=rsa-sha256; t=1791883309; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CuPrAE1aujrrKTTqGnVE44NFRe1DP44CCmHgOvI6NIMkVTAnIB56rp80AxcEw7qQ+C
    e1kPniQWBsFrA48XW5Mjo/9GNDILmuwb0ArUjnlrhUjmiKsj3kmHoJOxBEKuQm5OPDkk
    V/q9238AUnYpQAk1+Znvo4uMGNznfIGa/WVIk5NEjv6puGLRAV36TjCidALU28r/JkNo
    lSCGtDTadph0c3ByseMmF2APz8+wTFHKCsZsvkPaBHK/EYzhHKQrZMmqOp75MPpQ5R5C
    +/GcuIjky7EL5oWjRW1Z872dmn5chL4Y3OKvOKMVZeNhTlOFtsKV1By82vdiXlGKAkDH
    3i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791883309;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tOA1Xza/VKOE/F6G3qq1NQn6FEvAoR2TRmvvKSQZ5NQ=;
    b=QXzGvrl+GvwsInkv5ak1PWW1bUB1iyhyNbi7gQ17fSRlUCmQpb+KoEcGpsRzoXg6X1
    UevZZW6O5RumtwL8hPmQhPoZMpL6IG7x+fKLO7ZeoVDeYP61bJCHQ91GrXMM7eciWVsH
    7WweWJ3zSBNhfleU2GLdIj5vwVK6jPfOUMZZPqO4evRqkOty1e9v0QK5sbbGZz3a7ZA5
    83/XVaXp4B6zfM58MWVEIAUdWMkHja0hmQbExOMsqZS/8RTwGSYmkApiFcMJw8cy3SdT
    Ty2Yx2YApltEYFf7drQOwJN3vwENqBZVBDObGzk1KEAsc70i4CKvIH0gETmCQR3gjAo4
    Uvng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791883309;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tOA1Xza/VKOE/F6G3qq1NQn6FEvAoR2TRmvvKSQZ5NQ=;
    b=hjNX3erm+p/jDDEzg3YXLRaWqqIBTNVE2rCQ5Hyvh09mkt1CGo0yHWLP8WObKv2s0u
    eb6mYaqJjivwz8RlsJcpTn+YpwLNWpdwGFrlE+MZFYq979fLthJjfIXQk6IOy1A3Mc9L
    VfgMRPeFLpXpJDTb/gow73vJKla3bTziJtPZMNXbe6NSNKEISBLncBYtjbYnrwRIbkLg
    xVK8gN3KsSIteGPYAArgEh5C13D5iPV73ou3WQwVUhVnHahYnGZpX8yqqgJ05xxxDXaR
    m27zSpVJLx3P8TTn4XvL/Ru6rOTLUafLlaU5unEd0WuxJ346I6igkmzjnWu3F03Z4ARy
    PKhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791883309;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tOA1Xza/VKOE/F6G3qq1NQn6FEvAoR2TRmvvKSQZ5NQ=;
    b=1jVK4ehQiGp+1XQFYkw6lfALmfMQ0ktl3cbrb82brwzQmZX4IPufWS8l/bDXIdfs1N
    mniNjg3TUbkM9SNvlZDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29D9Ln58V
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 11:21:49 +0200 (CEST)
Message-ID: <47e7242b-ab71-4a42-924d-08f91dd35194@hartkopp.net>
Date: Tue, 13 Oct 2026 11:21:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
To: netdev-bot+sinfo@kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiale Yao <yaojiale02@163.com>
References: <20261013083523.4728-1-socketcan@hartkopp.net>
 <179188078132.2527009.11908657524993056251@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179188078132.2527009.11908657524993056251@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The issue was found by code inspection (LLM-assisted, see the
Assisted-by tag), following the syzbot report against the bonding
driver (syzbot+8ed98cbd0161632bce95), which was fixed by commit
8ba68464e478 ("bonding: refuse to enslave CAN devices").

team_setup_by_port() copies port_dev->type into the team device in
the same way, so a team master with a vxcan port ends up as an
ARPHRD_CAN device without can_ml_priv, and runs into the same
NULL pointer dereference (e.g. via isotp_release() ->
can_rx_unregister()).

The same class of problem (non-CAN netdevs claiming ARPHRD_CAN
without CAN ml_priv) was already hit by syzbot in the CAN core and
mitigated there, see 8aa59e355949 ("can: af_can: fix NULL pointer
dereference in can_rx_register()") and 0acc442309a0 ("can: af_can:
fix NULL pointer dereference in can_rcv_filter",
syzbot+2d7f58292cb5b29eb5ad), both with bonding/tun.

The IEEE 802.15.4 types were added by analogy during review.

Best regards,
Oliver

On 13.10.26 10:39, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

