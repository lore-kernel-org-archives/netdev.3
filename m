Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E533987F
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378965; cv=none; b=g/E+Dt8tVkRon3Kk6Flwy/oG3eBheGyrNB1/1RsD+YWoNXIeYalKM3lMoknW5AlqxfdI9OrUZ+0wzXKVO3AkJOY9KTV+RdXYAbY3+E4JnLGo7cLAgt1zP81dy41Uc7fQd2ME20iuE1ox3kLz0mZAqDhlfmvCcLN8xmWi9sNLCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378965; c=relaxed/simple;
	bh=huiBDVm4YZGR+EoYLcyww3eqlN3NbX+f7WlpOSgs6u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iO/n0q0ILJmW1tzLb1cBFDYfi0P2DBHypAQwMAHZPQAF3737dIdE1Xoeb+b7Pj3OqBpnyBN/id00FIYuqZUNeT+7Z//yskMAiBcTrDZaXw6bxFsKrnmve0ssy30CRx1js4ClljLMY6O0bxAPU0ITqVoJfKA/+E4tXrSlUQrSeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLY12gNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLY12gNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEE41F000E9;
	Thu, 21 May 2026 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378963;
	bh=AVHSwaF32iw0dr0NP2vboSwwUGX0DL+w7UhbleUcJ/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CLY12gNfK+pqlfCXH0Bqy1pMiGGg7fSeDvZbi0TJ5/lXQkAjl6I+YjW5kpYjPuj6s
	 JXZWVOMFPNLFmNAHN1CkZ2P2DFyliJ2ZlpOz9Ipf4eX0NGw9nHEAO18W4lEnCZwE/g
	 cnIVuG83rP5NKgNqM+3PXpazjv26TMlGNr5HVKYC/bWRTTtltdGtYpk1I9cEyKlioQ
	 JO/D6uj17JqCR6Aa0kwL6bPGWZlwRoB6ii8XnkciSNc3c6doQMSwdZcj3Zq5mKOSwQ
	 YYDnzuWBqOPYENmj7mw6CE0LL01ozncXcGnP8TqVj0i1pRs6JNK4zeIwJZYXjGy+yL
	 cLcsecap4+78Q==
Date: Thu, 21 May 2026 08:56:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260521085602.1a7d7ef0@kernel.org>
In-Reply-To: <CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
	<CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 17:51:25 +0200 Davide Caratti wrote:
> >  Do you know of anyone modifying payloads with pedit?  
> 
> yes: MPTCP kselftest does that on purpose, to mimic a middlebox and trigger
> DSS checksum failures [1]

As I said in another reply (looks like the ML is having a significant
lag this morning :() - we would still support it, the shared frag
tracking is just an optimization to avoid a copy. And maintaining that
optimization for an occasional CI test is not the right eng tradeoff.
