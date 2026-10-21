Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547440;
	b=G/uHCe0nrbLJ0bQPYBWhugzLWJ0vfUKxj9y2h8G0gaNZFsBoukAVjHgpfzAIqsKBiEa/
	 C1G5kf1KHSxzPfsFUvOII7D8oHPM0YGEDaIoD0s9gwjTBZ3YkCR40lcVCar75r3jEy3Ec
	 r7Q4wIWkE8JsLYtDk7exzyOhahSOm0GsDP8MVZTGsyI5JBlEm3LUtwZWBAyNV1ZTqTEZI
	 trtQJuJio2OVsrXa/OrOeD823HhG+f2RtfsQJ/RIlLKCyXndRcFJEwbOSskjqVn5le21s
	 qSNHrS3vSsChzSqanT86rUKU+C+tS9rIw22R2xKo2/+/r4gUOVW7/mnhsn7fWa2ia0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547440;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TYUr+H9Go1/ZCJXkY6afMfjog35jxn858taE8zzMuA4=;
	b=VW3aZjTlos7lefzISNeaXIXt0qvH95sa50eZcqPNN886voONhLgYI2iNApsUhxqmdy3c
	 w2DluKlog6xwUj8EKkojiUnWWaGQC+O6e7neNve3Yr+oqiDIAjLpezfyyvPjDHD6Lq138
	 OOjE0NYx1oBTJpjnb7FGScVTxuOJyejHpRYvdwSQlp8dTvPJDnSohMj+WfdNM95l5fVRU
	 nSeTsfG/23IzdOxjP9mBFJF6QOlPZ30LiKn649CmKmWhzttHJCRHiEGbM4jC/m8Lisyc6
	 iO1Snir1t82QVlhUSqCMkyd4CUYv6zj3+29mLw/6d4m0NBEQ1q1B6TqAjTqHPYlIf2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B49RA3MI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50F606A31A;
	Wed, 21 Oct 2026 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B49RA3MI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5372F1F000C9;
	Wed, 21 Oct 2026 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792547439;
	bh=TYUr+H9Go1/ZCJXkY6afMfjog35jxn858taE8zzMuA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B49RA3MI1BN1+3F3sndQ9xS3V+iTgPSXMUjTLMHLWtpd/dcd1Zik9g2zYbkYgmuN/
	 a5d+mk9r8YWoplXXYwmyWT0csrCvGusoNRwKjglD9MNrmus/+iQ4g8J+fDpoTx1gq1
	 WE59nLWzUr4CMcgSyZidkRNVuoBAm9MA5BvJYlt+vo3RsA601WX1hrhxa+uCuKldbd
	 QlEQytvpVcQsL7vQWSrYS58A/LaRCcHd1tzlAlV2tl/EqMHH6F1zT81y+z+pjlwgs7
	 P8J1e9kTTAQWcvurjho72NuNH29Ybd7yN6UbR5CF2ahl8wHUxTXi4gVJ8YXn0KEUbR
	 ekUZf05CWFoDg==
Date: Tue, 20 Oct 2026 18:50:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: qca8k: report port statistics
 from the MIB
Message-ID: <20261020185038.4dd7aa03@kernel.org>
In-Reply-To: <20261019191137.307514-1-kuncy7@gmail.com>
References: <20261019191137.307514-1-kuncy7@gmail.com>
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

On Mon, 19 Oct 2026 21:11:35 +0200 Stanislaw Pal wrote:
> qca8k has no .get_stats64, so a user port's netdev counts only what
> crosses the CPU port; traffic the switch forwards in hardware never
> shows up. Patch 2 reports the port counters from the switch MIB through
> a delayed work, as ar9331 and rtl8365mb do. Patch 1 makes register
> access safe for such a reader outside rtnl first.

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
pv-bot: close

