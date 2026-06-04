Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2A35FF58;
	Thu,  4 Jun 2026 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592418; cv=none; b=JitnLCha6A9cXG6BAyuuzhUjVYEgOxwbIPCZVYwfGz6gyrrFslou80ii9vHwuJu90meSZyZMdznKWdXkuq+v6DagKX7WBXWMiwW7HZK+7950yHxHJzAt1xzMzIefyiu5taGcEJ4gcxuO5c3roR/6W+Q1WO1pnWsTHFH342l4VQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592418; c=relaxed/simple;
	bh=CfNWtGz168NzoqOiknxM43p4SOXrj2yLEVY7yfF7Ljo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjaabL5MujFQk0GO6x5NculFXabGbFrXjzeBcwVwVd5RFsNm59PInvABRiSl4JJzxn3nV/j2d386KhZ9msibyLZILa3/sHUKNtXbbcMBnb3Oicn+gmGPAI16LZtWeoYrFIgxS7og2x5XzMjGaK9tKDbDUfQZtAXSy1/wOaDqLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0WpyDW6S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0WpyDW6S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rhl0ThfoiZNtuY6zcNsN3ee9YQZl9IUu7soVy+QE/Jw=; b=0WpyDW6S+sVcOgTehmhYVHgYB1
	st201YyQXzveHpQ6ArR7nIfmjN98WRZpVswhc3IL0FjRIuMBe2KRbXBihws1fOkZIbipG7B3xVJXN
	VT0tbJppiImmJfADo0IJ6x2fTuMGIVtns9Trcyy9stPgLNOsgLoHO2Zzpe642oIiod+U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVBQH-00655k-KU; Thu, 04 Jun 2026 19:00:01 +0200
Date: Thu, 4 Jun 2026 19:00:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-swimwear-garnet-3eb092e6fda7@spud>

> I just made the assumption that what was in the example worked, and
> wanted clarification that what the example was changed to actually
> reflected something else that worked on the hardware in question before
> I gave an ack.

That is the problem with edge interrupts when level should be
used. They work %99.9 of the time, so many developers don't notice
they have it wrong. And then one day it all stops because an interrupt
got lost.

    Andrew
