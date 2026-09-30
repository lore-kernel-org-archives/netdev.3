Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA233BE15F;
	Wed, 30 Sep 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762508; cv=none; b=WI2FR4DbsB3ourK+n59OYCcn/gU6Bt0RYYA2a/rPCO7yO3GN/JEIw0YQxdT5hLHeSnNXZ5sLeyIlKo2G5iqg22UpGKrRrVtm7C4J1jYAzSJyVakW8YP9MTHtrZc3ndIzuDb9Z+Z6YdiAXSj4Q/AxwXK264ubYgE6EkqkCuUV5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762508; c=relaxed/simple;
	bh=7aT6bgcPtCW5oehmL96KGS4fT0bM4ebVvrP97MFYTVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rtegxyq8b3xfyx2McxQGg9pM/36xygk41HYov5V7xnNiWMvFcBWxhFZ9XWOEALTyNToVhJcajGlpPwzVQsmUtofszFcciSYtIyA52px4XV9vd9WyLp6c7ZMSlLxAaxdMlKMJQv9Xc2YmeGsnsv7QzgSUOw4JIf9SQcEZNUY9+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PCYs5c3S; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PCYs5c3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790762506; x=1822298506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7aT6bgcPtCW5oehmL96KGS4fT0bM4ebVvrP97MFYTVs=;
  b=PCYs5c3SGW3FOYYftqM8YH/0tMZAHUqejxSyhiW1PUkUVzyDTfMdEALU
   X59/zhNSdctvvqxzJryUjYcuKgxvi0Z9mHwFvrLxOk/RbfIEaJIh0/bnt
   fmBLEUCr4dnDJXmu+RS0HsbRGtj8DAJM8Mnq/p4qbQAJMAttzmfZNHe/T
   B433/npNo1E7s1+6moFTQPMnR34VjMphtfSp9zZdB36RA4cXL9z/jwGD+
   B8po4SIYnb2MzmJYxZk4ADQrt+VnDeSBA7KUPe+6OcnYKENctbZ/bQkDq
   NuUMjS4u993v7OIuuI1hvVEFFbMbRFy+ZNOwvBQe9nA98EPGOApmDSlO4
   w==;
X-CSE-ConnectionGUID: l70GvazLT6CO1ji4/fGI7Q==
X-CSE-MsgGUID: LVwpygnjTQOmfk5PeePuCg==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="295774315"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2026 03:01:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 30 Sep 2026 03:01:44 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 03:01:40 -0700
Message-ID: <ffd9c6b8-1169-4fde-ad84-581aa27ec827@microchip.com>
Date: Wed, 30 Sep 2026 15:31:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] net: microchip_t1s: fix collision
 detection on PLCA status change
To: <netdev-bot+sinfo@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
References: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
 <179068710834.31693.5197444123173344784@kernel.org>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <179068710834.31693.5197444123173344784@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the feedback.

The issue was identified during production level testing of the
LAN865X/LAN867X-based system. The issue was observed when the device
transitioned between PLCA mode and CSMA/CD mode based on BEACON
availability. The existing collision-detection handling did not
correctly track these autonomous PLCA state transitions.

The changes were tested on a Raspberry Pi 4 with the LAN865X/LAN867X
devices.

Best regards,
Parthiban V

On 29/09/26 6:35 pm, netdev-bot+sinfo@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

