Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4736E484
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843653; cv=none; b=Ah7EUsVYu2xDBdpkiBo8DZjycw7galJ9PHN0OlnU5Yskz29CgBYpmLs1kLBjVbbMmmQvgIdgH4uuNqTBFKtxnpCRhlqKuYqTH5YL4yrQgx+6Az7hjFmmL0zrORUvbpP5XUsTz3kFfbwJNjTcYKZ2cJx2BTWdsvxLEuOA9f21U3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843653; c=relaxed/simple;
	bh=N9rHm4Wpgn9uZspKF3hqZ82JDWaIfZq5rRKp+x4f7Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOBf97x92Ckgl8K0BPvhbvJgPKh/XZ5JcUGWvas8JI1GBKRA4PYwZFSJ2bY6ln497nIGpR3z7u7ee1AXtVL2S5lZ2E+o+0mtqxW6JMbkGccWPGZrjB9ejBt7f/aVyd0JJl3ivu0zQV0ymvhbIHjdTkIrcYkBEmUABIDyqrc+YcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hTfvsuMZ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hTfvsuMZ"
Message-ID: <18c4a794-49f7-49db-bfef-a0e018972f74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785843638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsGPl9NXcf2VLsWt32/ibEgh4Ed8PyEs3/w7+z6s80U=;
	b=hTfvsuMZTzj4wxeXtpBYj13OvQFFphFvDKUvbXvXf4HHt0cm9KSJ729U5gjK8QqagGCw7w
	rhjI+f2pjcbiUyLpME9u0zDflQS4DC7uyoUVurXYkD7p8VhR/3NyOmszcnUK5w/iOhcIJx
	Pwh5U5LSJ3a0U5Cgp5QR0Q54NdgOwlg=
Date: Tue, 4 Aug 2026 12:40:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260803142830.5020-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260803142830.5020-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/08/2026 15:28, Sagi Maimon wrote:
> The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
> that is programmed over I2C using in-system programming (ISP).
> 
> The CPLD is connected to a secondary I2C bus shared with the onboard
> MicroBlaze soft CPU.
> 
> Add support for CPLD access and firmware updates on the ADVA TimeCard X1
> board by arbitration of the shared I2C bus, CPLD ISP command handling,
> status polling, and firmware upload operations using the firmware-upload
> subsystem.
> 
> Add the following X1-only user-visible interfaces:
> 
>    /sys/class/timecard/ocpN/cpld_device_id
>          report the 32-bit Lattice MachXO3 CPLD device ID
> 
>    /sys/class/timecard/ocpN/cpld_status
>          report the CPLD status register, including the DONE,
>          BUSY, and FAILED indicators
> 
> Firmware updates are performed through the firmware-upload framework,
> which acquires ownership of the shared I2C bus, erases the CPLD
> configuration flash, programs the image page-by-page, and activates
> the new image using the MachXO3 REFRESH command.
> 
> All CPLD operations are serialized and coordinated with the MicroBlaze
> firmware to ensure exclusive access to the shared I2C bus. The added
> interfaces are available only on ADVA TimeCard X1 boards.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>   
>   Changes since v8:
>   - Use dedicated MicroBlaze handshake values instead of 0xffffffff,
>     which may be returned by failed PCI reads.

Please, combine it with comments on v8

--
pw-bot: cr

