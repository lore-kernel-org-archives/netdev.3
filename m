Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA714F70
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929061; cv=none; b=h7pewfLgPq8A4+E98NrSdd8aPFNc1Yeu9aLU49zk0MK7vbTTGCTg802J6ApuxA0wBgkN062IJ8rAkkh3M5EL0nYGVpzwwck3SOYCYnXvnzqbFjG1K7Si8Hrs1YpN9FEfihin3YumBCsfH6NYIIjntGyaqzAU5lUdTtOAHi563vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929061; c=relaxed/simple;
	bh=8y/u/3+yfRbT0kMh+8jnAAMR3zzPOiG60rP0v7ZZY64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEvC+oqKls1kSzEiUvuqnhQ5dZ6XWmkJN3UslzYKewR1peJt+1ofy9D68NJ79DdMAkOx6Ava0wbDAZF/HjeHcDPcAvC1MDQc22yEjp/qcMCFaepHWYRZZjs4ds1ASNOfCvkc+GJv5PMJ+lSlJNm7lWdnJAUlafATUlmWM/PDi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZXd85x0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZXd85x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F7BC4CEE2;
	Wed, 19 Feb 2025 01:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739929060;
	bh=8y/u/3+yfRbT0kMh+8jnAAMR3zzPOiG60rP0v7ZZY64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sZXd85x0xg1PNO/W3ODyR3fAjrRpa9lZJa1OqV+XBCzwgrP+ccc09Jj/vomW+d0+0
	 yAdseSirDF47V1ncMUAp0kZLlvpnXaNQ51n5hW+TXmBn1GDD95weFwvgMMNlA2JHif
	 KgQDvt0OACQz5REWzAFs5otZZrLZMflVLfWsZgL/R9+wtOfu3JG1Y4VjgEkxpeZBYx
	 5cgbw2eSkWbOLtPQJxabZHWSS4E2JtEtR1bQhGRi8Talt7HEJ1aLnhpYOrafSuX3Ss
	 N1z+Lr2n03wr2/4mR675bOyhVPDXasp80C4g3NxXaav+hp40pyBmYyM0Un/ih3u/e7
	 rD+CQxGkUuIzg==
Date: Tue, 18 Feb 2025 17:37:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
 willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for
 a local process
Message-ID: <20250218173739.0eac493b@kernel.org>
In-Reply-To: <20250218150512.282c94eb@kernel.org>
References: <20250218195048.74692-1-kuba@kernel.org>
	<20250218195048.74692-3-kuba@kernel.org>
	<Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
	<20250218150512.282c94eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 15:05:12 -0800 Jakub Kicinski wrote:
> We shall find out if NIPA agrees with my local system at 4p.

NIPA agrees with you, I'll take another look tomorrow.
-- 
pw-bot: cr
