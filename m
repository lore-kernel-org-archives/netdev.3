Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546225;
	b=g29A6QSAT79YY0sJ8HbEDJEioguMIhmxlHbhHD0V1sJ7Ew3KzWoXZ50WJgjPQtNPnBlq
	 /Kl5A8MaS1fhFpRhVoRw0ygUaddqJ4+7Rzs8GQ7D4bEybgdp7bQbI23xq+CzEuYX68gZA
	 K4ktgrcQX9mIEYCZ2B8GXKvuvYqG8mwRW0qSIxdT3f1itFIju7GSMX3Z0nMo1r44RC3jj
	 8DqkN7C6uIJdmMWambd2xr5omvy2qqfe2uwU39jWM85bJyMNZTHP6AF0V2fQ+N/ppaIK6
	 8Bk6l2l6KgmN8DwmOZCSRRKY/1J0rXGXVPYAvnRxiIax+/FKN9z91lGOvl25NiWjn8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4B0/9ktwe00o36dcX1L9fIPtfL4K8IABLmr0ZzhtwVU=;
	b=1YOaGCZEuKT7aXRYPzlRqNIgSKVvkYLnHYABIAGhLMcD2CmstV0dnLZcvGd91G3OMLZR
	 cC+q67iFE96ANz0HhFcQ1u6i0PzBaX49xuTFqTvs4xvl9Az7yunJ9ioV5rw2xe08pWUvZ
	 m7JRVIGBAAl4I8SepdaWY/sKH+JXZ+2/cU+u7w8fnK1XAZxFtO/nwjmRIVWa8PmDgis15
	 AzRSHIMWrXyXpdg2+F/2GMfPTOUkQCgKa96i51RVCk3vzzh4p0Q0rkMZ4kE7cw1hHcal/
	 9dmh6OTRg16Ah9ZU6OuxAh5dxWOfjtgW8/0WEUXOBa91K9k62o/DN5Qzw8d6/TsG23g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWWSGJCj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB123606A31A;
	Wed, 21 Oct 2026 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWWSGJCj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87461F000C9;
	Wed, 21 Oct 2026 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792546224;
	bh=4B0/9ktwe00o36dcX1L9fIPtfL4K8IABLmr0ZzhtwVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oWWSGJCjejrtMsulN6Ux7i6Dxuk+qoRlUzXNFTVtPapywp4Eg/pfdJBeG/Yjq+Ve2
	 swjExRPlr/FDZJ5tdMkZ5h4d9t4yK0sNZHtVbNuK0nlR+UkFYgZFAL3I9gm6V+X59N
	 NmnMBskAQqUeCI5HOKwkq5kuRMYx3W64bgW5I0Ie6e9Ihvl5KI2X4HKvr2vh+4Yuix
	 uueSn6e2xGGt8zryMn4QEi3jaq2ftJjow7fmidA9XkWAtcEn76sIPA4hdPrPbpN7nx
	 S4bEhvHGVxItdAYQbd+e9fQZbNyeq6dNFtX2zcRdW6gbuIJ+o4Q7zqR29eh4FFxTG7
	 n+ueCDbSyFaVg==
Date: Tue, 20 Oct 2026 18:30:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v16 0/5] net: dsa: motorcomm: add support
 yt922x driver
Message-ID: <20261020183023.3665be78@kernel.org>
In-Reply-To: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 19:11:10 +0800 Kyle Switch wrote:
> This patchset mainly adds support for the yt922x series to the dsa driver.
> Currently, only the yt9224 in the yt922x series is supported, and the
> corresponding tag handling for yt922x is added.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

