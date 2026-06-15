Received: from a9-9.smtp-out.amazonses.com (a9-9.smtp-out.amazonses.com [54.240.9.9])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF8311C2C;
	Mon, 15 Jun 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556078; cv=none; b=ep2bJ/hsLV5+bhlzVXUbj0svLRxm3SGmnHvifGg13tDgrr0gtVXMqru6Hja9SO25U6NoyU7HWmL4q1ek3UBBkb1M4OuOpUkeaxbjrMkJxlyasQxJYRORBLoQ+OF3UxKVW+cSPT1Q4bNpBInUSQ0pWocneqTybmugk/Wqlnxdwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556078; c=relaxed/simple;
	bh=7Nd7pHVxAkJKJ1IKwSAEUgNEuQx3bdCIV3l2aVbH2Tw=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=djTG8focMtIju+bRVXy/xFKCQ6zuH47fbcKt2spyYu4RysFeedMs8dG2Vk64yxFHfUQSpjLKRXWJOyfxzyAxnTqDxVOXXQb1XcmngOW6/vjpiFNIV4eugd+eFtyGq13XsXAifD3hLBJOmRDDceDoT84hvQxK0O5g+9MbOsYPy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=Q7+djscg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=AefpJcvC; arc=none smtp.client-ip=54.240.9.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="Q7+djscg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AefpJcvC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781556075;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=7Nd7pHVxAkJKJ1IKwSAEUgNEuQx3bdCIV3l2aVbH2Tw=;
	b=Q7+djscgkypi3A6WvEc4PbOq21AHsn4JMZPkd/Kdpm+bdL4RS7Z34jXt/xj9OL3U
	CPuZItqvs8+PvqJ8UIBAS86xOscSsw63PrIFpmqcAS/RhmxDuX/Er5DAoYKM2drMQgb
	FQ1X/BcJMx8iYteEPMhsEnukE15/PzYraADoruZg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781556075;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=7Nd7pHVxAkJKJ1IKwSAEUgNEuQx3bdCIV3l2aVbH2Tw=;
	b=AefpJcvCxmbTaPmFW/I802FbVdW3J8Ip7RX65NEq643SiR+XQtW72yzeXFQtfeK2
	WOHM/5gUmi8BXq3ivy1kFB2/UvnR1n2Fni1ZaAc2Y0BleFudGGQpbQoB4v4E6Y4hWAP
	iQrELUXQglA3yvs7plJl7wRWFEFLXQw+7xBWbNoc=
In-Reply-To: <63983efb-dcad-4b34-9d35-4086de11be5e@bootlin.com>
From: Johan Alvarado <contact@c127.dev>
To: maxime.chevallier@bootlin.com, linusw@kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, namiltd@yahoo.com, luizluca@gmail.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: dsa: realtek: rtl8365mb: add
 SGMII support for RTL8367S
Message-ID: <0100019ecd045b3f-a7bfbb9d-6659-45c6-8fca-9cdce637092c-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Jun 2026 20:41:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.15-54.240.9.9

> This comment implies that you could deal with SGMII aneg at some point.
> [...] makes me wonder if this whole SGMII/2500BaseX series should be
> represented as a PCS phylink driver.

Hi Maxime,

You're right, and I'll convert the SerDes path to a phylink_pcs for v4.
It splits the MAC and SerDes layers cleanly, drops the "ext then sds"
branches in mac_link_up/down, and makes future in-band aneg an additive
change instead of a rewrite.

One point I'd like to confirm on scope: I can only test the forced-link
path on my MR80X (fixed-link / conventional PHY), and I have no setup to
exercise SGMII in-band autonegotiation. My plan is to do the PCS refactor
keeping the link forced (outband / no in-band AN), and leave actual
in-band aneg support for a follow-up once I have hardware to validate it.
Does limiting v4 to the forced path sound acceptable, or would you prefer
in-band aneg implemented up front? I'd rather not add a code path I can't
test.

I'll also reword the misleading "disable in-band aneg" comment.

net-next being closed until the 29th gives me time to do this properly,
so v4 will carry the PCS conversion, retested on the MR80X v2.20.

Best regards,
Johan
