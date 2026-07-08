Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00194A33F9;
	Wed,  8 Jul 2026 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535598; cv=none; b=l3jIE6AWcsfPoNxxzxnXF0N3+MFCrbE3iG/SSoQ8PU3N/WrG+OGz+jTunrryvoX+hPFfC6ExF//HTkMv3e4rFyuF+n1d2oXPVHp7uTBky5i51PXNS/flDNEx3Zkb7+2fiAWHdo5LjtoPG0GWYzUtBEywjIAKROBtk5AaFVirZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535598; c=relaxed/simple;
	bh=SHI5KTZNWDY0CQvUxVxI7YMd7s4gc/kSpjALzk9EBxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJOh8lSBGhlOGxTpv2p1e4lRABs9Jvm9fRyXV7BURFfDA4pDEZL7KpzDZuybzLWYFWrHzygsiTo2q7zaHmEwMzIASpPngU2bEkjjut5ADqgnGbG/iHxOgs0D+oz1GJjo6TyZmfHLkp2guI/lySCaieofl32vdJHSZbaUdGkjDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ezuvkAJ0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ok4OoZ91; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ezuvkAJ0";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ok4OoZ91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535596;
	bh=SHI5KTZNWDY0CQvUxVxI7YMd7s4gc/kSpjALzk9EBxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ezuvkAJ0wCqoixNLhu5g4FH4f35exmpFDxa9NPdV5aVKDseIkGI2THILAPZ464Bvq
	 puLhNPOhMRNPUlfXP+1Jojgx8EhLB8RXyF27RQgPfOifMSLFcMxWk/tRfNHnklV+2x
	 UE8czwLzmUFCVxVlPh2g1kbgruuVcZ07P5nnlolcg0+m0qKJVw05heA9IxCr5MgJg2
	 5PB19dUIATqdaT6JozJGPHfoAkq206rrANekMoi3xkYL0HccwOt0V3YhUcTkY8EWq7
	 IGvgisIesLIaEYrCu9MH3sE1rloMUoD8qfdDvCvdFHwYMiwGyMQy3Obo8/AyKQtIh0
	 MigvsGSx2vB1w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 06B7E493F1; Wed,  8 Jul 2026 18:33:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535593;
	bh=SHI5KTZNWDY0CQvUxVxI7YMd7s4gc/kSpjALzk9EBxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ok4OoZ91z6dPOBWIto3LlTB+11FOmVvTFmc3lg5nsgRZihD3iChA6PIX+2uD9ssnC
	 jHwbea8WF55nY6BGScdytwuJqbl4phdPW9H4dHJ+owZ174sODkiJJI/h0qw+7FIXGz
	 C+ogybmwgiKntORZbInxrg7XQNybv96fHL0fCYOYyhCY8p9IaQWnA9Q4AHg5JatVbp
	 v2tlV+Kj7oHZK3BCGiCp05B/nUzUasdcz01W4x6LXW/XVnxC3KreEG6BIyOqEZR9nI
	 syUm6ST6AdsEsUzZqD1usYfmvGKdS2eNVlO501TrKB/IUS3/mh46mkbCMCetPRZWxR
	 qXMi7+ALt0GXw==
Received: from [IPV6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd] (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 92C30493D0;
	Wed,  8 Jul 2026 18:33:13 +0000 (UTC)
Message-ID: <2567e897-87d3-4afa-844a-53980658dfec@birger-koblitz.de>
Date: Wed, 8 Jul 2026 20:33:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ax88179_178a: Add support for AX88179A MMD access
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-3-13685df67515@birger-koblitz.de>
 <b01b4c18-bb2d-413b-a993-4a9cf4d50549@bootlin.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <b01b4c18-bb2d-413b-a993-4a9cf4d50549@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Maxime for reviewing this patch!

On 7/1/26 11:53, Maxime Chevallier wrote:
> ADVERTISE_RESV isn't an unknown bit, it's been added in 802.3 as ADVERTISE_XNP
> for Extended Next Page, see :
> 
> commit e7a62edd34b1 ("net: phy: qcom: at803x: Use the correct bit to disable extended next page")
> 
> we shoudln't use ADVERTISE_RESV anymore in-kernel (there are a few callsites left).
> 
> As this seems to be a vendor-specific behaviour for that bit, please add a
> local #define for it in this driver, to make it clear that this is a device-specific
> value.
Will fix as suggested in v2 call it AX_ADVERTISE_2500.
And btw, I have to mention that I used the cross-referencing of bootlin
a lot for writing this patch-series, and it was enormously helpful. Thanks for that tool!

Birger
