Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92680511E90;
	Wed, 30 Sep 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792982; cv=none; b=UZu65sWkIr/kJaygxntqxiobfGteFwC88NhZgRwOZSlyylk6KuewbFTNQ5CDeOuqZxOG7aVUMNhaYFRJYLMWUny+eu3bgam97nVePxiFKXx52x1bf7JgZtrCxOp2XP0svMd1wKevjVAC07viTIvI0fhjqlAN/fYlHpEoBD69QJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792982; c=relaxed/simple;
	bh=W7b7fF+CcCWziV12h9ZawqHaoD5h7WS7WPY2/C/oS+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vA0xM7SvH1kKEdnJBcIpLn49eQm1y0Ivhb0OChrXDYh5UQuobxNMM/Vj1Bl+oR32GZfGbebuDW7a84aa1Gch2RwtQ/PThckNIqez8ljRXVUDZ3atPsPLwk29/TT12bSlLciaol1j8b8Q3nvMxU0uhnnT/VWxNsdDSD8eM6IXVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KRIlOpAc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KQIIET6G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KRIlOpAc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KQIIET6G"
Message-ID: <d94de82e27e28b18320f31e2690cb85673832411.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790792978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMowwEW9SgkF7w5iLzPCCh27f7/yKSZJ5Waoj5oObuQ=;
	b=KRIlOpAckpwNf3q4te5d7Z8BCFFcVbx877vgc+0iol1UniyUDYFfSbCbNNEOB+trELQ/bH
	owT3pVxnvErc3k4uC6fstJzGlcdm9icAFYJSqy4gVH8+4yH9NyOwni2vu5Ju+VBcqElnI0
	/IKOvhjD5P2r69HPMpAZE69bfXzILHALY4d2tmHQiGvUGpa5oATOZhq9Zqo/jGlcQzITUC
	WRT4GAAx0M9qUdjyFXE4xqtYyiPFiV1yV46qXUWFqX4xbezCRmEhNXyy/2kQEgUue/nRU+
	Gy9fEIhhFUBqiBeJ8BQxfi4aIcC+CE7I7ItcREheXlEkbg5KNuzgH5OuBUUugA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790792978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMowwEW9SgkF7w5iLzPCCh27f7/yKSZJ5Waoj5oObuQ=;
	b=KQIIET6Ge8hjgDvhQFH5obMl7TV9T3erMZxyR46oBTskqn7DoUFQKOt5SAgZUUivJgRGZG
	Qoikwf7M2WYDrDAQ==
Subject: Re: [PATCH net-next v3 8/8] net: dsa: soce: Disable unsupported
 hardware STP
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 30 Sep 2026 20:29:37 +0200
In-Reply-To: <ea1f498f-fce6-4e9b-8afb-10d16ac12f08@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-8-ddebafcb9ba7@linutronix.de>
	 <ea1f498f-fce6-4e9b-8afb-10d16ac12f08@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 01:24 +0200, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 12:39:35PM +0200, Vasilij Strassheim wrote:
> > The driver does not implement hardware STP offloading yet.
>=20
> What exactly do you mean by STP offload? Can it do the actual
> protocol? No DSA switch can do that, we always use the software
> implementation. I'm not even sure it is possible to offload the actual
> protocol.

That's not a complete offload. The documentation says:
"The Spanning Tree protocols is supported as a mixed hardware and
software solution. In the hardware section, IP core is in charge of
forwarding BPDU frames to/from the CPU port and managing frames
according to the STP port states."
And:
"Spanning Tree (STP/RSTP/MSTP) algorithm runs in a software application
in the CPU. The CPU is in charge of configuring the switch port states
based on the processed BPDU frames."

There are a few registers for this. However, it's enough to just turn
off the feature and use only the software implementation in Linux.

I will update the documentation accordingly and stop using the term
=E2=80=9Coffloading=E2=80=9D to avoid confusion.

>=20
> 	Andrew

Thanks,
Vasilij
