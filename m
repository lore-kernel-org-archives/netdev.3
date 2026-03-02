Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97911282F03;
	Mon,  2 Mar 2026 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492105; cv=none; b=WzC/gCGQzLsTsokQio/bmsoxy/DZOPapu8K7K2pWpSLaEQN4ueuc4413LC/MbMCO5JoCUz0q75o3Z3XrWWRkIFHxETyjJTh5fGiCiWQI2ObyJHQmxnRCq/xHQDSSWg5UG72GhZc30dBZPDAiFPMVI7nQUBiWiTRQO2U65oc1+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492105; c=relaxed/simple;
	bh=U6JUcqYh1LvRQQ1R7rmcPBgDLm0ri8voDLKmQqdul58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k87crUe4tviFvODzE8ySHNmRnqkB4UvOdpLu1CELLo9pMpt1mBAXreVCezuSf+zeG1kVaF5atvb4drJryAkRUgieOaN0WayGUtIRu34fLX74NKJN6f8aJndnCobJTnHmViqnb7UeWAqjH4wK6SjFAxDhd2k8gDh8FAl1TZz9vPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uwxjt4yD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uwxjt4yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7237C19423;
	Mon,  2 Mar 2026 22:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772492105;
	bh=U6JUcqYh1LvRQQ1R7rmcPBgDLm0ri8voDLKmQqdul58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwxjt4yDH++cEsfqU4mgri7BjttlcF8OOfyNgl3IjIWehB5MA714xIOIPTOg0uv6c
	 5KjxGULICOI6E8wR2mF0HweBf8Zah5dISTdgin3jiN65KbcTq12fRG+qTc14S8Zmgp
	 l3qJXZPMehGb6DlpsXXMqKPqFyzLcTGoYnsMPDR4=
Date: Mon, 2 Mar 2026 17:54:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	"open list:DIBS (DIRECT INTERNAL BUFFER SHARING)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dibs: change dibs_class to a const struct
Message-ID: <2026030246-savor-hardener-6102@gregkh>
References: <20260302163103.3324304-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302163103.3324304-1-jkoolstra@xs4all.nl>

On Mon, Mar 02, 2026 at 05:31:03PM +0100, Jori Koolstra wrote:
> The class_create() call has been deprecated in favor of class_register()
> as the driver core now allows for a struct class to be in read-only
> memory. Change dibs_class to be a const struct class and drop the
> class_create() call.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  drivers/dibs/dibs_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
