Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0792394797;
	Thu, 21 May 2026 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350256; cv=none; b=QLHHeaWdbHWe0SUoe8l2DijftvfrUWdDwtaKCxU1t6uMSm9uPH/zSiWtmhlOrM+dptG6nSBmYXw2K3poDOK8MUngG+8KGbstnH13jc+EptcMNRE2eDMJ30OzowMDjKMxeJLMdRbBuoMgoccQ1MqKLGiPr+zM/pfkWIqWSP8cjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350256; c=relaxed/simple;
	bh=5hO25DUJG6mwcnjP+pjR1h+Md4D27CyTmWx2zvii7A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWV/3a82wxNim8pe8E6VhELJufJE82tozlo1JZlm/zaPO9eWLA3uR4HUOAwWUQ5ku2FIp9FzyuiOGhI23JuMUxt137jZDQRdCtYtPjbqPPpAO5VL6y5C3wgv9L8LDjpxd0V5GYSYNBHZfZyXS+NuGxfFvfSqejVO+buv4NKGdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE6UtIGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE6UtIGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0411F000E9;
	Thu, 21 May 2026 07:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779350253;
	bh=1ilj7z8ofPWGWebTNTtjk4KCvHEDsKj0rq19QhruntQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RE6UtIGkL7d8d45iMMPh1Pc2VX0lbgT7fb4gK2JL8uv0X+ZAsZyCjENzl/w4UfugV
	 NcnWmGKo5Hl2aX58BkVbce0hHb7HWcqL7pVQAy1Sia4xv/+hpWZdRnjZ899vZ9dgn9
	 n2w+rkTvHsHzNlYOe7QsQytm0+kHBnE7rnLuYtDrUG6Djg2C/RKQu4QPuetWCK/+hb
	 fkfEcCO4n1xg79YQfJWghqVG9ZoQrW0hAEgOc3faAAnsUD1ug+CEZgtWr9MJEASi49
	 kf1Mm6uRwFrPOi7W1dstRoHdQOitRyYzWLVILbeBqvZwij77aJa6jgRI3C7eKLExVJ
	 sdZE8RoD+MhQA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wPyHb-00000003Njt-2RYQ;
	Thu, 21 May 2026 09:57:31 +0200
Date: Thu, 21 May 2026 09:57:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Jan Volckaert <janvolck@gmail.com>
Cc: bjorn@mork.no, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] USB: serial: option: add MeiG SRM813Q
Message-ID: <ag666-b99LGqWPQ5@hovoldconsulting.com>
References: <af3nDLa1A1JcTftq@hovoldconsulting.com>
 <20260517153237.55995-1-janvolck@gmail.com>
 <20260517153237.55995-3-janvolck@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517153237.55995-3-janvolck@gmail.com>

On Sun, May 17, 2026 at 05:32:37PM +0200, Jan Volckaert wrote:
> Add support for the Qualcomm Technology Snapdragon X35-based MeiG SRM813Q module.
> 
> The module can be put in different modes via AT commands to enable/disable GPS functionality:

In the future, remember to wrap the commit messages at 72 columns or so.

> Signed-off-by: Jan Volckaert <janvolck@gmail.com>

Now applied, thanks.

Johan
