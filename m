Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457346AA66;
	Fri, 14 Aug 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726887; cv=none; b=cWwCzpoRjnMpruoDL6+nho+O1prtfLx1K5BZpSCjcy21GRRBzcH7Hq3Ty5+011EZkqIAaHlhV2ivnuraLNdVnnJ1SBKY6uaQuW5ncphaMEyKl3KRvkQEifCmlmdA4iLYSw6iKGVtsnLS647qKxobR4ONG8YerKREMW+/DDCF7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726887; c=relaxed/simple;
	bh=n6dme3HZcFicPImyg0QNMpnOA85/wNW95eAMmIA9fN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ejw87Uc2pwaq3xnHazQSQMEspXT6DWOVW1Jk/ou0Co8JpdunjWvDfCytCy5kNkP1j8QyO1kY20WUmRAAgL6VqDsQ+m+tv8Db8BV9eTuHt7/Pwqy/5YB0gvWg6as9WMiUAdx1566xq8urIw8WUGmbLr2q5geGpFZR8uYynnsfaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3NgCqgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3NgCqgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB691F000E9;
	Fri, 14 Aug 2026 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786726885;
	bh=z/adx9u+3OiPBT0d+mc8OvaOlugkErjVWDWRXBBIINM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G3NgCqgUb1n8qmdbk6p25PmKqH0vIzn1yrT3+6hJwhyiK+ReEfczlkLmPqR1mAk3F
	 ZZx5w+8+W2so3geMEPVd4wCBNsXw3YxvBoDhoV+uuv9zz4C9Guy2XCb/QYSbjhNvLf
	 IdsNTQrG/Ni8AIgC58leaqUpDjh2IupLrriWUyg7e0W0a2xBB4zVTokyuRXr/+Ivvp
	 8tTyZhyRXmtm6WegFGGQtZvlIZMsEfjCJH0Q8Fe/Zs4Ni28NXn950S9GMVGhWGeAJG
	 GQ2kGd+/dJnufnbA3JxhtGCjG2bMnMz/6KtRxGHu4tBoblveVO/5XD8HtBMsRx391j
	 U1oDoiLNIQQpg==
Date: Fri, 14 Aug 2026 10:01:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <nshettyj@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Viswajith
 Murali <viswajithm@marvell.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sunil Goutham
 <sgoutham@marvell.com>, "Ratheesh Kannoth" <rkannoth@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-pf: add devlink param to reset MAC
 stats
Message-ID: <20260814100124.6411cece@kernel.org>
In-Reply-To: <20260814104256.743844-1-nshettyj@marvell.com>
References: <20260814104256.743844-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 16:12:55 +0530 nshettyj@marvell.com wrote:
> Add a runtime devlink parameter to reset CGX/RPM MAC hardware
> statistics.

parameters are not actions, you should be looking at reset APIs.
There's already one for resetting netdev blocks via ethtool
-- 
pw-bot: cr
