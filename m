Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196D2F7EF4;
	Sun,  9 Aug 2026 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786246800; cv=none; b=auOsx+JmppdT5zgQSKImrP5VQlFr3xnW+BLBFMCrQPrjdA9fzvKB3846Yf79yMPaM+TQU7kegHRePp6xveswQdJRFakryJWcNqRV0TW+BijUjJnevHh/UjNkG4Of+M35Ftw87aX3dSY+5oHs7/XVBiJ6gNeH+j3g3WOWhl24KkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786246800; c=relaxed/simple;
	bh=a52wR0nLqljWi//sJy/SOb9afT+Om7Jn0lmH6gabtHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCpVV8kQm558tQyTuUnqTzE8RatchxMKfP1Jn7Td9rIIusRNoP+69A+rvyDsBrA6wYAffPQjCN8ZyX0islRKZ22aziskaOYDbZoNrHkYmMzQ6e64OvE5fouBtVw/6uFGfB6wX7W8t18Wa+e0aDy/oY1IeAdSe70Q0aZs3hHHy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qdO7pT5b; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KjoCEsae; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qdO7pT5b";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KjoCEsae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786246790;
	bh=a52wR0nLqljWi//sJy/SOb9afT+Om7Jn0lmH6gabtHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qdO7pT5b8V7EymWc0SdAt7WVOYpNlaWFlXW1hOQv48SaM8cuuCoAGRbiyUgq6as7g
	 7b/sGyxuBfYW+VsETIAEKRyGV2iI1pKAq9vRgqECKRt4M1eFF393T6AETBC/Gf3JD0
	 QPpsTGsbQh/H0s/YhRTbOTpPCyoDTHPk0xaJKb1mFHbZ+7NLW7gT0ZaPg6d5A0uGRx
	 FacDvsr4uYSBrjs5YC64MMPgzNU9JGCzTWN0YNs2XBQIh9fncF98PqCU8bxnbaUxau
	 1+o0dW+llwX7l8KleMsD/ibs8an0mHCQ1F34MFh+kukKONxJqaSw0i4E1cUn4wmgZG
	 fcY75QvTMMdnA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 453DE49750; Sun,  9 Aug 2026 03:39:50 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786246789;
	bh=a52wR0nLqljWi//sJy/SOb9afT+Om7Jn0lmH6gabtHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KjoCEsaedZaOm6kU7AVj/dRKGpDbG7AY7R5jxW8xdgafAmuiUCP2h1GzL5TLmnVNj
	 Y5V3jDVwEXBpbbGpwv2BkROULIZZPwHXEgGLuCFe65ghzPU20zP3RQArRjjMob3mhM
	 Mch5gjRHhehXnskFexAedFb27KOY9WEjbEs1cfwr6lHOLM5Y+9y+cZ4/WWQRqI5L/B
	 yjDf+rq9+0MpaoUE/A34qIWh66hGMELIDzZodqI/Gs2aUtNeyxmeYGrm+36J/jL8xw
	 AJgI/XAKeyaLzNM60AZqR8wZkcjEjIPTiltMG1YspFTZavTpFvmZK/JN9zc1ZhAshF
	 80C8dWBgvmtpg==
Received: from [IPV6:2003:c6:9f06:3400:435a:e092:2ab7:871f] (p200300c69f063400435ae0922ab7871f.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:435a:e092:2ab7:871f])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 017554130F;
	Sun,  9 Aug 2026 03:39:48 +0000 (UTC)
Message-ID: <66570e9e-97fa-4fc6-8238-0968c59e15be@birger-koblitz.de>
Date: Sun, 9 Aug 2026 05:39:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/13] ax88179_178a: Split driver into library
 and device specific code
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260806-ax88179a-v6-2-fde7414619e6@birger-koblitz.de>
 <20260809005732.3084198-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260809005732.3084198-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/2026 02:57, Jianhui Xu wrote:
> Hi Birger,
> 
> I noticed what looks like a typo in the newly added `ax88179_read_cmd()`:
> 
> ```c
> if (size == 2) {
> 	u16 buf = 0;
> 
> 	ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
> 	le16_to_cpus(&buf);
> 	*((u16 *)data) = buf;
> } else if (size == 2) {
> 	u32 buf = 0;
> 
> 	ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
> 	le32_to_cpus(&buf);
> 	*((u32 *)data) = buf;
> }
> ```
> 
> The second condition should presumably be:
> 
> ```c
> } else if (size == 4) {
> ```
> 
> The original implementation before this code was moved to `ax88179_lib.c`
> also used `else if (4 == size)`.
> 
> As written, the `u32` branch is unreachable, so 4-byte reads fall through
> to `__ax88179_read_cmd()` without the `le32_to_cpus()` conversion.
Thanks Jianhui for reporting this. Indeed, this was a typo introduced when
updating the coding style for the original driver function that was copied to the
new library file. checkpatch complained about the old style.
Will fix to read (size == 4) in v7.

Birger
