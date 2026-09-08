Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC237F8C7;
	Tue,  8 Sep 2026 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846708; cv=none; b=diem5NbEe9NSOvib1JG9n8db6WSD4GkcGz0reu5Ah1niiGOpmYzu4gPdhstsP0DbIfQo0P541JnvU1TG8/HXfqhpzkeis+v7L+6eM2h5wtLzsDU3knnpHjrbLUvCORQUJUpLukNtUit1vHon2JwyDu76a/O3MNEVT7J9DE2PRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846708; c=relaxed/simple;
	bh=p1lWKxqjXLkVnKy4VRqMBC3WZHwllPItxFyiRfleGpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I40EYsyYZSiO7TOGVWc1ALc7OiHDVMn0dhy95SV//Bd31bGNMNmos6DO6wAfBFyTh0NpIfLEfdjeCsQPfWLlGf3700kd99FEvhhGFTxrCaRhIo021HI8wMsPabsya4lvVCkSAah887a7DqP7amaW+/3O/oYy4KOIv5FTYi+bQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hEI+WL6S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hEI+WL6S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CS9Kzo9hjCgoY/ebMX4a6llaNutb9H5FCC13GmHGBYM=; b=hEI+WL6S4BD6EpAhd5u+0sXBv4
	EhFC7Z1hzizaAjMCNuhFuj1sRJqto4HJhslO+2h2CfjywfaNzMOcr1H0jHc7AK9ixllauY0YcJiAN
	rHCYu8PIEF0B9E5il6zTrxDWSthsHsGhon5K60zNwXpInOMh+G09hPvgG7zS1FLQAm6g55GzJFXiZ
	iXMRxaoyXrlkdzSeUbsMKf2TS5kzS5Gon06XqcwatYdVtoFSxwg9vMyxl3joIsDZOkHNlvSVqNGc1
	3f13A9ApkeKhcTfrq5Z5Gn3DpHPphv+EaU4tWAr2FKPiPhqT0cRVRaM6aO8VRQpchKqunbVBeSio/
	WvKRgnKw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3ok1-000000086w6-2wAk;
	Tue, 08 Sep 2026 05:51:33 +0000
Message-ID: <8b923faa-4676-4487-931a-98d84993517a@infradead.org>
Date: Mon, 7 Sep 2026 22:51:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
 <20260908054643.11460-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260908054643.11460-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/26 10:46 PM, Hemanth Selam wrote:
> On Mon, Sep 07, 2026 at 10:27:00AM -0700, Randy Dunlap wrote:
>> How did you choose iwl-next as the target tree?
>>
>> The closest match to that in the MAINTAINERS file is this:
>> INTEL WIRELESS WIFI LINK (iwlwifi)
> [...]
>> but the patches don't touch any of the Intel wifi drivers.
>>
>> I expect that you want net-next there, but I could just be confuzed.
> 
> Sorry, the prefix is a confusing one.  Here "iwl" is Intel Wired LAN, not
> iwlwifi.  It is the prefix the Intel ethernet maintainers use for their
> next-queue tree, the one in MAINTAINERS under INTEL ETHERNET DRIVERS:
> 
>   L: intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
>   T: git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
> 
> Intel's own developers tag patches for that tree the same way; recent
> examples on the list are the ice, idpf, ixd and libie series, all
> [PATCH iwl-next].  Since these four patches only touch
> drivers/net/ethernet/intel/ and its documentation, they go through that
> tree rather than straight to net-next.
> 
> So I think iwl-next is right here, but Tony and Przemek should correct me
> if they would rather have them another way.
> 
> Thanks for looking.

Thanks for the info!

-- 
~Randy

