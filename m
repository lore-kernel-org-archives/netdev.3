Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19D2AF00;
	Thu, 19 Feb 2026 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461100; cv=none; b=YUy8NqqceZmAcP1Z1De3IDgBfQ7YOSeT4JRNhRUGauT5EFk5aMjXuqiPaSTjNgfRb27Qnm8PrBHHBacrc29cQXIgw/Q/+azq0R6XHJM+Z4Luc6Q124IBwoavWxSpLXuzT3M4vPHmvm5ioT9PDjX3936A+K9uuR818KOnUVJ83vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461100; c=relaxed/simple;
	bh=4n/dNgwExGMXCMhKuZ9Jr1UoGH2vNQNTZnefa+4wTdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+fJlLIFlR9QOvz6Zgx5q6qYLueBLt9wOwSrjXcGi12YJEz7VNhYDtnhZs24M8Gr/zhS7+q6Y2VvGWiA5nL1Wp5kH/CubBxeFDSbSA3jJIa0jisDOMR+xI3gzkhJzM05mmPxfEX2krr+JCld3b8z8qoILb1yj7RPbXgD0kBpMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnPC/3TI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnPC/3TI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C87C116D0;
	Thu, 19 Feb 2026 00:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771461099;
	bh=4n/dNgwExGMXCMhKuZ9Jr1UoGH2vNQNTZnefa+4wTdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PnPC/3TID5Ssx/nwngb6lCgcjpaaqfUCSC7JRirD7RWOMFLjLkYaiBuAveH1rKf5f
	 PpoVWiKa2nvGtXuwc9MgGYHSuDM4rG8MS1HTtXFu0P7/At0/kPyXlHrsFo6s3Iw2kC
	 E/A/RIXxMv+MkRnAcl0tJ92wC7Iu+5rytkikzcRyNIriahd61USxySNfHDSYIyhTiO
	 yZSdMofd3PvxGtosTACjl18lsAEJ0m/ITKDzUZ2KmMGrvMnHX+iqAQXuR3YP+MSuTd
	 MKv9GTZLOgg2JDo+kx2U2Bjnz2lRdXSyY8mDA9SteopCA9jtGsXgKD6E0uR/epw+Ex
	 eguej4KOfdEZA==
Date: Wed, 18 Feb 2026 16:31:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, rajashekar.hudumula@broadcom.com, Bhargava
 Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net v2] bnge: fix reserving resources from FW
Message-ID: <20260218163138.17fb1966@kernel.org>
In-Reply-To: <20260218052755.4097468-1-vikas.gupta@broadcom.com>
References: <20260218052755.4097468-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2026 10:57:55 +0530 Vikas Gupta wrote:
> Changes in v2:
>   -Fix commit message.

No need to repost but for the future changelog should go under the ---
separator.

I assume you have a lot more code to upstream to this driver, so please
follow the community guidelines:
https://docs.kernel.org/maintainer/feature-and-driver-maintainers.html
specifically:

  Maintainers must be subscribed and follow the appropriate
  subsystem-wide mailing list. Either by subscribing to the whole 
  list or using more modern, selective setup like lei.

If you spend 15min every day reading some ML submissions you'd avoid
all these silly mistakes.
