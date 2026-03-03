Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A6388E6B;
	Tue,  3 Mar 2026 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525698; cv=none; b=YfXrVOxc4NvfRRFH1rfRbWrtGtaEjbPSiDVOi18PjTHcmoaw5kyW782W2dgGMfWGCxnDlV0pMSZnb2BCEK6NjRxmfnJuyUtE96V4bOmoFA+cOTDYXkcgNmbG6hLx3dzLZFFZH3CQIDYAJvatIpJUbZNF+TwJhn4y7DO5/uIHJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525698; c=relaxed/simple;
	bh=Ce5nJRVWFSGJfoObDFfp/3+8CTyxmNquHiyi8rNKNhI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=pB7YYi1ufPndmTii6qnwMlWV404NVaAIRSGzFGnpM+WW9lGOuA0RtOAjswF5mDPv3tLpRYyn/NO9j4AqsarSHGttWcUW60HBf/Y+A0Wi7xI++VhwYcUWLwGzxE2+KilKgmlLDMNdEAtCJs7vp9NchTBZiwXMuB+c6eLNdPXY6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A36p1RjY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A36p1RjY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BE100C40FA1;
	Tue,  3 Mar 2026 08:15:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 306555FF29;
	Tue,  3 Mar 2026 08:14:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5AA9103695DA;
	Tue,  3 Mar 2026 09:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772525686; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kgG0ko0ssft+vH5TrQb6Qwg2Bs/GVlu2E3L0Q0CZVRI=;
	b=A36p1RjYa58rWdmoYYkoM9kvVA9opPsFtepzv3aXp1kn5IOwTeAq624E2Y7gADaaEAkqaS
	+9971sqqZ23aGv9STK8T+byZ+u8H6nVki03t+HkQZL0r2LxZg3Mz5J89adpDN+E53CmuzX
	Mb+Oyw10NJ9v4TUSbIeQe9eOdVCgoaW9Rrk2DPtprtmDdEETEQ7J0GtpZxWROnq1HSbRAE
	7zDDB+NpElm8chHmi8qS6VrT5IgDL5NOC/Y2ijZpCif0Jz2W6QTs5Qezx9OvkZ5HGbdbd/
	FkgWUyiG4mQRuVF5GF+DPD2rTkNNfGH7IthAOFRbolYG6X8YhgYserERue/x5g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 09:14:41 +0100
Message-Id: <DGSZWWKDJOFM.CCG4PBOJIRW1@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 2/5] net: cadence: macb: implement EEE TX
 LPI support
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux@armlinux.org.uk>, <claudiu.beznea@tuxon.dev>,
 <nicolas.ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
 <theo.lebrun@bootlin.com>, <phil@raspberrypi.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Nicolai Buchwitz" <nb@tipi-net.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260227150610.242215-1-nb@tipi-net.de>
 <20260227150610.242215-3-nb@tipi-net.de>
 <20260302181522.068f4715@kernel.org>
In-Reply-To: <20260302181522.068f4715@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Mar 3, 2026 at 3:15 AM CET, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 16:06:07 +0100 Nicolai Buchwitz wrote:
>> +static bool macb_tx_lpi_set(struct macb *bp, bool enable)
>> +{
>> +	unsigned long flags;
>> +	u32 old, ncr;
>> +
>> +	spin_lock_irqsave(&bp->lock, flags);
>
> we should optimize this function for the past path caller.
> xmit path does:
>
> +	macb_tx_lpi_wake(bp);
> +
>  	spin_lock(&bp->lock);
>
> So it immediately takes that lock again, can we move the lpi_wake()
> call under the spin_lock, and make sure other callers also take that
> lock? I think you can add a lockdep assert to make sure spin lock is
> held
>
>> +	ncr =3D macb_readl(bp, NCR);
>> +	old =3D ncr;
>> +	if (enable)
>> +		ncr |=3D GEM_BIT(TXLPIEN);
>> +	else
>> +		ncr &=3D ~GEM_BIT(TXLPIEN);
>> +	if (old !=3D ncr)
>> +		macb_writel(bp, NCR, ncr);
>> +	spin_unlock_irqrestore(&bp->lock, flags);
>> +
>> +	return old !=3D ncr;
>> +}
>> +
>> +static bool macb_tx_all_queues_idle(struct macb *bp)
>> +{
>> +	unsigned int q;
>> +
>> +	for (q =3D 0; q < bp->num_queues; q++) {
>> +		struct macb_queue *queue =3D &bp->queues[q];
>> +
>> +		if (queue->tx_head !=3D queue->tx_tail)
>
> Does not not need tx_ptr_lock technically?
>
>> +			return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +static void macb_tx_lpi_work_fn(struct work_struct *work)
>> +{
>> +	struct macb *bp =3D container_of(work, struct macb, tx_lpi_work.work);
>> +
>> +	if (bp->eee_active && macb_tx_all_queues_idle(bp))
>> +		macb_tx_lpi_set(bp, true);
>> +}
>> +
>> +static void macb_tx_lpi_schedule(struct macb *bp)
>> +{
>> +	if (bp->eee_active)
>> +		mod_delayed_work(system_wq, &bp->tx_lpi_work,
>> +				 usecs_to_jiffies(bp->tx_lpi_timer));
>> +}
>> +
>> +/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
>> + * and wait for the PHY to exit LPI before any frame can be sent.
>> + * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
>> + * we use a conservative 50us.
>> + */
>> +static void macb_tx_lpi_wake(struct macb *bp)
>> +{
>> +	if (!macb_tx_lpi_set(bp, false))
>
> Does this lpi_set() not have a relatively high cost, even if eee_active
> is disabled? Reading registers is usually pretty slow. Can we add=20
> a eee_active check here as well to short cut the lpi check?=20
> If we do we probably want to make sure that the code paths setting
> eee_active are also under bp->lock, otherwise this new check will be
> racy.

Funny how this discussion keeps coming up! I made the same remark on V3:
https://lore.kernel.org/netdev/DGOXXGNSSMYK.2XNU9AQ6E077P@bootlin.com/

And it had been discussed in a previous iteration before.

In theory I agree, in practice the optimization was statistically
insignificant on my platform. The total time spent in macb_start_xmit()
is tiny, so any optimization inside of it is even more so.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

