Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087A328623;
	Fri,  6 Feb 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363893; cv=none; b=MZfZCWJexg8VVzjYd53Pw8jeYxqbQ8NH9PXySdWRaCSJcmaFal5vD3cgQ3zahoXUk13LEjvqpbVe+Gs6H9Xrrv1zQ1oKT6d3H4dFEqPfTWaGG/CKU7C4PH3FLveYiqyTB8mzDf02UuleOR/hzhxfdo7C54EBDPG4sFLmhfRSxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363893; c=relaxed/simple;
	bh=sFavFKGwS58WDsYBtzJEnHEjzWndWpmKa5rsxOktmXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjupYm7lBRansfh2Im0Uhft8ZScNEZMUA0OThEAV3ieBWAabncJhlfrtOAeEumd5WdtE3eI8Sul5TNrYcO/SUFZJ965qc9njaaD1yaZbVx8NreiB7WbXculfOiWOnnMqlsQ9FBagwTdwZMCOq2a0Jblbz5z6UJBbQx2A2sMP9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yU7OniFO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5W2jvDG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yU7OniFO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5W2jvDG"
Date: Fri, 6 Feb 2026 08:44:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770363891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpzWp3yq3XiRmUCcwaPqU4QiBYrxfXsSEJ+PJeVd5pQ=;
	b=yU7OniFO6DTMhIXOIMwHx7vYb7Fc4wabicbGx8o5Ba3wljCAO+o9srwyg4uB3E89V8HsQ+
	1ctbCpBpTXlokDCVTfZL1xXfW07uhvABrJ7xoclNksmrKiREuozwOheb0Hmpd1E3l2k/Bn
	Ua9Y2RrUuhzXPFnXZ0LDY9Vmo9Iby+wWEsV/U897nWGyqJZJNTxmKSgmhPY5H68vZrDVGR
	Kj2kXsnsdbzhwuKjAsStvLIR9oTcD+1BQs2cTgr1pVn+aU05Fx9vpP0QRRez7PAKERPEod
	wj9WztLnKDdVxM/7xvyvXsYXAHq+0RJv8d0S1y2EgpCwjWJZ5RJ2wCl9SIYemg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770363891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpzWp3yq3XiRmUCcwaPqU4QiBYrxfXsSEJ+PJeVd5pQ=;
	b=N5W2jvDG3T5AdCJ5JQCIxnv7FBwjhTyLCY2tspJ0SgS8bn/Nwnk0lIxL60AORnUhZJWbuC
	A6C1iKTuhsJ2oKDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260206074449.CydBDckN@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.459b2672b1e7@gmail.com>

On 2026-02-05 16:41:03 [-0500], Willem de Bruijn wrote:
> 
> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.

okay. Can we move the check to sock_set_timestamping()/ setsockopt()
time? On the plus side we could throw an error instead silently dropping
packets. This might be a late win given that you describe the users as
legacy users.
I'm not sure if the "permission" can change over time and so get revoked
while an application is running.

Sebastian
