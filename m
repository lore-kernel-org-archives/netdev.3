Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15296518132
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989890; cv=pass; b=s9Z2xbUcJiImKbaPZXtfJV9OFKWIzC6pO4jOGpryUh8R3d9eFDhWl5BehWLhA6rKvqftoiF9K8G8v2T5C6SmuM6oa5zFY73EGKR5AV+0MyeMqrFolZLIp89vjDV6YN3btdxXmq3UhbxFM77YfookzNe6YzNiIBIUrHP46Xa5mIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989890; c=relaxed/simple;
	bh=oIEwSzF9zK/6XdTC3D+ryIhqXjz0AkZrZVc/89+pf6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CixwN+yvIeHdQqOVtWsurWh//mFUSgQ+rKkWODvuL4LjS6LQwwL9Xw5E+7B/7oW+MkVIgKI/lq8PyC+zOx80Eh1qU+DTLIS+JP9s2CYiM/OOErXTpTAhb6V9wa78nnvlKs8QaOmM5kUgWlXpGMS51HmKgSMdkhk+6lq7GBevUTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KCqTd9I+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g16/OB+V; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KCqTd9I+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g16/OB+V"
ARC-Seal: i=1; a=rsa-sha256; t=1791989868; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eETSyBGyBoSkDmeSeGkxIZV2m7CgJ6OE5zQRUSBiRYRAyqwt3na/AjJiYviI50D78u
    uj/G3WldPQgFLtewicx2atooD7BPjHO2sSbKo207RkSYBK1SRkIpphWZ9ItBKcnwl/Wm
    9UIrpILUldxYwDkWnN+sOJLPtLnWhxRGO7n/DUgk9XY2GLNG021+eVF9+DgLBKBsZHLk
    zCH+ZplHPgkBZgkkS6uGE/2W1v9Pu98AnAxaKnST9CFe8swNy9kBRze2ATsgfHp5KIrw
    r0eM7GAzWNezNjlcShNbq3TETDu1Ez+wwA1W0va5d5ryGmD6H7liWy/URcQ9XIVls2+6
    m6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791989868;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwhnwEJHExkgjKd9QsB/2ko8wE+WDrfgELKyL6/vU9A=;
    b=r+a/q0uIjVA/MADh0SxHn/3qLnM5qlgQy4jVaZzXTnk7epxOKEO8ZEmUhZLA9+lNxz
    MbppLH0r7lQ0HEoNon8CEe7MmMjtTwCmaHmKVMLNul+xrH/8cpbrUlxWL4fPULK4n23A
    oz5EI9WlCQzL/C3q+l4nInDdux/xHvhs3lpp/2iHIqu7DC5vWrf4me98g6pftb+/x6Ke
    Vg+xTk5RwrCetHdATm8rSocGGoNN85wBG64VKrPi18WYBh4iCV+q/oEzNqyXECQCdD21
    /1YGr0BJrcHlmFSn/0+b/n541DsNRFwbM8huDbOMLqiSG68jzT/Wqwy4BTAPDrwHRhum
    INiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791989868;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwhnwEJHExkgjKd9QsB/2ko8wE+WDrfgELKyL6/vU9A=;
    b=KCqTd9I+MeX/rrnlvLWVoaRtUE+H4Fju1S58tz63YvFhbDT430b06n82fQ466FxDAI
    zEdanYiDtM5URCB0LATsNLcA9Cc/mSVooFtfwgQbqA8fihjlHXpc/DQC7puWSbx23tCZ
    DHIfKaEJnDtJ38nBCdeXnr9cOCnwNEVmFEyNF9O3HsjpmnqeDN/5Kw1pdWXohIirEdqo
    UykdO7GAaYv1TjYG/d6/CQ0gi4jLy1uHGj7QGvP2zs/6lqBmfX6Nh1l0RAlnnh/SjyW9
    fN3PkWShmcfpNGazH8Om8/7I07S7xZe7d5R+ATv9oVCL8W3k1nPj4CAOH8GirBC5usrB
    xOPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791989868;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwhnwEJHExkgjKd9QsB/2ko8wE+WDrfgELKyL6/vU9A=;
    b=g16/OB+V2TQmWql87Oe+teGWtqV2ASsqbkT0LlegqTRoFQ3/HYBq+AMwVhwfMsw6qv
    SxfHVZM5LsnJPb4nOrDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29EEvlDip
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Oct 2026 16:57:47 +0200 (CEST)
Message-ID: <84811273-499e-45a4-bede-88bc6dcc5ed9@hartkopp.net>
Date: Wed, 14 Oct 2026 16:57:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] team: reject CAN, IEEE 802.15.4 and 6LoWPAN
 devices in team_port_add
To: netdev-bot+sinfo@kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiale Yao <yaojiale02@163.com>
References: <20261014143309.284388-1-socketcan@hartkopp.net>
 <179198901397.399038.11366807934508541241@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179198901397.399038.11366807934508541241@kernel.org>
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

The IEEE 802.15.4 and 6LoWPAN types were added by analogy during review.

Best regards,
Oliver

On 14.10.26 16:43, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

