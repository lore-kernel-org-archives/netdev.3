Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76B3845A7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791424932; cv=none; b=qXsmGkTSNTTOCOhGg6+jeuHCQde7e2zcNbgMSExRc1e99DIUoHErZI9ap0UdPWPnmkVP0baDAD4NwRU2vu5/HpNjdIpWiKTjjrtBhfzaDwLHyFAejDzFmCPQCtmLbAYgsshDVNQwW/9ejOay4l7PX5gvhhnOjSU4JbJmvMnWVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791424932; c=relaxed/simple;
	bh=o4tV/jHa98x9IH+4/YaR0GZiHLs86O4NUae0kGloM+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDlyOB60NC63mnTZ5a6nT1G1qvk5dhOxAsXHMRoERGFSQ7Q/b14Nw9uCfrueOIUPcdxaLXLkOhTMTfdZbyw8U0tnDvp03iyLWYD2G27SwDegmjtCkOcE3StgYTGieKxHYbMqUYcKQBNo2J5UaWs355G3R7CVKy8QtqrxUGmz71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUzf0r5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUzf0r5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7801F00893;
	Thu,  8 Oct 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791424931;
	bh=LZrezZvifiNRn2BObm2c9lk4LR+ddAtvFosDxUywPtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MUzf0r5S4paFUl12LttiAemYuZIMvYvTYGfTUzmwtt2i+bWh3gnJ6KQRU6DQsEFtk
	 JLfaeSZB3Gihv8IsdUjnMFia8a3Ryael22Krv33sH3Lsms888CumnIhzbsHkVPEMQR
	 l53oLdQoUEFMS1IprQqSXnJscXjD3DXaHlII5x0/lqSEZPM58RGm9U96lutadi/Kr0
	 X6nw338aWRI0vt51PP4peNqkBlyWz5TrJNv5gudpE5aZsyiQeobb5hiwkiIXJHBOeT
	 LQdzvK63VtlsLFGJWdcZLGHDHsi8GuRDB89/Hb9HUYjfopJyiOtOqRdgHmVy8e/UXU
	 RQdgFu4HiAIUQ==
Date: Wed, 7 Oct 2026 19:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, florian.bezdeka@siemens.com,
 meng.ding@siemens.com, p@1g4.org, tkusters@aweta.nl,
 jiayuan.chen@linux.dev, pulehui@huawei.com
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-10-01 (igc, igb, e1000e)
Message-ID: <20261007190210.388650bf@kernel.org>
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 15:24:33 -0700 Tony Nguyen wrote:
> For igc:
> Ding Meng fixes Rx hardware timestamp when NET_RX_BUSY_POLL is disabled
> by populating the skb hardware timestamp from the NIC's Rx timestamp.
> 
> Paul Moses limits timestamp-header stripping to the first buffer of
> each packet, preventing continuation-buffer data from being truncated.
> 
> For igb:
> Tjerk Kusters does the same limiting of timestamp-header stripping for
> the igb driver.

these 3 need to be reworked

> For e1000e:
> Jiayuan Chen prevents MSI-X IRQ leaks in IRQ error path.
> 
> Pu Lehui prevents out-of-bounds MMIO access by rejecting devices whose
> BAR0 is smaller than 64 KB.

applied to net-next

> Tony adds Lenovo ThinkPad P14s to disable list for K1 to avoid reported
> issues with K1 re-enablement.

applied to net
