Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29527A91D;
	Mon, 18 May 2026 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146571; cv=none; b=dY9zuOisb/6bpLRkCGWMQ0fawAp9xHS7flSNootk1vTZwcMYp4YGDSXzlYvkg/Aoq2uBVpCqJYf/cteGJoBTWVhbH8SA0xXXATN8IRr5Am4wBCJonJniS8y6mtVTYO6bCTIMuGpoCI/31K0yYOdNPViAdM/cQXKOyo4SXoxDLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146571; c=relaxed/simple;
	bh=LY3tlLIc5+mFWR9nIWqMwRjIYHgXxK/nKftF+YmPPaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9jDCo2TkKJP6XGpYXMQndkbJCH61RygJlP/DQ5YFp4gn/PEwbG0xY5tJXlIGmoxJo+3pndBiTQBFPKqbkPSBHhdsQGnQlu2VMijwWRk3stdDvPt7KFyMH0F/MZLK/K0wmrzkYZ25de9FPvVbg7ve92CW65GYHnVk8PaTQHPswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnpFmXBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnpFmXBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389D8C2BCB7;
	Mon, 18 May 2026 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779146571;
	bh=LY3tlLIc5+mFWR9nIWqMwRjIYHgXxK/nKftF+YmPPaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OnpFmXBoLC05qgfIL5RwDaBCgI21DLg2fdnqNiWLJ4VkmW/VL8KJuxfcjGEPUa+ST
	 zMQA+1Om+pSgZExu08qyfYKt38mL92La8/wIOsBVY6JRTF/ULyn4ZOvFueiqNtsa5A
	 cHBHGROAnKETBlItTxOmUHc/Xq1SuW5vjvxNpldKHF01AEZG0ULAzY9FgRfOWZ+RDV
	 imImXJAducqQx2f8X/F3pFoN+A0CI2yS2fD9mU/Q5HEzZIY3R46ZERCc0tKmIudFb2
	 P8dlASjZPvytb9prFzW6y1gW6eI4T5oqAc8mzAFl0HQDAT7pJSnAFIm8lERush6vBd
	 w7jRAyRU6oXkw==
Date: Mon, 18 May 2026 16:22:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] pps: bump PPS device count
Message-ID: <20260518162250.235911be@kernel.org>
In-Reply-To: <20260515135028.2021318-1-vadim.fedorenko@linux.dev>
References: <20260515135028.2021318-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 13:50:28 +0000 Vadim Fedorenko wrote:
> Modern systems may have more than 16 PPS sources and current hard-coded
> limit breaks registration of some devices. Let's bump the limit to 256
> in hope it will be enough in foreseen future.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Hi Rodolfo! Could you TAL / ack?
Or perhaps you have a tree via which you'll route this?

> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
> index 009ebcd8ced5..1088dea65e12 100644
> --- a/include/uapi/linux/pps.h
> +++ b/include/uapi/linux/pps.h
> @@ -26,7 +26,7 @@
>  #include <linux/types.h>
>  
>  #define PPS_VERSION		"5.3.6"
> -#define PPS_MAX_SOURCES		16		/* should be enough... */
> +#define PPS_MAX_SOURCES		256		/* should be enough... */
>  
>  /* Implementation note: the logical states ``assert'' and ``clear''
>   * are implemented in terms of the chip register, i.e. ``assert''

