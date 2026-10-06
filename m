Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800654704E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319155; cv=none; b=JvwuDB9Vi7BU0oOp7Hc+GJrwYoeJ0zV+XDA71QLIuyFZC66PIddBSLiVrN75zBm0CDDFFm1jWwF/7kindz42L0M7dZ0AMXhw8Un+nZOvCloUy3pbCbub3th+AW2C6eRS0MUkkZBJB+G2NJXBZlx8VBbxtvh9Bc2s7GLjrQ7OnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319155; c=relaxed/simple;
	bh=o19kFJGijJj60gdr7RSyopbn5XjaNrsO3gI7nIihf6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHSkBGek6jXpChOAN8ZPet+Lmurs1ghyugjG5CSpIkryI1j82wVacNuleNEx2Vj+Tt72OxpXHQdRa5zMReu2Gttu+hskhCVSJuxpkCs4kg9tKOAbDSwmjAVEUNSVPN0Nn5XxEUOvxLs10RATYhK1xiOJus8vjO+4HfQdjnEgmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0/k+9WFF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JYCwzH48; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1ZP/p+d6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mjeTAAqs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0/k+9WFF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JYCwzH48";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1ZP/p+d6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mjeTAAqs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CE4D21F6A;
	Tue,  6 Oct 2026 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791319147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVI4A9/3A6JEFu/vTh52aKTFJnpkfCUSg89id/ibj1Y=;
	b=0/k+9WFF7xPdPTdKyEhMTrjpk3BM7iqhmC9SQsWxEbiWy0HBillwZL7h9HgdKJt70bl9hM
	9Y5VPbWUU98hlsD2gsrSRASBtvDb65Vw5KBSQhxWMq/fBLRDLYQZ6sWGseqnpAdnJZRuLn
	w5/gl/8zkITBqNuSSQhOm59wpXDxZVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791319147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVI4A9/3A6JEFu/vTh52aKTFJnpkfCUSg89id/ibj1Y=;
	b=JYCwzH48yXUtRHMAjZBQ2c0ehuIM65SHT/VNAlZjcnxdF5feK5qP1S0RRQuPtXaLuE1vJp
	w2PvXlY6sqahDfDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1ZP/p+d6";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mjeTAAqs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791319143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVI4A9/3A6JEFu/vTh52aKTFJnpkfCUSg89id/ibj1Y=;
	b=1ZP/p+d6lsm0HnJ0Wxisw0pg6gK7N2PMK7LV+8BTP6VJ+4Zp2cZaYxfWoA75iFR8cSeCdj
	W6dmvLpvWP/ae7OmKpcLdq6WupaxmGKdlvTkThuWnUbSx4CpMuQu4ZqA08aynvvAIwGCY4
	V4myHXP+hWdsFdjFzqYw/lGWtuXawqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791319143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVI4A9/3A6JEFu/vTh52aKTFJnpkfCUSg89id/ibj1Y=;
	b=mjeTAAqsTvQVFf5O1vhKgXMDBjr3bjTctSyyNktGmtbP8e3kTtnH+LdR2UQO9QwmpXMM3x
	WzU8VCoY+KDjSRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCA2B13B88;
	Tue,  6 Oct 2026 20:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uCwFImZcxWrPNQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 06 Oct 2026 20:39:02 +0000
Message-ID: <5b7be049-a9dd-4032-a0a8-ca677a1f93b5@suse.de>
Date: Tue, 6 Oct 2026 22:39:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 0/9] neighbour: Add IPv4/IPv6-specific
 wrappers for neigh_lookup() and friends.
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20261003212336.1304988-1-kuniyu@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8CE4D21F6A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 10/3/26 11:23 PM, Kuniyuki Iwashima wrote:
> syzbot reported that ip6_finish_output2() could pass tbl and dev
> from different netns to neigh_create().
> 
> When namespacifying neigh_table, I chose to resolve neigh_table
> in callers to minimise changes, but it turned out to be error-prone.
> 
> This series adds IPv4/IPv6-specific helpers for neigh_lookup()
> and neigh_create() that always fetch the netns from dev to fix
> the problem.
> 
> Along the way, the confusing and now mostly redundant helpers
> __neigh_lookup() and __neigh_lookup_errno() are converted and
> removed.
> 

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

> 
> Changes:
>    v2:
>      * Add Patch 9
>      * Patch 6 & 7: Convert __teql_resolve()
> 
>    v1: https://lore.kernel.org/netdev/20260930200326.718459-1-kuniyu@google.com/
> 
> 
> Kuniyuki Iwashima (9):
>    ipv4: Rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().
>    ipv6: Rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().
>    ipv4: Add wrappers for neigh_lookup() and neigh_create().
>    ipv6: Add wrappers for neigh_lookup() and (__)?neigh_create().
>    mlxsw: spectrum: Resolve neigh_table right before neigh_lookup().
>    ipv6: Use ipv6_neigh_lookup() and friends.
>    ipv4: Use ipv4_neigh_lookup() and friends.
>    neighbour: Remove __neigh_lookup() and __neigh_lookup_errno().
>    neighbour: Check n->parms->tbl under tbl->lock in ___neigh_create().
> 
>   .../marvell/prestera/prestera_router.c        | 14 ++--
>   .../mellanox/mlx5/core/en/tc_tun_encap.c      | 14 ++--
>   .../mellanox/mlx5/core/en_accel/ipsec.c       |  6 +-
>   .../ethernet/mellanox/mlxsw/spectrum_router.c | 77 +++++++++++--------
>   .../ethernet/mellanox/mlxsw/spectrum_span.c   | 42 ++++++----
>   .../netronome/nfp/flower/tunnel_conf.c        |  8 +-
>   drivers/net/ethernet/rocker/rocker_ofdpa.c    |  2 +-
>   drivers/net/ethernet/sfc/tc_counters.c        | 11 +--
>   drivers/net/vrf.c                             |  4 +-
>   drivers/net/vxlan/vxlan_core.c                | 14 +---
>   include/net/arp.h                             | 16 ++++
>   include/net/ip6_route.h                       |  6 +-
>   include/net/ndisc.h                           | 31 ++++++--
>   include/net/neighbour.h                       | 24 ------
>   net/bridge/br_arp_nd_proxy.c                  |  4 +-
>   net/core/neighbour.c                          | 11 ++-
>   net/ieee802154/6lowpan/tx.c                   |  3 +-
>   net/ipv4/arp.c                                | 26 ++++---
>   net/ipv4/fib_semantics.c                      |  5 +-
>   net/ipv4/route.c                              | 18 ++---
>   net/ipv6/ip6_output.c                         |  2 +-
>   net/ipv6/ndisc.c                              | 48 +++++++-----
>   net/ipv6/route.c                              | 23 +++---
>   net/sched/sch_teql.c                          | 15 +++-
>   24 files changed, 234 insertions(+), 190 deletions(-)
> 

