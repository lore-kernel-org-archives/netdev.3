Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE6388395;
	Fri,  8 May 2026 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280165; cv=none; b=eW6lOFOHJijeiG/JP9/sPQsMhCx9ckYa12ll3BsDV+OcfqZ5uWpNobZPLY8/8wM0tdjj2gWdp4ukspYYE0uZe3TpXi9mWVOs416jFAYoGdHz1eydcR4rg435LB0JUwRT6lEIYnsrycp5nFZlZTB8M3cdvpoSChrLN6moL0vDNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280165; c=relaxed/simple;
	bh=TN6wKXAWcXACnAu2QoEeodf4yq0Dm7xg31j39K260J8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzKXv5S4/Ey6Mijg9vVZpLwx7eNfFkkbmpv4iG2j5OPo38hLteYJ6u1hDaI1WwK/minY/sW6xHQp2gD5kKTpzKtXyndXbpdpSf5uP0LDedyV7JOt+K6veL6QnFZjC6ZJLKK7fh+kliwRHy5LtA7hZgiOSC3+qDYxSIxfMYujM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jThJBNl+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jThJBNl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A7C2BCB0;
	Fri,  8 May 2026 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280165;
	bh=TN6wKXAWcXACnAu2QoEeodf4yq0Dm7xg31j39K260J8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jThJBNl+HMhxGbfh+UF/wnU7H067c6drhJeigKgZNwGviQgJyXXrvcKNRyWdeyImu
	 Ecr46MdmJIfD9BWsU5ElGxcXuyntuOzJ5U22XWbcbgnrJPuY9GGMWFTXFTrbn94AmY
	 0npk0fwrfNv7GgRhjdj+vUdU/gJ7ZEBRNVeT6JznKPxmhpc3sWE4TUWn27scKPrdFN
	 M1wrlkUzYvq9i5AW5jArSbilF2fVzYXvoJAM2/BV/LEazRJ7Yv3eqzmWaHBowAuY64
	 29ERwfA9wH8iMFC/hfzHNjGviZWKFV0UzrSyMwmHueS2JNmZVkfHSrgD1ds+0MFj73
	 2J9rGywBLRxwQ==
Date: Fri, 8 May 2026 15:42:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: alexjlzheng@gmail.com
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 hannes@stressinduktion.org, albinwyang@tencent.com, kuniyu@google.com,
 shenyangyang4@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH net v2 v2 1/3] macsec: introduce dedicated workqueue for
 SA crypto cleanup
Message-ID: <20260508154243.3ce21bee@kernel.org>
In-Reply-To: <20260507020426.1126254-2-alexjlzheng@tencent.com>
References: <20260507020426.1126254-1-alexjlzheng@tencent.com>
	<20260507020426.1126254-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 10:04:24 +0800 alexjlzheng@gmail.com wrote:
> +wq:

nit: better name:

err_destroy_wq:

> +	destroy_workqueue(macsec_wq);

Sashiko implies that rcu_barrier() is needed before this 

>  	return err;
