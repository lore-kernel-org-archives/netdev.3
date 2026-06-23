Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E8306746;
	Tue, 23 Jun 2026 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194103; cv=none; b=bpnTTGmCbpjGYs6iaEC0m0+e6cf+Eg3K9vP9c9ily4iIsCoRUPo8AuZUwV/C/YhAFseObtgr9+hLrPtrM6lscURSenMPV2PUbbYFA2gzPKFND9qaRF2RtyXGrl+VUwt3nuQn3KNAgt7kMNOgvDNy4Ap6491E8iRB4oB6DrJaFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194103; c=relaxed/simple;
	bh=xn+wvnXzpc9jXLOuctsgT9WJqipzbFncNOD9qXKry7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kv4qucF1zU6+LNL45rB6l7HTa5T+d7JYk+3GCto5tvLephQEFHjyo6NzzCBiv9IfMDSUyS7vKNHxjK1W6nj2W42eqZWGjOhmuZgX/NZ+HRjbNxU6FLyzdTjDjF9DWi9OaOSk8/LN8KvRJmHUp3AO1SnZR5NV8MJm/9laBIF1V7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CEXbprue; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CEXbprue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782194093;
	bh=xn+wvnXzpc9jXLOuctsgT9WJqipzbFncNOD9qXKry7g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CEXbpruebyN+ULBwabnfGMz/IPLDYGMrn054ck0qigRfFZLKsimynnZEPLMgRuUMR
	 7hkB2IN5TXKNUmNB23Ist4JUEij/F31pAzd+G1YrGhtg4XaAL3ncS3PF+uw+AkTyis
	 SonIfDUjb/EdCSS/tK61+BsIo6gmZdx738kwOLVGP2bfG7sgppH3mTg3jy7l8xvXMY
	 V4LvKdH46WZ3wALZfKGzp6oWeLn9CMiebQPdYqaeJUQ5V7zWpahSvtEW/ishBMGDjZ
	 AYjxa5bPrs5RM0IuGkTuDINXD3A/LBEsx3rnM4kpRdv8DS0/Ph2KkKNe4ppaxEgDIZ
	 6XisPsdwOAq8w==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 26C8A60007;
	Tue, 23 Jun 2026 13:54:51 +0800 (AWST)
Message-ID: <9d11a866347c2c8cd69fdcb338bae743d6e68bfc.camel@codeconstruct.com.au>
Subject: Re: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Paolo Abeni
	 <pabeni@redhat.com>, admiyo@os.amperecomputing.com
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 Jonathan.Cameron@huawei.com,  lihuisong@huawei.com
Date: Tue, 23 Jun 2026 13:54:50 +0800
In-Reply-To: <edacdad5-7936-4fbf-ba66-973768ebdf73@amperemail.onmicrosoft.com>
References: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
	 <20260528084611.133703-1-pabeni@redhat.com>
	 <63aebaed-2456-457d-be70-5211d2f746df@amperemail.onmicrosoft.com>
	 <8c2a9e591ba22a95962c2c5f7dff5971fc5123df.camel@codeconstruct.com.au>
	 <4fabc99f-52c1-422e-9513-69e2190bc91a@amperemail.onmicrosoft.com>
	 <068cd5ffb49aac3bfd2184df7289093cbcd524ee.camel@codeconstruct.com.au>
	 <edacdad5-7936-4fbf-ba66-973768ebdf73@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

> > > The code itself will not, as written, work on a 32 Bit system, as the=
re
> > > are 64 bit specific code.
> > Yeah, that was more my question - what is 64-bit specific about the
> > code?
>=20
> I'd really have to dig, as this decision was mixed in with the earlier=
=20
> endinaness conversions.=C2=A0=C2=A0I suspect, that it was origianally tri=
ggered by=20
> the ACPICA insisting on Machine architecture for these values, where=20
> they are supposed to be explicitly 32, 64 bit etc.

Looking at the history, it appears like this was a in response to the
AI review comments about the stats update with interrupts enabled. The
report was that it may result in tearing of the stats values on 32-bit
machines, but if you have the stats updates right (which I think
you do now?) then this is not an issue.

> It might be perfectly safe, but I have no way to test. Treat it as a=20
> general trend toward not supporting newer technology on older architectur=
es.

This is more about not imposing a configuration restriction with no
purpose. There is no need for you to test/support those configurations
though.

> Could I safely acquire a spinlock in the rx_ callback during interupt
> context?

Yes, absolutely. That's a main use-case for spinlocks, to allow
serialisation from within an atomic context.

> I thought that had a significant impact on the system.

You don't want to be doing large amounts of work within the critical
section (and with interrupts disabled), but your scenario should be
fine.

Cheers,


Jeremy
