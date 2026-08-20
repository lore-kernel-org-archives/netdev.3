Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07244163E
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231430; cv=none; b=G85787tGl+SDk2P1WBw7M2KcGV1++dIy2xUffYCE2hQYLUF5EXEL/iNrFbDKNZ3ikDOjEiw1zp5H1H2Mq+KioiAkcVKrmD5wOJTvotVhL8x+jwlOBf6lRnSAOCwkah4ihDaGMMR5OfAEqG5NVvhGZeJmxRZSFbCzWPP8gm/tWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231430; c=relaxed/simple;
	bh=IBG8HMzKm/8shCZ5oNAZsPCZ4cnUvbWk6974Y7KnXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOhsdQKPuVSP8YeCn5T8wxbKwO/JNYYTc12ALmFAUFReC3HeljeKTleOffAXuPsMwgYoOCh1iAS8wZvMChwOmx8AEUeMTm4Fc0XD7zk0jlOWg9uNfzqE5CUXnNUwAgMnc6cDrBCt8kq/ySwo0Kf+dAGqETnyZfR3jkoMbDE1JU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B91C960232; Thu, 20 Aug 2026 15:10:25 +0200 (CEST)
Date: Thu, 20 Aug 2026 15:10:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
Message-ID: <aob8wQn2EuI2N-BO@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
 <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de>
 <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
 <aobuk1osK-Lq-aMk@strlen.de>
 <CAM0EoMm8G9FaZZfctYKsm4Rkd3RVmVxkWMp6zJ1Gbxge5hdp0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMm8G9FaZZfctYKsm4Rkd3RVmVxkWMp6zJ1Gbxge5hdp0A@mail.gmail.com>

Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Sigh - couldnt help myself. Attached  fixes the poc from kyle - i know
> you are hinting there are other scenarios where it wont work.

Yes, e.g. what if pedit inflated th->doff?
nf_conntrack_in() checked that this was fine, but now the pipeline
can re-neg on that.
