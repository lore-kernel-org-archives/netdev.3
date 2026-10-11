Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8E3DFC8F
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745834; cv=none; b=MSz/5pFLYM5ZNlXl5ozF2sA9NPvsnSVkv+Uxjj82HbGsRN/+or+qjI6dmTsbxkJoFv6l9vHgdWQUOgYb1/tiDWASkkegmPibJKk0TdZBAXeLQrSDkg7dsGbC8rwAP/+MHGbfr5hgA2IO3yWr/AH1AJW27Wu8KwXGVrAmvGhv3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745834; c=relaxed/simple;
	bh=sU9Roct/4igfgAFbcMoUw6dfgn7blPvT5WY9ccBDmW0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWXPKT0tC9Ek4Vxk+m+t/vVenJs8qaI02hIXwlZfOVvW9hrrqJ2iAI3H3Zg7AynB28HMgePLcvlsTw4/ufrveQ0SMpt9LF2J1crmToHDB8edrstn0MBiey/FVeukNPe7EQ82JH28EwLb/Ed379RnYM5QLl8h72ECmkwRjyVWTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=igDrXqGF; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="igDrXqGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1791745821; x=1792005021;
	bh=x6EmLqjczaoOOnY0OtXs4ILpMpX+CID6QuYRw0aI2pY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=igDrXqGFM6LLMJhh15Yd7vkCUQpKGoBzqUuzkPHww/IWekW4XM58rgUxHvRUIN8lB
	 /M3sUxgWZda2ieXf8Cr8AA8WtKkTFWpcscKTflkyx63Pz8WAYSmWgJSJMhtc9WlHzR
	 WsTlGa5GJ3kvs7Z47aX6Gq+RDqVbfBQq3bo1/HFV6F33aYSTbnTdmBsJ6pdlpH8Qre
	 R4ZFmUmNXfb7+0Ct8HCLHuta5rrgngwBajTGOcbLmmYC/UEOcP4riarFU/v+Tv70vS
	 1QGuk3DbKXFZXiL/iycutdeZWWhIzKRmVxBK2ldi9KJAlY+OLuUeM+b5yrJ+vtyW+n
	 1oQPAHZmj6hlw==
Date: Sun, 11 Oct 2026 19:10:16 +0000
To: Tony Nguyen <anthony.l.nguyen@intel.com>
From: Paul Moses <p@1g4.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org, florian.bezdeka@siemens.com, meng.ding@siemens.com, tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2026-10-01 (igc, igb, e1000e)
Message-ID: <mMaxNKLm65maLk-vyDFTIZaiiWb5oaJiDiUdaFJ2cDV7soxmyqbe1WuKt_n-oTUDhgrvG6YcO8Fbi1Qb0iUnoLKsmaFd58Njgcciz_VWQTs=@1g4.org>
In-Reply-To: <793c66e0-e672-4ca1-9757-069958f3084c@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com> <20261007190210.388650bf@kernel.org> <793c66e0-e672-4ca1-9757-069958f3084c@intel.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 93bbc890dc921cc54e735bd47a073b862faced72
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Thursday, October 8th, 2026 at 12:05 PM, Tony Nguyen <anthony.l.nguyen@i=
ntel.com> wrote:

>
>
> On 10/7/2026 7:02 PM, Jakub Kicinski wrote:
> > On Thu,  1 Oct 2026 15:24:33 -0700 Tony Nguyen wrote:
> >> For igc:
> >> Ding Meng fixes Rx hardware timestamp when NET_RX_BUSY_POLL is disable=
d
> >> by populating the skb hardware timestamp from the NIC's Rx timestamp.
> >>
> >> Paul Moses limits timestamp-header stripping to the first buffer of
> >> each packet, preventing continuation-buffer data from being truncated.
> >>
> >> For igb:
> >> Tjerk Kusters does the same limiting of timestamp-header stripping for
> >> the igb driver.
> >
> > these 3 need to be reworked
> >
> >> For e1000e:
> >> Jiayuan Chen prevents MSI-X IRQ leaks in IRQ error path.
> >>
> >> Pu Lehui prevents out-of-bounds MMIO access by rejecting devices whose
> >> BAR0 is smaller than 64 KB.
> >
> > applied to net-next
> >
> >> Tony adds Lenovo ThinkPad P14s to disable list for K1 to avoid reporte=
d
> >> issues with K1 re-enablement.
> >
> > applied to net
>
> Ok thanks Jakub.
>
> - Tony
>
No idea how my patch could be different.

The problem with igc is that the two timer design is not compatible with th=
e core APIs.=20

[38399.282683] BUG: KASAN: use-after-free in igc_ptp_rx_pktstamp+0x12c/0x19=
0 [igc]
[38399.282754] Read of size 4 at addr ffff8881c607b008 by task python3/2656=
9

I'd like to see how Siemens does their patch(es) before any followup
work.

