Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D93A3E8C;
	Thu, 26 Mar 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553373; cv=none; b=FjKjl83RZRnwrmSsa9ZcCUbXOQ6d2vYbemoxxxeFIuuL04WaM1IlhIiCwRrE+PicFpV+lo6WrPdGTqZrz/AuAJ12waV63xIfB7kvjJNmguT5nGzsDMop7OWx500A8hDUL8Z/vmgAaajSthRl6WmPkn+CmbE1809/jMy9RTi86lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553373; c=relaxed/simple;
	bh=lQSO28sYXd8Q/b8mWBEsP49f7NhHn4D9RJdcn9c8DdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWuWqSrDwn+6ot2l+tiB22K1aLJALyZsEkcatFggVhlaDH1pQ6JyCUmiLJmPFPbT7YaYjDrpMpHD3hn3NOzOkMgHQlr2VgFrF1b4h5o7nRrqAbPm07jDgtjXL2WZN33be/4isyYO3K7mSqcg12KqHZL2Gvzvh6UNkA5uqfGJV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3I01V1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3I01V1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B25C116C6;
	Thu, 26 Mar 2026 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774553372;
	bh=lQSO28sYXd8Q/b8mWBEsP49f7NhHn4D9RJdcn9c8DdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l3I01V1DpAwrp5v/EN3CIk2uiLNUcAdRSPOxIBee2Gf6HNubRWYR52AzJGTq1vb4n
	 C6cb/ZBLVL+rjZ3ip3UHt+GPOuw2Sx9eAFf6aiW1jILT9bnH75dOHS5xI5HW/+Blau
	 9/VSdKD1cV2y+32PjaVrm+tMDcBebOqjZk3oJCmB8p3m8LmvhJVpfBejScI09+/ls8
	 ZWK/U+latACrmHZEE8XMvFInOqpdqNXEPfN6svV7RvSZ2N9ny33TLZnKA5iWCJL66v
	 5tN4Atgbeom5Jild5ktzaIKrgjY9vGv/A372vh9Deg/57DUbqplcHYDTffpkD8Oz0U
	 ZmmjzNf4CZx5Q==
Date: Thu, 26 Mar 2026 12:29:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] bnxt_en: validate firmware backing store types
Message-ID: <20260326122931.1e7e2849@kernel.org>
In-Reply-To: <20260326142033.82313-1-pengpeng@iscas.ac.cn>
References: <20260323080336.36905-1-pengpeng@iscas.ac.cn>
	<20260326142033.82313-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 22:20:33 +0800 Pengpeng Hou wrote:
> bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
> firmware response in ctxm->type and later uses that value to index
> fixed backing-store metadata arrays such as ctx_arr[] and
> bnxt_bstore_to_trace[] without a local range check.

please don't post the next version in reply to the old one.
Add a lore.kernel.org link to the previous posting in the change log
instead.
