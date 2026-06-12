Received: from a9-17.smtp-out.amazonses.com (a9-17.smtp-out.amazonses.com [54.240.9.17])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAD3A5422;
	Fri, 12 Jun 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241806; cv=none; b=lRnU2ixXNF7YAG3HdAQV86IfAz3Xhi7bXkRmV8O4vlwEdHKHd1efYX4CKZnpxwE1QZ2EVxqH0bQCtY3usaUyxmoTuPXWYdyIjd7v5ibAcHD6Qa1ZkA8AzdcQxlJ7zfokfwnLVPjH5T4CNPrtpukSjiRAMHl63Hk2oyfJeeWebnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241806; c=relaxed/simple;
	bh=KzBx4wrcZ9SM6utbGxEvn9CH5rMlJG9zYDQO6DRDtek=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=F33WS7MO6axdTg+lXzOiokGJmkXnqHMITK3NJdYyuyP0Cr+UZwS8a9vfsp2mGlSpLK9DWpJe0b+r9AqsBhwG5EtW3s1LoN8k08XvNAA4exeP1zOGIfuNRPlXb+JCHq2cGg6c3Mqm1mkqs9pGXuaR4kJh+SsP1lb+dKtPbVy46C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=DxOs6hXL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=bRKbSB6s; arc=none smtp.client-ip=54.240.9.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="DxOs6hXL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bRKbSB6s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781241803;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=KzBx4wrcZ9SM6utbGxEvn9CH5rMlJG9zYDQO6DRDtek=;
	b=DxOs6hXLGP3YBW3Z7oJDGdp8DtnE/yBVGxwxOzQVhlE7tL+tTw0y1O6i5KLDFyP2
	cwqE8rnZOO8nRt+ftfKCIMxi3+/YI5+HNtvH82MDUe1Q+EDjXv9wyhsp9ZRnJQJM2Dh
	jvNh1H0zLu/39GoJ3O49g9CPKj64LQYLluo3BvgU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781241803;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=KzBx4wrcZ9SM6utbGxEvn9CH5rMlJG9zYDQO6DRDtek=;
	b=bRKbSB6skJeQ915CpLQeOcP0YGVOLH3mu+ZzSMvoNUK4oCV5W837Vrxwy5zfVu+M
	XJeI7J4MrXQ5RRzhol14TYaRYG9sW82GPE212TmpLaXFuXapr3K2CPfhe2wtMXdYEU7
	ZCzenN/RrHRa5i0Qzhg3fmH55iMMrSUreSquAChg=
In-Reply-To:
 <CAJq09z4B_P7D0khof-e0hxu=A+UQYAH_anJYt8ppaFcjHCdBCw@mail.gmail.com>
From: Johan Alvarado <contact@c127.dev>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linusw@kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: dsa: realtek: rtl8365mb: add
 SGMII support for RTL8367S
Message-ID: <0100019eba48f14d-299bc369-1ba5-4262-a913-caefd96166de-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 05:23:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.12-54.240.9.17

> I think we don't need the firmware at all. Requesting a proprietary
> binary that we don't control to do things phylink already does is
> unnecessary and adds a burden to linux-firmware.
> I strongly suggest =
dropping rtl8365mb_dw8051_load_firmware() entirely,
> porting the BMCR reset sequence above directly into the driver, and
> keeping the 8051 disabled.

I tested exactly this on the MR80X v2: =
dropped the firmware loading,
ported the 0x1401/0x1403 BMCR sequence right =
after the SerDes reset
deassert, and kept the DW8051 permanently disabled =
(also removing the
re-enable at the end of the SGMII config path).

Results in both SGMII and HSGMII modes:

 - Link bring-up: 10/10 cold boots=
 (power drained), 10/10 warm
   reboots, 10/10 module reload cycles =
(rmmod/insmod), and repeated
   ip link down/up =E2=80=94 link came up =
cleanly every time.

 - Sustained traffic, CPU-generated (iperf3 on the =
router, 30 min
   each direction): ~750 Mbit/s in both modes, CPU-bound. =
Zero
   CRC/symbol errors in the port MIB counters.

 - NAT forwarding LAN->WAN (iperf3 between external hosts, 10-30 min
   runs): ~800-820 Mbit/s sustained, PHY-bound (1G user ports), again
   with zero CRC/symbol errors. A small number of buffer discards
   under sustained load (~0.07%), consistent with congestion rather
   than link-level corruption.

So I can confirm your analysis. v3 will =
drop the firmware entirely
and carry this with your Suggested-by.

> If we intend to support non-fixed links in the future (where in-band
> AN is required), we would need to implement phylink_pcs and
> pcs_get_state instead of just forcing the MAC. For fixed-link it is
> fine, but we should plan accordingly.

Agreed. I'd prefer to keep v3 =
scoped to fixed-link (matching what
RGMII supports today) and leave the =
phylink_pcs conversion for a
follow-up series.

Best regards,
Johan
