Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77225785C;
	Fri, 11 Sep 2026 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170770; cv=none; b=s80/EPIClrR/4fGuKhzydcq/eiHv3GxKplh5dSss8z86a3oa3qosg6h8IZlG/qRsKbYw17IRTRI30LkSkGK7icnm5UaX2j2dEuucpYAM5v51xGD7TiLxi+9l8MbWFRQKQUJItuYqDqiu78RF6GDm3/MX8MLw/FPiKEECTXA7pbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170770; c=relaxed/simple;
	bh=XttBEPsQUelM+HccKylQdUSHN8kSAxMuXQsG5dTz6sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJvMMsaGawiHZ49TBwljRvA3XlUEwKAFmkffafrJkNhF9/N6OY1X7shM1Rc/nIHweirYLA2iSyma46+e2fsLOs0Y8nRPqoCCdJQIyuoHFpoR0pjxXZ8c2kZcHNXnFIUTjTn4SDC7NhZ70mCoIO1f7fegsfrdNtgj+v2p8G0LZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJMMJLqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJMMJLqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D892A1F000FF;
	Fri, 11 Sep 2026 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170764;
	bh=P0wUoQu1ZN1UBeS12/39aCloqgeofrOz2NePkf+kb+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LJMMJLqPTUTnA7ML9/aJjXXXWlx/SrWcOHRR7MYfFC5gt7cKy7C2Ewk8lxpBQMeLL
	 qTKms5t4f0/8c+HTH8AqvUtcomfiPLPcUnr9mzD+9FJmT2s80ldDuNfGwPqVOnhc1F
	 0uLmddLtpJizpQ6RIzyHJuKaGLEFA+uKPIIgBXpkmLdvbQSDdfROIPsKEJbUwAzMTV
	 hbI9jG0mTnLRUov3+27Fiv4KDkVNoNbw6RxZPLRT2yAdseVokhc8ODJJ86NEAFb+L7
	 fNw8iSQZI9rtorY+Wjaj9fwhAhbX/AlvRn956kA5RQDXk7ojWmOv/9DV4H/kvTqyt+
	 x8vDTWFxfr3Dg==
Date: Fri, 11 Sep 2026 16:52:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 1/2] ptp: ocp: add TAP CPLD access for ADVA
 TimeCard X1
Message-ID: <20260911165243.53764253@kernel.org>
In-Reply-To: <20260908122328.52641-2-maimon.sagi@gmail.com>
References: <20260908122328.52641-1-maimon.sagi@gmail.com>
	<20260908122328.52641-2-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 15:23:27 +0300 Sagi Maimon wrote:
> +		  done=<0|1> busy=<0|1> failed=<0|1>

I think the sysfs rules are "one value per file"
We can stretch it a bit and say that this file contains flags

So format like done or busy or failed or multiple eg "busy failed"
But the X=[0|1] is too much

Also I think the AI is right this one commit does too many things.
