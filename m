Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD026D4F9;
	Tue,  3 Mar 2026 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571586; cv=none; b=bIcR3mHTc9PPvoLoT68vDL+zTEX2/TZWnyLRXSXNnyx+0jPaf+q2jXrNzCk17OH0IhemEsfH+2OqPjJMnPFqrJ7C3P+fZBiAiRlACOVWuLjOHA/F7xLnbgVS3vZKP0QKDzw0tknfusgh1EilZHFjE3eaRAz/jmfqJKvBnHik4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571586; c=relaxed/simple;
	bh=gfFJVL0Ru6aLGaKIfMWMNNbTU6/I8EyM6Gy1brOrRRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxlOtH2px35JdPXyo3WE632X88bonDoqNKIGi/B2fu4i8mp5H0yObNLHjUXBAqVufRpN3LlRqB0fuUe/UZmzl1e35upP9BCVl6TLWUmvJIT67QMUqp6aL/fKK3Wd31nq6l5wgRyt3YOyyF1yEDV47RcE8BWw469lMGB19/+5SIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fONlA0YJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fONlA0YJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE111C116C6;
	Tue,  3 Mar 2026 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772571586;
	bh=gfFJVL0Ru6aLGaKIfMWMNNbTU6/I8EyM6Gy1brOrRRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fONlA0YJO226zZNlvTSG0nyBA4K8iVZgbmCKwwwkoE7hGLzUtUFdymK20Gh83kT7M
	 Hae42NpdztDciB4ebbGkoHlr8ALbLmg49c175h1jWAT98jlohh9MEFxaVpYcL0ZLxp
	 maU51FIeg+s/Q06fLewmYnDLgXX4EFe+i36vFRU1eTj+VqtH9nfAwd2CkgnXmqX196
	 U/Ki9N1Drl29WVP4bD0DLGvErJnwYyVdHPc7XknuqZoOwjBZz9qKZ1sGuxgSzMhx2/
	 yutnATsSJd4fgWJkDxvp9BEIK+LcscPHQegCLzm51GIyDEB42jVds0MkxTeEZ1ysrE
	 ZglNyIWqifrTQ==
Date: Tue, 3 Mar 2026 20:59:42 +0000
From: Simon Horman <horms@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] NFC: pn544: i2c: Replace strcpy() with
 strscpy()
Message-ID: <20260303205942.GG71509@kernel.org>
References: <20260301121254.174354-1-tomasz.unger.ref@yahoo.pl>
 <20260301121254.174354-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301121254.174354-1-tomasz.unger@yahoo.pl>

On Sun, Mar 01, 2026 at 01:12:54PM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> Replace strcpy() with strscpy() which limits the copy to the size of
> the destination buffer. Since phy->firmware_name is an array, the
> two-argument variant of strscpy() is used - the compiler deduces
> the buffer size automatically.
> 
> This is a defensive cleanup. As pointed out by Jakub Kicinski
> <kuba@kernel.org>, firmware_name is already bounded to
> NFC_FIRMWARE_NAME_MAXSIZE via nla_strscpy() in net/nfc/netlink.c
> before reaching this driver, so no actual buffer overflow is possible.
> 
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
> ---
> Changes since v3:
> - Reworded commit message: removed "bug fix" and "buffer overflow"
>   language as pointed out by Jakub Kicinski <kuba@kernel.org>;
>   firmware_name is already bounded via nla_strscpy() in netlink.c
> - Changed submission target from net to net-next (cleanup, not a fix)
> 
> Testing:
> - checkpatch.pl: 0 errors, 0 warnings
> - make M=drivers/nfc/pn544/: compiled successfully, 0 errors, 0 warnings

Reviewed-by: Simon Horman <horms@kernel.org>

