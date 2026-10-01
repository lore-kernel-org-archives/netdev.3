Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68488405C38;
	Thu,  1 Oct 2026 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898696; cv=none; b=RsTc/uakQWXmU9Hdp0V82RHwr7iNXjmxy5W0Xebl6BPFEUTJPDrQv+Jn0DNHTE1m3CiJYREfFtGT8scywlqA//8aQgWb3bIJ1zGZTgpi6tjY1utDZCUWeicCvf4tLzJGPlkPmsN81jcth3U524wk1ZB4yEJBt7C3oGn1eoCC3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898696; c=relaxed/simple;
	bh=SHh4CJ6BYJIdUQfSEOAJQ/dF1ROYd/5DfMGKYmaFDQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoeARG2tSTOeoWxa60UEd9Be3ELYTKobujsTA28JpxbllfBiAMJWTyGzMap/0AiCLN7tVfiv/huBpD+8ijIPdTNQJYEqYX6307HbuNal037LLRL+kD7slsKNGUh8vZPV+oojcISdkOEbsQQTdVGEO2qpXQiDTtCznYDUAhp8DnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXFwC+9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXFwC+9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0031F000FF;
	Thu,  1 Oct 2026 23:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790898692;
	bh=X334cK14ejubPeoUE5DqAOdV4Xh9JEFtdOAmO8BCI28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HXFwC+9dvRSK3ps3touBsNYFPDt689nYpx88Bd3ZJO827CdEaF0R77M9wRa/Kzqwm
	 fSKt66VlkKWkAoL5VhyHz98R+Z6eZzhftkoOKOB6hg+6Dg1DnkrvIQQ5CJjKvHhReN
	 eNe8yjUPwS1Y8uvqXuuVlL95i76Su1lNjZc2pMwJz71Ht2NPABUlEqPrzvi3Chg+uD
	 JhcPJlyRdkLhcQpBmrlEkHmSlWwcs7SYZLvjABUj724Yt3kTc7eGRNQkaHojagd6pm
	 gLTPjiy2HXmPihwQKTInwMo4nyaERWqLiW8Ikewo19RvCnqdCcDPsGPDbDf3DHHJ0r
	 11OkgBjfq5Fzg==
Date: Thu, 1 Oct 2026 16:51:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Petr Oros <poros@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] dpll: zl3073x: add PTP periodic output
 support
Message-ID: <20261001165131.5b1d90cc@kernel.org>
In-Reply-To: <8c609bc7-be81-4498-8612-3a8f3b4a2401@redhat.com>
References: <20260928185552.1103515-1-ivecera@redhat.com>
	<8c609bc7-be81-4498-8612-3a8f3b4a2401@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 16:24:43 +0200 Ivan Vecera wrote:
> I would like to send the v2 series but now it depends on two bugfix patches
> that were submitted to 'net' as
> 
> https://lore.kernel.org/netdev/3c4e8106-83d0-4c1c-a3bd-8d9343d2d557@redhat.com/T/#m0caa2ce66da8213c8594bce7d0ff55baeafeee05
> 
> Without them the v2 is not applicable to net-next...
> 
> Can I include these 2 patches into v2 so they will be present on both net and
> net-next? Or how to proceed in this situations?

You have to wait for the fixes to propagate to net-next before posting.
