Received: from a9-107.smtp-out.amazonses.com (a9-107.smtp-out.amazonses.com [54.240.9.107])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7803A2549;
	Fri, 10 Jul 2026 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715194; cv=none; b=CYhHBOyevxArrfaDTTK0QB+qMKiZNRJFvTNgcekceqxjwhJTrs1yuUrIa7AhSdpytztT7qTS667eGczM1Bd7gvzxRZUXBYJNgx/51/ypmktKo+8BbW6FwITa5Kg9LICQ428VXO0taQhOS7BQy99jT0E2WhojGpxuK+E9TzW6YG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715194; c=relaxed/simple;
	bh=ar5RGU6olEWKtUlD/snRxZGdlh4P/diNblKPURYIg3k=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=jpvlkezL6zwHLmd1qMm1scZtqmnzDy3sJKtP8SKNajj2DLyWGGk+dsKkVXhLv0WpkgFcD9b67UeaH5z0Suj4errn1bZrh+A6U3S9GFR4xG47uTyyA6W1OqtWxkhGt2J3lNN6a3d52H79aVHHbAuBRxb8XS8i+3r8LHvdZghQ4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=CsPlirZG; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=eSh+Ajj8; arc=none smtp.client-ip=54.240.9.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="CsPlirZG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="eSh+Ajj8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783715192;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=ar5RGU6olEWKtUlD/snRxZGdlh4P/diNblKPURYIg3k=;
	b=CsPlirZGQ3zA0COMewEt+wh/pb8M35u/PEadNXFDzQu4E8VaPbDvSKPxJzCKfysz
	KaKwQI8Cz/jPBTVlDZ47uI4xx5QXKn+Xdgouyy2n/ZXaTF2ZF8lr2y60Q514Pl0uGp8
	pihZavZb1LFMXV4cJxtsGLmfRHRcXFdhPzZW+IOo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783715192;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=ar5RGU6olEWKtUlD/snRxZGdlh4P/diNblKPURYIg3k=;
	b=eSh+Ajj8CFVIvtuqI9oBxyp20am10efGnYf7M7lkjxBkqvS7h6g7q+TyFH75tNCS
	d5qktT55VZpbdwTblWyBftipEe6zKcc0rdtsynZGK+IQu+1QDKU9NnzxeI3vixb6IH1
	LMy+Vs3GgCdm1E7davvu+pFJSG/k654i9jUbGzSc=
In-Reply-To: <be5c2567-1b1a-4155-8577-cd9ad50500bf@yahoo.com>
From: Johan Alvarado <contact@c127.dev>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
Message-ID: <0100019f4db5db81-aeb03b7d-b9f4-49c5-af28-b011514e5351-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jul 2026 20:26:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.10-54.240.9.107

Hi Mieczyslaw,

On 7/10/2026 9:23 AM, Mieczyslaw Nalewaj wrote:

[...]

> I think you should make limiter initiation dependent on whether
> the port is assigned to CPU. In a loop, check if the port is CPU port
> and set limiters for it.
> This way, newly added systems with CPU port 5 or 7 will also work.

I considered this, but I don't think the CPU port is the right
condition here. Whether the limiter needs raising depends on the
port's attainable line rate, not on its CPU role: the reset default
of 0x1FFFF (~1.048 Gbps) only becomes a bottleneck on a port that can
run faster than that, and in this switch family the only such port is
the SerDes-backed external interface (physical port 6) in HSGMII
mode. The other external interfaces are MII/TMII/RMII/RGMII, which
top out at 1 Gbps, below the reset default - the limiter cannot
engage there, so a system with its CPU port on port 7 already works
today without any write.

A CPU-port condition would also miss the opposite case: if the SerDes
port were ever used as a non-CPU port (say, a 2.5 Gbps cascade to
another switch), it would still need the limiters raised, but a loop
over CPU ports would skip it.

This also matches the vendor driver's behavior: its switch init
raises the ingress and egress limiters unconditionally, and only for
the SerDes-capable external interface (physical port 6). It never
touches the port 7 limiters and never conditions any of this on which
port faces the CPU. Physical port 5 does not host an external
interface in this family at all, so there is no system with a CPU
port there.

On the driver side, every chip in rtl8365mb_chip_infos declares
SGMII/HSGMII only on external interface 1 / port 6 (the SerDes mux
only routes there), which is why the series keys the write on
mb->sds_supported and the fixed SerDes port. That gating also keeps
the QoS registers of the chips without a usable SerDes
(RTL8365MB-VC, RTL8367RB-VB) completely untouched, which I would
rather not change without a functional reason.

If a chip with SGMII/HSGMII on a different port is ever added, it
will need its own chip_info entry and SerDes bring-up work anyway,
and support for its rate limiters can be added then.

Regards,
Johan
