Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3F78F3A;
	Sat,  4 Apr 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274895; cv=none; b=WM521jDVduOnhn/DMQjj0aDPUHjOyKN2DLHmVWgrGQ9ZrFN1l0sAbDmNJmTWnf5wlkcPEUYc8EFslyxgG30rIAvf1OGruZclWy4Y0xirzNceqyzzVXmf6yFvDL2w8A1VbmKunrg86zxZ5Yr+Zzn0EdHhghEfh1jbJXCbkCfUOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274895; c=relaxed/simple;
	bh=AAYmdt/Dnap9XAHFGOKF2baEQgufyVIzPcYtTPtSwk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP64YSc4sckAEdpMheACYE1p2Vcrpo72pxTAX6fR4VupJP/mrlr5t3VW0b0NWkZ2aYC/LGpsF7OHIZpOVhcuc1oclcjDz5s/aIO7d10N5DHIPmocQBywsam02kBft/FgQTOlyP7VjOIQldkqMvMLIMlsG8mIlAvUlHOwbj88URo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=hW9/nJjm; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=wLdCg2j8; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="hW9/nJjm";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="wLdCg2j8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775274887;
	bh=AAYmdt/Dnap9XAHFGOKF2baEQgufyVIzPcYtTPtSwk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hW9/nJjm3wU4sgPfi6LeQ8saQ1U+ZpMAJFo/Sc++wjRUnTyGnQFaFpuZXGwNLernr
	 ml6ercsdDdnLWgLzidmeoXfwq9scTd1bPhSBDmk6hHU9S0XR/9+6JeYrSLLoCA8Uox
	 lfzNxJ/AOj/mEgxOA1wXM7YWFUuJVu0napj+8b+Q7AzKqj40eJTOi9K1DhMfWeiAMM
	 pEY478ADUJpQerslOdleCjkq1XMzFhQya4QcryqMP5cns866Ls2Y9G5JelmRvY+l/Z
	 kXuwasksMUZjczoxKMEcY717BYW38PfJXSyZl1UscR57nVakDLOorg9NpwU5ZcByo9
	 YSmCwoJbxA17w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 97ADD40909; Sat,  4 Apr 2026 03:54:47 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775274884;
	bh=AAYmdt/Dnap9XAHFGOKF2baEQgufyVIzPcYtTPtSwk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wLdCg2j8xhj3cyo4IM2tlQdDpSrApCPTlmvcIAsp5AnEz6H4g+5xYomMYvoEH28SM
	 WjPsD5K9177MtZqY54IAq8cW9BadTTXb2PEmeD/ANkOxlICM0oQsT4KhLP4dlmT/r7
	 5rrjp/ToOuMtBLo8K5/ZNhnPYs9c0TB/AYAtA2hflsZpmFk7oAX8re/hKg8NE14P2/
	 pMZvcsq37vbAdah+ZSdbIqO9+oFCITdEbfCzIP4xKg1i3FW5si1Ue63I+PLDqFpMR7
	 y7foX8unZ1Xb/8xcjzIDLwUw07XZNsGI0ftPYl8RxdFtIxZ2zlkgQrUssqYuBb1sPf
	 P8/RmjmewUFrQ==
Received: from [IPV6:2003:c6:9f04:eb00:4ab:5ce9:e9e2:2ae8] (p200300c69f04eb0004ab5ce9e9e22ae8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00:4ab:5ce9:e9e2:2ae8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C5F243FDF5;
	Sat,  4 Apr 2026 03:54:43 +0000 (UTC)
Message-ID: <741bde66-45b7-49e4-88be-7fb1ca8a92df@birger-koblitz.de>
Date: Sat, 4 Apr 2026 05:54:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de>
 <20260403160608.04f2408b@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260403160608.04f2408b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2026 01:06, Jakub Kicinski wrote:
> On Thu, 02 Apr 2026 10:28:12 +0200 Birger Koblitz wrote:
>> Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
>> chip in the RTL815x family of chips.
> 
> no longer applies, please rebase & repost
It looks like you are letting me play out the story of the hare and the
hedgehog. If there is no interest in this patch series or you would like
it to look different, please let me know instead of playing games.

Birger
