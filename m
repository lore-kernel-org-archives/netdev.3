Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0948BD3C;
	Wed, 22 Jul 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710535; cv=none; b=dCQ1V54VT/KblzSlSLgF0+MvWXhORTqDpm9P5I7TBM6+JNtcHuR5Iz0i+ebAAupDTjo+flwqOFljKWb401Dlork1HClBN3p4yRVJ1IiEhuYlwPovbCZ5iQfgkkCe/5Qv6YppFPXY6RFbiz4wvxhBe1crcb/Y1POIeHyHTx+w0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710535; c=relaxed/simple;
	bh=sYBDCplp0PYxE5IUJl0einJORS/M5pd8IUu5wUghyHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxlEvI71ZxbqTmZZ0o33b4ZnF7OKEvnXP+0S994fuhETDJWbyALnbgadsiYisqHf5VDdm77+/M+Ff9yPNSEsWDIAaZWVSZih6gt6GDDc93FER7MSuqru8T6uILPB0tL1JmIc8SAqmH3bR+wuvZJSJYhww7PajolY+ZxPuzG7OZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M40REd2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M40REd2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62D11F00A3A;
	Wed, 22 Jul 2026 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710534;
	bh=5hix3vWQwiNvl31DkSC6ft7VTBVCySt1FdSQ5y7sjMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M40REd2CUzZZdGozNjC5VwFjbjOlN7u5/it3SbTsPLhMoYgmIFYlLOiNp0hlI2h+s
	 sjAslsqyTPoI2Yk6jrhc/EDJxNW8q/T+TkkN6c4ooUFvB8SnrVsMOKJCa3tl1H9qHL
	 moFEWNW98fMax007h4SWN6IoGIEaxM9FnG8yI4eaCxWhOJMmV2sBaQL4/GBvXqXvJ7
	 zZA21WiV7Toyy1qyv5wkAnKjRMcjhJlzcw/F0EOjNw6Qlj27TOmV8CUZ5KFDReBah4
	 RJWDPA1fVW7whh74ISCLs2z/SKXlcsnV0LaUV8Y3MXxlLv5w+00r4jDtOeNOBUmz8P
	 c9E6hOtKDkEKA==
Date: Wed, 22 Jul 2026 09:55:30 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v45 2/7] mailbox/pcc.c: ignore errors on type 4 channels.
Message-ID: <20260722-rustling-taupe-sawfly-83c3ac@sudeepholla>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721175258.87600-3-admiyo@os.amperecomputing.com>

On Tue, Jul 21, 2026 at 01:52:51PM -0400, Adam Young wrote:
> THE ACPI spec states:
> 
> "[The Error status register] Contains the processor relative address,
> represented in Generic Address Structure (GAS) format, of the Error status
> register. This field is ignored by the OSPM on slave channels"
> 

Does anyone have these error status register for Type 4 ? If not it can
be optimised with that check rather than channel type check. I would rather
avoiding adding checks on the type of the channel everywhere in the code.

-- 
Regards,
Sudeep
