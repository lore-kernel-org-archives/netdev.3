Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2ED3B28D;
	Tue, 30 Jun 2026 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859610; cv=none; b=OL+Hve2pq7CVBELtNWXQCgL3zBtye3Y2TzgSZ8R7Shq/gp6GQpuQsJImnshqjYQMDBE/yuTxuWcr7aJENaKguEHHUpcwmd5m/7T6CY+pD3105eQ8pJ0jfK0ZxfNdF7jinduO1rCwOnQgbp7ETvTqMvryP+acq2igzZGLU+zlfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859610; c=relaxed/simple;
	bh=FROwpH6Y3qlVODMRVKnqBYvr1RAog2Xgprwy+idhyl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8r4fE8/xiaC4786MqlTJJlB2lX7gh6CdUdj/3MXN2dkEcJ3zIcYMr2KQP+uTOPUn7PcxQbF4BUPdLfOM+kcrE2u5SRUso19mtj6vjU+SAzQKtaEcXBsun8nhxmfzGkmogxdFLmqINb9t0cUFVZ+NoU8nd2cYDwXY8jk5Zv9cQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl31WKCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl31WKCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1DC1F000E9;
	Tue, 30 Jun 2026 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859608;
	bh=BO046DVHNPdd/bgH1yTENuqkNaD/sSQ5B6EfYU624G4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pl31WKCQkImCBYh5v4o9YGO3jdmwb7uQsSapjk7EA+o6ivd3fAaXgqCE7TW70QN+c
	 uMo1l587AgNlkG+KCDOKkzqJSfEbbcz+9MDTpk7eS2HBaAX5BVKdbQ56Pq0XfvmoCG
	 3Pd5hHrsIWjjKV3ci+h+uytMtqxeF+3OAoI3ndMct90vCNefqFzQ6ARJbsSP49aKBs
	 NtCHjDlSGmU2Vme6Zxg+o/+V0CeQvNHk3kWl4OS6IuwVhuYnEvpHYHRDxtoxX263XO
	 cFXO/B5e4Kj7ad7lolUQANo85ysLXCSCahNxAUX6SeWbWb06j9mjWfhOv+GgOyKYsw
	 KvEwr+LqfRG4Q==
Date: Tue, 30 Jun 2026 15:46:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Message-ID: <20260630154647.468076db@kernel.org>
In-Reply-To: <CYYPR02MB9828DBA5FD39F4DB45FC890A83F72@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
	<20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
	<20260629191553.0a305168@kernel.org>
	<CYYPR02MB9828DBA5FD39F4DB45FC890A83F72@CYYPR02MB9828.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 04:16:24 +0000 Selvamani Rajagopal wrote:
> > On Fri, 26 Jun 2026 08:35:18 -0700 Selvamani Rajagopal via B4 Relay
> > wrote:  
> > > Threaded IRQ uses waiting_tx_skb. Transmit path also uses
> > > this pointer without any mutual exclusion protection. As a
> > > result, it might leak skb buffer, particularly threaded IRQ
> > > runs in the middle of tranmsmit path, near skb_linearize.  
> > 
> > Can you say more ? only xmit sets waiting_tx_skb, the IRQ
> > clears it. So why is IRQ racing with xmit leading to drops?  
> 
> I believe xmit path and IRQ thread would run in different kernel
> instances. Imagine oa_tc6_try_spi_transfer call fails in threaded
> IRQ. It would set disable_irq. If xmit function didn't see that when
> it checked, but it is set before placing skb buffer in the
> waiting_tx_skb pointer (due to skb_linearize for example), the skb
> would be stuck in waiting_tx_skb.

Perhaps, but wouldn't that cause a stall not a leak?

Please do your digging and submit high quality patches which don't
require research. We get 150 patches a day in netdev, and all
maintainers have day jobs (contrary to popular belief)
