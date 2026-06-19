Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEF29B781
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831879; cv=none; b=XnqEGE5H1bydxpW/8Ugem9lH/0+1fXitXv5julZGbY1SGhwTNeaSfXfMioB8C6PbOwswnXei6+cxENoosQ8hMuQbwBAMnJiLesgpsM3RJlS60f6Pp77yA7kYQPMme+5qiGdYU3uorUCko8fzpbQ1W2cjkhTbX4DdsNDV8IABKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831879; c=relaxed/simple;
	bh=LP6k0xRqfu3Tqmu40moiCX9Xn0pN8uFLsZu70NIVlOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObfEQ9PFeg8lmoTRyERO+CVsbZDZ6xasMtYMEy6EAfuJj0Y8eCKAQT/2MqQ4frTDVGmeprmRNGEp1+ncAxrM6mppYfpEnM/4Q+LxZvwYGuwKMo2HqW8s8X5hEQIgvveWjOutmmxUT+R2zhtpWZxreCzq1A8Nu/+tDramMXUpCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZprggA6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZprggA6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4171F000E9;
	Fri, 19 Jun 2026 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831878;
	bh=noazxXcmd8eXgGl5a7/8DCd+ggl9ncuOOvT1XxigSfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZprggA6U3cBbE58nKEzcBGUvCO1fV28MUe/gHrCgNIC1ZI0FHxXp8glYmUpYsymB8
	 y0Qv29g2bghNKFxkoNv27HGPhALgcvIIKKz+CICN2RKeq870byH9bAoZBgUoEsnDoj
	 uOnA7zU5MLsm2YjHkXpxrpHjwqU3SYK9fMwIphvvTzVWQD80z+lCSW3nFJgrX8ZgAt
	 AemT7M1n4DvSJDPPvoBxN/DrbfBLxwf/ChlkWzxzMJ3uKDSAiDH9lMMGIDsQsFoiHN
	 BJDMqa/k1q4Fd42q+wMiSjaVbPws3xGy2/A6U+LVqQAZqXi3NhlGQ898slDsMOe8Tl
	 JmUHQae4p6g2Q==
Date: Thu, 18 Jun 2026 18:17:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org,
 razor@blackwall.org
Subject: Re: [PATCH net] selftests: vlan_bridge_binding: Fix flaky
 operational state check
Message-ID: <20260618181757.58fd3908@kernel.org>
In-Reply-To: <20260617104323.1069457-1-idosch@nvidia.com>
References: <20260617104323.1069457-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 13:43:23 +0300 Ido Schimmel wrote:
> check_operstate() busy waits for up to one second for the operational
> state to change to the expected state. This is not enough since carrier
> loss events can be delayed by the kernel for up to one second (see
> __linkwatch_run_queue()), leading to sporadic failures.
> 
> Fix by increasing the busy wait period to two seconds.

Thanks!!
