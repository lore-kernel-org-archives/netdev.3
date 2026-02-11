Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE511DF748
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774389; cv=none; b=BTfhDYEn5GNU4lXouxGOa975SYni/FWqaurlF2GhEipGpyBVmgREXWYCHyGc4OLE6MwLUTPRGDGZP06ltZTuJyrlfpeaL5QRg+ATRcQTjmS7JSYzzbW4ITrIqXXzKb57Bvm1Jlcsu9Bz4jBzzunvFhuI3yrNZsINj9XKrx9xn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774389; c=relaxed/simple;
	bh=3sHMAUaqiRg9ugkThGjcRaOG+X7c+mlttGN2AFx4L7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8W5OAdA7qp6lUq89IPf3rSXzw1YxjjEBLHO1RbHp+zjEYLbkJpIb+ZqdQaUFoUgCKm0aQfE/2IesQKEqdSMhFyKBHdU874CuddfRi/zOmQX3T3thv9QDLDGyBu4ogcJ7uEUozx/FCL1kAbx4ojrvCigILBsYrbT1i36p/Vtyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R15l7Aa/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R15l7Aa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F73FC116C6;
	Wed, 11 Feb 2026 01:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770774388;
	bh=3sHMAUaqiRg9ugkThGjcRaOG+X7c+mlttGN2AFx4L7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R15l7Aa/02WTlxA92bSGaBROZJhhNXQc8pQalYSiBRGIxsqjNdM7zwWY6osy03QQU
	 FHj0cuHRBbRBulDLf5HmOaomt9eUQs4XkoP0w6Ak+W3mdK0L8z0Hmp6BWFcZ0Xy0IJ
	 bfLvocr/DCTKzAfxEkTfurri2aLuG/yVyjLEf0gTquPfnHmJgnP6PfFHwu5oDaLkTN
	 H4Fr0cUQiT8Qz85Z1JoCvBeUBkm3uHymEKAkRUEAPfd2eoFxZuNUV2h8QQahvaiyXp
	 7rAd5QXoo27bOI9NoOuS98Ut481LF+9RqGD0KpuTPJnEMKvnWj8AQtvkzML7IorKmN
	 ngaFCAiZ8nxEA==
Date: Tue, 10 Feb 2026 17:46:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan
 <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS
 contexts persist after ifdown/up
Message-ID: <20260210174627.2360a03c@kernel.org>
In-Reply-To: <CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
	<20260206052930.1882740-5-michael.chan@broadcom.com>
	<aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
	<CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Feb 2026 21:56:39 +0530 Pavan Chebbi wrote:
> > > +
> > > +    import subprocess
> > > +    max_wait = 10
> > > +    ping_success = False
> > > +    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]
> > > +    for attempt in range(max_wait):
> > > +        try:
> > > +            result = subprocess.run(['ping', '-c', '1', '-W', '1', remote_addr],
> > > +                                  capture_output=True, timeout=2)
> > > +            if result.returncode == 0:
> > > +                ping_success = True
> > > +                break  
> >
> > This might be wanting to use utils.py's cmd()?  
> 
> I checked and tried using the cmd() and it indeed eliminates a lot of
> lines here. But the test itself becomes a little unreliable.
> I often see TimeoutError: [Errno Wait for file contents failed]
> /sys/class/net/ens2f0np0/carrier from the wait_file (Jakub asked me to
> use wait_file)

Does the link take more than the default 5 sec to come up?
wait_file() has a deadline param that should let us wait longer

> Also, even when the test succeeds, after the suite exits, I cannot
> ping the remote host for a long time. In contrast, my manual loop
> worked 100pc of the times I tested.
> I am using the command like below:
> 
>    for _ in range(10):
>         if cmd(f"ping -c 1 -W 1 {remote_addr}", fail=False, timeout=2).ret == 0:
>             break
>         time.sleep(1)
>     else:
>         raise KsftSkipEx("Cannot reach remote host after interface up")
> 
> I am not a py expert so is there something I am missing?

I don't think there's anything Python related here :(
Is it possible that NIC reports carrier before it can actually send
packets? Maybe the wait_file() gives ping has a higher chance of failing
with carrier up which makes the neighbor resolution failure more sticky?
