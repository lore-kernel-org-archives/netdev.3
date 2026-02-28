Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49F2264BB;
	Sat, 28 Feb 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317258; cv=none; b=uKhgWnjTXePtq+87iuIC1a50L0JL2XXmx5KQ091CEMH2R8hD+JDThnp5+jZl6Eb749XDhzyp14KmF7fduo1eY8Uno4ZLEyvomvgUqD5dRevuGu6rsqcoHAR5gaBHHVDETXas9M+g5lbtNB0/15ES2Xvw1+U4Gb4SYbvmy996+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317258; c=relaxed/simple;
	bh=njI1VNiwDHCe99XdaJYPTXymGNw8khFHdLG3k5QYDRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NY7nt1PHMG6B21MJnnARIHbnzz0rA/JRY9+YCOtR9L2hRBdHtH6KQS3U4P530hUzqRmI4dRVAzM/nqk1j0n9x8HoFwu1FELgPYZfAdrB3zQYLAtgNZe03uXKOBF5PVEDKMGkzAeWQJ8qgFwCVaTViYGOhCTkqSdYZKBq3YkO2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs67i+hS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs67i+hS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDAAC116D0;
	Sat, 28 Feb 2026 22:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772317257;
	bh=njI1VNiwDHCe99XdaJYPTXymGNw8khFHdLG3k5QYDRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vs67i+hS7s0ggK4RNwBsZU7wcg9NHr3E12+TgklV2tN0dkDdhNKTxEoM2NEn9fuu7
	 1rnRRsWNCKLHha06Xk5sQXaZBVUpTmQWL6D4FAEf4HgttbIFS+KNfN18vYB6kfFdqU
	 YWOe8y++DaDYX6q2WlZe79ki/eRL2To5ca+cdU1mbB6cAdB/A4z3E10WqxkSiVl3UN
	 4+7/EgXGxQv5OOWH9Ru+Ra3JuUncZbgOsUMaH+mjb5Nhqnnan2b2zXC3tQV59kz34m
	 2yZ2RTuk3hr34OW9U8sNq/w1M1/1bXDcBpfHX2Twn04GC+30sKidwoAe0CXV+jrGXJ
	 0bewE+cFdGX/w==
Date: Sat, 28 Feb 2026 14:20:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH net v2] amd-xgbe: fix sleep while atomic on
 suspend/resume
Message-ID: <20260228142056.2e6022ae@kernel.org>
In-Reply-To: <20260226161640.61246-1-Raju.Rangoju@amd.com>
References: <20260226161640.61246-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 21:46:40 +0530 Raju Rangoju wrote:
> The xgbe_powerdown() and xgbe_powerup() functions use spinlocks
> (spin_lock_irqsave) while calling functions that may sleep:
> - napi_disable() can sleep waiting for NAPI polling to complete
> - flush_workqueue() can sleep waiting for pending work items
> 
> This causes a "BUG: scheduling while atomic" error during suspend/resume
> cycles on systems using the AMD XGBE Ethernet controller.
> 
> The spinlock protection in these functions is unnecessary as these
> functions are called from suspend/resume paths which are already serialized
> by the PM core
> 
> Fix this by removing the spinlock from xgbe_powerdown() and xgbe_powerup()

I think you're deleting the only code that takes this lock.
Why not delete it completely?
-- 
pw-bot: cr
