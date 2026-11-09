Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210807;
	b=RhcaHec9N3YqfVz/Jse93rdccc7ukH1kfLE2BcJMAX0cflb9/v1Snx1bo16DDGgzQGFl
	 9r8GJfJi7us8/gnMa9NjDoGSt8csN1Ytd4uyEf7KGjrDk0qM20GUwDSYgxT3sM0vwlbrW
	 2JELBrO7/M4pBe3gPjtNj62Q2JcNoyeffOx5mlAegKH2FxpWVte21QSlWnv3wUbtGoT2a
	 ZYQPJ8IzfCQIySZz6ZZXUFVq7X9TNjxfUUZeHLBMGwt96hohn+pjZ4owq2RQDi1x30ih2
	 Ua5ilHdCJU/dUdxGAgs37Lpx/WHM1hiW2qAG21SGon+YiqOAJz6oSSzILy6geR890tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210807;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3yBBfB6jMcfNdtm/O48GRKX5xV2g1TjahrGp1n1Q4v4=;
	b=vBlIa8M4T5cbzJgdoFh0flVjJEYl10SlMlVgOT2eDT1cW8RqEKH9+tNz+tU82Y4wlAb2
	 qR0H6fnTrOAhjGAPpr4SQIzzkaZLEcsK63blm5zyBqdMhd5wL8NpGYfpC+04AjkH+s7+h
	 R2FXXXEPHxnvu9K0rhByWEr7PW5smAHeCxsY92QXl86sV52qEW7f5xPTuvMka8beA/yjD
	 ONFZr5o37UWHpMZNVUgS+hEqED3gMgRzvledaIFvtms13ZbqxIBehaIeOPnlTVfhggQzT
	 7jgO+ELVUOvKsIvu6hrGuBWvmWZzJ3woW2k97gMxn2G6Bp26pwaznIaM3Tbym0K8ZiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=0HL8lueG;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A9606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160A9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=0HL8lueG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794210814; x=1825746814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FkyW4iYoZwy4J/GBLQsUQrSOYRhDZAiwv3CgK4G4e3M=;
  b=0HL8lueGx+Cp8kgFVrWf3jE4DSrivNuF+OsFvZ9BCtafrf3y8I//WslX
   F9b0D//el4FLonv1mixYW7oLDTS9e1OxL1PtLm0c5xsTUoQjDnV5U6Ovp
   MQkOszdd0GG7XHK9CTwNioQquhBjDLot4PKPC4uEakO437tqpW9JD9yg7
   KPNewIaIyJnm7+edJ7cxPea3X4f9MXqzbUWz/QQ4DonKOwxywjAvT+y+M
   ouBwK3sQlvjL8jQi0JpBDc220cOMxmAJoJXZAGjdXuol9vhR7ka+nQqt8
   Of5LYLGUizLJ3nsmwGSkM/Temia+OOJxb0CJTPOAdDXvkfBgu+gfZK0ql
   w==;
X-CSE-ConnectionGUID: 9y7/IvHASjGj8qNAl1Au8Q==
X-CSE-MsgGUID: CkIhaKF1SWWhkFuNbHswMw==
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="66464273"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2026 00:53:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 9 Nov 2026 00:53:19 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 9 Nov 2026 00:53:18 -0700
Date: Mon, 9 Nov 2026 08:53:18 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <memoriaru@foxmail.com>
CC: <netdev@vger.kernel.org>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <79190669+memoriaru@users.noreply.github.com>
Subject: Re: [PATCH net 0/2] net: sparx5/lan969x: fix RX ring stall on frames
 from inactive ports
Message-ID: <20261109075318.b33ulhk4hgscftjv@DEN-DL-M70577.microsemi.net>
References: <tencent_ACC296C1F221C304053BD0F1F4B0D2C2BA06@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_ACC296C1F221C304053BD0F1F4B0D2C2BA06@qq.com>

Hi,

> From: Zhang Hewei <79190669+memoriaru@users.noreply.github.com>
> 
> The FDMA RX path on both sparx5 and its lan969x sibling stalls the RX
> ring forever when the hardware delivers a frame whose source port does
> not map to an active netdev.
> 
> In both drivers the RX NAPI loop only advances the software cursor
> (fdma_db_advance/fdma_dcb_advance) after a frame has been successfully
> delivered. When the source-port lookup fails:
> 
>   - sparx5 (sparx5_fdma_rx_get_frame()) logs an error, flushes the
>     extraction FIFO and returns false without touching the cursor,
>     leaving an skb_put()-extended skb behind in the rx->skb[][] array;
>   - lan969x (lan969x_fdma_rx_get_frame()) recycles the page and returns
>     NULL, which makes the poll loop break without touching the cursor.
> 
> Since the DCB still carries its hardware DONE bit, every subsequent
> NAPI poll picks the same DCB again, takes the same inactive-port branch
> and stops again: RX traffic on all ports stalls until the driver module
> is reloaded. sparx5_xtr_flush() only drains the QS_XTR hardware FIFO
> and does not clear the stall.
> 
> Patch 1 treats a bogus frame on sparx5 as consumed: free the skb, clear
> the array slot and return true so the NAPI loop advances past the DB as
> it does for any other received frame; the slot is refilled by the
> dataptr callback when the DCB is recycled. Patch 2 splits the two NULL
> meanings on lan969x (allocation failure, which keeps its retry-later
> break, vs bogus frame) and advances past bogus frames in the poll loop.
> 
> Found by code inspection; the stall needs the hardware to emit a frame
> with an invalid source port, which cannot be triggered without hardware.
> Review from someone with access to sparx5/lan969x systems would be
> appreciated.
> 
> Zhang Hewei (2):
>   net: sparx5: fix RX ring stall on frames from inactive ports
>   net: lan969x: fix RX ring stall on frames from inactive ports
> 
>  drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c | 18 ++++++++++++++--
>  drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c          |  9 ++++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.5 (Apple Git-154)
> 

The fixes looks legit, but before going any fruther, theres a number of issues
with the series as is. The patch bodies are mangled (a blank line after every
line, no 'diff --git' headers), and 1/2 and 2/2 are not threaded under the cover
letter. Also, the noreply GitHub address in From/SoB can't receive mail.

/Daniel

pw-bot: cr

