Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBB4C33E0
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978625; cv=pass; b=dchdztFzpaUL7kahFVqIrCwRRG3K+omBGHXA2jsFNsKL0V9riJCRgcTwwa99ZgKhut6wfylHjv4WIA17BG/kOZjOT/mhy2DgxVAJoLs/Sb0F8FjBpl+rO0ldywJ23ZaBkNgvZ1POJUIurTvC3iot4HzSDVJa1X7dKwVN3YcmmYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978625; c=relaxed/simple;
	bh=dHeKYurqzofInKoRbt75dzYOQ5k0RypvBTplfguB9nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EilCNM67avvi6CpYfD8HnxOOFCLjVVbVBDXKftlqo8FYlUvkRBWBOz2ROIu/xFkgiSiTfetgX62WXCCpn/lKkAemX2LfcIamcQL2RKfOsKVIgTTOHakIC9C1tYPg2THG4u3oBrUPqRHzlrLsrfousc4dm5/yS5tkYdbrXti432I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U+GpgHnt; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yVopqXe0; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U+GpgHnt";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yVopqXe0"
ARC-Seal: i=1; a=rsa-sha256; t=1791978596; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tOBHYVrYxDy4fqY8w+atMaC/qEFasMZF4nCjYAbiEbXeUdbdJjZrfGf6Kqysgq1ZpX
    6uWoIhaMUR/50BBOyfZUPkhyMKWjBvwTaq67NtIvtTMlgEXumhyIojp4wcbvE0V6Q4ed
    NtW77VRwCNhEdyX40xLRmC/OyYNiQoskDOniswXO/KU/FwejOt/GDdHCjdEvMkLJW9Wm
    +RT7CHxShk5enOA5F39eTb5wtbMotBFg4gYUg8msY7kquMoKq5rFMh7AnkfDDD4RZwNm
    79Wga83a0u7YPUwwGvtvtunmQ3ZyBpugjJ4LV4//LwjPIrvvkG1Dv8D9eGL3+lu8PFEG
    9N/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791978596;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0ES7tvd9XAx0+7cgXT3ziY8LvqKP/8Evm0pJvG0okew=;
    b=TCr9dIC72YHhc1kJo4yxj+lOgCIf47fh5+D7czWOJ1QUR5PmsoRtZJPt1bOXteFFOM
    AyobhtyzlEKNcGCefN6J5huJ6/W2NIJZXiMx0vs1LUX1MLdkzQy2c6SbhlDxUFGxIukq
    EY6ZffJ8p58UIIPjM2g2DOn4EuzMjH/so1aYKkFR1ctxJ/gv/J2HjWp99MZMRiEwQ3GC
    a8kiGBdx6XGd8cwNbf3Sva3F+yCbfE7yt1rBUt+7MNkYPXqbausNZ5NAgBDFWsi1xRQd
    hGto684qJxIhAo+zoXkffoQuTUDnv5UZsOYpDgJ1KZvznvLI0m3j5Mqpmgz8N9DE/4y/
    Dxdw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791978596;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0ES7tvd9XAx0+7cgXT3ziY8LvqKP/8Evm0pJvG0okew=;
    b=U+GpgHntJxB5rAznYVhpIsRzgxDp9nW2ta2ofZF61V04ooS2lhHP91r/aaSsHmrG9e
    jMIr/LWEec+DgYrJoIdUFPEIDh/a9hZQHJH7gWkxxy9UNNQ58jzVj54v/N6m1apIGH06
    5iyXcZg6MNb8xmuPRzHGsHtJrGtRWqXpsJogYdT2E0N6UhFP4ZKzmFgdrLNwGRZ0buXh
    toHtGny/iZeyXb6fYMIUmzj06JgT2bemczcBVTOqnRGysBuCtHNni19tEXkXBdE1+jAY
    7dmLdQYNidh7YN+WpimytwTuBexr/r5lWMXew874E0GpNmrUxUenEacbRziZPjxorMoW
    fEMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791978596;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0ES7tvd9XAx0+7cgXT3ziY8LvqKP/8Evm0pJvG0okew=;
    b=yVopqXe0e6xKdnNWTCSK/LXaA0yD+wQfu3yQDrNUMb3+Tlma34aRFUIHytEdPjf8bj
    pMptrMvNpR3ssLB68HDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29EBntCep
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Oct 2026 13:49:55 +0200 (CEST)
Message-ID: <bf99c42f-92eb-4e4f-aba4-1aeda5b84f65@hartkopp.net>
Date: Wed, 14 Oct 2026 13:49:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
To: netdev-bot+sashiko@kernel.org
Cc: jiri@resnulli.us, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, yaojiale02@163.com
References: <20261013083523.4728-1-socketcan@hartkopp.net>
 <179196707247.434549.3372737964220312421@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179196707247.434549.3372737964220312421@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.10.26 10:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new denylist in team_port_add()
