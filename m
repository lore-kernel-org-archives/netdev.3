Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D31340281;
	Thu,  6 Aug 2026 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022804; cv=none; b=NThv1ofoUqnAnC1pcnetw+6pt5RjUA7vzrd9bvYXcRckjexYFcahka93BDG+vpf34hfCozhDB3AFSvDjXgeSICJpce6/cY1TIxwfXoXsWyKaXhlmV7VBVCdzY6nXGUPKY3938Fm4jO9gzSvrz+3XsJJfMWo8WQpAAyukFOyrqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022804; c=relaxed/simple;
	bh=CD4rYDyXzUIGWRPj9bVWS+Yh40oJGAUZEJ8xQAsEpmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXiQuB/Tl39dV4Y7Id5PyeXGYsxiS20MIqwpuDJDgAImaPPS7rFp1bAt4zYBrifgOqrOofVK8zl8B9LQ88p9Ia3Yw5ocBZA2xaN7ckmVQNjhBOut6jemkJ3LSQyoqS3rf2JxZ7EQ7OqiAmlFYpb1yeUfYYPI9nkT+S7XO/WZz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqSm5wkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqSm5wkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4F41F00A3A;
	Thu,  6 Aug 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022794;
	bh=I7iLSp7MlkD/HOJfHrfS+oS/JSNGhj5j4KeQVWLOchk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VqSm5wkdubt1gW3RSTEl5ZVKC6zkf5tYz6hFdLUL70uaobXWXLs8vatTSGSAZrr8Z
	 WXo+aFV84hEHtt//0lrXdB9rmSUb8tjrdoMnKQPVaGGu3xU5ctbz3UUVh6dDIneJy3
	 7YoGHvh/7SDResxphoKhsV6Ame/AHsdiNJpfcpdgtY4zV5F7Aay0nLE6+rX5Ua8hxl
	 MZhLwbFdKBiiWB04jGJvdXnJ6XYAghKykV4VCa2qbBZUL2PQPNb+/e7OQdRLb3iBk1
	 swPn5t6P6mHZuXauP9x7ykQYl/Fxs6ZOUefGk1Mx9SoQihLr8Ul+KMIKfTAKwJ2Y9J
	 4XB0R4EWVMIFw==
Date: Thu, 6 Aug 2026 14:26:30 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Patron <priv.luk@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: ns: Raise lookup limit to 128
Message-ID: <20260806132630.GC51943@horms.kernel.org>
References: <20260804201919.1148015-1-priv.luk@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804201919.1148015-1-priv.luk@gmail.com>

On Tue, Aug 04, 2026 at 10:18:30PM +0200, Łukasz Patron wrote:
> Current limit of 64 is not enough for Sony Xperia 10 VII (SM6475).
> 
> Fixes: 5640227d9a21 ("net: qrtr: ns: Limit the maximum number of lookups")
> Signed-off-by: Łukasz Patron <priv.luk@gmail.com>

Hi Łukasz,

I think that this needs some more explanation.

E.g.:
Why is it insufficient on the cited device?
What is the user experience with the current and new limits?
Why is this considered a bug rather than enabling a device that
didn't work before?

-- 
pw-bot: changes-requested
