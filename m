Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CC377A85
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916049; cv=none; b=Vjo53iGVXw2haJr12OYm+eVlsX8qvLG3XZ9nRDMbJtqmJMmXpUDw/EuWrSVnDcmVuYDCN7qqsaJq2Wmgj9Vdtso3ptremE1reBaMO+2aNlZ0l1gtCGtb69Y15zQ6gAhXU3pHE0mlcnegfOCvVW8PKfBiq+YU7EnI+V/Qpja4WBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916049; c=relaxed/simple;
	bh=H6sBLSiu7gO8EIu2O1WJwjZnqJ5rMP2PvvK2yjVRrLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt0mwvg/2QhSR2VmOUviSAB1MgCHyqIHMUdf31Pz60bcL0uo2/KPxQbY8DoH98BUiHw1Uu1FlqAUUs/gunEqTy/6YOMOSR7o5QOczlv/bXuNZfujh3Uy2PdKo9ML8kfSqx/LIVU4qc8EGTaA8fsOnvXyAddaCuVg0VZYoMutTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=hlZzXWme; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="hlZzXWme"
Received: (wp-smtpd smtp.wp.pl 25797 invoked from network); 24 Jul 2026 20:00:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1784916037; bh=H6sBLSiu7gO8EIu2O1WJwjZnqJ5rMP2PvvK2yjVRrLA=;
          h=Subject:To:Cc:From;
          b=hlZzXWmewi1euvuhhVHYNRatBPVM7h5GXxwqL6Y7MaqYwUfzFxa9RunB2vizn9/Yh
           uXZYvfvKLFk6Mvzoz7Y6jLTrXCUEz8P5kB7cX6Tqwh9h4D7YAwIxtoPA+Uxwv6HaJL
           K9iBNaQIObS9AUpiqUw0rmCucTHrEI+ehTzpGIjIS7jEhvcoFF/pWX57wgVshqolxP
           h1H1LA/AyNqkwqt5nd/IqfkeHNP6zIZaLFOtdKBEmrMJXq1z5v3W+5npc2OTel3clk
           Xp6k+F/isCIbOAv2iVayrqMYbxqVioVlJdx5Ge2w5LOKmGwrr5g0s2bDdRQf/jhVvY
           DJZiICcrBCwEw==
Received: from 83.24.141.3.ipv4.supernova.orange.pl (HELO [192.168.3.224]) (olek2@wp.pl@[83.24.141.3])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 24 Jul 2026 20:00:37 +0200
Message-ID: <848f711b-a268-4d04-bf70-557d319b8da6@wp.pl>
Date: Fri, 24 Jul 2026 20:00:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool-next v3 1/3] sfpid: print all implemented options
To: Andrew Lunn <andrew@lunn.ch>
Cc: danieller@nvidia.com, mkubecek@suse.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jbe@pengutronix.de,
 netdev@vger.kernel.org
References: <20260719090458.659332-1-olek2@wp.pl>
 <419c2df7-6a46-47da-b4eb-e1a2f34a43cd@lunn.ch>
 <d3665805-2084-432e-b438-4c0e5969ff80@wp.pl>
 <0fe056aa-5725-44d1-934d-c5bf3ed3001d@lunn.ch>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <0fe056aa-5725-44d1-934d-c5bf3ed3001d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 4ae9c1cd808ddd58e7acaaeafc3d673e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [seO8]                               

Hi Andrew,

On 24/07/2026 02:28, Andrew Lunn wrote:
> On Thu, Jul 23, 2026 at 11:10:18PM +0200, Aleksander Jan Bajkowski wrote:
>> Hi Andrew,
>>
>> On 19/07/2026 17:54, Andrew Lunn wrote:
>>> On Sun, Jul 19, 2026 at 11:00:35AM +0200, Aleksander Jan Bajkowski wrote:
>>>> SFP modules implement multiple options. Before the “json” option was
>>>> introduced, all options were listed.
>>> Hi Aleksander
>>>
>>> This is a common theme here, the json option. Are the three patches
>>> for things you noticed for devices you have, or have you analysed
>>> those json patches and think you have found all the places it broke?
>> I think I’ve fixed all the broken places
> Thanks for checking.
>
> This is one place a unit test would be good. It would be nice to be
> able to read the SFP data from a file, and then compare the ASCII
> output with a static copy. Things disappearing would then cause a test
> failure. Also, we have had issues with the generated JSON not actually
> being compliment to the RFC specifying JSON. So maybe trying to import
> the generated JSON using the python parser, or feed it to jq for
> validation would be interesting.
>
> Do you have any time to work on such tests?

That sounds reasonable. Unfortunately,I have a few things queued that
I’d like to finish. Maybe in winter I’ll have more spare time and will
be able to add some tests.

Best regards,
Aleksander
