Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448237C91D;
	Tue,  3 Mar 2026 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571370; cv=none; b=jg3eprwMhm2YBi0elGnWVeN4KQZwbJOgKT5PZSQ/EO0aLgLC+LlQp7TV7oXFWmnByQVMM4MfyqRqPMwQDfRgzPIKNMuc5kHXEhwJ2T8tyCOmSQqbqsJ0/qVtPHsQobvax4IZkA+DHu6D89QTwM4XksZDeRwpYJyERmz/hFtm7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571370; c=relaxed/simple;
	bh=7PSCnrr6dSbrC+RmN21dPjRnagxWOmuk3lv3YsRXRQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBmC0xQRAzmh6GjqloTujGT5qSyzdbHgWnYnbnjnN20uVetPFo9M1scw+M6xuPb2ljHTP8l28LqaEX7IwQg6QMt+7uUq5bXnoERnt+uoTG8VUxA665V+V4xgfWFQSYcWOsf5nje58DYVg/cTImZz3c4pvApt8P4dvNNq84azHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF49Km8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF49Km8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA869C116C6;
	Tue,  3 Mar 2026 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772571370;
	bh=7PSCnrr6dSbrC+RmN21dPjRnagxWOmuk3lv3YsRXRQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uF49Km8TK/H+oPfyjXFX4BgwjQaB61DZY2PR2M4ipAEtclZq3hBCsG/erGMfst91N
	 7egchHFtU/HYveyFLG/XdHRPqfcURm949JYdVQWtsbJR6qpG4i05P7cMujH1Mmgo/d
	 b6zvPST379Sj+Ha7JDdVad1TUORyqYcZY40sip5Bpv0SuWDzQi/DhcgqaUXGmyTcX3
	 fNLd9y+2L0exZT/ww5ql1EHsCDzOemxnDdZDkakJOmk5YAK/F8VFQsIjrTCnmi3uVp
	 6uDKWVCxXirvacmAPASX0v+WgZBNNawfP5za9jktBAdLEcpYU7u721OvmSsljQIUQo
	 bHFdhQF004tpg==
Date: Tue, 3 Mar 2026 20:56:07 +0000
From: Simon Horman <horms@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] NFC: nfcmrvl: Replace strcpy() with strscpy()
Message-ID: <20260303205607.GF71509@kernel.org>
References: <20260301144345.218628-1-tomasz.unger.ref@yahoo.pl>
 <20260301144345.218628-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301144345.218628-1-tomasz.unger@yahoo.pl>

On Sun, Mar 01, 2026 at 03:43:45PM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> Replace strcpy() with strscpy() which limits the copy to the size of
> the destination buffer. Since fw_dnld->name is an array, the
> two-argument variant of strscpy() is used - the compiler deduces
> the buffer size automatically.
> 
> This is a defensive cleanup replacing the deprecated strcpy()
> with the preferred strscpy().
> 
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>

Reviewed-by: Simon Horman <horms@kernel.org>

