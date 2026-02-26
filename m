Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BC28489B;
	Thu, 26 Feb 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113457; cv=none; b=LamsC0cAFSw9+Q2jhM+UG88V6h8BGJkIZXaI5Y3kcSw3eQqe+V3aS/XZw2exwCYvIb1IygmXIgUSyTGGUqgRPUTwkxGNHvQRgEVgH7y1KNOk6VQUT/Cf+Iy3aibPyfNcnqWm+RDZZwSaHZvjMFRfaXzTYr3zEMAUGXBIpM5/oMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113457; c=relaxed/simple;
	bh=WcZwF9wDw1owtnf1rUQoVRjXkHyVltOHLpjN3GvpfEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8IlIaXUJNqX0G5Rq/BPw7ZhRY1hv6Snkz3Ix7N4jWEbLkwkk91VTXtQD88ILRS6eHMis8V+ILaW/X59Wwsfx2dvZbCZ9HQYDbGZILwKVJMXYwoZvFmFO3qCyi/wXfSroZ2CgFtiRgXoZUapBT3TXwhpP97RO/KBtybDu6I/CF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBd8Zhxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBd8Zhxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71963C19422;
	Thu, 26 Feb 2026 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113457;
	bh=WcZwF9wDw1owtnf1rUQoVRjXkHyVltOHLpjN3GvpfEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBd8ZhxcTIDXB8Ffeh5UBTxPjOt2TqXe6YaXuHQ6JdFFpdoRtD1bFUy6E54bbh4BL
	 EGc0tzwYwxrDAcnc3im/XM64EzkTJEDgNqyjN9n2DhA2E9aOzIpLPTY7jmAghavMMR
	 G0UOUpNvUXb6Iljuon4jL84flKZhljrPQ8jFkfglwblzjrDDm22sHck5ewzp0QlaEn
	 kfh1mFzfrcfmxlb1oAINpi43cn+j3TfwcTyFWJO4YQINvCtD+IC1cGsrcPB6xHrQJ7
	 u3p7D8OgfmEwT7HUxIVrQcKSpYoEHcREnG5XG0uO6BP3zJqWsS2iWhR8EDwbWvWr6e
	 kkcMLZFai5oKQ==
Date: Thu, 26 Feb 2026 13:44:14 +0000
From: Simon Horman <horms@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: pn544: i2c: Replace strcpy() with strscpy()
Message-ID: <aaBOLp6Vxg0tVDgp@horms.kernel.org>
References: <20260225172715.75756-1-tomasz.unger.ref@yahoo.pl>
 <20260225172715.75756-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225172715.75756-1-tomasz.unger@yahoo.pl>

On Wed, Feb 25, 2026 at 06:27:15PM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> strcpy() does not limit the number of bytes copied which can lead to
> buffer overflow when firmware_name is derived from user input via
> NFC subsystem. This is a bug fix, not a cleanup.
> 
> Replace with strscpy() which limits the copy to the size of the
> destination buffer. Since phy->firmware_name is an array, the
> two-argument variant of strscpy() is used - the compiler deduces
> the buffer size automatically.
> 
> Fixes: 06c660340f1e ("NFC: pn544: i2c: Add firmware download implementation for pn544")
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
> ---
> Changes since v1 (requested by Simon Horman <horms@kernel.org>):
> - Use two-argument strscpy() since phy->firmware_name is an array

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

