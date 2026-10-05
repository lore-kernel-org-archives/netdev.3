Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A447AF57;
	Mon,  5 Oct 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231400; cv=none; b=cQmFZNL7/9n9IbTQwbcK6t9arOkcM17or5rI41DyyCZoCpSZ0beAh1zz61398pUONRXgWlALNCuf8GQ6Z6QkHMPjkNZHFzdTOq6duKQnC9nMr+LtZ0n7Fo+Sll4cEryHc1lW1r4uZrQK0YskFSV5/q3kNEDCfGglYgeekmq4Cbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231400; c=relaxed/simple;
	bh=8Jzek+0zRSiVuZ7n0HDJlhS/n5kPtErQnI7huKM+UP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG4JkHOK60ZbhTL3roX5NfpsB5HcgiOaphM+kSCv9/401Gi1SKT+RWpWrPuAyKSPuMhjZhA1nYbs/vS5UsQonDwFNJj1wZ+Q0xjkrDnpUTlNk5aU0Zs23W4W6oNg8VMQ2dz+U4rkLCupX78z6RbEYu5+p1LJixR99hnpJMvPnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ2ytO0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ2ytO0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5E61F00899;
	Mon,  5 Oct 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231399;
	bh=2JUEgppnsskmxzR6hR4FkRdIFTQOgEmr9ItwcDNvDFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hZ2ytO0sFLlzH4xRT+cCs/c8fstDoh4U2Eqck7SoEtjBfo1o/iXk1AE676BfwQ1hq
	 KRxVF5A/bjOg7Cjo8VzH1GeLzf8Ww7TQotpSrb8jsxgXx49xpyl0JhAcDSiZQQUGGk
	 wrK8aqDMH3nIVoKwKpsXfHWj+RIbNvSFSiRrVuKEQ8bsmj0nzA0ad0Vz3vtWnQ7eUA
	 VRIWvL6zrIF1qicvT4xbGQUMqrTJ6n9FN/6ZPcuiXCxAOHU8utLuOgksNcocVzPZhZ
	 Hp36Q4TYrXj76CnBBm68Xo0yne4/bjOh9w1JLWq0X2+1lZvVIiWGZ2XHHsmEZfD/Ua
	 detfejExnZnNQ==
Date: Mon, 5 Oct 2026 15:16:38 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, shenjian15@huawei.com, shaojijie@huawei.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] dt-bindings: net: Convert HiSilicon hns-dsaf
 to DT schema
Message-ID: <20261005201638.GA1807068-robh@kernel.org>
References: <20260930201919.76465-2-robh@kernel.org>
 <179115213771.434549.6434616017051204695@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179115213771.434549.6434616017051204695@kernel.org>

On Sun, Oct 04, 2026 at 10:15:37PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 4
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The conversion drops the two leading legacy 'reg' regions
>   (sub-control and SerDes) that the old binding documented as the…

The old binding was deprecated for a long time and there are no users. 
Will detail in commit msg.

> - [Medium] The top-level 'required' list in hisilicon,hns-dsaf-v1.yaml
>   leaves out 'desc-num' and 'buf-size', although the deleted text…

Will fix.

> - [Low] The patch deletes
>   Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt, but…

Not an issue. Fixed when other binding is converted.

> - [Low] The deleted text binding had the buf-size and desc-num ranges
>   swapped ('buf-size: ... should be 16-1024', 'desc-num: ... should be…

Based on the .dts files and driver, the text binding is wrong.

> - [Low] The concern says that 'mc-mac-mask' with only 'maxItems: 6'
>   accepts 1–5 bytes, while hns_mac_get_info() needs exactly ETH_ALEN (6)…

Not an issue.

> - [Low] reg and reg-names use 'minItems: 1' for every 'mode'.

Not worth the complexity to try to express that.

pw-bot: cr

Rob
