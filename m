Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED13B14C6;
	Thu,  6 Aug 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980640; cv=none; b=KWZPzJC5P9NJHuAFF50IR2nzuHfxZSM+CjCjQrsNt5YPIy/270uZYivroRvHZjzt9h0Uc7qGcs/htie6pxsB+q3/cMPJoDi5X3TO9SJeFLEpQcixj/LUUQMdpdBOK0yQLJ3MLQTUTn3kPvqS1b0uQBgPnvV403D92CK+yxIJZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980640; c=relaxed/simple;
	bh=S/3TTLbCucVbTRezMURoAkvQ4hNT3GW4YTWH0WlcuJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkGcVzbOsCERhLWLYPLJCWDc1W9hPLFQOY/cn7EWGQI5yE0LfXC0iz/Jqc2P+Zr3qbIrW8jx4X5ZtUoHS0tpDIMUCKh7Bmogn4gAWGuWa/B87wVi6KS71fS+q9q7Izx7m5Dy0N57xWDHQEHaV7AEbPSLcgY65lzq4gD7rbzz8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdQUc8R1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdQUc8R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188641F000E9;
	Thu,  6 Aug 2026 01:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785980636;
	bh=VI9nZSkbOSpggo2vVq5+4IbOUUU/VPp0uPY3AtfmxBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EdQUc8R1Lh84jCCVkXLf8AmCB+TJyd63uI2mNhiUAuHFB1vuIoAhwNUNS1D2srZhn
	 LC7zOeQc7k8IpEqqXmIL1zo7xgpKUMhHI2XMWBgGuzM8u5h6bwbZPeSYDRiiSWHdrh
	 I32AGdf30DWrUMsJUNgVCndTp++4jTT8YT0eU0XxvtziMnNPPuG4QrMBd8vt4Or2dt
	 kqw6j8lGzXDy9PKN3MZukTJhXNidgRxioT7OJcDr2VEjN7p7MfSzLc5eEE69vrnBif
	 XuCqLAtCiEYRz2U6oQ+jUGc/YtxoxVti+Kv2oFGfKiKRDUrn1V5qrPDMXn8rBwWS5P
	 vj49O0ptX5kjw==
Date: Wed, 5 Aug 2026 18:43:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v23 net-next 04/12] net/nebula-matrix: add channel layer
Message-ID: <20260805184355.004797a5@kernel.org>
In-Reply-To: <20260731094242.2655-5-illusion.wang@nebula-matrix.com>
References: <20260731094242.2655-1-illusion.wang@nebula-matrix.com>
	<20260731094242.2655-5-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 17:42:27 +0800 illusion.wang wrote:
> +#define NBL_OPS_CALL(func, para)		\
> +do {						\
> +	typeof(func) _func = (func);		\
> +	if (_func)				\
> +		_func para;			\
> +} while (0)

Just spotted in the compiler warning -- this macro is definitely not
going to make it upstream. The C coding style of this driver is very
much below the upstream bar, please try to get this reviewed by someone
with upstream experience, or taste, or both.
