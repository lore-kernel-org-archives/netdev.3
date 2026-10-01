Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39F5187EC;
	Thu,  1 Oct 2026 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863076; cv=none; b=pUbeU3dRJkdYP6dAwtfjTRmfOOuMyorIGpXCGYQhEbuyjY1msdBbu4yfhA/H/QO+wJSmfHw5vksfgFtSVpudk6O9xgZIvX0fgiA8Sn2LMafPQji3FDN+a5OmJM4qpICaJCh1vZ5oDDl59mxjOvfJKeFgXXf8F7K7+th460bsD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863076; c=relaxed/simple;
	bh=QWITNb2sEnPsh76qCAHF8CFydqgx3OgM09tGbSN1KdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJVh5gmmqqf0JH2zGUeDOFhouUb+0NAO+xQh5QtIk0uOk+TexBorcJFUTvSMa10MHlo+RCY2EA50HFRxwWSUY1uJH5cBpGVaKCzI9Oh8Y4jqTxgMlY4Owd1dWBzGCWCRGeCLUnL8AvXgBC8q8VXYwYXwcSjTyLbKYI+PwAnfMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUC4HvnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUC4HvnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A441F00898;
	Thu,  1 Oct 2026 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790863069;
	bh=If/g5eWVXEk8uWe8EjIkbefr7shLTwmjTLxNFVeJQ3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DUC4HvnXfguUTVi3ZmRucTIqbrGTKHvwYOd3Ta2LtgH3u+GgAO4VtYRW1uR9D4d0h
	 LsvgSxSqEgdy+XF0Nqj2BG1TUG6tHh37nnn+C+HXrmtBqyZJ6vfILG7PN78gwGj8UB
	 3dhmNCtHaUt44NHQZ6CBMu3d5caXM0NxXTilckvKhVfOMMiLDLLwDjFL0ArLdb4LVD
	 iHerbOm+WJZZgW93Ct7kcSe7bDpiirhZ/rm1711ne7Sujrrw89wd0L78P+cR6WbjIW
	 PNpwOeyA2aRrQWczRi2CI8FBvhFNewf0OusdGndwmh3NJzxioDyQ71OPUHTMKfwIIW
	 kcqSMF4IGN9fg==
Date: Thu, 1 Oct 2026 14:57:45 +0100
From: Simon Horman <horms@kernel.org>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: asix: remove redundant PHY address
 short-read check
Message-ID: <20261001135745.GF13925@horms.kernel.org>
References: <20260928192119.73351-1-xinsheng.zhu.ny@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928192119.73351-1-xinsheng.zhu.ny@gmail.com>

On Mon, Sep 28, 2026 at 03:21:19PM -0400, Xinsheng Zhu wrote:
> Short-read handling was added to asix_read_cmd() by commit
> 920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
> The helper converts short reads to -ENODATA while preserving negative
> errors from the underlying USB read operation.
> 
> Remove the redundant short-read check in asix_read_phy_addr()
> and its unreachable -EIO assignment. The existing negative-return check
> handles both short reads and underlying USB read errors.
> 
> Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