>    (drivers/net/team/team_core.c:1228-1236) only rejects ARPHRD_CAN,…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the bonding
>    driver, which the commit message cites as the precedent being…
> 
> --
> 
> team: reject CAN and IEEE 802.15.4 devices in team_port_add
> 
> This patch makes team_port_add() reject ports of type ARPHRD_CAN,
> ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR. Team never sets up the
> private mid-layer data these L2 types expect, so enslaving one leads to a
> NULL pointer dereference. The check mirrors the CAN check bonding has had
> since commit 8ba68464e478.
> 
> Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
> 
>> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>> index ca75f08e3c593..5f1708c2a3445 100644
>> --- a/drivers/net/team/team_core.c
>> +++ b/drivers/net/team/team_core.c
>> @@ -1225,6 +1225,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (port_dev->type == ARPHRD_CAN ||
>> +	    port_dev->type == ARPHRD_IEEE802154 ||
>> +	    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
> 
> [Severity: High]
> Does this list cover the whole class of devices the commit message
> describes? ARPHRD_6LOWPAN devices still seem to get through
> team_port_add(). Examples are lowpan0 on top of wpan0, or a Bluetooth bt0.

I'll send a v4 covering ARPHRD_6LOWPAN too.
> For the first port of a different type, the call chain
> team_port_add()->team_dev_type_check_change()->team_setup_by_port() copies
> the port's type onto the team device:
> 
> drivers/net/team/team_core.c:team_setup_by_port() {
>      ...
> 	dev->type = port_dev->type;
>      ...
> }
> 
> At that point netdev_priv() of the team device is still a struct team. None
> of the NETDEV_PRE_TYPE_CHANGE notifiers seem to refuse the change here. The
> team device's inet6_dev also survives it.
> 
> The global lowpan notifier checks only the type and the inet6_dev before it
> writes through lowpan_dev(dev):
> 
> net/6lowpan/core.c:lowpan_event() {
> 	if (dev->type != ARPHRD_6LOWPAN)
> 		return NOTIFY_DONE;
> 
> 	idev = __in6_dev_get(dev);
> 	if (!idev)
> 		return NOTIFY_DONE;
>      ...
> 	case NETDEV_DOWN:
> 		for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
> 			clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE,
> 				  &lowpan_dev(dev)->ctx.table[i].flags);
>      ...
> }
> 
> When the team device is set down, would these 16 clear_bit() calls write
> into struct team? The exact offsets depend on the config. On a typical
> x86_64 config without spinlock debugging, they appear to hit:
> 
> - notify_peers.dw.work.data (the pending bit)
> - notify_peers.dw.timer.flags
> - mcast_rejoin.count_pending
> - mode_priv[0]
> 
> The last write lands at about sizeof(struct team), which is just past the
> private area.
> 
> On NETDEV_UP and NETDEV_CHANGE, lowpan_is_ll() also reads
> lowpan_dev(dev)->lltype. That field overlaps team->pcpu_stats.
> 
> Would an allowlist of supported port types be more robust here than a
> longer denylist?

No. We had that discussion already on the ML.

team (like bonding) intentionally supports non-Ethernet ports via 
team_setup_by_port() (e.g. IPoIB), so an allowlist would regress 
existing users. The denylist targets the L2 types whose stacks rely on 
type-specific private data.


> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. The commit
> message says this change mirrors a bonding check, but that check only
> rejects CAN:
> 
> drivers/net/bonding/bond_main.c:bond_enslave() {
>      ...
> 	if (slave_dev->type == ARPHRD_CAN) {
> 		BOND_NL_ERR(bond_dev, extack,
> 			    "CAN devices cannot be enslaved");
> 		return -EPERM;
> 	}
>      ...
> }
> 
> Does bonding have the same IEEE 802.15.4 hole? For a non-Ethernet first
> slave, bond_enslave()->bond_setup_by_slave() copies slave_dev->type onto
> the bond. A wpan device appears to pass all the remaining checks. The bond
> then ends up as ARPHRD_IEEE802154 with a NULL ieee802154_ptr.
> 
> ieee802154_get_dev() filters only on the type before it dereferences that
> pointer:
> 
> net/ieee802154/socket.c:ieee802154_get_dev() {
>      ...
> 		for_each_netdev(net, tmp) {
> 			if (tmp->type != ARPHRD_IEEE802154)
> 				continue;
> 
> 			pan_id = tmp->ieee802154_ptr->pan_id;
>      ...
> }
> 
> This path runs from bind() or connect() with a short address on an
> AF_IEEE802154 SOCK_DGRAM socket. ieee802154_create() needs no capability
> for SOCK_DGRAM.
> 
> Once a bond has a wpan slave, could an unprivileged user oops the kernel
> this way? Should bond_enslave() get the same IEEE 802.15.4 checks in a
> separate patch?

Yes. When this team patch is settled and shows up in the tree, I'll 
create a follow-up for bonding for those 4 exceptions.

Best regards,
Oliver

> 
>> +		NL_SET_ERR_MSG(extack,
>> +			       "CAN and IEEE 802.15.4 devices can't be added as a team port");
> 
> [ ... ]
> 

