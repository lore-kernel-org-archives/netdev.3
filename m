Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA522F155
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028075; cv=none; b=P8xdsgkhHPJbUWUWfR+wc4akL6Jm+ArBSTAS5OTg6d9JFggEIsNZyo2Ffopss5tNEaVvzbLm0Vp5ChhViUxv6iUbEdsCFaQwW5jS+XTxu9uXRCKJhlP5AynnP/xy7MLqbd5cF0NkdkQS+LwXPd/NoFILs3QUrYgGknIl8sNon6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028075; c=relaxed/simple;
	bh=7QVDoinyjHBts4roWW0D4UNn2wkr+axourAxesXSBdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/+JPF+62dxJ3NcMc6hxxtBN/HwFuMhAT0ZE/c1kwL+C3tkfYv7hILKkGNb5lx7Jn1/x+Hd6wcsVeoiOlBlADh0zd5zlEbsG/DJJqYGkn7YkQ7ZrTIWsP/owpwHP5QRXbXHIlMHEmCWe4wTccGF/EHQSCHjAZdUtStbPshWbh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWoo/uHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWoo/uHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05516C4CEDD;
	Mon,  7 Apr 2025 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744028075;
	bh=7QVDoinyjHBts4roWW0D4UNn2wkr+axourAxesXSBdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWoo/uHoGU2TUrIvPzjuz+/KVFWtDaMncno0P9xgOOMnwFCqVSiMZYv6jXKpv8iFh
	 ffkdzoGL6S1jBX72RdwPCqIEtc/MlJxcPJ2ktcjDkdtNWE3zUI+VX6thZZo7LvRHZR
	 zDTAx4aK0AxfAdQ7JyvQeLhliClR3x4sauuNgmPxtO92lZ9DYPc+L7YkUX4LIK2nKd
	 u1a2VhRHUnySNQrOxeX11Bq/YKzS/ofI3q0dNb9V5/naHftqUtYQL3+QOM47czZp33
	 EQ537U9jG2HyWTTjb5nBWv3BqErJnPHB9ZJ/bwxZQgV10XssFnAcnWUxJ179XXTQ37
	 dIjRmlbpZnEcA==
Date: Mon, 7 Apr 2025 13:14:31 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	victor@mojatatu.com, Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: Re: [Patch net v2 01/11] sch_htb: make htb_qlen_notify() idempotent
Message-ID: <20250407121431.GD395307@horms.kernel.org>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211033.166059-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403211033.166059-2-xiyou.wangcong@gmail.com>

On Thu, Apr 03, 2025 at 02:10:23PM -0700, Cong Wang wrote:
> htb_qlen_notify() always deactivates the HTB class and in fact could
> trigger a warning if it is already deactivated. Therefore, it is not
> idempotent and not friendly to its callers, like fq_codel_dequeue().
> 
> Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
> life.
> 
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

