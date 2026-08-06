Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B3494804;
	Thu,  6 Aug 2026 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045121; cv=none; b=KPHH5HjA66ZRbQNVIJ5wSuGXWRu7yjSaEQ0TEkUxJAiSbCohyLZJva2vtDLPVpfwsOEDZHdgpdGhmAbR5KmQhi6qGNdK1NzbJ3JIt3axCIMkGwRInuamTK0bCKvYaUCc5fNzm5kUoWQYfShuOqWVU634o1eipriBnvu4fndXDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045121; c=relaxed/simple;
	bh=aGae3eEx8Va1clbVfvjWCfnqrPA4/3+yjFVGcXnVIas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Psuf1kzAcfAwiw7/RIGqfPMDL8fdRi/Q+6BbAsl3DJd1gmfgVaCl4Ng8h8NCVpiqrzd+scy7tC1VfjDLPoi9E3E1RoF7BUgBYIsAlqvvqNHUiSiWwq3pDRs+CT+XKrVoPl27Ebi2Ey/UsO8kAnoMqoebblSEhThNmfEVKDv4Ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=uxJpkLsq; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=oc1J7UNQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="uxJpkLsq";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="oc1J7UNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786045119;
	bh=aGae3eEx8Va1clbVfvjWCfnqrPA4/3+yjFVGcXnVIas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uxJpkLsqzyLI0x/6H8CseTNu7rc5DoOMaWvMiUi4LN9jcCkfrRa05QXh+YqjpDCHj
	 ZrOTAzeMeQzsldeNTb/09JAMOArlLn4KyKN4KIJl3nfhBZ1LG6kFEZN+/Gf2Jq9sIE
	 aQBTJsVPcGviegdjFhMpz7AFHhYFTg4Xq36YGRnGM50E4bjb9+mzp4wDRPE7Q08tJh
	 7A5wpvzt5+yHTjW8PIKXIejjIjS23YToM8x7koRfSBmwnP/mHfQAkkxnrYrD4gbnFu
	 d8gbEOkwvU2mOanBZZNHNb8HkULLj6H6DoJSH99R8frBMdupBoA9uSew9Xj3RI+hdr
	 WahA5Vbf5KJZw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 24F0A496F2; Thu,  6 Aug 2026 19:38:39 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786045118;
	bh=aGae3eEx8Va1clbVfvjWCfnqrPA4/3+yjFVGcXnVIas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oc1J7UNQ5oqNjvATbdY5aDHGVRCvvahLdlVSKtUucvt8q0wV3lbtgSUvtXQ7jbsbQ
	 6YnS8OcxrCiTK7IqpccagrbMHZfZD0VJtm7AUmRDdKRRhoZ4btC1EcZyrQjDSsDtSk
	 YXpk5IzDxtRZsO9Og7hC+7t00z7Fi35XRGEdyepnStbSz4C/z/94xWQyLRToljSwml
	 pMz2oS3JmGQHw4KO6skYnnfxdXmmYGbtCNSegE2dxVQ2+8ZYHZifpSyr2rNrZj6XmM
	 +chJvmJyWVnnVKl7cURxMKNHPzJo/4VyEUEWa+3aGxTkIUomgyvQiWP+YOerx5psgB
	 brpkZJ3VuiN9w==
Received: from [10.30.1.58] (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D2BAD496F2;
	Thu,  6 Aug 2026 19:38:37 +0000 (UTC)
Message-ID: <48bfa275-0a70-4489-9440-e1db80bde38d@birger-koblitz.de>
Date: Thu, 6 Aug 2026 21:38:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/13] ax88179_178a: Add support for
 AX88179A-based chips
To: Yuan Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260803073348.2190800-1-neuromoments@gmail.com>
 <82acabcc-7b98-468a-a989-cb95f620fe5f@birger-koblitz.de>
 <CAMdPb80_Y8Chkoo4a+VJQz3yPa5YkKWHvAvXYjb=06BveBjP6w@mail.gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <CAMdPb80_Y8Chkoo4a+VJQz3yPa5YkKWHvAvXYjb=06BveBjP6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yuan,

On 03/08/2026 16:39, Yuan Xu wrote:
> Hi Birger,
> 
> I really appreciate all the work you’ve put into this!
Thanks so much. And thanks for testing!

> 
> I’ll apply the fix and run additional tests this weekend. I’ll report back
> with the traces and any reproducible differences if I find them.
I sent out a v5. This should fix the issues you reported. I tested
extensively link speeds and resume/suspend using a laptop and a loop-back
cable between and AX88279 and an AX88179B using netns. I tested around 20
suspend/resume cycles and found no issues even with different speeds with
the fixes in v5.

Cheers,
   Birger
