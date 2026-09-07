Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D827233941;
	Mon,  7 Sep 2026 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753128; cv=none; b=Wr7PKohcsIeKlRj5PiNIHbsF3dS3GDr8fv5zN7VQYVOYVbI+iYyCSlGB2B4dtWodhlREfEdzCtwBq51kTfYlu155fB/nHw6rKa4HAmZEvmoUpFwKPMM4JNaev1m+cXTioEyBx21FlSoq86jJ/RGw4bQfIBM6xEEHzNQjbjx6smo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753128; c=relaxed/simple;
	bh=wGSTXigwVwcAOEJJhYoMO/3F5N2F/BJka8qWh42ZYeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz3oDJN404vLyqaUk/hUvPvbwNURJxldvx6inYiGaCMXpwVyoEom47tFWQDI6+DnRg3HuQH1PorvNSrMIxDXrv4qRTakRk3/aAKbRZq3HGbt+UnbEcPO6ZoLS8IC8+Rw/zXGfbXUtN56oHovcJ9vC3s21pCy8SKbuK1i1uORWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1788753058t17ca1ebb
X-QQ-Originating-IP: XwaUVt+mxKOKC49mM0WRnuelpEAlllUgFupYt9pMvJ4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Sep 2026 11:50:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7604924112529991838
EX-QQ-RecipientCnt: 10
Date: Mon, 7 Sep 2026 11:50:55 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v10 1/5] net: rnpgbe: Add interrupt handling
Message-ID: <5FB2D06B15EBF2CB+20260907035055.GA323862@nic-Precision-5820-Tower>
References: <20260831073608.401988-1-dong100@mucse.com>
 <F44E6669E6C9E7C4+20260831073608.401988-2-dong100@mucse.com>
 <20260904145410.67b6877f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904145410.67b6877f@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Nr5N425iK0yrAR3JqgNfVjPklW3DNZoONLOCfEH6DeAfRV74Nj8H1wV3
	+yWqQj94FsoaIZJQKLxaPDhe8W1rFG2ArqCIQsJ6xeTw721seErWno4Lnpzi9CkN7qMfpWr
	6nlBP+68joqlbn2leKirWmEPRIxKXk732mYzGPSfJSVN1BTfWRWaJMg1YTwKGx3kjU2IiDA
	aX+izBNdwIOXAaxpb8kO4rzjla/RXLTuOOhR+GOizfSX15Y61w4DigKXzih5luyD/7bcXUW
	mdZzhB95Zu7SA2u2j+njPdQTu9nyQMK7oASbS8jqknduKqI3+WSj7qjvIM5J8U6BBehoUja
	bdJoDseld+Yx7PbHzidmnvD42ksLiDl1LWteZKvFDceFPmqgsPTM9nWGKY6imYIVyLk2GKV
	Yve43xbiZ6JxvjQzHjE06F0eRYNxaPdhgqQNJ2j49Xau4NXhTuHkXGL+wtx6r178l9Ky9NT
	J6d1yoIDmQ+zuSm8qPotMjClW7/5dMiGrbKTFECj9k/4A8xs5NfklwcJNg/AhFIvVW5coWa
	i/QCGuZb6fQEUGDrkVPv4XqGFblssJwR9pH8BIl+neL7UzhAb3s/usnAtjPPtKr48ItdbmX
	NomZr/KZgjp4rmgbpRWV21HA4DsGWaNwEIb4XU4lUsNyGew1+MsFjq7TFjJotY/qhVz3CZ+
	pccRF50tcpxuaudx7D9id9igiNJBdho7DicZ9XhmFSn70YplYTE8n2moULlPVUp0vZLod4l
	16n+W1k2NtGQWGk9BFkn5fgD8UAOaJCEKwzJVClLvioSijToGraqCT+XbVFbVbjXpT5Jn0n
	Ipu03F8Ojr74CgzjHZ/jlUk3ZW6hq3T89mc9uXx11LhMUuEj4075x9FQ9/sj58fiuiCOPaj
	FFx0PHeMfEcowSQsP1zJOzzQmNJIwWW32ALZRurdhWHZoGgqhy2PyBPgIvYsjpcYVURd6u6
	keI/K29NkpTIk7m6m1PkXyKaTlig6Z+CX0znLzjrc/NbONcDfHVfD18jDWpYvaS7iOVnD8X
	0MHihbIu5aJeX5vSEBxBj7Q6E3V3r3m3JRHCNORQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Hi, Jakub:
On Fri, Sep 04, 2026 at 02:54:10PM -0700, Jakub Kicinski wrote:
> On Mon, 31 Aug 2026 15:36:04 +0800 Dong Yibo wrote:
> > +/**
> > + * rnpgbe_int_single - MSI-X single-vector/MSI interrupt handler
> > + * @irq: interrupt number
> > + * @data: private data
> > + *
> > + * Return: IRQ_HANDLED
> > + **/
> > +static irqreturn_t rnpgbe_int_single(int irq, void *data)
> > +{
> > +	struct mucse *mucse = (struct mucse *)data;
> > +	struct mucse_q_vector *q_vector;
> > +
> > +	queue_work(system_percpu_wq, &mucse->mbx_work);
> > +
> > +	if (test_bit(__MUCSE_DOWN, &mucse->state))
> > +		return IRQ_HANDLED;
> > +
> > +	q_vector = mucse->q_vector[0];
> > +	rnpgbe_irq_disable_queues(q_vector);
> > +	napi_schedule_irqoff(&q_vector->napi);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> It's not reasonable to have a single IRQ handle datapath and also
> unconditionally queue a mbox work item. Just require at least 2 IRQs.
> 

The hardware supports only one MSI vector, and it does not provide a
reliable interrupt-cause register to distinguish mailbox events from
Tx/Rx events on a shared vector.
I will remove the shared MSI/single-vector MSI-X path and require at
least two MSI-X vectors instead. Vector 0 will be dedicated to mailbox
events, while the remaining vectors will be used for the data path.

Thanks for the feedback.

