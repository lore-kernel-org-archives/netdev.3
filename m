Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88F426EDE;
	Thu,  5 Feb 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309825; cv=none; b=LlPBUiK8k5tLH0jjk7g1YE+LcNDOfRxdT6I1BW+0CARGI8/2YoF8Laglzf6zbm/4BVFSqUbeIedIDlBxVhSdVglAQIomlgqUb97CFhs/BumfWX7tqDaQj3tHsT85rJnfRuiNH+8F98PtH7sqHGkBHa4ovJXSINHwx4SJVnWAUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309825; c=relaxed/simple;
	bh=KydXj7FJV7eI4RaSnpEMpn04wpviyE/skfmAQzfW4aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVri1OuNN98jREqiQgjBM6IgU2NLho+qHf4lrvoJuX+YxR5gqysFQCwHc4gw9d+GRCW+m2yMaG4FHp3wwn9Iak05dvJu+SkqZdAhg7DAb6S5eif8NjhEJL2THOpbkZq+YQUdlWVS5+hb0qH+GcLKFBWltSpY1anHkd8QsGm5kyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pekszn7K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ab+q7BSq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pekszn7K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ab+q7BSq"
Date: Thu, 5 Feb 2026 17:43:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770309822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KydXj7FJV7eI4RaSnpEMpn04wpviyE/skfmAQzfW4aM=;
	b=Pekszn7KxVSM+oHVMKA2ooTZA1dsyUwxEeInKoSTpq3sgNnDqBTggzelkybvmAfpAmJXKe
	gZ/3X5RTLYTh2YMXHB9+OnIeztFKZTraAjSsByLCodz+v0x0QIcNeF7sdsA8fwcn/tgCfW
	JXt8VZ9lTm/ZLzp9LFqpjiBbBYCev6StAZEDUDUgOF3CJ+uVjrXY+pWT0nbLPIrdEWsjqb
	V/mTl4wg3XkO5EzOf9UHRjO1U2N2rAY4pJJzwnoGAbrGN4xtGAMKqcxc5rivGVREO+eMX9
	LbvsdssTtNBSJ1wHmmRUVyVHIyIqu9NTknY0DkHCXK1UELSuZCtUddPz1K6e5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770309822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KydXj7FJV7eI4RaSnpEMpn04wpviyE/skfmAQzfW4aM=;
	b=ab+q7BSqcHxfuC8sKrooKlNeB10oMSiuEFxsifO6gvvErCt4H5ZyJdMD6xcojzWMQvZked
	CQgentwdMzdMCvAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260205164341.pJvni8kA@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>

On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
> > So the only thing that bothers me is the read_lock_bh() in
> > skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
> > the same CPU.
>=20
> Alright. Now you make me think whether we should enforce OPT_TSONLY
> option on socket which doesn't have CAP_NET_RAW? Then we can get rid of t=
his
> check, and in case sysctl was flipped off - drop TX timestamps as
> it's done now?

This would "fix" this problem for all users which do deliver the
timestamp from their IRQ handler instead of napi. There are a few of
those=E2=80=A6
This would be considered stable material, right? (despite the fact that
we have it for quite some time and nobody complained so far).

Sebastian
