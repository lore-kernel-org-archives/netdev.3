Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567D2C3768
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781394190; cv=none; b=S9EmKiy0Wj859AjelxPyDtXcUggXxCRR8x2pPpJixwGK+QrUMrJh+LWAwnyxId6Pfue586w8njdc6UpJHvlTJX/lNGW71ZmEaysp7yhg6QV8atb/037iDwxYgvw4ODFj8SzViTrRYPQlOZHGQ/8sxLZKLpperIsKi38aamvABqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781394190; c=relaxed/simple;
	bh=n2nj2ss2YTQI+G/J+KyTotuCGZVUozd2Wfwj5pLB8as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubKE2s5DpWqqE6cK1StctuyXInbeXtNvxJ3VSM271BJTrRE/XCeTGpmMJKysnMh0hT7lYNIYrL0fJd8yzHhaMlIDCLikW95eGnZFNp4EsGd7/pdpSM7Qx3VOfYv5lvb3XnZNt+8Hiuwg/yNZE01IzyZfS0ty7TvM9EtYVpxbOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPBKKtKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPBKKtKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7FD1F000E9;
	Sat, 13 Jun 2026 23:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781394188;
	bh=OR+SdyWTxa5kmJvl/+C3NKcYOXfP6wxnTo/8jDnyEkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jPBKKtKh+JYt4gHhkxRL/GbPqFall3r77u3i7rgqJNmcgUz6zI99zqGsyuYVbPQVI
	 Q4B03338QpiJ3IQwZw9ER7PkfCR1yMIuOE9aCmAL+7wyVZ1fDdFIC0X7o6Kn7XYHbv
	 3bLbYBV62EX+5//m2B8PH6WbM21fMADyihwn2lB5AExRF8tqTiopwEq7ML0yFi5ZtK
	 CDwzsCMq5Xup1/goi6JCo6spd3+zdQPP7oiDwP1LZCzLrbIOt/20uSgzLuUSlxeL3z
	 DdWRZ779b1oNnPD6SYpMpS2dLb3w9ZA23kPZmV8QVvweDgSzO2ZxNbxQc2q/pUDx+R
	 jHtA4APGspcXQ==
Date: Sat, 13 Jun 2026 16:43:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 ade@amicon.ru, dima.ruinskiy@intel.com, jacob.e.keller@intel.com,
 dish@amicon.ru, avigailx.dahan@intel.com, Kurt Kanzenbach
 <kurt@linutronix.de>
Subject: Re: [PATCH net-next 06/15] igb: Retrieve Tx timestamp from BH
 workqueue
Message-ID: <20260613164306.567d1cc6@kernel.org>
In-Reply-To: <20260612095742.662653-3-horms@kernel.org>
References: <20260609213559.178657-7-anthony.l.nguyen@intel.com>
	<20260612095742.662653-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 10:57:44 +0100 Simon Horman wrote:
> >  		/* reschedule to check later */
> > -		schedule_work(&adapter->ptp_tx_work);
> > +		queue_work(system_bh_wq, &adapter->ptp_tx_work);  
> 
> [Severity: High]
> If the hardware timestamp is not yet valid, won't this work item
> unconditionally reschedule itself to system_bh_wq without delay? 

This sounds correct, the patch is basically busy polling from a tasklet.
BH workqueue is not just another work queue.
