Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E43EF0DC
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841026; cv=none; b=T3ge+2xV/Dw6HgAj/h7FLApp9bwSy9j1XrKqZ3LvI11e8ODJpks+WbfWEercMRabPvXVdTPYaLlGPJJ6wIbFtEGBa1QiTZCHgWgsdQl7/ZFV/cp4NwQc7vvyV40nNu+eZY2sdndDSVroOZitvmEbshKJHshBa7Ra0RAgte/7uHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841026; c=relaxed/simple;
	bh=+sRYIICTeDsWpxwN4rVMHGQi3H0f+n5S8Sb8FI0WAMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl/PthVkp16jVjvimt2rcvSGjxE/BzNsGo12OckpoQiC9OZ6h95w7wc+0nmGmtpZO+4QzJYp7pQWys08O216hwZJ291FJ4Fug7Hqe4XM5bqjdGq377DM0pcmnBSLyGkyW42hygdTPRQNItaGc35T7HV4aRON6MOSXq9T680r9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=pnXA2ruL; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="pnXA2ruL"
Received: (wp-smtpd smtp.wp.pl 26550 invoked from network); 23 Jul 2026 23:10:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1784841018; bh=+sRYIICTeDsWpxwN4rVMHGQi3H0f+n5S8Sb8FI0WAMo=;
          h=Subject:To:Cc:From;
          b=pnXA2ruLzpqEf43x7MEG2p7jk/7e2pm4h+VcizEQfzkGFkWd3sBBCGEWFmdiw0ZPA
           GYYN+PRCAXDpO2bxDTi2zoXY/w1ErVYE2zwPrHYTKsKUUM6qyH8FboUq7JlsU2VGJe
           5EnpwC9yfbUPUhauPrSYjTTLSmYI+f0Gz123pS90U4Hq27wxgDNXifogNXh5p4JXfa
           ga+eYiB+OZK8h1JPZggLa1YwB7WQUByBRtCm5QO7WvU8Mkr/+6m+KxWMFxFNAw1OaZ
           HtGfUp0G6bI+t0+DKhQBSjS12sYT5nVmIxQR6zW0f5z1g5KNOKHT5bygXOA5wgsTTb
           FtCA1ibO/2tGw==
Received: from 83.24.141.3.ipv4.supernova.orange.pl (HELO [192.168.3.224]) (olek2@wp.pl@[83.24.141.3])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 23 Jul 2026 23:10:18 +0200
Message-ID: <d3665805-2084-432e-b438-4c0e5969ff80@wp.pl>
Date: Thu, 23 Jul 2026 23:10:18 +0200
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
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <419c2df7-6a46-47da-b4eb-e1a2f34a43cd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: f91b0447c371369ad281fc19cf1ad848
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [4ZI8]                               

Hi Andrew,

On 19/07/2026 17:54, Andrew Lunn wrote:
> On Sun, Jul 19, 2026 at 11:00:35AM +0200, Aleksander Jan Bajkowski wrote:
>> SFP modules implement multiple options. Before the “json” option was
>> introduced, all options were listed.
> Hi Aleksander
>
> This is a common theme here, the json option. Are the three patches
> for things you noticed for devices you have, or have you analysed
> those json patches and think you have found all the places it broke?

I think I’ve fixed all the broken places


Best regards,
Aleksander

