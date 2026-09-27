Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A863C1F4B;
	Sun, 27 Sep 2026 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499929; cv=none; b=RDOtLaj+dGMJpFEYLI8tCpdCY88JMzoJZa8w0yRI5VQGveBYy3sa+P0fRWzlU1FuDWG8Ec1Kq93QXnq7XySJkEerAWYutPjfaFhtpiwydzWCpBl8Adg0S8+uHgseL7L522q+wjV40U3HvvlyryuiHs2HlvXnAaJG+Tr9LqOMqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499929; c=relaxed/simple;
	bh=FGYMbX4aa+5+V2NKYcq8D599UYU0Bll/uezqGx2FBiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oy5kOAcnMMXjYGD2t7M8ByXzxbMbIF8MKpQgQPo2lB8X4o/4DE/6dvNvK/UUyI54HAyK8lJRrxti5v+ODdNSRMf1acJPw9pbVEYWCgv/XaQh/+YaIQGXX//ukm3zelt6mG2BZIW0KmyS+KCFkQuOok9sDUkURGdMD5PIVjLX7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=07Gvuvem; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Wl8ZqoFE; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="07Gvuvem";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Wl8ZqoFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499926;
	bh=FGYMbX4aa+5+V2NKYcq8D599UYU0Bll/uezqGx2FBiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=07Gvuvem+irQmsR5FkKNn+LU8uZoVMUpWTT35IRsWrm2REh9DpK2O9vB2HRCDz+eI
	 XI5cSZGB6JKCVU4+6mPiOyXE4wT1LZNFO0UuINQ6wBk00oJzLYSFgszVcvC7UPtBrG
	 xRo2hWtfB5PV7/WrCE0Ci9x600kIYRcOn4hgxcRU1BUn2FaUPfY67r87sdZyN9E+w1
	 WNuI72SBbXwQ1VuFYsNPzqtMqD3tjUKsSApJAz5yUAM7d2oM9RLJFZ8qeY0pW5F+OY
	 axfU/BK9qi6/N+Pki0QFNh+v1oC3293fv6DI6ixaXnE/rAhrzQKXVKNaoqeOnIziCX
	 TXhK0D8LwSGQA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 08CF0412E8; Sun, 27 Sep 2026 09:05:26 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499925;
	bh=FGYMbX4aa+5+V2NKYcq8D599UYU0Bll/uezqGx2FBiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wl8ZqoFE9EcAajBTlniaU6VeOtrNSDBBfwxwceYsb8+CLCJKcB9NZUkaZJYcgnYxe
	 OB7bHku+nPfuINtk7lSyQ6bPI8SW98qhWB0rIYiRBT1I79fjriw8TCgbWDQ1og3uJH
	 n1KIXdG/Kx5r0Q7Fiacqnl2xd7FUihTgV6OlnOxFzMqelDj2VBs46lZkhmt6xZyqVr
	 +YCnMx3lY/CdOTQlluz/G0Nd1DzmmTfV7GY2azKetPrs/qo6KApsRVFMDXk06ZuMWP
	 VzFuGJaZxOMES2FLkV18MHK3PRFJ/OL4becR5sf2ZS0X/skADiDWHnTIHwlY8wAHTr
	 WrsZX+qh4tNGQ==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5F3C0412E0;
	Sun, 27 Sep 2026 09:05:25 +0000 (UTC)
Message-ID: <a347428a-980e-45ef-b478-df25db63f1bf@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:05:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 03/15] ax88179_178a: Fix endianness of pause
 watermark register
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-3-60c04c9924a2@birger-koblitz.de>
 <178968029284.22033.9805083282551581110@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029284.22033.9805083282551581110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] Commit subject/message mismatch: the patch is titled
>    "ax88179_178a: Fix endianness of pause watermark register" but…
The patch does what it is supposed to do, it is needed when 16-bit 
access is done in later patches.

