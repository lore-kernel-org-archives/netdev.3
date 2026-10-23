Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792718201;
	b=xzSeTxfkQ0ARw+S1prwBS1wqznuC/Y/uVbpoPP62Vwj7DS9v6xPLp/QMHDedT+Y/LfWk
	 qvULFjxOYeiKi+YkdV7XcNbOBDKgbDPU0IN7XwfyVYN0kzxckrcuhmfSuQIrqC7wbeE8y
	 0lXq/HPA/AHMmGui4jMrQOXChkNbcIjkWKO6xohHhp/vDrJV7JHncT8SNL3cIaXJjG6oe
	 1TRdzKfBQZYF9PuxcN14x75ZVzoU7gdlw3nTgIUewZ9ycoG9olkBTTIHuatNyqOgaZmSW
	 3YuTfspEsBfBd/UBvOql0cP9gN+1czJODAhOMtnCWDDWKMez/9ua6uLNwndMb62QEWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718201;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AI1pt/WcFIVZ2zFt+hMNgvExr8+0haeAuHJ00CRqJFs=;
	b=Bc//Uy0FVE704K6nebCnelPcy1yRpnUfDhluIngRUV+RzpDSOc7m34xEmvciRrHSTKxo
	 Ndci8RkzyL4fa2fmm2wL/PN7cbOITDCO+UUYT22brylgGGCA5RGyWnd7DR6M9P9ApdpIW
	 bZE+0lvxLlRV7VxMj142lfw1K25+5K9x1K4eqGCQ8tjYVwhX6qsJR9MQ3VY73JVue1Oyv
	 nWi/wnD73ZNZMKbKmXEloKVMJPIoDETpRIs5LgKiXDQLKv0AZAnDqj9TNKRcn80roRHmB
	 5Hf8zta4cW4rT+xsGSU09tpM7eIYYshj26huLYBWX/OW6uFbCU+qnbtJ5gkAH747MHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsTqwc0c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEC606A31A;
	Fri, 23 Oct 2026 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsTqwc0c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57EA1F01825;
	Fri, 23 Oct 2026 01:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792718200;
	bh=AI1pt/WcFIVZ2zFt+hMNgvExr8+0haeAuHJ00CRqJFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KsTqwc0caR7gAxojNOgT7cQYxyztYycQ97A56PdkiL4nuV6UIZUdBKUpWpopYsi0u
	 VsmxBfyaQVxNcVigy9pMsXKd8GUyw7zxddUGEUxVISGEJsqPodJ7eAzgIcL839mZHM
	 23e81yJHsLF+Hefc6Y0CIAP0H639ThCfFIbX4voxst6hnLYJTOOg3/h0jI4C4y28dQ
	 kA73+z3xd9J1QG2SYoYgIBqhcklpUEWHas457kxUhavOc1rTRD7xIDSY9vLzsNV1SM
	 Ea+UGPcsPswN/dPAlOcT5SGfTMFdHm0qSxxIPsdBcJqysQmUHz2vd/6ketNZ/0cHc/
	 2uvaq82fxr5Cw==
Date: Thu, 22 Oct 2026 18:16:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Dharmender Garg <dharmender.garg@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, Ramakrishna Koduri
 <ramakrishna.koduri@broadcom.com>
Subject: Re: [PATCH net-next v3 5/5] bnge: make NQ0 persistent across
 open/stop cycles
Message-ID: <20261022181639.1815c338@kernel.org>
In-Reply-To: <CANXQDtYjxskxm11cGVV4QbnTjwStwJ5ot-5Kg+P+z5L0pOL5Cw@mail.gmail.com>
References: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
	<20261013200645.1346299-6-bhargava.marreddy@broadcom.com>
	<20261020133444.3395670e@kernel.org>
	<CANXQDtYjxskxm11cGVV4QbnTjwStwJ5ot-5Kg+P+z5L0pOL5Cw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 16:27:42 +0530 Bhargava Chenna Marreddy wrote:
> What I propose for v4:
> 
> 1. NAPI for NQ0 is added in ndo_open and deleted in ndo_stop, like
>    every other NQ.
> 2. NQ0's IRQ stays requested across open/stop:
>    - When netdev is UP: The IRQ handler schedules NAPI, which handles
>      Rx/Tx, async (including link), and HWRM events.
>    - When netdev is DOWN: There is no NAPI instance. The IRQ handler
>      queues a work item that handles async and HWRM events.
> 3. Mode switches happen only in open/stop, so only one context
>    consumes NQ0 at a time:
>    - open: quiesce the IRQ, flush the work item, then enable NAPI.
>    - stop: disable NAPI, then allow the work item again.

Sounds reasonable (please note that net-next is closed now)
