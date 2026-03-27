Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC02D1913;
	Fri, 27 Mar 2026 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573574; cv=none; b=IrTk9JqZ8EI4LVAmLHOog4Ig/Ub4Gnk1tUIZrLjdNNnOLwFeIo3AUF0oOHqKLSXUm4nimyP7xtt4rfpsn8SGSqv7r/iGNjp5Yx2zpk4p7zVeAQFJPGxoUpQ7kelbY+y+G+UtSt0mTGaePD0BFjsOitwZKd+XbjDyZkw8X87joOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573574; c=relaxed/simple;
	bh=CpW4Iba18ntMPY+defwSwftFxvJNSdODVY+gGWhKNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K44EMlIpP6y7fxC2TaGFTLw3pEpA79To6Bz0wXKl6cDRHCI0ekgLBpNOLYOWNglFl+xnavZ9Ah7G3jv6+c+aoRpXn3cr3xtAf4ZPBtNuNvBbKxw8AiNLPrZZNY4IoURMSyru4DoMw2fvwZZ/yKgb3h2mwc/mAkj5CQfJV6VX4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRHKQlFD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRHKQlFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA06C116C6;
	Fri, 27 Mar 2026 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774573574;
	bh=CpW4Iba18ntMPY+defwSwftFxvJNSdODVY+gGWhKNFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eRHKQlFDLW5+sXoqD0RB7xc1zs0JoStJfzEYV6RT0ZIvJd6zABeRTOMIyf6lbq16n
	 jh336UfGlRkkNGPIInOUJnlTFA5+CpdnFcV1gjzMSckPzWGYFotJm7ERTo6gPuV1NA
	 LJdyAQGTKCoEoJiZwlaLkeJisUrRdY5eTZgKpgI1Na5pZGQ9KPLFsDx7NjGimmor6W
	 IawoHcw8hZd3YOW96WeVE2ilRPuKKGTbHHZoF7wqvD0v8p++7DZpEbfeqFZjMLQ+1j
	 3Vu5LlQWUBwRp1FB9tomHMWJeBrseXttHqPlkW3gNp/Kp2TsfTrw/THrulloomxFOP
	 l+DAO+GLHvCYQ==
Date: Thu, 26 Mar 2026 18:06:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] bnxt_en: validate firmware backing store types
Message-ID: <20260326180613.7f3e0ca0@kernel.org>
In-Reply-To: <20260327003845.27877-1-pengpeng@iscas.ac.cn>
References: <20260326142033.82313-1-pengpeng@iscas.ac.cn>
	<20260327003845.27877-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 08:38:45 +0800 Pengpeng Hou wrote:
> bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
> firmware response in ctxm->type and later uses that value to index
> fixed backing-store metadata arrays such as ctx_arr[] and
> bnxt_bstore_to_trace[].

Again, please do not post in replay to previous posting.
And wait 24h before reposting. Read this:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
